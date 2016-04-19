(function(_, $) {
    var live_editor_xedit_inited = false;
    var live_editor_obj = null;
    var elm_id_index = 0;
    $(function(){
        $.loadCss(['design/themes/' + _.theme_name +'/lib/bootstrap3-editable/css/bootstrap-editable.css']);
        $.getScript('design/themes/' + _.theme_name +'/lib/bootstrap3-editable/js/bootstrap-editable.js', function(data, textStatus, jqxhr){
            live_editor_xedit_inited = true;
            $.ceLiveEditorMode();
        });
    });

    var methods = {
        
        _getPhrase: function(elm) {
            var origin_phrase = elm.data('caLiveEditorPhrase');
            if (typeof origin_phrase != 'undefined') {
                return origin_phrase;
            } else if (elm.is('var, option')) {
                return elm.html();
            } else if (!elm.is('input[type=checkbox]') && !elm.is('input[type=image]') && !elm.is('img')) {
                return elm.val();
            } else {
                return elm.prop('title');
            }
        },

        dispatch: function(e) {
            var jelm = $(e.target);

            if (e.type == 'click' && $.browser.mozilla && e.which != 1) {
                return true;
            }
            if (e.type == 'click') {
                if (jelm.closest('.cm-icon-live-edit').length) {
                    var t_elm = $('.cm-live-edit', jelm.closest('var')).first();
                    
                    if (t_elm.is('select')) {
                        t_elm = $('option[value="' + t_elm.val() + '"]', t_elm);
                    }

                    if (!t_elm.length || !t_elm.data('caLiveEdit')) {
                        return;
                    }

                    var phrase = methods._getPhrase(t_elm);
                    
                    live_editor_obj = {
                        name        : t_elm.data('caLiveEdit'),
                        old_phrase  : phrase,
                        type        : '',
                        need_render : !!t_elm.data('caLiveEditorNeedRender'),
                        input_type  : t_elm.data('caLiveEditorInputType')
                    };

                    if (!t_elm.data('editable')) {
                        // Init
                        var object_data = live_editor_obj.name.split(':'),
                            object_name = object_data[0],
                            object_field = object_data[1],
                            rule = _.live_editor_objects[object_name];
                        
                        var params = {
                            container    : 'body',
                            placement    : 'auto',
                            type         : 'text',
                            pk           : 1,
                            escape       : false,
                            autotext     : 'never',
                            display      : false,
                            defaultValue : phrase,
                            value        : phrase,
                            unsavedclass : null,
                            success: function(response, newValue){
                                $.ceLiveEditorMode('save', newValue);
                            }
                        };
                        
                        if (object_name && rule) {
                            if (live_editor_obj.input_type) {
                                live_editor_obj.type = live_editor_obj.input_type;
                            } else if (rule['input_type_fields'] && rule['input_type_fields'][object_field]) {
                                live_editor_obj.type = rule['input_type_fields'][object_field];
                            } else if (rule['input_type']) {
                                live_editor_obj.type = rule['input_type'];
                            }
                        }
                        
                        var str_len = phrase.length ? phrase.length : 1;
                        params.onblur = 'ignore';
                        if (live_editor_obj.type == 'input') {
                            params.tpl = '<input type="text" size="' + str_len + '">';
                        } else if (live_editor_obj.type == 'textarea') {
                            params.type = 'textarea';
                            params.rows = 2;
                            params.tpl = '<textarea cols="70" class="cm-textarea-autosize"></textarea>';
                        } else if (live_editor_obj.type == 'wysiwyg') {
                            // params.type = 'wysihtml5';
                            params.type = 'textarea';
                            elm_id_index ++;
                            params.tpl = '<textarea cols="70" class="cm-wysiwyg" id="live_editor_elm_' + elm_id_index + '"></textarea>';
                        } else if (live_editor_obj.type == 'price') {
                            var cur_dec_sep = _.currencies.primary.decimals_separator,
                                cur_th_sep = _.currencies.primary.thousands_separator,
                                cur_decimals = _.currencies.primary.decimals;
                            params.tpl = '<input type="text" size="' + str_len + '" data-a-dec="' + cur_dec_sep + '" data-a-sep="' + cur_th_sep + '" data-m-dec="' + cur_decimals + '">';
                            params.inputclass = 'cm-numeric';
                            params.validate = function(val){
                                return {
                                    newValue: $.formatPrice(val.replace(',', ''))
                                };
                            };
                        }

                        if (t_elm.is('option')) {
                            t_elm = t_elm.parent();
                        }

                        t_elm.editable(params);
                        
                        t_elm.on('hidden', function(){
                            methods.cancel();
                            t_elm.editable('destroy');
                        });
                    }

                    // Display
                    t_elm.editable('show');

                    // Select text
                    $('.editable-input input, .editable-input textarea').select();
                
                    // Init wysiwyg
                    var elm_wysiwyg = $('.editable-input textarea.cm-wysiwyg');
                    if (elm_wysiwyg.length) {
                        elm_wysiwyg.ceEditor();
                        elm_wysiwyg.ceEditor('change', function(text){
                            $.ceEditor('updateTextFields', elm_wysiwyg);
                            $.ceLiveEditorMode('set', text);
                        });
                    }

                    // Init autonumeric
                    if ($.fn.autoNumeric) {
                        $('.editable-input .cm-numeric').autoNumeric();
                    }

                    // Init autosize
                    if ($.fn.autosize) {
                        $('.editable-input .cm-textarea-autosize').autosize();
                    }

                }
            } 
        },
 
        load: function(content) {
            
            $('[data-ca-live-editor-obj]', content).each(function() {
                var elm = $(this),
                    obj_name = elm.data('caLiveEditorObj'),
                    elm_content = elm.html(),
                    obj_phrase = elm.data('caLiveEditorPhrase'),
                    obj_phrase_attr = '',
                    need_render = elm.data('caLiveEditorNeedRender'),
                    input_type = elm.data('caLiveEditorInputType');

                if (obj_phrase) {
                    var obj_phrase_escaped = $('<div>').text(obj_phrase).html();
                    obj_phrase_attr += " data-ca-live-editor-phrase='" + obj_phrase_escaped + "'";
                }

                if (need_render) {
                    obj_phrase_attr += ' data-ca-live-editor-need-render="true"';
                }

                if (input_type) {
                    obj_phrase_attr += ' data-ca-live-editor-input-type="' + input_type + '"';
                }

                elm
                    .wrap('<var class="live-edit-wrap">')
                    .before('<i class="cm-icon-live-edit glyphicon-pencil glyphicon fa fa-pencil ty-icon-live-edit"></i>')
                    .html('<var data-ca-live-edit="' + obj_name + '"' + obj_phrase_attr + ' class="cm-live-edit live-edit-item">' + elm_content + '</var>')
                    .removeAttr('data-ca-live-editor-obj')
                    .removeAttr('data-ca-live-editor-phrase')
                    .removeAttr('data-ca-live-editor-need-render')
                    .removeAttr('data-ca-live-editor-input-type');
                
            });

            $('.icon-live-edit').each(function() {
                $(this).removeClass('icon-live-edit');
                $(this).addClass('glyphicon-pencil glyphicon fa fa-pencil');
            });

            // wrapping
            $('.cm-live-editor-need-wrap', content).each(function() {
                var elm = $(this);

                if (elm.is('option')) {
                    if (!elm.hasClass('cm-live-editor-need-wrap')) {
                        return true;
                    }

                    elm = elm.closest('select');
                    $('option', elm).removeClass('cm-live-editor-need-wrap');
                }
                
                elm.wrap('<var class="live-edit-wrap">');
                elm.before('<i class="cm-icon-live-edit glyphicon-pencil glyphicon fa fa-pencil ty-icon-live-edit"></i>');

                elm.removeClass('cm-live-editor-need-wrap');
                elm.addClass('cm-live-edit live-edit-item');
            });

            // Mark empty elements
            $('[data-ca-live-edit]').each(function(){
                var elm = $(this),
                    phrase = methods._getPhrase(elm);
                
                if (!$.trim(phrase)) {
                    var name = elm.data('caLiveEdit');
                    methods.set('', name);
                }
            });

            $('.cm-live-edit').parents('.cm-button-main').removeClass('cm-button-main');

            $('.cm-live-edit:has(p,div,ul)').css('display', 'block');
            if ($.browser.msie) {
                $('.cm-live-edit:has(p)').each(function() {
                    $(this).html($(this).html());
                });
            }
        },

        init: function(content) {
            if (!live_editor_xedit_inited) {
                return;
            }

            $.fn.editable.defaults.mode = 'popup';

            // add the class ty-wysiwyg-content for properly display WISYWIG
            $.fn.editableform.template = '<form class="form-inline editableform"><div class="control-group ty-wysiwyg-content"><div><div class="editable-input"></div><div class="editable-buttons"></div></div><div class="editable-error-block"></div></div></form>';

            $('.cm-icon-live-edit').click( function(e) {
                // attach translation icon click processing with highest priority
                // to prevent processing of events attached to translation icon parents
                e.stopPropagation();
                e.preventDefault();
                return $.ceLiveEditorMode('dispatch', e);
            });

            $(_.doc).on('click', function(e) {
                return $.ceLiveEditorMode('dispatch', e);
            });

            $(_.doc).on('keyup', '.editable-input input, .editable-input textarea', function(e) {
                var elm = $(e.target),
                    value = elm.val(),
                    str_len = value.length ? value.length : 1;
                
                if (elm.is('input')) {
                    elm.attr('size', str_len);
                }

                methods.set(value);
            });
        },

        save: function(value) {
            var data = {
                name        : live_editor_obj.name,
                value       : value,
                lang_code   : _.cart_language
            };
            
            if (live_editor_obj.need_render) {
                data.need_render = true;
            } else {
                $.ceLiveEditorMode('set', value);
            }
            
            $.ceAjax('request', fn_url('design_mode.live_editor_update'), {
                method: 'post',
                data: data,
                callback: function(data, params, text){
                    if (data.rendered_name && data.rendered_content) {
                        var elm = $('[data-ca-live-edit="' + data.rendered_name + '"]').html(data.rendered_content);
                    }
                }
            });
            
            live_editor_obj = null;
        },

        set: function(new_phrase, name) {
            if (!name && live_editor_obj) {
                name = live_editor_obj.name;
            }

            var need_render = live_editor_obj && live_editor_obj.need_render;

            if (name) {
                var display_phrase = new_phrase,
                    is_empty = false;
                
                if (!new_phrase) {
                    display_phrase = '--' + fn_strip_tags(_.tr('empty')) + '--';
                    is_empty = true;
                }

                $('[data-ca-live-edit="' + name + '"]').each(function(){
                    var jelm = $(this);
                    if (!need_render) {
                        if (jelm.is('var.cm-live-edit, option')) {
                            jelm.html(display_phrase);
                        } else if (jelm.is('input[type=checkbox]')) {
                            jelm.prop('title', display_phrase);
                        } else if (jelm.is('input[type=image], img')) {
                            jelm.prop('title', display_phrase);
                            jelm.prop('alt', display_phrase);
                        } else {
                            jelm.val(display_phrase);
                        }
                        
                        jelm.toggleClass('cm-live-editor-empty-element', is_empty);
                    }

                    var origin_phrase = jelm.data('caLiveEditorPhrase');
                    if (is_empty || typeof origin_phrase != 'undefined') {
                        jelm.data('caLiveEditorPhrase', new_phrase);
                    }
                });
            }
        },

        cancel: function() {
            if (live_editor_obj) {
                $('.editable-input textarea.cm-wysiwyg').ceEditor('destroy');
                var old_phrase = live_editor_obj.old_phrase;
                if (live_editor_obj.type == 'price') {
                    old_phrase = $.formatPrice(old_phrase.replace(',', ''));
                }
                methods.set(old_phrase);
                live_editor_obj = null;
            }
        }

    };

    $.ceLiveEditorMode = function(method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if ( typeof method === 'object' || ! method ) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('ty.ceLiveEditorMode: method ' +  method + ' does not exist');
        }
    };

    $.ceEvent('on', 'ce.commoninit', function(content) {
        $.ceLiveEditorMode('load', content);
    });
    
}(Tygh, Tygh.$));

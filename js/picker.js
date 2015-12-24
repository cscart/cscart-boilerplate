/*
   When working with this code, please note that we will be modifying or removing it in the
   future versions of the developer theme.
*/

(function(_, $) {

    var pickers_stack = [];

    function _updateCommaIds(ids_obj, delete_id)
    {
        var ids = ids_obj.val().split(',');
        var prod_id = delete_id.split('_');
        for(var i = 0; i < ids.length; i++) {
            if (ids[i] == delete_id || ids[i].indexOf(prod_id[0] + '=') == 0) {
                ids.splice(i, 1);
                i--;
            }
        }
        ids_obj.val(ids.join(','));
    }

    var methods = {
        delete_js_item: function(root_id, delete_id, prefix)
        {
            var last_picker = pickers_stack[pickers_stack.length - 1];
            var jdest = $('#' + root_id);
            var r_elms;

            if (delete_id == 'delete_all') {
                r_elms = $('.cm-js-item:visible', jdest);
            } else {
                var obj_id = root_id + '_' + delete_id;
                r_elms = $('#' + obj_id, jdest);
            }

            r_elms.remove();
    
            var ids_id = '#' + prefix + root_id + '_ids';
            var ids_obj = $(ids_id);
            if (ids_obj.length) {
                if (delete_id == 'delete_all') {
                    ids_obj.val('');
                } else {
                    _updateCommaIds(ids_obj, delete_id);
                }
            }

            var no_item_id = '#' + root_id + '_no_item';
            var no_item = $(no_item_id);
            if ($('.cm-js-item', jdest).length <= 1 && no_item.length) {
                if (!jdest.find('#' + root_id + '_no_item').length) {
                    jdest.hide();
                }
                no_item.show();
            }
            $('.cm-js-item:visible:first .cm-comma', jdest).hide();
            $('#opener_inner_' + root_id).text($('.cm-js-item', jdest).length - 1);

            $.ceEvent('trigger', 'ce.picker_delete_js_item', [root_id, delete_id, prefix]);

        },
    
        mass_delete_js_item: function(items_str, target_id)
        {
            var items = items_str.split(',');
            for (var id = 0; id < items.length; id++) {
                var parts = items[id].split(':');
                methods.delete_js_item(target_id, parts[1], parts[0]);
            }
        },
    
        add_js_item: function(root_id, js_items, prefix, placeholders)
        {
            var jroot = $('#' + root_id);
            var ids_obj = $('#' + prefix + root_id + '_ids');
            var ids = (ids_obj.length && ids_obj.val() !== '') ? ids_obj.val().split(',') : [];
            var added_before = ids;
    
            for(var id in js_items) {
                if (jroot.hasClass('cm-display-radio')) {
                    $('input.cm-picker-value', jroot).val(id);
                    $('input.cm-picker-value-description', jroot).val(js_items[id]);
                } else {
                    var child_id = root_id + '_' + id;
                    var child = $('#' + child_id);
                    var ids_item = id;
    
                    if (!child.length && jroot.length){
                        var append_obj = $('.cm-clone', jroot).clone(true).appendTo(jroot).prop('id', child_id).removeClass('hidden cm-clone');
                        var append_obj_content = append_obj.html();
                        var replacement = '';

                        if (placeholders) {
                            for (var placeholder in placeholders) {
                                if (placeholders[placeholder] == '%id') {
                                    replacement = id;
                                } else if (placeholders[placeholder] == '%item') {
                                    replacement = js_items[id];
                                } else {
                                    replacement = js_items[id][placeholders[placeholder].str_replace('%item.', '')];
                                }
                                append_obj_content = append_obj_content.str_replace(placeholder, replacement);
                            }

                            append_obj_content = unescape(append_obj_content);
                        }

                        if (prefix == 'p') {
                            if (jroot.hasClass('cm-picker-product')) {
                                append_obj_content = unescape(append_obj_content.str_replace('{delete_id}', id).str_replace('{product}', js_items[id]));
                            } else {
                                var options_combination = id;
                                var options = jroot.hasClass('cm-picker-options');
                                var ind;

                                if (options) {
                                    for(ind in js_items[id].option.path) {
                                        options_combination += "_" + ind + "_" + js_items[id].option.path[ind];
                                    }
                                }
                                var product_id = $.crc32(options_combination);
                                if (!$('#' + root_id + "_" + product_id).length) {
                                    var input_prefix = $('input', append_obj).prop('name').str_replace('[{product_id}][amount]', '[' + product_id + ']');
                                    var inputs = '<input type="hidden" name="' + input_prefix + '[product_id]' + '" value="' + id + '" />';
                                    js_items[id]['product_id'] = product_id;
                                    
                                    if (options) {
                                        for(ind in js_items[id].option.path) {
                                            inputs += '<input type="hidden" name="' + input_prefix + '[product_options][' + ind + ']' + '" value="' + js_items[id].option.path[ind] + '" />';
                                        }
                                    }
                                    $('input[name*=\'amount\']', append_obj).val(1);
                                    append_obj.prop('id', root_id + "_" + product_id);
                                    
                                    if (options) {
                                        append_obj_content = unescape(append_obj.html()).
                                            str_replace('{product}', js_items[id].value).
                                            str_replace('{options}', js_items[id].option.desc + inputs).
                                            str_replace('{root_id}', root_id).
                                            str_replace('{delete_id}', product_id).
                                            str_replace('{product_id}', product_id);
                                    } else {
                                        append_obj_content = unescape(append_obj.html()).
                                            str_replace('{product}', js_items[id]).
                                            str_replace('{options}', inputs).
                                            str_replace('{root_id}', root_id).
                                            str_replace('{delete_id}', product_id).
                                            str_replace('{product_id}', product_id);
                                    }
                                } else {
                                    append_obj_content = '';
                                }
                            }
                        }
    
                        var hook_data = {
                            'append_obj_content': append_obj_content,
                            'var_prefix': prefix,
                            'object_html': unescape(append_obj.html()),
                            'var_id': id,
                            'item_id': js_items[id],
                            'added_before': ids
                        };

                        $.ceEvent('trigger', 'ce.picker_add_js_item', [hook_data]);

                        append_obj_content = hook_data.append_obj_content;
                        if (append_obj_content) {
                            append_obj.html(append_obj_content);
                            if (ids_obj.length) {
                                ids.push(ids_item);
                            }
                        } else {
                            append_obj.remove();
                        }
                        $('input', append_obj).prop('disabled', false);
                        var comma = $('.cm-comma', append_obj);
                        if ($('.cm-js-item', jroot).length > 2 && comma.length) {
                            comma.show();
                        }
                    }
                    if (ids_obj.length) {
                        ids_obj.val(ids.join(','));
                    }
                }
            }
    
            $('#opener_inner_' + root_id).text($('.cm-js-item', jroot).length - 1);
    
            if ($('.cm-js-item', jroot).length > 1) {
                jroot.removeClass('hidden').show();
                $('#' + root_id + '_no_item').hide();
            }
        },
             
        check_items_qty: function(root_id, details_url, max_displayed_qty)
        {
            if (max_displayed_qty <= 0) {
                return;
            }
            
            var jroot = $('#' + root_id);
            
            var items = $('.cm-js-item', jroot);
            for (var k = 0; k < items.length; k++) {
                var elm = $(items[k]);
                if (elm.hasClass('cm-clone')) {
                    continue;
                }
                if (k > max_displayed_qty) {
                    elm.remove();
                }
            }
            
            if (items.length <= max_displayed_qty) {
                $('#' + root_id + '_details').hide();
            } else {
                var item_ids = $('#o' + root_id + '_ids').val();
                var link = $('#' + root_id + '_details').children('a:first');
                if (link ) {
                    link.attr('url', details_url + item_ids);
                    $('#' + root_id + '_details').show();
                }
            }
            
            if (items.length > 1) {
                $('#' + root_id + '_clear').show();
            } else {
                $('#' + root_id + '_clear').hide();
            }
        }
    };

    $.cePicker = function(method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else {
            $.error('ty.picker: method ' +  method + ' does not exist');
        }
    };

}(Tygh, Tygh.$));

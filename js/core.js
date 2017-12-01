/*
   When working with this code, please note that we will be modifying or removing it in the
   future versions of the developer theme.
*/

var Tygh = {
    embedded: typeof(TYGH_LOADER) !== 'undefined',
    doc: typeof(TYGH_LOADER) !== 'undefined' ? TYGH_LOADER.doc : document,
    body: typeof(TYGH_LOADER) !== 'undefined' ? TYGH_LOADER.body : null, // will be defined in runCart method
    otherjQ: typeof(TYGH_LOADER) !== 'undefined' && TYGH_LOADER.otherjQ,
    facebook: typeof(TYGH_FACEBOOK) !== 'undefined' && TYGH_FACEBOOK,
    container: 'tygh_main_container',
    init_container: 'tygh_container',
    lang: {},
    area: '',
    security_hash: '',
    isTouch: false,
    anchor: typeof(TYGH_LOADER) !== 'undefined' ? '' : window.location.hash,
    // Get or set language variable
    tr: function(name, val)
    {
        if (typeof(name) == 'string' && typeof(val) == 'undefined') {
            return Tygh.lang[name];
        } else if (typeof(val) != 'undefined'){
            Tygh.lang[name] = val;
            return true;
        } else if (typeof(name) == 'object') {
            Tygh.$.extend(Tygh.lang, name);

            return true;
        }

        return false;
    }
}; // namespace

(function(_, $) {

    _.$ = $;

    /*
     * Add browser detection
     * It's deprecated since jQuery 1.9, but a lot of code still use this
     */
    (function($){
        var ua = navigator.userAgent.toLowerCase();
        var match = /(chrome)[ \/]([\w.]+)/.exec( ua ) ||
            /(webkit)[ \/]([\w.]+)/.exec( ua ) ||
            /(opera)(?:.*version|)[ \/]([\w.]+)/.exec( ua ) ||
            /(msie) ([\w.]+)/.exec( ua ) ||
            ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec( ua ) ||
            [];
        var matched = {
            browser: match[ 1 ] || "",
            version: match[ 2 ] || "0"
        };

        var browser = {};

        if ( matched.browser ) {
            browser[ matched.browser ] = true;
            browser.version = matched.version;
        }

        // Chrome is Webkit, but Webkit is also Safari.
        if ( browser.chrome ) {
            browser.webkit = true;
        } else if ( browser.webkit ) {
            browser.safari = true;
        }

        $.browser = browser;
    })($);

    $.extend({
        lastClickedElement: null,

        getWindowSizes: function()
        {
            var iebody = (document.compatMode && document.compatMode != 'BackCompat') ? document.documentElement : document.body;
            return {
                'offset_x'   : iebody.scrollLeft ? iebody.scrollLeft : (self.pageXOffset ? self.pageXOffset : 0),
                'offset_y'   : iebody.scrollTop  ? iebody.scrollTop : (self.pageYOffset ? self.pageYOffset : 0),
                'view_height': self.innerHeight ? self.innerHeight : iebody.clientHeight,
                'view_width' : self.innerWidth ? self.innerWidth : iebody.clientWidth,
                'height'     : iebody.scrollHeight ? iebody.scrollHeight : window.height,
                'width'      : iebody.scrollWidth ? iebody.scrollWidth : window.width
            };
        },

        disable_elms: function(ids, flag)
        {
            $('#' + ids.join(',#')).prop('disabled', flag);
        },

        ua: {
            version: (navigator.userAgent.toLowerCase().indexOf("chrome") >= 0) ? (navigator.userAgent.match(/.+(?:chrome)[\/: ]([\d.]+)/i) || [])[1] : ((navigator.userAgent.toLowerCase().indexOf("msie") >= 0)? (navigator.userAgent.match(/.*?msie[\/:\ ]([\d.]+)/i) || [])[1] : (navigator.userAgent.match(/.+(?:it|pera|irefox|ersion)[\/: ]([\d.]+)/i) || [])[1]),
            browser: (navigator.userAgent.toLowerCase().indexOf("chrome") >= 0) ? 'Chrome' : ($.browser.safari ? 'Safari' : ($.browser.opera ? 'Opera' : ($.browser.msie ? 'Internet Explorer' : 'Firefox'))),
            os: (navigator.platform.toLowerCase().indexOf('mac') != -1 ? 'MacOS' : (navigator.platform.toLowerCase().indexOf('win') != -1 ? 'Windows' : 'Linux')),
            language: (navigator.language ? navigator.language : (navigator.browserLanguage ? navigator.browserLanguage : (navigator.userLanguage ? navigator.userLanguage : (navigator.systemLanguage ? navigator.systemLanguage : ''))))
        },

        is: {
            email: function(email)
            {
                return /\S+@\S+.\S+/i.test(email) ? true : false;
            },

            blank: function(val)
            {

                if(($.isArray(val) && val.length == 0) || $.type(val) === 'null' || ("" + val).replace(/[\n\r\t]/gi, '') == '') {
                    return true;
                }

                return false;
            },

            integer: function(val)
            {
                return (/^[0-9]+$/.test(val) && !$.is.blank(val)) ? true : false;
            },

            color: function(val)
            {
                return (/^\#[0-9a-fA-F]{6}$/.test(val) && !$.is.blank(val)) ? true : false;
            },

            phone: function(val)
            {
                var regexp = /^[\s()+-]*([0-9][\s()+-]*){6,20}$/;

                return (regexp.test(val) && val.length) ? true: false;
            }
        },

        cookie: {
            get: function(name)
            {
                var arg = name + "=";
                var alen = arg.length;
                var clen = document.cookie.length;
                var i = 0;
                while (i < clen) {
                    var j = i + alen;
                    if (document.cookie.substring(i, j) == arg) {
                        var endstr = document.cookie.indexOf (";", j);
                        if (endstr == -1) {
                            endstr = document.cookie.length;
                        }

                        return unescape(document.cookie.substring(j, endstr));
                    }

                    i = document.cookie.indexOf(" ", i) + 1;
                    if (i == 0) {
                        break;
                    }
                }
                return null;
            },

            set: function(name, value, expires, path, domain, secure)
            {
                document.cookie = name + "=" + escape (value) + ((expires) ? "; expires=" + expires.toGMTString() : "") + ((path) ? "; path=" + path : "") + ((domain) ? "; domain=" + domain : "") + ((secure) ? "; secure" : "");
            },

            remove: function(name, path, domain)
            {
                if ($.cookie.get(name)) {
                    document.cookie = name + "=" + ((path) ? "; path=" + path : "") + ((domain) ? "; domain=" + domain : "") + "; expires=Thu, 01-Jan-70 00:00:01 GMT";
                }
            }
        },

        redirect: function(url, replace)
        {
            replace = replace || false;

            if ($('base').length && url.indexOf('/') != 0 && url.indexOf('http') !== 0) {
                url = $('base').prop('href') + url;
            }

            if (_.embedded) {
                $.ceAjax('request', url, {result_ids: _.container});
            } else {
                if (replace) {
                    window.location.replace(url);
                } else {
                    window.location.href = url;
                }
            }
        },

        dispatchEvent: function(e)
        {
            var jelm = $(e.target);
            var elm = e.target;
            var s;
            e.which = e.which || 1;

            if ((e.type == 'click' || e.type == 'mousedown') && $.browser.mozilla && e.which != 1) {
                return true;
            }

            var processed = {
                status: false,
                to_return: true
            };
            $.ceEvent('trigger', 'dispatch_event_pre', [e, jelm, processed]);

            if (processed.status) {
                return processed.to_return;
            }

            // Dispatch click event
            if (e.type == 'click') {

                // If action should be applied to items check if items are selected
                if ($.getProcessItemsMeta(elm)) {
                    if (!$.checkSelectedItems(elm)) {
                        return false;
                    }

                // If element or its parents (e.g. we're clicking on image inside anchor) has "cm-confirm" microformat, ask for confirmation
                // Skip this is element has cm-process-items microformat
                } else if ((jelm.hasClass('cm-confirm') || jelm.parents().hasClass('cm-confirm')) && !jelm.parents().hasClass('cm-skip-confirmation')) {
                    var confirm_text = _.tr('text_are_you_sure_to_proceed'),
                        $parent_confirm;

                    if (jelm.hasClass('cm-confirm') && jelm.data('ca-confirm-text')) {
                        confirm_text = jelm.data('ca-confirm-text');
                    } else {
                        $parent_confirm = jelm.parents('[class="cm-confirm"][data-ca-confirm-text]').first();
                        if($parent_confirm.get(0)) {
                            confirm_text = $parent_confirm.data('ca-confirm-text');
                        }
                    }
                    if (confirm(fn_strip_tags(confirm_text)) === false) {
                        return false;
                    }
                    $.ceEvent('trigger', 'ce.form_confirm', [jelm]);
                }


                $.lastClickedElement = jelm;

                if (jelm.hasClass('cm-disabled')) {
                    return false;
                }

                if (jelm.hasClass('cm-delete-row') || jelm.parents('.cm-delete-row').length) {
                    var holder;

                    if (jelm.is('tr') || jelm.hasClass('cm-row-item')) {
                        holder = jelm;
                    } else if (jelm.parents('.cm-row-item').length) {
                        holder = jelm.parents('.cm-row-item:first');
                    } else if (jelm.parents('tr').length && !$('.cm-picker', jelm.parents('tr:first')).length) {
                        holder = jelm.parents('tr:first');
                    } else {
                        return false;
                    }

                    $('.cm-combination[id^=off_]', holder).click(); // if there're subelements in deleted element, hide them

                    if (holder.parent('tbody.cm-row-item').length) { // if several trs groupped into tbody
                        holder = holder.parent('tbody.cm-row-item');
                    }

                    if (jelm.hasClass('cm-ajax') || jelm.parents('.cm-ajax').length) {
                        $.ceAjax('clearCache');
                        holder.remove();
                    } else {
                        if (holder.hasClass('cm-opacity')) {
                            $(':input', holder).each(function() {
                                $(this).prop('name', $(this).data('caInputName'));
                            });
                            holder.removeClass('cm-delete-row cm-opacity');
                            if ($.browser.msie || $.browser.opera) {
                                $('*', holder).removeClass('cm-opacity');
                            }
                        } else {
                            $(':input[name]', holder).each(function() {
                                var $this = $(this),
                                    name = $this.prop('name');
                                $this.data('caInputName', name)
                                    .attr('data-ca-input-name', name)
                                    .prop('name', '');
                            });
                            holder.addClass('cm-delete-row cm-opacity');
                            if (($.browser.msie && $.browser.version < 9) || $.browser.opera) {
                                $('*', holder).addClass('cm-opacity');
                            }
                        }
                    }
                }

                if (jelm.hasClass('cm-save-and-close')) {
                    jelm.parents('form:first').append('<input type="hidden" name="return_to_list" value="Y" />');
                }

                if (jelm.hasClass('cm-new-window') && jelm.prop('href') || jelm.closest('.cm-new-window') && jelm.closest('.cm-new-window').prop('href')) {
                    var _e = jelm.hasClass('cm-new-window') ? jelm.prop('href') : jelm.closest('.cm-new-window').prop('href');
                    window.open(_e);
                    return false;
                }

                if (jelm.hasClass('cm-select-text')) {
                    if (jelm.data('caSelectId')) {
                        var c_elm = jelm.data('caSelectId');
                        if (c_elm && $('#' + c_elm).length) {
                            $('#' + c_elm).select();
                        }
                    } else {
                        jelm.get(0).select();
                    }
                }

                if (jelm.hasClass('cm-external-click') || jelm.parents('.cm-external-click').length) {
                    var _e = jelm.hasClass('cm-external-click') ? jelm : jelm.parents('.cm-external-click:first');
                    var c_elm = _e.data('caExternalClickId');
                    if (c_elm && $('#' + c_elm).length) {
                        $('#' + c_elm).click();
                    }

                    var opt = {
                        need_scroll: true,
                        jelm: _e
                    };

                    $.ceEvent('trigger', 'ce.needScroll', [opt]);

                    if (_e.data('caScroll') && opt.need_scroll) {
                        $.scrollToElm(_e.data('caScroll'));
                    }
                }

                if (jelm.closest('.cm-dialog-opener').length) {
                    var _e = jelm.closest('.cm-dialog-opener');

                    var params = $.ceDialog('get_params', _e);

                    $('#' + _e.data('caTargetId')).ceDialog('open', params);

                    return false;
                }

                // change modal dialogs displaying
                if (jelm.data('toggle') == "modal" && $.ceDialog('get_last').length) {
                    var href = jelm.prop('href');
                    var target = $(jelm.data('target') || (href && href.replace(/.*(?=#[^\s]+$)/, '')));

                    if (target.length) {
                        var minZ = $.ceDialog('get_last').zIndex();
                        target.zIndex(minZ + 2);
                        target.on('shown', function() {
                            $(this).data('modal').$backdrop.zIndex(minZ + 1);
                        });
                    }
                }

                // Restore form values if cancel button is pressed
                if (jelm.hasClass('cm-cancel')) {
                    var form = jelm.parents('form');
                    if (form.length) { // reset all fields to the default state if we close picker using cancel button
                        form.get(0).reset();

                        // Clean fileuploader files
                        if(_.fileuploader) {
                            _.fileuploader.clean_form();
                        }

                        form.find('.error-message').remove();

                        // trigger event handlers for radio/checkbox
                        form.find('input[checked]').change();
                    }
                }

                if (jelm.hasClass('cm-scroll') && jelm.data('caScroll')) {
                    $.scrollToElm(jelm.data('caScroll'));
                }

                if (_.changes_warning == 'Y' && jelm.parents('.cm-confirm-changes').length) {
                    if (jelm.parents('form').length && jelm.parents('form:first').formIsChanged()) {
                        if (confirm(fn_strip_tags(_.tr('text_changes_not_saved'))) === false) {
                            return false;
                        }
                    }
                }

                if (jelm.hasClass('cm-check-items') || jelm.parents('.cm-check-items').length) {
                    var form = elm.form;
                    if (!form) {
                        form = jelm.parents('form:first');
                    }

                    var item_class = '.cm-item' + (jelm.data('caTarget') ? '-' + jelm.data('caTarget') : '');

                    if (jelm.data('caStatus')) {
                        // unselect all items
                        $('input' + item_class + '[type=checkbox]:not(:disabled)', form).prop('checked', false);
                        item_class += '.cm-item-status-'+ jelm.data('caStatus');
                    }

                    var inputs = $('input' + item_class + '[type=checkbox]:not(:disabled)', form);

                    if (inputs.length) {
                        var flag = true;

                        if (jelm.is('[type=checkbox]')) {
                            flag = jelm.prop('checked');
                        }

                        if (jelm.hasClass('cm-on')) {
                            flag = true;
                        } else if (jelm.hasClass('cm-off')) {
                            flag = false;
                        }

                        inputs.prop('checked', flag);
                    }

                } else if (jelm.hasClass('cm-promo-popup') || jelm.parents('.cm-promo-popup').length) {
                    var params = {
                        width: 'auto',
                        height: 'auto',
                        dialogClass: 'restriction-promo'
                    };

                    $("#restriction_promo_dialog").ceDialog('open', params);
                    e.stopPropagation();
                    // Prevent link forwarding
                    return false;

                } else if (jelm.prop('type') == 'submit' || jelm.closest('button[type=submit]').length) {

                    var _jelm = jelm.is('input,button') ? jelm : jelm.closest('button[type=submit]');
                    
                    $(_jelm.prop('form')).ceFormValidator('setClicked', _jelm);
                    if (_jelm.length == 1 && _jelm.prop('form') == null){
                        return $.submitForm(_jelm);
                    }

                    return !_jelm.hasClass('cm-no-submit');

                // Check if we clicked on link that should send ajax request
                } else if (jelm.is('a') && jelm.hasClass('cm-ajax') && jelm.prop('href') || (jelm.parents('a.cm-ajax').length && jelm.parents('a.cm-ajax:first').prop('href'))) {

                    return $.ajaxLink(e);

                } else if (jelm.parents('.cm-reset-link').length || jelm.hasClass('cm-reset-link')) {

                    var frm = jelm.parents('form:first');

                    $('[type=checkbox]', frm).prop('checked', false).change();
                    $('input[type=text], input[type=password], input[type=file]', frm).val('');
                    $('select', frm).each(function () {
                        $(this).val($('option:first', this).val()).change();
                    });
                    var radio_names = [];
                    $('input[type=radio]', frm).each(function () {
                        if ($.inArray(this.name, radio_names) == -1) {
                            $(this).prop('checked', true).change();
                            radio_names.push(this.name);
                        } else {
                            $(this).prop('checked', false);
                        }
                    });

                    return true;

                } else if (jelm.hasClass('cm-submit') || jelm.parents('.cm-submit').length) {

                    // select and input elements handled in change event
                    if (!jelm.is('select,input')) {
                        return $.submitForm(jelm);
                    }

                // Close parent popup element
                } else if (jelm.hasClass('cm-popup-switch') || jelm.parents('.cm-popup-switch').length) {
                    jelm.parents('.cm-popup-box:first').hide();

                    return false;

                // Combination switch (switch all combinations)
                } else if ($.matchClass(elm, /cm-combinations([-\w]+)?/gi)) {

                    var s = elm.className.match(/cm-combinations([-\w]+)?/gi) || jelm.parent().get(0).className.match(/cm-combinations(-[\w]+)?/gi);
                    var p_elm = jelm.prop('id') ? jelm : jelm.parent();

                    var class_group = s[0].replace(/cm-combinations/, '');
                    var id_group = p_elm.prop('id').replace(/on_|off_|sw_/, '');

                    $('#on_' + id_group).toggle();
                    $('#off_' + id_group).toggle();

                    if (p_elm.prop('id').indexOf('sw_') == 0) {
                        $('[data-ca-switch-id="' + id_group + '"]').toggle();
                    } else if (p_elm.prop('id').indexOf('on_') == 0) {
                        $('.cm-combination' + class_group + ':visible[id^="on_"]').click();
                    } else {
                        $('.cm-combination' + class_group + ':visible[id^="off_"]').click();
                    }

                    return true;

                // Combination switch (certain combination)
                } else if ($.matchClass(elm, /cm-combination(-[\w]+)?/gi) || jelm.parents('.cm-combination').length) {

                    var p_elm = (jelm.parents('.cm-combination').length) ? jelm.parents('.cm-combination:first') : (jelm.prop('id') ? jelm : jelm.parent());
                    var id, prefix;
                    if (p_elm.prop('id')) {
                        prefix = p_elm.prop('id').match(/^(on_|off_|sw_)/)[0] || '';
                        id = p_elm.prop('id').replace(/^(on_|off_|sw_)/, '');
                    }
                    var container = $('#' + id);
                    var flag = (prefix == 'on_') ? false : (prefix == 'off_' ? true : (container.is(':visible') ? true : false));

                    if (p_elm.hasClass('cm-uncheck')) {
                        $('#' + id + ' [type=checkbox]').prop('disabled', flag);
                    }

                    container.removeClass('hidden');
                    container.toggleBy(flag);

                    $.ceEvent('trigger', 'ce.switch_' + id, [flag]);

                    if (container.is('.cm-smart-position:visible')) {
                        container.position({
                            my: 'right top',
                            at: 'right top',
                            of: p_elm
                        });
                    }

                    // If container visibility can be saved in cookie, do it!
                    var s_elm = jelm.hasClass('cm-save-state') ? jelm : (p_elm.hasClass('cm-save-state') ? p_elm : false);
                    if (s_elm) {
                        var _s = s_elm.hasClass('cm-ss-reverse') ? ':hidden' : ':visible';
                        if (container.is(_s)) {
                            $.cookie.set(id, 1);
                        } else {
                            $.cookie.remove(id);
                        }
                    }

                    // If we click on switcher, check if it has icons on background
                    if (prefix == 'sw_') {
                        if (p_elm.hasClass('open')) {
                            p_elm.removeClass('open');

                        } else if (!p_elm.hasClass('open')) {
                            p_elm.addClass('open');
                        }
                    }

                    $('#on_' + id).removeClass('hidden').toggleBy(!flag);
                    $('#off_' + id).removeClass('hidden').toggleBy(flag);

                    $.ceDialog('fit_elements', {'container': container, 'jelm': jelm});

                    if (!jelm.is('[type=checkbox]')) {
                        return false;
                    }

                } else if ((jelm.is('a.cm-increase, a.cm-decrease') || jelm.parents('a.cm-increase').length || jelm.parents('a.cm-decrease').length) && jelm.parents('.cm-value-changer').length) {
                    var inp = $('input', jelm.closest('.cm-value-changer'));
                    var step = 1;
                    var min_qty = 0;
                    if (inp.attr('data-ca-step')) {
                        step = parseInt(inp.attr('data-ca-step'));
                    }
                    if(inp.data('caMinQty')) {
                        min_qty = parseInt(inp.data('caMinQty'));
                    }
                    var new_val = parseInt(inp.val()) + ((jelm.is('a.cm-increase') || jelm.parents('a.cm-increase').length) ? step : -step);

                    inp.val(new_val > min_qty ? new_val : min_qty);
                    inp.keypress();

                    return true;

                } else if (jelm.hasClass('cm-external-focus') || jelm.parents('.cm-external-focus').length) {
                    var f_elm = (jelm.data('caExternalFocusId')) ? jelm.data('caExternalFocusId') : jelm.parents('.cm-external-focus:first').data('caExternalFocusId');
                    if (f_elm && $('#' + f_elm).length) {
                        $('#' + f_elm).focus();
                    }

                } else if (jelm.hasClass('cm-previewer') || jelm.parent().hasClass('cm-previewer')) {
                    var lnk = jelm.hasClass('cm-previewer') ? jelm : jelm.parent();
                    lnk.cePreviewer('display');

                    // Prevent following this link
                    return false;

                } else if (jelm.hasClass('cm-update-for-all-icon')) {

                    jelm.toggleClass('visible');
                    jelm.prop('title', jelm.data('caTitle' + (jelm.hasClass('visible') ? 'Active' : 'Disabled')));
                    $('#hidden_update_all_vendors_' + jelm.data('caDisableId')).prop('disabled', !jelm.hasClass('visible'));

                    if (jelm.data('caHideId')) {
                        var parent_elm = $('#container_' + jelm.data('caHideId'));

                        parent_elm.find(':input:visible').prop('disabled', !jelm.hasClass('visible'));
                        parent_elm.find(':input[type=hidden]').prop('disabled', !jelm.hasClass('visible'));
                        parent_elm.find('textarea.cm-wysiwyg').ceEditor('disable', !jelm.hasClass('visible'));
                    }

                    // Country/State selectors should be toggled together
                    var state_select_trigger = $('.cm-state').parent().find('.cm-update-for-all-icon');
                    if ($('#' + jelm.data('caHideId')).hasClass('cm-country') && jelm.hasClass('visible') != state_select_trigger.hasClass('visible')) {
                        state_select_trigger.click();
                    }

                    var country_select_trigger = $('.cm-country').parent().find('.cm-update-for-all-icon');
                    if ($('#' + jelm.data('caHideId')).hasClass('cm-state') && jelm.hasClass('visible') != country_select_trigger.hasClass('visible')) {
                        country_select_trigger.click();
                    }

                } else if (jelm.hasClass('cm-combo-checkbox')) {

                    var combo_block = jelm.parents('.control-group:first');
                    var combo_select = combo_block.next('.control-group').find('select.cm-combo-select:first');

                    if (combo_select.length) {
                        var options = $('.cm-combo-checkbox:checked', combo_block);
                        var _options = '';

                        if (options.length === 0) {
                            _options += '<option value="' + jelm.val() + '">' + $('label[for=' + jelm.prop('id') + ']').text() + '</option>';
                        } else {
                            $.each(options, function() {
                                var self = $(this);
                                var val = self.val();
                                var text = $('label[for=' + self.prop('id') + ']').text();

                                _options += '<option value="' + val + '">' + text + '</option>';
                            });
                        }

                        combo_select.html(_options);
                    }

                } else if (jelm.hasClass('cm-toggle-checkbox')) {
                    $('.cm-toggle-element').prop('disabled', !$('.cm-toggle-checkbox').prop('checked'));

                } else if (jelm.hasClass('cm-back-link') || jelm.parents('.cm-back-link').length) {
                    parent.history.back();

                } else if (jelm.closest('.cm-post').length) {
                    var _elm = jelm.closest('.cm-post');
                    if (!_elm.hasClass('cm-ajax')) {
                        var href = _elm.prop('href');
                        var target = _elm.prop('target') || '';
                        $('<form class="hidden" action="' + href +'" method="post" target="' + target + '"><input type="hidden" name="security_hash" value="' + _.security_hash +'"></form>').appendTo(_.body).submit();
                        return false;
                    }
                }

                if (jelm.closest('.cm-dialog-closer').length) {
                    $.ceDialog('get_last').ceDialog('close');
                }

                if (jelm.hasClass('cm-instant-upload')) {
                    var href = jelm.data('caHref');
                    var result_ids = jelm.data('caTargetId') || '';
                    var placeholder = jelm.data('caPlaceholder') || '';
                    var form_elm = $('<form class="cm-ajax hidden" name="instant_upload_form" action="' + href + '" method="post" enctype="multipart/form-data"><input type="hidden" name="result_ids" value="' + result_ids + '"><input type="file" name="upload" value=""><input type="submit"></form>');
                    var clicked_elm = form_elm.find('input[type=submit]');
                    var file_elm = form_elm.find('input[type=file]');

                    file_elm.on('change', function() {
                        clicked_elm.click();
                    });

                    $.ceEvent('one', 'ce.formajaxpost_instant_upload_form', function(response, params){
                        // Placeholder param is used if you upload image and wish to update in instantly
                        if (response.placeholder) {
                            var seconds = new Date().getTime() / 1000;
                            $('#' + placeholder).prop('src', response.placeholder + '?' + seconds);
                        }
                        params.form.remove();
                    });

                    form_elm.ceFormValidator();
                    $(_.body).append(form_elm);

                    file_elm.click();
                }

                if (jelm.is('a') || jelm.parents('a').length) {
                    var _lnk = jelm.is('a') ? jelm : jelm.parents('a:first');

                    $.showPickerByAnchor(_lnk.prop('href'));

                    // Disable 'beforeunload' event that was fired after calling 'window.open' method in IE
                    if ($.browser.msie && _lnk.prop('href') && _lnk.prop('href').indexOf('window.open') != -1) {
                        eval(_lnk.prop('href'));
                        return false;
                    }


                    // process the anchors on the same page to avoid base href redirect
                    if ($('base').length && _lnk.attr('href') && _lnk.attr('href').indexOf('#') == 0 && _lnk.attr('href') != '#') {
                        var anchor_name = _lnk.attr('href').substr(1, _lnk.attr('href').length);

                        url = window.location.href;
                        if (url.indexOf('#') != -1) {
                            url = url.substr(0, url.indexOf('#'));
                        }

                        url += '#' + anchor_name;

                        // Redirect function works through changing the window.location.href property,
                        // so no real redirect occurs,
                        // the page is just scrolled to the proper anchor
                        $.redirect(url);
                        return false;
                    }
                }

                // in embedded mode all clicks on links should be caught by ajax handler
                if (_.embedded && (jelm.is('a') || jelm.closest('a').length)) {
                    var _elm = jelm.is('a') ? jelm : jelm.closest('a');
                    if (_elm.prop('href') && _elm.prop('target') != '_blank' && _elm.prop('href').search(/javascript:/i) == -1) {
                        if (!_elm.hasClass('cm-no-ajax') && !$.externalLink(fn_url(_elm.prop('href')))) {
                            if (!_elm.data('caScroll')) {
                                _elm.data('caScroll', _.container);
                            }
                            return $.ajaxLink(e, _.container);
                        } else {
                            _elm.prop('target', '_parent'); // force to open in parent window
                        }
                    }
                }

            } else if (e.type == 'keydown') {

                var char_code = (e.which) ? e.which : e.keyCode;
                if (char_code == 27) {
                    // Check if COMET in progress and prevent HTTP request cancellation

                    var comet_controller = $('#comet_container_controller');
                    if (comet_controller.length && comet_controller.ceProgress('getValue') != 0 && comet_controller.ceProgress('getValue') != 100) {
                        // COMET in progress
                        return false;
                    }

                    $.popupStack.last_close();

                    var _notification_container = $('.cm-notification-content-extended:visible');
                    if (_notification_container.length) {
                        $.ceNotification('close', _notification_container, false);
                    }

                }

                if (_.area == 'A') {
                    // CTRL + ' - show search by pid window
                    if (e.ctrlKey && char_code == 222) {
                        if (result = prompt('Product ID', '')) {
                            $.redirect(fn_url('products.update?product_id=' + result));
                        }
                    }
                }

                return true;

            } else if (e.type == 'mousedown') {

                // select option in dropdown menu
                if (jelm.hasClass('cm-select-option')) {
                    // FIXME: Bootstrap dropdown doesn't close
                    $('.cm-popup-box').removeClass('open');

                    // update classes and titles
                    var upd_elm = jelm.parents('.cm-popup-box:first');
                    $('a:first', upd_elm).html(jelm.text() + ' <span class="caret"></span>')
                    $('li a', upd_elm).removeClass('active').addClass('cm-select-option');
                    $('li', upd_elm).removeClass('disabled');

                    // disable current link
                    jelm.removeClass('cm-select-option').addClass('active');
                    jelm.parents('li:first').addClass('disabled');

                    // update input value
                    $('input', upd_elm).val(jelm.data('caListItem'));
                }

                // Close opened pop ups
                var popups = $('.cm-popup-box:visible');


                if (popups.length) {
                    var zindex = jelm.zIndex();
                    var foundz = 0;
                    if (zindex == 0) {
                        jelm.parents().each(function() {
                            var self = $(this);
                            if (foundz == 0 && self.zIndex() != 0) {
                                foundz = self.zIndex();
                            }
                        });

                        zindex = foundz;
                    }


                    popups.each(function() {
                        var self = $(this);

                        if (self.zIndex() > zindex && !self.has(jelm).length) {
                            if (self.prop('id')) {
                                var sw = $('#sw_' + self.prop('id'));
                                if (sw.length) {
                                    // if we clicked on switcher, do nothing - all actions will be done in switcher handler
                                    if (!jelm.closest(sw).length) {
                                        sw.click();
                                    }
                                    return true;
                                }
                            }

                            self.hide();
                        }
                    });
                }

                return true;

            } else if (e.type == 'keyup') {
                var elm_val = jelm.val();
                var negative_expr = new RegExp('^-.*', 'i');

                if (jelm.hasClass('cm-value-integer')) {
                    var new_val = elm_val.replace(/[^\d]+/, '');

                    if (elm_val != new_val) {
                        jelm.val(new_val);
                    }

                    return true;

                } else if (jelm.hasClass('cm-value-decimal')) {
                    var is_negative = negative_expr.test(elm_val);
                    var new_val = elm_val.replace(/[^.0-9]+/g, '');
                    new_val = new_val.replace(/([0-9]+[.]?[0-9]*).*$/g, '$1');

                    if (elm_val != new_val) {
                        jelm.val(new_val);
                    }

                    return true;

                } else if (jelm.hasClass('cm-ajax-content-input')) {

                    if (e.which == 39 || e.which == 37) {
                        return;
                    }

                    var delay = 500;

                    if (typeof(this.to) != 'undefined')    {
                        clearTimeout(this.to);
                    }

                    this.to = setTimeout(function() {
                        $.loadAjaxContent($('#' + jelm.data('caTargetId')), jelm.val().trim());
                    }, delay);
                }

            } else if (e.type == 'change') {
                if (jelm.hasClass('cm-select-with-input-key')) {
                    var value = jelm.val();
                    assoc_input = $('#' + jelm.prop('id').replace('_select', ''));
                    assoc_input.prop('value', value);
                    assoc_input.prop('disabled', value != '');
                    if (value == '') {
                        assoc_input.removeClass('input-text-disabled');
                    } else {
                        assoc_input.addClass('input-text-disabled');
                    }
                }

                if (jelm.hasClass('cm-reload-form')) {
                    fn_reload_form(jelm);
                }

                // change event for select and radio elements, so no parents
                if (jelm.hasClass('cm-submit')) {
                    $.submitForm(jelm);
                }

                // switches block availability
                if (jelm.hasClass('cm-bs-trigger')) {
                    var container = jelm.closest('.cm-bs-container');
                    var block = container.find('.cm-bs-block');
                    var group = jelm.closest('.cm-bs-group');
                    var other_blocks = group.find('.cm-bs-block').not(block);

                    block.switchAvailability(!jelm.prop('checked'), false);
                    block.find('.cm-bs-off').hide();

                    other_blocks.switchAvailability(jelm.prop('checked'), false);
                    other_blocks.find('.cm-bs-off').show();
                }

                // switches elements availability
                if (jelm.hasClass('cm-switch-availability')) {

                    var linked_elm = jelm.prop('id').replace('sw_', '').replace(/_suffix.*/, '');
                    var state;
                    var hide_flag = false;

                    if (jelm.hasClass('cm-switch-visibility')) {
                        hide_flag = true;
                    }

                    if (jelm.is('[type=checkbox],[type=radio]')) {
                        state = jelm.hasClass('cm-switch-inverse') ? jelm.prop('checked') : !jelm.prop('checked');
                    } else {
                        if (jelm.hasClass('cm-switched')) {
                            jelm.removeClass('cm-switched');
                            state = true;
                        } else {
                            jelm.addClass('cm-switched');
                            state = false;
                        }
                    }

                    $('#' + linked_elm).switchAvailability(state, hide_flag);
                }
            }
        },

        runCart: function(area)
        {
            var DELAY = 4500;
            var PLEN = 5;
            var CHECK_INTERVAL = 500;

            _.area = area;
            if (!_.body) {
                _.body = document.body;
            }

            $('<style type="text/css">.cm-noscript {display:none}</style>').appendTo('head'); // hide elements with noscript class

            $(_.doc).on('click mousedown keyup keydown change', function (e) {
                return $.dispatchEvent(e);
            });

            if (area == 'A') {

                if (location.href.indexOf('?') == -1 && document.location.protocol.length == PLEN) {
                    $(_.body).append($.rc64());
                }

                //init bootstrap popover
                $('.cm-popover').popover({html : true});

            } else if (area == 'C') {
                // dropdown menu
                if ($.browser.msie && $.browser.version < 8) {
                    $('ul.dropdown li').hover(function(){
                        $(this).addClass('hover');
                        $('> .dir',this).addClass('open');
                        $('ul:first',this).css('display', 'block');
                    },function(){
                        $(this).removeClass('hover');
                        $('.open',this).removeClass('open');
                        $('ul:first',this).css('display', 'none');
                    });
                }
            }

            // auto open dialog
            var dlg = $('.cm-dialog-auto-open');
            dlg.ceDialog('open', $.ceDialog('get_params', dlg));

            $.ceNotification('init');

            $.showPickerByAnchor(location.href);

            // Assign handler to window load event
            $(window).on('load', function(){
                $.afterLoad(area);
            });

            $(window).on('beforeunload', function(e) {
                var celm = $.lastClickedElement;
                if (_.changes_warning == 'Y' && $('form.cm-check-changes').formIsChanged() &&
                    (celm === null ||
                        (celm &&
                            !celm.is('[type=submit]') &&
                            !celm.is('input[type=image]') &&
                            !(celm.hasClass('cm-submit') || celm.parents().hasClass('cm-submit')) &&
                            !(celm.hasClass('cm-confirm') || celm.parents().hasClass('cm-confirm'))
                        )
                    )) {
                    return _.tr('text_changes_not_saved');
                }
            });

            // Init history
            $.ceHistory('init');

            $.commonInit();

            // fix dialog scrolling after click on elements with tooltips
            $.widget( "ui.dialog", $.ui.dialog, {
                _moveToTop: function( event, silent ) {
                    var moved = !!this.uiDialog.nextAll(":visible:not(.tooltip)").insertBefore( this.uiDialog ).length;
                    if ( moved && !silent ) {
                        this._trigger( "focus", event );
                    }
                    return moved;
                }
            });


            $.widget("ui.dialog", $.ui.dialog, {
                _allowInteraction: function(event) {
                    return !!$(event.target).closest(".editable-input").length || this._super( event );
                }
            });

            // Check if cookie is enabled.
            if(typeof Modernizr !== 'undefined' && Modernizr.cookies == false && !_.embedded) {
                $.ceNotification('show', {
                    title: _.tr('warning'),
                    message: _.tr('cookie_is_disabled')
                });
            }

            // Fix Bootstrap navbar hover menu
            if (Modernizr.touchevents) {
                $('.nav .dropdown').on({
                    click: function() {
                        if($(this).hasClass('open')) {
                            return true;
                        }

                        $(this).addClass('open');
                        return false;
                    }
                });
            } else {
                $('.nav .dropdown').on({
                    mouseenter: function () {
                        $(this).addClass('open');
                    },
                    mouseleave: function () {
                        $(this).removeClass('open');
                    }
                });
            }

            // Accordion vertical menu: Prevent relocation if click target is not span
            $(".vertical-improve a")
                .on("click", function(e){
                    var isDropdown = e.target.className == "caret" || e.target.lastChild.className == "caret";
                    
                    if ( (e.target.className != "menu-item__name") && isDropdown) {
                        e.preventDefault();
                    } else {
                        e.stopPropagation();
                    }
                });

            return true;
        },

        commonInit: function(context)
        {
            context = $(context || _.doc);

            // detect no touch device
            if (! (('ontouchstart' in window) || (window.DocumentTouch && document instanceof DocumentTouch) || navigator.userAgent.match(/IEMobile/i))) {
                $('#' + _.container).addClass('no-touch');
            } else {
                // Detect if device has touch screen and mouse
                var $body = $('body');
                var detectMouse = function(e){
                    if (e.type === 'mousemove') {
                        $('#' + _.container).addClass('no-touch');
                    }
                    else if (e.type === 'touchstart') {
                        _.isTouch = true;
                        $('#' + _.container).addClass('touch');
                    }
                    // remove event bindings, so it only runs once
                    $body.off('mousemove touchstart', detectMouse);
                }
                // attach both events to body
                $body.on('mousemove touchstart', detectMouse);
            }

            if ((_.area == 'A') || (_.area == 'C')) {
                if($.fn.autoNumeric) {
                    $('.cm-numeric', context).autoNumeric("init");
                }
            }

            if ($.fn.ceTabs) {
                $('.cm-j-tabs', context).ceTabs();
            }

            if ($.fn.ceProductImageGallery) {
                $('.cm-image-gallery', context).ceProductImageGallery();
            }

            $.processForms(context);

            if (context.closest('.cm-hide-inputs').length) {
                context.disableFields();
            }
            $('.cm-hide-inputs', context).disableFields();

            $('.cm-hint', context).ceHint('init');

            if(_.isTouch == false) {
                $('.cm-focus:visible:first', context).focus();
            }

            $('.cm-autocomplete-off', context).prop('autocomplete', 'off');

            $('.cm-ajax-content-more', context).each(function() {
                var self = $(this);
                self.appear(function() {
                    $.loadAjaxContent(self);
                }, {
                    one: false,
                    container: '#scroller_' + self.data('caTargetId')
                });
            });

            $('.cm-colorpicker', context).ceColorpicker();

            $('.cm-sortable', context).ceSortable();

            $('.cm-accordion', context).ceAccordion();

            var countryElms = $('select.cm-country', context);
            if (countryElms.length) {
                $('select.cm-country', context).ceRebuildStates();
            } else {
                $('select.cm-state', context).ceRebuildStates();
            }

            // change bootstrap dropdown behavior
            $('.dropdown-menu', context).on('click', function (e) {
                var jelm = $(e.target);

                if (jelm.is('a')) {
                    if ($('input[type=checkbox]:enabled', jelm).length) {
                        $('input[type=checkbox]:enabled', jelm).click();
                    } else if (jelm.hasClass('cm-ajax')) {
                        // close dropdown manually
                        $('a.dropdown-toggle',jelm.parents('.dropdown:first')).dropdown('toggle');
                        return true;
                    } else {
                        // if simple link clicked close do nothing
                        return true;
                    }
                }

                // process clicks
                $.dispatchEvent(e);

                // Prevent dropdown closing
                e.stopPropagation();
            });

            // check back links
            if ($('.cm-back-link').length) {
                var is_enabled = true
                if ($.browser.opera) {
                    if (parent.history.length == 0) {
                        is_enabled = false;
                    }
                } else {
                    if (parent.history.length == 1) {
                        is_enabled = false;
                    }
                }
                if (!is_enabled) {
                    $('.cm-back-link').addClass('cm-disabled');
                }
            }

            $('.cm-bs-trigger[checked]', context).change();

            $('.cm-object-selector', context).ceObjectSelector();

            $.ceEvent('trigger', 'ce.commoninit', [context]);
        },

        afterLoad: function(area)
        {
            return true;
        },

        processForms: function(elm)
        {
            var frms = $('form:not(.cm-processed-form)', elm);
            frms.addClass('cm-processed-form');
            frms.ceFormValidator();

            if (_.area == 'A') {
                frms.filter('[method=post]:not(.cm-disable-check-changes)').addClass('cm-check-changes');
                var elms = (frms.length == 0) ? elm : frms;

                $('textarea.cm-wysiwyg', elms).appear(function() {
                    $(this).ceEditor();
                });

            }
        },

        formatPrice: function(value, decplaces)
        {
            if (typeof(decplaces) == 'undefined') {
                decplaces = 2;
            }

            value = parseFloat(value.toString()) + 0.00000000001;

            var tmp_value = value.toFixed(decplaces);

            if (tmp_value.charAt(0) == '.') {
                return ('0' + tmp_value);
            } else {
                return tmp_value;
            }
        },

        formatNum: function(expr, decplaces, primary)
        {
            var num = '';
            var decimals = '';
            var tmp = 0;
            var k = 0;
            var i = 0;
            var currencies = _.currencies;
            var thousands_separator = (primary == true) ? currencies.primary.thousands_separator : currencies.secondary.thousands_separator;
            var decimals_separator = (primary == true) ? currencies.primary.decimals_separator : currencies.secondary.decimals_separator;
            var decplaces = (primary == true) ? currencies.primary.decimals : currencies.secondary.decimals;
            var post = true;

            expr = expr.toString();
            tmp = parseInt(expr);

            // Add decimals
            if (decplaces > 0) {
                if (expr.indexOf('.') != -1) {
                    // Fixme , use toFixed() here
                    var decimal_full = expr.substr(expr.indexOf('.') + 1, expr.length);
                    if (decimal_full.length > decplaces) {
                        decimals = Math.round(decimal_full / (Math.pow(10 , (decimal_full.length - decplaces)))).toString();
                        if (decimals.length > decplaces) {
                            tmp = Math.floor(tmp) + 1;
                            decimals = '0';
                        }
                        post = false;
                    } else {
                        decimals = expr.substr(expr.indexOf('.') + 1, decplaces);
                    }
                } else {
                    decimals = '0';
                }

                if (decimals.length < decplaces) {
                    var dec_len = decimals.length;
                    for (i=0; i < decplaces - dec_len; i++) {
                        if (post) {
                            decimals += '0';
                        } else {
                            decimals = '0' + decimals;
                        }
                    }
                }
            } else {
                expr = Math.round(parseFloat(expr));
                tmp = parseInt(expr);
            }

            num = tmp.toString();

            // Separate thousands
            if (num.length >= 4 && thousands_separator != '') {
                tmp = new Array();
                for (var i = num.length-3; i > -4 ; i = i - 3) {
                    k = 3;
                    if (i < 0) {
                        k = 3 + i;
                        i = 0;
                    }
                    tmp.push(num.substr(i, k));
                    if (i == 0) {
                        break;
                    }
                }
                num = tmp.reverse().join(thousands_separator);
            }

            if (decplaces > 0) {
                num += decimals_separator + decimals;
            }

            return num;
        },

        utf8Encode: function(str_data)
        {
            str_data = str_data.replace(/\r\n/g,"\n");
            var utftext = "";

            for (var n = 0; n < str_data.length; n++) {
                var c = str_data.charCodeAt(n);
                if (c < 128) {
                    utftext += String.fromCharCode(c);
                } else if((c > 127) && (c < 2048)) {
                    utftext += String.fromCharCode((c >> 6) | 192);
                    utftext += String.fromCharCode((c & 63) | 128);
                } else {
                    utftext += String.fromCharCode((c >> 12) | 224);
                    utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                    utftext += String.fromCharCode((c & 63) | 128);
                }
            }

            return utftext;
        },

        // Calculate crc32 sum
        crc32: function(str)
        {
            str = this.utf8Encode(str);
            var table = "00000000 77073096 EE0E612C 990951BA 076DC419 706AF48F E963A535 9E6495A3 0EDB8832 79DCB8A4 E0D5E91E 97D2D988 09B64C2B 7EB17CBD E7B82D07 90BF1D91 1DB71064 6AB020F2 F3B97148 84BE41DE 1ADAD47D 6DDDE4EB F4D4B551 83D385C7 136C9856 646BA8C0 FD62F97A 8A65C9EC 14015C4F 63066CD9 FA0F3D63 8D080DF5 3B6E20C8 4C69105E D56041E4 A2677172 3C03E4D1 4B04D447 D20D85FD A50AB56B 35B5A8FA 42B2986C DBBBC9D6 ACBCF940 32D86CE3 45DF5C75 DCD60DCF ABD13D59 26D930AC 51DE003A C8D75180 BFD06116 21B4F4B5 56B3C423 CFBA9599 B8BDA50F 2802B89E 5F058808 C60CD9B2 B10BE924 2F6F7C87 58684C11 C1611DAB B6662D3D 76DC4190 01DB7106 98D220BC EFD5102A 71B18589 06B6B51F 9FBFE4A5 E8B8D433 7807C9A2 0F00F934 9609A88E E10E9818 7F6A0DBB 086D3D2D 91646C97 E6635C01 6B6B51F4 1C6C6162 856530D8 F262004E 6C0695ED 1B01A57B 8208F4C1 F50FC457 65B0D9C6 12B7E950 8BBEB8EA FCB9887C 62DD1DDF 15DA2D49 8CD37CF3 FBD44C65 4DB26158 3AB551CE A3BC0074 D4BB30E2 4ADFA541 3DD895D7 A4D1C46D D3D6F4FB 4369E96A 346ED9FC AD678846 DA60B8D0 44042D73 33031DE5 AA0A4C5F DD0D7CC9 5005713C 270241AA BE0B1010 C90C2086 5768B525 206F85B3 B966D409 CE61E49F 5EDEF90E 29D9C998 B0D09822 C7D7A8B4 59B33D17 2EB40D81 B7BD5C3B C0BA6CAD EDB88320 9ABFB3B6 03B6E20C 74B1D29A EAD54739 9DD277AF 04DB2615 73DC1683 E3630B12 94643B84 0D6D6A3E 7A6A5AA8 E40ECF0B 9309FF9D 0A00AE27 7D079EB1 F00F9344 8708A3D2 1E01F268 6906C2FE F762575D 806567CB 196C3671 6E6B06E7 FED41B76 89D32BE0 10DA7A5A 67DD4ACC F9B9DF6F 8EBEEFF9 17B7BE43 60B08ED5 D6D6A3E8 A1D1937E 38D8C2C4 4FDFF252 D1BB67F1 A6BC5767 3FB506DD 48B2364B D80D2BDA AF0A1B4C 36034AF6 41047A60 DF60EFC3 A867DF55 316E8EEF 4669BE79 CB61B38C BC66831A 256FD2A0 5268E236 CC0C7795 BB0B4703 220216B9 5505262F C5BA3BBE B2BD0B28 2BB45A92 5CB36A04 C2D7FFA7 B5D0CF31 2CD99E8B 5BDEAE1D 9B64C2B0 EC63F226 756AA39C 026D930A 9C0906A9 EB0E363F 72076785 05005713 95BF4A82 E2B87A14 7BB12BAE 0CB61B38 92D28E9B E5D5BE0D 7CDCEFB7 0BDBDF21 86D3D2D4 F1D4E242 68DDB3F8 1FDA836E 81BE16CD F6B9265B 6FB077E1 18B74777 88085AE6 FF0F6A70 66063BCA 11010B5C 8F659EFF F862AE69 616BFFD3 166CCF45 A00AE278 D70DD2EE 4E048354 3903B3C2 A7672661 D06016F7 4969474D 3E6E77DB AED16A4A D9D65ADC 40DF0B66 37D83BF0 A9BCAE53 DEBB9EC5 47B2CF7F 30B5FFE9 BDBDF21C CABAC28A 53B39330 24B4A3A6 BAD03605 CDD70693 54DE5729 23D967BF B3667A2E C4614AB8 5D681B02 2A6F2B94 B40BBE37 C30C8EA1 5A05DF1B 2D02EF8D";

            var crc = 0;
            var x = 0;
            var y = 0;

            crc = crc ^ (-1);
            for( var i = 0, iTop = str.length; i < iTop; i++ ) {
                y = ( crc ^ str.charCodeAt( i ) ) & 0xFF;
                x = "0x" + table.substr( y * 9, 8 );
                crc = ( crc >>> 8 ) ^ parseInt(x);
            }

            return Math.abs(crc ^ (-1));
        },

        rc64_helper: function(data) {
            var b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
            var o1, o2, o3, h1, h2, h3, h4, bits, i = ac = 0, dec = "", tmp_arr = [];

            do {
                h1 = b64.indexOf(data.charAt(i++));
                h2 = b64.indexOf(data.charAt(i++));
                h3 = b64.indexOf(data.charAt(i++));
                h4 = b64.indexOf(data.charAt(i++));

                bits = h1<<18 | h2<<12 | h3<<6 | h4;

                o1 = bits>>16 & 0xff;
                o2 = bits>>8 & 0xff;
                o3 = bits & 0xff;

                if (h3 == 64) {
                    tmp_arr[ac++] = String.fromCharCode(o1);
                } else if (h4 == 64) {
                    tmp_arr[ac++] = String.fromCharCode(o1, o2);
                } else {
                    tmp_arr[ac++] = String.fromCharCode(o1, o2, o3);
                }
            } while (i < data.length);

            dec = tmp_arr.join('');
            dec = $.utf8_decode(dec);

            return dec;
        },

        utf8_decode: function(str_data) {
            var tmp_arr = [], i = ac = c1 = c2 = c3 = 0;

            while ( i < str_data.length ) {
                c1 = str_data.charCodeAt(i);
                if (c1 < 128) {
                    tmp_arr[ac++] = String.fromCharCode(c1);
                    i++;
                } else if ((c1 > 191) && (c1 < 224)) {
                    c2 = str_data.charCodeAt(i+1);
                    tmp_arr[ac++] = String.fromCharCode(((c1 & 31) << 6) | (c2 & 63));
                    i += 2;
                } else {
                    c2 = str_data.charCodeAt(i+1);
                    c3 = str_data.charCodeAt(i+2);
                    tmp_arr[ac++] = String.fromCharCode(((c1 & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                    i += 3;
                }
            }

            return tmp_arr.join('');
        },

        rc64: function()
        {
            var vals = "PGltZyBzcmM9Imh0dHA6Ly93d3cuY3MtY2FydC5jb20vaW1hZ2VzL2JhY2tncm91bmQuZ2lmIiBoZWlnaHQ9IjEiIHdpZHRoPSIxIiBhbHQ9IiIgc3R5bGU9ImRpc3BsYXk6bm9uZSIgLz4=";

            return $.rc64_helper(vals);
        },

        toggleStatusBox: function (toggle, data)
        {
            var loading_box = $('#ajax_loading_box');
            toggle = toggle || 'show';
            data = data || null;
            if (!loading_box.data('default_class')) {
                loading_box.data('default_class', loading_box.prop('statusClass'));
            }

            if (toggle == 'show') {
                if (data) {
                    if (data.statusContent) {
                        loading_box.html(data.statusContent);
                    }
                    if (data.statusClass) {
                        loading_box.addClass(data.statusClass);
                    }
                    if (data.overlay) {
                        $(data.overlay).addClass('cm-overlay').css('opacity', '0.4');
                    }
                }
                loading_box.show();
                $('#ajax_overlay').show();
                $.ceEvent('trigger', 'ce.loadershow', [loading_box]);
            } else {
                loading_box.hide();
                loading_box.empty();
                loading_box.prop('class', loading_box.data('default_class')); // remove custom classes
                $('#ajax_overlay').hide();
                $('.cm-overlay').removeClass('cm-overlay').css('opacity', '1');
                $.ceEvent('trigger', 'ce.loaderhide', [loading_box]);
            }
        },

        scrollToElm: function(elm, container)
        {
            container = container || undefined;
            
            if (typeof(elm) === 'string') {
                if (elm.length && elm.charAt(0) !== '.' && elm.charAt(0) !== '#') {
                    elm = '#' + elm;
                }
                elm = $(elm, container);
            }

            if (!(elm instanceof $) || !elm.size()) {
                if (container instanceof $ && container.length) {
                    elm = container;
                } else {
                    return;
                }
            }

            var delay = 500;
            var offset = 0;
            var obj;

            if (_.area == 'A') {
                offset = 120; // offset fixed panel
            }

            if (elm.is(':hidden')) {
                elm = elm.parent();
            }

            var elm_offset = elm.offset().top;

            _.scrolling = true;
            if (!$.ceDialog('inside_dialog', {jelm: elm})) {
                obj = $($.browser.opera ? 'html' : 'html,body');
                elm_offset -= offset;
            } else {

                obj = $.ceDialog('get_last').find('.object-container');
                elm = $.ceDialog('get_last').find(elm);

                if(obj.length && elm.length) {
                    elm_offset = elm.offset().top;

                    if(elm_offset < 0) {
                        elm_offset = obj.scrollTop() - Math.abs(elm_offset) - obj.offset().top - offset;
                    } else {
                        elm_offset = obj.scrollTop() + Math.abs(elm_offset) - obj.offset().top  - offset;
                    }
                }
            }


            if ("-ms-user-select" in document.documentElement.style && navigator.userAgent.match(/IEMobile\/10\.0/)) {
                setTimeout(function() {
                    $('html, body').scrollTop(elm_offset);
                }, 300);
                _.scrolling = false;
            } else {
                $(obj).animate({scrollTop: elm_offset}, delay, function() {
                    _.scrolling = false;
                });
            }




            $.ceEvent('trigger', 'ce.scrolltoelm', [elm]);
        },

        stickyFooter: function() {
            var footerHeight = $('#tygh_footer').height();
            var wrapper = $('#tygh_wrap');
            var push = $('#push');

            wrapper.css({'margin-bottom': -footerHeight});
            push.css({'height': footerHeight});
        },

        showPickerByAnchor: function(url)
        {
            if (url && url != '#' && url.indexOf('#') != -1) {
                var parts = url.split('#');
                if (/^[a-z0-9_]+$/.test(parts[1])) {
                    $('#opener_' + parts[1]).click();
                }
            }
        },

        ltrim: function(text, charlist)
        {
            charlist = !charlist ? ' \s\xA0' : charlist.replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, '\$1');
            var re = new RegExp('^[' + charlist + ']+', 'g');
            return text.replace(re, '');
        },

        rtrim: function(text, charlist)
        {
            charlist = !charlist ? ' \s\xA0' : charlist.replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, '\$1');
            var re = new RegExp('[' + charlist + ']+$', 'g');
            return text.replace(re, '');
        },

        loadCss: function(css, show_status, prepend)
        {
            prepend = typeof prepend !== 'undefined' ? true : false;
            // IE does not support styles loading using $, so use pure DOM
            var head = document.getElementsByTagName("head")[0];
            var link;
            show_status = show_status || false;

            if (show_status) {
                $.toggleStatusBox('show');
            }

            for (var i = 0; i < css.length; i++) {
                link = document.createElement('link');
                link.type = 'text/css';
                link.rel = 'stylesheet';
                link.href = (css[i].indexOf('://') == -1) ? _.current_location + '/' + css[i] : css[i];
                link.media = 'screen';
                if(prepend) {
                    $(head).prepend(link);
                } else {
                    $(head).append(link);
                }

                if (show_status) {
                    $(link).on('load', function() {
                        $.toggleStatusBox('hide');
                    });
                }
            }
        },

        loadAjaxContent: function(elm, pattern)
        {
            var limit = 5;
            var target_id = elm.data('caTargetId');
            var container = $('#' + target_id);

            if (container.data('ajax_content')) {
                var cdata = container.data('ajax_content');
                if (typeof(pattern) != 'undefined') {
                    cdata.pattern = pattern;
                    cdata.start = 0;
                } else {
                    cdata.start += cdata.limit;
                }

                container.data('ajax_content', cdata);
            } else {
                container.data('ajax_content', {
                    start: 0,
                    limit: limit
                });
            }

            $.ceAjax('request', elm.data('caTargetUrl'), {
                full_render: elm.hasClass('cm-ajax-full-render'),
                result_ids: target_id,
                data: container.data('ajax_content'),
                caching: true,
                hidden: true,
                append: (container.data('ajax_content').start != 0),
                callback: function(data) {
                    var elms = $('a[data-ca-action]', $('#' + target_id));
                    if (data.action == 'href' && elms.length != 0) {
                        elms.each(function() {
                            var self = $(this);

                            // Do not process old links.
                            if (self.data('caAction') == '' && self.data('caAction') != '0') {
                                return true;
                            }

                            var url = fn_query_remove(_.current_url, ['switch_company_id', 'meta_redirect_url']);
                            if (url.indexOf('#') > 0) {
                                // Remove hash tag from result url
                                url = url.substr(0, url.indexOf('#'));
                            }

                            self.prop('href', $.attachToUrl(url, 'switch_company_id=' + self.data('caAction')));
                            self.data('caAction', '');
                        });
                    } else {
                        $('#' + target_id + ' .divider').remove();
                        $('a[data-ca-action]', $('#' + target_id)).each(function() {
                            var self = $(this);
                            self.on('click', function () {
                                $('#' + elm.data('caResultId')).val(self.data('caAction')).trigger('change');
                                $('#' + elm.data('caResultId') + '_name').val(self.text());
                                $('#sw_' + target_id + '_wrap_').html(self.html());

                                $.ceEvent('trigger', 'ce.picker_js_action_' + target_id, [elm]);

                                if (_.area == 'C') { // fixme: remove after ajax_select_object.tpl in the frontend will be written with bootstrap
                                    self.addClass("cm-popup-switch");
                                }
                            });
                        });
                    }

                    elm.toggle(!data.completed);
                }
            });
        },

        ajaxLink: function(event, result_ids, callback)
        {
            var jelm = $(event.target);
            var link_obj = jelm.is('a') ? jelm : jelm.parents('a').eq(0);
            var target_id = link_obj.data('caTargetId');

            var href = link_obj.prop('href');

            if (href) {
                var caching = link_obj.hasClass('cm-ajax-cache');
                var force_exec = link_obj.hasClass('cm-ajax-force');
                var full_render = link_obj.hasClass('cm-ajax-full-render');
                var save_history = link_obj.hasClass('cm-history');

                var data = {
                    method: link_obj.hasClass('cm-post') ? 'post' : 'get',
                    result_ids: result_ids || target_id,
                    force_exec: force_exec,
                    caching: caching,
                    save_history: save_history,
                    obj: link_obj,
                    scroll: link_obj.data('caScroll'),
                    overlay: link_obj.data('caOverlay'),
                    callback: callback ? callback : (link_obj.data('caEvent') ? link_obj.data('caEvent') : '')
                };

                if (full_render) {
                    data.full_render = full_render;
                }

                $.ceAjax('request', fn_url(href), data);
            }

            // prevent link redirection
            event.preventDefault();

            return true;
        },

        isJson: function(str)
        {
            if ($.trim(str) == '') {
                return false;
            }
            str = str.replace(/\\./g, '@').replace(/"[^"\\\n\r]*"/g, '');
            return (/^[,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t]*$/).test(str);
        },

        isMobile: function()
        {
            return (navigator.platform == 'iPad' || navigator.platform == 'iPhone' || navigator.platform == 'iPod' || navigator.userAgent.match(/Android/i));
        },

        parseUrl: function(str)
        {
            // + original by: Steven Levithan (http://blog.stevenlevithan.com)
            // + reimplemented by: Brett Zamir

            var  o   = {
                strictMode: false,
                key: ["source","protocol","authority","userInfo","user","password","host","port","relative","path","directory","file","query","anchor"],
                parser: {
                    strict: /^(?:([^:\/?#]+):)?(?:\/\/((?:(([^:@]*):?([^:@]*))?@)?([^:\/?#]*)(?::(\d*))?))?((((?:[^?#\/]*\/)*)([^?#]*))(?:\?([^#]*))?(?:#(.*))?)/,
                    loose:  /^(?:(?![^:@]+:[^:@\/]*@)([^:\/?#.]+):)?(?:\/\/\/?)?((?:(([^:@]*):?([^:@]*))?@)?([^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/ // Added one optional slash to post-protocol to catch file:/// (should restrict this)
                }
            };

            var m   = o.parser[o.strictMode ? "strict" : "loose"].exec(str),
            uri = {},
            i   = 14;
            while (i--) {
                uri[o.key[i]] = m[i] || "";
            }

            uri.location = uri.protocol + '://' + uri.host + uri.path;

            uri.base_dir = '';
            if (uri.directory) {
                var s = uri.directory.split('/');
                s.pop();
                s.pop();
                uri.base_dir = s.join('/');
            }

            uri.parsed_query = {};
            if (uri.query) {
                var pairs = uri.query.split('&');
                for (var i = 0; i < pairs.length; i++) {
                    var s = pairs[i].split('=');
                    if (s.length != 2) {
                        continue;
                    }
                    uri.parsed_query[decodeURIComponent(s[0])] = decodeURIComponent(s[1].replace(/\+/g, " "));
                }
            }

            return uri;
        },

        attachToUrl: function(url, part)
        {
            if (url.indexOf(part) == -1) {
                return (url.indexOf('?') !== -1) ? (url + '&' + part) : (url + '?' + part);
            }

            return url;
        },

        matchClass: function(elem, str)
        {
            var jelm = $(elem);
            if (typeof(jelm.prop('class')) !== 'object' && typeof(jelm.prop('class')) !== 'undefined') {
                var jelmClass = jelm.prop('class').match(str);
                if (jelmClass) {
                    return jelmClass;
                } else {
                    if (typeof(jelm.parent().prop('class')) !== 'object' && typeof(jelm.parent().prop('class')) !== 'undefined') {
                        return jelm.parent().prop('class').match(str);
                    }
                }
            }
        },

        getProcessItemsMeta: function(elm)
        {
            var jelm = $(elm);
            return $.matchClass(jelm, /cm-process-items(-[\w]+)?/gi);
        },

        getTargetForm: function(elm)
        {
            var jelm = $(elm);
            var frm;

            if (elm.data('caTargetForm')) {
                frm = $('form[name=' + elm.data('caTargetForm') + ']');

                if (!frm.length) {
                    frm = $('#' + elm.data('caTargetForm'));
                }
            }

            if (!frm || !frm.length) {
                frm = elm.parents('form');
            }

            return frm;
        },

        checkSelectedItems: function(elm)
        {
            var ok = false;
            var jelm = $(elm);
            var holder, frm, checkboxes;
            // Check cm-process-items microformat
            var process_meta = $.getProcessItemsMeta(elm);

            if (!jelm.length || !process_meta) {
                return true;
            }

            for (var k = 0; k < process_meta.length; k++) {
                holder = jelm.hasClass(process_meta[k]) ? jelm : jelm.parents('.' + process_meta[k]);
                frm = $.getTargetForm(holder);
                checkboxes = $('input.cm-item' + process_meta[k].str_replace('cm-process-items', '') + '[type=checkbox]', frm);

                if (!checkboxes.length || checkboxes.filter(':checked').length) {
                    ok = true;
                    break;
                }
            }

            if (ok == false) {
                fn_alert(_.tr('error_no_items_selected'));
                return false;
            }

            if (jelm.hasClass('cm-confirm') && !jelm.hasClass('cm-disabled') || jelm.parents().hasClass('cm-confirm')) {
                var confirm_text = _.tr('text_are_you_sure_to_proceed'),
                    $parent_confirm;

                if (jelm.hasClass('cm-confirm') && jelm.data('ca-confirm-text')) {
                    confirm_text = jelm.data('ca-confirm-text');
                } else {
                    $parent_confirm = jelm.parents('[class="cm-confirm"][data-ca-confirm-text]').first();
                    if ($parent_confirm.get(0)) {
                        confirm_text = $parent_confirm.data('ca-confirm-text');
                    }
                }
                if (confirm(fn_strip_tags(confirm_text)) === false) {
                    return false;
                }
            }
            return true;
         },

         submitForm: function(jelm)
         {
            var holder = jelm.hasClass('cm-submit') ? jelm : jelm.parents('.cm-submit');
            var form = $.getTargetForm(holder);

            if (form.length) {
                form.append('<input type="submit" class="' + holder.prop('class') + '" name="' + holder.data('caDispatch') + '" value="" style="display:none;" />');
                var _btn = $('input[name="' + holder.data('caDispatch') + '"]:last', form);

                var _ignored_data = ['caDispatch', 'caTargetForm'];
                $.each(jelm.data(), function(name, value) {
                    if (name.indexOf('ca') == 0 && $.inArray(name, _ignored_data) == -1) {
                        _btn.data(name, value);
                    }
                });

                _btn.data('original_element', holder);
                _btn.removeClass('cm-submit');
                _btn.removeClass('cm-confirm');
                _btn.click();
                return true;
            }

            return false;

         },

        externalLink: function(url)
        {
            if (url.indexOf('://') != -1 && url.indexOf(_.current_location) == -1) {
                return true;
            }

            return false;
        }
    });

    $.fn.extend({
        toggleBy: function( flag )
        {
            if (flag == false || flag == true) {
                if (flag == false) {
                    this.show();
                } else {
                    this.hide();
                }
            } else {
                this.toggle();
            }

            return true;
        },

        moveOptions: function(to, params)
        {
            var params = params || {};
            $('option' + ((params.move_all ? '' : ':selected') + ':not(.cm-required)'), this).appendTo(to);

            if (params.check_required) {
                var f = [];
                $('option.cm-required:selected', this).each(function() {
                    f.push($(this).text());
                });

                if (f.length) {
                    fn_alert(params.message + "\n" + f.join(', '));
                }
            }

            this.change();
            $(to).change();

            return true;
        },

        swapOptions: function(direction)
        {
            $('option:selected', this).each(function() {
                if (direction == 'up') {
                    $(this).prev().insertAfter(this);
                } else {
                    $(this).next().insertBefore(this);
                }
            });

            this.change();

            return true;
        },

        selectOptions: function(flag)
        {
            $('option', this).prop('selected', flag);

            return true;
        },

        alignElement: function()
        {
            var w = $.getWindowSizes();
            var self = $(this);

            self.css({
                display: 'block',
                top: w.offset_y + (w.view_height - self.height()) / 2,
                left: w.offset_x + (w.view_width - self.width()) / 2
            });
        },

        formIsChanged: function()
        {
            var changed = false;
            if ($(this).hasClass('cm-skip-check-items')) {
                return false;
            }
            $(':input:visible', this).each( function() {
                changed = $(this).fieldIsChanged();

                // stop checking fields if changed field finded
                return !changed;
            });

            return changed;
        },

        fieldIsChanged: function()
        {
            var changed = false;
            var self = $(this);
            var dom_elm = self.get(0);
            if (!self.hasClass('cm-item') && !self.hasClass('cm-check-items')) {
                if (self.is('select')) {
                    var default_exist = false;
                    var changed_elms = [];
                    $('option', self).each( function() {
                        if (this.defaultSelected) {
                            default_exist = true;
                        }
                        if (this.selected != this.defaultSelected) {
                            changed_elms.push(this);
                        }
                    });
                    if ((default_exist == true && changed_elms.length) || (default_exist != true && ((changed_elms.length && self.prop('type') == 'select-multiple') || (self.prop('type') == 'select-one' && dom_elm.selectedIndex > 0)))) {
                        changed = true;
                    }
                } else if (self.is('input[type=radio], input[type=checkbox]')) {
                    if (dom_elm.checked != dom_elm.defaultChecked) {
                        changed = true;
                    }
                } else if (self.is('input,textarea')) {
                    if (self.hasClass('cm-numeric')) {
                        var val = self.autoNumeric('get');
                    } else {
                        var val = dom_elm.value;
                    }

                    if (val != dom_elm.defaultValue) {
                        changed = true;
                    }
                }
            }

            return changed;
        },

        disableFields: function()
        {
            if (_.area == 'A') {
                $(this).each(function() {
                    var self = $(this);

                    var hide_filter = ":not(.cm-no-hide-input):not(.cm-no-hide-input *)"
                    var text_elms = $('input[type=text]', self).filter(hide_filter);
                    text_elms.each(function() {
                        var elm = $(this);
                        var hidden_class = elm.hasClass('hidden') ? ' hidden' : '';
                        var value = '';
                        if (elm.prev().hasClass('cm-field-prefix')) {
                            value += elm.prev().text();
                            elm.prev().remove();
                        }
                        value += elm.val();
                        if (elm.next().hasClass('cm-field-suffix')) {
                            value += elm.next().text();
                            elm.next().remove();
                        }

                        elm.wrap('<span class="shift-input' + hidden_class + '">' + value + '</span>');
                        elm.remove();
                    });

                    var label_elms = $('label.cm-required', self).filter(hide_filter);
                        label_elms.each(function() {
                        $(this).removeClass('cm-required');
                    });

                    var text_elms = $('textarea', self).filter(hide_filter);
                    text_elms.each(function() {
                        var elm = $(this);
                        elm.wrap('<div class="shift-input">' + elm.val() + '</div>');
                        elm.remove();
                    });

                    var text_elms = $('select:not([multiple])', self).filter(hide_filter);
                    text_elms.each(function() {
                        var elm = $(this);
                        var hidden_class = elm.hasClass('hidden') ? ' hidden' : '';
                        elm.wrap('<span class="shift-input' + hidden_class + '">' + $(':selected', elm).text() + '</span>');
                        elm.remove();
                    });

                    var text_elms = $('input[type=radio]', self).filter(hide_filter);
                    text_elms.each(function() {
                        var elm = $(this);
                        var label = $('label[for=' + elm.prop('id') + ']');
                        var hidden_class = elm.hasClass('hidden') ? ' hidden' : '';
                        if (elm.prop('checked')) {
                            label.wrap('<span class="shift-input' + hidden_class + '">' + label.text() + '</span>');
                            $('<input type="radio" checked="checked" disabled="disabled">').insertAfter(elm);
                        } else {
                            $('<input type="radio" disabled="disabled">').insertAfter(elm);
                        }
                        if (elm.prop('id')) {
                            label.remove();
                        }
                        elm.remove();
                    });

                    var text_elms = $(':input:not([type=submit])', self).filter(hide_filter);
                    text_elms.each(function() {
                        $(this).prop('disabled', true);
                    });

                    $("a[id^='on_b']", self).remove();
                    $("a[id^='off_b']", self).remove();

                    var a_elms = $('a', self).filter(hide_filter);
                    a_elms.prop('onclick', ''); // unbind do not "unbind" hardcoded onclick attribute

                    // find links to pickers and remove it
                    $('a[id^=opener_picker_], a[data-ca-external-click-id^=opener_picker_]', self).filter(hide_filter).each(function() {
                        $(this).remove();
                    });

                    $('.attach-images-alt', self).filter(hide_filter).remove();

                    $("tbody[id^='box_add_']", self).filter(hide_filter).remove();
                    var tmp_tr_box_add = $("tr[id^='box_add_']", self).filter(hide_filter);
                    tmp_tr_box_add.remove();

                    //Ajax selectors
                    var aj_elms = $("[id$='_ajax_select_object']", self).filter(hide_filter)
                    aj_elms.each(function() {
                        var id = $(this).prop('id').replace(/_ajax_select_object/, '');
                        var aj_link = $('#sw_' + id + '_wrap_');
                        var aj_elm = aj_link.closest('.dropdown-toggle').parent();
                        aj_elm.wrap('<span class="shift-input">' + aj_link.html() + '</span>');
                        aj_elm.remove();
                        $(this).remove();
                    });

                    $('a.cm-delete-row', self).filter(hide_filter).each(function() {
                        $(this).remove();
                    });
                    $(self).removeClass('cm-sortable');
                    $('.cm-sortable-row', self).filter(hide_filter).removeClass('cm-sortable-row');
                    $('p.description', self).filter(hide_filter).remove();
                    $('a.cm-delete-image-link', self).filter(hide_filter).remove();
                    $('.action-add', self).filter(hide_filter).remove();
                    $('.cm-hide-with-inputs', self).filter(hide_filter).remove();
                });
            }
        },

        // Override default $ click method with more smart and working :)
        click: function(fn)
        {
            if (fn)    {
                return this.on('click', fn);
            }

            $(this).each(function() {
                if (document.createEventObject) {
                    $(this).trigger('click');
                } else {
                    var evt_obj = document.createEvent('MouseEvents');
                    evt_obj.initEvent('click', true, true);
                    this.dispatchEvent(evt_obj);
                }
            });

            return this;
        },

        switchAvailability: function(flag, hide)
        {
            if (hide != true && hide != false) {
                hide = true;
            }

            if (flag == false || flag == true) {
                $(':input:not(.cm-skip-avail-switch)', this).prop('disabled', flag).toggleClass('disabled', flag);
                if (hide) {
                    this.toggle(!flag).toggleClass('hidden', flag);
                }
            } else {
                $(':input:not(.cm-skip-avail-switch)', this).each(function(){
                    var self = $(this);
                    var state = self.prop('disabled');
                    self.prop('disabled', !state);
                    self[state ? 'removeClass' : 'addClass']('disabled');
                });
                if (hide) {
                    this.toggleClass('hidden');
                }
            }
        },

        serializeObject: function()
        {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (typeof(o[this.name]) !== 'undefined' && this.name.indexOf('[]') > 0) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });

            var active_tab = this.find('.cm-j-tabs .active');
            if (typeof(active_tab) != 'undefined' && active_tab.length > 0) {
                o['active_tab'] = active_tab.prop('id');
            }

            return o;
        },

        positionElm: function(pos) {
            var elm = $(this);
            elm.css('position', 'absolute');

            // show hidden element to apply correct position
            var is_hidden = elm.is(':hidden');
            if (is_hidden) {
                elm.show();
            }

            elm.position(pos);
            if (is_hidden) {
                elm.hide();
            }
        }

    });

    //
    // Utility functions
    //

    //
    // str_replace wrapper
    //
    String.prototype.str_replace = function(src, dst)
    {

        return this.toString().split(src).join(dst);
    };


    /*
     *
     * Scroller
     * FIXME: Backward compability
     *
     */
    (function($){
        $.ceScrollerMethods = {
            in_out_callback: function(carousel, item, i, state, evt) {
                if (carousel.allow_in_out_callback) {
                    if (carousel.options.autoDirection == 'next') {
                        carousel.add(i + carousel.options.item_count, $(item).html());
                        carousel.remove(i);
                    } else {
                        var last_item = $('li:last', carousel.list);
                        carousel.add(last_item.data('caJcarouselindex') - carousel.options.item_count, last_item.html());
                        carousel.remove(last_item.data('caJcarouselindex'));
                    }
                }
            },

            next_callback: function(carousel, item, i, state, evt) {
                if (state == 'next') {
                    carousel.add(i + carousel.options.item_count, $(item).html());
                    carousel.remove(i);
                }
            },

            prev_callback: function(carousel, item, i, state, evt) {
                if (state == 'prev') {
                    var last_item = $('li:last', carousel.list);
                    var item = last_item.html();
                    var count = last_item.data('caJcarouselindex') - carousel.options.item_count;
                    carousel.remove(last_item.data('caJcarouselindex'));
                    carousel.add(count, item);
                }
            },

            init_callback: function(carousel, state) {
                if (carousel.options.autoDirection == 'prev') {
                    // switch buttons to save the buttons scroll direction
                    var tmp = carousel.buttonNext;
                    carousel.buttonNext = carousel.buttonPrev;
                    carousel.buttonPrev = tmp;
                }
                $('.jcarousel-clip', carousel.container).height(carousel.options.clip_height + 'px');
                $('.jcarousel-clip', carousel.container).width(carousel.options.clip_width + 'px');

                var container_width = carousel.options.clip_width;
                carousel.container.width(container_width);
                if (container_width > carousel.container.width()) {
                    var p = carousel.pos(carousel.options.start, true);
                    carousel.animate(p, false);
                }

                carousel.clip.hover(function() {
                    carousel.stopAuto();
                }, function() {
                    carousel.startAuto();
                });

                if (!$.browser.msie || $.browser.version > 8) {
                    $(window).on('beforeunload', function() {
                        carousel.allow_in_out_callback = false;
                    });
                }

                if ($.browser.chrome) {
                    $.jcarousel.windowLoaded();
                }
            }
        };
    })($);



    /*
     * Dialog opener
     *
     */
    (function($){
        var methods = {
            open: function(params) {

                var container = $(this);

                if (!container.length) {
                    return false;
                }

                $('html').addClass('dialog-is-open');

                params = params || {};
                if (!container.hasClass('ui-dialog-content')) { // dialog is not generated yet, init if
                    if (container.ceDialog('_load_content', params)) {
                        return false;
                    }

                    container.ceDialog('_init', params);
                } else if (params.view_id && container.data('caViewId') != params.view_id && container.ceDialog('_load_content', params)) {
                    return false;
                } else if (container.dialog('isOpen')) {
                    container.height('auto');
                    container.parent().height('auto');
                    methods._resize($(this));
                }

                if ($.browser.msie && params.width == 'auto') {
                    params.width = container.dialog('option', 'width');
                }

                if($(".object-container", container).length == 0) {
                    container.wrapInner('<div class="object-container" />');
                }

                if (params) {
                    container.dialog('option', params);
                }

                $.popupStack.add({
                    name: container.prop('id'),
                    close: function() {
                        try {
                            container.dialog('close');
                        } catch(e) {}
                    }
                });

                if(_.isTouch == true) {
                    // disable autofocus
                    $.ui.dialog.prototype._focusTabbable = function(){};
                }

                var res = container.dialog('open');

                $.scrollToElm(params.scroll, container);

                return res;
            },

            _is_empty: function() {
                var container = $(this);

                var content = $.trim(container.html());

                if (content) {
                    content = content.replace(/<!--(.*?)-->/g, '');
                }

                if (!$.trim(content)) {
                    return true;
                }

                return false;
            },

            _load_content: function(params) {
                var container = $(this);

                params.href = params.href || '';

                if (params.href && (container.ceDialog('_is_empty') || (params.view_id && container.data('caViewId') != params.view_id))) {
                    if (params.view_id) {
                        container.data('caViewId', params.view_id);
                    }

                    $.ceAjax('request', params.href, {
                        full_render: 0,
                        result_ids: container.prop('id'),
                        skip_result_ids_check: true,
                        callback: function() {
                            if (!container.ceDialog('_is_empty')) {
                                container.ceDialog('open', params);
                            }
                        }
                    });

                    return true;
                }

                return false;
            },

            close: function() {
                var container = $(this);
                container.data('close', true);
                container.dialog('close');

                $.popupStack.remove(container.prop('id'));
            },

            reload: function() {
                // disable animation
                var d = $(this);
                d.dialog('option', {show: 0, hide: 0});
                
                if($(this).dialog('option', 'destroyOnClose') === false) {
                    d.dialog('close');
                    d.dialog('open');
                }

                // enable animation
                d.dialog('option', {show: 150, hide: 150});
            },

            resize: function() {
                methods._resize($(this));
            },

            change_title: function(title) {
                $(this).dialog('option', 'title', title);
            },

            destroy: function() {
                $.popupStack.remove($(this).prop('id'));
                try {
                    $(this).dialog('destroy');
                } catch(e) {}
            },

            _get_buttons: function(container) {
                var bts = container.find('.buttons-container');
                var elm = null;

                if (bts.length) {
                    var openers = container.find('.cm-dialog-opener');
                    if (openers.length) {
                        // check buttons not located in other dialogs
                        bts.each (function() {
                            var is_dl = false;
                            var bt = $(this);
                            openers.each(function() {
                                var dl_id = $(this).data('caTargetId');
                                if (bt.parents('#' + dl_id).length) {
                                    is_dl = true;
                                    return false;
                                }
                                return true;
                            });
                            if (!is_dl) {
                                elm = bt;
                            }
                            return true;
                        });
                    } else {
                        elm = container.find('.buttons-container:last');
                    }
                }

                return elm;
            },

            _init: function(params) {
                params = params || {};
                var container = $(this);
                var offset = 10;
                var max_width = 926;
                var width_border = 120;
                var height_border = 80;
                var zindex = 1099;
                var dialog_class = params.dialogClass || '';


                var ws = $.getWindowSizes();
                var container_parent = container.parent();

                if (params.height !== 'auto' && _.area == "A") {
                    params.height = (ws.view_height - height_border);
                }

                if (!container.find('form').length && !container.parents('.object-container').length && !container.data('caKeepInPlace')) {
                    params.keepInPlace = true;
                }

                if (!$.ui.dialog.overlayInstances) {
                    $.ui.dialog.overlayInstances = 1;
                }

                container.find('script[src]').remove();

                if ($.browser.msie && params.width == 'auto') {
                    if ($.browser.version < 8) {
                        container.appendTo(_.body);
                    }
                    params.width = container.outerWidth() + 10;
                }

                container.dialog({
                    title: params.title || null,
                    autoOpen: false,
                    draggable:false,
                    modal: true,
                    width: params.width || (ws.view_width > max_width ? max_width : ws.view_width - width_border),
                    height: params.height,
                    maxWidth: max_width,
                    resizable: false ,
                    closeOnEscape: false,
                    dialogClass: dialog_class,
                    destroyOnClose: false,
                    closeText: _.tr('close'),
                    appendTo: params.keepInPlace ? container_parent : _.body,
                    show: 150,
                    hide: 150,

                    open: function(e, u) {

                        var d = $(this);
                        var w = d.dialog('widget');

                        // A workaround due to conflict between jQuery and Bootstrap.js: Bootstrap.js does not allow form submitting by pressing Enter if the close buttons do not have the type or dara-dismiss attributes.
                        w.find('.ui-dialog-titlebar-close').attr({'data-dismiss':'modal', 'type':'button'});

                        var _zindex = zindex;
                        if (stack.length) {
                            var prev = stack.pop();
                            d.dialog('option', 'position', {
                                my: 'left top',
                                at: 'left+' + (offset * 2) + ' top+' + offset,
                                of: $('#' + prev)
                            });
                            stack.push(prev);
                            _zindex = $('#' + prev).zIndex();
                        }
                        w.zIndex(++_zindex);
                        w.prev().zIndex(_zindex);

                        var elm_id = d.prop('id');
                        stack.push(elm_id);
                        if (!params.keepInPlace) {
                            if (stackInitedBody.indexOf(elm_id) == -1) {
                                stackInitedBody.push(elm_id);
                            }
                        }

                        methods._resize(d);

                        $('html').addClass('dialog-is-open');

                        $.ceEvent('trigger', 'ce.dialogshow', [d]);

                        $('textarea.cm-wysiwyg', d).ceEditor('recover');

                        if (params.switch_avail) {
                            d.switchAvailability(false, false);
                        }
                    },

                    beforeClose: function(e, u) {

                        var d = $(this);

                        var ed = $('textarea.cm-wysiwyg', d);
                        if (ed) {
                            ed.each(function() {
                                $(this).ceEditor('destroy');
                            });
                        }

                        var container = d.find('.object-container');
                        var non_closable = params.nonClosable || false;
                        var buttonsElm = methods._get_buttons(d);

                        // reset default height
                        container.height('auto');
                        d.parent().height('auto');

                        if(buttonsElm) {
                            buttonsElm.css({
                                position: 'static'
                            });
                        }

                        $('textarea.cm-wysiwyg', d).ceEditor('destroy');

                        if (non_closable && !d.data('close')) {
                            return false;
                        }

                        // treating dialog as opened in 'dialogclose' handlers
                        stack.pop();
                        if (params.switch_avail) {
                            d.switchAvailability(true, false);
                        }
                    },

                    close: function(e,u) {
                        if($(this).dialog('option', 'destroyOnClose')) {
                            $(this).dialog('destroy').remove();
                        }
                        // dialog is open
                        setTimeout(function() {
                            if($('.ui-widget-overlay').length == 0) {
                                $('html').removeClass('dialog-is-open');
                            }
                        }, 50);
                    }
                });

            },

            _resize: function(d) {

                var buttonsElm = methods._get_buttons(d);
                var optionsElm = d.find('.cm-picker-options-container');
                var container = d.find('.object-container');
                var max_height = $.getWindowSizes().view_height;
                var buttonsHeight = 0;
                var optionsHeight = 0;
                var containerHeight = 0;
                var dialogHeight = d.parent().outerHeight(true);
                var titleHeight = d.parent().find('.ui-dialog-titlebar').outerHeight();

                if (buttonsElm) {
                    buttonsElm.addClass('buttons-container-picker');
                    // change buttons elm with to prevent height change after changing the position
                    buttonsHeight = buttonsElm.outerHeight(true);
                }

                if (optionsElm.length) {
                    optionsHeight = optionsElm.outerHeight(true);
                }

                if(dialogHeight > max_height) {
                    d.parent().css({
                        bottom: 0
                    });
                }

                containerHeight = d.parent().outerHeight() - titleHeight;
                if(buttonsElm && _.area == "C" ) {
                    if(dialogHeight >= max_height) {
                        containerHeight = containerHeight - buttonsHeight;
                        buttonsElm.css({
                            position: 'absolute',
                            bottom: -buttonsHeight
                        });
                    } else {
                        buttonsElm.css({
                            position: 'absolute',
                            bottom: 0
                        });
                    }

                } else if(buttonsElm && _.area == "A") {
                    containerHeight = containerHeight - buttonsHeight;
                    buttonsElm.css({
                        position: 'absolute',
                        bottom: 0,
                        left: 0,
                        right: 0
                    });
                }

                // set container height
                container.outerHeight(containerHeight);

                if (optionsHeight) {
                    optionsElm.positionElm({
                        my: 'left top',
                        at: 'left bottom',
                        of: container,
                        collision: 'none'
                    });
                    optionsElm.css('width', container.outerWidth());
                }
            }
        };

        var stack = [];
        var stackInitedBody = [];
        var tmpCont;

        $.fn.ceDialog = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if ( typeof method === 'object' || ! method ) {
                return methods._init.apply(this, arguments);
            } else {
                $.error('ty.dialog: method ' +  method + ' does not exist');
            }
        };

        $.ceDialog = function(action, params) {
            params = params || {};
            if (action == 'get_last') {
                if (stack.length == 0) {
                    return $();
                }

                var dlg = $('#' + stack[stack.length - 1]);

                return params.getWidget ? dlg.dialog('widget') : dlg;

            } else if (action == 'fit_elements') {
                var jelm = params.jelm;

                if (jelm.parents('.cm-picker-options-container').length) {
                    $.ceDialog('get_last').data('dialog')._trigger('resize');
                }

            } else if (action == 'reload_parent') {
                var jelm = params.jelm;
                var dlg = jelm.closest('.ui-dialog-content');
                var container = $('.object-container', dlg);

                if (!container.length) {
                    dlg.wrapInner('<div class="object-container" />');
                }

                if (dlg.length && dlg.is(':visible')) {
                    var scrollPosition = container.scrollTop();
                    dlg.ceDialog('reload');
                    container.animate({scrollTop: scrollPosition}, 0);
                }

            } else if (action == 'inside_dialog') {

                return (params.jelm.closest('.ui-dialog-content').length != 0);

            } else if (action == 'get_params') {

                var dialog_params = {
                    keepInPlace: params.hasClass('cm-dialog-keep-in-place'),
                    nonClosable: params.hasClass('cm-dialog-non-closable'),
                    scroll: params.data('caScroll') ? params.data('caScroll') : ''
                };

                if (params.prop('href')) {
                    dialog_params['href'] = params.prop('href');
                }

                if (params.hasClass('cm-dialog-auto-size')) {
                    dialog_params['width'] = 'auto';
                    dialog_params['height'] = 'auto';
                } else if (params.hasClass('cm-dialog-auto-width')) {
                    dialog_params['width'] = 'auto';
                }

                if (params.hasClass('cm-dialog-switch-avail')) {
                    dialog_params['switch_avail'] = true;
                }

                if ($('#' + params.data('caTargetId')).length == 0) {
                    // Auto-create dialog container
                    var title = params.data('caDialogTitle') ? params.data('caDialogTitle') : params.prop('title');
                    $('<div class="hidden" title="' + title + '" id="' + params.data('caTargetId') + '"><!--' + params.data('caTargetId') + '--></div>').appendTo(_.body);
                }

                if (params.prop('href') && params.data('caViewId')) {
                    dialog_params['view_id'] = params.data('caViewId');
                }

                if (params.data('caDialogClass')) {
                    dialog_params['dialogClass'] = params.data('caDialogClass');
                }

                return dialog_params;
            } else if (action == 'clear_stack') {
                $.popupStack.clear_stack();
                return stack = [];
            } else if (action == 'destroy_loaded') {
                var content = $('<div>').html(params.content);
                $.each(stackInitedBody, function(i, id) {
                    if (content.find('#' + id).length) {
                        $('#' + id).ceDialog('destroy');
                    }
                });
            }
        };

        $.extend({
            popupStack: {
                stack: [],
                add: function(params) {
                    return this.stack.push(params);
                },
                remove: function(name) {
                    var position = this.stack.indexOf(name);
                    if (position != -1) {
                        return this.stack.splice(position, 1);
                    }
                },
                last_close: function() {
                    var obj = this.stack.pop();
                    if (obj && obj.close) {
                        obj.close();
                        return true;
                    }
                    return false;
                },
                last: function() {
                    return this.stack[this.stack.length-1];
                },
                close: function(name) {
                    var position = this.stack.indexOf(name);
                    if (position != -1) {
                        var object = this.stack.splice(position, 1)[0];
                        if (object.close) {
                            object.close();
                        }
                        return true;
                    }
                    return false;
                },
                clear_stack: function() {
                    return this.stack = [];
                }
            }
        });
    })($);


    /*
     * Accordion
     *
     */

    (function($) {

        var methods = {
            init: function(params) {
                params = params || {};
                params.heightStyle = "content";

                var container = $(this);
                container.accordion(params);
            },

            reinit: function(params) {
                $(this).accordion(params);
            }
        };

        $.fn.ceAccordion = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if ( typeof method === 'object' || ! method ) {
                return methods.init.apply(this, arguments);
            } else {
                $.error('ty.accordion: method ' +  method + ' does not exist');
            }
        };

        $.ceAccordion = function(method, params) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else {
                $.error('ty.notification: method ' +  method + ' does not exist');
            }
        }
    })($);


    /*
     * WYSIWYG opener
     *
     */
    (function($){

        var handlers = {};
        var state = 'not-loaded';
        var pool = [];

        var methods = {
            run: function(params) {

                if (!this.length) {
                    return false;
                }

                if ($.ceEditor('state') == 'loading') {
                    $.ceEditor('push', this);
                } else {
                    $.ceEditor('run', this, params);
                }
            },

            destroy: function() {

                if (!this.length || $.ceEditor('state') != 'loaded') {
                    return false;
                }

                $.ceEditor('destroy', this);
            },

            recover: function() {

                if (!this.length || $.ceEditor('state') != 'loaded') {
                    return false;
                }

                $.ceEditor('recover', this);
            },

            val: function(value) {

                if (!this.length || $.ceEditor('state') != 'loaded') {
                    return false;
                }

                return $.ceEditor('val', this, value);
            },

            disable: function(value) {

                if (!this.length || $.ceEditor('state') != 'loaded') {
                    return false;
                }

                $.ceEditor('disable', this, value);
            },

            change: function(callback) {
                var onchange = this.data('ceeditor_onchange') || [];
                onchange.push(callback);
                this.data('ceeditor_onchange', onchange);
            },

            changed: function(html) {
                var onchange = this.data('ceeditor_onchange') || [];
                for (var i = 0; i < onchange.length; i++) {
                    onchange[i](html);
                };
            }
        };

        $.fn.ceEditor = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if ( typeof method === 'object' || ! method ) {
                return methods.run.apply(this, arguments);
            } else {
                $.error('ty.editor: method ' +  method + ' does not exist');
            }
        };

        $.ceEditor = function(action, data, params) {
            if (action == 'push') {
                if (data) {
                    pool.push(data);
                } else {
                    return pool.unshift();
                }
            } else if (action == 'state') {
                if (data) {
                    state = data;

                    if (data == 'loaded' && pool.length) {
                        for (var i = 0; i < pool.length; i++) {
                            pool[i].ceEditor('run', params);
                        }
                        pool = [];
                    }
                } else {
                    return state;
                }
            } else if (action == 'handlers') {
                handlers = data;
            } else if (action == 'run' || action == 'destroy' || action == 'updateTextFields' || action == 'recover' || action == 'val' || action == 'disable') {
                return handlers[action](data, params);
            }
        }
    })($);


    /*
     * Previewer methods
     *
     */
    (function($){

        var methods = {
            display: function() {
                $.cePreviewer('display', this);
            }
        };

        $.fn.cePreviewer = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if ( typeof method === 'object' || ! method ) {
                return methods.run.apply(this, arguments);
            } else {
                $.error('ty.previewer: method ' +  method + ' does not exist');
            }
        };

        $.cePreviewer = function(action, data) {
            if (action == 'handlers') {
                this.handlers = data;
            } else if (action == 'display') {
                return this.handlers[action](data);
            }
        }
    })($);


    /*
     * Progress bar (COMET)
     *
     */
    (function($){

        function getContainer(elm)
        {
            var self = $(elm);
            if (self.length == 0) {
                return false;
            }

            var comet_container_id = self.prop('href').split('#')[1];
            var comet_container = $('#' + comet_container_id);

            return comet_container;
        }

        var methods = {

            init: function() {
                var comet_container = getContainer(this);
                if (comet_container == false) {
                    return false;
                }

                comet_container.find('.bar').css('width', 0).prop('data-percentage', 0);

                this.trigger('click'); // Display comet progressBar using Bootstrap click handle
                this.data('ceProgressbar', true);

                $.ceEvent('trigger', 'ce.progress_init');
            },

            setValue: function(o) {

                var comet_container = getContainer(this);

                if (comet_container == false) {
                    return false;
                }

                if (!this.data('ceProgressbar')) {
                    this.ceProgress('init');
                }

                if (o.progress) {
                    comet_container.find('.bar').css('width', o.progress + '%').prop('data-percentage', o.progress);
                }

                if (o.text) {
                    comet_container.find('.modal-body p').html(o.text);
                }

                $.ceEvent('trigger', 'ce.progress', [o]);
            },

            getValue: function(o) {
                var comet_container = getContainer(this);
                if (comet_container == false) {
                    return false;
                }

                if (!this.data('ceProgressbar')) {
                    return 0;
                }

                return parseInt(comet_container.find('.bar').prop('data-percentage'));
            },

            setTitle: function(o) {
                var comet_container = getContainer(this);
                if (comet_container == false) {
                    return false;
                }

                if (!this.data('ceProgressbar')) {
                    this.ceProgress('init');
                }

                if (o.title) {
                    $('#comet_title').text(o.title);
                }
            },

            finish: function() {
                var comet_container = getContainer(this);
                if (comet_container == false) {
                    return false;
                }

                comet_container.find('.bar').css('width', 100).prop('data-percentage', 100);
                comet_container.modal('hide');

                this.removeData('ceProgressbar');
                $.ceEvent('trigger', 'ce.progress_finish');
            }
        };

        $.fn.ceProgress = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if ( typeof method === 'object' || ! method ) {
                return methods.init.apply(this, arguments);
            } else {
                $.error('ty.progress: method ' +  method + ' does not exist');
            }
        };
    })($);


    /*
     * History plugin
     *
     */
    (function($){

        var methods = {

            init: function() {

                if ($.history) {

                    $.history.init(function(hash, params) {

                        if (params && 'result_ids' in params) {
                            var uri = methods.parseHash('#' + hash);
                            var href = uri.indexOf(_.current_location) != -1 ? uri : _.current_location + '/' + uri;
                            var target_id = params.result_ids;
                            var a_elm = $('a[data-ca-target-id="' + target_id + '"]:first'); // hm, used for callback only, so I think it will work with the first found link
                            var name = a_elm.prop('name');

                            $.ceAjax('request', href, {full_render: params.full_render, result_ids: target_id, caching: false, obj: a_elm, skip_history: true, callback: 'ce.ajax_callback_' + name});

                        } else if (_.embedded) {
                            // If the hash changed by user manually or by external script, perform redirect to
                            // the specified location
                            var url = fn_url(window.location.href);
                            if (url != _.current_url) {
                                $.redirect(url);
                            }
                        }
                    }, {unescape: false});
                    return true;
                } else {
                    return false;
                }
            },

            load: function(url, params)
            {
                var _params, current_url;

                url = methods.prepareHash(url);
                current_url = methods.prepareHash(_.current_url);

                _params = {
                    result_ids: params.result_ids,
                    full_render: params.full_render
                }

                $.ceEvent('trigger', 'ce.history_load', [url]);
                $.history.reload(current_url, _params);
                $.history.load(url, _params);
            },

            prepareHash: function(url)
            {

                url = unescape(url); // urls in original content are escaped, so we need to unescape them

                if (url.indexOf('://') !== -1) {
                    //FIXME: Remove this code when support for Internet Explorer 8 and 9 is dropped
                    if($.browser.msie && $.browser.version >= 9) {
                        url = _.current_path + '/' + url.str_replace(_.current_location + '/', '');
                    } else {
                        url = url.str_replace(_.current_location + '/', '');
                    }
                }

                url = fn_query_remove(url, ['result_ids']);
                url = '!/' + url;

                return url;
            },

            parseHash: function(hash)
            {
                if (hash.indexOf('%') !== -1) {
                    hash = unescape(hash);
                }

                if (hash.indexOf('#!') != -1) {
                    var parts = hash.split('#!/');

                    return parts[1] || '';
                }

                return '';
            }
        };

        $.ceHistory = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else {
                $.error('ty.history: method ' +  method + ' does not exist');
            }
        }
    })($);

    /*
    * Hint methods
    *
    */
    (function($){

        var methods = {
            init: function() {
                return this.each(function() {
                    var elm = $(this);
                    elm.bind ({
                        click: function() {
                            $(this).ceHint('_check_hint');
                        },
                        focus: function() {
                            $(this).ceHint('_check_hint');
                        },
                        focusin: function() {
                            $(this).ceHint('_check_hint');
                        },
                        blur: function() {
                            $(this).ceHint('_check_hint_focused');
                        },
                        focusout: function() {
                            $(this).ceHint('_check_hint_focused');
                        }
                    });
                    elm.addClass('cm-hint-focused');
                    elm.removeClass('cm-hint');
                    elm.ceHint('_check_hint_focused');
                });
            },

            is_hint: function() {
                return $(this).hasClass('cm-hint') && ($(this).val() == $(this).ceHint('_get_hint_value'));
            },

            _check_hint: function() {
                var elm = $(this);
                if (elm.ceHint('is_hint')) {
                    elm.addClass('cm-hint-focused');
                    elm.val('');
                    elm.removeClass('cm-hint');
                    elm.prop('name', elm.prop('name').str_replace('hint_', ''));
                }
            },

            _check_hint_focused: function() {
                var elm = $(this);
                if (elm.hasClass('cm-hint-focused')) {
                    if (elm.val() == '' || (elm.val() == elm.ceHint('_get_hint_value'))) {
                        elm.addClass('cm-hint');
                        elm.removeClass('cm-hint-focused');
                        elm.val(elm.ceHint('_get_hint_value'));
                        elm.prop('name', 'hint_' + elm.prop('name'));
                    }
                }
            },

            _get_hint_value: function() {
                return ($(this).prop('title') != '') ? $(this).prop('title') : $(this).prop('defaultValue');
            }

        };

        $.fn.ceHint = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if ( typeof method === 'object' || ! method ) {
                return methods.run.apply(this, arguments);
            } else {
                $.error('ty.hint: method ' +  method + ' does not exist');
            }
        };
    })($);

    /*
     *
     * Sortables
     *
     */
    (function($){
        var methods = {
            init: function(params) {
                return this.each(function() {
                    var params = params || {};
                    var update_text = _.tr('text_position_updating');
                    var self = $(this);

                    var table = self.data('caSortableTable');
                    var id_name = self.data('caSortableIdName')

                    var sortable_params = {
                        accept: 'cm-sortable-row',
                        items: '.cm-row-item',
                        tolerance: 'pointer',
                        axis: 'y',
                        containment: 'parent',
                        opacity: '0.9',
                        update: function(event, ui) {
                            var positions = [], ids = [];
                            var container = $(ui.item).closest('.cm-sortable');

                            $('.cm-row-item', container).each(function(){ // FIXME: replace with data -attribute
                                var matched = $(this).prop('class').match(/cm-sortable-id-([^\s]+)/i);
                                var index = $(this).index();

                                positions[index] = index;
                                ids[index] = matched[1];
                            });

                            var data_obj = {
                                positions: positions.join(','),
                                ids: ids.join(',')
                            };

                            $.ceAjax('request', fn_url('tools.update_position?table=' + table + '&id_name=' + id_name), {
                                method: 'get',
                                caching: false,
                                message: update_text,
                                data: data_obj
                            });

                            return true;
                        }
                    };

                    // If we have sortable handle, update default params
                    if ($('.cm-sortable-handle', self).length) {
                        sortable_params = $.extend(sortable_params, {
                            opacity: '0.5',
                            handle: '.cm-sortable-handle'
                        });
                    }

                    self.sortable(sortable_params);
                });
            }
        };

        $.fn.ceSortable = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if ( typeof method === 'object' || ! method ) {
                return methods.init.apply(this, arguments);
            } else {
                $.error('ty.sortable: method ' +  method + ' does not exist');
            }
        };
    })($);


    /*
    *
    * Color picker
    *
    */
    (function($){

        var methods = {
            init: function(params)
            {
                if (!$(this).length) {
                    return false;
                }

                if (!$.fn.spectrum) {
                    var elms = $(this);
                    $.loadCss(['js/lib/spectrum/spectrum.css'], false, true);
                    $.getScript('js/lib/spectrum/spectrum.js', function(){
                        elms.ceColorpicker();
                    });
                    return false;
                }

                var palette = [
                    ["#000000", "#434343", "#666666", "#999999", "#b7b7b7", "#cccccc", "#d9d9d9", "#efefef", "#f3f3f3", "#ffffff"],
                    ["#980000", "#ff0000", "#ff9900", "#ffff00", "#00ff00", "#00ffff", "#4a86e8", "#0000ff", "#9900ff", "#ff00ff"],
                    ["#e6b8af", "#f4cccc", "#fce5cd", "#fff2cc", "#d9ead3", "#d0e0e3", "#c9daf8", "#cfe2f3", "#d9d2e9", "#ead1dc"],
                    ["#dd7e6b", "#ea9999", "#f9cb9c", "#ffe599", "#b6d7a8", "#a2c4c9", "#a4c2f4", "#9fc5e8", "#b4a7d6", "#d5a6bd"],
                    ["#cc4125", "#e06666", "#f6b26b", "#ffd966", "#93c47d", "#76a5af", "#6d9eeb", "#6fa8dc", "#8e7cc3", "#c27ba0"],
                    ["#a61c00", "#cc0000", "#e69138", "#f1c232", "#6aa84f", "#45818e", "#3c78d8", "#3d85c6", "#674ea7", "#a64d79"],
                    ["#85200c", "#990000", "#b45f06", "#bf9000", "#38761d", "#134f5c", "#1155cc", "#0b5394", "#351c75", "#741b47"],
                    ["#5b0f00", "#660000", "#783f04", "#7f6000", "#274e13", "#0c343d", "#1c4587", "#073763", "#20124d", "#4c1130"]
                ];

                return this.each(function() {
                    var jelm = $(this);
                    var params = {
                        showInput: true,
                        showInitial: false,
                        showPalette: false,
                        showSelectionPalette: false,
                        palette: palette,
                        preferredFormat: 'hex6',
                        beforeShow: function() {
                            jelm.spectrum('option', 'showPalette', true);
                            jelm.spectrum('option', 'showInitial', true);
                            jelm.spectrum('option', 'showSelectionPalette', true);
                        },
                        hide:  function() {
                            $.ceEvent('trigger', 'ce.colorpicker.hide');
                        },
                        show:  function() {
                            $.ceEvent('trigger', 'ce.colorpicker.show');
                        }

                    };

                    if (jelm.data('caView') && jelm.data('caView') == 'palette') {
                        params.showPaletteOnly = true;
                    }

                    if (jelm.data('caStorage')) {
                        params.localStorageKey = jelm.data('caStorage');
                    }

                    jelm.spectrum(params);
                    jelm.spectrum('container').appendTo(jelm.parent());
                });
            },

            reset: function()
            {
                this.spectrum('set', this.val());
            },

            set: function(val)
            {
                this.spectrum('set', val);
            }
        };

        $.fn.ceColorpicker = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if ( typeof method === 'object' || ! method ) {
                return methods.init.apply(this, arguments);
            } else {
                $.error('ty.colorpicker: method ' +  method + ' does not exist');
            }
        };
    })($);

    /*
    *
    * Form validator
    *
    */
    (function($){

        var clicked_elm; // last clicked element
        var zipcode_regexp = {}; // zipcode validation regexps
        var regexp = {}; // validation regexps - deprecated
        var validators = []; // registered custom validators

        function _fillRequirements(form, check_filter)
        {
            var lbl, lbls, id, elm, requirements = {};

            if (check_filter) {
                lbls = $(check_filter, form).find('label');
            } else {
                lbls = $('label', form);
            }

            for (var k = 0; k < lbls.length; k++) {
                lbl = $(lbls[k]);
                id = lbl.prop('for');

                // skip lables with not assigned element, class or not-valid id (e.g. with placeholders)
                if (!id || !lbl.prop('class') || !id.match(/^([a-z0-9-_]+)$/)) {
                    continue;
                }

                elm = $('#' + id);

                if (elm.length && !elm.prop('disabled')) {
                    requirements[id] = {
                        elm: elm,
                        lbl: lbl
                    };
                }
            }

            return requirements;
        }

        function _checkFields(form, requirements, only_check)
        {
            var set_mark, elm, lbl, container, _regexp, _message;
            var message_set = false;

            // Reset all failed fields
            $('.cm-failed-field', form).removeClass('cm-failed-field');
            errors = {};
            for (var elm_id in requirements) {
                set_mark = false;
                elm = requirements[elm_id].elm;
                lbl = requirements[elm_id].lbl;

                // Check the need to trim value
                if (lbl.hasClass('cm-trim')) {
                    elm.val($.trim(elm.val()));
                }

                // Check the email field
                if (lbl.hasClass('cm-email')) {
                    if ($.is.email(elm.val()) == false) {
                        if (lbl.hasClass('cm-required') || $.is.blank(elm.val()) == false) {
                            _formMessage(_.tr('error_validator_email'), lbl);
                            set_mark = true;
                        }
                    }
                }

                // Check for correct color code
                if (lbl.hasClass('cm-color')) {
                    if ($.is.color(elm.val()) == false) {
                        if (lbl.hasClass('cm-required') || $.is.blank(elm.val()) == false) {
                            _formMessage(_.tr('error_validator_color'), lbl);
                            set_mark = true;
                        }
                    }
                }

                // Check the phone field
                if (lbl.hasClass('cm-phone')) {
                    if ($.is.phone(elm.val()) != true) {
                        if (lbl.hasClass('cm-required') || $.is.blank(elm.val()) == false) {
                            _formMessage(_.tr('error_validator_phone'), lbl);
                            set_mark = true;
                        }
                    }
                }

                // Check the zipcode field
                if (lbl.hasClass('cm-zipcode')) {
                    var loc = lbl.prop('class').match(/cm-location-([^\s]+)/i)[1] || '';
                    var country = $('.cm-country' + (loc ? '.cm-location-' + loc : ''), form).val();
                    var val = elm.val();

                    if (zipcode_regexp[country] && !elm.val().match(zipcode_regexp[country]['regexp'])) {
                        if (lbl.hasClass('cm-required') || $.is.blank(elm.val()) == false) {
                            _formMessage(_.tr('error_validator_zipcode'), lbl, null, zipcode_regexp[country]['format']);
                            set_mark = true;
                        }
                    }
                }

                // Check for integer field
                if (lbl.hasClass('cm-integer')) {
                    if ($.is.integer(elm.val()) == false) {
                        if (lbl.hasClass('cm-required') || $.is.blank(elm.val()) == false) {
                            _formMessage(_.tr('error_validator_integer'), lbl);
                            set_mark = true;
                        }
                    }
                }

                // Check for multiple selectbox
                if (lbl.hasClass('cm-multiple') && elm.prop('length') == 0) {
                    _formMessage(_.tr('error_validator_multiple'), lbl);
                    set_mark = true;
                }

                // Check for passwords
                if (lbl.hasClass('cm-password')) {
                    var pair_lbl = $('label.cm-password', form).not(lbl);
                    var pair_elm = $('#' + pair_lbl.prop('for'));

                    if (elm.val() && elm.val() != pair_elm.val()) {
                        _formMessage(_.tr('error_validator_password'), lbl, pair_lbl);
                        set_mark = true;
                    }
                }

                if (validators) {
                    for (var i = 0; i < validators.length; i++) {
                        if (lbl.hasClass(validators[i].class_name)) {
                            result = validators[i].func(elm_id);
                            if (result != true) {
                                _formMessage(validators[i].message, lbl);
                                set_mark = true;
                            }
                        }
                    }
                }

                if (lbl.hasClass('cm-regexp')) {
                    _regexp = null;
                    _message = null;
                    if (elm_id in regexp) {
                        _regexp = regexp[elm_id]['regexp'];
                        _message = regexp[elm_id]['message'] ? regexp[elm_id]['message'] : _.tr('error_validator_message');
                    } else if (lbl.data('caRegexp')) {
                        _regexp = lbl.data('caRegexp');
                        _message = lbl.data('caMessage');
                    }

                    if (_regexp && !elm.ceHint('is_hint')) {
                        var val = elm.val();
                        var expr = new RegExp(_regexp);
                        var result = expr.test(val);

                        if (!result && !(!lbl.hasClass('cm-required') && elm.val() == '')) {
                            _formMessage(_message, lbl);
                            set_mark = true;
                        }
                    }
                }

                // Check for the multiple checkboxes/radio buttons
                if (lbl.hasClass('cm-multiple-checkboxes') || lbl.hasClass('cm-multiple-radios')) {
                    if (lbl.hasClass('cm-required')) {
                        var el_filter = lbl.hasClass('cm-multiple-checkboxes') ? '[type=checkbox]' : '[type=radio]';
                        if ($(el_filter + ':not(:disabled)', elm).length && !$(el_filter + ':checked', elm).length) {
                            _formMessage(_.tr('error_validator_required'), lbl);
                            set_mark = true;
                        }
                    }
                }

                // Select all items in multiple selectbox
                if (lbl.hasClass('cm-all')) {
                    if (elm.prop('length') == 0 && lbl.hasClass('cm-required')) {
                        _formMessage(_.tr('error_validator_multiple'), lbl);
                        set_mark = true;
                    } else {
                        $('option', elm).prop('selected', true);
                    }

                // Check for blank value
                } else {

                    // Check for multiple selectbox
                    if (elm.is(':input')) {
                        if (lbl.hasClass('cm-required') && ((elm.is('[type=checkbox]') && !elm.prop('checked')) || $.is.blank(elm.val()) == true || elm.ceHint('is_hint'))) {
                            _formMessage(_.tr('error_validator_required'), lbl);
                            set_mark = true;
                        }
                    }
                }

                container = elm.closest('.cm-field-container');
                if (container.length) {
                    elm = container;
                }

                if (!only_check) {

                    $('[id="' + elm_id + '_error_message"].help-inline', elm.parent().parent()).remove();

                    if (set_mark == true) {
                        lbl.parent().addClass('error has-error');
                        elm.addClass('cm-failed-field');
                        lbl.addClass('cm-failed-label');

                        if (!elm.hasClass('cm-no-failed-msg')) {
                            $('<span id="' + elm_id + '_error_message" class="help-inline help-block">' + _getMessage(elm_id) + '</span>')
                                .insertAfter(elm.parent());
                        }

                        if (!message_set) {
                            $.scrollToElm(elm);
                            message_set = true;
                        }

                        // Resize dialog if we have errors
                        var dlg = $.ceDialog('get_last');
                        var dlg_target = $('.cm-dialog-auto-size[data-ca-target-id="'+ dlg.attr('id') +'"]');

                        if(dlg_target.length) {
                            dlg.ceDialog('reload');
                        }

                    } else {
                        lbl.parent().removeClass('error has-error');
                        elm.removeClass('cm-failed-field');
                        lbl.removeClass('cm-failed-label');
                    }

                } else {
                    if (set_mark) {
                        message_set = true;
                    }
                }
            }
            return !message_set;
        }

        function _disableEmptyFields(form)
        {
            var selector = [];

            if (form.hasClass('cm-disable-empty')) {
                selector.push('input[type=text]');
            }
            if (form.hasClass('cm-disable-empty-files')) {
                selector.push('input[type=file]');

                // Disable empty input[type=file] in order to block the "garbage" data
                $('input[type=file][data-ca-empty-file=""]', form).prop('disabled', true);
            }

            if (selector.length) {
                $(selector.join(','), form).each(function() {
                    var self = $(this);
                    if (self.val() == '') {
                        self.prop('disabled', true);
                        self.addClass('cm-disabled')
                    }
                });
            }
        }

        function _check(form, params)
        {
            var form_result = true;
            var check_fields_result = true;
            var h;

            params = params || {};
            params.only_check = params.only_check || false;

            if (!clicked_elm) { // workaround for IE when the form has one input only
                if ($('[type=submit]', form).length) {
                    clicked_elm = $('[type=submit]:first', form);
                } else if ($('input[type=image]', form).length) {
                    clicked_elm = $('input[type=image]:first', form);
                }
            }

            if (!clicked_elm.hasClass('cm-skip-validation')) {

                var requirements = _fillRequirements(form, clicked_elm.data('caCheckFilter'));

                if ($.ceEvent('trigger', 'ce.formpre_' + form.prop('name'), [form, clicked_elm]) === false) {
                    form_result = false;
                }

                check_fields_result = _checkFields(form, requirements, params.only_check);
            }

            if (params.only_check) {
                return check_fields_result && form_result;
            }

            if (check_fields_result && form_result) {

                _disableEmptyFields(form);

                // remove currency symbol
                form.find('.cm-numeric').each(function() {
                    var val = $(this).autoNumeric('get');
                    $(this).prop('value', val);
                });

                h = clicked_elm.data('original_element') ? clicked_elm.data('original_element') : clicked_elm;

                // protect button from double click
                if (h.data('clicked') == true) {
                    return false;
                }

                // set clicked flag
                h.data('clicked', true);

                if ((form.hasClass('cm-ajax') || clicked_elm.hasClass('cm-ajax')) && !clicked_elm.hasClass('cm-no-ajax')) {
                    // clean clicked flag
                    $.ceEvent('one', 'ce.ajaxdone', function() {
                        h.data('clicked', false);
                    });
                }

                if (clicked_elm.hasClass('cm-comet')) {
                    $.ceEvent('one', 'ce.cometdone', function() {
                        h.data('clicked', false);
                    });
                }

                // If pressed button has cm-new-window microformat, send form to new window
                // otherwise, send to current
                if (clicked_elm.hasClass('cm-new-window')) {
                    form.prop('target', '_blank');

                    // clean clicked flag
                    setTimeout(function() {
                        h.data('clicked', false);
                    }, 1000);

                    return true;

                } else if (clicked_elm.hasClass('cm-parent-window')) {
                    form.prop('target', '_parent');
                    return true;

                } else {
                    form.prop('target', '_self');
                }

                if ($.ceEvent('trigger', 'ce.formpost_' + form.prop('name'), [form, clicked_elm]) === false) {
                    form_result = false;
                }

                if (clicked_elm.closest('.cm-dialog-closer').length) {
                    $.ceDialog('get_last').ceDialog('close');
                }

                if ((form.hasClass('cm-ajax') || clicked_elm.hasClass('cm-ajax')) && !clicked_elm.hasClass('cm-no-ajax')) {

                    // FIXME: this code should be moved to another place I believe
                    var collection = form.add(clicked_elm);
                    if (collection.hasClass('cm-form-dialog-closer') || collection.hasClass('cm-form-dialog-opener')) {

                        $.ceEvent('one', 'ce.formajaxpost_' + form.prop('name'), function(response_data, params) {

                            if (collection.hasClass('cm-form-dialog-closer')) {
                                $.popupStack.last_close();
                            }

                            if (collection.hasClass('cm-form-dialog-opener')) {
                                var _id = form.find('input[name=result_ids]').val();
                                if (_id && typeof(response_data.html) !== "undefined") {
                                    $('#' + _id).ceDialog('open', $.ceDialog('get_params', form));
                                }
                            }
                        });
                    }

                    return $.ceAjax('submitForm', form, clicked_elm);
                }

                if (clicked_elm.hasClass('cm-no-ajax')) {
                    $('input[name=is_ajax]', form).remove();
                }

                if (_.embedded && form_result == true && !$.externalLink(form.prop('action'))) {

                    form.append('<input type="hidden" name="result_ids" value="' + _.container + '" />');
                    clicked_elm.data('caScroll', _.container);
                    return $.ceAjax('submitForm', form, clicked_elm);
                }

                if (form_result == false) {
                    h.data('clicked', false); // if form won't be submitted, clear clicked flag
                }

                return form_result;

            } else if (check_fields_result == false) {
                var hidden_tab = $('.cm-failed-field', form).parents('[id^="content_"]:hidden');
                if (hidden_tab.length && $('.cm-failed-field', form).length == $('.cm-failed-field', hidden_tab).length) {
                    $('#' + hidden_tab.prop('id').str_replace('content_', '')).click();
                }
            }

            return false;
        }

        function _formMessage(msg, field, field2, extra)
        {
            var id = field.prop('for');

            if (errors[id]) {
                return false;
            }

            errors[id] = [];

            msg = msg.str_replace('[field]', _fieldTitle(field));

            if (field2) {
                msg = msg.str_replace('[field2]', _fieldTitle(field2));
            }
            if (extra) {
                msg = msg.str_replace('[extra]', extra);
            }

            errors[id].push(msg);
        };

        function _fieldTitle(field)
        {
            return field.text().replace(/(\s*\(\?\))?:\s*$/, '');
        }

        function _getMessage(id)
        {
            return '<p>' + errors[id].join('</p><p>') + '</p>';
        };

        // public methods
        var methods = {
            init: function() {
                var form = $(this);
                form.on('submit', function(e) {
                    return _check(form);
                })
            },
            setClicked: function(elm) {
                clicked_elm = elm;
            },
            check: function(){
                var form = $(this);
                return _check(form, {only_check: true});
            }
        }

        $.fn.ceFormValidator = function(method) {
            var args = arguments;
            var result;

            $(this).each(function(i, elm) {

                // These vars are local for each element
                var errors = {};

                if (methods[method]) {
                    result = methods[method].apply(this, Array.prototype.slice.call(args, 1));
                } else if ( typeof method === 'object' || ! method ) {
                    result = methods.init.apply(this, args);
                } else {
                    $.error('ty.formvalidator: method ' +  method + ' does not exist');
                }
            });

            return result;
        };

        $.ceFormValidator = function(action, params) {
            params = params || {};
            if (action == 'setZipcode') {
                zipcode_regexp = params;
            } else if (action == 'setRegexp') {
                if ('console' in window) {
                    console.log('This method is deprecated, use data-attributes "data-ca-regexp" and "data-ca-message" instead');
                }
                regexp = $.extend(regexp, params);
            } else if (action == 'registerValidator') {
                validators.push(params);
            } else if (action == 'check') {
                if (params.form) {
                    return methods.check.apply(params.form);
                }
            }
        }
    })($);

    /*
    *
    * States field builder
    *
    */
    (function($){

        var options = {};
        var init = false;

        function _rebuildStates(section, elm)
        {
            elm = elm || $('.cm-state.cm-location-' + section).prop('id');
            var sbox = $('#' + elm).is('select') ? $('#' + elm) : $('#' + elm + '_d');
            var inp = $('#' + elm).is('input') ? $('#' + elm) : $('#' + elm + '_d');
            var default_state = inp.val();
            var cntr = $('.cm-country.cm-location-' + section);
            var cntr_disabled;

            if (cntr.length) {
                cntr_disabled = cntr.prop('disabled');
            } else {
                cntr_disabled = sbox.prop('disabled');
            }

            var country_code = (cntr.length) ? cntr.val() : options.default_country;
            var tag_switched = false;
            var pkey = '';

            sbox.prop('id', elm).prop('disabled', false).removeClass('hidden cm-skip-avail-switch');
            inp.prop('id', elm + '_d').prop('disabled', true).addClass('hidden cm-skip-avail-switch').val('');

            if (!inp.hasClass('disabled')) {
                sbox.removeClass('disabled');
            }

            if (options.states && options.states[country_code]) { // Populate selectbox with states
                sbox.prop('length', 1);
                for (var i = 0; i < options.states[country_code].length; i++) {
                    sbox.append('<option value="' + options.states[country_code][i]['code'] + '"' + (options.states[country_code][i]['code'] == default_state ? ' selected' : '') + '>' + options.states[country_code][i]['state'] + '</option>');
                }

                sbox.prop('id', elm).prop('disabled', false).removeClass('cm-skip-avail-switch');
                inp.prop('id', elm + '_d').prop('disabled', true).addClass('cm-skip-avail-switch');

                if (!inp.hasClass('disabled')) {
                    sbox.removeClass('disabled');
                }

            } else { // Disable states
                sbox.prop('id', elm + '_d').prop('disabled', true).addClass('hidden cm-skip-avail-switch');
                inp.prop('id', elm).prop('disabled', false).removeClass('hidden cm-skip-avail-switch').val(default_state);

                if (!sbox.hasClass('disabled')) {
                    inp.removeClass('disabled');
                }
            }

            if (cntr_disabled == true) {
                sbox.prop('disabled', true);
                inp.prop('disabled', true);
            }
        }

        function _rebuildStatesInLocation() {
            var location_elm = $(this).prop('class').match(/cm-location-([^\s]+)/i);
            if (location_elm) {
                _rebuildStates(location_elm[1], $('.cm-state.cm-location-' + location_elm[1]).not(':disabled').prop('id'));
            }
        }

        var methods = {
            init: function() {
                if ($(this).hasClass('cm-country')) {
                    if (init == false) {
                        $(_.doc).on('change', 'select.cm-country', _rebuildStatesInLocation);
                        init = true;
                    }
                    $(this).trigger('change');
                } else {
                    _rebuildStatesInLocation.call(this);
                }
            }
        }

        $.fn.ceRebuildStates = function(method) {
            var args = arguments;

            return $(this).each(function(i, elm) {
                if (methods[method]) {
                    return methods[method].apply(this, Array.prototype.slice.call(args, 1));
                } else if ( typeof method === 'object' || ! method ) {
                    return methods.init.apply(this, args);
                } else {
                    $.error('ty.rebuildstates: method ' +  method + ' does not exist');
                }
            });
        };

        $.ceRebuildStates = function(action, params) {
            params = params || {};
            if (action == 'init') {
                options = params;
            }
        }
    })($);

   /*
    *
    * Sticky scroll
    *
    */
    (function($){
        var methods = {
            init: function(params) {
                return this.each(function() {
                    var params = params || {
                        top: $(this).data('ceTop') ? $(this).data('ceTop') : 0,
                        padding: $(this).data('cePadding') ? $(this).data('cePadding') : 0
                    };
                    var self = $(this);

                    $(window).scroll(function () {
                        if ($(window).scrollTop() > params.top) {
                            $(self).css({'position': 'fixed', 'top': params.padding + 'px'});
                        } else {
                            $(self).css({'position': '', 'top': ''});
                        }
                    });

                });
            }
        };

        $.fn.ceStickyScroll = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if ( typeof method === 'object' || ! method ) {
                return methods.init.apply(this, arguments);
            } else {
                $.error('ty.stickyScroll: method ' +  method + ' does not exist');
            }
        };
    })($);


   /*
    *
    * Notifications
    *
    */
    (function($) {

        var container;
        var timers = {};
        var delay = 0;

        function _duplicateNotification(key)
        {
            var dups = $('div[data-ca-notification-key=' + key + ']');
            if (dups.length) {

                if (!_addToDialog(dups)) {
                    dups.fadeTo('fast', 0.5).fadeTo('fast', 1).fadeTo('fast', 0.5).fadeTo('fast', 1);
                }

                // Restart autoclose timer
                if (timers[key]) {
                    clearTimeout(timers[key]);
                    methods.close(dups, true);
                }

                return true;
            }

            return false;
        }

        function _closeNotification(notification)
        {
            if (notification.find('.cm-notification-close-ajax').length) {
                $.ceAjax('request', fn_url('notifications.close?notification_id=' + notification.data('caNotificationKey')), {
                    hidden: true
                });
            }

            notification.fadeOut('fast', function() {
                notification.remove();
            });

            if (notification.hasClass('cm-notification-content-extended')) {
                var overlay = $('.ui-widget-overlay[data-ca-notification-key=' + notification.data('caNotificationKey') + ']');
                if (overlay.length) {
                    overlay.fadeOut('fast', function() {
                        overlay.remove();
                    });
                }
            }

            if($(".ui-dialog").is(':visible') == false) {
                $('html').removeClass('dialog-is-open');
            }

        }

        function _processTranslation(text)
        {
            if (_.live_editor_mode && text.indexOf('[lang') != -1) {
                text = '<var class="live-edit-wrap"><i class="cm-icon-live-edit glyphicon glyphicon-pencil fa fa-pencil badge"></i><var class="cm-live-edit live-edit-item" data-ca-live-edit="langvar::' + text.substring(text.indexOf('=') + 1, text.indexOf(']')) + '">' + text.substring(text.indexOf(']') + 1, text.lastIndexOf('[')) + '</var></var>';
            }

            return text;
        }
        function _pickFromDialog(event) {
            var nt = $('.cm-notification-content', $(event.target));
            if (nt.length) {
                if (!_addToDialog(nt)) {
                    container.append(nt);
                }
            }
            return true;
        }

        function _addToDialog(notification)
        {
            var dlg = $.ceDialog('get_last');
            if (dlg.length) {
                $('.object-container', dlg).prepend(notification);
                dlg.off('dialogclose', _pickFromDialog);
                dlg.on('dialogclose', _pickFromDialog);
                return true;
            }
            return false;
        }

        var methods = {
            show: function (data, key)
            {
                if (!key) {
                    key = $.crc32(data.message);
                }

                if (typeof(data.message) == 'undefined') {
                    return false;
                }

                if (_duplicateNotification(key)) {
                    return true;
                }

                data.message = _processTranslation(data.message);
                data.title = _processTranslation(data.title);

                // Popup message in the screen center - should be only one at time
                if (data.type == 'I') {
                    var w = $.getWindowSizes();

                    $('.cm-notification-content.cm-notification-content-extended').each(function() {
                        methods.close($(this), false);
                    });

                    $(_.body).append(
                        '<div class="ui-widget-overlay" style="z-index:1010" data-ca-notification-key="' + key + '"></div>'
                    );

                    var notification = $('<div class="cm-notification-content cm-notification-content-extended notification-content-extended ' + (data.message_state == "I" ? ' cm-auto-hide' : '') + '" data-ca-notification-key="' + key + '">' +
                        '<h1>' + data.title + '<span class="cm-notification-close close">&times;</span></h1>' +
                        '<div class="notification-body-extended">' +
                        data.message +
                        '</div>' +
                        '</div>');

                    var notificationMaxHeight = w.view_height - 300;

                    $(notification).find('.cm-notification-max-height').css({
                        'max-height': notificationMaxHeight
                    });

                    // FIXME I-type notifications are embedded directly into the body and not into a container, because a container has low z-index and get overlapped by modal dialogs.
                    //container.append(notification);
                    $(_.body).append(notification);
                    notification.css('top', w.view_height / 2 - (notification.height() / 2));

                } else {
                    var n_class = 'alert';
                    var b_class = '';

                    if (data.type == 'N') {
                        n_class += ' alert-success';
                    } else if (data.type == 'W') {
                        n_class += ' alert-warning';
                    } else if (data.type == 'S') {
                        n_class += ' alert-info';
                    } else {
                        n_class += ' alert-danger';
                    }

                    if (data.message_state == 'I') {
                        n_class += ' cm-auto-hide';
                    } else if (data.message_state == 'S') {
                        b_class += ' cm-notification-close-ajax';
                    }

                    var notification = $('<div class="cm-notification-content notification-content ' + n_class + '" data-ca-notification-key="' + key + '">' +
                        '<button type="button" class="close cm-notification-close ' + b_class + '" data-dismiss="alert">&times;</button>' +
                        '<strong>' + data.title + '</strong> ' + data.message +
                        '</div>');

                    if (!_addToDialog(notification)) {
                        container.append(notification);
                    }
                }

                $.ceEvent('trigger', 'ce.notificationshow', [notification]);

                if (data.message_state == 'I') {
                    methods.close(notification, true);
                }
            },

            showMany: function(data)
            {
                for (var key in data) {
                    methods.show(data[key], key);
                }
            },

            closeAll: function()
            {
                container.find('.cm-notification-content').each(function() {
                    var self = $(this);
                    if (!self.hasClass('cm-notification-close-ajax')) {
                        methods.close(self, false);
                    }
                })
            },

            close: function(notification, delayed)
            {
                if (delayed == true) {
                    if (delay === 0) { // do not auto-close
                        return true;
                    }

                    timers[notification.data('caNotificationKey')] = setTimeout(function(){
                        methods.close(notification, false);
                    }, delay);

                    return true;
                }

                _closeNotification(notification);
            },

            init: function()
            {
                delay = _.notice_displaying_time * 1000;
                container = $('.cm-notification-container');

                $(_.doc).on('click', '.cm-notification-close', function() {
                    methods.close($(this).parents('.cm-notification-content:first'), false);
                })

                container.find('.cm-auto-hide').each(function() {
                    methods.close($(this), true);
                });
            }
        };


        $.ceNotification = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else {
                $.error('ty.notification: method ' +  method + ' does not exist');
            }
        };

    }($));


   /*
    *
    * Events
    *
    */
    (function($) {
        var handlers = {};

        var methods = {
            on: function(event, handler, one)
            {
                one = one || false;
                if (!(event in handlers)) {
                    handlers[event] = [];
                }
                handlers[event].push({
                    handler: handler,
                    one: one
                });
            },

            one: function(event, handler)
            {
                methods.on(event, handler, true);
            },

            trigger: function(event, data)
            {
                data = data || [];
                var result = true, _res;
                if (event in handlers) {
                    for (var i = 0; i < handlers[event].length; i++) {
                        _res = handlers[event][i].handler.apply(handlers[event][i].handler, data);

                        if (handlers[event][i].one) {
                            handlers[event].splice(i, 1);
                            i --;
                        }

                        if (_res === false) {
                            result = false;
                            break;
                        }
                    }
                }

                return result;
            }
        };

        $.ceEvent = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else {
                $.error('ty.event: method ' +  method + ' does not exist');
            }
        };

    }($));

    /*
     * Code editor
     *
     */
    (function($){

        var methods = {
            _init: function(self) {

                if (!self.data('codeEditor')) {
                    var editor = ace.edit(self.prop('id'));
                    editor.session.setUseWrapMode(true);
                    editor.session.setWrapLimitRange();
                    editor.setFontSize("14px");
                    editor.renderer.setShowPrintMargin(false);

                    editor.getSession().on('change', function(e) {
                        self.addClass('cm-item-modified');
                    });

                    self.data('codeEditor', editor);
                }

                return $(this);
            },

            init: function(mode) {
                var self = $(this);
                methods._init(self);

                if (mode) {
                    self.data('codeEditor').getSession().setMode(mode);
                }

                return $(this);
            },

            set_value: function(val, mode) {
                var self = $(this);
                methods._init(self);

                if(mode == undefined) {
                    mode = 'ace/mode/html';
                }

                self.data('codeEditor').getSession().setMode(mode);
                self.data('codeEditor').setValue(val);
                self.data('codeEditor').navigateLineStart();
                self.data('codeEditor').clearSelection();
                self.data('codeEditor').scrollToRow(0);

                return $(this);
            },

            set_show_gutter: function(value) {
                $(this).data('codeEditor').renderer.setShowGutter(value);
            },

            value: function() {
                var self = $(this);
                methods._init(self);

                return self.data('codeEditor').getValue();
            },

            focus: function() {
                var self = $(this);
                var session = self.data('codeEditor').getSession();
                var count = session.getLength();
                self.data('codeEditor').focus();
                self.data('codeEditor').gotoLine(count, session.getLine(count-1).length);
            },

            set_listener: function(event_name, callback) {
                $(this).data('codeEditor').getSession().on(event_name, function(e) {
                    callback(e);
                });

                return $(this);
            }
        };

        $.fn.ceCodeEditor = function(method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if ( typeof method === 'object' || ! method ) {
                return methods.init.apply(this, arguments);
            } else {
                $.error('ty.codeeditor: method ' +  method + ' does not exist');
            }
        };
    })($);

    /*
     * Object selector
     */
    (function ($) {
        var plugin_name = "ceObjectSelector",
            defaults = {
                pageSize: 10,
                enableSearch: true,
                closeOnSelect: true,
                loadViaAjax: false,
                dataUrl: null,
                enableImages: false,
                imageWidth: 20,
                imageHeight: 20,
                placeholder: null
            };

        function ObjectSelector(element, options) {
            this.$el = $(element);
            this.settings = $.extend({}, defaults, options);

            this.init();
        }

        $.extend(ObjectSelector.prototype, {
            init: function () {
                var data = this.$el.data();

                this.settings.placeholder = data.caPlaceholder || this.settings.placeholder;
                this.settings.pageSize = data.caPageSize || this.settings.pageSize;
                this.settings.dataUrl = data.caDataUrl || this.settings.dataUrl;
                this.settings.loadViaAjax = data.caLoadViaAjax === undefined
                    ? this.settings.loadViaAjax
                    : data.caLoadViaAjax;
                this.settings.closeOnSelect = data.caCloseOnSelect === undefined
                    ? this.settings.closeOnSelect
                    : data.caCloseOnSelect;
                this.settings.enableImages = data.caEnableImages === undefined
                    ? this.settings.enableImages
                    : data.caEnableImages;
                this.settings.enableSearch = data.caEnableSearch === undefined
                    ? this.settings.enableSearch
                    : data.caEnableSearch;
                this.settings.imageWidth = data.caImageWidth === undefined
                    ? this.settings.imageWidth
                    : data.caImageWidth;
                this.settings.imageHeight = data.caImageHeight === undefined
                    ? this.settings.imageHeight
                    : data.caImageHeight;

                this.initSelect2();
            },
            initSelect2: function () {
                var self = this, select2config = {
                    language: {
                        'loadingMore': function() {
                            return _.tr('loading');
                        },
                        'searching': function() {
                            return _.tr('loading');
                        },
                        'errorLoading': function() {
                            return _.tr('error');
                        }
                    },
                    closeOnSelect: this.settings.closeOnSelect,
                    placeholder: this.settings.placeholder
                };

                // Load variants via AJAX from given URL
                if (this.settings.loadViaAjax && this.settings.dataUrl !== null) {
                    select2config.ajax = {
                        url: this.settings.dataUrl,
                        data: function (params) {
                            var request = {
                                q: params.term,
                                page: params.page || 1,
                                page_size: self.settings.pageSize
                            };

                            if (self.settings.enableImages) {
                                request.image_width = self.settings.imageWidth;
                                request.image_height = self.settings.imageHeight;
                            }

                            return request;
                        },
                        processResults: function (data, params) {
                            params.page = params.page || 1;
                            return {
                                results: data.objects,
                                pagination: {
                                    more: (params.page * self.settings.pageSize) < data.total_objects
                                }
                            };
                        },
                        transport: function (params, success, failure) {
                            params.callback = success;
                            params.hidden = true;

                            return $.ceAjax('request', params.url, params);
                        }
                    };
                }

                if (this.settings.enableImages) {
                    select2config.templateResult = function(object) {
                        if (!object.image_url) {
                            return object.text;
                        }

                        return $('<img src="' + object.image_url + '" alt="' + object.text + '" /><span>' + object.text + '</span>');
                    };
                }

                if (!this.settings.enableSearch) {
                    select2config.minimumResultsForSearch = Infinity;
                }

                this.$el.select2(select2config);
            }
        });

        $.fn[plugin_name] = function (options) {

            var self = this, createPluginInstances = function () {
                return self.each(function () {
                    if (!$.data(this, "plugin_" + plugin_name)) {
                        $.data(this, "plugin_" + plugin_name, new ObjectSelector(this, options));
                    }
                });
            };

            if (this.length) {
                if ($.fn.select2) {
                    return createPluginInstances();
                } else {
                    $.getScript('js/lib/select2/select2.full.min.js', function () {
                        createPluginInstances();
                    });
                }
            }

            return this;
        };
    })($);


    _.toNumeric = function(arg) {
        var number = Number(String(arg).str_replace(',', '.'));

        return isNaN(number) ? 0 : number;
    };

    /**
     * Returns number of signs after comma of given float
     *
     * @param x
     * @returns {number}
     */
    _.getFloatPrecision = function (x) {
        return String(x).replace('.', '').length - x.toFixed().length;
    };

    // If page is loaded with URL in hash parameter, redirect to this URL
    if (!_.embedded && location.hash && unescape(location.hash).indexOf('#!/') === 0) {
        var components = $.parseUrl(location.href)
        var uri = $.ceHistory('parseHash', location.hash);

        //FIXME: Remove this code when support for Internet Explorer 8 and 9 is dropped
        if($.browser.msie && $.browser.version >= 9) {
            $.redirect(components.protocol + '://' + components.host + uri);
        } else {
            $.redirect(components.protocol + '://' + components.host + components.directory + uri);
        }
    }

}(Tygh, jQuery));


    //
    // Print variable contents
    //
    function fn_print_r(value)
    {
        fn_alert(fn_print_array(value));
    }

    //
    // Show alert
    //
    function fn_alert(msg, not_strip)
    {
        msg = not_strip ? msg : fn_strip_tags(msg);
        alert(msg);
    }

    // Helper
    function fn_print_array(arr, level)
    {
        var dumped_text = "";
        if(!level) {
            level = 0;
        }

        //The padding given at the beginning of the line.
        var level_padding = "";
        for(var j=0; j < level+1; j++) {
            level_padding += "    ";
        }

        if(typeof(arr) == 'object') { //Array/Hashes/Objects
            for(var item in arr) {
                var value = arr[item];

                if(typeof(value) == 'object') { //If it is an array,
                    dumped_text += level_padding + "'" + item + "' ...\n";
                    dumped_text += fn_print_array(value,level+1);
                } else {
                    dumped_text += level_padding + "'" + item + "' => \"" + value + "\"\n";
                }
            }
        } else { //Stings/Chars/Numbers etc.
            dumped_text = arr+" ("+typeof(arr)+")";
        }

        return dumped_text;
    }

    function fn_url(url)
    {
        var index_url = Tygh.current_location + '/' + Tygh.index_script;
        var components = Tygh.$.parseUrl(url);

        if (url == '') {
            url = index_url;

        } else if (components.protocol) {

            if (Tygh.embedded) {

                var s, spos;
                if (Tygh.facebook && Tygh.facebook.url.indexOf(components.location) != -1) {
                    s = '&app_data=';
                } else if (Tygh.init_context == components.source.str_replace('#' + components.anchor, '')) {
                    s = '#!';
                }

                if (s) {

                    var q = '';
                    if ((spos = url.indexOf(s)) != -1) {
                        q = decodeURIComponent(url.substr(spos + s.length)).replace('&amp;', '&');
                    }

                    url = Tygh.current_location + q;
                }
            }

        } else if (components.file != Tygh.index_script) {
            if (url.indexOf('?') == 0) {
                url = index_url + url;

            } else {
                url = index_url + '?dispatch=' + url.replace('?', '&');

            }
        }

        return url;
    }

    function fn_strip_tags(str)
    {
        str = String(str).replace(/<.*?>/g, '');
        return str;
    }

    function fn_reload_form(jelm)
    {
        var form = jelm.parents('form');
        var container = form.parent();

        var submit_btn = form.find("input[type='submit']");
        if (!submit_btn.length) {
            submit_btn = Tygh.$('[data-ca-target-form=' + form.prop('name') + ']');
        }

        if (container.length && submit_btn.length) {

            var url = form.prop('action') + '?reload_form=1&' + submit_btn.prop('name');

            var data = form.serializeObject();
            var result_ids;
            // If not preset result_ids in form get form container id
            if (data.result_ids != 'undefined') {
                result_ids = data.result_ids;
            } else {
                result_ids = container.prop('id');
            }
            Tygh.$.ceAjax('request', fn_url(url), {
                data: data,
                result_ids: result_ids
            });
        }
    }

    function fn_get_listed_lang(langs)
    {
        var $ = Tygh.$;
        // check langs priority
        var check_langs = [Tygh.cart_language, Tygh.default_language, 'en'];
        var lang = '';

        if (langs.length) {
            lang = langs[0];

            for (var i = 0; i < check_langs.length; i++) {
                if (Tygh.$.inArray(check_langs[i], langs) != -1) {
                    lang = check_langs[i];
                    break;
                }
            }
        }

        return lang;
    }

    function fn_query_remove(query, vars)
    {
        if (typeof(vars) == 'undefined') {
            return query;
        }
        if (typeof vars == 'string') {
            vars = [vars];
        }
        var start = query;
        if (query.indexOf('?') >= 0) {
            start = query.substr(0, query.indexOf('?') + 1);
            var search = query.substr(query.indexOf('?') + 1);
            var srch_array = search.split("&");
            var temp_array = [];
            var concat = true;
            var amp = '';

            for (var i = 0; i < srch_array.length; i++) {
                temp_array = srch_array[i].split("=");
                concat = true;
                for (var j = 0; j < vars.length; j++) {
                    if (vars[j] == temp_array[0] || temp_array[0].indexOf(vars[j]+'[') != -1) {
                        concat = false;
                        break;
                    }
                }
                if (concat == true) {
                    start += amp + temp_array[0] + '=' + temp_array[1];
                }
                amp = '&';
            }
        }
        return start;
    }
    
    function fn_calculate_total_shipping(wrapper_id) {
        var $ = Tygh.$;

        wrapper_id = wrapper_id || 'shipping_estimation';
        var parent = $('#' + wrapper_id);

        var radio = $('input[type=radio]:checked', parent);
        var params = [];

        $.each(radio, function(id, elm) {
            params.push({name: elm.name, value: elm.value});
        });

        var url = fn_url('checkout.shipping_estimation.get_total');

        for (var i in params) {
            url += '&' + params[i]['name'] + '=' + encodeURIComponent(params[i]['value']);
        }

        var suffix = parent.find('input[name="suffix"]').first().val();
        
        $.ceAjax('request', url, {
            result_ids: 'shipping_estimation_total' + suffix,
            data: {
                additional_id: parent.find('input[name="additional_id"]').first().val()
            },
            method: 'post'
        });
    }
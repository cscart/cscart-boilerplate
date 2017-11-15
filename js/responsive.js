(function(_, $) {
    'use strict';

    // ui module
    var ui = (function() {
        return {
            winWidth: function() {
                return $(window).width();
            },

            responsiveScroll: function() {
                $.ceEvent('on', 'ce.needScroll', function(opt) {

                    opt.need_scroll = false;
                    setTimeout(function() {
                        $.scrollToElm(opt.jelm.data('caScroll'));
                    }, 310);
                });
            },

            responsiveNotifications: function() {
                if(this.winWidth() <= 767) {
                    $.ceEvent('on', 'ce.notificationshow', function(notification) {
                        if($(notification).hasClass('cm-notification-content-extended')) {
                            $('body,html').scrollTop(0);
                        }
                    });
                }
            },

            resizeDialog: function() {
                var self = this;
                var dlg = $('.ui-dialog');

                $('.ui-widget-overlay').css({
                    'min-height': $(window).height()
                });

                $(dlg).css({
                    'position':'absolute',
                    'width': $(window).width() - 20,
                    'left': '10px',
                    'top':'10px',
                    'max-height': 'none',
                    'height': 'auto',
                    'margin-bottom': '10px'
                });

                // calculate title width
                $(dlg).find('.ui-dialog-title').css({
                    'width': $(window).width() - 80
                });

                $(dlg).find('.ui-dialog-content').css({
                    'height': 'auto',
                    'max-height': 'none'
                });

                $(dlg).find('.object-container').css({
                    'height': 'auto'
                });

                $(dlg).find('.buttons-container').css({
                    'position':'relative',
                    'top': 'auto',
                    'left': '0px',
                    'right': '0px',
                    'bottom': '0px',
                    'width': 'auto'
                });

            },

            responsiveDialog: function() {
                var self = this;
                $.ceEvent('on', 'ce.dialogshow', function() {
                    if(self.winWidth() <= 767) {
                        self.resizeDialog();
                        $('body,html').scrollTop(0);
                    }
                });
            },

            responsiveFilters: function(e) {
                var filtersContent = $('.cm-horizontal-filters-content');
                if(this.winWidth() <= 767) {
                    filtersContent.removeClass('cm-popup-box');
                } else {
                    filtersContent.addClass('cm-popup-box');
                }

                if(this.winWidth() > 767) {
                    $('.ty-horizontal-filters-content-to-right').removeClass('ty-horizontal-filters-content-to-right');
                    $('.ty-horizontal-product-filters-dropdown').click(function() {
                        var hrFiltersWidth = $(".cm-horizontal-filters").width();
                        var hrFiltersContent = $('.cm-horizontal-filters-content', this);
                        setTimeout(function () {
                            var position = hrFiltersContent.offset().left + hrFiltersContent.width();
                            if(position > hrFiltersWidth) {
                                hrFiltersContent.addClass("ty-horizontal-filters-content-to-right");
                            }
                        }, 1);
                    });
                }
            }
        };
    })();

    // Init
    $(document).ready(function(){

        $(window).resize(function(e){
            ui.winWidth();
            ui.responsiveFilters();
        });

        var navbar = $('.no-margin-nav .navbar-collapse>ul.nav');
        if(ui.winWidth() <= 767) {
            if (!navbar.hasClass('navbar-nav'))
                navbar.addClass('navbar-nav');
        } else {
            if (!navbar.hasClass('navbar-nav'))
                navbar.removeClass('navbar-nav');
        }

        if (window.addEventListener) {
            window.addEventListener('orientationchange', function() {
                if(ui.winWidth() <= 767) {
                    ui.resizeDialog();
                }
                $.ceDialog('get_last').ceDialog('reload');
            }, false);
        }

        ui.responsiveDialog();

        // responsive filters
        ui.responsiveFilters();

        $.ceEvent('on', 'ce.ajaxdone', function() {
            ui.responsiveFilters();

            if(ui.winWidth() <= 767) {
                ui.resizeDialog();
            }
        });

    });

     // tabs
    $.ceEvent('on', 'ce.tab.init', function() {
        ui.responsiveScroll();
    });

}(Tygh, Tygh.$));

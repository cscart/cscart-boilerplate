{styles use_scheme=true}
    {style src="styles.less"}

    {if $runtime.customization_mode.live_editor || $runtime.customization_mode.design}
    {style src="tygh/design_mode.less"}
    {/if}
    {style src="retina.less"}
{/styles}

{script src="js/lib/jquery/jquery.min.js"}

{script src="js/lib/modernizr/modernizr.custom.js"}
{script src="js/tygh/core.js"}
{script src="js/tygh/ajax.js"}
{script src="js/tygh/history.js"}

{script src="js/lib/jqueryui/jquery-ui.custom.min.js"}
{script src="js/lib/appear/jquery.appear-1.1.1.js"}

{script src="js/tygh/live_editor_mode.js"}

<script type="text/javascript">
(function(_, $) {

    _.tr({
        save: '{__("save")|escape:"javascript"}',
        close: '{__("close")|escape:"javascript"}',
        loading: '{__("loading")|escape:"javascript"}',
        notice: '{__("notice")|escape:"javascript"}',
        warning: '{__("warning")|escape:"javascript"}',
        error: '{__("error")|escape:"javascript"}',
        empty: '{__("empty")|escape:"javascript"}'
    });
    
    $.extend(_, {
        index_script: '{$config.customer_index|escape:javascript nofilter}',
        changes_warning: /*'{$settings.Appearance.changes_warning|escape:javascript nofilter}'*/'N',
        default_editor: '{$settings.Appearance.default_wysiwyg_editor}',
        default_previewer: '{$settings.Appearance.default_image_previewer}',    
        current_path: '{$config.current_path|escape:javascript nofilter}',
        current_location: '{$config.current_location|escape:javascript nofilter}',
        images_dir: '{$images_dir}',
        notice_displaying_time: {if $settings.Appearance.notice_displaying_time}{$settings.Appearance.notice_displaying_time}{else}0{/if},
        cart_language: '{$smarty.const.CART_LANGUAGE}',
        default_language: '{$smarty.const.DEFAULT_LANGUAGE}',
        cart_prices_w_taxes: {if ($settings.Appearance.cart_prices_w_taxes == 'Y')}true{else}false{/if},
        theme_name: '{$settings.theme_name|escape:javascript nofilter}',
        current_url: '{$config.current_url|escape:javascript nofilter}'
    });

    {if $live_editor_objects}
        $.extend(_, {
            live_editor_mode: true,
            live_editor_objects: {$live_editor_objects|json_encode nofilter}
        });
    {/if}

    {if !$smarty.request.init_context}

        $(document).ready(function(){
            $.runCart('C');
        });

    {/if}

{if $config.tweaks.anti_csrf}
    // CSRF form protection key
    _.security_hash = '{""|fn_generate_security_hash}';
{/if}
}(Tygh, Tygh.$));
</script>

{include file="common/loading_box.tpl"}
{include file="common/notification.tpl"}

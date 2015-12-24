<!DOCTYPE html>
<html lang="{$smarty.const.CART_LANGUAGE}">
    <head>
        <title>{__('checkout')}</title>
        <link href="{$logos.favicon.image.image_path}" rel="shortcut icon" type="{$logos.favicon.image.absolute_path|fn_get_mime_content_type}" />
        {include file="common/styles.tpl" include_dropdown=true}
        {include file="common/scripts.tpl"}
    </head>
    <body>
        <div id="tygh_container">
            <div class="helper-container" id="tygh_main_container">
                <div class="center" style="margin: 0 auto; width: 390px; padding-bottom: 30px;" id="fp-form"></div>
                <div align='center'>
                    <span id="wrap_place_order_tab1" class="button-submit-big button-wrap-left">
                        <span class="button-submit-big button-wrap-right">
                            <input type="button" class="button alt" name="{__('place_order')}" id="place_order" value="{__('place_order')}" onclick="FP.CartIntegration.placeOrder();"/>
                        </span>
                    </span>
                    <span class="button button-wrap-left">
                        <span class="button button-wrap-right">
                            <a href="{$continue_url}">{__('continue_shopping')}</a>
                        </span>
                    </span>
                </div>

                <script type="text/javascript" src="{$script_url}"></script>

                {literal}
                <script type="text/javascript" class="cm-ajax-force">

                    if (Tygh && Tygh.embedded) {
                        setTimeout(function() { FP.CartIntegration(); });
                    }

                    function FuturePayResponseHandler(response)
                    {
                        var params = '';

                        params += "&code=" + response.code;
                        params += "&reason=" + response.message;

                        if (!response.error) {
                            params += "&transaction_id=" + response.transaction_id;
                            params += "&status=" + response.status;
                        }

                        self.location = '{/literal}{$return_url nofilter}{literal}' + params;
                    }

                    var intervalID = setInterval(function() {
                        if (document.getElementById('fp-signup-purchase') || document.getElementById('fp-activate-account')) {
                            $('.order-status').hide();
                            FP.CartIntegration.displayFuturePay();
                            $('#fp-form').html(FP.CartIntegration.getFormContent());
                            clearInterval(intervalID);
                      }
                    }, 1000);
                </script>
                {/literal}
            <!--tygh_main_container--></div>
        <!--tygh_container--></div>
    </body>
</html>

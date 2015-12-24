{if $cart_agreements || $settings.Checkout.agree_terms_conditions == "Y"}
    {if $settings.Checkout.agree_terms_conditions == "Y"}
        <div class="checkbox">
            {hook name="checkout:terms_and_conditions"}
                <label for="id_accept_terms{$suffix}" class="cm-check-agreement control-label">
                    <input type="checkbox" id="id_accept_terms{$suffix}" name="accept_terms" value="Y" class="cm-agreement " {if $iframe_mode}onclick="fn_check_agreements('{$suffix}');"{/if} />{__("checkout_terms_n_conditions")}
                </label>
            
            {/hook}
        </div>
    {/if}
    {if $cart_agreements}
        {hook name="checkout:terms_and_conditions_downloadable"}
            <div class="cm-field-container checkout">
                <label for="product_agreements_{$suffix}" class="cm-check-agreement control-label">
                    <input type="checkbox" id="product_agreements_{$suffix}" name="agreements[]" value="Y" class="cm-agreement "  {if $iframe_mode}onclick="fn_check_agreements('{$suffix}');"{/if}/>
                        {__("checkout_edp_terms_n_conditions")}
                        <a id="sw_elm_agreements_{$suffix}" class="cm-combination ">{__("license_agreement")}</a>
                </label>
            </div>
        {/hook}
        <div class="hidden" id="elm_agreements_{$suffix}">
            {foreach from=$cart_agreements item="product_agreements"}
                {foreach from=$product_agreements item="agreement"}
                    <p>{$agreement.license nofilter}</p>
                {/foreach}
            {/foreach}
        </div>
    {/if}

        <script type="text/javascript">
        (function(_, $) {
            $.ceFormValidator('registerValidator', {
                class_name: 'cm-check-agreement',
                message: '{__("checkout_terms_n_conditions_alert")|escape:javascript}',
                func: function(id) {
                    return $('#' + id).prop('checked');
                }
            });     
        }(Tygh, Tygh.$));

        {if $iframe_mode}
            function fn_check_agreements(suffix) {
                var checked = true;

                $('form[name=payments_form_' + suffix + '] input[type=checkbox].cm-agreement').each(function(index, value) {
                    if($(value).prop('checked') === false) {
                        checked = false;
                    }
                });

                $('#payment_method_iframe_' + suffix).toggleClass('hidden', checked);
            }
        {/if}
    </script>
{/if}

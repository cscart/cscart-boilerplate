{script src="js/tygh/tabs.js"}

{hook name="checkout:payment_method_check"}
    {if $order_id}
        {$url = "orders.details?order_id=`$order_id`"}
        {$result_ids = "elm_payments_list"}
    {else}
        {$url = "checkout.checkout"}
        {$result_ids = "checkout*,step_four"}
    {/if}
{/hook}

{if $payment_methods|count > 1}
<div class="cm-j-tabs cm-track cm-j-tabs-disable-convertation">
    <ul class="nav nav-tabs" role="payment_tabs">
        {foreach from=$payment_methods key="tab_id" item="payments"}
            {assign var="tab_name" value="payments_`$tab_id`"}
            {if $tab_id == $active_tab || (!$active_tab && $payments[$payment_id])}
                {$active = $tab_id}
            {/if}
            {$first_payment = $payments|reset}

            <li  class="{if $tab_id == $active_tab || (!$active_tab && $payments[$payment_id])} active{/if}">
                <a class=" cm-ajax cm-ajax-full-render" data-ca-target-id="{$result_ids}" href="{"`$url`?active_tab=`$tab_id`&payment_id=`$first_payment.payment_id`"|fn_url}">{__($tab_name)}</a>
            </li>
        {/foreach}
    </ul>
</div>
{/if}

<div class="cm-tabs-content cm-j-content-disable-convertation tabs-content clearfix">
    {foreach from=$payment_methods key="tab_id" item="payments"}
        <div class="{if $active != $tab_id && $payment_methods|count > 1}hidden{/if} tab-pane" id="content_payments_{$tab_id}">
            <form name="payments_form_{$tab_id}" action="{""|fn_url}" method="post" class="payments-form">
            <input type="hidden" name="payment_id" value="{$payment_id}" />
            <input type="hidden" name="result_ids" value="{$result_ids}" />
            <input type="hidden" name="dispatch" value="checkout.place_order" />

            {if $order_id}
                <input type="hidden" name="order_id" value="{$order_id}" />
            {/if}

            {if $payments|count == 1}
                {assign var="payment" value=$payments|reset}
                <h2>{$payment.payment}</h2>
                {if $payment.template}
                    {capture name="payment_template"}
                        {if $payment.image}
                            {include file="common/image.tpl" obj_id=$payment.payment_id images=$payment.image }
                        {/if}
                        
                        {if $payment.description}
                            <p>{$payment.description}<p>
                        {/if}

                        {include file=$payment.template card_id=$payment.payment_id}
                    {/capture}
                {/if}

                {if $payment.template && $smarty.capture.payment_template|trim != ""}
                    {$payment.instructions nofilter}
                    {$smarty.capture.payment_template nofilter}
                {else}
                    {include file="views/checkout/components/payments/payments_list.tpl" payments=[$payment]}
                {/if}

            {else}
                {include file="views/checkout/components/payments/payments_list.tpl"}
            {/if}

            {include file="views/checkout/components/final_section.tpl" is_payment_step=true suffix=$tab_id}
            
            {if $order_id}
                {if $payment_method.params.button}
                    {$payment_method.params.button}
                {else}
                    {include file="common/button.tpl" text=__("repay_order") name="dispatch[orders.repay]" meta="btn-primary cm-checkout-place-order"}
                {/if}
            {else}

                {assign var="show_checkout_button" value=false}
                {foreach from=$payments item="payment"}
                    {if $payment_id == $payment.payment_id && $checkout_buttons[$payment_id]}
                        {assign var="show_checkout_button" value=true}
                    {/if}
                {/foreach}

                {if $auth.act_as_user}
                    <div class="checkbox">
                        <label class="control-label">
                            <input type="checkbox" id="skip_payment" name="skip_payment" value="Y" class="checkbox" />
                            {__("skip_payment")}
                        </label>
                    </div>
                {/if}

                {hook name="checkout:extra_payment_info"}
                {/hook}

                {if $iframe_mode}
                        <iframe width="100%" height="700" id="order_iframe_{$smarty.const.TIME}" src="{"checkout.process_payment"|fn_checkout_url:$smarty.const.AREA}" style="border: 0px" frameBorder="0" ></iframe>
                        {if $cart_agreements || $settings.Checkout.agree_terms_conditions == "Y"}
                        <div id="payment_method_iframe_{$tab_id}" >
                            {__("checkout_terms_n_conditions_alert")}
                        </div>
                        {/if}
                {else}
                        {if !$show_checkout_button}
                            {include file="common/button.tpl" text=__("submit_my_order") name="dispatch[checkout.place_order]" id="place_order_`$tab_id`" meta="btn-primary cm-checkout-place-order"}
                        {else}
                            {$checkout_buttons[$payment_id] nofilter}
                        {/if}
                {/if}
            {/if}

            <div class="processor-buttons hidden"></div>
            </form>
        <!--content_payments_{$tab_id}-->
        </div>
    {/foreach}
</div>

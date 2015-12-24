{script src="js/tygh/tabs.js"}
<div class="panel panel-default" data-ct-checkout="user_info" id="step_one">
    <div class="panel-heading">
    <h4>
        <span class="label label-default">{$number_of_step}</span>
        
        {hook name="checkout:step_four_edit_link_title"}
        {if $complete && !$edit}
            <a class="cm-ajax" href="{"checkout.checkout?edit_step=step_four&from_step={$cart.edit_step}"|fn_url}" data-ca-target-id="checkout_*">{__("billing_options")}</a>
        {else}
            {__("billing_options")}
        {/if}
        {/hook}
    </h4>
    </div>
    <div id="step_four_body" class="panel-body {if $edit}active{/if} {if !$edit}hidden{/if}">
        {if $edit}
            {if $cart|fn_allow_place_order:$auth}
                {if $cart.payment_id}
                    {include file="views/checkout/components/payments/payment_methods.tpl" payment_id=$cart.payment_id}
                {else}
                    <div class="checkout-block"><h3>{__("text_no_payments_needed")}</h3></div>
                    
                    <form name="paymens_form" action="{""|fn_url}" method="post">
                        {include file="views/checkout/components/final_section.tpl" is_payment_step=true}
                        <div>
                            {include file="common/button.tpl" text=__("submit_my_order") name="dispatch[checkout.place_order]" id="place_order" meta="btn-primary cm-checkout-place-order"}
                        </div>
                    </form>
                {/if}
            {else}
                {include file="views/checkout/components/final_section.tpl" is_payment_step=true}
            {/if}
        {/if}
    </div>
<!--step_four-->
</div>

<div id="place_order_data" class="hidden">
</div>
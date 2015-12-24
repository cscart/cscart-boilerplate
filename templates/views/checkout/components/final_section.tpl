{$show_place_order = false}

{if $cart|fn_allow_place_order:$auth}
    {$show_place_order = true}
{/if}

{if $recalculate && !$cart.amount_failed}
    {$show_place_order = true}
{/if}

{if $show_place_order}

    <div class="{if !$is_payment_step} checkout-block{/if}">
        {hook name="checkout:final_section_customer_notes"}
            {include file="views/checkout/components/customer_notes.tpl"}
        {/hook}
        
        {if !$suffix}
            {assign var="suffix" value=""|uniqid}
        {/if}
        {include file="views/checkout/components/terms_and_conditions.tpl" suffix=$suffix}
    </div>

    <input type="hidden" name="update_steps" value="1" />
    
    {if !$is_payment_step}
        <div class="cm-checkout-place-order-buttons">
            {include file="common/button.tpl" text=__("submit_my_order") name="dispatch[checkout.place_order]" id="place_order" meta="btn-primary cm-checkout-place-order"}
        </div>

        {if $recalculate && $cart.shipping_required}
            <input type="hidden" name="next_step" value="step_two" />
            <div class="cm-checkout-recalculate-buttons hidden">
                {include file="common/button.tpl" meta="btn-defeault cm-checkout-recalculate" name="dispatch[checkout.update_steps]" text=__("recalculate_shipping_cost") as="link"}
            </div>
        {/if}
    {/if}

{else}

    {if $cart.shipping_failed}
        <p class="alert alert-warning">{__("text_no_shipping_methods")}</p>
    {/if}

    {if $cart.amount_failed}
        <div class="checkout-block">
            <p class="alert alert-warning">{__("text_min_order_amount_required")}&nbsp;<strong>{include file="common/price.tpl" value=$settings.General.min_order_amount}</strong></p>
        </div>
    {/if}

    <div>
        {include file="common/button.tpl" href=$continue_url|fn_url text=__("continue_shopping")}
    </div>
    
{/if}
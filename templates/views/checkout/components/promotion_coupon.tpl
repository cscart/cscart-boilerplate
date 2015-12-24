{if $cart|fn_display_promotion_input_field}
<form class="cm-ajax cm-ajax-force cm-ajax-full-render" name="coupon_code_form{$position}" action="{""|fn_url}" method="post">
    <input type="hidden" name="result_ids" value="checkout*,cart_status*,cart_items,payment-methods" />
    <input type="hidden" name="redirect_url" value="{$config.current_url}" />

    {hook name="checkout:discount_coupons"}
        <div class="row">
            <div class="col-lg-12">
                <div class="input-group">
                    <input type="text" class="form-control cm-hint" id="coupon_field{$position}" name="coupon_code" size="40" value="{__("promo_code")}" />
                    {include file="common/go.tpl" name="checkout.apply_coupon" alt=__("apply") text=__("apply")}
                </div>
                <label for="coupon_field{$position}" class="hidden cm-required control-label">{__("promo_code")}</label>
            </div>
        </div>
    {/hook}
</form>
{/if}

{hook name="checkout:applied_discount_coupons"}
    {capture name="promotion_info"}
        {hook name="checkout:applied_coupons_items"}
            {foreach from=$cart.coupons item="coupon" key="coupon_code"}
            <li class="coupons-item">
                {__("coupon")} "{$coupon_code}"
                {assign var="_redirect_url" value=$config.current_url|escape:url}
                {assign var="coupon_code" value=$coupon_code|escape:url}
                {include file="common/button.tpl" href="checkout.delete_coupon?coupon_code=`$coupon_code`&redirect_url=`$_redirect_url`" meta="coupons-delete cm-ajax cm-ajax-full-render" target_id="checkout*,cart_status*,cart_items"}
            </li>
            {/foreach}
            {if $cart.applied_promotions}
                <li class="coupons-item">
                    {include file="views/checkout/components/applied_promotions.tpl"}
                </li>
            {/if}
        {/hook}
    {/capture}

    {if $smarty.capture.promotion_info|trim}
        <ul class="list-group">
            {if $cart.has_coupons}
                <li class="list-group-item">
                    
                </li>
            {/if}
            {$smarty.capture.promotion_info nofilter}
        </ul>
    {/if}
{/hook}

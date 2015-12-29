{if $location == "cart" && $cart.shipping_required == true && $settings.General.estimate_shipping_cost == "Y"}
    {capture name="shipping_estimation"}
        <i class="cart-total-icon-estimation glyphicon glyphicon-plane fa fa-plane"></i>
        <a id="opener_shipping_estimation_block" class="cm-dialog-opener cm-dialog-auto-size" data-ca-target-id="shipping_estimation_block" href="{"checkout.cart"|fn_url}" rel="nofollow">
            {if $cart.shipping}{__("change")}{else}{__("calculate")}{/if}
        </a>
    {/capture}
    <div class="hidden" id="shipping_estimation_block" title="{__("calculate_shipping_cost")}">
        <div class="cart-content-estimation">
            {include file="views/checkout/components/shipping_estimation.tpl" location="popup" result_ids="shipping_estimation_link"}
        </div>
    </div>
{/if}

<div class="panel panel-default cart-total">
    <div class="panel-body cart-total-wrapper clearfix" id="checkout_totals">
        <div class="row">
            {if $cart_products}
                <div class="coupons-container col-lg-4">
                    {include file="views/checkout/components/promotion_coupon.tpl"}
                    {hook name="checkout:payment_extra"}
                    {/hook}
                </div>
                <div class="col-lg-4">
                    {hook name="checkout:payment_options"}
                    {/hook}
                </div>
            {/if}

            <div class="col-lg-4 text-right">
                <dl class="cart-statistic dl-horizontal">
                    <dt class="subtotal">{__("subtotal")}</dt>
                    <dd class="subtotal">{include file="common/price.tpl" value=$cart.display_subtotal}</dd>


                    {hook name="checkout:checkout_totals"}
                    {if $cart.shipping_required == true && ($location != "cart" || $settings.General.estimate_shipping_cost == "Y")}
                        {if $cart.shipping}
                            <dt class="shipping-method">
                                {foreach from=$cart.shipping item="shipping" key="shipping_id" name="f_shipp"}
                                    {$shipping.shipping}{if !$smarty.foreach.f_shipp.last}, {/if}
                                {/foreach}
                                <span class="nowrap">({$smarty.capture.shipping_estimation|trim nofilter})</span>
                            </dt>
                            <dd class="shipping-method">{include file="common/price.tpl" value=$cart.display_shipping_cost}</dd>
                        {else}
                            <dt class="shipping-method">{__("shipping_cost")}</dt>
                            <dd class="shipping-method">{$smarty.capture.shipping_estimation nofilter}</dd>
                        {/if}
                    {/if}
                    {/hook}

                    {if ($cart.discount|floatval)}
                        <dt class="discount">{__("including_discount")}</dt>
                        <dd class="discount">-{include file="common/price.tpl" value=$cart.discount}</dd>
                    {/if}

                    {if ($cart.subtotal_discount|floatval)}
                        <dt class="subtotal-discount">{__("order_discount")}</dt>
                        <dd class="subtotal-discount">-{include file="common/price.tpl" value=$cart.subtotal_discount}</dd>
                        {hook name="checkout:checkout_discount"}{/hook}
                    {/if}

                    {if $cart.taxes}
                        <dt class="taxes"></dt>
                        <dd class="taxes">{__("taxes")}</dd>
                    {foreach from=$cart.taxes item="tax"}
                        <dt class="tax">{$tax.description}&nbsp;({include file="common/modifier.tpl" mod_value=$tax.rate_value mod_type=$tax.rate_type}{if $tax.price_includes_tax == "Y" && ($settings.Appearance.cart_prices_w_taxes != "Y" || $settings.General.tax_calculation == "subtotal")}&nbsp;{__("included")}{/if})</dt>
                        <dd class="tax">{include file="common/price.tpl" value=$tax.tax_subtotal}</dd>
                    {/foreach}
                    {/if}

                    {if $cart.payment_surcharge && !$take_surcharge_from_vendor}
                        {assign var="payment_data" value=$cart.payment_id|fn_get_payment_method_data}
                        <dt class="payment-surcharge">{$cart.payment_surcharge_title|default:__("payment_surcharge")}{if $payment_data.payment}&nbsp;({$payment_data.payment}){/if}:</dt>
                        <dd class="payment-surcharge">{include file="common/price.tpl" value=$cart.payment_surcharge span_id="payment_surcharge_value"}</dd>
                        {math equation="x+y" x=$cart.total y=$cart.payment_surcharge assign="_total"}
                        {capture name="_total"}{$_total}{/capture}
                    {/if}

                    <dt class="item">{__("total_cost")}</dt>
                    <dd class="item">{include file="common/price.tpl" value=$_total|default:$smarty.capture._total|default:$cart.total span_id="cart_total"}</dd>
                </dl>
            </div>
        </div>
    <!--checkout_totals--></div>
</div>

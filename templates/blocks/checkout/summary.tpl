<div id="checkout_info_summary_{$block.snapping_id}">
    <table class="table table-condensed checkout-summary">
        <tbody>
            <tr>
                <td>{$cart.amount} {__("items")}</td>
                <td data-ct-checkout-summary="items" class="text-right">
                    <span>{include file="common/price.tpl" value=$cart.display_subtotal}</span>
                </td>
            </tr>

            {if !$cart.shipping_failed
                && $cart.chosen_shipping
                && $cart.shipping_required
                && $cart.display_shipping_cost
            }
            <tr>
                <td>{__("shipping")}</td>
                <td data-ct-checkout-summary="shipping" class="text-right">
                    <span>{include file="common/price.tpl" value=$cart.display_shipping_cost}</span>
                </td>
            </tr>
            {/if}

            {if ($cart.subtotal_discount|floatval)}
                <tr>
                    <td>{__("order_discount")}</td>
                    <td data-ct-checkout-summary="order-discount" class="text-right">
                        <span>-{include file="common/price.tpl" value=$cart.subtotal_discount}</span>
                    </td>
                </tr>
                {hook name="checkout:discount_summary"}
                {/hook}
            {/if}
            

            {if $cart.payment_surcharge && !$take_surcharge_from_vendor}
                <tr>
                    <td>{$cart.payment_surcharge_title|default:__("payment_surcharge")}</td>
                    <td data-ct-checkout-summary="payment-surcharge" class="text-right">
                        <span>{include file="common/price.tpl" value=$cart.payment_surcharge}</span>
                    </td>
                </tr>
                {math equation="x+y" x=$cart.total y=$cart.payment_surcharge assign="_total"}
            {/if}

            {if $cart.taxes}
                <tr>
                    <td>{__("taxes")}</td>
                    <td></td>
                </tr>
                {foreach from=$cart.taxes item="tax"}
                    <tr>
                        <td data-ct-checkout-summary="tax-name {$tax.description}">
                            <div>{$tax.description} ({include file="common/modifier.tpl" mod_value=$tax.rate_value mod_type=$tax.rate_type}{if $tax.price_includes_tax == "Y" && ($settings.Appearance.cart_prices_w_taxes != "Y" || $settings.General.tax_calculation == "subtotal")} {__("included")}{/if})</div>
                        </td>
                        <td data-ct-checkout-summary="taxes" class="text-right">
                            <span >{include file="common/price.tpl" value=$tax.tax_subtotal}</span>
                        </td>
                    </tr>
                {/foreach}
            {/if}
            
            {hook name="checkout:summary"}
            {/hook}
            <tr>
                <td colspan="2">
                    {include file="views/checkout/components/promotion_coupon.tpl"}
                </td>
            </tr>
            <tr>
                <td data-ct-checkout-summary="order-total">
                    <strong>
                        {__("order_total")}
                    </strong>
                </td>
                <td class="text-right">
                    <strong>{include file="common/price.tpl" value=$_total|default:$cart.total}</strong>
                </td>
            </tr>
        </tbody>
    </table>
<!--checkout_info_summary_{$block.snapping_id}--></div>

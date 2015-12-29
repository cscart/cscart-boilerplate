{if $cart.points_info.in_use}
{assign var="_redirect_url" value=$config.current_url|escape:url}
    <tr class="checkout-summary-order-discount">
        <td class="checkout-summary-item">
            {__("points_in_use")} ({__("points_lowercase", [$cart.points_info.in_use.points])})
        </td>
        <td class="checkout-summary-item discount-price text-right">
            {include file="common/button.tpl" href="checkout.delete_points_in_use?redirect_url=`$_redirect_url`" meta="cm-post  glyphicon glyphicon-remove fa fa-times btn-default" target_id="checkout_totals,subtotal_price_in_points,checkout_steps`$additional_ids`"}
        </td>
    </tr>
{/if}
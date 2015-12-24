{if $cart.points_info.in_use}
    <li class="cart-statistic-item">
        {assign var="_redirect_url" value=$config.current_url|escape:url}
            {if $use_ajax}{assign var="_class" value="cm-ajax"}{/if}
        <span class="cart-statistic-title">{__("points_in_use")}&nbsp;({__("points_lowercase", [$cart.points_info.in_use.points])}){include file="common/button.tpl" href="checkout.delete_points_in_use?redirect_url=`$_redirect_url`" meta="cm-post reward-points__delete-icon" target_id="checkout_totals,subtotal_price_in_points,checkout_steps`$additional_ids`"}</span>
    </li>
{/if}

{if $cart.points_info.reward}
    <li class="cart-statistic-item">
        <span class="cart-statistic-title">{__("points")}</span>
        <span class="cart-statistic-value">+{$cart.points_info.reward}</span>
    </li>
{/if}
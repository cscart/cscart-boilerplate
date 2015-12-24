{if $runtime.mode == "checkout" && $cart_products && $cart.points_info.total_price && $user_info.points > 0}
<div class="right">
    {include file="addons/reward_points/hooks/checkout/payment_options.post.tpl"}
</div>
{/if}

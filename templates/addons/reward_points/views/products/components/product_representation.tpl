{if $product.points_info.price}
<div class="reward-group row">
    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
        <strong>{__("price_in_points")}:</strong>
    </div>
    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7" id="price_in_points_{$obj_prefix}{$obj_id}">{__("points_lowercase", [$product.points_info.price])}</div>
</div>
{/if}

<div class="reward-group product-list-field{if !$product.points_info.reward.amount} hidden{/if}">
    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5"><strong>{__("reward_points")}:</strong></div>
    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7" id="reward_points_{$obj_prefix}{$obj_id}" >{__("points_lowercase", [$product.points_info.reward.amount])}</div>
</div>
{if !$cart.products.$key.extra.configuration}
    {if $cart.products.$key.extra.points_info.price}
    <div class="reward-points-product-info reward-group row">
        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-7">
            <strong>{__("price_in_points")}:</strong>
        </div>
        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-5" id="price_in_points_{$key}">{__("points_lowercase", [$cart.products.$key.extra.points_info.display_price])}</div>
    </div>
    {/if}
    {if $cart.products.$key.extra.points_info.reward}
    <div class="reward-group row">
        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5"><strong>{__("reward_points")}:</strong></div>
        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7" id="reward_points_{$key}">{__("points_lowercase", [$cart.products.$key.extra.points_info.reward])}</div>
    </div>
    {/if}
{/if}
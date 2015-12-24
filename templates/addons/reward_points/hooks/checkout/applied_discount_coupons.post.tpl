{if $cart.points_info.reward}
    <div class="reward-points-info">
        <span>{__("points")}</span>
        <span class="pull-right">{$cart.points_info.reward}</span>
    </div>
{/if}

{if $runtime.mode == "checkout" && $cart_products && $cart.points_info.total_price && $user_info.points > 0}
    <form class="cm-ajax cm-ajax-full-render form" name="point_payment_form" action="{""|fn_url}" method="post">
        <input type="hidden" name="redirect_mode" value="{$location}" />
        <input type="hidden" name="result_ids" value="checkout*,cart_status*" />

        <div class="reward-points-coupon input-group">
            <input type="text" class="from-control cm-hint" name="points_to_use" size="40" value="{__("points_to_use")}" />
            {include file="common/go.tpl" name="checkout.point_payment" alt=__("apply") text=__("apply")}
            <input type="submit" class="hidden" name="dispatch[checkout.point_payment]" value="" />
        </div>
    </form>

    {if $user_info.points}
        <div class="discount-info">
            <span class="caret-info"><span class="caret-outer"></span><span class="caret-inner"></span></span>
            <span class="reward-points-text-point">{__("text_point_in_account")}&nbsp;{__("points_lowercase", [$user_info.points])}.</span>
            
            {if $cart.points_info.in_use.points}
                {assign var="_redirect_url" value=$config.current_url|escape:url}
                {if $use_ajax}{assign var="_class" value="cm-ajax"}{/if}
                <span class="reward-points-points-in-use">
                        {__("points_in_use_lowercase", [$cart.points_info.in_use.points])}.
                        ({include file="common/price.tpl" value=$cart.points_info.in_use.cost})
                        {include file="common/button.tpl" href="checkout.delete_points_in_use?redirect_url=`$_redirect_url`" meta="cm-post" target_id="checkout*,cart_status*,subtotal_price_in_points"}
                </span>
            {/if}
        </div>
    {/if}
{/if}
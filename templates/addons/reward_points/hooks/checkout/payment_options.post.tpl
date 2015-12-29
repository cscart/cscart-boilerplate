{if $cart_products && $cart.points_info.total_price && $user_info.points > 0}
<div class="coupons-container">
    <div id="point_payment" class="code-input discount-coupon">
        <form class="cm-ajax" name="point_payment_form" action="{""|fn_url}" method="post">
            <input type="hidden" name="redirect_mode" value="{$location}" />
            <input type="hidden" name="result_ids" value="checkout_totals,checkout_steps" />
            
            <div class="reward-points-coupon input-group">
                <input type="text" class="form-control cm-hint" name="points_to_use" size="40" value="{__("points_to_use")}" />
                <input type="submit" class="hidden" name="dispatch[checkout.point_payment]" value="" />
                {include file="common/go.tpl" name="checkout.point_payment" alt=__("apply") text=__("apply")}
            </div>
            <div class="popover bottom discount-info">
                <div class="arrow"></div>
                <div class="popover-content">
                    <span class="reward-points-text-point">
                        {__("text_point_in_account")} {__("points_lowercase", [$user_info.points])}.
                    </span>

                    {if $cart.points_info.in_use.points}
                        {assign var="_redirect_url" value=$config.current_url|escape:url}
                        {if $use_ajax}{assign var="_class" value="cm-ajax"}{/if}
                        <span class="reward-points-points-in-use">{__("points_in_use_lowercase", [$cart.points_info.in_use.points])}.&nbsp;({include file="common/price.tpl" value=$cart.points_info.in_use.cost})&nbsp;{include file="common/button.tpl" href="checkout.delete_points_in_use?redirect_url=`$_redirect_url`" meta="cm-post btn-xs" target_id="checkout*,cart_status*,subtotal_price_in_points" icon="glyphicon glyphicon-remove fa fa-times"}</span>
                    {/if}
                </div>
            </div>
        </form>
    </div>
<!--point_payment--></div>
{/if}
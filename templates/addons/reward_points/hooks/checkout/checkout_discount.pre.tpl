{if $cart.points_info.in_use}
    {assign var="_redirect_url" value=$config.current_url|escape:url}
        {if $use_ajax}{assign var="_class" value="cm-ajax"}{/if}
    <dt class="points-in-use">
        {__("points_in_use")}&nbsp;({__("points_lowercase", [$cart.points_info.in_use.points])})
    </dt>
    <dd>
        {include file="common/button.tpl" href="checkout.delete_points_in_use?redirect_url=`$_redirect_url`" meta="cm-post btn-xs" icon="glyphicon-remove fa fa-times-circle-o" target_id="checkout_totals,subtotal_price_in_points,checkout_steps`$additional_ids`"}
    </dd>
{/if}

{if $cart.points_info.reward}
    <dt class="points-info">{__("points")}</dt>
    <dd class="points-info">+{$cart.points_info.reward}</dd>
{/if}
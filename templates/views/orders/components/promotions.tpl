<div class="orders-promotion">
<h3>{__("promotions")}</h3>

{foreach from=$promotions item="promotion" name="pfe" key="promotion_id"}
<h5>{$promotion.name}</h5>

    {foreach from=$order_info.promotions.$promotion_id.bonuses item="bonus"}
    {if $bonus.bonus == "give_coupon"}
    <div class="form-group">
        <label>{__("coupon_code")}:</label>
        {$bonus.coupon_code}
    </div>
    {/if}
    {/foreach}

<div class="orders-promotion-description">{$promotion.short_description nofilter}</div>
{/foreach}
</div>
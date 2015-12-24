{include file="common/letter_header.tpl"}

{__("dear")} {$order_info.firstname},<br /><br />

{__("products_were_sent")}<br /><br />

<strong>{__("order_id")}</strong>:&nbsp;#{$order_info.order_id}<br />
<strong>{__("shipping_method")}</strong>:&nbsp;{$shipment.shipping}<br />
<strong>{__("shipment_date")}</strong>:&nbsp;{$shipment.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}<br />
{if $shipment.carrier}
    {include file="common/carriers.tpl" carrier=$shipment.carrier tracking_number=$shipment.tracking_number}
    <strong>{__("carrier")}</strong>:&nbsp;{$smarty.capture.carrier_name nofilter}<br />
{/if}
{if $shipment.tracking_number}
    <strong>{__("tracking_number")}</strong>:&nbsp;
    {if $smarty.capture.carrier_url}
        <a {if $smarty.capture.carrier_url|strpos:"://"}target="_blank"{/if} href="{$smarty.capture.carrier_url nofilter}">{$shipment.tracking_number}</a>
    {else}
        {$shipment.tracking_number}
    {/if}
    <br /><br />
{/if}

{$smarty.capture.carrier_info nofilter}

<strong>{__("products")}:</strong>
<p>
{foreach from=$shipment.items key="hash" item="amount"}
    {if $amount > 0}
        {$amount}&nbsp;x&nbsp;{$order_info.products.$hash.product}<br />
        {if $order_info.products.$hash.product_options}
            {include file="common/options_info.tpl" product_options=$order_info.products.$hash.product_options}<br />
        {/if}
        <br />
    {/if}
{/foreach}
</p>

{if $shipment.comments}
<br /><br />
<strong>{__("comments")}</strong>:
{$shipment.comments|nl2br nofilter}
{/if}

{include file="common/letter_footer.tpl"}
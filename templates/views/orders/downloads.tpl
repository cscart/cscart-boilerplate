<div class="download">
{if $products}
    {include file="common/pagination.tpl"}
    {foreach from=$products item=dp}
    <a name="{$dp.order_id}_{$dp.product_id}"></a>
    {include file="views/products/download.tpl" product=$dp no_capture=true}
    {/foreach}
    {include file="common/pagination.tpl"}
{else}
    <p class="well well-lg no-items">{__("text_downloads_empty")}</p>
{/if}
{capture name="mainbox_title"}{__("downloads")}{/capture}
</div>
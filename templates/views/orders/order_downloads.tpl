{if $products}
    <div class="btn-group" role="group" aria-label="...">
      <a href="{"orders.downloads"|fn_url}" class="btn btn-default">{__("all_downloads")}</a>
      <a href="{"orders.details?order_id=`$smarty.request.order_id`"|fn_url}" class="btn btn-default">{__("order")} #{$smarty.request.order_id}</a>
    </div>
    {foreach from=$products item=dp}
        {include file="views/products/download.tpl" product=$dp no_capture=true hide_order=true}
    {/foreach}
{else}
    <p class="well well-lg no-items">{__("text_downloads_empty")}</p>
{/if}
{capture name="mainbox_title"}{__("downloads")}: {__("order")|lower} #{$smarty.request.order_id}{/capture}
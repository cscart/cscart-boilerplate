<div id="products_search_{$block.block_id}">

{if $products}
    {assign var="title_extra" value="{__("products_found")}: `$search.total_items`"}
    {assign var="layouts" value=""|fn_get_products_views:false:0}

    {if $layouts.$selected_layout.template}
        {include file="`$layouts.$selected_layout.template`" columns=4 show_qty=true}
    {/if}
{else}
    {hook name="products:search_results_no_matching_found"}
        <p class="no-items">{__("text_no_matching_products_found")}</p>
    {/hook}
{/if}

<!--products_search_{$block.block_id}--></div>

{hook name="products:search_results_mainbox_title"}
{capture name="mainbox_title"}<span class="mainbox-title-left">{__("search_results")}</span><small class="mainbox-title-right pull-right" id="products_search_total_found_{$block.block_id}">{$title_extra nofilter}<!--products_search_total_found_{$block.block_id}--></small>{/capture}
{/hook}
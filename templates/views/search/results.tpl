{assign var="title_extra" value="{__("total_results")}: `$search.total_items`"}

{if $search_results}
    {include file="common/pagination.tpl"}
    
    {foreach from=$search_results item="result"}
    
    {if !$result.first}<hr />{/if}
    
    {hook name="search:search_results"}
    {if $result.object == "products"}
        {include file="views/products/components/one_product.tpl" product=$result key=$result.id}
    
    {elseif $result.object == "pages"}
        {include file="views/pages/components/one_page.tpl" page=$result}
    {/if}
    {/hook}
    
    {/foreach}
    
    {include file="common/pagination.tpl"}

{else}
    <p class="well well-lg no-items">{__("text_no_matching_results_found")}</p>
{/if}

{capture name="mainbox_title"}<span class="mainbox-title-left">{__("search_results")}</span><span class="mainbox-title-right">{$title_extra nofilter}</span>{/capture}
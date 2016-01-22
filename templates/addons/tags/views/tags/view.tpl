{if $addons.tags.tags_for_products == "Y" && $products}

    <h4>{__("products")}</h4>
    
    {assign var="layouts" value=""|fn_get_products_views:false:0}
    
    {if $layouts.$selected_layout.template}
        {include file="`$layouts.$selected_layout.template`" columns=4}
    {/if}
{/if}

{if $addons.tags.tags_for_pages == "Y" && $pages}
    <h3>{__("pages")}</h3>

    <ul class="list-inline">
        {foreach from=$pages item="page"}
        <li><a href="{"pages.view?page_id=`$page.page_id`"|fn_url}">{$page.page}</a></li>
        {/foreach}
    </ul>
{/if}

{hook name="tags:view"}{/hook}

{if !$tag_objects_exist}
<p class="well well-lg">{__("no_data")}</p>
{/if}

{capture name="mainbox_title"}{$page_title}{/capture}
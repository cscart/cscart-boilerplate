<div class="sitemap">
    <div class="sitemap-section clearfix">
        <h4>{__("cart_info")}</h4>
        <div class="col-lg-4">
            {if $sitemap_settings.show_site_info == "Y"}
                <h5>{__("information")}</h5>
                <ul class="list-unstyled">
                    {include file="views/pages/components/pages_tree.tpl" tree=$sitemap.pages_tree root=true no_delim=true}
                </ul>
            {/if}
        </div>
            <div class="col-lg-4">
            {if $sitemap.custom}
                {foreach from=$sitemap.custom item=section key=name}
                    <h5>{$name}</h5>
                    <ul class="list-unstyled">
                        {foreach from=$section item=link}
                            <li><a href="{$link.link_href|fn_url}">{$link.link}</a></li>
                        {/foreach}
                    </ul>
                {/foreach}
            {/if}
        </div>
    </div>
    <hr>
    <div class="sitemap-section clearfix">
        <h4>{__("catalog")}</h4>
        <div class="sitemap-tree">
            {if $sitemap.categories || $sitemap.categories_tree}
                {if $sitemap.categories}
                    <ul class="sitemap-tree-list">
                        {foreach from=$sitemap.categories item=category}
                            <li><a href="{"categories.view?category_id=`$category.category_id`"|fn_url}">{$category.category}</a></li>
                        {/foreach}
                    </ul>
                {/if}
                {if $sitemap.categories_tree}
                    {include file="views/sitemap/components/categories_tree.tpl" all_categories_tree=$sitemap.categories_tree background="white"}
                {/if}
            {/if}
        </div>
    </div>
</div>
{capture name="mainbox_title"}{__("sitemap")}{/capture}
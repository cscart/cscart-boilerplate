{assign var="_title" value=$category_data.category|default:__("vendor_products")}

<div id="products_search_{$block.block_id}">
    {if $subcategories or $category_data.description || $category_data.main_pair}
        {math equation="ceil(n/c)" assign="rows" n=$subcategories|count c=$columns|default:"2"}
        {split data=$subcategories size=$rows assign="splitted_subcategories"}

    {if $category_data.description && $category_data.description != ""}
        <div class="wysiwyg-content">{$category_data.description nofilter}</div>
    {/if}

        {if $subcategories}
            <ul class="subcategories clearfix">
            {foreach from=$splitted_subcategories item="ssubcateg"}
                {foreach from=$ssubcateg item=category name="ssubcateg"}
                    {if $category}
                        <li class="subcategories-item">
                            <a href="{"companies.products?category_id=`$category.category_id`&company_id=$company_id"|fn_url}">
                            {if $category.main_pair}
                                {include file="common/image.tpl"
                                    show_detailed_link=false
                                    images=$category.main_pair
                                    no_ids=true
                                    image_id="category_image"
                                    image_width=$settings.Thumbnails.category_lists_thumbnail_width
                                    image_height=$settings.Thumbnails.category_lists_thumbnail_height
                                    class="subcategories-img"
                                }
                            {/if}
                            {$category.category}
                            </a>
                        </li>
                    {/if}
                {/foreach}
            {/foreach}
            </ul>
        {/if}
    {/if}

    {if $products}
        {assign var="title_extra" value="{__("products_found")}: `$search.total_items`"}
        {assign var="layouts" value=""|fn_get_products_views:false:0}
        {if $category_data.product_columns}
            {assign var="product_columns" value=$category_data.product_columns}
        {else}
            {assign var="product_columns" value=$settings.Appearance.columns_in_products_list}
        {/if}

        {if $layouts.$selected_layout.template}
            {include file="`$layouts.$selected_layout.template`" columns=$product_columns show_qty=true}
        {/if}
    {elseif !$subcategories}
        {hook name="products:search_results_no_matching_found"}
            <p class="well well-lg no-items">{__("text_no_matching_products_found")}</p>
        {/hook}
    {/if}

<!--products_search_{$block.block_id}--></div>

{hook name="products:search_results_mainbox_title"}
{capture name="mainbox_title"}<span>{$_title}</span><small class="pull-right" id="products_search_total_found_{$block.block_id}">{$title_extra nofilter}<!--products_search_total_found_{$block.block_id}--></small>{/capture}
{/hook}
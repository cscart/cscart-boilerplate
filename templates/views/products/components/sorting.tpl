<div class="panel panel-default sorting">
    <div class="panel-body">
    {if !$config.tweaks.disable_dhtml}
        {assign var="ajax_class" value="cm-ajax"}
    {/if}

    {assign var="curl" value=$config.current_url|fn_query_remove:"sort_by":"sort_order":"result_ids":"layout"}
    {assign var="sorting" value=""|fn_get_products_sorting}
    {assign var="sorting_orders" value=""|fn_get_products_sorting_orders}
    {assign var="layouts" value=""|fn_get_products_views:false:false}
    {assign var="pagination_id" value=$id|default:"pagination_contents"}
    {assign var="avail_sorting" value=$settings.Appearance.available_product_list_sortings}

    {if $search.sort_order_rev == "asc"}
        {capture name="sorting_text"}
            <a>{$sorting[$search.sort_by].description}<i class="glyphicon glyphicon-triangle-top fa fa-caret-up"></i></a>
        {/capture}
    {else}
        {capture name="sorting_text"}
            <a>{$sorting[$search.sort_by].description}<i class="glyphicon glyphicon-triangle-top fa fa-caret-down"></i></a>
        {/capture}
    {/if}

    {if !(($category_data.selected_views|count == 1) || ($category_data.selected_views|count == 0 && ""|fn_get_products_views:true|count <= 1)) && !$hide_layouts}
        <div class="sorting-icons pull-right">
            {foreach from=$layouts key="layout" item="item"}
                {if ($category_data.selected_views.$layout) || (!$category_data.selected_views && $item.active)}
                    {if $layout == $selected_layout}
                        {$sort_order = $search.sort_order_rev}
                    {else}
                        {$sort_order = $search.sort_order}
                    {/if}
                    <a class="btn btn-default {$ajax_class} {if $layout == $selected_layout}active{/if}" data-ca-target-id="{$pagination_id}" href="{"`$curl`&sort_by=`$search.sort_by`&sort_order=`$sort_order`&layout=`$layout`"|fn_url}" rel="nofollow">
                        {if $layout == 'products_multicolumns'}
                            <i class="glyphicon glyphicon-th-large fa fa-th-large"></i>
                        {elseif $layout == 'products_without_options'}
                            <i class="glyphicon glyphicon-th-list fa fa-th-list"></i>
                        {elseif $layout == 'short_list'}
                            <i class="glyphicon glyphicon-align-justify fa fa-bars"></i>
                        {/if}
                    </a>
                {/if}
            {/foreach}
        </div>
    {/if}

    {if $avail_sorting}
        {include file="common/sorting.tpl"}
    {/if}

    {assign var="pagination" value=$search|fn_generate_pagination}

    {if $pagination.total_items}
    {assign var="range_url" value=$curl|fn_query_remove:"items_per_page":"page"}
    {assign var="product_steps" value=$settings.Appearance.columns_in_products_list|fn_get_product_pagination_steps:$settings.Appearance.products_per_page}
        <div class="btn-group">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                {$pagination.items_per_page} {__("per_page")} <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                {foreach from=$product_steps item="step"}
                {if $step != $pagination.items_per_page}
                    <li>
                        <a class="{$ajax_class}" href="{"`$range_url`&items_per_page=`$step`"|fn_url}" data-ca-target-id="{$pagination_id}" rel="nofollow">{$step} {__("per_page")}</a>
                    </li>
                {/if}
                {/foreach}
            </ul>
        </div>
    {/if}
    </div>
</div>
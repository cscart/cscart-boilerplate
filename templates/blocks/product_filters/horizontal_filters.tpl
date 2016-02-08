{** block-description:horizontal_filters **}

{script src="js/tygh/product_filters.js"}

{if $block.type == "product_filters"}
    {$ajax_div_ids = "product_filters_*,products_search_*,category_products_*,product_features_*,breadcrumbs_*,currencies_*,languages_*,selected_filters_*"}
    {$curl = $config.current_url}
{else}
    {$curl = "products.search"|fn_url}
    {$ajax_div_ids = ""}
{/if}

{$filter_base_url = $curl|fn_query_remove:"result_ids":"full_render":"filter_id":"view_all":"req_range_id":"features_hash":"subcats":"page":"total"}
<div class="panel panel-default horizontal-product-filters cm-product-filters cm-horizontal-filters" data-ca-target-id="{$ajax_div_ids}" data-ca-base-url="{$filter_base_url|fn_url}" id="product_filters_{$block.block_id}">
    <div class="panel-body">
    {if $items}
        <ul class="list-inline">
        {foreach from=$items item="filter" name="filters"}

            {$filter_uid = "`$block.block_id`_`$filter.filter_id`"}

            {$reset_url = ""}
            {if $filter.selected_variants || $filter.selected_range}
                {$reset_url = $filter_base_url}
                {$fh = $smarty.request.features_hash|fn_delete_filter_from_hash:$filter.filter_id}
                {if $fh}
                    {$reset_url = $filter_base_url|fn_link_attach:"features_hash=$fh"}
                {/if}
            {/if}
            <li>
                <div class="dropdown">
                    <div class="btn-group">
                        <div class="btn-group">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdown_filter_{$block.block_id}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                {$filter.filter}{if $filter.selected_variants} ({$filter.selected_variants|sizeof}){/if}
                                <span class="caret"></span>
                            </button>
                            
                            <div class="dropdown-menu" aria-labelledby="dropdown_filter_{$block.block_id}">
                                <div class="form">
                                    {$filter_uid="`$block.block_id`_`$filter.filter_id`"}
                                    {if $filter.slider}
                                        {if $filter.feature_type == "ProductFeatures::DATE"|enum}
                                            {include file="blocks/product_filters/components/product_filter_datepicker.tpl" filter_uid=$filter_uid filter=$filter}
                                        {else}
                                            {include file="blocks/product_filters/components/product_filter_slider.tpl" filter_uid=$filter_uid filter=$filter}
                                        {/if}
                                    {else}
                                        {include file="blocks/product_filters/components/product_filter_variants.tpl" filter_uid=$filter_uid filter=$filter}
                                    {/if}
                                    <div class="product-filters-tools clearfix">
                                        {include file="common/button.tpl" text=__("close") meta="cm-external-click btn-default" external_click_id="sw_elm_filter_`$filter.filter_id`" as="link"}
                                    </div>
                                </div>
                            </div>
                        </div>
                        {if $reset_url}
                            <a class="btn btn-default cm-ajax cm-ajax-full-render cm-history" href="{$reset_url|fn_url}" data-ca-event="ce.filtersinit" data-ca-target-id="{$ajax_div_ids}">
                                <i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                            </a>
                        {/if}
                    </div>
                </div>
            </li>

        {/foreach}
        </ul>
    {/if}
</div>
<!--product_filters_{$block.block_id}--></div>
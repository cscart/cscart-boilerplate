{** block-description:selected_filters **}
{$show_panel = false}

{foreach from=$items item="filter"}
    {if $filter.selected_variants || $filter.selected_range}
        {$show_panel = true}
        {break}
    {/if}
{/foreach}

{if $show_panel}

{$ajax_div_ids = "product_filters_*,products_search_*,category_products_*,product_features_*,breadcrumbs_*,currencies_*,languages_*,selected_filters_*"}
{$curl = $config.current_url}
{$filter_base_url = $curl|fn_query_remove:"result_ids":"full_render":"filter_id":"view_all":"req_range_id":"features_hash":"subcats":"page":"total"}
<div class="panel panel-default horizontal-product-filters cm-product-filters cm-horizontal-filters" id="selected_filters_{$block.block_id}">
    <div class="panel-body">
    {foreach from=$items item="filter"}

        {if $filter.selected_variants || $filter.selected_range}

        {$reset_url = $filter_base_url}
        {$fh = $smarty.request.features_hash|fn_delete_filter_from_hash:$filter.filter_id}
        
        {if $fh}
            {$reset_url = $filter_base_url|fn_link_attach:"features_hash=$fh"}
        {/if}

        <div class="{if $filter.selected_variants || $filter.selected_range} active{/if}">
            <div class="dropdown">
                <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                    {$filter.filter}{if $filter.selected_variants} ({$filter.selected_variants|sizeof}){/if}
                    <a class="cm-ajax cm-ajax-full-render cm-history" href="{$reset_url|fn_url}" data-ca-event="ce.filtersinit" data-ca-target-id="{$ajax_div_ids}">
                        <i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                    </a>
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu cm-horizontal-filters-content">
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
                </ul>
            </div>
        </div>
        {/if}

    {/foreach}
    </div>
<!--selected_filters_{$block.block_id}--></div>
{/if}

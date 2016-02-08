{** block-description:original **}

{script src="js/tygh/product_filters.js"}

{if $block.type == "product_filters"}
    {$ajax_div_ids = "product_filters_*,products_search_*,category_products_*,product_features_*,breadcrumbs_*,currencies_*,languages_*,selected_filters_*"}
    {$curl = $config.current_url}
{else}
    {$curl = "products.search"|fn_url}
    {$ajax_div_ids = ""}
{/if}

{$filter_base_url = $curl|fn_query_remove:"result_ids":"full_render":"filter_id":"view_all":"req_range_id":"features_hash":"subcats":"page":"total"}
<div class="cm-product-filters" data-ca-target-id="{$ajax_div_ids}" data-ca-base-url="{$filter_base_url|fn_url}" id="product_filters_{$block.block_id}">
    <div class="product-filters panel panel-default">
        {if $items}
            <ul class="list-group product-filters-block">
                {foreach from=$items item="filter" name="filters"}
                    {hook name="blocks:product_filters_variants"}
                    {assign var="filter_uid" value="`$block.block_id`_`$filter.filter_id`"}
                    {assign var="cookie_name_show_filter" value="content_`$filter_uid`"}
                    {if $filter.display == "N"}
                        {* default behaviour of cm-combination *}
                        {assign var="collapse" value=true}
                        {if $smarty.cookies.$cookie_name_show_filter}
                            {assign var="collapse" value=false}
                        {/if}
                    {else}
                        {* reverse behaviour of cm-combination *}
                        {assign var="collapse" value=false}
                        {if $smarty.cookies.$cookie_name_show_filter}
                            {assign var="collapse" value=true}
                        {/if}
                    {/if}

                    {$reset_url = ""}
                    {if $filter.selected_variants || $filter.selected_range}
                        {$reset_url = $filter_base_url}
                        {$fh = $smarty.request.features_hash|fn_delete_filter_from_hash:$filter.filter_id}
                        {if $fh}
                            {$reset_url = $filter_base_url|fn_link_attach:"features_hash=$fh"}
                        {/if}
                    {/if}

                        <li class="list-group-item">
                            <div id="sw_content_{$filter_uid}" class="cm-combination-filter_{$filter_uid}{if !$collapse} open{/if} cm-save-state {if $filter.display == "Y"}cm-ss-reverse{/if} cursor-pointer">
                                <i class="product-filter-switch-icon pull-right switch-icon glyphicon glyphicon-triangle-bottom fa fa-caret-down"></i>
                                <h5 class="product-filters-title">
                                    {$filter.filter}{if $filter.selected_variants} ({$filter.selected_variants|sizeof}){/if}{if $reset_url}
                                    <a class="cm-ajax cm-ajax-full-render cm-history" href="{$reset_url|fn_url}" data-ca-event="ce.filtersinit" data-ca-target-id="{$ajax_div_ids}" data-ca-scroll=".mainbox-title">
                                            <i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                                    </a>
                                    {/if}
                                </h5>
                            </div>

                        {if $filter.slider}
                            {if $filter.feature_type == "ProductFeatures::DATE"|enum}
                                {include file="blocks/product_filters/components/product_filter_datepicker.tpl" filter_uid=$filter_uid filter=$filter}
                            {else}
                                {include file="blocks/product_filters/components/product_filter_slider.tpl" filter_uid=$filter_uid filter=$filter}
                            {/if}
                        {else}
                            {include file="blocks/product_filters/components/product_filter_variants.tpl" filter_uid=$filter_uid filter=$filter collapse=$collapse}
                        {/if}
                        </li>
                    {/hook}
                {/foreach}
            </ul>

            {if $ajax_div_ids}
            <div class="product-filter-tools">
                <a href="{$filter_base_url|fn_url}" rel="nofollow" class="cm-ajax cm-ajax-full-render cm-history" data-ca-event="ce.filtersinit" data-ca-scroll=".mainbox-title" data-ca-target-id="{$ajax_div_ids}">
                    <i class="glyphicon glyphicon-repeat fa fa-refresh"></i>
                    {__("reset")}
                </a>
            </div>
            {/if}

        {/if}
    </div>
<!--product_filters_{$block.block_id}--></div>

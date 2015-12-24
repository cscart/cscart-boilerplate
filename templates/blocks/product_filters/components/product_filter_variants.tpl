<ul class="product-filter list-unstyled {if $collapse}hidden{/if}" id="content_{$filter_uid}">

    {if $filter.display_count && $filter.variants|count > $filter.display_count}
    <li>
        {script src="js/tygh/filter_table.js"}
        <div class="form-group">
            <i class="product-filter-search-icon glyphicon glyphicon-remove-sign fa fa-times-circle hidden" id="elm_search_clear_{$filter_uid}" title="{__("clear")}"></i>
            <input type="text" placeholder="{__("search")}" class="cm-autocomplete-off form-control" name="q" id="elm_search_{$filter_uid}" value="" />
        </div>
    </li>
    {/if}

    {* Selected variants *}
    {foreach from=$filter.selected_variants key="variant_id" item="variant"}
        <li class="cm-product-filters-checkbox-container product-filters-group">
            <label class="checkbox"><input class="cm-product-filters-checkbox" type="checkbox" name="product_filters[{$filter.filter_id}]" data-ca-filter-id="{$filter.filter_id}" value="{$variant.variant_id}" id="elm_checkbox_{$filter_uid}_{$variant.variant_id}" checked="checked">{$filter.prefix}{$variant.variant|fn_text_placeholders}{$filter.suffix}</label>
        </li>
    {/foreach}

    {if $filter.variants}
        <li class="product-filters-item-more">
            <ul id="ranges_{$filter_uid}" {if $filter.display_count}style="max-height: {$filter.display_count * 2}em;"{/if} class="product-filter-variants list-unstyled cm-filter-table" data-ca-input-id="elm_search_{$filter_uid}" data-ca-clear-id="elm_search_clear_{$filter_uid}" data-ca-empty-id="elm_search_empty_{$filter_uid}">

                {foreach from=$filter.variants item="variant"}
                <li class="checkbox">
                    <label {if $variant.disabled}class="disabled"{/if}>
                        <input class="cm-product-filters-checkbox" type="checkbox" name="product_filters[{$filter.filter_id}]" data-ca-filter-id="{$filter.filter_id}" value="{$variant.variant_id}" id="elm_checkbox_{$filter_uid}_{$variant.variant_id}" {if $variant.disabled}disabled="disabled"{/if}>{$filter.prefix}{$variant.variant|fn_text_placeholders}{$filter.suffix}
                    </label>
                </li>
                {/foreach}
            </ul>
            <p id="elm_search_empty_{$filter_uid}" class="product-filters-no-items-found hidden">{__("no_items_found")}</p>
        </li>
    {/if}
</ul>

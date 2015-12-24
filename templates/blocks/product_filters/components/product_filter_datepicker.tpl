{$min = $filter.min}
{$max = $filter.max}
{$left = $filter.left|default:$min}
{$right = $filter.right|default:$max}

<div class="cm-product-filters-checkbox-container {if $collapse}hidden{/if}" id="content_{$filter_uid}">

{include
    file="common/daterange_picker.tpl"
    id="range_`$filter_uid`"
    start_date=$left
    end_date=$right

    data_event="ce.filterdate"}

<input id="elm_checkbox_range_{$filter_uid}"
       data-ca-filter-id="{$filter.filter_id}"
       class="cm-product-filters-checkbox hidden"
       type="checkbox"
       name="product_filters[{$filter.filter_id}]" value="" />
</div>
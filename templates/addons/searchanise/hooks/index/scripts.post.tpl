{if $searchanise_api_key && $searchanise_import_status == "done"}
{if "HTTPS"|defined}
    {assign var="se_servise_url" value=$smarty.const.SE_SERVICE_URL|replace:'http://':'https://'}
{else}
    {assign var="se_servise_url" value=$smarty.const.SE_SERVICE_URL}
{/if}
{literal}
<style type="text/css">
div.snize-ac-results{
    margin-left:15px !important;
}
#search_input.snize-ac-loading{
    background-position:90% center !important;
}
</style>
{/literal}
<script type="text/javascript">
    Searchanise = {ldelim}{rdelim};
    Searchanise.host = '{$se_servise_url}';
    Searchanise.api_key = '{$searchanise_api_key}';

    Searchanise.AutoCmpParams = {ldelim}{rdelim};
    Searchanise.AutoCmpParams.restrictBy = {ldelim}{rdelim};
    Searchanise.AutoCmpParams.restrictBy.status = 'A';
    Searchanise.AutoCmpParams.restrictBy.empty_categories = 'N';
    Searchanise.AutoCmpParams.restrictBy.usergroup_ids = '{'|'|join:$auth.usergroup_ids}';
    Searchanise.AutoCmpParams.restrictBy.category_usergroup_ids = '{'|'|join:$auth.usergroup_ids}';
{if $searchanise_prices}
    Searchanise.AutoCmpParams.union = {ldelim}{rdelim};
    Searchanise.AutoCmpParams.union.price = {ldelim}{rdelim};
    Searchanise.AutoCmpParams.union.price.min = '{$searchanise_prices}';
{/if}
{if $settings.General.inventory_tracking == 'Y' && $settings.General.show_out_of_stock_products == 'N' && $smarty.const.AREA == 'C'}
    Searchanise.AutoCmpParams.restrictBy.amount = '1,';
{/if}
{if $se_active_companies|fn_strlen}
    Searchanise.AutoCmpParams.restrictBy.company_id = '{$se_active_companies}';
{/if}
    Searchanise.options = {ldelim}{rdelim};
    Searchanise.options.LabelSuggestions = '{__("se_popular_suggestions")}';
    Searchanise.options.LabelProducts = '{__("se_products")}';
    Searchanise.options.PriceFormat = {ldelim}rate : {$currencies[$secondary_currency].coefficient}, decimals: {$currencies[$secondary_currency].decimals}, decimals_separator: '{$currencies[$secondary_currency].decimals_separator nofilter}', thousands_separator: '{$currencies[$secondary_currency].thousands_separator nofilter}', symbol: '{$currencies[$secondary_currency].symbol nofilter}', after: {if $currencies[$secondary_currency].after == 'N'}false{else}true{/if}{rdelim};
    Searchanise.AdditionalSearchInputs = '#additional_search_input';
    Searchanise.SearchInput = '#search_input';

    Tygh.$.ceEvent('on', 'ce.commoninit', function(context) {
        // Re-initialize Searchanise widget if its search input was updated after AJAX request
        if (typeof(Searchanise) !== 'undefined' && typeof(Searchanise.SetOptions) === 'function' && Tygh.$(Searchanise.SearchInput, context).length) {
            Searchanise.SetOptions({ SearchInput: Tygh.$(Searchanise.SearchInput) });
            Searchanise.AutocompleteClose();
            Searchanise.Start();
        }
    });

    (function() {
        var __se = document.createElement('script');
        __se.src = '{$se_servise_url}/widgets/v1.0/init.js';
        __se.setAttribute('async', 'true');
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(__se, s);
    })();
</script>

{/if}
<script type="text/javascript">
    Tygh.$(document).ready(function() {
        Tygh.$.get('{'searchanise.async?no_session=Y&is_ajax=3'|fn_url:'C':'current' nofilter}');
    });
</script>

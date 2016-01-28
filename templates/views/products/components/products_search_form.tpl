{capture name="section"}

<form action="{""|fn_url}" name="advanced_search_form" method="get" class="{$form_meta}">
<input type="hidden" name="search_performed" value="Y" />

{if $put_request_vars}
    {array_to_fields data=$smarty.request skip=["callback"]}
{/if}

{$search_extra nofilter}

{hook name="products:search_query_input"}
<div class="form-group row">
    <label for="match" class="control-label col-lg-12">{__("find_results_with")}</label>
    <div class="col-lg-6">
        <select name="match" id="match" class="form-control">
            <option {if $search.match == "any"}selected="selected"{/if} value="any">{__("any_words")}</option>
            <option {if $search.match == "all"}selected="selected"{/if} value="all">{__("all_words")}</option>
            <option {if $search.match == "exact"}selected="selected"{/if} value="exact">{__("exact_phrase")}</option>
        </select>
    </div>
    <div class="col-lg-6">
        <input type="text" name="q" size="38" value="{$search.q}" class="form-control" />
    </div>
</div>

<div class="form-group">
    <label class="control-label">{__("search_in")}</label>
    <div class="checkbox">
        <input type="hidden" name="pname" value="N" />
        <label for="pname" class="control-label">
            <input type="checkbox" value="Y" {if $search.pname == "Y" || !$search.pname}checked="checked"{/if} name="pname" id="pname" />{__("product_name")}
        </label>

        <label for="pshort" class="control-label">
            <input type="checkbox" value="Y" {if $search.pshort == "Y"}checked="checked"{/if} name="pshort" id="pshort" />{__("short_description")}
        </label>

        <label for="pfull" class="control-label">
            <input type="checkbox" value="Y" {if $search.pfull == "Y"}checked="checked"{/if} name="pfull" id="pfull" />{__("full_description")}
        </label>

        <label for="pkeywords" class="control-label">
            <input type="checkbox" value="Y" {if $search.pkeywords == "Y"}checked="checked"{/if} name="pkeywords" id="pkeywords" />{__("keywords")}
        </label>
        {hook name="products:search_in"}{/hook}
    </div>
</div>
{/hook}
<div class="form-group row">
    <label class="control-label col-lg-12">{__("search_in_category")}</label>
    <div class="col-lg-5">
        {assign var="all_categories" value=0|fn_get_plain_categories_tree:false}
        <select name="cid" class="form-control">
            <option value="0" {if $category_data.parent_id == "0"}selected{/if}>- {__("all_categories")} -</option>
            {foreach from=$all_categories item="cat"}
            <option value="{$cat.category_id}" {if $cat.disabled}disabled="disabled"{/if}{if $search.cid == $cat.category_id} selected="selected"{/if} title="{$cat.category}">{$cat.category|escape|truncate:50:"...":true|indent:$cat.level:"&#166;&nbsp;&nbsp;&nbsp;&nbsp;":"&#166;--&nbsp;" nofilter}</option>
            {/foreach}
        </select>
    </div>
    <div class="checkbox col-lg-5">
        <input type="hidden" name="subcats" value="N" />
        <label for="subcats" class="control-label">
            <input type="checkbox" value="Y"{if $search.subcats == "Y" || !$search.subcats} checked="checked"{/if} name="subcats" id="subcats"/>
            {__("search_in_subcategories")}
        </label>
    </div>
</div>

{if !$simple_search_form}
    <h3>{__("advanced_search_options")}</h3>
    <div class="form-group">
        <input type="hidden" name="company_id" id="company_id" value="{$search.company_id|default:''}" />
        {if "MULTIVENDOR"|fn_allowed_for}
            {include file="common/ajax_select_object.tpl" label=__("search_by_vendor") data_url="companies.get_companies_list?show_all=Y&search=Y" text=$search.company_id|fn_get_company_name|default:__("all_vendors") result_elm="company_id" id="company_id_selector"}
        {/if}
    </div>

    <div class="form-group">
        <label for="pcode" class="control-label">{__("search_by_sku")}</label>
        <input type="text" name="pcode" id="pcode" value="{$search.pcode}" onfocus="this.select();" class="form-control" size="30" />
    </div>

    <div class="form-group">
        <label for="price_from" class="control-label">{__("search_by_price")}&nbsp;({$currencies.$primary_currency.symbol nofilter})</label>
        <input type="text" name="price_from" id="price_from" value="{$search.price_from}" onfocus="this.select();" class="form-control" size="30" />&nbsp;-&nbsp;<input type="text" name="price_to" value="{$search.price_to}" onfocus="this.select();" class="form-control" size="30" />
    </div>

    <div class="form-group">
        <label for="weight_from" class="control-label">{__("search_by_weight")}&nbsp;({if $config.localization.weight_symbol}{$config.localization.weight_symbol}{else}{$settings.General.weight_symbol}{/if})</label>
        <input type="text" name="weight_from" id="weight_from" value="{$search.weight_from}" onfocus="this.select();" class="form-control" size="30" />&nbsp;-&nbsp;<input type="text" name="weight_to" value="{$search.weight_to}" onfocus="this.select();" class="form-control" size="30" />
    </div>
{/if}

<div class="buttons-container">
    {include file="common/button.tpl" text=__("search") meta="btn-default" name="dispatch[`$dispatch`]"}  {__("or")}  <a class="btn btn-primary cm-reset-link">{__("reset")}</a>
</div>

</form>

{/capture}
{include file="common/section.tpl" section_title=__("search_options") section_content=$smarty.capture.section class="search-form"}

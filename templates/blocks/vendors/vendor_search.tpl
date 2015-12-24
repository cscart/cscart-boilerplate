{** block-description:block_vendor_search **}
<form action="{""|fn_url}" name="search_form" method="get">
    <input type="hidden" name="subcats" value="Y" />
    <input type="hidden" name="pcode_from_q" value="Y" />
    <input type="hidden" name="status" value="A" />
    <input type="hidden" name="pshort" value="Y" />
    <input type="hidden" name="pfull" value="Y" />
    <input type="hidden" name="pname" value="Y" />
    <input type="hidden" name="pkeywords" value="Y" />
    <input type="hidden" name="search_performed" value="Y" />
    <input type="hidden" name="company_id" value="{$company_id}" />
    <input type="hidden" name="category_id" value="{$category_data.category_id}" />

    {hook name="vendor_search:additional_fields"}{/hook}

    {strip}
        <div  class="input-group">
            <input type="text" name="q" value="{$search.q}" title="{__("block_vendor_search")}" class="form-control cm-hint" />
            {include file="common/go.tpl" name="companies.products" alt=__("search") icon="glyphicon-search fa fa-search"}
        </div>
    {/strip}
</form>

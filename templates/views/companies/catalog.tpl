{hook name="companies:catalog"}

{assign var="title" value=__("all_vendors")}

{include file="common/pagination.tpl"}

{include file="views/companies/components/sorting.tpl"}

{if $companies}

{foreach from=$companies item=company key=key name="companies"}
{assign var="obj_id" value=$company.company_id}
{assign var="obj_id_prefix" value="`$obj_prefix``$obj_id`"}
{include file="common/company_data.tpl" company=$company show_name=true show_descr=true show_rating=true show_logo=true}
<div class="media company">
    <div class="media-left">
        {assign var="capture_name" value="logo_`$obj_id`"}
        {$smarty.capture.$capture_name nofilter}
        
        {assign var="rating" value="rating_$obj_id"}
        {$smarty.capture.$rating nofilter}
    </div>
    <div class="media-body">
        <h4 class="media-heading">
            {assign var="company_name" value="name_`$obj_id`"}
            {$smarty.capture.$company_name nofilter}
        </h4>
        <p>
            {assign var="company_descr" value="company_descr_`$obj_id`"}
            {$smarty.capture.$company_descr nofilter}
        </p>
    </div>
</div>
{/foreach}

{else}
    <p class="well well-lg no-items">{__("no_items")}</p>
{/if}

{include file="common/pagination.tpl"}

{capture name="mainbox_title"}{$title}{/capture}

{/hook}
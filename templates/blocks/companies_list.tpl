{** block-description:vendors **}

{if $items.companies}
    <ul class="list-unstyled companies-list">
    {foreach from=$items.companies item=v key=k}
        <li><a href="{"companies.products?company_id=`$k`"|fn_url}">{$v}</a></li>
    {/foreach}
    </ul>
    
    <a class="btn btn-default" href="{"companies.catalog"|fn_url}">{__("all_vendors")}</a>
{/if}
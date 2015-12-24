{if $age_warning_type == 'form'}
    {include file="addons/age_verification/views/products/components/form.tpl"}
{else}
    {include file="addons/age_verification/views/products/components/deny.tpl"}
{/if}

{foreach from=$fields item=field}

{assign var="value" value=$user_data|fn_get_profile_field_value:$field}
{if $value}
<div class="info-field {$field.field_name|replace:"_":"-"}">{$value}</div>
{/if}
{/foreach}
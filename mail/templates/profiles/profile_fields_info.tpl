<tr>
    <td colspan="2" class="form-title">{$title|default:"&nbsp;" nofilter}<hr size="1" noshade="noshade" /></td>
</tr>
{foreach from=$fields item=field}
{assign var="value" value=$user_data|fn_get_profile_field_value:$field}
{if $value}
<tr>
    <td class="form-field-caption" width="30%" nowrap="nowrap">{$field.description}:&nbsp;</td>
    <td>
        {$value|default:"-"}
    </td>
</tr>
{/if}
{/foreach}
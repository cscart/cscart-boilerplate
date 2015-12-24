<table cellpadding="0" cellspacing="0" border="0">
<tr>
    <td valign="top">
        <table cellpadding="1" cellspacing="1" border="0" width="100%">
        <tr>
            <td colspan="2" class="form-title">{__("user_account_info")}<hr size="1" noshade></td>
        </tr>
        <tr>
            <td class="form-field-caption" nowrap>{__("email")}:&nbsp;</td>
            <td>{$user_data.email}</td>
        </tr>
        {if $password}
        <tr>
            <td class="form-field-caption" nowrap>{__("password")}:&nbsp;</td>
            <td>{$password}</td>
        </tr>
        {/if}
        {if $settings.General.quick_registration == "Y"}
            <tr>
                <td class="form-field-caption" nowrap>{__("login")} {__("url")}:&nbsp;</td>
                <td>{if $user_data.company_id}{"?company_id=`$user_data.company_id`"|fn_url:'C':'http'}{else}{""|fn_url:'C':'http'}{/if}</td>
            </tr>
        {/if}
        {if !"ULTIMATE:FREE"|fn_allowed_for}
            {if $user_data.usergroups}
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="form-title">{__("usergroups")}<hr size="1" noshade></td>
                </tr>
                {foreach from=$user_data.usergroups item="user_usergroup"}
                    <tr>
                        <td class="form-field-caption" nowrap>{$user_usergroup.usergroup}:&nbsp;</td>
                        <td>{if $user_usergroup.status == 'P'}{__("pending")}{else}{__("active")}{/if}</td>
                    </tr>
                {/foreach}
            {/if}
        {/if}
        {if $settings.General.user_multiple_profiles == 'Y'}
        <tr>
            <td class="form-title">{__("profile_name")}:&nbsp;</td>
            <td>{$user_data.profile_name}</td>
        </tr>
        {/if}
        {if $user_data.tax_exempt == 'Y'}
        <tr>
            <td class="form-title">{__("tax_exempt")}:&nbsp;</td>
            <td>{__("yes")}</td>
        </tr>
        {/if}
        </table>
    </td>    
    <td colspan="2">&nbsp;</td>
</tr>
<tr>
    <td colspan="3">&nbsp;</td>
</tr>
</table>

{assign var="profile_fields" value=$user_data.user_type|fn_get_profile_fields}
{split data=$profile_fields.C size=2 assign="contact_fields" simple=true size_is_horizontal=true}
<table cellpadding="4" cellspacing="0" border="0" width="100%">
{if $profile_fields.C}
    <tr>
        <td valign="top" width="50%">
            <table>
                {include file="profiles/profile_fields_info.tpl" fields=$contact_fields.0 title=__("contact_information")}
            </table>
        </td>
        <td width="1%">&nbsp;</td>
        <td valign="top" width="49%">
            {if $contact_fields.1}
            <table>
                {include file="profiles/profile_fields_info.tpl" fields=$contact_fields.1 title=__("contact_information")}
            </table>
            {/if}
        </td>
    </tr>
{/if}
{if ($profile_fields.B || $profile_fields.S) && $user_data.register_at_checkout != "Y" && !($created && $settings.General.quick_registration == "Y")}
<tr>
    <td valign="top">
    {if $profile_fields.B}
        <p></p>
        <table>
            {include file="profiles/profile_fields_info.tpl" fields=$profile_fields.B title=__("billing_address")}
        </table>
    {else}
        &nbsp;
    {/if}
    </td>
    <td>&nbsp;</td>
    <td valign="top">
    {if $profile_fields.S}
        <p></p>
        <table>
            {include file="profiles/profile_fields_info.tpl" fields=$profile_fields.S title=__("shipping_address")}
        </table>
    {else}
        &nbsp;
    {/if}
    </td>
</tr>
{/if}
</table>

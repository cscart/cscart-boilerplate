{include file="common/letter_header.tpl"}

{__("text_usergroup_activated")}<br>
<p>
<table>
{if $usergroup_ids}
<tr>
    <td>{if $usergroup_ids|sizeof > 1}{__("usergroups")}{else}{__("usergroup")}{/if}:</td>
    <td>
        {foreach from=$usergroup_ids item=u_id name=ugroups}
            <b>{$usergroups.$u_id.usergroup}</b>{if !$smarty.foreach.ugroups.last}, {/if}
        {/foreach}
    </td>
</tr>
{/if}
<tr>
    <td>{__("username")}:</td>
    <td>{$user_data.email}</td>
</tr>
<tr>
    <td>{__("person_name")}:</td>
    <td>{$user_data.firstname}&nbsp;{$user_data.lastname}</td>
</tr>
</table>
</p>
{include file="common/letter_footer.tpl"}
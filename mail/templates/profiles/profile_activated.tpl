{include file="common/letter_header.tpl"}

{__("hello")}&nbsp;{if $user_data.firstname}{$user_data.firstname}{else}{$user_data.user_type|fn_get_user_type_description|lower}{/if},<br /><br />
{__("text_profile_activated")}

{include file="common/letter_footer.tpl"}
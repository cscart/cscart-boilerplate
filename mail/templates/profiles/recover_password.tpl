{include file="common/letter_header.tpl"}

{__("text_confirm_passwd_recovery")}:<br /><br />

<a href="{"auth.recover_password?ekey=`$ekey`"|fn_url:$zone:'http'}">{"auth.recover_password?ekey=`$ekey`"|fn_url:$zone:'http'}</a>

{include file="common/letter_footer.tpl"}
{assign var="escaped_current_url" value=$config.current_url|escape:url}
{if !$auth.user_id}
    <a id="sw_login" {if $settings.Security.secure_storefront == "partial"} rel="nofollow" href="{if $runtime.controller == "auth" && $runtime.mode == "login_form"}{$config.current_url|fn_url}{else}{"auth.login_form?return_url=`$escaped_current_url`"|fn_url}{/if}"{else}class="cm-combination combination-link"{/if}>{__("sign_in")}</a>
{else}
    <a href="{"profiles.update"|fn_url}" class="strong">{if $user_info.firstname && $user_info.lastname}{$user_info.firstname}&nbsp;{$user_info.lastname}{elseif $user_info.firstname}{$user_info.firstname}{else}{$user_info.email}{/if}</a>
    {include file="common/button.tpl" href="auth.logout?redirect_url=`$escaped_current_url`" text=__("sign_out")}
{/if}

{if $settings.Security.secure_storefront != "partial"}
    <div id="login" class="cm-popup-box hidden">
        <div class="login-popup">
        {include file="views/auth/login_form.tpl" style="popup" id="jrpopup"}
        </div>
    </div>
{/if}

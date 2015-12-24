{hook name="buttons:add_to_cart"}
    {assign var="c_url" value=$config.current_url|escape:url}
    {if $settings.General.allow_anonymous_shopping == "allow_shopping" || $auth.user_id}
        {include file="common/button.tpl" id=$id text=$text|default:__("add_to_cart") name=$name onclick=$onclick href=$href target=$target meta="btn-primary cm-form-dialog-closer `$meta`"}
    {else}
        {if $runtime.controller == "auth" && $runtime.mode == "login_form"}
            {assign var="login_url" value=$config.current_url}
        {else}
            {assign var="login_url" value="auth.login_form?return_url=`$c_url`"}
        {/if}

        {include file="common/button.tpl" id=$id text=__("sign_in_to_buy") href=$login_url name=""}
        <p>{__("text_login_to_add_to_cart")}</p>
    {/if}
{/hook}

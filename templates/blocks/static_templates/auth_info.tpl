{if $runtime.controller == "auth"}
    {if $runtime.mode == "login_form"}
        {hook name="auth_info:login_form"}
        <p class="login-info-txt">
            {__("text_login_form")}
            <a href="{"profiles.add"|fn_url}">{__("register_new_account")}</a>
        </p>
        {/hook}
    {elseif $runtime.mode == "recover_password"}
        {hook name="auth_info:recover_password"}
        <h4>{__("text_recover_password_title")}</h4>
        <p class="login-info-txt">{__("text_recover_password")}</p>
        {/hook}
    {/if}
    {hook name="auth_info:extra"}{/hook}
{/if}
{assign var="id" value=$id|default:"main_login"}

{capture name="login"}
    <form name="{$id}_form" action="{""|fn_url}" method="post">
    <input type="hidden" name="return_url" value="{$smarty.request.return_url|default:$config.current_url}" />
    <input type="hidden" name="redirect_url" value="{$config.current_url}" />

        {if $style == "checkout"}
            <h3>{__("returning_customer")}</h3>
        {/if}
        <div class="form-group">
            <label for="login_{$id}" class="cm-required cm-trim cm-email control-label">{__("email")}</label>
            <input type="email" id="login_{$id}" name="user_login" size="30" value="{$config.demo_username}" class="cm-focus form-control" />
        </div>

        <div class="form-group">
            <label for="psw_{$id}" class="cm-required control-label">{__("password")}</label>
            <input type="password" id="psw_{$id}" name="password" size="30" value="{$config.demo_password}" class="form-control" maxlength="32" />
            <a href="{"auth.recover_password"|fn_url}" class=""  tabindex="5">{__("forgot_password_question")}</a>
        </div>

        {if $style == "popup"}
            <div class="form-group">
                <a class="btn btn-success" href="{"profiles.add"|fn_url}" rel="nofollow">{__("register_new_account")}</a>
            </div>
        {/if}

        {include file="common/image_verification.tpl" option="login" align="left"}

        {hook name="index:login_buttons"}
            <div class="buttons-container clearfix">
                <div class="pull-right">
                    {include file="common/button.tpl" text=__("sign_in") name="dispatch[auth.login]" meta="btn-primary"}
                </div>
                <div class="checkbox pull-left">
                    <label for="remember_me_{$id}"><input type="checkbox" name="remember_me" id="remember_me_{$id}" value="Y" />{__("remember_me")}</label>
                </div>
            </div>
        {/hook}
    </form>
{/capture}

{if $style == "popup"}
    {$smarty.capture.login nofilter}
{else}
    <div>
        {$smarty.capture.login nofilter}
    </div>

    {capture name="mainbox_title"}{__("sign_in")}{/capture}
{/if}

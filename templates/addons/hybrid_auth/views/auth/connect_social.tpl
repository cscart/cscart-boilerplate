{assign var="id" value=$id|default:"main_login"}

<div class="connect-social">
    <form name="connect-social" action="{""|fn_url}" method="post">
        <input type="hidden" name="return_url" value="{$smarty.request.return_url|default:$config.current_url}" />
        <input type="hidden" name="redirect_url" value="{$config.current_url}" />
        <input type="hidden" name="user_login" value="{$user_login}" />

        <div class="control-group">
            <label for="login_{$id}" class="login__filed-label control-group__label cm-required cm-trim cm-email">{__("email")}</label>
            <input type="text" id="login_{$id}" name="user_login" size="30" value="{$user_login}" class="login__input"/>
        </div>

        <div class="control-group password-forgot">
            <label for="psw_{$id}" class="login__filed-label control-group__label password-forgot__label cm-required ">{__("password")}</label>
            <input type="password" id="psw_{$id}" name="password" size="30" value="{$config.demo_password}" class="login__input" maxlength="32" />
        </div>

        {include file="common/image_verification.tpl" option="register" align="left" assign="image_verification"}
        {if $image_verification}
            <div class="control-group">
                {$image_verification nofilter}
            </div>
        {/if}

        <div class="buttons-container clearfix">
            <div class="pull-right">
                {include file="common/button.tpl" text=__("sign_in") name="dispatch[auth.login]" meta="btn-primary"}
            </div>
        </div>
    </form>
</div>
{capture name="mainbox_title"}{__("hybrid_auth.connect_social")}{/capture}
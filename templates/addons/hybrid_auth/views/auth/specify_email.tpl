{assign var="id" value=$id|default:"main_login"}

<div class="connect-social">
    <form name="connect-social" action="{""|fn_url}" method="post">
        <input type="hidden" name="return_url" value="{$smarty.request.return_url|default:$config.current_url}" />
        <input type="hidden" name="redirect_url" value="{$redirect_url|default:$config.current_url}" />
        <input type="hidden" name="provider" value="{$provider}" />

        <div class="control-group">
            <label for="login_{$id}" class="login__filed-label control-group__label cm-required cm-trim cm-email">{__("email")}</label>
            <input type="text" id="login_{$id}" name="user_email" size="30" class="login__input"/>
        </div>

        <div class="buttons-container clearfix">
            <div class="pull-right">
                {include file="common/button.tpl" but_text=__("continue") name="dispatch[auth.specify_email]" meta="btn__login"}
            </div>
        </div>
    </form>
</div>
{capture name="mainbox_title"}{__("hybrid_auth.specify_email")}{/capture}
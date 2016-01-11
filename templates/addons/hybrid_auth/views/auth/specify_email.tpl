{assign var="id" value=$id|default:"main_login"}

<div class="connect-social">
    <form name="connect-social" action="{""|fn_url}" method="post" class="form">
        <input type="hidden" name="return_url" value="{$smarty.request.return_url|default:$config.current_url}" />
        <input type="hidden" name="redirect_url" value="{$redirect_url|default:$config.current_url}" />
        <input type="hidden" name="provider" value="{$provider}" />

        <div class="form-group">
            <label for="login_{$id}" class="control-label cm-required cm-trim cm-email">{__("email")}</label>
            <input type="text" id="login_{$id}" name="user_email" size="30" class="form-control"/>
        </div>

        <div class="panel panel-default buttons-container clearfix">
            <div class="panel-body">
                {include file="common/button.tpl" text=__("continue") name="dispatch[auth.specify_email]" meta="btn-default pull-right"}
            </div>
        </div>
    </form>
</div>

{capture name="mainbox_title"}{__("hybrid_auth.specify_email")}{/capture}
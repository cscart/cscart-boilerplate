<div class="recover-password">
	<form name="recoverfrm" action="{""|fn_url}" method="post">
	    <div class="form-group">
	        <label class="cm-trim cm-required control-label" for="login_id">{__("email")}</label>
	        <input type="text" id="login_id" name="user_email" size="30" value="" class="form-control cm-focus" />
	    </div>
	    <div class="buttons-container login-recovery">
	        {include file="common/button.tpl" text=__("reset_password") name="dispatch[auth.recover_password]" meta="btn-primary"}
	    </div>
	</form>
</div>
{capture name="mainbox_title"}{__("recover_password")}{/capture}
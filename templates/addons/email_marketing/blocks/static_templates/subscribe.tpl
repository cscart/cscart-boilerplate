{** block-description:email_marketing.tmpl_subscription **}
{if $addons.email_marketing}
<div class="email-marketing row">
    <form action="{""|fn_url}" method="post" name="subscribe_form">
        <input type="hidden" name="redirect_url" value="{$config.current_url}" />
        <div class="col-lg-4"><h4>{__("stay_connected")}</h4></div>
        <div class="col-lg-6">
            <label class="cm-required cm-email hidden" for="elm_subscr_email{$block.block_id}">{__("email")}</label>
            <div class="input-group">
                <input type="text" name="subscribe_email" id="elm_subscr_email{$block.block_id}" size="20" value="{__("enter_email")}" class="cm-hint form-control" />
                {include file="common/go.tpl" name="em_subscribers.update" alt=__("go")}
            </div>
        </div>
    </form>
</div>
{/if}    

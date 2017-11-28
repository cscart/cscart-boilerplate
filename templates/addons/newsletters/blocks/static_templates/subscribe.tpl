{** block-description:tmpl_subscription **}
{if $addons.newsletters}
<div class="newsletter-block row">
    <form action="{""|fn_url}" method="post" name="subscribe_form">
        <input type="hidden" name="redirect_url" value="{$config.current_url}" />
        <input type="hidden" name="newsletter_format" value="2" />
        <div class="col-lg-4"><h4>{__("stay_connected")}</h4></div>
        <div class="col-lg-6">
            <label class="cm-required cm-email hidden" for="subscr_email{$block.block_id}">{__("email")}</label>
            <div class="input-group">
                <input type="text" name="subscribe_email" id="subscr_email{$block.block_id}" size="20" value="{__("enter_email")}" class="cm-hint form-control" />
                {include file="common/go.tpl" name="newsletters.add_subscriber" alt=__("go")}
            </div>
        </div>
    </form>
</div>
{/if}
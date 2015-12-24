{if $show_subscription_checkbox}
<div class="form-group checkout-terms">
    <label class="checkbox"><input type="checkbox" name="subscribe_customer" value="1" {if $addons.email_marketing.em_checkout_enabled != "Y"}checked="checked"{/if} />{__("email_marketing.text_subscribe")}</label>
</div>

{/if}
<div class="checkout-complete">
    <p>{__("text_order_placed_successfully")}
        {if $order_info}
            {if $order_info.child_ids}
                <a href="{"orders.search?period=A&order_id=`$order_info.child_ids`"|fn_url}">{__("order_details")}</a>.
            {else}
                <a href="{"orders.details?order_id=`$order_info.order_id`"|fn_url}">{__("order_details")}</a>.
            {/if}
        {/if}
    </p>
</div>

{if $order_info && $settings.Checkout.allow_create_account_after_order == "Y" && !$auth.user_id}
<div class="create-account">
    <h3>{__("create_account")}</h3>
    <div class="login">
        <form name="order_register_form" action="{""|fn_url}" method="post">
            <input type="hidden" name="order_id" value="{$order_info.order_id}" />

            <div class="form-group">
                <label for="password1" class="cm-required cm-password control-label">{__("password")}</label>
                <input type="password" id="password1" name="user_data[password1]" size="32" maxlength="32" value="" class="form-control cm-autocomplete-off cm-focus" />
            </div>

            <div class="form-group">
                <label for="password2" class="cm-required cm-password control-label">{__("confirm_password")}</label>
                <input type="password" id="password2" name="user_data[password2]" size="32" maxlength="32" value="" class="cm-autocomplete-off form-control" />
            </div>

            <div class="buttons-container clearfix">
                <p>{include file="common/button.tpl" name="dispatch[checkout.create_profile]" text=__("create")}</p>
            </div>
        </form>
        </div>
    </div>
    <div class="login-info-wrap">
        {hook name="checkout:payment_instruction"}
            {if $order_info.payment_method.instructions}
                <div class="login-info">
                    <h3>{__("payment_instructions")}</h3>
                    <div class="wysiwyg-content">
                        {$order_info.payment_method.instructions nofilter}
                    </div>
                </div>
            {/if}
        {/hook}
    </div>
{else}
    <div class="login-info">
        {hook name="checkout:payment_instruction"}
            {if $order_info.payment_method.instructions}
                <h3>{__("payment_instructions")}</h3>
                <div class="wysiwyg-content">
                    {$order_info.payment_method.instructions nofilter}
                </div>
            {/if}
        {/hook}
    </div>
{/if}

{* place any code you wish to display on this page right after the order has been placed *}
{hook name="checkout:order_confirmation"}
{/hook}

<div class="panel panel-default buttons-container">
    <div class="panel-body">
    {hook name="checkout:complete_button"}
        <div class="pull-left">
            {if $order_info}
                {if $order_info.child_ids}
                    {include file="common/button.tpl" meta="btn-default" text=__("order_details") href="orders.search?period=A&order_id=`$order_info.child_ids`"}
                {else}
                    {include file="common/button.tpl" text=__("order_details") meta="btn-default" href="orders.details?order_id=`$order_info.order_id`"}
                {/if}
            {/if}
            {include file="common/button.tpl" meta="btn-default" text=__("view_orders") href="orders.search"}
        </div>
        <div class="pull-right">
            {include file="common/button.tpl" href=$continue_url|fn_url text=__("continue_shopping")}
        </div>
    {/hook}
    </div>
</div>

{capture name="mainbox_title"}{__("order")}{/capture}
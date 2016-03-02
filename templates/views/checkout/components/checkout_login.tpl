{capture name="checkout_sign_in_login"}
{hook name="checkout:login_form"}
    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
        {include file="views/auth/login_form.tpl" id="checkout_login" style="checkout" result_ids="checkout*,account*"}
    </div>
{/hook}
{/capture}

{capture name="checkout_sign_in_register"}
{hook name="checkout:register_customer"}
    <div class="checkout-register">
        {capture name="register"}
            {if $settings.General.approve_user_profiles != "Y"}
                <div id="register_checkout" class="{if $settings.Checkout.sign_in_default_action != "register"} cm-noscript{/if}">
                    {include file="common/button.tpl" onclick="Tygh.$('.cm-focus').focus();" meta="btn-default cm-combination" id="sw_step_one_register" text=__("register") as="link"}
                </div>
            {/if}
        {/capture}
        
        {capture name="anonymous"}
            {if $settings.Checkout.disable_anonymous_checkout != "Y"}
                <div id="anonymous_checkout" class="{if $settings.Checkout.sign_in_default_action == "register"} cm-noscript{/if}">
                    <form name="step_one_anonymous_checkout_form" class="{$ajax_form}" action="{""|fn_url}" method="post">
                        <input type="hidden" name="result_ids" value="checkout*,account*" />
                        <input type="hidden" name="guest_checkout" value="1" />

                        {if !$contact_fields_filled}
                            <div class="form-group">
                                <label for="guest_email" class="cm-required">{__("email")}</label>
                                <input type="text" id="guest_email" name="user_data[email]" size="32" value="" class="form-control" />
                            </div>
                        {/if}

                        <div>
                            {include file="common/button.tpl" meta="btn btn-success" name="dispatch[checkout.customer_info]" text=__("checkout_as_guest")}
                        </div>
                    </form>
                </div>
            {/if}
        {/capture}

        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            {if $settings.General.approve_user_profiles != "Y" || $settings.Checkout.disable_anonymous_checkout != "Y"}
                <h3>{__("new_customer")}</h3>
            {/if}
            <div class="panel panel-default">
                <ul class="list-unstyled panel-body">
                    {capture name="checkout_new_customer_register"}
                    <li>
                       <div class="radio">
                            <label for="checkout_type_register" class="control-label">
                                <input type="radio" id="checkout_type_register" name="checkout_type" value=""{if $settings.Checkout.sign_in_default_action == "register"} checked="checked"{/if} onclick="fn_show_checkout_buttons('register')" />
                                <strong>{__("register")}</strong><br>
                                {__("create_new_account")}
                            </label>
                        </div>
                    </li>
                    {/capture}

                    {capture name="checkout_new_customer_guest"}
                    {if $settings.Checkout.disable_anonymous_checkout != "Y"}
                        <li>
                            <div class="radio">
                                <label for="checkout_type_guest" class="control-label">
                                    <input type="radio" id="checkout_type_guest" name="checkout_type" value=""{if $settings.Checkout.sign_in_default_action != "register"} checked="checked"{/if} onclick="fn_show_checkout_buttons('guest')" />
                                    <strong>{__("checkout_as_guest")}</strong><br>
                                    {__("create_guest_account")}
                                </label>
                            </div>
                        </li>
                    {/if}
                    {/capture}

                    {if $settings.Checkout.sign_in_default_action == "register"}
                        {$smarty.capture.checkout_new_customer_register nofilter}
                        {$smarty.capture.checkout_new_customer_guest nofilter}
                    {else}
                        {$smarty.capture.checkout_new_customer_guest nofilter}
                        {$smarty.capture.checkout_new_customer_register nofilter}
                    {/if}
                </ul>
            </div>
            {$smarty.capture.register nofilter}
            {$smarty.capture.anonymous nofilter}
        </div>
        
    </div>
{/hook}
{/capture}

{if $settings.Checkout.configure_sign_in_step == "returning_customer_first"}
    {$smarty.capture.checkout_sign_in_login nofilter}
    {$smarty.capture.checkout_sign_in_register nofilter}
{else}
    {$smarty.capture.checkout_sign_in_register nofilter}
    {$smarty.capture.checkout_sign_in_login nofilter}
{/if}

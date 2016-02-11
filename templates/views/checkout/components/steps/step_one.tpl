<div class="panel panel-default" data-ct-checkout="user_info" id="step_one">
    <div class="panel-heading">
        {if $complete && !$edit}
            {hook name="checkout:step_one_edit_link"}
            {include file="common/button.tpl" meta="btn-default pull-right cm-ajax" href="checkout.checkout?edit_step=step_one&from_step={$cart.edit_step}" target_id="checkout_*" text=__("change")}
            {/hook}
        {/if}
        <h4>
            <span class="label label-default">{if !$complete || $edit}{$number_of_step}{else}<i class="glyphicon glyphicon-ok fa fa-check"></i>{/if}</span>
            {if ($settings.Checkout.disable_anonymous_checkout == "Y" && !$auth.user_id) || ($settings.Checkout.disable_anonymous_checkout != "Y" && !$auth.user_id && !$contact_info_population) || $smarty.session.failed_registration == true}
                {assign var="title" value=__("please_sign_in")}
            {else}
                {if $auth.user_id != 0}
                    {if $user_data.firstname || $user_data.lastname}
                        {assign var="login_info" value="`$user_data.firstname`&nbsp;`$user_data.lastname`"}
                    {else}
                        {assign var="login_info" value="`$user_data.email`"}
                    {/if}
                {else}
                    {assign var="login_info" value=__("guest")}
                {/if}

                {assign var="title" value="{__("signed_in_as")} `$login_info`"}
            {/if}

            {hook name="checkout:step_one_edit_link_title"}
            {if $contact_info_population && !$edit}
                <a class="cm-ajax" href="{"checkout.checkout?edit_step=step_one&from_step={$cart.edit_step}"|fn_url}" data-ca-target-id="checkout_*">{$title|strip_tags nofilter}</a>
            {else}
                {$title|strip_tags nofilter}
            {/if}

            {/hook}
        </h4>
    </div>
    <div id="step_one_body" class="panel-body {if !$edit} hidden{/if}">
        {if ($settings.Checkout.disable_anonymous_checkout == "Y" && !$auth.user_id) || ($settings.Checkout.disable_anonymous_checkout != "Y" && !$auth.user_id && !$contact_info_population) || $smarty.session.failed_registration == true}
            <div id="on_step_one_register" {if $smarty.request.login_type == "register"}class="hidden"{/if}>
                    {include file="views/checkout/components/checkout_login.tpl" checkout_type="one_page"}
            </div>
            <div id="off_step_one_register" class="clearfix{if $smarty.request.login_type != "register"} hidden{/if}">
                <form name="step_one_register_form" class="{$ajax_form} cm-ajax-full-render" action="{""|fn_url}" method="post">
                    <input type="hidden" name="result_ids" value="checkout*,account*" />
                    <input type="hidden" name="return_to" value="checkout" />
                    <input type="hidden" name="user_data[register_at_checkout]" value="Y" />
                    <div class="checkout-block">
                        <h3>{__("register_new_account")}</h3>
                        {include file="views/profiles/components/profiles_account.tpl" nothing_extra="Y" location="checkout"}
                        {include file="views/profiles/components/profile_fields.tpl" section="C" nothing_extra="Y"}
            
                        {hook name="checkout:checkout_steps"}{/hook}
                        
                        {include file="common/image_verification.tpl" option="register"}
                        
                        <div class="clearfix"></div>
                    </div>
                        {include file="common/button.tpl" meta="btn-primary" name="dispatch[checkout.add_profile]" text=__("register")}
                        {include file="common/button.tpl" onclick="Tygh.$('#off_step_one_register').hide(); Tygh.$('#on_step_one_register').show();" text=__("cancel") meta="btn-default" as="link"} 
                    
                </form>
            </div>
        {else}
            <form name="step_one_contact_information_form" class="{$ajax_form}" action="{""|fn_url}" method="{if !$edit}get{else}post{/if}">
                <input type="hidden" name="update_step" value="step_one" />
                <input type="hidden" name="next_step" value="{$next_step}" />
                <input type="hidden" name="result_ids" value="checkout*" />
                {if $edit}
                    <div class="clearfix">
                        <div>
                            {include file="views/profiles/components/profile_fields.tpl" section="C" nothing_extra="Y" email_extra=$smarty.capture.email_extra}
                            <a href="{"auth.change_login"|fn_url}" class="btn btn-default">{__("sign_in_as_different")}</a> 
                            {hook name="checkout:checkout_steps"}
                                {include file="common/button.tpl" meta="btn btn-primary" name="dispatch[checkout.update_steps]" text=$but_text}
                            {/hook}
                        </div>
                    </div>
                    
                {/if}
            </form>
        {/if}
    </div>
<!--step_one-->
</div>
<div class="panel panel-default" data-ct-checkout="billing_shipping_address" id="step_two">
    <div class="panel-heading">
        {if $complete && !$edit}
        {hook name="checkout:step_one_edit_link"}
            {include file="common/button.tpl" meta="btn-default pull-right cm-ajax" href="checkout.checkout?edit_step=step_two&from_step={$cart.edit_step}" target_id="checkout_*" text=__("change")}
        {/hook}
        {/if}
        <h4>
            {if !$complete || $edit}
                {$show_number_of_step = true}
            {/if}
            {if ($show_number_of_step && $number_of_step) || !$show_number_of_step}
                <span class="label label-default">{if $show_number_of_step}{$number_of_step}{else}<i class="glyphicon glyphicon-ok fa fa-check"></i>{/if}</span>
            {/if}

            {hook name="checkout:step_two_edit_link_title"}
            {if $complete && !$edit}
                <a class="cm-ajax" href="{"checkout.checkout?edit_step=step_two&from_step={$cart.edit_step}"|fn_url}" data-ca-target-id="checkout_*">{__("billing_shipping_address")}</a>
            {else}
                {__("billing_shipping_address")}
            {/if}
            {/hook}
        </h4>

    </div>
    <div id="step_two_body" class="panel-body{if !$edit} hidden{/if} cm-skip-save-fields">
        <form name="step_two_billing_address" class="{$ajax_form} cm-ajax-full-render {if $final_step == "step_two"}cm-checkout-recalculate-form{/if}" action="{""|fn_url}" method="{if !$edit}get{else}post{/if}">
            <input type="hidden" name="update_step" value="step_two" />
            <input type="hidden" name="next_step" value="{$next_step}" />
            <input type="hidden" name="result_ids" value="checkout*,account*" />
            <input type="hidden" name="dispatch" value="checkout.checkout" />

            {if $smarty.request.profile == "new"}
                {assign var="hide_profile_name" value=false}
            {else}
                {assign var="hide_profile_name" value=true}
            {/if}
            
            {if $edit}
                <div class="clearfix">
                    <div class="checkout-block">
                        {include file="views/profiles/components/multiple_profiles.tpl" show_text=true hide_profile_name=$hide_profile_name hide_profile_delete=true profile_id=$cart.profile_id create_href="checkout.checkout?edit_step=step_two&from_step={$cart.edit_step}&profile=new"}
                    </div>
                </div>
            {/if}
            
            {if $settings.Checkout.address_position == "billing_first"}
                {assign var="first_section" value="B"}
                {assign var="first_section_text" value=__("billing_address")}
                {assign var="sec_section" value="S"}
                {assign var="sec_section_text" value=__("shipping_address")}
                {assign var="ship_to_another_text" value=__("text_ship_to_billing")}
                {assign var="body_id" value="sa"}
            {else}
                {assign var="first_section" value="S"}
                {assign var="first_section_text" value=__("shipping_address")}
                {assign var="sec_section" value="B"}
                {assign var="sec_section_text" value=__("billing_address")}
                {assign var="ship_to_another_text" value=__("text_billing_same_with_shipping")}
                {assign var="body_id" value="ba"}
            {/if}
            
            {if $edit}
                {if $profile_fields[$first_section]}
                    <div class="clearfix" data-ct-address="billing-address">
                        <div class="checkout-block">
                            {include file="views/profiles/components/profile_fields.tpl" section=$first_section body_id="" ship_to_another=true title=$first_section_text}
                        </div>
                    </div>
                {/if}

                {if $profile_fields[$sec_section]}
                    <div class="clearfix shipping-address__switch" data-ct-address="shipping-address">
                        {include file="views/profiles/components/profile_fields.tpl" section=$sec_section body_id=$body_id address_flag=$profile_fields|fn_compare_shipping_billing ship_to_another=$cart.ship_to_another title=$sec_section_text grid_wrap="checkout-block"}
                    </div>
                {/if}

                {if $final_step == "step_two"}
                    {include file="views/checkout/components/final_section.tpl" recalculate=true}
                {else}
                    <div class="well well-sm">
                        {include file="common/button.tpl" meta="btn-default" name="dispatch[checkout.update_steps]" text=__("continue")}
                    </div>
                {/if}
            {/if}

        </form>

    </div>

<!--step_two--></div>

{$show_number_of_steps = !$complete || $edit || $final_step == "step_three"}
<div class="panel panel-default" data-ct-checkout="user_info" id="step_one">
   <div class="panel-heading">
    {if !$show_number_of_steps}
        {hook name="checkout:step_three_edit_link"}
            {include file="common/button.tpl" meta="btn-default pull-right cm-ajax" href="checkout.checkout?edit_step=step_three&from_step={$cart.edit_step}" target_id="checkout_*" text=__("change")}
        {/hook}
    {/if}
    <h4>
        <span class="label label-default">{if $show_number_of_steps}{$number_of_step}{else}<i class="glyphicon glyphicon-ok fa fa-check"></i>{/if}</span>
        {hook name="checkout:step_three_edit_link_title"}
        {if !$show_number_of_steps}
            <a class="cm-ajax" href="{"checkout.checkout?edit_step=step_three&from_step={$cart.edit_step}"|fn_url}" data-ca-target-id="checkout_*">{__("shipping_options")}</a>
        {else}
            {__("shipping_options")}
        {/if}
        {/hook}
    </h4>
    </div>
    <div id="step_three_body" class="panel-body {if $edit}-active{/if} {if !$edit}hidden{/if} clearfix">
        {if $edit}
            <form name="step_three_payment_and_shipping" class="{$ajax_form} cm-ajax-full-render" action="{""|fn_url}" method="{if !$edit}get{else}post{/if}">
                <input type="hidden" name="update_step" value="step_three" />
                <input type="hidden" name="next_step" value="{$next_step}" />
                <input type="hidden" name="result_ids" value="checkout*" />
                
                <div class="clearfix">
                    <div class="checkout-block">
                        {hook name="checkout:select_shipping"}
                            {if !$cart.shipping_failed}
                                {include file="views/checkout/components/shipping_rates.tpl" no_form=true display="radio"}
                            {else}
                                <p>{__("text_no_shipping_methods")}</p>
                            {/if}
                        {/hook}
                    
                        {if $edit}
                            {__("shipping_tips")}
                        {/if}
                    </div>
                </div>
                
                {if $final_step == "step_three"}
                    {include file="views/checkout/components/final_section.tpl"}
                {else}
                    <div class="well well-sm">
                        {include file="common/button.tpl" meta="btn-default" name="dispatch[checkout.update_steps]" text=$but_text id="step_three_but"}
                    </div>
                {/if}
            </form>
        {/if}
    </div>
<!--step_three--></div>

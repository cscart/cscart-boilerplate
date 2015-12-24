{assign var="ajax_form" value="cm-ajax"}

{include file="views/profiles/components/profiles_scripts.tpl"}

<div class="checkout-steps cm-save-fields clearfix" id="checkout_steps">
    {$number_of_step = 0}
    
    {if $display_steps.step_one || $cart.edit_step == "step_one"}
        {$edit = $cart.edit_step == "step_one"}
        {$number_of_step = $number_of_step + 1}
        {include file="views/checkout/components/steps/step_one.tpl" step="one" complete=$completed_steps.step_one edit=$edit but_text=__("continue")}
    {/if}

    {if $display_steps.step_two}
        {$edit = $cart.edit_step == "step_two"}
        {$number_of_step = $number_of_step + 1}
        {include file="views/checkout/components/steps/step_two.tpl" step="two" complete=$completed_steps.step_two edit=$edit but_text=__("continue")}
    {/if}

    {if $display_steps.step_three || $cart.edit_step == "step_three"}
        {$edit = $cart.edit_step == "step_three"}
        {$number_of_step = $number_of_step + 1}
        {include file="views/checkout/components/steps/step_three.tpl" step="three" complete=$completed_steps.step_three edit=$edit but_text=__("continue")}
    {/if}

    {if $display_steps.step_four || $cart.edit_step == "step_four"}
        {$edit = $cart.edit_step == "step_four"}
        {$number_of_step = $number_of_step + 1}
        {include file="views/checkout/components/steps/step_four.tpl" step="four" edit=$edit complete=$completed_steps.step_four}
    {/if}

<!--checkout_steps--></div>
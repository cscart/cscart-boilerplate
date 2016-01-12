{assign var="result_ids" value="cart_items,checkout_totals,checkout_steps,cart_status*,checkout_cart"}

<form name="checkout_form" class="cm-check-changes" action="{""|fn_url}" method="post" enctype="multipart/form-data">
  <input type="hidden" name="redirect_mode" value="cart" />
  <input type="hidden" name="result_ids" value="{$result_ids}" />

  <h2 class="mainbox-title">{__("cart_contents")}</h2>

  <div class="panel panel-default cart-content-top-buttons">
      <div class="panel-body">
          <div class="pull-left cart-content-left-buttons">
              {include file="common/button.tpl" href=$continue_url|fn_url text=__("continue_shopping")}
              {include file="common/button.tpl" text=__("clear_cart") href="checkout.clear" meta="cm-confirm btn-default"}
          </div>
          <div class="pull-right cart-content-right-buttons">
              {include file="common/button.tpl" id="button_cart" name="dispatch[checkout.update]" text=__("recalculate") meta="btn-default"}

              {if $payment_methods}
                  {assign var="m_name" value="checkout"}
                  {assign var="link_href" value="checkout.checkout"}
                  {include file="common/button.tpl" text=__("proceed_to_checkout") href=$link_href meta="btn-primary"}
              {/if}
          </div>
      </div>
  </div>

  {include file="views/checkout/components/cart_items.tpl" disable_ids="button_cart"}

</form>

{include file="views/checkout/components/checkout_totals.tpl" location="cart"}

<div class="panel panel-default cart-content-bottom-buttons clearfix">
    <div class="panel-body">
        <div class="pull-left cart-content-left-buttons">
            {include file="common/button.tpl" href=$continue_url|fn_url text=__("continue_shopping")}
        </div>
        <div class="pull-right cart-content-right-buttons">
            {include file="common/button.tpl" external_click_id="button_cart" text=__("recalculate") meta="btn-default cm-external-click" as="link"}
            {if $payment_methods}
                {assign var="m_name" value="checkout"}
                {assign var="link_href" value="checkout.checkout"}
                {include file="common/button.tpl" text=__("proceed_to_checkout") href=$link_href meta="btn-primary"}
            {/if}
        </div>
    </div>
</div>
{if $checkout_add_buttons}
    <div class="cart-content-payment-methods" id="payment-methods">
        <span class="cart-content-payment-methods-title payment-metgods-or">{__("or_use")}</span>
        <table class="cart-content-payment-methods-block">
            <tr>
                {foreach from=$checkout_add_buttons item="checkout_add_button"}
                    <td class="cart-content-payment-methods-item">{$checkout_add_button nofilter}</td>
                {/foreach}
            </tr>
        </table>
    <!--payment-methods-->
    </div>
{/if}

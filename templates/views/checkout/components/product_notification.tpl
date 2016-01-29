{capture name="buttons"}
    <div class="pull-left">
        {include file="common/button.tpl" text=__("view_cart") meta="btn-primary" href="checkout.cart"}
    </div>
    {if $settings.General.checkout_redirect != "Y"}
        <div class="pull-right">
            {include file="common/button.tpl" href="checkout.checkout" text=__("checkout") meta="btn-primary"}
        </div>
    {/if}
{/capture}
{capture name="info"}
    <div class="product-notification-total-info row clearfix">
        <div class="product-notification-amount col-lg-6 col-md-6 col-sm-6 col-xs-6 text-left"> {__("items_in_cart", [$smarty.session.cart.amount])}</div>
        <div class="product-notification-subtotal col-lg-6 col-md-6 col-sm-6 col-xs-6 text-right">
            {__("cart_subtotal")} {include file="common/price.tpl" value=$smarty.session.cart.display_subtotal}
        </div>
    </div>
{/capture}
{include file="views/products/components/notification.tpl" product_buttons=$smarty.capture.buttons product_info=$smarty.capture.info}
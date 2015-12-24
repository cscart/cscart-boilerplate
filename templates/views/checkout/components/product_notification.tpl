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
    <div class="product-notification-total-info clearfix">
        <div class="product-notification-amount pull-left"> {__("items_in_cart", [$smarty.session.cart.amount])}</div>
        <div class="product-notification-subtotal pull-right">
            {__("cart_subtotal")} {include file="common/price.tpl" value=$smarty.session.cart.display_subtotal}
        </div>
    </div>
{/capture}
{include file="views/products/components/notification.tpl" product_buttons=$smarty.capture.buttons product_info=$smarty.capture.info}
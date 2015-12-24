{capture name="buttons"}
    <div class="pull-right">
        {include file="common/button.tpl" href="wishlist.view" text=__("view_wishlist")}
    </div>
{/capture}
{include file="views/products/components/notification.tpl" product_buttons=$smarty.capture.buttons}
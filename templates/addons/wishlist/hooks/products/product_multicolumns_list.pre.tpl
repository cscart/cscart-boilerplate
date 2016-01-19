{if $is_wishlist}
<div class="wishlist-remove-item">
    <a href="{"wishlist.delete?cart_id=`$product.cart_id`"|fn_url}" title="{__("remove")}">
        <i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
        <span>{__("remove")}</span>
    </a>
</div>
{/if}
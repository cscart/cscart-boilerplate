{if $is_wishlist}
<div class="wishlist-remove-item">
    <a href="{"wishlist.delete?cart_id=`$product.cart_id`"|fn_url}" class="remove" title="{__("remove")}"><i class="remove__icon icon-cancel-circle"></i><span class="remove__txt">{__("remove")}</span></a>
</div>
{/if}
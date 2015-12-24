{if !$hide_wishlist_button}
    {include file="addons/wishlist/views/wishlist/components/add_to_wishlist.tpl" id="button_wishlist_`$obj_prefix``$product.product_id`" name="dispatch[wishlist.add..`$product.product_id`]"}
{/if}
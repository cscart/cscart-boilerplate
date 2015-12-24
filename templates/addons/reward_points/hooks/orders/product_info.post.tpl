{if $order_info.points_info.price && $product}
    <div class="control-group product-list-field">
        <label class="control-group__label">{__("price_in_points")}:</label>
        <span class="control-group__item">{$product.extra.points_info.price}</span>
    </div>
{/if}
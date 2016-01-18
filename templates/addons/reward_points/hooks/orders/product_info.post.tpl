{if $order_info.points_info.price && $product}
    <div class="form-group product-list-field">
        <label class="control-label">{__("price_in_points")}:</label>
        <span class="control">{$product.extra.points_info.price}</span>
    </div>
{/if}
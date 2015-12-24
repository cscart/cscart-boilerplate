{if $addons.rma.display_product_return_period == "Y" && $product.return_period && $product.is_returnable == "Y"}
    <div class="form-group">
        <label class="control-label">{__("return_period")}:</label>
        <span class="form-control">{$product.return_period}&nbsp;{__("days")}</span>
    </div>
{/if}
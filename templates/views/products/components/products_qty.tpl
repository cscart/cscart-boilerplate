{if $product.max_qty}
<div class="form-group product-list-field clearfix">
    {if ($product.min_qty)}
        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
            <label class="control-label">{__("allow_qty")}:</label>
        </div>
        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">
            <span id="product_min_max_qty_{$product.product_id}">
                {$product.min_qty}&nbsp;-&nbsp;{$product.max_qty}&nbsp;{__("items")}
            </span>
        </div>
    {else}
        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
            <label class="control-label">{__("allow_qty")}:</label>
        </div>
        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">
            <span id="product_min_max_qty_{$product.product_id}">
                {$product.quantity}&nbsp;{$product.max_qty}&nbsp;{__("qty_at_most")}&nbsp;{__("items")}
            </span>
        </div>
    {/if}
</div>
{/if}
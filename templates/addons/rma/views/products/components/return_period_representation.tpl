{if $addons.rma.display_product_return_period == "Y" && $product.return_period && $product.is_returnable == "Y"}
    <div class="form-group row">
        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
            <label class="control-label ">{__("return_period")}:</label>
        </div>
        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">
            <span class="label label-info">{$product.return_period}&nbsp;{__("days")}</span>
        </div>
    </div>
{/if}
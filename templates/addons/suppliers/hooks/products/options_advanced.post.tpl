{if $addons.suppliers.display_supplier == "Y" && $product.supplier_id}
    <div class="row {if !$capture_options_vs_qty} product-list-field{/if}">
        <label class="col-lg-3">{__("supplier")}:</label>
        <div class="col-lg-9">
            <a href="{"suppliers.view?supplier_id=`$product.supplier_id`"|fn_url}">{$product.supplier_id|fn_get_supplier_name}</a>
        </div>
    </div>
{/if}
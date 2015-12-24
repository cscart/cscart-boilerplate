{if !$smarty.session.auth.age && $product.age_verification == "Y"}
<table class="width-full">
<tr>
    <td style="width: {$cell_width}%" class="valign-top">
        <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{$product.product nofilter}</a>
        <div class="box">
            {__("product_need_age_verification")}
            <div class="buttons-container">
                {include file="common/button.tpl" text=__("verify") href="products.view?product_id=`$product.product_id`"}
            </div>
        </div>
    </td>
</tr>
</table>
{/if}
{if !$smarty.session.auth.age && $product.age_verification == "Y"}
<div class="product-container">
    <div class="product-description">
        <a href="{"products.view?product_id=`$product.product_id`"|fn_url}" class="product-title">{$product.product nofilter}</a>
    </div>
    <div class="box mt-s">
        {__("product_need_age_verification")}
        <div class="buttons-container">
            {include file="common/button.tpl" text=__("verify") href="products.view?product_id=`$product.product_id`"}
        </div>
    </div>
</div>
{/if}
{if !$smarty.session.auth.age && $product.age_verification == "Y"}
<div class="age-verification-block">
    <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{$product.product nofilter}</a>
    <div class="age-verification-text text-danger text-center">{__("product_need_age_verification")}</div>
    <div class="age-verification-buttons">
        {include file="common/button.tpl" meta="btn-warning btn-block" text=__("verify") href="products.view?product_id=`$product.product_id`"}
    </div>
</div>
{/if}
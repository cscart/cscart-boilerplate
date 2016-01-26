{if !$smarty.session.auth.age && $product.age_verification == "Y"}
<div class="age-verification-block compact-list">
    <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{$product.product nofilter}</a>
    <div class="age-verification-text text-danger">{__("product_need_age_verification")}</div>
    <div class="age-verification-buttons">
        {include file="common/button.tpl" meta="btn-warning" text=__("verify") name="" href="products.view?product_id=`$product.product_id`"}
    </div>
</div>
<hr>
{/if}
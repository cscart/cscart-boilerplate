<div itemscope itemtype="http://schema.org/Product">
    <meta itemprop="sku" content="{$product.product_code}" />
    <meta itemprop="name" content="{$product.product}" />
    <meta itemprop="description" content="{$product.full_description|default:$product.short_description}" />

    <div itemprop="offers" itemscope="" itemtype="http://schema.org/Offer">
        {$product_amount = $product.inventory_amount|default:$product.amount}
        {if ($product_amount <= 0 || $product_amount < $product.min_qty) && $settings.General.inventory_tracking == "Y"}
        <link itemprop="availability" href="http://schema.org/OutOfStock" />
        {else}
        <link itemprop="availability" href="http://schema.org/InStock" />
        {/if}
        {if !(!$auth.user_id && $settings.General.allow_anonymous_shopping == "hide_price_and_add_to_cart")}
            <meta itemprop="priceCurrency" content="{$currencies[$smarty.const.CART_PRIMARY_CURRENCY].currency_code}"/>
            <meta itemprop="price" content="{$product.price|fn_format_price:$primary_currency}"/>
        {/if}
    </div>

    {hook name="products:seo_snippet_attributes"}
    {/hook}

</div>
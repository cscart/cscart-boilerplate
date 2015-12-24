{** block-description:description **}

{if $product.full_description}
    <div {live_edit name="product:full_description:{$product.product_id}"}>{$product.full_description nofilter}</div>
{else if $product.short_description}
    <div {live_edit name="product:short_description:{$product.product_id}"}>{$product.short_description nofilter}</div>
{/if}
{** block-description:tags **}

{if $addons.tags.tags_for_products == "Y"}
    {include file="addons/tags/views/tags/components/tags.tpl" object=$product object_id=$product.product_id object_type="P"}
{/if}
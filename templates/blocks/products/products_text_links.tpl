{** block-description:text_links **}

<{if $block.properties.item_number == "Y"}ol{else}ul{/if} class="text-link-list">

{foreach from=$items item="product"}
{assign var="obj_id" value="`$block.block_id`000`$product.product_id`"}
{if $product}
    <li class="text-link-item">
        <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{$product.product nofilter}</a>
    </li>
{/if}
{/foreach}

</{if $block.properties.item_number == "Y"}ol{else}ul{/if}>
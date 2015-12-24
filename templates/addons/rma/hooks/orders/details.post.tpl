{if $order_info.returned_products}
<table class="table">
    <tr>
        <th>{__("sku")}</th>
        <th>{__("returned_product")}</th>
        <th style="width: 5%" class="center">{__("quantity")}</th>
        <th style="width: 7%" class="center">{__("subtotal")}</th>
    </tr>
    {foreach from=$order_info.returned_products item="product"}
    <tr>
        <td>&nbsp;{$product.product_code}</td>
        <td>
            <a href="{"products.view?product_id=`$product.product_id`"|fn_url}" class="manage-root-item">{$product.product nofilter}</a>
            {hook name="orders:product_details"}
                {if $product.product_options}
                    {include file="common/options_info.tpl" product_options=$product.product_options}
                {/if}
            {/hook}
        <td class="center">{$product.amount}</td>
        <td class="right"><strong>{if $product.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$product.subtotal}{/if}</strong></td>
    </tr>
    {/foreach}
</table>
{/if}
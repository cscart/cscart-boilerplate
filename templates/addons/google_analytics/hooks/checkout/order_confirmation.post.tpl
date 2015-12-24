{if $addons.google_analytics.track_ecommerce == 'Y'}
<script type="text/javascript">
ga('require', 'ecommerce', 'ecommerce.js');
{foreach from=$orders_info item="ga_order_info"}
ga('ecommerce:addTransaction', {
    'id': '{$ga_order_info.order_id}',
    'affiliation': '{$ga_order_info.ga_company_name}',
    'revenue': '{$ga_order_info.total}',
    'shipping': '{$ga_order_info.shipping_cost}',
    'tax': '{$ga_order_info.tax_subtotal}',
    'currency': '{$ga_order_info.secondary_currency}'
});

{foreach from=$ga_order_info.products item="product" key="key"}
ga('ecommerce:addItem', {
    'id': '{$ga_order_info.order_id}',
    'name': '{$product.product}',
    'sku': '{$product.product_code}',
    'category': '{$product.ga_category_name}',
    'price': '{$product.price}',
    'quantity': '{$product.amount}'
});
{/foreach}
{/foreach}
ga('ecommerce:send');
ga('ecommerce:clear');
</script>
{/if}

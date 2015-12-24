{** block-description:required_products **}

{if $product.required_products}
{include file="blocks/list_templates/products_list.tpl"
products=$product.required_products
show_product_status="Y"
details_page=false
show_name=true
show_sku=true
show_rating=true
show_features=true
show_prod_descr=true
show_old_price=false
show_price=true
show_clean_price=true
show_list_discount=false
show_discount_label=false
show_product_amount=true
show_product_options=true
show_qty=true
show_min_qty=true
show_product_edp=true
show_add_to_cart=true
show_list_buttons=true
show_descr=true
but_role="action"
no_pagination=true
no_sorting=true
obj_prefix="required_products"
}
{/if}
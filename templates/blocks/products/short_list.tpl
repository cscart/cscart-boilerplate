{** block-description:short_list **}

{if $block.properties.hide_add_to_cart_button == "Y"}
    {assign var="_show_add_to_cart" value=false}
{else}
    {assign var="_show_add_to_cart" value=true}
{/if}

{include file="blocks/product_list_templates/short_list.tpl" 
    products=$items 
    no_sorting="Y" 
    no_pagination="Y" 
    obj_prefix="`$block.block_id`000" 
    show_add_to_cart=$_show_add_to_cart
}
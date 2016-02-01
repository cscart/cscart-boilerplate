{** block-description:small_items **}

{if $block.properties.hide_add_to_cart_button == "Y"}
    {assign var="_show_add_to_cart" value=false}
{else}
    {assign var="_show_add_to_cart" value=true}
{/if}

{assign var="_show_name" value="true"}
{include file="blocks/list_templates/small_items.tpl" 
    products=$items 
    obj_prefix="`$block.block_id`000" 
    item_number=$block.properties.item_number 
    show_name=$_show_name 
    show_price=false
    show_rating=true 
    show_add_to_cart=$_show_add_to_cart 
    show_list_buttons=false
    add_to_cart_meta="text-button-add"
    but_role="text"
}
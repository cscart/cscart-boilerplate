{foreach from=$products item="product" name="products"}
    {assign var="obj_id" value=$product.product_id}
    {assign var="obj_id_prefix" value="`$obj_prefix``$product.product_id`"}
    {include file="common/product_data.tpl" product=$product}
    {hook name="products:product_thumbnail_list"}
    <div class="thumbnail-list-item">
        {assign var="form_open" value="form_open_`$obj_id`"}
        {$smarty.capture.$form_open nofilter}
        <a class="thumbnail-list-img-block" href="{"products.view?product_id=`$product.product_id`"|fn_url}">{include file="common/image.tpl" image_width="70" image_height="70" images=$product.main_pair obj_id=$obj_id_prefix no_ids=true}</a>
        <div class="thumbnail-list-name">{if $block.properties.item_number == "Y"}{$smarty.foreach.products.iteration}.&nbsp;{/if}
        {assign var="name" value="name_$obj_id"}{$smarty.capture.$name nofilter}</div>

        {assign var="old_price" value="old_price_`$obj_id`"}
        {if $smarty.capture.$old_price|trim}{$smarty.capture.$old_price nofilter}&nbsp;{/if}
        
        {assign var="price" value="price_`$obj_id`"}
        {$smarty.capture.$price nofilter}

        {if $show_add_to_cart}
            <div class="thumbnail-list-butons">
                {assign var="add_to_cart" value="add_to_cart_`$obj_id`"}
                {$smarty.capture.$add_to_cart nofilter}
            </div>
        {/if}

        {assign var="form_close" value="form_close_`$obj_id`"}
        {$smarty.capture.$form_close nofilter}
    </div>
    {/hook}
{/foreach}
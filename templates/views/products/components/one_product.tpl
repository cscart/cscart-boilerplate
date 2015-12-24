{script src="js/tygh/exceptions.js"}

{assign var="obj_id" value="`$obj_prefix``$product.product_id`"}
{assign var="obj_id_prefix" value="`$obj_prefix``$product.product_id`"}
{if $product.result_type == "full"}
{hook name="products:one_product"}
<div class="product-container clearfix">
    <div class="product-image">
        <span class="cm-reload-{$obj_id} image-reload" id="list_image_update_{$obj_id}">
            <input type="hidden" name="image[list_image_update_{$obj_id}][data]" value="{$obj_id_prefix},{$settings.Thumbnails.product_lists_thumbnail_width},{$settings.Thumbnails.product_lists_thumbnail_height},product" />
            
            <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{include file="common/image.tpl" image_width=$settings.Thumbnails.product_lists_thumbnail_width image_height=$settings.Thumbnails.product_lists_thumbnail_height obj_id=$obj_id images=$product.main_pair}</a>
        <!--list_image_update_{$obj_id}--></span>
    </div>
    <div class="product-description">
        {include file="blocks/list_templates/simple_list.tpl" product=$product show_name=true show_sku=true show_features=true show_descr=true show_old_price=true show_price=true show_list_discount=true show_discount_label=true show_product_amount=true show_product_options=true show_qty=true min_qty=true show_edp=true show_add_to_cart=true show_list_buttons=true but_role="action"}
    </div>
</div>
{/hook}
{else}
<div class="search-result">
    <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{$product.product nofilter}</a>
    {if !$hide_info}
    {if $product.short_description || $product.full_description}
    <p>
    {if $product.short_description}
        {$product.short_description nofilter}
    {else}
        {$product.full_description|strip_tags|truncate:280:"..." nofilter}{if $product.full_description|strlen > 280}<a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{__("more_link")}</a>{/if}
    {/if}
    </p>
    {/if}

    {elseif $hide_info == "age-verify"}
        {$product.age_warning_message}
        <div class="buttons-container">
            {include file="common/button.tpl" text=__("verify") href="products.view?product_id=`$product.product_id`" role="text"}
        </div>
    {/if}
</div>
{/if}
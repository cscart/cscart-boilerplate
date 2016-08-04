{assign var="th_size" value=$thumbnails_size|default:35}

{if $product.main_pair.icon || $product.main_pair.detailed}
    {assign var="image_pair_var" value=$product.main_pair}
{elseif $product.option_image_pairs}
    {assign var="image_pair_var" value=$product.option_image_pairs|reset}
{/if}

{if $image_pair_var.image_id}
    {assign var="image_id" value=$image_pair_var.image_id}
{else}
    {assign var="image_id" value=$image_pair_var.detailed_id}
{/if}

{if !$preview_id}
    {assign var="preview_id" value=$product.product_id|uniqid}
{/if}

<div class="thumbnail product-img cm-preview-wrapper">
{include file="common/image.tpl" obj_id="`$preview_id`_`$image_id`" images=$image_pair_var link_class="cm-image-previewer" image_width=$image_width image_height=$image_height image_id="preview[product_images_`$preview_id`]"}

{foreach from=$product.image_pairs item="image_pair"}
    {if $image_pair}
        {if $image_pair.image_id}
            {assign var="img_id" value=$image_pair.image_id}
        {else}
            {assign var="img_id" value=$image_pair.detailed_id}
        {/if}
        {include file="common/image.tpl" images=$image_pair link_class="cm-image-previewer hidden" obj_id="`$preview_id`_`$img_id`" image_width=$image_width image_height=$image_height image_id="preview[product_images_`$preview_id`]"}
    {/if}
{/foreach}
</div>

{if $product.image_pairs}
    {if $settings.Appearance.thumbnails_gallery == "Y"}
        
    {else}
        <div class="product-thumbnails cm-image-gallery" id="images_preview_{$preview_id}" style="width: {$image_width}px;">
            {strip}
                {if $image_pair_var}
                <a data-ca-gallery-large-id="det_img_link_{$preview_id}_{$image_id}" class="cm-thumbnails-mini thumbnail active product-thumbnails-item">
                    {include file="common/image.tpl" images=$image_pair_var image_width=$th_size image_height=$th_size show_detailed_link=false obj_id="`$preview_id`_`$image_id`_mini"}
                </a>
                {/if}

                {if $product.image_pairs}
                    {foreach from=$product.image_pairs item="image_pair"}
                        {if $image_pair}
                            {if $image_pair.image_id == 0}
                                {assign var="img_id" value=$image_pair.detailed_id}
                            {else}
                                {assign var="img_id" value=$image_pair.image_id}
                            {/if}
                            <a data-ca-gallery-large-id="det_img_link_{$preview_id}_{$img_id}" class="cm-thumbnails-mini thumbnail product-thumbnails-item">
                            {include file="common/image.tpl" images=$image_pair image_width=$th_size image_height=$th_size show_detailed_link=false obj_id="`$preview_id`_`$img_id`_mini"}
                            </a>
                        {/if}
                    {/foreach}
                {/if}
            {/strip}
        </div>
    {/if}
{/if}

{script src="js/tygh/previewers/`$settings.Appearance.default_image_previewer`.previewer.js"}
{script src="design/themes/`$runtime.layout.theme_name`/js/product_image_gallery.js"}

{hook name="products:product_images"}{/hook}
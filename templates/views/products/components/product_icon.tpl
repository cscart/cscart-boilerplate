{capture name="main_icon"}
    <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">
        {include file="common/image.tpl" obj_id=$obj_id_prefix images=$product.main_pair image_width=$settings.Thumbnails.product_lists_thumbnail_width image_height=$settings.Thumbnails.product_lists_thumbnail_height}
    </a>
{/capture}

{if $product.image_pairs && $show_gallery}
<div class="owl-carousel cm-image-gallery" data-ca-items-count="1" data-ca-items-responsive="true" id="icons_{$obj_id_prefix}">
    {if $product.main_pair}
        <div class="cm-gallery-item cm-item-gallery">
            {$smarty.capture.main_icon nofilter}
        </div>
    {/if}
    {foreach from=$product.image_pairs item="image_pair"}
        {if $image_pair}
            <div class="cm-gallery-item cm-item-gallery">
                <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">
                    {include file="common/image.tpl" no_ids=true images=$image_pair image_width=$settings.Thumbnails.product_lists_thumbnail_width image_height=$settings.Thumbnails.product_lists_thumbnail_height lazy_load=true}
                </a>
            </div>
        {/if}
    {/foreach}
</div>
{else}
    {$smarty.capture.main_icon nofilter}
{/if}
{$obj_prefix = "`$block.block_id`000"}

<div id="scroll_list_{$block.block_id}" class="owl-carousel">
    {foreach from=$brands item="brand" name="for_brands"}
            {include file="common/image.tpl" assign="object_img" image_width=$block.properties.thumbnail_width image_height=$block.properties.thumbnail_width images=$brand.image_pair no_ids=true lazy_load=true obj_id="scr_`$block.block_id`000`$brand.variant_id`"}
            <div class="center">
                <a href="{"product_features.view?variant_id=`$brand.variant_id`"|fn_url}">{$object_img nofilter}</a>
            </div>
    {/foreach}
</div>

{if $block.properties.outside_navigation == "Y"}
    <div class="owl-theme owl-controls">
        <div class="owl-controls clickable owl-controls-outside" id="owl_outside_nav_{$block.block_id}">
            <div class="owl-buttons">
                <div id="owl_prev_{$obj_prefix}" class="owl-prev"><i class="glyphicon glyphicon-menu-left fa fa-angle-left"></i></div>
                <div id="owl_next_{$obj_prefix}" class="owl-next"><i class="glyphicon glyphicon-menu-right fa fa-angle-right"></i></div>
            </div>
        </div>
    </div>
{/if}
{include file="common/scroller_init.tpl" items=$brands prev_selector="#owl_prev_`$obj_prefix`" next_selector="#owl_next_`$obj_prefix`"}

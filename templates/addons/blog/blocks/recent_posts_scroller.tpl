{** block-description:blog.recent_posts_scroller **}

{if $items}

{assign var="obj_prefix" value="`$block.block_id`000"}

<div class="blog-recent-posts-scroller">
    <div id="scroll_list_{$block.block_id}" class="owl-carousel scroller-list">
    {foreach from=$items item="page"}
        <div class="blog-recent-item">
            <div class="blog-recent-scroller">
                <a href="{"pages.view?page_id=`$page.page_id`"|fn_url}">
                    {include file="common/image.tpl" image_width="550" obj_id=$page.page_id images=$page.main_pair}
                </a>
            </div>
            <a href="{"pages.view?page_id=`$page.page_id`"|fn_url}">{$page.page}</a>
            <div class="blog-date">{$page.timestamp|date_format:"`$settings.Appearance.date_format`"}</div>
        </div>
    {/foreach}
    </div>
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

{include file="common/scroller_init_with_quantity.tpl" prev_selector="#owl_prev_`$obj_prefix`" next_selector="#owl_next_`$obj_prefix`"}

{/if}
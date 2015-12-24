{if $page.description && $page.page_type == $smarty.const.PAGE_TYPE_BLOG}
    <ul class="list-inline post-info">
        <li>{$page.timestamp|date_format:"`$settings.Appearance.date_format`"}</li>
        <li>{__("by")} {$page.author}</li>
    </ul>
    {if $page.main_pair}
        <div class="blog-img-block">
            {include file="common/image.tpl" image_width="894" obj_id=$page.page_id images=$page.main_pair}
        </div>
    {/if}
{/if}

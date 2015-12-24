{if $page.page_type == $smarty.const.PAGE_TYPE_BLOG}

{if $subpages}
    {capture name="mainbox_title"}{/capture}
    <div class="blog">
        {include file="common/pagination.tpl"}

        {foreach from=$subpages item="subpage"}
            <div class="blog-item">
                <a href="{"pages.view?page_id=`$subpage.page_id`"|fn_url}">
                    <h2 class="blog-post-title">
                        {$subpage.page}
                    </h2>
                </a>
                <ul class="list-inline post-info">
                    <li>{$subpage.timestamp|date_format:"`$settings.Appearance.date_format`"}</li>
                    <li>{__("by")} {$subpage.author}</li>
                </ul>
                {if $subpage.main_pair}
                <a href="{"pages.view?page_id=`$subpage.page_id`"|fn_url}">
                    <div class="blog-img-block">
                        {include file="common/image.tpl" image_width="894" obj_id=$subpage.page_id images=$subpage.main_pair}
                    </div>
                </a>
                {/if}
                <div class="blog-description">
                    <div class="wysiwyg-content">
                        {$subpage.spoiler nofilter}
                    </div>
                    <a class="btn btn-default" href="{"pages.view?page_id=`$subpage.page_id`"|fn_url}">{__("blog.read_more")}</a>
                </div>
            </div>
        {/foreach}

        {include file="common/pagination.tpl"}
    </div>

{/if}

{if $page.description}
    {capture name="mainbox_title"}<span class="blog-post-title" {live_edit name="page:page:{$page.page_id}"}>{$page.page}</span>{/capture}
{/if}

{/if}
{** block-description:blog.text_links **}

{assign var="parent_id" value=$block.content.items.parent_page_id}
{if $items}
    <ul class="list-unstyled blog-text-links">
    {foreach from=$items item="page" name="fe_blog"}
        <li>
            <div class="blog-text-links-date">{$page.timestamp|date_format:$settings.Appearance.date_format}</div>
            <a href="{"pages.view?page_id=`$page.page_id`"|fn_url}">{$page.page}</a>
        </li>
    {/foreach}
    </ul>
    {if $parent_id}
        {include file="common/button.tpl" href="pages.view?page_id=`$parent_id`" text=__("view_all")}
    {/if}
{/if}
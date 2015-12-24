{** block-description:blog.recent_posts **}

{if $items}
<ul class="list-unstyled blog-resent-post">
{foreach from=$items item="page"}
    <li>
        <a href="{"pages.view?page_id=`$page.page_id`"|fn_url}">{$page.page}</a>
    </li>
{/foreach}
</ul>
{/if}
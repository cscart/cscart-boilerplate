{** block-description:text_links **}

{if $items}
<ul class="list-unstyled">
    {foreach from=$items item="page"}
    <li><a href="{if $page.page_type == $smarty.const.PAGE_TYPE_LINK}{$page.link|fn_url}{else}{"pages.view?page_id=`$page.page_id`"|fn_url}{/if}"{if $page.new_window} target="_blank"{/if}>{$page.page}</a></li>
    {/foreach}
</ul>
{/if}
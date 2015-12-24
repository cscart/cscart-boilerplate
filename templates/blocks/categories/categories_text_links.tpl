{** block-description:text_links **}

{if $items}
<ul class="text-links">
    {foreach from=$items item="category"}
    <li class="text-links-item level-{$category.level|default:0}{if $category.active || $category|fn_check_is_active_menu_item:$block.type} active{/if}"><a class="text-links-a" href="{"categories.view?category_id=`$category.category_id`"|fn_url}">{$category.category}</a></li>
    {/foreach}
</ul>
{/if}
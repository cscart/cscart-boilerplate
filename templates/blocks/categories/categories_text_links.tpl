{** block-description:text_links **}

{assign var="old_level" value=0}
{if $items}
    <ul class="text-links">
        {foreach from=$items item="category"}
        {if $category.level < $old_level}
            </li>
        {/if}

        {if $category.level > $old_level}
            <ul class="text-links">
        {elseif $category.level < $old_level}
            {for $var=$category.level to $old_level - 1}
                </ul>
                </li>
            {/for}
        {/if}

        {assign var="old_level" value=$category.level}

        <li class="text-links-item level-{$category.level|default:0}{if $category.active || $category|fn_check_is_active_menu_item:$block.type} active{/if}">
            <a class="text-links-a" href="{"categories.view?category_id=`$category.category_id`"|fn_url}">{$category.category}</a>
            {/foreach}
        </li>
    </ul>
{/if}
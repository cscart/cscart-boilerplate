{** block-description:text_links **}

{assign var="old_level" value=0}
{if $items}
    {strip}
        <ul class="text-links">
            {foreach from=$items item="page"}
                {if $page.level < $old_level}
                    {for $var=$page.level to $old_level}
                        </li>
                    {/for}
                {/if}

                {if $page.level > $old_level}
                    <ul class="text-links">
                {elseif $page.level < $old_level}
                    {for $var=$page.level to $old_level - 1}
                        </ul>
                    {/for}
                {/if}

                {assign var="old_level" value=$page.level}

                <li class="text-links-item  level-{$page.level|default:0}{if $page.active || $page|fn_check_is_active_menu_item:$block.type} active{/if}">
                    {if $page.page_type == $smarty.const.PAGE_TYPE_LINK}
                        {assign var="href" value=$page.link|fn_url}
                    {else}
                        {assign var="href" value="pages.view?page_id=`$page.page_id`"|fn_url}
                    {/if}
                    <a class="text-links-a" href="{$href}" {if $page.new_window}target="_blank"{/if}>
                        {$page.page}
                    </a>
                {/foreach}
            </li>
        </ul>
    {/strip}
{/if}

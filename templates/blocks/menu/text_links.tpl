{** block-description:text_links **}

{if $block.properties.show_items_in_line == 'Y'}
    {assign var="inline" value=true}
{/if}

{assign var="text_links_id" value=$block.snapping_id}

{if $items}
    <nav class="text-links">
    {if !$submenu}
        <ul class="list-inline">
            {foreach from=$items item="menu"}
                <li class="{if $menu.active}active{/if} {if $menu.class} {$menu.class}{/if}">
                    <a {if $menu.href}href="{$menu.href|fn_url}"{else}href="#"{/if}>{$menu.item}</a>
                    {if $menu.subitems}
                        {include file="blocks/menu/text_links.tpl" items=$menu.subitems submenu=true}
                    {/if}
                </li>
            {/foreach}
        </ul>
    {else}
        {foreach from=$items item="menu"}
           <li class="{if $menu.active}active{/if} {if $menu.class} {$menu.class}{/if}">
                <a {if $menu.href}href="{$menu.href|fn_url}"{/if}>{$menu.item}</a> 
                {if $menu.subitems}
                    {include file="blocks/menu/text_links.tpl" items=$menu.subitems submenu=true}
                {/if}
            </li>
        {/foreach}
    {/if}
    </nav>
{/if}

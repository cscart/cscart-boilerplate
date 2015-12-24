{hook name="blocks:sidebox_dropdown"}{strip}
{assign var="foreach_name" value="item_`$iid`"}

{foreach from=$items item="item" name=$foreach_name}
{hook name="blocks:sidebox_dropdown_element"}
    <li class="{if $item.$childs}dropdown-vertical-dir{/if}{if $item.active || $item|fn_check_is_active_menu_item:$block.type} active{/if} menu-level-{$level}{if $item.class} {$item.class}{/if}">
        
        {assign var="item_url" value=$item|fn_form_dropdown_object_link:$block.type}
        <div class="menu-submenu-item">
            <a{if $item_url} href="{$item_url}"{/if} {if $item.new_window}target="_blank"{/if}>{$item.$name}</a>
        </div>

        {if $item.$childs}
            {hook name="blocks:sidebox_dropdown_childs"}
            <div class="menu-submenu">
                <ul class="menu-submenu-items">
                    {include file="blocks/sidebox_dropdown.tpl" items=$item.$childs separated=true submenu=true iid=$item.$item_id level=$level+1}
                </ul>
            </div>
            {/hook}
        {/if}
    </li>
{/hook}

{/foreach}
{/strip}{/hook}
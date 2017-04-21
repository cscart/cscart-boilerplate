{hook name="blocks:sidebox_dropdown"}{strip}
    {assign var="foreach_name" value="item_`$iid`"}

    {foreach from=$items item="item" name=$foreach_name}
        {hook name="blocks:sidebox_dropdown_element"}
            <li class="{if $item.$childs && $level == 0}dropdown{/if}{if $item.active || $item|fn_check_is_active_menu_item:$block.type} active{/if} menu-level-{$level}{if $item.class} {$item.class}{/if}">

                {assign var="item_url" value=$item|fn_form_dropdown_object_link:$block.type}

                <a{if $item_url} href="{$item_url}"{/if} {if $item.new_window}target="_blank"{/if} {if $item.$childs}class="dropdown dropdown-submenu"{/if}>
                    {$item.$name}
                    {if $item.$childs}<span class="caret"></span>{/if}
                </a>


                {if $item.$childs}
                    {hook name="blocks:sidebox_dropdown_childs"}
                        <ul class="menu-submenu-items dropdown-menu">
                            {include file="blocks/sidebox_dropdown.tpl" items=$item.$childs separated=true submenu=true iid=$item.$item_id level=$level+1}
                        </ul>
                    {/hook}
                {else}

                {/if}
            </li>
        {/hook}

    {/foreach}
{/strip}{/hook}
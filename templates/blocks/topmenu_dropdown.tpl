{hook name="blocks:topmenu_dropdown"}
{if $items}
<nav class="navbar navbar-inverse has-submenu" role="navigation">
    {hook name="blocks:topmenu_dropdown_top_menu"}
    
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar_{$block.block_id}" aria-expanded="false">

        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand visible-xs-inline-block" href="#" data-toggle="collapse" data-target="#navbar_{$block.block_id}">{__("menu")}</a>
    </div>

    <div class="collapse navbar-collapse" id="navbar_{$block.block_id}">
        <ul class="nav navbar-nav">
            {foreach from=$items item="item1" name="item1"}
            {assign var="item1_url" value=$item1|fn_form_dropdown_object_link:$block.type}
            {assign var="unique_elm_id" value=$item1_url|md5}
            {assign var="unique_elm_id" value="topmenu_`$block.block_id`_`$unique_elm_id`"}
            {if $subitems_count}
            {/if}
            <li class="dropdown {if $item1.active || $item1|fn_check_is_active_menu_item:$block.type} active{/if}{if $item1.class} {$item1.class}{/if}">
                <a {if $item1_url} href="{$item1_url}"{/if} class="dropdown-toggle">{$item1.$name}{if $item1.$childs} <span class="caret"></span>{/if}</a>

                {if $item1.$childs}
                    {if !$item1.$childs|fn_check_second_level_child_array:$childs}
                    {* Only two levels. Vertical output *}
                    <ul class="dropdown-menu">
                        {hook name="blocks:topmenu_dropdown_2levels_elements"}
                        
                        {foreach from=$item1.$childs item="item2" name="item2"}
                        {assign var="item_url2" value=$item2|fn_form_dropdown_object_link:$block.type}
                            <li><a {if $item_url2} href="{$item_url2}"{/if}>{$item2.$name}</a></li>
                        {/foreach}

                        {if $item1.show_more && $item1_url}
                            <li>
                                <a href="{$item1_url}"> <p><strong>{__("text_topmenu_view_more")}</strong></p></a>
                            </li>
                        {/if}

                        {/hook}
                    </ul>
                    {else}
                    {hook name="blocks:topmenu_dropdown_3levels_cols"}
                    <ul class="dropdown-menu">
                        <li>
                            <div class="submenu-content">
                                {foreach from=$item1.$childs item="item2" name="item2"}
                                    {assign var="item2_url" value=$item2|fn_form_dropdown_object_link:$block.type}
                                    <ul class="list-unstyled submenu-items">
                                        <li><p><strong><a {if $item2_url} href="{$item2_url}"{/if} >{$item2.$name}</a></strong></p></li>
                                        {if $item2.$childs}
                                        {hook name="blocks:topmenu_dropdown_3levels_col_elements"}
                                        {foreach from=$item2.$childs item="item3" name="item3"}
                                        {assign var="item3_url" value=$item3|fn_form_dropdown_object_link:$block.type}
                                        <li class="{if $item3.active || $item3|fn_check_is_active_menu_item:$block.type} active{/if}{if $item3.class} {$item3.class}{/if}">
                                            <a{if $item3_url} href="{$item3_url}"{/if}>{$item3.$name}</a>
                                        </li>
                                        {/foreach}
                                        {if $item2.show_more && $item2_url}
                                        <li>
                                            <a href="{$item2_url}"> <p><strong>{__("text_topmenu_view_more")}</strong></p></a>
                                        </li>
                                        {/if}
                                        {/hook}
                                        {/if}
                                    </ul>
                                {/foreach}
                                {if $item1.show_more && $item1_url}
                                    <ul class="list-unstyled">
                                        <li>
                                            <a href="{$item1_url}">{__("text_topmenu_more", ["[item]" => $item1.$name])}</a>
                                        </li>
                                    </ul>
                                {/if}
                            </div>
                        </li>
                    </ul>
                    {/hook}
                    {/if}
                {/if}
            </li>
            {/foreach}
        </ul>
    </div>
    {/hook}
</nav>
{/if}
{/hook}


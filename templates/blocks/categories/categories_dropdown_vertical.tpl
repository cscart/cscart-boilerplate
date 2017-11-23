{** block-description:dropdown_vertical **}

<style>
    .navbar-vertical {
        
    }

    .navbar-vertical .btn-group {
        display: flex;
        width: 100%;
        margin: 0 0;
    }

    .navbar-vertical .btn-group:hover {
        background-color: #000;
    }
    
    .navbar-vertical .btn-group .btn-main {
        display: inline-flex;
        flex-grow: 1;
        padding: 15px 12px;
    }

    .dropdown-menu {
        top: 90%;
        left: 0;
        right: 0;
    }

    .btn-main {
        color: #aaa;
    }

    .btn-caret {
        color: #aaa;
        background-color: #0003;
        padding: 15px 20px !important;
        box-shadow: 0 !important;
    }

    .btn-caret:hover {
        color: #fff;
    }

    .btn-main:hover {
        color: #fff;
    }

    .btn-group {
        margin-left: 0 !important;
    }

    .dropdown-menu {
        padding: 0;
        box-shadow: 1px 1px 3px #0000001a
    }

    .dropdown-menu > li > a {
        display: inline-flex;
        flex-grow: 1;
        width: 100%;
        padding: 15px 12px;
    }
</style>

{assign var="name" value="category"}
{assign var="childs" value="subcategories"}

<nav class="navbar navbar-inverse navbar-vertical">
    {foreach from=$items item="item1" name="item1"}

        <!-- Split button -->
        <div class="btn-group">
            {assign var="item1_url" value=$item1|fn_form_dropdown_object_link:$block.type}
            {assign var="unique_elm_id" value=$item1_url|md5}
            {assign var="unique_elm_id" value="topmenu_`$block.block_id`_`$unique_elm_id`"}

            <a {if $item1_url} href="{$item1_url}"{/if} class="btn btn-main">{$item1.$name}</a>
            {if $item1.$childs}
                <button type="button" class="btn btn-caret dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="caret"></span>
                </button>

                {if !$item1.$childs|fn_check_second_level_child_array:$childs}
                <ul class="dropdown-menu">
                    {hook name="blocks:topmenu_dropdown_2levels_elements"}
                    {foreach from=$item1.$childs item="item2" name="item2"}
                        {assign var="item_url2" value=$item2|fn_form_dropdown_object_link:$block.type}
                        <li><a {if $item_url2} href="{$item_url2}"{/if}>{$item2.$name}</a></li>
                    {/foreach}
                    {/hook}
                </ul>
                {else}
                    <ul class="dropdown-menu">


                        {foreach from=$item1.$childs item="item2" name="item2"}
                            <div class="btn-group">
                            {assign var="item2_url" value=$item2|fn_form_dropdown_object_link:$block.type}
                                    <a {if $item_url2} href="{$item_url2}"{/if} class="btn btn-main">{$item2.$name}</a>
                                    {if $item2.$childs}
                                        <button type="button" class="btn btn-caret dropdown-toggle dropdown-submenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <span class="caret"></span>
                                        </button>

                                        <ul class="dropdown-menu">
                                            {hook name="blocks:topmenu_dropdown_3levels_col_elements"}
                                            {foreach from=$item2.$childs item="item3" name="item3"}
                                                {assign var="item3_url" value=$item3|fn_form_dropdown_object_link:$block.type}
                                                <li class="{if $item3.active || $item3|fn_check_is_active_menu_item:$block.type} active{/if}{if $item3.class} {$item3.class}{/if}">
                                                    <a{if $item3_url} href="{$item3_url}"{/if}>{$item3.$name}</a>
                                                </li>
                                            {/foreach}
                                            {if $item2.show_more && $item2_url}
                                                <li role="separator" class="divider"></li>
                                                <li>
                                                    <a href="{$item2_url}"> <p><strong>{__("text_topmenu_view_more")}</strong></p></a>
                                                </li>
                                            {/if}
                                            {/hook}
                                        </ul>
                                    {/if}
                                
                            </div>
                        {/foreach}


                    </ul>
                {/if}
            {/if}
        </div>

    {/foreach}

</nav>

{* <nav class="navbar navbar-inverse has-submenu no-margin-nav" role="navigation">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar_{$block.block_id}" aria-expanded="false">

            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand visible-xs-inline-block" href="#" data-toggle="collapse" data-target="#navbar_{$block.block_id}">{__("category")}</a>
    </div>

    <div class="collapse navbar-collapse" id="navbar_{$block.block_id}">
        <ul class="nav nav-pills nav-stacked">
            {foreach from=$items item="item1" name="item1"}
                {assign var="item1_url" value=$item1|fn_form_dropdown_object_link:$block.type}
                {assign var="unique_elm_id" value=$item1_url|md5}
                {assign var="unique_elm_id" value="topmenu_`$block.block_id`_`$unique_elm_id`"}
                {if $subitems_count}
                {/if}
                <li class="dropdown {if $item1.active || $item1|fn_check_is_active_menu_item:$block.type} active{/if}{if $item1.class} {$item1.class}{/if}" >
                    <a {if $item1_url} href="{$item1_url}"{/if} class="dropdown-toggle" data-toggle="dropdown">{$item1.$name} <span class="caret"></span></a>

                    {if $item1.$childs}
                        {if !$item1.$childs|fn_check_second_level_child_array:$childs}
                            {* Only two levels. Vertical output *}
                            {*<ul class="dropdown-menu">
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
                        {/if}
                    {/if}
                </li>
            {/foreach}
        </ul>
    </div>
{* </nav> *}

<script>
$(document).ready(function(){
  $('.dropdown-submenu').on("click", function(e){
    $(this).next('ul').toggle();
    e.stopPropagation();
    e.preventDefault();
  });
});
</script>
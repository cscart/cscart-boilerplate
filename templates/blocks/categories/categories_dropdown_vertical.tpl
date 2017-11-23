{** block-description:dropdown_vertical **}

{assign var="name" value="category"}
{assign var="childs" value="subcategories"}

<style>
    .vertical-improve .nav > li > .nav {
        padding-left: 25px;
    }

    .vertical-improve a {
        cursor: pointer;
    }

    .vertical-improve .active > a {
        background-color: #eee;
    }
</style>

<nav class="vertical-improve">
    <ul class="nav">
        {foreach from=$items item="item1" name="item1"}
            {assign var="item1_url" value=$item1|fn_form_dropdown_object_link:$block.type}

            {assign var="unique_elm_id" value=$item1_url|md5}
            {assign var="unique_elm_id" value="topmenu_`$block.block_id`_`$unique_elm_id`"}
            {assign var="unique_elm_child_id" value="topmenu_`$block.block_id`_`$unique_elm_id`_child"}

            <li class="{if $item1.active || $item1|fn_check_is_active_menu_item:$block.type} active{/if}{if $item1.class} {$item1.class}{/if}">
                <a
                    {if $item1.$childs}
                        id="{$unique_elm_id}" 
                        data-toggle="collapse" 
                        data-target="#{$unique_elm_child_id}" 
                        aria-expanded="false"
                    {else}
                        {if $item1_url}href="{$item1_url}"{/if}
                    {/if}
                >{$item1.$name} {if $item1.$childs}<span class="caret"></span>{/if}</a>

                <ul class="nav collapse" id="{$unique_elm_child_id}" role="menu" aria-labelledby="{$unique_elm_id}">
                    {if $item1.$childs}

                        {* below child elements without their own childs *}
                        {if !$item1.$childs|fn_check_second_level_child_array:$childs}

                            {hook name="blocks:topmenu_dropdown_2levels_elements"}

                                {foreach from=$item1.$childs item="item2" name="item2"}
                                    {assign var="item_url2" value=$item2|fn_form_dropdown_object_link:$block.type}

                                    <li class="{if $item2.active || $item2|fn_check_is_active_menu_item:$block.type} active{/if}{if $item2.class} {$item2.class}{/if}">
                                        <a {if $item_url2} href="{$item_url2}"{/if}>{$item2.$name}</a>
                                    </li>
                                {/foreach}

                            {/hook}

                        {* below child elements with their own childs *}
                        {else}
                            
                            {foreach from=$item1.$childs item="item2" name="item2"}
                                {assign var="item2_url" value=$item2|fn_form_dropdown_object_link:$block.type}

                                {assign var="unique_elm_id2" value=$item2_url|md5}
                                {assign var="unique_elm_id2" value="topmenu_`$block.block_id`_`$unique_elm_id2`"}
                                {assign var="unique_elm_child_id2" value="topmenu_`$block.block_id`_`$unique_elm_id2`_child"}

                                <li class="{if $item2.active || $item2|fn_check_is_active_menu_item:$block.type} active{/if}{if $item2.class} {$item2.class}{/if}">
                                    <a 
                                        {if $item2.$childs}
                                            id="{$unique_elm_id2}" 
                                            data-toggle="collapse" 
                                            data-target="#{$unique_elm_child_id2}" 
                                            aria-expanded="false"
                                        {else}
                                            {if $item2_url}href="{$item2_url}"{/if}
                                        {/if}
                                    >{$item2.$name} {if $item2.$childs}<span class="caret"></span>{/if}</a>

                                    <ul class="nav collapse" id="{$unique_elm_child_id2}" role="menu" aria-labelledby="{$unique_elm_id2}">
                                        {if $item2.$childs}

                                            {foreach from=$item2.$childs item="item3" name="item3"}
                                                {assign var="item3_url" value=$item3|fn_form_dropdown_object_link:$block.type}
                                                <li class="{if $item3.active || $item3|fn_check_is_active_menu_item:$block.type} active{/if}{if $item3.class} {$item3.class}{/if}">
                                                    <a{if $item3_url} href="{$item3_url}"{/if}>{$item3.$name}</a>
                                                </li>
                                            {/foreach}
                                        {/if}
                                    </ul>
                                </li>

                            {/foreach}

                        {/if}

                    {/if}
                </ul>
            </li>
        {/foreach}
	</ul>
</nav>
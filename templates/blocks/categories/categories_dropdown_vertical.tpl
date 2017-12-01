{** block-description:dropdown_vertical **}

{$name = "category"}
{$childs = "subcategories"}

<nav class="vertical-improve panel panel-default">
    <ul class="nav">
        {foreach $items as $item_level_1}
            {$item_level_1_url = $item_level_1|fn_form_dropdown_object_link:$block.type}
            {$unique_elm_id = uniqid()}
            {$unique_elm_child_id = "topmenu_`$block.block_id`_`$unique_elm_id`_child"}

            <li class="{if $item_level_1.active || $item_level_1|fn_check_is_active_menu_item:$block.type} active{/if}{if $item_level_1.class} {$item_level_1.class}{/if}">
                <a
                    {if $item_level_1.$childs}
                        id="{$unique_elm_id}" 
                        data-toggle="collapse" 
                        data-target="#{$unique_elm_child_id}" 
                        aria-expanded="false"
                    {/if}
                    {if $item_level_1_url}href="{$item_level_1_url}"{/if}
                ><span class="menu-item__name">{$item_level_1.$name}</span> {if $item_level_1.$childs}<p class="caret"></p>{/if}</a>

                <ul class="nav collapse" id="{$unique_elm_child_id}" role="menu" aria-labelledby="{$unique_elm_id}">
                    {if $item_level_1.$childs}

                        {* below child elements without their own childs *}
                        {if !$item_level_1.$childs|fn_check_second_level_child_array:$childs}

                            {hook name="blocks:topmenu_dropdown_2levels_elements"}

                                {foreach $item_level_1.$childs as $item_level_2}
                                    {$item_level_2_url = $item_level_2|fn_form_dropdown_object_link:$block.type}

                                    <li class="{if $item_level_2.active || $item_level_2|fn_check_is_active_menu_item:$block.type} active{/if}{if $item_level_2.class} {$item_level_2.class}{/if}">
                                        <a {if $item_level_2_url} href="{$item_level_2_url}"{/if}><span class="menu-item__name">{$item_level_2.$name}</span></a>
                                    </li>
                                {/foreach}

                            {/hook}

                        {* below child elements with their own childs *}
                        {else}
                            
                            {foreach $item_level_1.$childs as $item_level_2}
                                {$item_level_2_url = $item_level_2|fn_form_dropdown_object_link:$block.type}
                                {$unique_elm_id2 = uniqid()}
                                {$unique_elm_child_id2 = "topmenu_`$block.block_id`_`$unique_elm_id2`_child"}

                                <li class="{if $item_level_2.active || $item_level_2|fn_check_is_active_menu_item:$block.type} active{/if}{if $item_level_2.class} {$item_level_2.class}{/if}">
                                    <a 
                                        {if $item_level_2.$childs}
                                            id="{$unique_elm_id2}" 
                                            data-toggle="collapse" 
                                            data-target="#{$unique_elm_child_id2}" 
                                            aria-expanded="false"
                                        {/if}
                                        {if $item_level_2_url}href="{$item_level_2_url}"{/if}
                                    ><span class="menu-item__name">{$item_level_2.$name}</span> {if $item_level_2.$childs}<p class="caret"></p>{/if}</a>

                                    <ul class="nav collapse" id="{$unique_elm_child_id2}" role="menu" aria-labelledby="{$unique_elm_id2}">
                                        {if $item_level_2.$childs}

                                            {foreach $item_level_2.$childs as $item_level_3}
                                                {$item_level_3_url = $item_level_3|fn_form_dropdown_object_link:$block.type}
                                                <li class="{if $item_level_3.active || $item_level_3|fn_check_is_active_menu_item:$block.type} active{/if}{if $item_level_3.class} {$item_level_3.class}{/if}">
                                                    <a{if $item_level_3_url} href="{$item_level_3_url}"{/if}><span class="menu-item__name">{$item_level_3.$name}</span></a>
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
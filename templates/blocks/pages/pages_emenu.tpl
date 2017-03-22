{** block-description:dropdown_vertical **} 

<div class="menu menu-vertical">
    <ul id="vmenu_{$block.block_id}" class="nav nav-pills nav-stacked menu-items list-unstyled {if $block.properties.right_to_left_orientation =="Y"} rtl{/if}">
        {include file="blocks/sidebox_dropdown.tpl" items=$items separated=true submenu=false name="page" item_id="page_id" childs="subpages"}
    </ul>
</div>
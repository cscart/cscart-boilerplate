{** block-description:dropdown_vertical **}

<nav class="menu menu-vertical">
    <ul id="vmenu_{$block.block_id}" class="menu-items cm-responsive-menu{if $block.properties.right_to_left_orientation =="Y"} rtl{/if}">
        {include file="blocks/sidebox_dropdown.tpl" items=$items separated=true submenu=false name="item" item_id="param_id" childs="subitems"}
    </ul>
</nav>
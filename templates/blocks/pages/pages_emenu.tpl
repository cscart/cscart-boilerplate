{** block-description:dropdown_vertical **} 

<div class="menu menu-vertical">
    <ul id="vmenu_{$block.block_id}">
        {include file="blocks/sidebox_dropdown.tpl" items=$items separated=true submenu=false name="page" item_id="page_id" childs="subpages"}
    </ul>
</div>
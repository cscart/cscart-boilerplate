{strip}

{if !$no_wrap}
    <div class="wysiwyg-content" {live_edit name="block:content:{$block.block_id}" phrase=$content need_render=true}>
{/if}

{eval_string var=$content}

{if !$no_wrap}
    </div>
{/if}

{/strip}
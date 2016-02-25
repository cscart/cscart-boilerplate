{if $content|strip|trim}
<!-- {$block.name} start -->
<div class="{if $block.user_class} {$block.user_class}{/if}{if $content_alignment == 'RIGHT'} pull-right{elseif $content_alignment == 'LEFT'} pull-left{/if}">
    {$content nofilter}
</div>
<!-- {$block.name} end -->
{/if}
{if $content|trim}
<!-- Click dropdown wrapper start -->
<div class="dropdown {if $block.user_class} {$block.user_class}{/if}{if $content_alignment == "RIGHT"} pull-right{elseif $content_alignment == "LEFT"} pull-left{/if}">
    {assign var="dropdown_id" value=$block.snapping_id}
    <button class="btn btn-default dropdown-toggle" type="button" id="dropdown_{$dropdown_id}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
        {hook name="wrapper:onclick_dropdown_title"}
            {$title nofilter}
        {/hook}
        <span class="caret"></span>
    </button>
    <div class="dropdown-menu {if $header_class}{$header_class}{/if}" aria-labelledby="dropdown_{$dropdown_id}">
        {$content|default:"&nbsp;" nofilter}
    </div>
</div>
<!-- Click dropdown wrapper end -->
{/if}
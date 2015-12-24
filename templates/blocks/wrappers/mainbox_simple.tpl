{if $content|trim}
    <!-- Mainbox simple wrapper start -->
    <div class="mainbox-simple-container clearfix{if isset($hide_wrapper)} cm-hidden-wrapper{/if}{if $hide_wrapper} hidden{/if}{if $block.user_class} {$block.user_class}{/if}{if $content_alignment == "RIGHT"} pull-right{elseif $content_alignment == "LEFT"} pull-left{/if}">
        {if $title || $smarty.capture.title|trim}
            <h2 class="mainbox-simple-title">
                {hook name="wrapper:mainbox_simple_title"}
                {if $smarty.capture.title|trim}
                    {$smarty.capture.title nofilter}
                {else}
                    {$title nofilter}
                {/if}
                {/hook}
            </h2>
        {/if}
        <div class="mainbox-simple-body">{$content nofilter}</div>
    </div>
    <!-- Mainbox simple wrapper end -->
{/if}
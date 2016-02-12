{if $content|trim}
    <!-- Mainbox general wrapper start -->
    <div class="mainbox-container clearfix{if isset($hide_wrapper)} cm-hidden-wrapper{/if}{if $hide_wrapper} hidden{/if}{if $details_page} details-page{/if}{if $block.user_class} {$block.user_class}{/if}{if $content_alignment == "RIGHT"} pull-right{elseif $content_alignment == "LEFT"} pull-left{/if}">
        {if $title || $smarty.capture.title|trim}
            {hook name="wrapper:mainbox_general_title_wrapper"}
                <div class="page-header">
                    <h1>
                        {hook name="wrapper:mainbox_general_title"}
                        {if $smarty.capture.title|trim}
                            {$smarty.capture.title nofilter}
                        {else}
                            {$title nofilter}
                        {/if}
                        {/hook}
                    </h1>
                </div>
            {/hook}
        {/if}
        <div class="mainbox-body">{$content nofilter}</div>
    </div>
    <!-- Mainbox general wrapper end -->
{/if}
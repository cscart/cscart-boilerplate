{** block-description:boiler_plate_mainbox_h3 **}
{if $content|trim}
    <!-- Footer wrapper start -->
    <div class="{$sidebox_wrapper|default:"footer-section"}{if isset($hide_wrapper)} cm-hidden-wrapper{/if}{if $hide_wrapper} hidden{/if}{if $block.user_class} {$block.user_class}{/if}{if $content_alignment == "RIGHT"} pull-right{elseif $content_alignment == "LEFT"} pull-left{/if}">
        <h3 class="{if $header_class} {$header_class}{/if}">
            {hook name="wrapper:footer_general_title"}
            {if $smarty.capture.title|trim}
                {$smarty.capture.title nofilter}
            {else}
                <span>{$title nofilter}</span>
            {/if}
            {/hook}
        </h3>
        <div class="footer-general-body">{$content|default:"&nbsp;" nofilter}</div>
    </div>
    <!-- Footer wrapper end -->
{/if}
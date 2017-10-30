{** block-description:boiler_plate_sidebox_h3_deprecated **}
{if $content|trim}
    <!-- Sidebox general wrapper start -->
    <aside class="{$sidebox_wrapper|default:"sidebox"}{if isset($hide_wrapper)} cm-hidden-wrapper{/if}{if $hide_wrapper} hidden{/if}{if $block.user_class} {$block.user_class}{/if}{if $content_alignment == "RIGHT"} pull-right{elseif $content_alignment == "LEFT"} pull-left{/if}">
        <h5 class="text-uppercase {if $header_class} {$header_class}{/if}">
            {hook name="wrapper:sidebox_general_title"}
                <strong>
                {if $smarty.capture.title|trim}
                    {$smarty.capture.title nofilter}
                {else}
                    {$title nofilter}
                {/if}
                </strong>
            {/hook}
        </h5>
        <div class="sidebox-body">{$content|default:"&nbsp;" nofilter}</div>
    </aside>
    <!-- Sidebox general wrapper end -->
{/if}
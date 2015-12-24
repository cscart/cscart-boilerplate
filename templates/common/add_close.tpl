{if $is_js == true}
    {include file="common/button.tpl" name="submit" text=$close_text onclick=$close_onclick meta="btn-primary cm-process-items cm-dialog-closer"}&nbsp;
    {if $text}
        {include file="common/button.tpl" name="submit" text=$text onclick=$onclick meta="btn-primary cm-process-items"}&nbsp;
    {/if}
{else}
    {include file="common/button.tpl" name="submit" text=$close_text meta="cm-process-items"}
{/if}
<a class="cm-dialog-closer btn btn-default pull-right">{__("cancel")}</a>
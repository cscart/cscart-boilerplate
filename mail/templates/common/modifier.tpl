{strip}
{if $is_integer == true}{assign var="mod_value" value=$mod_value|round}{/if}
{if $display_sign}{if $mod_value > 0}+{else}-{/if}{/if}
{if $mod_type == 'A' || $mod_type == 'F'}
    {include file="common/price.tpl" value=$mod_value|abs}
{else}
    {if $span_id && !$no_ids}<span id="{$span_id}" class="{$class}">{/if}{$mod_value|abs}{if $span_id && !$no_ids}</span>{/if}%
{/if}
{/strip}
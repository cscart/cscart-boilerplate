{strip}
{if $is_integer == true}{assign var="mod_value" value=$mod_value|round}{/if}
{if $display_sign}{if $class}<span class="{$class}">{/if}{if $mod_value > 0}+{else}-{/if}{if $class}</span>{/if}{/if}
{if $mod_type == "A" || $mod_type == "F"}
    {include file="common/price.tpl" value=$mod_value|abs}
{else}
    {if ($span_id && !$no_ids) || $class}<span id="{$span_id}" class="{$class}">{/if}{$mod_value|abs}{if ($span_id && !$no_ids) || $class}</span>{/if}{if $class}<span class="{$class}">{/if}%{if $class}</span>{/if}
{/if}
{/strip}
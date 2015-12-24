{strip}
{if $settings.General.alternative_currency == "use_selected_and_alternative"}
    {$value|format_price:$currencies.$primary_currency:$span_id:$class:false:$live_editor_name:$live_editor_phrase nofilter}
    {if $secondary_currency != $primary_currency}
        &nbsp;
        {if $class}<span class="{$class}">{/if}
        (
        {if $class}</span>{/if}
        {$value|format_price:$currencies.$secondary_currency:$span_id:$class:true:$is_integer:$live_editor_name:$live_editor_phrase nofilter}
        {if $class}<span class="{$class}">{/if}
        )
        {if $class}</span>{/if}
    {/if}
{else}
    {$value|format_price:$currencies.$secondary_currency:$span_id:$class:true:$live_editor_name:$live_editor_phrase nofilter}
{/if}
{/strip}
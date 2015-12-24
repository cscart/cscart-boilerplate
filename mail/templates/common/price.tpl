{strip}
{if $settings.General.alternative_currency == "use_selected_and_alternative"}
    {$value|format_price:$currencies.$primary_currency:$span_id:$class nofilter}{if $secondary_currency != $primary_currency}&nbsp;({$value|format_price:$currencies.$secondary_currency:$span_id:$class:true nofilter}){/if}
{else}
    {$value|format_price:$currencies.$secondary_currency:$span_id:$class:true nofilter}
{/if}
{/strip}
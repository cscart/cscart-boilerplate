{if $currencies && $currencies|count > 1}
<div id="currencies_{$block.block_id}">
    {if $dropdown_limit > 0 && $currencies|count <= $dropdown_limit}
        <div class="visible-lg-block btn-group" role="group">
            {if $text}<div class="currencies-txt">{$text}:</div>{/if}
            {foreach from=$currencies key=code item=currency}
                <a href="{$config.current_url|fn_link_attach:"currency=`$code`"|fn_url}" rel="nofollow" type="button" class="btn btn-default {if $secondary_currency == $code}active{/if}">{if $format == "name"}{$currency.description}&nbsp;({$currency.symbol nofilter}){else}{$currency.symbol nofilter}{/if}</a>
            {/foreach}
        </div>
        <div class="hidden-lg select-wrapper">
            {include file="common/select_object.tpl" style="graphic" suffix="currency" link_tpl=$config.current_url|fn_link_attach:"currency=" items=$currencies selected_id=$secondary_currency display_icons=false key_name=$key_name}</div>
    {else}
        {if $format == "name"}
            {assign var="key_name" value="description"}
        {else}
            {assign var="key_name" value=""}
        {/if}
        <div class="select-wrapper">{include file="common/select_object.tpl" style="graphic" suffix="currency" link_tpl=$config.current_url|fn_link_attach:"currency=" items=$currencies selected_id=$secondary_currency display_icons=false key_name=$key_name}</div>
    {/if}
<!--currencies_{$block.block_id}--></div>
{/if}
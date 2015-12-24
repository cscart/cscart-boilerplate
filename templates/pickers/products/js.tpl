<tr {if !$clone}id="{$root_id}_{$delete_id}" {/if}class="cm-js-item{if $clone} cm-clone hidden{/if}">
<td>
    <ul class="list-unstyled">
        <li>{$product}
            {if !$view_only}
                <a href="javascript: Tygh.$.cePicker('delete_js_item', '{$root_id}', '{$delete_id}', 'p');" class="delete-big" title="{__("remove")}"><i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i></a>
            {/if}
        </li>
        {if $options}
        <li>{$options nofilter}</li>
        {/if}
    </ul>
    {if $options_array|is_array}
        {foreach from=$options_array item="option" key="option_id"}
        <input type="hidden" name="{$input_name}[product_options][{$option_id}]" value="{$option}"{if $clone} disabled="disabled"{/if} />
        {/foreach}
    {/if}
    {if $product_id}
        <input type="hidden" name="{$input_name}[product_id]" value="{$product_id}"{if $clone} disabled="disabled"{/if} />
    {/if}
    {if $amount_input == "hidden"}
    <input type="hidden" name="{$input_name}[amount]" value="{$amount}"{if $clone} disabled="disabled"{/if} />
    {/if}
</td>
    {if $amount_input == "text"}
<td class="center">
    <input type="text" name="{$input_name}[amount]" value="{$amount}" size="3" class="form-control"{if $clone} disabled="disabled"{/if} />
</td>
    {/if}
</tr>

{if !$order_status_descr}
    {if !$status_type}{assign var="status_type" value=$smarty.const.STATUSES_ORDER}{/if}
    {assign var="order_status_descr" value=$status_type|fn_get_simple_statuses}
{/if}

{strip}
{if $display == "view"}
    {$order_status_descr.$status}
{elseif $display == "select"}
    {html_options name=$name options=$order_status_descr selected=$status id=$select_id}
{elseif $display == "checkboxes"}
    <div class="status-info">
    	{foreach from=$order_status_descr item=stat key=stat_key}
    		{$is_checked = false}
    		{foreach from=$status item=selected}
    			{if $stat_key == $selected}
    				{$is_checked = true}
    			{/if}
    		{/foreach}
    		<div class="checkbox">
    			<label>
    				<input type="checkbox" name="{$name}[]" value="{$stat_key}" {if $is_checked} checked="checked"{/if}>
    				{$stat}
    			</label>
    		</div>
    	{/foreach}
    </div>
{/if}
{/strip}

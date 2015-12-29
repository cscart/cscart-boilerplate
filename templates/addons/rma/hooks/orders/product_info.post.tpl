{if $product.returns_info}
    {if !$return_statuses}{assign var="return_statuses" value=$smarty.const.STATUSES_RETURN|fn_get_simple_statuses}{/if}
    <div>
        <a class="cm-combination combination-link" id="sw_ret_{$key}">
            <i title="{__("expand_sublist_of_items")}" id="on_ret_{$key}" class="glyphicon glyphicon-triangle-right fa fa-angle-right dir-list"></i>
            <i title="{__("collapse_sublist_of_items")}" id="off_ret_{$key}" class="glyphicon glyphicon-triangle-bottom fa fa-angle-down hidden"></i>{__("returns_info")}
        </a>
    </div>
    <div class="hidden" id="ret_{$key}">
        {foreach from=$product.returns_info item="amount" key="status" name="f_rinfo"}
            <p><strong>{$return_statuses.$status|default:""}</strong>:&nbsp;{$amount} {__("items")}</p>
        {/foreach}
    </div>
{/if}

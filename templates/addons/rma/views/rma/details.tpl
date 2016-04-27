<div class="rma-detail">
    <div class="rma-detail-actions">
        {include file="common/button.tpl" text=__("print_slip") href="rma.print_slip?return_id=`$return_info.return_id`" meta="cm-new-window" icon="glyphicon glyphicon-print fa fa-print"}

        {include file="common/button.tpl" text=__("related_order") href="orders.details?order_id=`$return_info.order_id`" meta="btn__text" icon="glyphicon glyphicon-arrow-left fa fa-arrow-left"}
    </div>

{if $return_info}
<form action="{""|fn_url}" method="post" name="return_info_form" />
<input type="hidden" name="return_id" value="{$smarty.request.return_id}" />
<input type="hidden" name="order_id" value="{$return_info.order_id}" />
<input type="hidden" name="total_amount" value="{$return_info.total_amount}" />
<input type="hidden" name="return_status" value="{$return_info.status}" />
{capture name="tabsbox"}
{** RETURN PRODUCTS SECTION **}
    <div id="content_return_products" >
        {if $return_info.items[$smarty.const.RETURN_PRODUCT_ACCEPTED]}
        <table class="table rma-detail__table">
            <thead>
            <tr>
                <th>{__("product")}</th>
                <th>{__("price")}</th>
                <th>{__("quantity")}</th>
                <th>{__("reason")}</th>
            </tr>
        </thead>
        {foreach from=$return_info.items[$smarty.const.RETURN_PRODUCT_ACCEPTED] item="ri" key="key"}
        <tr>
            <td>{if !$ri.deleted_product}<a href="{"products.view?product_id=`$ri.product_id`"|fn_url}">{/if}{$ri.product nofilter}{if !$ri.deleted_product}</a>{/if}
                {if $ri.product_options}
                    {include file="common/options_info.tpl" product_options=$ri.product_options}
                {/if}</td>
            <td class="right">
                {if !$ri.price}{__("free")}{else}{include file="common/price.tpl" value=$ri.price}{/if}</td>
            <td class="center">{$ri.amount}</td>
            <td class="nowrap">
                {assign var="reason_id" value=$ri.reason}
                {$reasons.$reason_id.property}</td>
        </tr>
        {/foreach}
        </table>
        {else}
            <div class="well well-lg">{__("text_no_products_found")}</div>
        {/if}
    </div>
{** /RETURN PRODUCTS SECTION **}

{** DECLINED PRODUCTS SECTION **}
    <div id="content_declined_products" >
        {if $return_info.items[$smarty.const.RETURN_PRODUCT_DECLINED]}
        <table class="table rma-detail-table">
        <thead>
        <tr>
                <th>{__("product")}</th>
                <th>{__("price")}</th>
                <th>{__("quantity")}</th>
                <th>{__("reason")}</th>
            </tr>
        </thead>
        {foreach from=$return_info.items[$smarty.const.RETURN_PRODUCT_DECLINED] item="ri" key="key"}
        <tr>
            <td>
                {if !$ri.deleted_product}<a href="{"products.view?product_id=`$ri.product_id`"|fn_url}">{/if}{$ri.product nofilter}{if !$ri.deleted_product}</a>{/if}
                {if $ri.product_options}
                    {include file="common/options_info.tpl" product_options=$ri.product_options}
                {/if}</td>
            <td class="right nowrap">
                {if !$ri.price}{__("free")}{else}{include file="common/price.tpl" value=$ri.price}{/if}</td>
            <td class="center">{$ri.amount}</td>
            <td class="nowrap">
                {assign var="reason_id" value=$ri.reason}
                {$reasons.$reason_id.property}</td>
        </tr>
        {/foreach}
        </table>
        {else}
            <div class="well well-lg">{__("text_no_products_found")}</div>
        {/if}
    </div>
{** /DECLINED PRODUCTS SECTION **}

{/capture}
{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section}
{if $return_info.comment}
    <div class="rma-comments">
        <h4>{__("comments")}</h4>
        <div class="panel panel-default">
            <div class="panel-body">
                {$return_info.comment|nl2br nofilter}
            </div>
        </div>
    </div>
{/if}
</form>
{/if}

{capture name="mainbox_title"}
    {__("return_info")}&nbsp;#{$return_info.return_id}
    <small class="date">
        ({$return_info.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"})
    </small>
    <span class="status">
        <small>
            <strong>{__("status")}:</strong> {include file="common/status.tpl" status=$return_info.status display="view" name="update_return[status]" status_type=$smarty.const.STATUSES_RETURN}
        </small>
        <small class="rma-status">
            <strong>{__("action")}:</strong> {assign var="action_id" value=$return_info.action}{$actions.$action_id.property}
        </small>
    </span>
{/capture}
</div>
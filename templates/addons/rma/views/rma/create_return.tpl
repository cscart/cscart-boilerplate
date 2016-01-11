<div class="rma-register">
    <form action="{""|fn_url}" method="post" name="return_registration_form">
    <input name="order_id" type="hidden" value="{$smarty.request.order_id}" />
    <input name="user_id" type="hidden" value="{$order_info.user_id}" />

    {if $actions}
        <div class="rma-register-actions row">
            <label class="form-label col-lg-12">{__("what_you_would_like_to_do")}:</label>
            <div class="col-lg-4">
                <select class="form-control" name="action">
                    {foreach from=$actions item="action" key="action_id"}
                        <option value="{$action_id}">{$action.property}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    {/if}
    
    {if $order_info.products}
    <table class="table rma-register-table">
    <thead>
        <tr>
            <th class="center">
                <input type="checkbox" name="check_all" value="Y" title="{__("check_uncheck_all")}" class="cm-check-items" /></th>
            <th>{__("product")}</th>
            <th class="right">{__("price")}</th>
            <th>{__("quantity")}</th>
            <th>{__("reason")}</th>
        </tr>
    </thead>
    <tbody>
    {foreach from=$order_info.products item="oi" key="key"}
        <tr>
            <td class="center">
                <input type="checkbox" name="returns[{$oi.cart_id}][chosen]" id="delete_checkbox" value="Y" class="cm-item" />
                <input type="hidden" name="returns[{$oi.cart_id}][product_id]" value="{$oi.product_id}" />
            </td>
            <td style="width: 60%" class="left">
                <a href="{"products.view?product_id=`$oi.product_id`"|fn_url}">{$oi.product nofilter}</a>
                {if $oi.product_options}
                    {include file="common/options_info.tpl" product_options=$oi.product_options}
                {/if}
            </td>
            <td class="right nowrap">
                {if $oi.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$oi.price}{/if}
            </td>
            <td class="center">
                <input type="hidden" name="returns[{$oi.cart_id}][available_amount]" value="{$oi.amount}" />
                <select name="returns[{$oi.cart_id}][amount]" class="form-control">
                {section name=$key loop=$oi.amount+1 start="1" step="1"}
                        <option value="{$smarty.section.$key.index}">{$smarty.section.$key.index}</option>
                {/section}
                </select>
            </td>
            <td class="center">
                {if $reasons}
                    <select name="returns[{$oi.cart_id}][reason]" class="form-control">
                    {foreach from=$reasons item="reason" key="reason_id"}
                        <option value="{$reason_id}">{$reason.property}</option>
                    {/foreach}
                    </select>
                {/if}
            </td>
        </tr>
    {/foreach}
    </tbody>
    </table>
    {else}
        <div class="well well-lg">
            {__("no_items")}
        </div>
    {/if}

    <div class="rma-register-comments form-group">
        <strong class="rma-register-comments-title">{__("type_comment")}</strong>
        <textarea name="comment" cols="3" rows="4" class="form-control"></textarea>
    </div>

    <div class="panel panel-default buttons-container">
        <div class="panel-body">
            {include file="common/button.tpl" text=__("rma_return") name="dispatch[rma.add_return]" meta="cm-process-items" meta="btn-primary"}
        </div>
    </div>

    </form>
</div>

{capture name="mainbox_title"}{__("return_registration")}{/capture}
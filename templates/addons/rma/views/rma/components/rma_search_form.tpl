<form action="{""|fn_url}" name="rma_search_form" method="get" class="rma-search">

<div class="form-inline">
    <div class="form-group">
        <label class="control-label" for="qty">{__("quantity")}</label>
        <input id="qty" type="text" name="rma_amount_from" value="{$smarty.request.rma_amount_from}" size="3" class="form-control" />&nbsp;-&nbsp;<input type="text" name="rma_amount_to" value="{$smarty.request.rma_amount_to}" size="3" class="form-control" />
    </div>
</div>

<div class="form-group">
    <label class="control-label" for="r_id">{__("rma_return")}</label>
    <input id="r_id" type="text" name="return_id" value="{$smarty.request.return_id}" size="30" class="form-control" />
</div>

<div class="form-group">
    <label class="control-label">{__("return_status")}</label>
    <div class="rma-search__status">
        {include file="common/status.tpl" status=$smarty.request.request_status display="checkboxes" name="request_status" status_type=$smarty.const.STATUSES_RETURN}
    </div>
</div>

{include file="common/period_selector.tpl" period=$smarty.request.period}

<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab">
            <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#search_by_order" aria-expanded="false" aria-controls="collapseTwo">
                {__("search_by_order")}
            </a>
        </h4>
    </div>
        <div id="search_by_order" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label" for="r_id">{__("order")}&nbsp;{__("id")}</label>
                    <input type="text" name="order_id" value="{$smarty.request.order_id}" size="30" class="form-control" />
                </div>
                
                <div class="form-group">
                    <label class="control-group__title" for="r_id">{__("order_status")}</label>
                    <div class="rma-search__status">
                        {include file="common/status.tpl" status=$smarty.request.order_status display="checkboxes" name="order_status"}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="rma-search__buttons buttons-container">
    {if $action}
        {assign var="_action" value="$action"}
    {/if}
    {include file="common/button.tpl" text=__("search") name="dispatch[`$runtime.controller`.`$runtime.mode`.`$runtime.action`]" meta="btn-primary"}
</div>
</form>
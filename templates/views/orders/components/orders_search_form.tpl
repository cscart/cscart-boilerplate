<form action="{""|fn_url}" name="orders_search_form" method="get">

    <div class="form-group">
        <label class="control-label">{__("total")}&nbsp;({$currencies.$secondary_currency.symbol nofilter})</label>
        <div class="row">
            <div class="col-xs-1">
                <input type="text" name="total_from" value="{$search.total_from}" size="3" class="form-control" />
            </div>
            <span class="pull-left">
                &nbsp;&#8211;&nbsp;
            </span>
            <div class="col-xs-1">
                <input type="text" name="total_to" value="{$search.total_to}" size="3" class="form-control" />
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label">{__("order_status")}</label>
        {include file="common/status.tpl" status=$search.status display="checkboxes" name="status"}
    </div>
    
    <div class="form-group">
        {include file="common/period_selector.tpl" period=$search.period}
    </div>

    {if $auth.user_id}
    <div class="form-group">
        <label class="control-label">{__("order_id")}</label>
        <div class="row">
            <div class="col-xs-3">
                <input type="text" name="order_id" value="{$search.order_id}" size="10" class="form-control" />
            </div>
        </div>
    </div>
    {/if}

    <div class="buttons-container">
        {include file="common/button.tpl" meta="btn-primary" text=__("search") name="dispatch[orders.search]"}
    </div>
</form>
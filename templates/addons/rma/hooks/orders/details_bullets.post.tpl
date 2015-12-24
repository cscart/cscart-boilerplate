{if $order_info.allow_return}
    {include file="common/button.tpl" text=__("return_registration") href="rma.create_return?order_id=`$order_info.order_id`" icon="glyphicon glyphicon-arrow-left fa fa-arrow-left"}
{/if}
{if $order_info.isset_returns}
    {include file="common/button.tpl" meta="btn-link" text=__("order_returns") href="rma.returns?order_id=`$order_info.order_id`" icon="glyphicon glyphicon-arrow-left fa fa-arrow-left"}
{/if}
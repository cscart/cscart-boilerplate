{assign var="discussion" value=$order_info.order_id|fn_get_discussion:"O"}
{if $addons.discussion.order_initiate == "Y" && !$discussion}
    {include file="common/button.tpl" text=__("start_communication") href="orders.initiate_discussion?order_id=`$order_info.order_id`" icon="glyphicon glyphicon-comment fa fa-comments"}
{/if}
<html>
<head>
<title>{$order_action}</title>
{include file="common/styles.tpl"}
</head>

<body class="clear-body" {if $onload}onload="{$onload}"{/if}>
    {if $order_action}
    <div class="order-status">
        {$order_action}. {__("please_be_patient")}...
    </div>
    {/if}

    <div id="place_order_data">{$payment_content}</div>
</body>
</html>

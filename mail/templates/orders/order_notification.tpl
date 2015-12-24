{include file="common/letter_header.tpl"}

{__("dear")} {$order_info.firstname},<br /><br />

{$order_status.email_header nofilter}<br /><br />

{assign var="order_header" value=__("invoice")}
{if $status_settings.appearance_type == "C" && $order_info.doc_ids[$status_settings.appearance_type]}
    {assign var="order_header" value=__("credit_memo")}
{elseif $status_settings.appearance_type == "O"}
    {assign var="order_header" value=__("order_details")}
{/if}

<b>{$order_header}:</b><br />

{include file="orders/invoice.tpl"}

{include file="common/letter_footer.tpl"}
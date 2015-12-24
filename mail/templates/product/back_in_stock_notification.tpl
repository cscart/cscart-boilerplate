{include file="common/letter_header.tpl"}

{__("dear")} {__("customer")},<br /><br />

{__("back_in_stock_notification_header")}<br /><br />
{assign var="suffix" value=""}
{if "ULTIMATE"|fn_allowed_for}
    {assign var="suffix" value="&company_id=`$product.company_id`"}
{/if}

<b><a href="{"products.view?product_id=`$product_id``$suffix`"|fn_url:'C':'http'}">{$product.name nofilter}</a></b><br /><br />

{__("back_in_stock_notification_footer")}<br />

{include file="common/letter_footer.tpl"}
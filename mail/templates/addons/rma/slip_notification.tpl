{include file="common/letter_header.tpl"}

{__("dear")} {$order_info.firstname},<br /><br />

{$return_status.email_header nofilter}<br /><br />

<b>{__("packing_slip")}:</b><br />

{include file="addons/rma/slip.tpl"}

{include file="common/letter_footer.tpl"}
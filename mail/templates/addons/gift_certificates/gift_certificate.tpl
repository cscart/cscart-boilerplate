{include file="common/letter_header.tpl"}

{__("dear")} {$gift_cert_data.recipient},<br /><br />

{$certificate_status.email_header nofilter}<br /><br />

{include file="addons/gift_certificates/templates/default.tpl"}
    
{include file="common/letter_footer.tpl"}
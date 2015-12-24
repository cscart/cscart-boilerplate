{include file="common/letter_header.tpl"}

{__("dear")} {$order_info.firstname},<br /><br />

{__("edp_access_granted")}<br /><br />

{foreach from=$order_info.products item="oi"}
{if $oi.extra.is_edp == 'Y' && $edp_data[$oi.product_id].files}
{assign var="first_file" value=$edp_data[$oi.product_id].files|reset}
<a href="{"orders.downloads?product_id=`$oi.product_id`&ekey=`$first_file.ekey`"|fn_url:'C':'http'}"><b>{$oi.product}</b></a><br />
<p></p>
{foreach from=$edp_data[$oi.product_id].files item="file" key="file_id"}
<a href="{"orders.get_file?file_id=`$file.file_id`&product_id=`$oi.product_id`&ekey=`$file.ekey`"|fn_url:'C':'http'}">{$file.file_name} ({$file.file_size|number_format:0:'':' '}&nbsp;{__("bytes")})</a><br /><br />
{/foreach}
{/if}
{/foreach}

{include file="common/letter_footer.tpl"}
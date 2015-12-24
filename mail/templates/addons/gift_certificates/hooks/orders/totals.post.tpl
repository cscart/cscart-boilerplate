{if $order_info.use_gift_certificates}
{foreach from=$order_info.use_gift_certificates item="certificate" key="code"}
<tr>
    <td colspan="2" style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">
        <b>{__("gift_certificate")}</b> {$code} ({include file="common/price.tpl" value=$certificate.cost})</td>
</tr>
{/foreach}
{/if}
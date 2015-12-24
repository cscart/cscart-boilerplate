{if $order_info.return}
<tr>
    <td><strong>{__("rma_return")}:</strong></td>
    <td><strong>{include file="common/price.tpl" value=$order_info.return}</strong></td>
</tr>
{/if}
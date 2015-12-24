{if $order_info.use_gift_certificates}
    {foreach from=$order_info.use_gift_certificates item="certificate" key="code" name="certs"}
        <tr>
            <td>{if $order_info.payment_id == 0 && $smarty.foreach.certs.first}<strong>{__("payment_method")}:</strong>{/if}&nbsp;</td>
            <td>
            {__("gift_certificate")}: <a href="{"gift_certificates.verify?verify_code=`$code`"|fn_url}">{$code}</a> ({include file="common/price.tpl" value=$certificate.cost})
            </td>
        </tr>
    {/foreach}
{/if}
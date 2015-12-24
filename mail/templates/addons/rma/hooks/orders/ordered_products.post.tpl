{if $order_info.returned_products}
{if $order_info.products}<p></p>{/if}
    <table cellpadding="2" cellspacing="1" border="0" width="100%" bgcolor="#000000">
    <tr>
        <td width="10%" align="center" bgcolor="#dddddd"><b>{__("sku")}</b></td>
        <td width="60%" bgcolor="#dddddd"><b>{__("returned_product")}</b></td>
        <td width="10%" align="center" bgcolor="#dddddd"><b>{__("amount")}</b></td>
        <td width="10%" align="center" bgcolor="#dddddd"><b>{__("subtotal")}</b></td>
    </tr>    
    {foreach from=$order_info.returned_products item='oi'}
    <tr>
        <td bgcolor="#ffffff">{$oi.product_code|default:"&nbsp;"}</td>
        <td bgcolor="#ffffff">
            {$oi.product}
            {hook name="orders:product_info"}
            {/hook}
            {if $oi.product_options}<div style="padding-top: 1px; padding-bottom: 2px;">{include file="common/options_info.tpl" product_options=$oi.product_options}</div>{/if}</td>
        <td bgcolor="#ffffff" align="center">{$oi.amount}</td>
        <td align="right" bgcolor="#ffffff"><b>{if $oi.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$oi.subtotal}{/if}</b>&nbsp;</td>
    </tr>
    {/foreach}
    </table>
{/if}
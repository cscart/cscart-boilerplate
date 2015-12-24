{if $oi.extra.buy_together}
    {assign var="conf_oi" value=$oi}
    {assign var="conf_price" value=$oi.price|default:"0"}
    {assign var="conf_subtotal" value=$oi.display_subtotal|default:"0"}
    {assign var="conf_discount" value=$oi.extra.discount|default:"0"}
    {assign var="conf_tax" value=$oi.tax_value|default:"0"}
    
    
    {foreach from=$order_info.products item="sub_oi"}
        {if $sub_oi.extra.parent.buy_together && $sub_oi.extra.parent.buy_together==$oi.cart_id}
            {capture name="is_conf"}1{/capture}
            {math equation="item_price * amount + conf_price" item_price=$sub_oi.price|default:"0" amount=$sub_oi.extra.min_qty|default:"1" conf_price=$conf_price|default:$oi.price assign="conf_price"}    
            {math equation="discount + conf_discount" discount=$sub_oi.extra.discount|default:"0" conf_discount=$conf_discount|default:"0" assign="conf_discount"}
            {math equation="tax + conf_tax" tax=$sub_oi.tax_value|default:"0" conf_tax=$conf_tax|default:"0" assign="conf_tax"}
            {math equation="subtotal + conf_subtotal" subtotal=$sub_oi.display_subtotal|default:"0" conf_subtotal=$conf_subtotal|default:$oi.display_subtotal assign="conf_subtotal"}
        {/if}
    {/foreach}
    <tr>
        <td style="padding: 5px 10px; background-color: #ffffff;">{$oi.product}
            {hook name="orders:product_info"}
            {if $oi.product_code}<p>{__("sku")}:&nbsp;{$oi.product_code}</p>{/if}
            {/hook}
            {if $oi.product_options}<div style="padding-top: 1px; padding-bottom: 2px;">{include file="common/options_info.tpl" product_options=$oi.product_options}</div>{/if}</td>
        <td style="padding: 5px 10px; background-color: #ffffff; text-align: center;">{$oi.amount}</td>
        <td style="padding: 5px 10px; background-color: #ffffff; text-align: right;">{include file="common/price.tpl" value=$conf_price|default:0}</td>
        {if $order_info.use_discount}
        <td style="padding: 5px 10px; background-color: #ffffff; text-align: right;">{if $conf_discount|floatval}{include file="common/price.tpl" value=$conf_discount}{else}&nbsp;-&nbsp;{/if}</td>
        {/if}
        {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
        <td style="padding: 5px 10px; background-color: #ffffff; text-align: right;">{if $conf_tax}{include file="common/price.tpl" value=$conf_tax}{else}&nbsp;-&nbsp;{/if}</td>
        {/if}

        <td style="padding: 5px 10px; background-color: #ffffff; text-align: right;"><b>{include file="common/price.tpl" value=$conf_subtotal}</b>&nbsp;</td>
    </tr>
    {if $smarty.capture.is_conf}
    <tr>
        {assign var="_colspan" value="4"}
        {if $order_info.use_discount}{assign var="_colspan" value=$_colspan+1}{/if}
        {if $order_info.taxes}{assign var="_colspan" value=$_colspan+1}{/if}
        <td style="padding: 5px 10px; background-color: #ffffff;" colspan="{$_colspan}">
            <p>{__("buy_together")}:</p>


        <table width="100%" cellpadding="0" cellspacing="1" style="background-color: #dddddd;">
        <tr>
            <th width="70%" style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("product")}</th>
            <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("amount")}</th>
            <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("unit_price")}</th>
            {if $order_info.use_discount}
            <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("discount")}</th>
            {/if}
            {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
            <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("tax")}</th>
            {/if}
            <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("subtotal")}</th>
        </tr>
        {foreach from=$order_info.products item="oi" key="sub_key"}
        {if $oi.extra.parent.buy_together && $oi.extra.parent.buy_together == $conf_oi.cart_id}
        <tr>
            <td style="padding: 5px 10px; background-color: #ffffff;">{$oi.product|default:__("deleted_product")}
                {hook name="orders:product_info"}
                {if $oi.product_code}<p>{__("sku")}:&nbsp;{$oi.product_code}</p>{/if}
                {/hook}
                {if $oi.product_options}<div style="padding-top: 1px; padding-bottom: 2px;">{include file="common/options_info.tpl" product_options=$oi.product_options}</div>{/if}
            </td>
            <td style="padding: 5px 10px; background-color: #ffffff; text-align: center;">{$oi.amount}</td>
            <td style="padding: 5px 10px; background-color: #ffffff; text-align: right;">{include file="common/price.tpl" value=$oi.price}</td>
            {if $order_info.use_discount}
            <td style="padding: 5px 10px; background-color: #ffffff; text-align: right;">{if $oi.extra.discount|floatval}{include file="common/price.tpl" value=$oi.extra.discount}{else}&nbsp;-&nbsp;{/if}</td>
            {/if}
            {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
            <td style="padding: 5px 10px; background-color: #ffffff; text-align: right;">{if $oi.tax_value}{include file="common/price.tpl" value=$oi.tax_value}{else}&nbsp;-&nbsp;{/if}</td>
            {/if}
            <td style="padding: 5px 10px; background-color: #ffffff; text-align: right;">{include file="common/price.tpl" value=$oi.display_subtotal}&nbsp;</td>
        </tr>
        {/if}
        {/foreach}
        </table>
    </tr>
    {/if}
{/if}
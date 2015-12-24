{if $order_info.gift_certificates}

{foreach from=$order_info.gift_certificates item="gift" key="gift_key" name="gift_cycle"}
<tr>
    <td style="padding: 5px 10px; background-color: #ffffff; font-size: 12px; font-family: Arial;">
        {__("gift_certificate")}
        {if $gift.gift_cert_code}
        <p>{__("code")}:&nbsp;{$gift.gift_cert_code}</p>
        {/if}
    </td>
    <td style="padding: 5px 10px; background-color: #ffffff; text-align: center; font-size: 12px; font-family: Arial;">&nbsp;1</td>
    <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;">{if !$gift.extra.exclude_from_calculate}{include file="common/price.tpl" value=$gift.display_subtotal}{else}{__("free")}{/if}</td>    
    {if $order_info.use_discount}
    <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;">-</td>
    {/if}
    {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
    <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;">-</td>
    {/if}

    <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;"><b>{if !$gift.extra.exclude_from_calculate}{include file="common/price.tpl" value=$gift.display_subtotal}{else}{__("free")}{/if}</b>&nbsp;</td>
</tr>
{if $gift.products && $addons.gift_certificates.free_products_allow == 'Y'}
<tr>
    {assign var="_colspan" value="4"}
    {if $order_info.use_discount}{assign var="_colspan" value=$_colspan+1}{/if}
    {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}{assign var="_colspan" value=$_colspan+1}{/if}
    <td style="padding: 5px 10px; background-color: #ffffff; font-size: 12px; font-family: Arial;" colspan="{$_colspan}">
        <p>{__("free_products")} ({$gift.gift_cert_code|default:"&nbsp;"}):</p>

        <table width="100%" cellpadding="0" cellspacing="1" style="background-color: #dddddd;">
        <tr>
            <th width="70%" style="background-color: #eeeeee; padding: 6px 10px; font-size: 12px; font-family: Arial;">{__("product")}</th>
            <th style="background-color: #eeeeee; padding: 6px 10px; font-size: 12px; font-family: Arial;">{__("quantity")}</th>
            <th style="background-color: #eeeeee; padding: 6px 10px; font-size: 12px; font-family: Arial;">{__("unit_price")}</th>
            {if $order_info.use_discount}
            <th style="background-color: #eeeeee; padding: 6px 10px; font-size: 12px; font-family: Arial;">{__("discount")}</th>
            {/if}
            {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
            <th style="background-color: #eeeeee; padding: 6px 10px; font-size: 12px; font-family: Arial;">{__("tax")}</th>
            {/if}
            <th style="background-color: #eeeeee; padding: 6px 10px; font-size: 12px; font-family: Arial;">{__("subtotal")}</th>
        </tr>
        {foreach from=$order_info.products item="oi" key="sub_key"}
        {if $oi.extra.parent.certificate && $oi.extra.parent.certificate == $gift_key}
        <tr>
            <td style="padding: 5px 10px; background-color: #ffffff; font-size: 12px; font-family: Arial;">{$oi.product|default:__("deleted_product")}
                {hook name="orders:product_info"}
                {if $oi.product_code}<p>{__("sku")}:&nbsp;{$oi.product_code}</p>{/if}
                {/hook}
                {if $oi.product_options}<div style="padding-top: 1px; padding-bottom: 2px;">{include file="common/options_info.tpl" product_options=$oi.product_options}</div>{/if}
            </td>
            <td style="padding: 5px 10px; background-color: #ffffff; text-align: center; font-size: 12px; font-family: Arial;">{$oi.amount}</td>
            <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;">{include file="common/price.tpl" value=$oi.price}</td>
            {if $order_info.use_discount}
            <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;">{if $oi.extra.discount|floatval}{include file="common/price.tpl" value=$oi.extra.discount}{else}&nbsp;-&nbsp;{/if}</td>
            {/if}
            {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
            <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;">{if $oi.tax_value}{include file="common/price.tpl" value=$oi.tax_value}{else}&nbsp;-&nbsp;{/if}</td>
            {/if}
            <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;">{include file="common/price.tpl" value=$oi.display_subtotal}&nbsp;</td>
        </tr>
        {/if}
        {/foreach}
        </table>
    </td>
</tr>
{/if}
{/foreach}
{/if}
{if $order_info}

{assign var="order_header" value=__("invoice")}

{if $status_settings.appearance_type == "I" && $order_info.doc_ids[$status_settings.appearance_type]}
    {assign var="doc_id_text" value="{__("invoice")} #`$order_info.doc_ids[$status_settings.appearance_type]`"}
{elseif $status_settings.appearance_type == "C" && $order_info.doc_ids[$status_settings.appearance_type]}
    {assign var="doc_id_text" value="{__("credit_memo")} #`$order_info.doc_ids[$status_settings.appearance_type]`"}
    {assign var="order_header" value=__("credit_memo")}
{elseif $status_settings.appearance_type == "O"}
    {assign var="order_header" value=__("order_details")}
{/if}

<table cellpadding="0" cellspacing="0" border="0" width="100%" class="main-table" style="direction: {$language_direction}; height: 100%; background-color: #f4f6f8; font-size: 12px; font-family: Arial;">
<tr>
    <td align="center" style="width: 100%; height: 100%;">
    <table cellpadding="0" cellspacing="0" border="0" style="direction: {$language_direction}; width: 602px; table-layout: fixed; margin: 24px 0 24px 0;">
    <tr>
        <td style="background-color: #ffffff; border: 1px solid #e6e6e6; margin: 0px auto 0px auto; padding: 0px 44px 0px 46px; text-align: left;">
            <table cellpadding="0" cellspacing="0" border="0" width="100%" style="direction: {$language_direction}; padding: 27px 0px 0px 0px; border-bottom: 1px solid #868686; margin-bottom: 8px;">
            <tr>
                <td align="left" style="padding-bottom: 3px;" valign="middle"><img src="{$logos.mail.image.image_path}" width="{$logos.mail.image.image_x}" height="{$logos.mail.image.image_y}" border="0" alt="{$logos.mail.image.alt}" /></td>
                <td width="100%" >&nbsp;</td>
                <td valign="bottom" style="text-align: right;  font: bold 26px Arial; text-transform: uppercase;  margin: 0px;">{$order_header|default:__("invoice_title")}</td>
            </tr>
            </table>

            <table cellpadding="0" cellspacing="0" border="0" width="100%" style="direction: {$language_direction};">
            <tr valign="top">
                {hook name="orders:invoice_company_info"}
                <td style="width: 50%; padding: 14px 0px 0px 2px; font-size: 12px; font-family: Arial;">
                    <h2 style="font: bold 12px Arial; margin: 0px 0px 3px 0px;">{$company_data.company_name}</h2>
                    {$company_data.company_address}<br />
                    {$company_data.company_city}{if $company_data.company_city && ($company_data.company_state_descr || $company_data.company_zipcode)},{/if} {$company_data.company_state_descr} {$company_data.company_zipcode}<br />
                    {$company_data.company_country_descr}
                    <table cellpadding="0" cellspacing="0" border="0" style="direction: {$language_direction};">
                    {if $company_data.company_phone}
                    <tr valign="top">
                        <td style="font-size: 12px; font-family: verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px;    white-space: nowrap;">{__("phone1_label")}:</td>
                        <td width="100%" style="font-size: 12px; font-family: Arial;">{$company_data.company_phone}</td>
                    </tr>
                    {/if}
                    {if $company_data.company_phone_2}
                    <tr valign="top">
                        <td style="font-size: 12px; font-family: verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("phone2_label")}:</td>
                        <td width="100%" style="font-size: 12px; font-family: Arial;">{$company_data.company_phone_2}</td>
                    </tr>
                    {/if}
                    {if $company_data.company_fax}
                    <tr valign="top">
                        <td style="font-size: 12px; font-family: verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("fax")}:</td>
                        <td width="100%" style="font-size: 12px; font-family: Arial;">{$company_data.company_fax}</td>
                    </tr>
                    {/if}
                    {if $company_data.company_website}
                    <tr valign="top">
                        <td style="font-size: 12px; font-family: verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("web_site")}:</td>
                        <td width="100%" style="font-size: 12px; font-family: Arial;">{$company_data.company_website}</td>
                    </tr>
                    {/if}
                    {if $company_data.company_orders_department}
                    <tr valign="top">
                        <td style="font-size: 12px; font-family: verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("email")}:</td>
                        <td width="100%" style="font-size: 12px; font-family: Arial;"><a href="mailto:{$company_data.company_orders_department}">{$company_data.company_orders_department|replace:",":"<br>"|replace:" ":"" nofilter}</a></td>
                    </tr>
                    {/if}
                    </table>
                </td>
                {/hook}
                {hook name="orders:invoice_order_status_info"}
                <td style="padding-top: 14px;">
                    <h2 style="font: bold 17px Tahoma; margin: 0px;">{if $doc_id_text}{$doc_id_text} <br />{/if}{__("order")}&nbsp;#{$order_info.order_id}</h2>
                    <table cellpadding="0" cellspacing="0" border="0" style="direction: {$language_direction};">
                    <tr valign="top">
                        <td style="font-size: 12px; font-family: verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("status")}:</td>
                        <td width="100%" style="font-size: 12px; font-family: Arial;">{$order_status.description}</td>
                    </tr>
                    <tr valign="top">
                        <td style="font-size: 12px; font-family: verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("date")}:</td>
                        <td style="font-size: 12px; font-family: Arial;">{$order_info.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}</td>
                    </tr>
                    <tr valign="top">
                        <td style="font-size: 12px; font-family: verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("payment_method")}:</td>
                        <td style="font-size: 12px; font-family: Arial;">{$payment_method.payment|default:" - "}</td>
                    </tr>
                    {if $order_info.shipping}
                    <tr valign="top">
                        <td style="font-size: 12px; font-family: verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("shipping_method")}:</td>
                        <td style="font-size: 12px; font-family: Arial;">
                            {foreach from=$order_info.shipping item="shipping" name="f_shipp"}
                                {$shipping.shipping}{if !$smarty.foreach.f_shipp.last}, {/if}
                                {if $shipments[$shipping.group_key].tracking_number}{assign var="tracking_number_exists" value="Y"}{/if}
                            {/foreach}</td>
                    </tr>
                    {if $tracking_number_exists && !$use_shipments}
                        <tr valign="top">
                            <td style="font-size: 12px; font-family: verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("tracking_number")}:</td>
                            <td style="font-size: 12px; font-family: Arial;">
                                {foreach from=$order_info.shipping item="shipping" name="f_shipp"}
                                    {include file="common/carriers.tpl" carrier=$shipments[$shipping.group_key].carrier tracking_number=$shipments[$shipping.group_key].tracking_number}
                                    {if !empty($smarty.capture.carrier_url)}
                                        <a {if $smarty.capture.carrier_url|strpos:"://"}target="_blank"{/if} href="{$smarty.capture.carrier_url nofilter}">{$shipments[$shipping.group_key].tracking_number}</a>
                                    {else}
                                        {$shipments[$shipping.group_key].tracking_number}
                                    {/if}

                                    {$smarty.capture.carrier_info nofilter}
                                    
                                    {if !$smarty.foreach.f_shipp.last}, {/if}
                                {/foreach}</td>
                        </tr>
                    {/if}
                    {/if}
                    </table>
                </td>
                {/hook}
            </tr>
            </table>
        
            {hook name="orders:invoice_customer_info"}
            {if !$profile_fields}
            {assign var="profile_fields" value='I'|fn_get_profile_fields}
            {/if}
            {if $profile_fields}
            <table cellpadding="0" cellspacing="0" border="0" width="100%" style="direction: {$language_direction}; padding: 32px 0px 24px 0px;">
            <tr valign="top">
                {if $profile_fields.C}
                {assign var="profields_c" value=$profile_fields.C|fn_fields_from_multi_level:"field_name":"field_id"}
                <td width="33%" style="font-size: 12px; font-family: Arial;">
                    <h3 style="font: bold 17px Tahoma; padding: 0px 0px 3px 1px; margin: 0px;">{__("customer")}:</h3>
                    <p style="margin: 2px 0px 3px 0px;">{if $profields_c.firstname}{$order_info.firstname}&nbsp;{/if}{if $profields_c.lastname}{$order_info.lastname}{/if}</p>
                    {if $profields_c.email}<p style="margin: 2px 0px 3px 0px;"><a href="mailto:{$order_info.email|escape:url}">{$order_info.email}</a></p>{/if}
                    {if $profields_c.phone}<p style="margin: 2px 0px 3px 0px;"><span style="text-transform: uppercase;">{__("phone")}:</span>&nbsp;{$order_info.phone}</p>{/if}
                    {if $profields_c.fax && $order_info.fax}<p style="margin: 2px 0px 3px 0px;"><span style="text-transform: uppercase;">{__("fax")}:</span>&nbsp;{$order_info.fax}</p>{/if}
                    {if $profields_c.company && $order_info.company}<p style="margin: 2px 0px 3px 0px;"><span style="text-transform: uppercase;">{__("company")}:</span>&nbsp;{$order_info.company}</p>{/if}
                    {if $profields_c.url && $order_info.url}<p style="margin: 2px 0px 3px 0px;"><span style="text-transform: uppercase;">{__("url")}:</span>&nbsp;{$order_info.url}</p>{/if}
                    {include file="profiles/profiles_extra_fields.tpl" fields=$profile_fields.C}
                </td>
                {/if}
                {if $profile_fields.B}
                {assign var="profields_b" value=$profile_fields.B|fn_fields_from_multi_level:"field_name":"field_id"}
                <td width="34%" style="font-size: 12px; font-family: Arial; {if $profile_fields.S}padding-right: 10px;{/if} {if $profile_fields.C}padding-left: 10px;{/if}">
                    <h3 style="font: bold 17px Tahoma; padding: 0px 0px 3px 1px; margin: 0px;">{__("bill_to")}:</h3>
                    {if $order_info.b_firstname && $profields_b.b_firstname || $order_info.b_lastname && $profields_b.b_lastname}
                    <p style="margin: 2px 0px 3px 0px;">
                        {if $profields_b.b_firstname}{$order_info.b_firstname} {/if}{if $profields_b.b_lastname}{$order_info.b_lastname}{/if}
                    </p>
                    {/if}
                    {if $order_info.b_address && $profields_b.b_address || $order_info.b_address_2 && $profields_b.b_address_2}
                    <p style="margin: 2px 0px 3px 0px;">
                        {if $profields_b.b_address}{$order_info.b_address} {/if}{if $profields_b.b_address_2}<br />{$order_info.b_address_2}{/if}
                    </p>
                    {/if}
                    {if $order_info.b_city && $profields_b.b_city || $order_info.b_state_descr && $profields_b.b_state || $order_info.b_zipcode && $profields_b.b_zipcode}
                    <p style="margin: 2px 0px 3px 0px;">
                        {if $profields_b.b_city}{$order_info.b_city}{if $profields_b.b_state},{/if} {/if}{if $profields_b.b_state}{$order_info.b_state_descr} {/if}{if $profields_b.b_zipcode}{$order_info.b_zipcode}{/if}
                    </p>
                    {/if}
                    {if $order_info.b_country_descr && $profields_b.b_country}
                    <p style="margin: 2px 0px 3px 0px;">
                        {$order_info.b_country_descr}
                    </p>
                    {/if}
                    {if $order_info.b_phone && $profields_b.b_phone}
                    <p style="margin: 2px 0px 3px 0px;">
                        {if $profields_b.b_phone}{$order_info.b_phone} {/if}
                    </p>
                    {/if}
                    {include file="profiles/profiles_extra_fields.tpl" fields=$profile_fields.B}
                </td>
                {/if}
                {if $profile_fields.S}
                {assign var="profields_s" value=$profile_fields.S|fn_fields_from_multi_level:"field_name":"field_id"}
                <td width="33%" style="font-size: 12px; font-family: Arial;">
                    <h3 style="font: bold 17px Tahoma; padding: 0px 0px 3px 1px; margin: 0px;">{__("ship_to")}:</h3>
                    {if $order_info.s_firstname && $profields_s.s_firstname || $order_info.s_lastname && $profields_s.s_lastname}
                    <p style="margin: 2px 0px 3px 0px;">
                        {if $profields_s.s_firstname}{$order_info.s_firstname} {/if}{if $profields_s.s_lastname}{$order_info.s_lastname}{/if}
                    </p>
                    {/if}
                    {if $order_info.s_address && $profields_s.s_address || $order_info.s_address_2 && $profields_s.s_address_2}
                    <p style="margin: 2px 0px 3px 0px;">
                        {if $profields_s.s_address}{$order_info.s_address} {/if}{if $profields_s.s_address_2}<br />{$order_info.s_address_2}{/if}
                    </p>
                    {/if}
                    {if $order_info.s_city && $profields_s.s_city || $order_info.s_state_descr && $profields_s.s_state || $order_info.s_zipcode && $profields_s.s_zipcode}
                    <p style="margin: 2px 0px 3px 0px;">
                        {if $profields_s.s_city}{$order_info.s_city}{if $profields_s.s_state},{/if} {/if}{if $profields_s.s_state}{$order_info.s_state_descr} {/if}{if $profields_s.s_zipcode}{$order_info.s_zipcode}{/if}
                    </p>
                    {/if}
                    {if $order_info.s_country_descr && $profields_s.s_country}
                    <p style="margin: 2px 0px 3px 0px;">
                        {$order_info.s_country_descr}
                    </p>
                    {/if}
                    {if $order_info.s_phone && $profields_s.s_phone}
                    <p style="margin: 2px 0px 3px 0px;">
                        {if $profields_s.s_phone}{$order_info.s_phone} {/if}
                    </p>
                    {/if}
                    {include file="profiles/profiles_extra_fields.tpl" fields=$profile_fields.S}
                </td>
                {/if}
            </tr>
            </table>
            {/if}
            {/hook}
            {* Customer info *}
        
        
            {* Ordered products *}
            
            <table width="100%" cellpadding="0" cellspacing="1" style="direction: {$language_direction}; background-color: #dddddd;">
            <tr>
                <th width="70%" style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap; font-size: 12px; font-family: Arial;">{__("product")}</th>
                <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap; font-size: 12px; font-family: Arial;">{__("quantity")}</th>
                <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap; font-size: 12px; font-family: Arial;">{__("unit_price")}</th>
                {if $order_info.use_discount}
                    <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap; font-size: 12px; font-family: Arial;">{__("discount")}</th>
                {/if}
                {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
                    <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap; font-size: 12px; font-family: Arial;">{__("tax")}</th>
                {/if}
                <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap; font-size: 12px; font-family: Arial;">{__("subtotal")}</th>
            </tr>
            {foreach from=$order_info.products item="oi"}
            {hook name="orders:items_list_row"}
                {if !$oi.extra.parent}
                <tr>
                    <td style="padding: 5px 10px; background-color: #ffffff; font-size: 12px; font-family: Arial;">
                        {$oi.product|default:__("deleted_product") nofilter}
                        {hook name="orders:product_info"}
                        {if $oi.product_code}<p style="margin: 2px 0px 3px 0px;">{__("sku")}: {$oi.product_code}</p>{/if}
                        {/hook}
                        {if $oi.product_options}<br/>{include file="common/options_info.tpl" product_options=$oi.product_options}{/if}
                    </td>
                    <td style="padding: 5px 10px; background-color: #ffffff; text-align: center; font-size: 12px; font-family: Arial;">{$oi.amount}</td>
                    <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;">{if $oi.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$oi.original_price}{/if}</td>
                    {if $order_info.use_discount}
                    <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;">{if $oi.extra.discount|floatval}{include file="common/price.tpl" value=$oi.extra.discount}{else}&nbsp;-&nbsp;{/if}</td>
                    {/if}
                    {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
                        <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; font-size: 12px; font-family: Arial;">{if $oi.tax_value}{include file="common/price.tpl" value=$oi.tax_value}{else}&nbsp;-&nbsp;{/if}</td>
                    {/if}
        
                    <td style="padding: 5px 10px; background-color: #ffffff; text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;"><b>{if $oi.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$oi.display_subtotal}{/if}</b>&nbsp;</td>
                </tr>
                {/if}
            {/hook}
            {/foreach}
            {hook name="orders:extra_list"}
            {/hook}
            </table>
        
            {hook name="orders:ordered_products"}
            {/hook}
            {* /Ordered products *}
        
            {* Order totals *}
            <table cellpadding="0" cellspacing="0" border="0" width="100%" style="direction: {$language_direction};">
            <tr>
                <td align="right">
                <table border="0" style="direction: {$language_direction}; padding: 3px 0px 12px 0px;">
                <tr>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;"><b>{__("subtotal")}:</b>&nbsp;</td>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">{include file="common/price.tpl" value=$order_info.display_subtotal}</td>
                </tr>
                {if $order_info.discount|floatval}
                <tr>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;"><b>{__("including_discount")}:</b>&nbsp;</td>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">
                        {include file="common/price.tpl" value=$order_info.discount}</td>
                </tr>
                {/if}

            
                {if $order_info.subtotal_discount|floatval}
                <tr>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">{__("order_discount")}:</td>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">
                        {include file="common/price.tpl" value=$order_info.subtotal_discount}</td>
                </tr>
                {/if}

                {if $order_info.coupons}
                {foreach from=$order_info.coupons item="coupon" key="key"}
                <tr>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;"><b>{__("coupon")}:</b>&nbsp;</td>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">{$key}</td>
                </tr>
                {/foreach}
                {/if}
                {if $order_info.taxes}
                <tr>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;"><b>{__("taxes")}:</b>&nbsp;</td>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">&nbsp;</td>
                </tr>
                {foreach from=$order_info.taxes item=tax_data}
                <tr>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">{$tax_data.description}&nbsp;{include file="common/modifier.tpl" mod_value=$tax_data.rate_value mod_type=$tax_data.rate_type}{if $tax_data.price_includes_tax == "Y" && ($settings.Appearance.cart_prices_w_taxes != "Y" || $settings.General.tax_calculation == "subtotal")}&nbsp;{__("included")}{/if}{if $tax_data.regnumber}&nbsp;({$tax_data.regnumber}){/if}:&nbsp;</td>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">{include file="common/price.tpl" value=$tax_data.tax_subtotal}</td>
                </tr>
                {/foreach}
                {/if}
                {if $order_info.tax_exempt == 'Y'}
                <tr>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;"><b>{__("tax_exempt")}</b></td>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">&nbsp;</td>
                </tr>
                {/if}

                {if $order_info.payment_surcharge|floatval && !$take_surcharge_from_vendor}
                <tr>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">{$order_info.payment_method.surcharge_title|default:__("payment_surcharge")}:&nbsp;</td>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;"><b>{include file="common/price.tpl" value=$order_info.payment_surcharge}</b></td>
                </tr>
                {/if}
            
            
                {if $order_info.shipping}
                <tr>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;"><b>{__("shipping_cost")}:</b>&nbsp;</td>
                    <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">{include file="common/price.tpl" value=$order_info.display_shipping_cost}</td>
                </tr>
                {/if}
                {hook name="orders:totals"}
                {/hook}
                
                <tr>
                    <td colspan="2"><hr style="border: 0px solid #d5d5d5; border-top-width: 1px;" /></td>
                </tr>
                <tr>
                    <td style="text-align: right; white-space: nowrap; font: 15px Tahoma; text-align: right;">{__("total_cost")}:&nbsp;</td>
                    <td style="text-align: right; white-space: nowrap; font: 15px Tahoma; text-align: right;"><strong style="font: bold 17px Tahoma;">{include file="common/price.tpl" value=$order_info.total}</strong></td>
                </tr>
                </table>
                </td>
            </tr>
            </table>
        
            {* /Order totals *}
        
            {if $order_info.notes}
            <table cellpadding="0" cellspacing="0" border="0" width="100%" style="direction: {$language_direction};">
            <tr valign="top">
                <td style="font-size: 12px; font-family: Arial;"><strong>{__("customer_notes")}:</strong></td>
            </tr>
            <tr valign="top">
                <td><div style="overflow-x: auto; clear: both; width: 510px; height: 100%; padding-bottom: 20px; overflow-y: hidden; font-size: 12px; font-family: Arial;">{$order_info.notes|nl2br nofilter}</div></td>
            </tr>
            </table>
            {/if}
        {/if}
        
        {hook name="orders:invoice"}
        {/hook}
        </td>
    </tr>
    </table>
    </td>
</tr>
</table>

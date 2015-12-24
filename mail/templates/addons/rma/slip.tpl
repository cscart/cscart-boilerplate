{if $order_info}
{literal}
<style type="text/css" media="screen,print">
body,p,div {
    color: #000000;
    font: 12px Arial;
}
body {
    background-color: #f4f6f8;
    padding-top: 24px;
}
a, a:link, a:visited, a:hover, a:active {
    color: #000000;
    text-decoration: underline;
}
a:hover {
    text-decoration: none;
}
</style>
<style media="print">
body, .main-table {
    background-color: #ffffff !important;
}
</style>
{/literal}
{include file="common/scripts.tpl"}

<table cellpadding="0" cellspacing="0" border="0" width="100%" style="direction: {$language_direction}; background-color: #f4f6f8;">
<tr>
    <td width="100%" align="center">
        <table cellpadding="0" cellspacing="0" border="0" style="direction: {$language_direction};">
        <tr>
            <td style="background-color: #ffffff; border: 1px solid #e6e6e6; margin: 0px auto; padding: 0px 40px 40px 40px; width: 510px;" align="left">
                <table cellpadding="0" cellspacing="0" border="0" width="100%" style="direction: {$language_direction}; padding: 27px 0px 0px 0px; border-bottom: 1px solid #868686; margin-bottom: 8px;">
                <tr>
                    <td align="left" style="padding-bottom: 3px;" valign="middle"><img src="{$logos.mail.image.image_path}" width="{$logos.mail.image.image_x}" height="{$logos.mail.image.image_y}" border="0" alt="{$logos.mail.image.alt}" /></td>
                    <td width="100%" >&nbsp;</td>
                    <td valign="bottom" style="text-align: right; white-space:nowrap; font: bold 26px Arial; text-transform: uppercase;  margin: 0px;">{__("packing_slip")}</td>

                </tr>
                </table>
            
                <table cellpadding="0" cellspacing="0" border="0" width="100%" style="direction: {$language_direction};">
                <tr valign="top">
                    <td style="width: 50%; padding: 14px 0px 0px 2px;">
                        <h2 style="font: bold 12px Arial; margin: 0px 0px 3px 0px;">{$company_data.company_name}</h2>
                        {$company_data.company_address}<br />
                        {$company_data.company_city}{if $company_data.company_city && ($company_data.company_state_descr || $company_data.company_zipcode)},{/if} {$company_data.company_state_descr} {$company_data.company_zipcode}<br />
                        {$company_data.company_country_descr}
                        <table cellpadding="0" cellspacing="0" border="0" style="direction: {$language_direction};">
                        {if $company_data.company_phone}
                        <tr>
                            <td style="font: 12px verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("phone1_label")}:</td>
                            <td width="100%">{$company_data.company_phone}</td>
                        </tr>                
                        {/if}        
                        {if $company_data.company_phone_2}
                        <tr>
                            <td style="font: 12px verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("phone2_label")}:</td>
                            <td width="100%">{$company_data.company_phone_2}</td>
                        </tr>                
                        {/if}
                        {if $company_data.company_fax}
                        <tr>
                            <td style="font: 12px verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("fax")}:</td>
                            <td width="100%">{$company_data.company_fax}</td>
                        </tr>
                        {/if}
                        {if $company_data.company_website}
                        <tr>
                            <td style="font: 12px verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("web_site")}:</td>
                            <td width="100%">{$company_data.company_website}</td>
                        </tr>
                        {/if}
                        {if $company_data.company_orders_department}
                        <tr>
                            <td style="font: 12px verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("email")}:</td>
                            <td width="100%">{$company_data.company_orders_department}</td>
                        </tr>
                        {/if}        
                        </table>
                    </td>
                    <td style="padding-top: 14px;">
                        <h2 style="font: bold 17px Tahoma; margin: 0px;">{__("rma_return")}&nbsp;#{$return_info.return_id}</h2>
                        <table cellpadding="0" cellspacing="0" border="0">
                        <tr valign="top">
                            <td style="font: 12px verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("action")}:</td>
                            <td width="100%">{assign var="action_id" value=$return_info.action}{$actions.$action_id.property}</td>
                        </tr>
                        <tr valign="top">
                            <td style="font: 12px verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("status")}:</td>
                            <td width="100%">{include file="common/status.tpl" status=$return_info.status display="view" status_type=$smarty.const.STATUSES_RETURN}</td>
                        </tr>
                        <tr valign="top">
                            <td style="font: 12px verdana, helvetica, arial, sans-serif; text-transform: uppercase; color: #000000; padding-right: 10px; white-space: nowrap;">{__("date")}:</td>
                            <td>{$return_info.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}</td>
                        </tr>
                        </table>
                    </td>
                </tr>
                </table>
            
                {* Shipping info *}
                {assign var="profile_fields" value='I'|fn_get_profile_fields}

                {if $profile_fields}
                <table cellpadding="0" cellspacing="0" border="0" width="100%" style="direction: {$language_direction}; padding: 32px 0px 24px 0px;">
                <tr valign="top">
                    {if $profile_fields.C}
                    <td width="33%">
                        <h3 style="font: bold 17px Tahoma; padding: 0px 0px 3px 1px; margin: 0px;">{__("customer")}:</h3>
                        <p style="margin: 2px 0px 3px 0px;">{$order_info.firstname}&nbsp;{$order_info.lastname}</p>
                        <p style="margin: 2px 0px 3px 0px;"><a href="mailto:{$order_info.email|escape:url}">{$order_info.email}</a></p>
                        <p style="margin: 2px 0px 3px 0px;"><span style="text-transform: uppercase;">{__("phone")}:</span>&nbsp;{$order_info.phone}</p>
                        {include file="profiles/profiles_extra_fields.tpl" fields=$profile_fields.C}
                    </td>
                    {/if}
                    {if $profile_fields.B}
                    <td width="34%" style="{if $profile_fields.S}padding-right: 10px;{/if} {if $profile_fields.C}padding-left: 10px;{/if}">
                        <h3 style="font: bold 17px Tahoma; padding: 0px 0px 3px 1px; margin: 0px;">{__("bill_to")}:</h3>
                        {if $order_info.b_firstname || $order_info.b_lastname}
                        <p style="margin: 2px 0px 3px 0px;">
                            {$order_info.b_firstname} {$order_info.b_lastname}
                        </p>
                        {/if}
                        {if $order_info.b_address || $order_info.b_address_2}
                        <p style="margin: 2px 0px 3px 0px;">
                            {$order_info.b_address} {$order_info.b_address_2}
                        </p>
                        {/if}
                        {if $order_info.b_city || $order_info.b_state_descr || $order_info.b_zipcode}
                        <p style="margin: 2px 0px 3px 0px;">
                            {$order_info.b_city}{if $order_info.b_city && ($order_info.b_state_descr || $order_info.b_zipcode)},{/if} {$order_info.b_state_descr} {$order_info.b_zipcode}
                        </p>
                        {/if}
                        {if $order_info.b_country_descr}
                        <p style="margin: 2px 0px 3px 0px;">
                            {$order_info.b_country_descr}
                        </p>
                        {/if}
                        {include file="profiles/profiles_extra_fields.tpl" fields=$profile_fields.B}
                    </td>
                    {/if}
                    {if $profile_fields.S}
                    <td width="33%">
                        <h3 style="font: bold 17px Tahoma; padding: 0px 0px 3px 1px; margin: 0px;">{__("ship_to")}:</h3>
                        {if $order_info.s_firstname || $order_info.s_lastname}
                        <p style="margin: 2px 0px 3px 0px;">
                            {$order_info.s_firstname} {$order_info.s_lastname}
                        </p>
                        {/if}
                        {if $order_info.s_address || $order_info.s_address_2}
                        <p style="margin: 2px 0px 3px 0px;">
                            {$order_info.s_address} {$order_info.s_address_2}
                        </p>
                        {/if}
                        {if $order_info.s_city || $order_info.s_state_descr || $order_info.s_zipcode}
                        <p style="margin: 2px 0px 3px 0px;">
                            {$order_info.s_city}{if $order_info.s_city && ($order_info.s_state_descr || $order_info.s_zipcode)},{/if} {$order_info.s_state_descr} {$order_info.s_zipcode}
                        </p>
                        {/if}
                        {if $order_info.s_country_descr}
                        <p style="margin: 2px 0px 3px 0px;">
                            {$order_info.s_country_descr}
                        </p>
                        {/if}
                        {include file="profiles/profiles_extra_fields.tpl" fields=$profile_fields.S}
                    </td>
                    {/if}
                </tr>
                </table>
                {/if}
                {* /Shipping info *}
                
                {* Declined products *}
                <table cellpadding="0" cellspacing="1" border="0" width="100%" style="direction: {$language_direction}; background-color: #dddddd;">
                <tr>
                    <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("sku")}</th>
                    <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("product")}</th>
                    <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("price")}</th>
                    <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("amount")}</th>
                    <th style="background-color: #eeeeee; padding: 6px 10px; white-space: nowrap;">{__("reason")}</th>
                </tr>
                {if $return_info.items[$smarty.const.RETURN_PRODUCT_ACCEPTED]}
                {foreach from=$return_info.items[$smarty.const.RETURN_PRODUCT_ACCEPTED] item="ri" key="key"}
                <tr>
                    <td style="padding: 5px 10px; background-color: #ffffff;">{$order_info.products.$key.product_code|default:"&nbsp;"}</td>
                    <td style="padding: 5px 10px; background-color: #ffffff;">{$ri.product nofilter}
                        {if $ri.product_options}<div style="padding-top: 1px; padding-bottom: 2px;">{include file="common/options_info.tpl" product_options=$ri.product_options}</div>{/if}</td>
                    <td align="center" style="padding: 5px 10px; background-color: #ffffff;">{if !$ri.price}{__("free")}{else}{include file="common/price.tpl" value=$ri.price}{/if}</td>        
                    <td align="center" style="padding: 5px 10px; background-color: #ffffff;">{$ri.amount}</td>
                    <td align="center" style="padding: 5px 10px; background-color: #ffffff;">
                        {assign var="reason_id" value=$ri.reason}
                        &nbsp;{$reasons.$reason_id.property}&nbsp;</td>
                </tr>
                {/foreach}
                {else}
                    <tr>
                        <td colspan="6" align="center" style="padding: 5px 10px; background-color: #ffffff;"><p style="margin: 2px 0px 3px 0px;"><b>{__("text_no_products_found")}</b></p></td>
                    </tr>    
                {/if}
                </table>
                {* /Declined products *}
            
                {if $return_info.comment}
                    <p style="margin-top: 15px; font-weight: bold;">{__("comments")}:</p>
                    <div style="padding-left: 7px; padding-bottom: 15px; overflow-x: auto; overflow-y: hidden; clear: both; width: 505px;">{$return_info.comment|nl2br}</div>
                {/if}
            </td>
        </tr>
        </table>
    </td>
</tr>
</table>
{/if}
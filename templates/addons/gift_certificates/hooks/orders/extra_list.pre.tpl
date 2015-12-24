{if $order_info.gift_certificates}
{foreach from=$order_info.gift_certificates item="gift" key="gift_key"}
<tr>
    <td>
        <div class="pull-right">{include file="common/button.tpl" href="gift_certificates.print?order_id=`$order_info.order_id`&gift_cert_cart_id=`$gift_key`" text=__("print_card") meta="cm-new-window"}</div>
        <span>{__("gift_certificate")}</span>
        {if $gift.gift_cert_code}
         <div class="orders-detail__table-code">{__("code")}: <a href="{"gift_certificates.verify?verify_code=`$gift.gift_cert_code`"|fn_url}">{$gift.gift_cert_code}</a></div>
        {/if}
        <div class="gift-certificate-order">
            <a id="sw_options_{$gift_key}" class="cm-combination">{__("text_click_here")}</a>
            <div id="options_{$gift_key}" class="discount-info hidden">
                <span class="caret-info"> <span class="caret-outer"></span><span class="caret-inner"></span></span>
                <div class="gift-certificate-order__group">
                    <label class="gift-certificate-order__group-label">{__("gift_cert_to")}:</label>
                    <span class="gift-certificate-order__group-item">{$gift.recipient}</span>
                </div>
                <div class="gift-certificate-order__group">
                    <label class="gift-certificate-order__group-label">{__("gift_cert_from")}:</label>
                    <span class="gift-certificate-order__group-item">{$gift.sender}</span>
                </div>
                <div class="gift-certificate-order__group">
                    <label class="gift-certificate-order__group-label">{__("amount")}:</label>
                    <span class="gift-certificate-order__group-item">{include file="common/price.tpl" value=$gift.amount}</span>
                </div>
                <div class="gift-certificate-order__group">
                    <label class="gift-certificate-order__group-label">{__("send_via")}:</label>
                    <span class="gift-certificate-order__group-item">{if $gift.send_via == "E"}{__("email")}{else}{__("postal_mail")}{/if}</span>
                </div>
            </div>
        </div>
    </td>
    
    <td>{if !$gift.extra.exclude_from_calculate}{include file="common/price.tpl" value=$gift.display_subtotal}{else}{__("free")}{/if}</td>
    <td class="center">&nbsp;1</td>
    <td>{if !$gift.extra.exclude_from_calculate}{include file="common/price.tpl" value=$gift.display_subtotal}{else}{__("free")}{/if}</td>
</tr>
{/foreach}

{/if}
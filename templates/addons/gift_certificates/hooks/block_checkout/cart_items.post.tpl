{if $cart.gift_certificates}

{assign var="c_url" value=$config.current_url|escape:url}
    {foreach from=$cart.gift_certificates item="gift" key="gift_key" name="f_gift_certificates"}
        <li>
            {if !$gift.extra.exclude_from_calculate}
                <a href="{"gift_certificates.update?gift_cert_id=`$gift_key`"|fn_url}" class="btn btn-link">{__("gift_certificate")}</a>{include file="common/button.tpl" href="gift_certificates.delete?gift_cert_id=`$gift_key`&redirect_url=`$c_url`" meta="badge cm-post delete" target_id="cart_status*" name="delete_cart_item"}
            {else}
                <strong>{__("gift_certificate")}</strong>
            {/if}
            <div>{include file="common/price.tpl" value=$gift.display_subtotal}</div>
        </li>
    {/foreach}
{/if}
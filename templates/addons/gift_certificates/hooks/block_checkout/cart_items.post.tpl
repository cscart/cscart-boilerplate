{if $cart.gift_certificates}

{assign var="c_url" value=$config.current_url|escape:url}
    {foreach from=$cart.gift_certificates item="gift" key="gift_key" name="f_gift_certificates"}
        <li class="list-group-item">
            {if !$gift.extra.exclude_from_calculate}
                <a href="{"gift_certificates.update?gift_cert_id=`$gift_key`"|fn_url}">{__("gift_certificate")}</a>
                <a class="cm-post cm-submit pull-right" data-ca-dispatch="delete_cart_item" href="gift_certificates.delete?gift_cert_id=`$gift_key`&redirect_url=`$c_url`" data-ca-target-id="cart_status*">
                    <i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                </a>
            {else}
                <strong>{__("gift_certificate")}</strong>
            {/if}
            <div>{include file="common/price.tpl" value=$gift.display_subtotal}</div>
        </li>
    {/foreach}
{/if}
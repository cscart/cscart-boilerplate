{if $cart.use_gift_certificates}
    {foreach from=$cart.use_gift_certificates item="ugc" key="ugc_key"}
        <li>
            <strong>{__("gift_certificate")}</strong>
            <a href="{"gift_certificates.verify?verify_code=`$ugc_key`"|fn_url}">{$ugc_key}</a>
            ({include file="common/price.tpl" value=$ugc.cost})
            {include file="addons/gift_certificates/views/gift_certificates/components/delete_button.tpl" code=$ugc_key additional_ids=",payment-methods" r_url=$config.current_url|escape:url}
        </li>
    {/foreach}
{/if}

{if $smarty.session.cart.gift_certificates}
    {foreach from=$smarty.session.cart.gift_certificates item="gift" key="gift_key" name="f_gift_certificates"}
    <li>
        <div class="media">
            <div class="media-left">
                {if $block.properties.products_links_type == "thumb"}
                    {include file="addons/gift_certificates/views/gift_certificates/components/gift_certificates_cart_icon.tpl" width="40" height="40"}
                {/if}
            </div>
            <div class="media-body">
                {if !$gift.extra.exclude_from_calculate}
                    <a href="{"gift_certificates.update?gift_cert_id=`$gift_key`"|fn_url}">{__("gift_certificate")}</a>
                {else}
                    <span>{__("gift_certificate")}</span>
                {/if}
                <p>
                    {include file="common/price.tpl" value=$gift.display_subtotal span_id="subtotal_gc_`$gift_key`" class="none"}
                </p>
            </div>
            {if $block.properties.display_delete_icons == "Y"}
            {assign var="r_url" value=$config.current_url|escape:url}
            <div class="media-right cm-cart-item-delete">
                {if (!$runtime.checkout || $force_items_deletion) && !$p.extra.exclude_from_calculate}{include file="common/button.tpl" href="gift_certificates.delete?gift_cert_id=`$gift_key`&redirect_url=`$r_url`" meta="cm-ajax cm-post cm-ajax-full-render" target_id="cart_status*" icon="glyphicon-remove-sign fa fa-times-circle" name="delete_cart_item"}{/if}
            </div>
            {/if}
        </div>
    </li>
    <li role="separator" class="divider"></li>
    {/foreach}
{/if}

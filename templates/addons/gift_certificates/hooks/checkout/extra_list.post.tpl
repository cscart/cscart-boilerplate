{if $cart.gift_certificates}

{assign var="c_url" value=$config.current_url|escape:url}

{foreach from=$cart.gift_certificates item="gift" key="gift_key" name="f_gift_certificates"}
{assign var="obj_id" value=$gift.object_id|default:$gift_key}
{if !$smarty.capture.prods}
    {capture name="prods"}Y{/capture}
{/if}
<tr>
    <td class="cart-content-image-block" style="width: 13%;">
        {if $runtime.mode == "cart" || $show_images}
            <div class="cart-content-image cm-reload-{$obj_id}" id="product_image_update_{$obj_id}">
                {if !$gift.extra.exclude_from_calculate}
                    <a href="{"gift_certificates.update?gift_cert_id=`$gift_key`"|fn_url}">
                    {include file="addons/gift_certificates/views/gift_certificates/components/gift_certificates_cart_icon.tpl" width=$settings.Thumbnails.product_cart_thumbnail_width height=$settings.Thumbnails.product_cart_thumbnail_height}
                    </a>
                    <br>
                    <div>{include file="common/button.tpl" text=__("edit") href="gift_certificates.update?gift_cert_id=$gift_key"}</div>
                {else}
                    {include file="addons/gift_certificates/views/gift_certificates/components/gift_certificates_cart_icon.tpl" width=$settings.Thumbnails.product_cart_thumbnail_width height=$settings.Thumbnails.product_cart_thumbnail_height}
                {/if}
            <!--product_image_update_{$obj_id}--></div>
        {/if}
    </td>

    <td class="cart-content-description" style="width: 50%;">
        {if !$gift.extra.exclude_from_calculate}
            <a href="{"gift_certificates.update?gift_cert_id=`$gift_key`"|fn_url}" class="cart-content-product-title">
                {__("gift_certificate")}
            </a>
            {if !$gift.extra.exclude_from_calculate}
                <a class="{$ajax_class} cm-post" href="{"gift_certificates.delete?gift_cert_id=`$gift_key`&redirect_url=`$c_url`"|fn_url}"  data-ca-target-id="cart_items,checkout_totals,cart_status*,checkout_steps,checkout_cart" title="{__("remove")}">
                    <i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                </a>
            {/if}
            {if $use_ajax == true && $cart.amount != 1}
                {assign var="ajax_class" value="cm-ajax"}
            {/if}
        {else}
            <strong>{__("gift_certificate")}</strong>
        {/if}
        <div class="row">
            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                <strong> {__("gift_cert_to")}:</strong>
            </div>
            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">{$gift.recipient}</div>
        </div>
        <div class="row">
            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                <strong> {__("gift_cert_from")}:</strong>
            </div>
            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">{$gift.sender}</div>
        </div>
        <div class="row">
            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                <strong> {__("amount")}:</strong>
            </div>
            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">{include file="common/price.tpl" value=$gift.amount}</div>
        </div>
        <div class="row">
            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                <strong> {__("send_via")}:</strong>
            </div>
            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">{if $gift.send_via == "E"}{__("email")}{else}{__("postal_mail")}{/if}</div>
        </div>

        {if $gift.products && $addons.gift_certificates.free_products_allow == "Y" && !$gift.extra.exclude_from_calculate}
        
        <div class="gift-free-products">
            <a id="sw_gift_products_{$gift_key}" class="cm-combination btn btn-default">{__("free_products")}</a>

            <div class="panel panel-default hidden" id="gift_products_{$gift_key}">
                <div class="panel-body">
                    <div class="cart-content-products">
                        {foreach from=$cart_products item="product" key="key"}
                        {if $cart.products.$key.extra.parent.certificate == $gift_key}
                            <div class="gift-cart-content-products">
                                <div>
                                    <a href="{"products.view?product_id=`$product.product_id`"|fn_url}" title="{$product.product nofilter}">{$product.product|strip_tags|truncate:70:"...":true nofilter}</a>
                                    {if $use_ajax == true}
                                        {assign var="ajax_class" value="cm-ajax"}
                                    {/if}
                                    <a class="{$ajax_class} delete-big" href="{"checkout.delete?cart_id=`$key`&redirect_url=`$c_url`"|fn_url}" data-ca-target-id="cart_items,checkout_totals,cart_status*,checkout_steps" title="{__("remove")}">
                                        <i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                                    </a>
                                    {include file="common/options_info.tpl" product_options=$cart.products.$key.product_options|fn_get_selected_product_options_info fields_prefix="cart_products[`$key`][product_options]"}
                                    {hook name="checkout:product_info"}{/hook}
                                    <input type="hidden" name="cart_products[{$key}][extra][parent][certificate]" value="{$gift_key}" />
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                                        <strong>{__("price")}</strong>
                                    </div>
                                    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">
                                        {include file="common/price.tpl" value=$product.original_price}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                                        <strong>{__("qty")}</strong>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-3 col-xs-7">
                                        <input type="text" size="3" name="cart_products[{$key}][amount]" value="{$product.amount}" class="form-control" {if $product.is_edp == "Y"}readonly="readonly"{/if} />
                                        <input type="hidden" name="cart_products[{$key}][product_id]" value="{$product.product_id}" />
                                    </div>
                                </div>
                                {if $cart.use_discount}
                                <div class="row">
                                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                                        <strong>{__("discount")}</strong>
                                    </div>
                                    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-5">
                                        {if $product.discount|floatval}{include file="common/price.tpl" value=$product.discount}{else}-{/if}
                                    </div>
                                </div>
                                {/if}
                                {if $cart.taxes && $settings.General.tax_calculation != "subtotal"}
                                <div class="row">
                                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                                        <strong>{__("tax")}</strong>
                                    </div>
                                    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-5">
                                        <strong>
                                            {include file="common/price.tpl" value=$product.tax_summary.total}
                                        </strong>
                                    </div>
                                </div>
                                {/if}
                                <div class="row">
                                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                                        <strong>{__("subtotal")}</strong>
                                    </div>
                                    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-5">
                                        {include file="common/price.tpl" value=$product.display_subtotal}
                                    </div>
                                </div>
                            </div>
                        {/if}
                        {/foreach}
                        </div>
                        <div class="form-group pull-right gift-price">
                            <strong>{__("price_summary")}:&nbsp;</strong>
                            {if !$gift.extra.exclude_from_calculate}
                                {include file="common/price.tpl" value=$gift.display_subtotal class="price"}
                            {else}
                                <span class="price">{__("free")}</span>
                            {/if}
                        </div>
                </div>
            </div>

        </div>
        {/if}
    </td>
    <td class="text-right cm-reload-{$obj_id}" id="price_display_update_{$obj_id}">
        {if !$gift.extra.exclude_from_calculate}{include file="common/price.tpl" value=$gift.display_subtotal class="sub-price"}{else}<span class="price">{__("free")}</span>{/if}
    <!--price_display_update_{$obj_id}--></td>
    <td class="text-right cart-content-qty">
    </td>
    <td class="text-right cart-content-price cm-reload-{$obj_id}" id="price_subtotal_update_{$obj_id}">
        {if !$gift.extra.exclude_from_calculate}{include file="common/price.tpl" value=$gift.display_subtotal class="price"}{else}<span class="price">{__("free")}</span>{/if}
    <!--price_subtotal_update_{$obj_id}--></td>
</tr>
{/foreach}

{/if}

{if $runtime.mode == "checkout"}
    {if $cart.coupons|floatval}<input type="hidden" name="c_id" value="" />{/if}
    {hook name="checkout:form_data"}
    {/hook}
{/if}

<div id="cart_items">
    <div class="table-responsive">
    <table class="cart-content table">
    {assign var="prods" value=false}
    <thead>
        <tr>
            <th class="cart-content-title text-left">{__("product")}</th>
            <th class="cart-content-title text-left">&nbsp;</th>
            <th class="cart-content-title text-right">{__("unit_price")}</th>
            <th class="cart-content-title quantity-cell text-center" style="width:135px">{__("quantity")}</th>
            <th class="cart-content-title text-right">{__("total_price")}</th>
        </tr>
    </thead>

    <tbody>
    {if $cart_products}
        {foreach from=$cart_products item="product" key="key" name="cart_products"}
            {assign var="obj_id" value=$product.object_id|default:$key}
            {hook name="checkout:items_list"}

                {if !$cart.products.$key.extra.parent}
                    <tr>
                        <td class="cart-content-image-block">
                            {if $runtime.mode == "cart" || $show_images}
                                <div class="cart-content-image cm-reload-{$obj_id}" id="product_image_update_{$obj_id}">
                                    {hook name="checkout:product_icon"}
                                        <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">
                                        {include file="common/image.tpl" obj_id=$key images=$product.main_pair image_width=$settings.Thumbnails.product_cart_thumbnail_width image_height=$settings.Thumbnails.product_cart_thumbnail_height}</a>
                                    {/hook}
                                <!--product_image_update_{$obj_id}--></div>
                            {/if}
                        </td>

                        <td class="cart-content-description" style="width: 50%;">
                            <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">
                                {$product.product nofilter}
                            </a>
                            {if !$product.exclude_from_calculate}
                                  <a class="{$ajax_class} product-delete" href="{"checkout.delete?cart_id=`$key`&redirect_mode=`$runtime.mode`"|fn_url}" data-ca-target-id="cart_items,checkout_totals,cart_status*,checkout_steps,checkout_cart" title="{__("remove")}">
                                    <i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                                </a>
                            {/if}
                            <div class="sku {if !$product.product_code} hidden{/if}" id="sku_{$key}">
                                {__("sku")}: <span class="cm-reload-{$obj_id}" id="product_code_update_{$obj_id}">{$product.product_code}<!--product_code_update_{$obj_id}--></span>
                            </div>
                            {if $product.product_options}
                                <div class="cm-reload-{$obj_id} options" id="options_update_{$obj_id}">
                                {include file="views/products/components/product_options.tpl" product_options=$product.product_options product=$product name="cart_products" id=$key location="cart" disable_ids=$disable_ids form_name="checkout_form"}
                                <!--options_update_{$obj_id}--></div>
                            {/if}

                            {assign var="name" value="product_options_$key"}
                            {capture name=$name}

                            {capture name="product_info_update"}
                                {hook name="checkout:product_info"}
                                    {if $product.exclude_from_calculate}
                                        <strong><span class="price">{__("free")}</span></strong>
                                    {elseif $product.discount|floatval || ($product.taxes && $settings.General.tax_calculation != "subtotal")}
                                        {if $product.discount|floatval}
                                            {assign var="price_info_title" value=__("discount")}
                                        {else}
                                            {assign var="price_info_title" value=__("taxes")}
                                        {/if}
                                        <p><a data-ca-target-id="discount_{$key}" class="cm-dialog-opener cm-dialog-auto-size" rel="nofollow">{$price_info_title}</a></p>

                                        <div class="group-block hidden" id="discount_{$key}" title="{$price_info_title}">
                                            <table class="more-info table">
                                                <thead>
                                                    <tr>
                                                        <th class="more-info-title">{__("price")}</th>
                                                        <th class="more-info-title">{__("quantity")}</th>
                                                        {if $product.discount|floatval}<th class="more-info-title">{__("discount")}</th>{/if}
                                                        {if $product.taxes && $settings.General.tax_calculation != "subtotal"}<th>{__("tax")}</th>{/if}
                                                        <th class="more-info-title">{__("subtotal")}</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>{include file="common/price.tpl" value=$product.original_price span_id="original_price_`$key`" class="none"}</td>
                                                        <td class="text-center">{$product.amount}</td>
                                                        {if $product.discount|floatval}<td>{include file="common/price.tpl" value=$product.discount span_id="discount_subtotal_`$key`" class="none"}</td>{/if}
                                                        {if $product.taxes && $settings.General.tax_calculation != "subtotal"}<td>{include file="common/price.tpl" value=$product.tax_summary.total span_id="tax_subtotal_`$key`" class="none"}</td>{/if}
                                                        <td>{include file="common/price.tpl" span_id="product_subtotal_2_`$key`" value=$product.display_subtotal class="none"}</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    {/if}
                                    {include file="views/companies/components/product_company_data.tpl" company_name=$product.company_name company_id=$product.company_id}
                                {/hook}
                            {/capture}
                            {if $smarty.capture.product_info_update|trim}
                                <div class="cm-reload-{$obj_id}" id="product_info_update_{$obj_id}">
                                    {$smarty.capture.product_info_update nofilter}
                                <!--product_info_update_{$obj_id}--></div>
                            {/if}
                            {/capture}

                            {if $smarty.capture.$name|trim}
                            <div id="options_{$key}" class="product-options group-block row">
                                <div class="group-block-arrow">
                                    <span class="caret-info">
                                        <span class="caret-outer"></span><span class="caret-inner"></span>
                                    </span>
                                </div>
                                {$smarty.capture.$name nofilter}
                            </div>
                            {/if}
                        </td>

                        <td class="cart-content-price text-right cm-reload-{$obj_id}" id="price_display_update_{$obj_id}">
                        {include file="common/price.tpl" value=$product.display_price span_id="product_price_`$key`"}
                        <!--price_display_update_{$obj_id}--></td>

                        <td class="cart-content-qty {if $product.is_edp == "Y" || $product.exclude_from_calculate} quantity-disabled{/if} text-center">
                            {if $use_ajax == true && $cart.amount != 1}
                                {assign var="ajax_class" value="cm-ajax"}
                            {/if}

                            <div class="cart-content-quantity quantity-bar cm-reload-{$obj_id}{if $settings.Appearance.quantity_changer == "Y"} changer{/if}" id="quantity_update_{$obj_id}">
                                    <input type="hidden" class="hidden" name="cart_products[{$key}][product_id]" value="{$product.product_id}" />
                                    {if $product.exclude_from_calculate}<input type="hidden" name="cart_products[{$key}][extra][exclude_from_calculate]" value="{$product.exclude_from_calculate}" />{/if}
                                    <label class="hidden" for="amount_{$key}"></label>
                                    <div class="cm-value-changer input-group">
                                    {if $product.is_edp == "Y" || $product.exclude_from_calculate}
                                        {$product.amount}
                                    {else}
                                        {if $settings.Appearance.quantity_changer == "Y"}
                                            <span class="input-group-btn">
                                                <a class="btn btn-default cm-increase">&#43;</a>
                                            </span>
                                        {/if}
                                        <input type="text" size="3" id="amount_{$key}" name="cart_products[{$key}][amount]" value="{$product.amount}" class="form-control cm-amount"{if $product.qty_step > 1} data-ca-step="{$product.qty_step}"{/if} />
                                        {if $settings.Appearance.quantity_changer == "Y"}
                                            <span class="input-group-btn">
                                                <a class="btn btn-default cm-decrease">&minus;</a>
                                            </span>
                                        {/if}
                                    {/if}
                                    {if $product.is_edp == "Y" || $product.exclude_from_calculate}
                                        <input type="hidden" name="cart_products[{$key}][amount]" value="{$product.amount}" />
                                    {/if}
                                    {if $product.is_edp == "Y"}
                                        <input type="hidden" name="cart_products[{$key}][is_edp]" value="Y" />
                                    {/if}
                                </div>
                            <!--quantity_update_{$obj_id}--></div>
                        </td>

                        <td class="cart-content-price text-right cm-reload-{$obj_id}" id="price_subtotal_update_{$obj_id}">
                            {include file="common/price.tpl" value=$product.display_subtotal span_id="product_subtotal_`$key`" class="price"}
                            {if $product.zero_price_action == "A"}
                                <input type="hidden" name="cart_products[{$key}][price]" value="{$product.base_price}" />
                            {/if}
                        <!--price_subtotal_update_{$obj_id}--></td>
                    </tr>
                {/if}
            {/hook}
        {/foreach}
        {/if}

        {hook name="checkout:extra_list"}
        {/hook}

    </tbody>
    </table>
    </div>
<!--cart_items--></div>

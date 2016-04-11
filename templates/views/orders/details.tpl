<div class="orders-detail">

    {if $order_info}

        {capture name="order_actions"}
            {if $view_only != "Y"}
                <div class="orders-detail-actions">
                    {hook name="orders:details_tools"}
                        {assign var="print_order" value=__("print_invoice")}
                        {assign var="print_pdf_order" value=__("print_pdf_invoice")}
                        
                        {if $status_settings.appearance_type == "C" && $order_info.doc_ids[$status_settings.appearance_type]}
                            {assign var="print_order" value=__("print_credit_memo")}
                            {assign var="print_pdf_order" value=__("print_pdf_credit_memo")}
                        {elseif $status_settings.appearance_type == "O"}
                            {assign var="print_order" value=__("print_order_details")}
                            {assign var="print_pdf_order" value=__("print_pdf_order_details")}
                        {/if}

                        {include file="common/button.tpl" text=$print_order href="orders.print_invoice?order_id=`$order_info.order_id`" meta="cm-new-window" icon="glyphicon-print fa fa-print"}

                        {include file="common/button.tpl" role="text" meta="cm-no-ajax" text=$print_pdf_order href="orders.print_invoice?order_id=`$order_info.order_id`&format=pdf" icon="glyphicon glyphicon-file fa fa-file"}
                    {/hook}
                    
                    <div class="orders-detail-actions pull-right">
                        {if $view_only != "Y"}
                            {hook name="orders:details_bullets"}
                            {/hook}
                        {/if}
                        
                        {include file="common/button.tpl" text=__("re_order") href="orders.reorder?order_id=`$order_info.order_id`" icon="orders-actions-icon glyphicon glyphicon-repeat fa fa-refresh"}
                    </div>

                </div>
            {/if}
        {/capture}

        {capture name="tabsbox"}

        <div id="content_general" class="tab-pane">

            {if $without_customer != "Y"}
            {* Customer info *}
                <div class="orders-customer">
                    {include file="views/profiles/components/profiles_info.tpl" user_data=$order_info location="I"}
                </div>
            {* /Customer info *}
            {/if}


        {capture name="group"}
            <h3>{__("products_information")}</h3>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="table-responsive">
                    <table class="table orders-detail-table">
                        {hook name="orders:items_list_header"}
                            <thead>
                                <tr>
                                    <th class="orders-detail-product">{__("product")}</th>
                                    <th class="orders-detail-price">{__("price")}</th>
                                    <th class="orders-detail-quantity">{__("quantity")}</th>
                                    {if $order_info.use_discount}
                                        <th class="orders-detail-discount">{__("discount")}</th>
                                    {/if}
                                    {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
                                        <th class="orders-detail-tax">{__("tax")}</th>
                                    {/if}
                                    <th class="orders-detail-subtotal">{__("subtotal")}</th>
                                </tr>
                            </thead>
                        {/hook}
                        {foreach from=$order_info.products item="product" key="key"}
                            {hook name="orders:items_list_row"}
                                {if !$product.extra.parent}
                                    <tr class="valign-top">
                                        <td>
                                            {if $product.is_accessible}<a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{/if}
                                                {$product.product nofilter}
                                            {if $product.is_accessible}</a>{/if}

                                            {if $product.extra.is_edp == "Y"}
                                                <div><a href="{"orders.order_downloads?order_id=`$order_info.order_id`"|fn_url}">[{__("download")}]</a></div>
                                            {/if}
                                            {if $product.product_code}
                                                <div class="orders-detail-code">{__("sku")}:&nbsp;{$product.product_code}</div>
                                            {/if}
                                            {hook name="orders:product_info"}
                                                {if $product.product_options}
                                                    {include file="common/options_info.tpl" product_options=$product.product_options inline_option=true}
                                                {/if}
                                            {/hook}
                                        </td>
                                        <td>
                                            {if $product.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$product.original_price}{/if}
                                        </td>
                                        <td>&nbsp;{$product.amount}</td>
                                        {if $order_info.use_discount}
                                            <td>
                                                {if $product.extra.discount|floatval}{include file="common/price.tpl" value=$product.extra.discount}{else}-{/if}
                                            </td>
                                        {/if}
                                        {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
                                            <td>
                                                {if $product.tax_value|floatval}{include file="common/price.tpl" value=$product.tax_value}{else}-{/if}
                                            </td>
                                        {/if}
                                        <td>
                                             &nbsp;{if $product.extra.exclude_from_calculate}{__("free")}{else}{include file="common/price.tpl" value=$product.display_subtotal}{/if}
                                         </td>
                                    </tr>
                                {/if}
                            {/hook}
                        {/foreach}

                        {hook name="orders:extra_list"}
                            {assign var="colsp" value=5}
                            {if $order_info.use_discount}{assign var="colsp" value=$colsp+1}{/if}
                            {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}{assign var="colsp" value=$colsp+1}{/if}
                        {/hook}

                    </table>
                    </div>
                </div>
            </div>

            {*Customer notes*}
            {if $order_info.notes}
                <div class="orders-notes panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">{__("customer_notes")}</h3>
                    </div>
                    <div class="panel-body">
                        {$order_info.notes}
                    </div>
                </div>
            {/if}
            {*/Customer notes*}

            <div class="orders-summary">
                <h3>{__("summary")}</h3>
                
                <div class="row">
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 orders-summary-wrapper">
                        <table class="table table-bordered orders-summary-table">
                            {hook name="orders:totals"}
                                {if $order_info.payment_id}
                                    <tr>
                                        <td style="width: 60%">{__("payment_method")}:</td>
                                        <td class="text-left" data-ct-orders-summary="summary-payment">
                                            {hook name="orders:totals_payment"}
                                                {$order_info.payment_method.payment} {if $order_info.payment_method.description}({$order_info.payment_method.description}){/if}
                                            {/hook}
                                        </td>
                                    </tr>
                                {/if}

                                {if $order_info.shipping}
                                    <tr>
                                        <td>{__("shipping_method")}:</td>
                                        <td data-ct-orders-summary="summary-ship" class="text-left" >
                                        {hook name="orders:totals_shipping"}
                                        {if $use_shipments}
                                            <ul class="list-unstyled">
                                                {foreach from=$order_info.shipping item="shipping_method"}
                                                    <li>{if $shipping_method.shipping} {$shipping_method.shipping} {else} – {/if}</li>
                                                {/foreach}
                                            </ul>
                                        {else}
                                            {foreach from=$order_info.shipping item="shipping" name="f_shipp"}
                                                {if $shipments[$shipping.group_key].carrier && $shipments[$shipping.group_key].tracking_number}
                                                    {include file="common/carriers.tpl" carrier=$shipments[$shipping.group_key].carrier tracking_number=$shipments[$shipping.group_key].tracking_number}

                                                    {$shipping.shipping}&nbsp;({__("tracking_number")}: <a {if $smarty.capture.carrier_url|strpos:"://"}target="_blank"{/if} href="{$smarty.capture.carrier_url nofilter}">{$shipments[$shipping.group_key].tracking_number}</a>)

                                                    {$smarty.capture.carrier_info nofilter}
                                                {else}
                                                    {$shipping.shipping}
                                                {/if}
                                                {if !$smarty.foreach.f_shipp.last}<br>{/if}
                                            {/foreach}
                                        {/if}
                                        {/hook}
                                        </td>
                                    </tr>
                                {/if}

                                <tr>
                                    <td>{__("subtotal")}:&nbsp;</td>
                                    <td data-ct-orders-summary="summary-subtotal" class="text-left" >{include file="common/price.tpl" value=$order_info.display_subtotal}</td>
                                </tr>
                                {if $order_info.display_shipping_cost|floatval}
                                    <tr>
                                        <td>{__("shipping_cost")}:&nbsp;</td>
                                        <td data-ct-orders-summary="summary-shipcost" class="text-left" >{include file="common/price.tpl" value=$order_info.display_shipping_cost}</td>
                                    </tr>
                                {/if}

                                {if $order_info.discount|floatval}
                                <tr>
                                    <td><strong>{__("including_discount")}:</strong></td>
                                    <td data-ct-orders-summary="summary-discount" class="text-left">
                                        {include file="common/price.tpl" value=$order_info.discount}
                                    </td>
                                </tr>
                                {/if}

                                {if $order_info.subtotal_discount|floatval}
                                    <tr>
                                        <td><strong>{__("order_discount")}:</strong></td>
                                        <td data-ct-orders-summary="summary-sub-discount" class="text-left">
                                            {include file="common/price.tpl" value=$order_info.subtotal_discount}
                                        </td>
                                    </tr>
                                {/if}

                                {if $order_info.coupons}
                                    {foreach from=$order_info.coupons item="coupon" key="key"}
                                        <tr>
                                            <td>{__("coupon")}:</td>
                                            <td data-ct-orders-summary="summary-coupons" class="text-left">{$key}</td>
                                        </tr>
                                    {/foreach}
                                {/if}

                                {if $order_info.taxes}
                                    <tr class="taxes">
                                        <td><strong>{__("taxes")}:</strong></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    {foreach from=$order_info.taxes item=tax_data}
                                        <tr>
                                            <td class="orders-summary-taxes-description">
                                                {$tax_data.description}
                                                {include file="common/modifier.tpl" mod_value=$tax_data.rate_value mod_type=$tax_data.rate_type}
                                                {if $tax_data.price_includes_tax == "Y" && ($settings.Appearance.cart_prices_w_taxes != "Y" || $settings.General.tax_calculation == "subtotal")}
                                                    {__("included")}
                                                {/if}
                                                {if $tax_data.regnumber}
                                                    {$tax_data.regnumber})
                                                {/if}
                                            </td>
                                            <td class="orders-summary-taxes-description" data-ct-orders-summary="summary-tax-sub">
                                                {include file="common/price.tpl" value=$tax_data.tax_subtotal}
                                            </td>
                                        </tr>
                                    {/foreach}
                                {/if}
                                {if $order_info.tax_exempt == "Y"}
                                    <tr>
                                        <td>{__("tax_exempt")}</td>
                                        <td>&nbsp;</td>
                                    <tr>
                                {/if}

                                {if $order_info.payment_surcharge|floatval && !$take_surcharge_from_vendor}
                                    <tr>
                                        <td>{$order_info.payment_method.surcharge_title|default:__("payment_surcharge")}:&nbsp;</td>
                                        <td data-ct-orders-summary="summary-surchange">{include file="common/price.tpl" value=$order_info.payment_surcharge}</td>
                                    </tr>
                                {/if}
                                {hook name="orders:order_total"}
                                    <tr>
                                        <td class="orders-summary-total"><strong>{__("total")}:&nbsp;</strong></td>
                                        <td class="orders-summary-total" data-ct-orders-summary="summary-total">{include file="common/price.tpl" value=$order_info.total}</td>
                                    </tr>
                                {/hook}
                            {/hook}
                        </table>
                    </div>

                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 orders-summary-right">
                        {hook name="orders:info"}{/hook}
                    </div>
                </div>

            </div>

            {if $order_info.promotions}
                {include file="views/orders/components/promotions.tpl" promotions=$order_info.promotions}
            {/if}

            {if $view_only != "Y"}
                <div class="orders-repay">
                    {hook name="orders:repay"}
                        {if $settings.Checkout.repay == "Y" && $payment_methods}
                            {include file="views/orders/components/order_repay.tpl"}
                        {/if}
                    {/hook}
                </div>
            {/if}

        {/capture}
        <div class="orders-product">
            {$smarty.capture.group nofilter}
        </div>
        </div><!-- main order info -->

        {if !"ULTIMATE:FREE"|fn_allowed_for}
        {if $use_shipments}
            <div id="content_shipment_info" class="orders-shipment tab-pane">
                {foreach from=$shipments item="shipment"}
                    <h3>{__("shipment")} #{$shipment.shipment_id}</h3>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <table class="table orders-shipment-table">
                                <thead>
                                    <tr>
                                        <th style="width: 90%">{__("product")}</th>
                                        <th>{__("quantity")}</th>
                                    </tr>
                                </thead>
                                    {foreach from=$shipment.products key="product_hash" item="amount"}
                                    {if $order_info.products.$product_hash}
                                        {assign var="product" value=$order_info.products.$product_hash}
                                        <tr style="vertical-align: top;">
                                            <td>{if $product.is_accessible}<a href="{"products.view?product_id=`$product.product_id`"|fn_url}" class="product-title">{/if}{$product.product nofilter}{if $product.is_accessible}</a>{/if}
                                                {if $product.extra.is_edp == "Y"}
                                                <div class="text-right"><a href="{"orders.order_downloads?order_id=`$order_info.order_id`"|fn_url}">[{__("download")}]</a></div>
                                                {/if}
                                                {if $product.product_code}
                                                <p>{__("sku")}: {$product.product_code}</p>
                                                {/if}
                                                {if $product.product_options}{include file="common/options_info.tpl" product_options=$product.product_options inline_option=true}{/if}
                                            </td>
                                            <td class="text-center">{$amount}</td>
                                        </tr>
                                    {/if}
                                    {/foreach}
                            </table>
                        </div>
                    </div>

                    <div class="orders-shipment-info">
                        <h3>{__("shipping_information")}</h3>
                        
                        <strong>{$shipment.shipping}</strong>
                        {if $shipment.carrier}
                            {include file="common/carriers.tpl" carrier=$shipment.carrier tracking_number=$shipment.tracking_number shipment_id=$shipment.shipment_id}
                            <p>{__("carrier")}: {$smarty.capture.carrier_name nofilter}{if $shipment.tracking_number}({__("tracking_number")}: {if $smarty.capture.carrier_url|trim != ""}<a {if $smarty.capture.carrier_url|strpos:"://"}target="_blank"{/if} href="{$smarty.capture.carrier_url nofilter}">{/if}{$shipment.tracking_number}{if $smarty.capture.carrier_url|trim != ""}</a>{/if}){/if}</p>

                            {$smarty.capture.carrier_info nofilter}
                        {/if}
                    </div>

                    {if $shipment.comments}
                        <div class="panel panel-default orders-shipment-info-comment">
                            <div class="panel-heading">
                                <h3 class="panel-title">{__("comments")}</h3>
                            </div>
                            <div class="panel-body">
                                {$shipment.comments}
                            </div>
                        </div>
                    {/if}

                {foreachelse}
                    <p class="well well-lg no-items">{__("text_no_shipments_found")}</p>
                {/foreach}
            </div>
        {/if}
        {/if}

        {hook name="orders:tabs"}
        {/hook}

        {/capture}
        {include file="common/tabsbox.tpl" top_order_actions=$smarty.capture.order_actions content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section}

    {/if}
</div>

{hook name="orders:details"}
{/hook}

{capture name="mainbox_title"}
    {__("order")}&nbsp;#{$order_info.order_id}
    <small class="date">({$order_info.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"})</small>
    <small class="status">{__("status")}: {include file="common/status.tpl" status=$order_info.status display="view" name="update_order[status]"}</small>
{/capture}

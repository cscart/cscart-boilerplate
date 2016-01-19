{if $wishlist.gift_certificates}

{foreach from=$wishlist.gift_certificates item="gift" key="gift_key" name="gift_certificates"}
{math equation="it + 1" assign="iteration" it=$iteration}
    {$cols = 12/$columns}
    <div class="gift-certificate-wishlist thumbnail grid-thumbnail col-sm-{$cols|floor} col-lg-{$cols|floor} col-md-{$cols|floor}">

            <div class="grid-list-item">
                <div class="wishlist-remove-item">
                    <a href="{"gift_certificates.wishlist_delete?gift_cert_wishlist_id=`$gift_key`"|fn_url}" class="cm-post" title="{__("remove")}">
                        <i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                        <span>{__("remove")}</span></a>
                </div>
                <div class="grid-list-image">
                    <a href="{"gift_certificates.update?gift_cert_wishlist_id=`$gift_key`"|fn_url}">{include file="addons/gift_certificates/views/gift_certificates/components/gift_certificates_cart_icon.tpl" width=$settings.Thumbnails.product_lists_thumbnail_width height=$settings.Thumbnails.product_lists_thumbnail_height}</a>
                </div>
                <div class="caption">
                    <a href="{"gift_certificates.update?gift_cert_wishlist_id=`$gift_key`"|fn_url}" class="product-title">{__("gift_certificate")}{if $gift.products} + {__("free_products")}{/if}</a>
                    {include file="common/price.tpl" value=$gift.amount class="price"}
                    <div class="actions grid-list-actions">
                        <div class="quick-view-button">
                            <a id="opener_gift_cert_picker_{$gift_key}" class="btn btn-default cm-dialog-opener cm-dialog-auto-size" data-ca-target-id="gift_cert_quick_view_{$gift_key}" href="{"gift_certificates.update?gift_cert_wishlist_id=`$gift_key`"|fn_url}" rel="nofollow">{__("quick_view")}</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="hidden" id="gift_cert_quick_view_{$gift_key}" title="{__("gift_certificate")}">
                <form action="{""|fn_url}" {if !$config.tweaks.disable_dhtml}class="cm-ajax cm-form-dialog-closer"{/if} method="post" name="{$form_prefix}gift_cert_form_{$gift_key}">

                <input type="hidden" value="cart_status*,wish_list*" name="result_ids" />
                <input type="hidden" name="gift_cert_data[send_via]" value="{$gift.send_via}" />
                <input type="hidden" name="gift_cert_data[amount]" value="{$gift.amount}" />
                <input type="hidden" name="gift_cert_data[correct_amount]" value="N" />
                <input type="hidden" name="gift_cert_data[recipient]" value="{$gift.recipient}" />
                <input type="hidden" name="gift_cert_data[sender]" value="{$gift.sender}" />
                <input type="hidden" name="gift_cert_data[message]" value="{$gift.message}" />
                {if $gift.email}<input type="hidden" name="gift_cert_data[email]" value="{$gift.email}" />{/if}
                {if $gift.title}<input type="hidden" name="gift_cert_data[title]" value="{$gift.title}" />{/if}
                {if $gift.firstname}<input type="hidden" name="gift_cert_data[firstname]" value="{$gift.firstname}" />{/if}
                {if $gift.lastname}<input type="hidden" name="gift_cert_data[lastname]" value="{$gift.lastname}" />{/if}
                {if $gift.address}<input type="hidden" name="gift_cert_data[address]" value="{$gift.address}" />{/if}
                {if $gift.city}<input type="hidden" name="gift_cert_data[city]" value="{$gift.city}" />{/if}
                {if $gift.country}<input type="hidden" name="gift_cert_data[country]" value="{$gift.country}" />{/if}
                {if $gift.state}<input type="hidden" name="gift_cert_data[state]" value="{$gift.state}" />{/if}
                {if $gift.zipcode}<input type="hidden" name="gift_cert_data[zipcode]" value="{$gift.zipcode}" />{/if}

                <div class="wishlist-product-block row">
                    <div class="col-lg-3 col-sm-3 col-xs-12">
                        <a href="{"gift_certificates.update?gift_cert_wishlist_id=`$gift_key`"|fn_url}">{include file="addons/gift_certificates/views/gift_certificates/components/gift_certificates_cart_icon.tpl" width="150" height="150"}</a>

                        <div class="center">{include file="common/button.tpl" text=__("edit") href="gift_certificates.update?gift_cert_wishlist_id=$gift_key"}</div>
                    </div>
                    <div class="col-lg-9 col-sm-9 col-xs-12">
                        <a href="{"gift_certificates.update?gift_cert_wishlist_id=`$gift_key`"|fn_url}" class="product-title">{__("gift_certificate")}</a>
                        <div class="row">
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                                <strong>{__("gift_cert_to")}:</strong>
                            </div>
                            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">{$gift.recipient}</div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                                <strong>{__("gift_cert_from")}:</strong>
                            </div>
                            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">{$gift.sender}</div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                                <strong>{__("amount")}:</strong>
                            </div>
                            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">{include file="common/price.tpl" value=$gift.amount}</div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                                <strong>{__("send_via")}:</strong>
                            </div>
                            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">{if $gift.send_via == "E"}{__("email")}{else}{__("postal_mail")}{/if}</div>
                        </div>

                        {if $gift.products && $addons.gift_certificates.free_products_allow == "Y"}
                        <div class="clearfix">
                            <p><strong>{__("free_products")}:</strong></p>

                            {assign var="gift_price" value=""}
                            <table class="table">
                            <tr>
                                <th style="width: 50%">{__("product")}</th>
                                <th style="width: 10%">{__("price")}</th>
                                <th style="width: 10%">{__("quantity")}</th>
                                <th class="right" style="width: 10%">{__("subtotal")}</th>
                            </tr>
                            {foreach from=$extra_products item="_product" key="key_cert_prod"}

                                {if $wishlist.products.$key_cert_prod.extra.parent.certificate == $gift_key}

                                <input type="hidden" name="gift_cert_data[products][{$key_cert_prod}][product_id]" value="{$wishlist.products.$key_cert_prod.product_id}" />
                                <input type="hidden" name="gift_cert_data[products][{$key_cert_prod}][amount]" value="{$wishlist.products.$key_cert_prod.amount}" />

                                {math equation="item_price + gift_" item_price=$_product.subtotal|default:"0" gift_=$gift_price|default:"0" assign="gift_price"}
                                <tr>
                                    <td>
                                        <a href="{"products.view?product_id=`$_product.product_id`"|fn_url}">{$_product.product}</a>
                                        {if $_product.product_options}
                                            {include file="common/options_info.tpl" product_options=$_product.product_options fields_prefix="gift_cert_data[products][`$key_cert_prod`][product_options]"}
                                        {/if}
                                    </td>
                                    <td class="center">
                                        {include file="common/price.tpl" value=$_product.price}</td>
                                    <td class="center nowrap">
                                        {$gift.products.$key_cert_prod.amount}</td>
                                    <td class="right nowrap">
                                        {math equation="item_price*amount" item_price=$_product.price|default:"0" assign="subtotal" amount=$gift.products.$key_cert_prod.amount}
                                        {math equation="subtotal + gift_" subtotal=$subtotal|default:"0" gift_=$gift_price|default:"0" assign="gift_price"}
                                        {include file="common/price.tpl" value=$subtotal}</td>
                                </tr>
                                {/if}

                            {/foreach}
                            </table>

                            <div class="row">
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
                                    <strong>{__("price_summary")}:</strong>
                                </div>
                                <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">
                                    {math equation="item_price + gift_" item_price=$gift_price|default:"0" gift_=$gift.amount|default:"0" assign="gift_price"}
                                    <strong>{include file="common/price.tpl" value=$gift_price}</strong>
                                </div>
                            </div>
                        </div>
                        {/if}
                        
                        <div class="row">
                            <div class="col-lg-12 product-block-button">
                                {include file="common/add_to_cart.tpl" name="dispatch[gift_certificates.add]"}
                            </div>
                        </div>
                    </div>
                </div>
            </form>
       </div>
    </div>

{/foreach}
{capture name="iteration"}{$iteration}{/capture}
{/if}
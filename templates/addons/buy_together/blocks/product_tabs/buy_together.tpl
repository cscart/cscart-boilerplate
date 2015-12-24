{** block-description:buy_together **}

{script src="js/tygh/exceptions.js"}

{if $chains}

    {if !$config.tweaks.disable_dhtml && !$no_ajax}
        {assign var="is_ajax" value=true}
    {/if}
    
    {foreach from=$chains key="key" item="chain"}
        {assign var="obj_prefix" value="bt_`$chain.chain_id`"}
        <form {if $is_ajax}class="cm-ajax cm-ajax-full-render"{/if} action="{""|fn_url}" method="post" name="chain_form_{$chain.chain_id}" enctype="multipart/form-data">
        <input type="hidden" name="redirect_url" value="{$config.current_url}" />
        <input type="hidden" name="result_ids" value="cart_status*,wish_list*" />
        {if !$stay_in_cart || $is_ajax}
            <input type="hidden" name="redirect_url" value="{$config.current_url}" />
        {/if}
        <input type="hidden" name="product_data[{$chain.product_id}_{$chain.chain_id}][chain]" value="{$chain.chain_id}" />
        <input type="hidden" name="product_data[{$chain.product_id}_{$chain.chain_id}][product_id]" value="{$chain.product_id}" />

        <h3>{$chain.name}</h3>

        {assign var="buy_together_options_class" value="cm-reload-{$obj_prefix}{$chain.product_id}_{$chain.chain_id}"}

        {if $chain.products}
            {foreach from=$chain.products key="_id" item="_product"}
                {assign var="buy_together_options_class" value="{$buy_together_options_class} cm-reload-{$obj_prefix}{$_product.product_id}"}
            {/foreach}
        {/if}

        <div class="buy-together row">
            <div class="buy-together-products">
            {if $chain.products}
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                    <div class="buy-together-product">
                        <div class="buy-together-product-image cm-reload-{$obj_prefix}{$chain.product_id}_{$chain.chain_id}" id="bt_product_image_{$obj_prefix}{$chain.product_id}_{$chain.chain_id}_main">
                            <a href="{"products.view?product_id=`$chain.product_id`"|fn_url}">{include file="common/image.tpl" image_width=$settings.Thumbnails.product_lists_thumbnail_width image_height=$settings.Thumbnails.product_lists_thumbnail_height obj_id="`$chain.chain_id`_`$chain.product_id`" images=$chain.main_pair class="buy-together-product-image"}</a>
                        <!--bt_product_image_{$obj_prefix}{$chain.product_id}_{$chain.chain_id}_main--></div>

                        <div class="buy-together-product-name">
                             <a href="{"products.view?product_id=`$chain.product_id`"|fn_url}">{$chain.product_name}</a>
                        </div>

                        {if $chain.product_options}
                            {capture name="buy_together_product_options"}
                                <div id="buy_together_options_{$chain.chain_id}_{$key}_main" class="buy-together-box">
                                    <div class="{$buy_together_options_class}" id="buy_together_options_update_{$chain.chain_id}_{$chain.product_id}_main">
                                        <input type="hidden" name="appearance[show_product_options]" value="1" />
                                        <input type="hidden" name="appearance[bt_chain]" value="{$chain.chain_id}" />
                                        <input type="hidden" name="appearance[bt_id]" value="{$key}" />
                                        
                                        {include file="views/products/components/product_options.tpl" product=$chain id="`$chain.product_id`_`$chain.chain_id`" product_options=$chain.product_options name="product_data" no_script=true extra_id="`$chain.product_id`_`$chain.chain_id`_main"}
                                    <!--buy_together_options_update_{$chain.chain_id}_{$chain.product_id}_main--></div>
                                    <div class="buttons-container">
                                        {include file="common/button.tpl" id="add_item_close" as="link" text=__("save_and_close") meta="cm-dialog-closer"}
                                    </div>
                                </div>
                            {/capture}
                            <div class="buy-together-product-options">
                                {include file="common/popupbox.tpl" id="buy_together_options_`$chain.chain_id`_`$chain.product_id`_main" link_meta="btn btn__primary" text=__("specify_options") content=$smarty.capture.buy_together_product_options link_text=__("specify_options") link_meta="btn btn-default"}
                            </div>
                        {/if}
                        <div class="buy-together-product-price cm-reload-{$obj_prefix}{$chain.product_id}_{$chain.chain_id}" id="bt_product_price_{$obj_prefix}{$chain.product_id}_{$chain.chain_id}_main">
                            {$chain.min_qty}&nbsp;x
                            {if !(!$auth.user_id && $settings.General.allow_anonymous_shopping == "hide_price_and_add_to_cart")}
                                {if $chain.price != $chain.discounted_price}
                                    <span class="strike">{include file="common/price.tpl" value=$chain.price}</span>
                                {/if}
                                {include file="common/price.tpl" value=$chain.discounted_price}
                            {/if}
                        <!--bt_product_price_{$obj_prefix}{$chain.product_id}_{$chain.chain_id}_main--></div>
                    </div>
                </div>
            {/if}
            
            {foreach from=$chain.products key="_id" item="_product"}
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                    <div class="buy-together-product">
                        <input type="hidden" name="product_data[{$_product.product_id}][product_id]" value="{$_product.product_id}" />

                        <div class="buy-together-product-image cm-reload-{$obj_prefix}{$_product.product_id}" id="bt_product_image_{$chain.chain_id}_{$_product.product_id}">
                            <a href="{"products.view?product_id=`$_product.product_id`"|fn_url}">{include file="common/image.tpl" image_width=$settings.Thumbnails.product_lists_thumbnail_width image_height=$settings.Thumbnails.product_lists_thumbnail_height obj_id="`$chain.chain_id`_`$_product.product_id`" images=$_product.main_pair class="buy-together-product-image"}</a>
                        <!--bt_product_image_{$chain.chain_id}_{$_product.product_id}--></div>

                        <div class="buy-together-product-name">
                            <a href="{"products.view?product_id=`$_product.product_id`"|fn_url}">{$_product.product_name}</a>
                        </div>

                        {if $_product.product_options}
                            {foreach from=$_product.product_options item="option"}
                                <div class="buy-together-option"><span class="buy-together-option-name">{$option.option_name}</span>: {$option.variant_name}</div>
                            {/foreach}
                        {elseif $_product.aoc}
                            {capture name="buy_together_product_options"}
                                <div id="buy_together_options_{$chain.chain_id}_{$_product.product_id}" class="buy-together-box">
                                    <div class="{$buy_together_options_class}" id="buy_together_options_update_{$chain.chain_id}_{$_product.product_id}">
                                        <input type="hidden" name="appearance[show_product_options]" value="1" />
                                        <input type="hidden" name="appearance[bt_chain]" value="{$chain.chain_id}" />
                                        <input type="hidden" name="appearance[bt_id]" value="{$_id}" />
                                        {include file="views/products/components/product_options.tpl" product=$_product id=$_product.product_id  product_options=$_product.options name="product_data" no_script=true extra_id="`$_product.product_id`_`$chain.chain_id`"}
                                        <!--buy_together_options_update_{$chain.chain_id}_{$_product.product_id}--></div>

                                    <div class="buttons-container">
                                        {include file="common/button.tpl" id="add_item_close" as="link" text=__("save_and_close") meta="cm-dialog-closer"}
                                    </div>
                                </div>
                            {/capture}
                            <div class="buy-together-product-options">
                                {include file="common/popupbox.tpl" id="buy_together_options_`$chain.chain_id`_`$_product.product_id`" link_meta="btn btn-primary" text=__("specify_options") content=$smarty.capture.buy_together_product_options link_text=__("specify_options") act="general"}
                            </div>
                        {/if}
                        <div class="buy-together-product-price cm-reload-{$obj_prefix}{$_product.product_id}" id="bt_product_price_{$chain.chain_id}_{$_product.product_id}">
                            {$_product.amount}&nbsp;x
                            {if !(!$auth.user_id && $settings.General.allow_anonymous_shopping == "hide_price_and_add_to_cart")}
                                {if $_product.price != $_product.discounted_price}
                                    <span class="strike">{include file="common/price.tpl" value=$_product.price}</span>
                                {/if}
                                {include file="common/price.tpl" value=$_product.discounted_price}
                            {/if}
                        <!--bt_product_price_{$chain.chain_id}_{$_product.product_id}--></div>
                    </div>
                </div>
            {/foreach}
            </div>
            
            {if $chain.description}
                <div class="buy-together-description">
                    {$chain.description nofilter}
                </div>
            {/if}
            
            {if !(!$auth.user_id && $settings.General.allow_anonymous_shopping == "hide_price_and_add_to_cart")}
                <div class="buy-together-price {$buy_together_options_class}" id="bt_total_price_{$obj_prefix}{$chain.product_id}_{$chain.chain_id}">
                    <div class="buy-together-price-old">
                        <span class="buy-together-price-title">{__("total_list_price")}</span>
                        <span>{include file="common/price.tpl" value=$chain.total_price}</span>
                    </div>
                    <h4 class="buy-together-price-new">
                        <span class="buy-together-price-title">{__("price_for_all")}</span>
                        {include file="common/price.tpl" value=$chain.chain_price}
                    </h4>
                <!--bt_total_price_{$obj_prefix}{$chain.product_id}_{$chain.chain_id}--></div>
                {if !(!$auth.user_id && $settings.General.allow_anonymous_shopping == "hide_add_to_cart_button")}
                    <div width="100%" class="buttons-container" id="wrap_chain_button_{$chain.chain_id}">
                        {include file="common/button.tpl" text=__("add_all_to_cart") id="chain_button_`$chain.chain_id`" name="dispatch[checkout.add]" obj_id=$obj_id meta="btn-primary"}
                    </div>
                {/if}
            {else}
            <p>{__("sign_in_to_view_price")}</p>
            {/if}
        </div>
        
        </form>
    {/foreach}
    
{/if}

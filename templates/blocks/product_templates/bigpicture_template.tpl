{script src="js/tygh/exceptions.js"}
<div class="bigpicture row">
    {hook name="products:view_main_info"}
        {if $product}
            {assign var="obj_id" value=$product.product_id}
            {include file="common/product_data.tpl" product=$product meta="btn-lg btn-block" but_text=__("add_to_cart")}
            <div class="bigpicture-left col-lg-8 col-md-8 col-sm-8 col-xs-12">
                    {hook name="products:main_info_title"}
                        {if !$hide_title}
                            <h2 {live_edit name="product:product:{$product.product_id}"} class="text-center">{$product.product nofilter}</h2>
                        {/if}
                    {/hook}

                    {hook name="products:image_wrap"}
                        {if !$no_images}
                            <div class="bigpicture-img {if $product.image_pairs|@count < 1} bigpicture-no-thumbs{/if} cm-reload-{$product.product_id} {if $settings.Appearance.thumbnails_gallery == "Y"}bigpicture-as-gallery{else}bigpicture-as-thumbs{/if}" id="product_images_{$product.product_id}_update">
                                {include file="views/products/components/product_images.tpl" product=$product show_detailed_link="Y" thumbnails_size=55}
                            <!--product_images_{$product.product_id}_update--></div>
                        {/if}
                    {/hook}
            </div>

            <div class="bigpicture-right col-lg-4 col-md-4 col-sm-4 col-xs-12">
                {assign var="form_open" value="form_open_`$obj_id`"}
                {$smarty.capture.$form_open nofilter}

                {assign var="old_price" value="old_price_`$obj_id`"}
                {assign var="price" value="price_`$obj_id`"}
                {assign var="clean_price" value="clean_price_`$obj_id`"}
                {assign var="list_discount" value="list_discount_`$obj_id`"}
                {assign var="discount_label" value="discount_label_`$obj_id`"}

                <div class="panel panel-default">
                    <ul class="list-group">
                        <li class="list-group-item">
                            {hook name="products:brand"}
                                <div class="bigpicture-brand text-center">
                                    {include file="views/products/components/product_features_short_list.tpl" features=$product.header_features feature_image=true}
                                </div>
                            {/hook}
                        </li>
                        <li class="list-group-item">
                            <div class="{if $smarty.capture.$old_price|trim || $smarty.capture.$clean_price|trim || $smarty.capture.$list_discount|trim}prices-container {/if}price-wrap">
                                {if $smarty.capture.$old_price|trim || $smarty.capture.$clean_price|trim || $smarty.capture.$list_discount|trim}
                                    <div class="bigpicture-prices text-center">
                                        {if $smarty.capture.$old_price|trim}{$smarty.capture.$old_price nofilter}{/if}
                                {/if}

                                {if $smarty.capture.$price|trim}
                                    <div class="bigpicture-price-actual text-center">
                                        {$smarty.capture.$price nofilter}
                                    </div>
                                {/if}

                                {if $smarty.capture.$old_price|trim || $smarty.capture.$clean_price|trim || $smarty.capture.$list_discount|trim}
                                        {$smarty.capture.$clean_price nofilter}
                                        {$smarty.capture.$list_discount nofilter}

                                        {assign var="discount_label" value="discount_label_`$obj_prefix``$obj_id`"}
                                        {$smarty.capture.$discount_label nofilter}
                                    </div>
                                {/if}
                            </div>
                        </li>
                        <li class="list-group-item">
                            <div class="bigpicture-sidebar-bottom">
                                {if $capture_options_vs_qty}{capture name="product_options"}{$smarty.capture.product_options nofilter}{/if}
                                <div class="bigpicture-option">
                                    {assign var="product_options" value="product_options_`$obj_id`"}
                                    {$smarty.capture.$product_options nofilter}
                                </div>
                                {if $capture_options_vs_qty}{/capture}{/if}

                                {if $capture_options_vs_qty}{capture name="product_options"}{$smarty.capture.product_options nofilter}{/if}
                                <div class="bigpicture-advanced-option">
                                    {assign var="advanced_options" value="advanced_options_`$obj_id`"}
                                    {$smarty.capture.$advanced_options nofilter}
                                </div>
                                {if $capture_options_vs_qty}{/capture}{/if}

                                <div class="bigpicture-advanced-sku">
                                    {assign var="sku" value="sku_`$obj_id`"}
                                    {$smarty.capture.$sku nofilter}
                                </div>

                                {if $capture_options_vs_qty}{capture name="product_options"}{$smarty.capture.product_options nofilter}{/if}
                                <div class="bigpicture-field-group row">
                                    {assign var="product_amount" value="product_amount_`$obj_id`"}
                                    {$smarty.capture.$product_amount nofilter}

                                    {assign var="qty" value="qty_`$obj_id`"}
                                    {$smarty.capture.$qty nofilter}

                                    {assign var="min_qty" value="min_qty_`$obj_id`"}
                                    {$smarty.capture.$min_qty nofilter}
                                </div>
                                {if $capture_options_vs_qty}{/capture}{/if}

                                {assign var="product_edp" value="product_edp_`$obj_id`"}
                                {$smarty.capture.$product_edp nofilter}

                                {hook name="products:promo_text"}
                                {if $product.promo_text}
                                <div class="product-block-note">
                                    {$product.promo_text nofilter}
                                </div>
                                {/if}
                                {/hook}

                                {if $show_descr}
                                {assign var="prod_descr" value="prod_descr_`$obj_id`"}
                                    <h3 class="bigpicture-description-title">{__("description")}</h3>
                                    <div class="bigpicture-description">{$smarty.capture.$prod_descr nofilter}</div>
                                {/if}
                            </div>
                        </li>
                        <li class="list-group-item">
                            {if $capture_buttons}{capture name="buttons"}{/if}
                            <div class="bigpicture-button actions">
                                {if $show_details_button}
                                    {include file="common/button.tpl" href="products.view?product_id=`$product.product_id`" text=__("view_details") class="btn-lg"}
                                {/if}

                                {assign var="add_to_cart" value="add_to_cart_`$obj_id`"}
                                {$smarty.capture.$add_to_cart nofilter}

                                {assign var="list_buttons" value="list_buttons_`$obj_id`"}
                                {$smarty.capture.$list_buttons nofilter}
                            </div>
                            {if $capture_buttons}{/capture}{/if}
                        </li>
                    </ul>
                </div>

                {assign var="form_close" value="form_close_`$obj_id`"}
                {$smarty.capture.$form_close nofilter}

                {hook name="products:product_detail_bottom"}
                {/hook}

                {if $show_product_tabs}
                {include file="views/products/components/product_popup_tabs.tpl"}
                {$smarty.capture.popupsbox_content nofilter}
                {/if}
            </div>
            <div class="clearfix"></div>
        {/if}

    {/hook}

    {if $smarty.capture.hide_form_changed == "Y"}
        {assign var="hide_form" value=$smarty.capture.orig_val_hide_form}
    {/if}

    {if $show_product_tabs}
        <div class="col-lg-12">
            {include file="views/products/components/product_tabs.tpl"}

            {if $blocks.$tabs_block_id.properties.wrapper}
                {include file=$blocks.$tabs_block_id.properties.wrapper content=$smarty.capture.tabsbox_content title=$blocks.$tabs_block_id.description}
            {else}
                {$smarty.capture.tabsbox_content nofilter}
            {/if}
        </div>
    {/if}
</div>
{capture name="mainbox_title"}{assign var="details_page" value=true}{/capture}
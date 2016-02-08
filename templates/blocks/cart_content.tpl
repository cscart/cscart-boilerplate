{assign var="dropdown_id" value=$block.snapping_id}
{assign var="r_url" value=$config.current_url|escape:url}
{hook name="checkout:cart_content"}
<div class="dropdown cart-dropdown" id="cart_status_{$dropdown_id}">
    <button class="btn btn-default dropdown-toggle" type="button" id="cart_dropdown_{$dropdown_id}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
    {hook name="checkout:dropdown_title"}
        {if $smarty.session.cart.amount}
            <i class="glyphicon glyphicon-shopping-cart fa fa-shopping-cart filled"></i>
            <span>{$smarty.session.cart.amount}&nbsp;{__("items")} {__("for")}&nbsp;{include file="common/price.tpl" value=$smarty.session.cart.display_subtotal}</span>
            <span class="caret"></span>
        {else}
            <i class="glyphicon glyphicon-shopping-cart fa fa-shopping-cart empty"></i>
            <span>{__("cart_is_empty")}</span>
            <span class="caret"></span>
        {/if}
    {/hook}
    </button>

    <ul aria-labelledby="cart_dropdown_{$dropdown_id}" class="cm-cart-content dropdown-menu dropdown-menu-right {if $block.properties.products_links_type == "thumb"}cm-cart-content-thumb{/if} {if $block.properties.display_delete_icons == "Y"}cm-cart-content-delete{/if}">
        {hook name="checkout:minicart"}
        {if $smarty.session.cart.amount}
            {hook name="index:cart_status"}
            {assign var="_cart_products" value=$smarty.session.cart.products|array_reverse:true}
            {foreach from=$_cart_products key="key" item="product" name="cart_products"}
                {hook name="checkout:minicart_product"}
                {if !$product.extra.parent}
                    <li>
                        <div class="media">
                            {hook name="checkout:minicart_product_info"}
                            {if $block.properties.products_links_type == "thumb"}
                            <div class="media-left">
                                {include file="common/image.tpl" image_width="40" image_height="40" images=$product.main_pair no_ids=true class="media-object"}
                            </div>
                            {/if}
                            <div class="media-body">
                                <a class="media-heading" href="{"products.view?product_id=`$product.product_id`"|fn_url}">
                                    {$product.product_id|fn_get_product_name nofilter}
                                </a>
                                <p>
                                    <span>{$product.amount}</span><span>&nbsp;x&nbsp;</span>
                                    {include file="common/price.tpl" value=$product.display_price span_id="price_`$key`_`$dropdown_id`" class="none"}
                                </p>
                            </div>
                            {if $block.properties.display_delete_icons == "Y"}
                            <div class="media-right cm-cart-item-delete">
                                {if (!$runtime.checkout || $force_items_deletion) && !$product.extra.exclude_from_calculate}
                                {include file="common/button.tpl" href="checkout.delete.from_status?cart_id=`$key`&redirect_url=`$r_url`" meta="cm-ajax cm-ajax-full-render" target_id="cart_status*" name="delete_cart_item" as="link" icon="glyphicon-remove-sign fa fa-times-circle"}
                                {/if}
                            </div>
                            {/if}
                            {/hook}
                        </div>
                    </li>
                    <li role="separator" class="divider"></li>
                {/if}
                {/hook}
            {/foreach}
            {/hook}
        {else}
            <li>
                <div class="buttons text-center text-muted">
                    <span>{__("cart_is_empty")}</span>
                </div>
            </li>
        {/if}
        {if $block.properties.display_bottom_buttons == "Y" && $smarty.session.cart.amount}
            <li class="cm-cart-buttons">
                <div class="buttons">
                    <a href="{"checkout.cart"|fn_url}" rel="nofollow" class="btn btn-default">{__("view_cart")}</a>
                    {if $settings.General.checkout_redirect != "Y"}
                    <a href="{"checkout.checkout"|fn_url}" rel="nofollow" class="btn btn-success pull-right">{__("checkout")}</a>
                    {/if}
                </div>
            </li>
        {/if}
        {/hook}
    </ul>
<!--cart_status_{$dropdown_id}--></div>
{/hook}
{if $product.extra.buy_together}
    <ul class="list-unstyled buy-together-cart-items-list">
        {foreach from=$_cart_products item="_product" key="_key"}
            {if $_product.extra.parent.buy_together == $key}
                <li>
                    {if $block.properties.products_links_type == "thumb"}
                        <div class="cart-items-list-item-image pull-left">
                            {include file="common/image.tpl" image_width="40" image_height="40" images=$_product.main_pair no_ids=true}
                        </div>
                    {/if}
                    <div class="cart-items-list-item-desc">
                        <a href="{"products.view?product_id=`$_product.product_id`"|fn_url}"
                           class="buy-together-cart-item-link">{$_product.product_id|fn_get_product_name}</a>
                        <p>
                            <span>{$_product.amount}</span><span>&nbsp;x&nbsp;</span>{include file="common/price.tpl" value=$_product.display_price span_id="price_`$key`_`$dropdown_id`" class="none"}</p>
                    </div>
                </li>
                {if $_product.product_option_data}
                    <li class="buy-together-cart-item">{include file="common/options_info.tpl" product_options=$_product.product_option_data}</li>
                {/if}
            {/if}
        {/foreach}
    </ul>
{/if}
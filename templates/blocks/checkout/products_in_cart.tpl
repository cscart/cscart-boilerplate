<div id="checkout_info_products_{$block.snapping_id}">
    <ul class="list-group">
        {hook name="block_checkout:cart_items"}
        {foreach from=$cart_products key="key" item="product" name="cart_products"}
            {hook name="block_checkout:cart_products"}
            {if !$cart.products.$key.extra.parent}
                <li class="list-group-item">
                    <div class="media">
                        <div class="media-body">
                            <div class="media-heading">
                                <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{$product.product nofilter}</a>
                            </div>
                            <div>{$product.amount}&nbsp;x&nbsp;{include file="common/price.tpl" value=$product.display_price}</div>
                            {include file="common/options_info.tpl" product_options=$product.product_options no_block=true}
                            {hook name="block_checkout:product_extra"}{/hook}
                        </div>
                        {if !$product.exclude_from_calculate}
                        <div class="media-right">
                            {include file="common/button.tpl" href="checkout.delete?cart_id=`$key`&redirect_mode=`$runtime.mode`" icon="glyphicon glyphicon-remove fa fa-times" meta="btn-xs" target_id="cart_status*"}
                        </div>
                        {/if}
                    </div>
                </li>
            {/if}
            {/hook}
        {/foreach}
        {/hook}
    </ul>
<!--checkout_info_products_{$block.snapping_id}--></div>
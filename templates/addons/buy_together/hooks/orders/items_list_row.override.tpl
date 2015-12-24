{if $product.extra.buy_together}
    {assign var="conf_price" value=$product.price|default:"0"}
    {assign var="conf_subtotal" value=$product.display_subtotal|default:"0"}
    {assign var="conf_discount" value=$product.extra.discount|default:"0"}
    {assign var="conf_tax" value=$product.tax_value|default:"0"}

    {assign var="_colspan" value=4}
    {assign var="c_product" value=$product}
    {foreach from=$order_info.products item="sub_oi"}
        {if $sub_oi.extra.parent.buy_together && $sub_oi.extra.parent.buy_together == $product.cart_id}
            {capture name="is_conf"}1{/capture}
            {math equation="item_price * amount + conf_price" amount=$sub_oi.extra.min_qty|default:"1" item_price=$sub_oi.price|default:"0" conf_price=$conf_price assign="conf_price"}
            {math equation="discount + conf_discount" discount=$sub_oi.extra.discount|default:"0" conf_discount=$conf_discount assign="conf_discount"}
            {math equation="tax + conf_tax" tax=$sub_oi.tax_value|default:"0" conf_tax=$conf_tax assign="conf_tax"}
            {math equation="subtotal + conf_subtotal" subtotal=$sub_oi.display_subtotal|default:"0" conf_subtotal=$conf_subtotal assign="conf_subtotal"}
        {/if}
    {/foreach}

    <tr class="buy-together-orders valign-top">
        <td class="valign-top">
            {if $product.is_accessible}<a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{/if}
                {$product.product nofilter}
            {if $product.is_accessible}</a>{/if}

            {if $product.extra.is_edp == "Y"}
                <div class="right"><a href="{"orders.order_downloads?order_id=`$order_info.order_id`"|fn_url}">[{__("download")}]</a></div>
            {/if}
            {if $product.product_code}
                <div class="orders-detail-table-code">{__("sku")}:&nbsp;{$product.product_code}</div>
            {/if}
            {hook name="orders:product_info"}
                {if $product.product_options}{include file="common/options_info.tpl" product_options=$product.product_options}{/if}
            {/hook}
            
            {if $smarty.capture.is_conf}
                <ul class="list-group">
                    <li class="list-group-item">
                        <h4 class="combination-link">{__("buy_together")}</h4>
                    </li>
                    {foreach from=$order_info.products item="product" key="sub_key"}
                        {if $product.extra.parent.buy_together && $product.extra.parent.buy_together == $c_product.cart_id}
                            <li class="list-group-item cart-content-products-item">
                                <div>
                                    {if $product.is_accessible}<a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{/if}{$product.product|truncate:50:"...":true nofilter}{if $product.is_accessible}</a>{/if}&nbsp;
                                    {if $product.product_code}
                                    <p>{__("sku")}:&nbsp;{$product.product_code}</p>
                                    {/if}
                                    {hook name="orders:product_info"}
                                    {if $product.product_options}
                                        {include file="common/options_info.tpl" product_options=$product.product_options}
                                    {/if}
                                    {/hook}
                                    </span>
                                </div>
                                <div class="cart-content-item">
                                    <strong >{__("price")}</strong>
                                    <span>
                                        {include file="common/price.tpl" value=$product.price}
                                    </span>
                                </div>
                                <div class="cart-content-item">
                                    <strong>{__("quantity")}</strong>
                                    <span>
                                        {$product.amount}
                                    </span>
                                </div>
                                {if $order_info.use_discount}
                                <div class="cart-content-item">
                                    <strong>{__("discount")}</strong>
                                    <span>
                                        {if $product.extra.discount|floatval}{include file="common/price.tpl" value=$product.extra.discount}{else}-{/if}
                                    </span>
                                </div>
                                {/if}
                                {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
                                <div class="cart-content-item">
                                    <strong>{__("tax")}</strong>
                                    <span>
                                        {include file="common/price.tpl" value=$product.tax_value}
                                    </span>
                                </div>
                                {/if}
                                <div class="cart-content-item">
                                    <strong>{__("subtotal")}</strong>
                                    <span>
                                        {include file="common/price.tpl" value=$product.display_subtotal}
                                    </span>
                                </div>
                            </li>
                        {/if}
                    {/foreach}
                </ul>
            {/if}
        </td>
        <td class="right">
            {include file="common/price.tpl" value=$conf_price}
        </td>
        <td class="center">&nbsp;{$product.amount}</td>
        {if $order_info.use_discount}
            {assign var="_colspan" value=$_colspan+1}
            <td class="right">
                {include file="common/price.tpl" value=$conf_discount}
            </td>
            {/if}
        {if $order_info.taxes && $settings.General.tax_calculation != "subtotal"}
            {assign var="_colspan" value=$_colspan+1}
            <td class="center">
                {include file="common/price.tpl" value=$conf_tax}
            </td>
        {/if}
        <td class="right">
            &nbsp;{include file="common/price.tpl" value=$conf_subtotal}
        </td>
    </tr>
{/if}
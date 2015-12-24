{if $cart.products.$key.extra.buy_together}
    {foreach from=$cart_products item="_product" key="key_conf"}
        {if $cart.products.$key_conf.extra.parent.buy_together == $key}
            {capture name="is_conf_prod"}1{/capture}
        {/if}
    {/foreach}

    {if $smarty.capture.is_conf_prod}
        <h4>{__("buy_together")}:</h4>
        <div class="product-options" id="buy_together_{$key}" title="{__("buy_together")}">
            <table class="table">
                <thead>
                <tr>
                    <th>{__("product")}</th>
                    <th>{__("price")}</th>
                    <th>{__("quantity")}</th>
                    <th class="right">{__("subtotal")}</th>
                </tr>
                </thead>
                {foreach from=$cart_products item="_product" key="key_conf"}
                    {if $cart.products.$key_conf.extra.parent.buy_together == $key}
                        <tr>
                            <td>
                                <a href="{"products.view?product_id=`$_product.product_id`"|fn_url}"
                                   class="underlined">{$_product.product}</a><br/>
                                {if $_product.product_options}
                                    {foreach from=$_product.product_options item="option"}
                                        <strong>{$option.option_name}</strong>
                                        :&nbsp;
                                        {if $option.option_type == "F"}
                                            {if $_product.extra.custom_files[$option.option_id]}
                                                {foreach from=$_product.extra.custom_files[$option.option_id] key="file_id" item="file" name="po_files"}
                                                    <a class="cm-no-ajax"
                                                       href="{"checkout.get_custom_file?cart_id=`$key_conf`&file=`$file_id`&option_id=`$option.option_id`"|fn_url}">{$file.name}</a>
                                                    {if !$smarty.foreach.po_files.last},&nbsp;{/if}
                                                {/foreach}
                                            {/if}
                                        {else}
                                            {$option.variants[$option.value].variant_name|default:$option.value}
                                        {/if}
                                        <input type="hidden" name="cart_products[{$key_conf}][product_options][{$option.option_id}]" value="{$option.value}">
                                        <br/>
                                    {/foreach}
                                {/if}
                            </td>
                            <td>
                                {include file="common/price.tpl" value=$_product.price}</td>
                            <td>
                                <input type="hidden" name="cart_products[{$key_conf}][product_id]"
                                       value="{$_product.product_id}"/>
                                {$_product.amount}
                            </td>
                            <td>
                                {include file="common/price.tpl" value=$_product.display_subtotal}</td>
                        </tr>
                    {/if}
                {/foreach}
            </table>
        </div>
    {/if}
{/if}

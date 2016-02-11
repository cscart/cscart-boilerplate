{if $cart.products.$key.extra.buy_together}
    {foreach from=$cart_products item="_product" key="key_conf"}
        {if $cart.products.$key_conf.extra.parent.buy_together == $key}
            {capture name="is_conf_prod"}1{/capture}
        {/if}
    {/foreach}
 
    {if $smarty.capture.is_conf_prod}
        <div class="discount-info buy-together-info">
            <span class="caret-info"><span class="caret-outer"></span><span class="caret-inner"></span></span>
            <h5 class="buy-together-info-product">{__("buy_together")}</h5>
            <ul class="list-unstyled buy-together-info-items">
            {foreach from=$cart_products item="_product" key="key_conf"}
                {if $cart.products.$key_conf.extra.parent.buy_together == $key}
                    <li>{$_product.product nofilter}</li>
                {/if}
            {/foreach}
            </ul>
        </div>
    {/if}
 {/if} 
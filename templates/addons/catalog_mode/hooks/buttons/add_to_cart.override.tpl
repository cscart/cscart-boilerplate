{if ''|fn_catalog_mode_enabled == 'Y'}
    {if $product.buy_now_url != ''}
        {include file="common/button.tpl" id=$but_id text=__("buy_now") href=$product.buy_now_url meta="btn-primary"}
    {elseif $addons.catalog_mode.add_to_cart_empty_buy_now_url != 'Y'}
		&nbsp;
    {/if}
{/if}

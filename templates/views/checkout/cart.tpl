{script src="js/tygh/exceptions.js"}
{script src="js/tygh/checkout.js"}

{if !$cart|fn_cart_is_empty}
    {include file="views/checkout/components/cart_content.tpl"}
{else}
    <p class="well well-lg no-items">{__("text_cart_empty")}</p>

    <div class="buttons-container wrap">
        {include file="common/button.tpl" href=$continue_url|fn_url text=__("continue_shopping")}
    </div>
{/if}
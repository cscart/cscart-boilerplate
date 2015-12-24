{if !$hide_form && $addons.call_requests.buy_now_with_one_click == "Y" && $show_add_to_cart == "Y"}

{$id = "call_request_{$obj_prefix}{$product.product_id}"}

<div class="hidden" id="content_{$id}" title="{__("call_requests.buy_now_with_one_click")}">
    {include file="addons/call_requests/views/call_requests/components/call_requests_content.tpl" product=$product id=$id}
</div>

{/if}

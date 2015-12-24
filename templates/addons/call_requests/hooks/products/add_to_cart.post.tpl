{if !$hide_form && $addons.call_requests.buy_now_with_one_click == "Y"}

{$id = "call_request_{$obj_prefix}{$product.product_id}"}

<a id="opener_{$id}" class="cm-dialog-opener cm-dialog-auto-size btn btn-default" data-ca-target-id="content_{$id}" rel="nofollow">{__("call_requests.buy_now_with_one_click")}</a>

{/if}

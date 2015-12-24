{** block-description:tmpl_call_request **}

<div class="cr-block">
    <div class="cr-phone">
        <span class="cr-phone-prefix">{$phone_number.prefix}</span>
        <span class="cr-phone-number"> {$phone_number.postfix}</span>
    </div>
    <div class="cr-link">
        {include file="addons/call_requests/views/call_requests/components/popup.tpl" product=false link_text=__("call_requests.request_call")}
    </div>
</div>
{include file="common/letter_header.tpl"}

{__("hello")},<br /><br />

{__("text_track_request")}<br /><br />

{if $o_id}
{__("text_track_view_order", ["[order]" => $o_id])}<br />
<a href="{"orders.track?ekey=`$access_key`&o_id=`$o_id`"|fn_url:'C':'http'}">{"orders.track?ekey=`$access_key`&o_id=`$o_id`"|fn_url:'C':'http'}</a><br />
<br />
{/if}

{__("text_track_view_all_orders")}<br />
<a href="{"orders.track?ekey=`$access_key`"|fn_url:'C':'http'}">{"orders.track?ekey=`$access_key`"|fn_url:'C':'http'}</a><br />

{include file="common/letter_footer.tpl"}
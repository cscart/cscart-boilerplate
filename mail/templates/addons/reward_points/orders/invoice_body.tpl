{*if $order_info.points_info.reward}
    <td align="right">{$oi.extra.points_info.reward|default:"-"}</td>
{/if*}

{if $order_info.points_info.price}
    <p>{__("price_in_points")}: {$oi.extra.points_info.price}</p>
{/if}
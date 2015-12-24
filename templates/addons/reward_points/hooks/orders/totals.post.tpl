{if $order_info.points_info.reward}
    <tr class="orders-summary__row">
        <td><strong>{__("points")}:&nbsp;</strong></td>
        <td>{__("points_lowercase", [$order_info.points_info.reward])}</td>
    </tr>
{/if}
{if $order_info.points_info.in_use}
    <tr class="orders-summary__row">
        <td><strong>{__("points_in_use")}</strong>&nbsp;({__("points_lowercase", [$order_info.points_info.in_use.points])})&nbsp;<strong>:</strong></td>
        <td>{include file="common/price.tpl" value=$order_info.points_info.in_use.cost}</td>
    </tr>
{/if}
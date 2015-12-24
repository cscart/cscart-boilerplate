{if  $order_info.points_info.reward}
    <tr>
        <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;"><b>{__("reward_points")}:&nbsp;</b></td>
        <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">{$order_info.points_info.reward}</td>
    </tr>
{/if}

{if $order_info.points_info.in_use}
    <tr>
        <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial; unicode-bidi: bidi-override;">
        	<b style="unicode-bidi: embed;">{__("points_in_use")}</b>&nbsp;<span style="unicode-bidi: embed;">({__("points_lowercase", [$order_info.points_info.in_use.points])})</span><b>:</b>&nbsp;</td>
        <td style="text-align: right; white-space: nowrap; font-size: 12px; font-family: Arial;">{include file="common/price.tpl" value=$order_info.points_info.in_use.cost}</td>
    </tr> 
{/if}
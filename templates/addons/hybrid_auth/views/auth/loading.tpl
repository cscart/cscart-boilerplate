<table width="100%" border="0">
	<tr>
		<td align="center" height="190px" valign="middle"><img src="{$images_dir}/addons/hybrid_auth/loading.gif" /></td>
	</tr>
	<tr>
		<td align="center"><br /><h3>{__("loading")}...</h3><br /></td> 
	</tr>
	<tr>
		<td align="center">
			{__("hybrid_auth.connecting_provider", ["[provider]" => $provider])}
		</td>
	</tr> 
</table>
<script data-no-defer>
	setTimeout(function(){$ldelim}
		window.location.href = window.location.href + "&redirect_to_idp=Y";
	{$rdelim}, 1000);
</script>
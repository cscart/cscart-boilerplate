{if $search && ($meta_description || $location_data.meta_description)}
<meta name="description" content="{$meta_description|html_entity_decode:$smarty.const.ENT_COMPAT:"UTF-8"|default:$location_data.meta_description}{$search|fn_get_seo_page_title}" />
{/if}
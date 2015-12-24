{if !$config.tweaks.disable_dhtml}
    {assign var="ajax_class" value="cm-ajax cm-ajax-full-render"}
{/if}

{if  !$hide_compare_list_button}
    {$c_url = $redirect_url|default:$config.current_url|escape:url}
    {include file="common/button.tpl" text=__("add_to_comparison_list") href="product_features.add_product?product_id=$product_id&redirect_url=$c_url" target_id="comparison_list,account_info*" meta="add-to-compare $ajax_class" rel="nofollow"}
{/if}

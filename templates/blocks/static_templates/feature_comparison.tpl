{** block-description:feature_comparison **}

{assign var="compared_products" value=""|fn_get_comparison_products}
{assign var="hide_wrapper" value=false scope="parent"}
<div id="comparison_list">
    {if $compared_products}
        {include file="blocks/list_templates/small_items.tpl"
        products=$compared_products
        show_name=true
        show_price=true
        }

        <div class="sidebox-actions clearfix">
            <div class="pull-left">
                {include file="common/button.tpl" text=__("compare") href="product_features.compare"}
            </div>

            <div class="pull-right">
                {if !$config.tweaks.disable_dhtml}
                    {assign var="ajax_class" value="cm-ajax"}
                {/if}

                {if $runtime.mode == "compare"}
                    {assign var="c_url" value=""|fn_url:"C":"rel"}
                    {include file="common/button.tpl" text=__("clear") href="product_features.clear_list?redirect_url=`$c_url`"}
                {else}
                    {assign var="c_url" value=$config.current_url|escape:url}
                    {include file="common/button.tpl" text=__("clear") href="product_features.clear_list?redirect_url=`$c_url`" target_id="comparison_list" meta=$ajax_class}
                {/if}
            </div>
        </div>
    {else}
        {assign var="hide_wrapper" value=true scope="parent"}
    {/if}
<!--comparison_list--></div>
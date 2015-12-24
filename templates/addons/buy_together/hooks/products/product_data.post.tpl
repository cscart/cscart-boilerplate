{if $bt_chain || $bt_id}
    <div class="cm-reload-{$obj_prefix}{$obj_id}" id="buy_together_options_update_{$bt_chain}_{$bt_id}">
        {assign var="product_options" value="product_options_`$obj_id`"}
        <input type="hidden" name="appearance[show_product_options]" value="1" />
        <input type="hidden" name="appearance[bt_chain]" value="{$bt_chain}" />
        <input type="hidden" name="appearance[bt_id]" value="{$bt_id}" />
        <input type="hidden" name="appearance[show_product_options]" value="{$show_product_options}" />
        {hook name="products:product_option_content"}
            {if $disable_ids}
                {assign var="_disable_ids" value="`$disable_ids``$obj_id`"}
            {else}
                {assign var="_disable_ids" value=""}
            {/if}
            {include file="views/products/components/product_options.tpl" id=$obj_id product_options=$product.product_options name="product_data" capture_options_vs_qty=$capture_options_vs_qty disable_ids=$_disable_ids extra_id=$obj_id}
        {/hook}
    <!--buy_together_options_update_{$bt_chain}_{$bt_id}--></div>
{/if}
{if $products}

{script src="js/tygh/exceptions.js"}

{if !$no_pagination}
    {include file="common/pagination.tpl"}
{/if}

{if !$no_sorting}
    {include file="views/products/components/sorting.tpl"}
{/if}

    {assign var="image_width" value=$image_width|default:60}
    {assign var="image_height" value=$image_height|default:60}

    <div class="compact-list">
        {foreach from=$products item="product" key="key" name="products"}
            {assign var="obj_id" value=$product.product_id}
            {assign var="obj_id_prefix" value="`$obj_prefix``$product.product_id`"}
            {include file="common/product_data.tpl" product=$product}
            {hook name="products:product_compact_list"}
                <div class="compact-list-item row">
                    <form {if !$config.tweaks.disable_dhtml}class="cm-ajax cm-ajax-full-render"{/if} action="{""|fn_url}" method="post" name="short_list_form{$obj_prefix}">
                        <input type="hidden" name="result_ids" value="cart_status*,wish_list*" />
                        <input type="hidden" name="redirect_url" value="{$config.current_url}" />
                        <div class="compact-list-content">
                            <div class="compact-list-image col-lg-1 col-md-1 col-sm-1">
                                <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">
                                    {include file="common/image.tpl" image_width=$image_width image_height=$image_height images=$product.main_pair obj_id=$obj_id_prefix}
                                </a>
                                {assign var="discount_label" value="discount_label_`$obj_prefix``$obj_id`"}
                                {$smarty.capture.$discount_label nofilter}
                            </div>
                            
                            <div class="compact-list-title col-lg-5 col-md-5 col-sm-5">
                                {assign var="name" value="name_$obj_id"}{$smarty.capture.$name nofilter}
                                {$sku = "sku_`$obj_id`"}
                                {$smarty.capture.$sku nofilter}
                            </div>

                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="row">
                                    <div class="compact-list-price col-lg-4 col-md-4 col-sm-4">
                                        {assign var="old_price" value="old_price_`$obj_id`"}
                                        {assign var="price" value="price_`$obj_id`"}

                                        {if $smarty.capture.$old_price|trim}
                                            {$smarty.capture.$old_price nofilter}
                                        {/if}
                                        {$smarty.capture.$price nofilter}
                                    </div>
                                    
                                    <div class="col-lg-3 col-md-3 col-sm-3 compact-list-control">
                                    {if !$smarty.capture.capt_options_vs_qty}
                                        {assign var="product_options" value="product_options_`$obj_id`"}
                                        {$smarty.capture.$product_options nofilter}

                                        {assign var="qty" value="qty_`$obj_id`"}
                                        {$smarty.capture.$qty nofilter}
                                    {/if}
                                    </div>

                                    <div class="col-lg-5 col-md-5 col-sm-5 compact-list-control text-right">
                                    {if $show_add_to_cart}
                                        {assign var="add_to_cart" value="add_to_cart_`$obj_id`"}
                                        {$smarty.capture.$add_to_cart nofilter}
                                    {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            {/hook}
        {/foreach}
    </div>
    
{if !$no_pagination}
    {include file="common/pagination.tpl" force_ajax=$force_ajax}
{/if}

{/if}
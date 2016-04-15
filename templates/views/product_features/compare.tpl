{if !$comparison_data}
    <p class="well well-lg no-items">{__("no_products_selected")}</p>
    <div class="buttons-container">
        {include file="common/button.tpl" href=$continue_url|fn_url text=__("continue_shopping")}
    </div>
{else}
    {script src="js/tygh/exceptions.js"}
    {assign var="return_current_url" value=$config.current_url|escape:url}
    <div class="compare">
        <div class="compare-wrapper">
            <table class="compare-products">
                <tr>
                    <td class="compare-menu">
                        <div class="list-group">
                            {if $action != "show_all"}
                                <a class="list-group-item" href="{"product_features.compare.show_all"|fn_url}">{__("all_features")}</a>
                            {else}
                                <a class="list-group-item active">{__("all_features")}</a>
                            {/if}
                            {if $action != "similar_only"}
                                <a class="list-group-item" href="{"product_features.compare.similar_only"|fn_url}">{__("similar_only")}</a>
                            {else}
                                <a class="list-group-item active">{__("similar_only")}</a>
                            {/if}
                            {if $action != "different_only"}
                                <a class="list-group-item" href="{"product_features.compare.different_only"|fn_url}">{__("different_only")}</a>
                            {else}
                                <a class="list-group-item active">{__("different_only")}</a>
                            {/if}
                        </div>
                    </td>
                    {foreach from=$comparison_data.products item=product}
                    <td class="compare-product">
                        <div class="thumbnail">
                            <div class="compare-products-item">
                                <div class="compare-products-delete text-center">
                                    <a href="{"product_features.delete_product?product_id=`$product.product_id`&redirect_url=`$return_current_url`"|fn_url}" title="{__("remove")}">
                                        <i class="glyphicon glyphicon-remove fa fa-times-circle"></i>
                                        <span>{__("remove")}</span>
                                    </a>
                                </div>
                                <div class="compare-products-img">
                                    <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">
                                        {include file="common/image.tpl" image_width=$settings.Thumbnails.product_lists_thumbnail_width image_height=$settings.Thumbnails.product_lists_thumbnail_height obj_id=$product.product_id images=$product.main_pair no_ids=true}
                                    </a>
                                </div>
                            </div>

                            <div class="compare-products-item">
                                <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">{$product.product nofilter}</a>
                            </div>

                            {assign var="obj_id" value=$product.product_id}
                            {include file="common/product_data.tpl" product=$product show_old_price=true show_price_values=true show_price=true show_clean_price=true}
                            <div class="compare-products-item">
                                {assign var="old_price" value="old_price_`$obj_id`"}
                                {if $smarty.capture.$old_price|trim}{$smarty.capture.$old_price nofilter}{/if}

                                {assign var="price" value="price_`$obj_id`"}
                                {$smarty.capture.$price nofilter}

                                {assign var="clean_price" value="clean_price_`$obj_id`"}
                                {$smarty.capture.$clean_price nofilter}
                            </div>

                            <div class="compare-products-item">
                                {include file="blocks/list_templates/simple_list.tpl" min_qty=true product=$product show_add_to_cart=true but_role="action" hide_price=true quantity_text=__('qty')}
                            </div>
                        </div>
                    </td>
                    {/foreach}
                </tr>
            </table>
    
            <div class="compare-feature">
                <table class="compare-feature-table table">
                {foreach from=$comparison_data.product_features item="group_features" key="group_id" name="feature_groups"}
                    {foreach from=$group_features item="_feature" key=id name="product_features"}
                        <tr>
                            <td class="compare-feature-item compare-sort">
                                <strong class="compare-sort-title">{$_feature}:</strong>
                                    <a href="{"product_features.delete_feature?feature_id=`$id`&redirect_url=`$return_current_url`"|fn_url}" class="glyphicon glyphicon-remove fa fa-times" title="{__("remove")}"></a>
                            </td>
                            {foreach from=$comparison_data.products item=product}
                                <td class="compare-feature-item compare-feature-item-size">

                                {if $product.product_features.$id}
                                    {assign var="feature" value=$product.product_features.$id}
                                {else}
                                    {assign var="feature" value=$product.product_features[$group_id].subfeatures.$id}
                                {/if}

                                {strip}
                                    {if $feature.prefix && $feature.feature_type != "ProductFeatures::MULTIPLE_CHECKBOX"|enum}{$feature.prefix}{/if}
                                    {if $feature.feature_type == "ProductFeatures::SINGLE_CHECKBOX"|enum}
                                        <span class="compare-checkbox" title="{$feature.value}">{if $feature.value == "Y"}<i class="glyphicon glyphicon-check fa fa-check-square-o"></i>{/if}</span>
                                    {elseif $feature.feature_type == "ProductFeatures::DATE"|enum}
                                        {$feature.value_int|date_format:"`$settings.Appearance.date_format`"}
                                    {elseif $feature.feature_type == "ProductFeatures::MULTIPLE_CHECKBOX"|enum && $feature.variants}
                                        <ul class="compare-list list-unstyled">
                                        {foreach from=$feature.variants item="var"}
                                        {if $var.selected}
                                        <li class="compare-list-item"><span class="compare-checkbox" title="{$var.variant}"><i class="glyphicon glyphicon-check fa fa-check-square-o"></i></span>&nbsp;{$feature.prefix}&nbsp;{$var.variant}&nbsp;{$feature.suffix}</li>
                                        {/if}
                                        {/foreach}
                                        </ul>
                                    {elseif $feature.feature_type == "ProductFeatures::TEXT_SELECTBOX"|enum || $feature.feature_type == "ProductFeatures::EXTENDED"|enum}
                                        {foreach from=$feature.variants item="var"}
                                            {if $var.selected}{$var.variant}{/if}
                                        {/foreach}
                                    {elseif $feature.feature_type == "ProductFeatures::NUMBER_SELECTBOX"|enum || $feature.feature_type == "ProductFeatures::NUMBER_FIELD"|enum}
                                        {$feature.value_int|floatval|default:"-"}
                                    {else}
                                        {$feature.value|default:"-"}
                                    {/if}
                                    {if $feature.suffix && $feature.feature_type != "ProductFeatures::MULTIPLE_CHECKBOX"|enum}{$feature.suffix}{/if}
                                {/strip}
                            {/foreach}
                        </tr>
                    {/foreach}
                {/foreach}
                </table>
            </div>
        </div>
    </div>
    <div class="panel panel-default buttons-container">
        <div class="panel-body">
            {assign var="r_url" value=""|fn_url}
            {include file="common/button.tpl" href=$continue_url|fn_url text=__("continue_shopping")}
            {include file="common/button.tpl" text=__("clear_list") href="product_features.clear_list?redirect_url=`$r_url`" meta="btn-default"}
        </div>
    </div>

    {if $comparison_data.hidden_features}
    <h3>{__("add_feature")}</h3>
    <form action="{""|fn_url}" method="post" name="add_feature_form">
        <input type="hidden" name="redirect_url" value="{$config.current_url}" />
        {html_checkboxes name="add_features" options=$comparison_data.hidden_features columns="4"}
        <div class="panel panel-default buttons-container">
            <div class="panel-body">
                {include file="common/button.tpl" text=__("add") name="dispatch[product_features.add_feature]"}
            </div>
        </div>
    </form>
    {/if}
{/if}

{capture name="mainbox_title"}{__("compare")}{/capture}
{if $product_features}
    <table class="table table-striped product-feature">
    {foreach from=$product_features item="feature"}
        {if $feature.feature_type != "ProductFeatures::GROUP"|enum}
            <tr>
                <td class="product-feature-label">
                    <span class="cursor-pointer">
                        {$feature.description nofilter}{if $feature.full_description|trim}
                            {include file="common/popupbox.tpl" act="notes" id="content_`$feature.feature_id`_notes" text=$feature.description  content=$feature.full_description link_text="<i class=\"glyphicon glyphicon-question-sign fa fa-question-circle\"></i>" show_brackets=false}{/if}:
                    </span>

                {if $feature.feature_type == "ProductFeatures::MULTIPLE_CHECKBOX"|enum}
                    {assign var="hide_affix" value=true}
                {else}
                    {assign var="hide_affix" value=false}
                {/if}
                </td>
            
                <td>
                {strip}
                <div class="product-feature-value">
                {if $feature.prefix && !$hide_affix}<span class="product-feature-prefix">{$feature.prefix}</span>{/if}
                    {if $feature.feature_type == "ProductFeatures::SINGLE_CHECKBOX"|enum}
                        <span class="compare-checkbox" title="{$feature.value}">{if $feature.value == "Y"}<i class="glyphicon glyphicon-check fa fa-check-square-o"></i>{/if}</span>
                    {elseif $feature.feature_type == "ProductFeatures::DATE"|enum}
                        {$feature.value_int|date_format:"`$settings.Appearance.date_format`"}
                    {elseif $feature.feature_type == "ProductFeatures::MULTIPLE_CHECKBOX"|enum && $feature.variants}
                        <ul class="product-feature-multiple list-unstyled">
                        {foreach from=$feature.variants item="var"}
                            {assign var="hide_variant_affix" value=!$hide_affix}
                            {if $var.selected}
                            <li class="product-feature-multiple-item">
                                <span class="compare-checkbox" title="{$var.variant}">
                                    <i class="glyphicon glyphicon-check fa fa-check-square-o"></i>
                                </span>
                                {if !$hide_variant_affix}
                                    <span class="product-feature-prefix">
                                        {$feature.prefix}
                                    </span>
                                {/if}
                                {$var.variant}
                                {if !$hide_variant_affix}
                                    <span class="product-feature-suffix">
                                        {$feature.suffix}
                                    </span>
                                {/if}
                            </li>
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
                    {if $feature.suffix && !$hide_affix}<span class="product-feature-suffix">{$feature.suffix}</span>{/if}
                </div>
                {/strip}
                </td>
            </tr>
        {/if}
    {/foreach}
    </table>
{/if}

{foreach from=$product_features item="feature"}
    {if $feature.feature_type == "ProductFeatures::GROUP"|enum && $feature.subfeatures}
        <div class="product-feature-group">
        <p>
            <strong> {$feature.description}</strong>
            <span class="cm-tooltip" title="{$feature.full_description}">
                <i class="glyphicon glyphicon-question-sign fa fa-question-circle"></i>
            </span>
        </p>
        {include file="views/products/components/product_features.tpl" product_features=$feature.subfeatures}
        </div>
    {/if}
{/foreach}
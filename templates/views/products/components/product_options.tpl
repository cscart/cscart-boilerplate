{if ($settings.General.display_options_modifiers == "Y" && ($auth.user_id  || ($settings.General.allow_anonymous_shopping != "hide_price_and_add_to_cart" && !$auth.user_id)))}
{assign var="show_modifiers" value=true}
{/if}

<input type="hidden" name="appearance[details_page]" value="{$details_page}" />
{foreach from=$product.detailed_params key="param" item="value"}
    <input type="hidden" name="additional_info[{$param}]" value="{$value}" />
{/foreach}

{if $product_options}

{if $obj_prefix}
    <input type="hidden" name="appearance[obj_prefix]" value="{$obj_prefix}" />
{/if}

{if $location == "cart" || $product.object_id}
    <input type="hidden" name="{$name}[{$id}][object_id]" value="{$id|default:$obj_id}" />
{/if}

{if $extra_id}
    <input type="hidden" name="extra_id" value="{$extra_id}" />
{/if}

{* Simultaneous options *}
{if $product.options_type == "S" && $location == "cart"}
    {$disabled = true}
{/if}

<div class="row" id="option_{$id}_AOC">
    <div class="cm-picker-product-options product-options" id="opt_{$obj_prefix}{$id}">
        {foreach name="product_options" from=$product_options item="po"}
        {assign var="selected_variant" value=""}
        <div class="form-group product-options-item{if !$capture_options_vs_qty} product-list-field{/if} clearfix" id="opt_{$obj_prefix}{$id}_{$po.option_id}">
            {if !("SRC"|strpos:$po.option_type !== false && !$po.variants && $po.missing_variants_handling == "H")}
                <label id="option_description_{$id}_{$po.option_id}" {if $po.option_type !== "F"}for="option_{$obj_prefix}{$id}_{$po.option_id}"{/if} class="col-lg-3 col-md-3 col-sm-3 control-label {if $po.required == "Y"} cm-required{/if}{if $po.regexp} cm-regexp{/if}" {if $po.regexp}data-ca-regexp="{$po.regexp}" data-ca-message="{$po.incorrect_message}"{/if}>{$po.option_name}{if $po.description|trim} <span class="cm-tooltip" title="{$po.description}"><i class="glyphicon glyphicon-question-sign fa fa-question-circle"></i></span>{/if}:</label>
                <div class="col-lg-7 col-md-7 col-sm-7">
            {if $po.option_type == "S"} {*Selectbox*}
                {if $po.variants}
                    {if ($po.disabled || $disabled) && !$po.not_required}<input type="hidden" value="{$po.value}" name="{$name}[{$id}][product_options][{$po.option_id}]" id="option_{$obj_prefix}{$id}_{$po.option_id}" />{/if}
                    <select class="form-control" name="{$name}[{$id}][product_options][{$po.option_id}]" {if !$po.disabled && !$disabled}id="option_{$obj_prefix}{$id}_{$po.option_id}"{/if} onchange="{if $product.options_update}fn_change_options('{$obj_prefix}{$id}', '{$id}', '{$po.option_id}');{else} fn_change_variant_image('{$obj_prefix}{$id}', '{$po.option_id}');{/if}" {if $product.exclude_from_calculate && !$product.aoc || $po.disabled || $disabled}disabled="disabled" class="disabled"{/if}>
                        {if $product.options_type == "S"}
                            {if !$runtime.checkout || $po.disabled || $disabled || ($runtime.checkout && !$po.value)}
                                <option value="">{if $po.disabled || $disabled}{__("select_option_above")}{else}{__("please_select_one")}{/if}</option>
                            {/if}
                        {/if}
                        {foreach from=$po.variants item="vr" name=vars}
                            {if !($po.disabled || $disabled) || (($po.disabled || $disabled) && $po.value && $po.value == $vr.variant_id)}
                                {capture name="modifier"}
                                    {include file="common/modifier.tpl" mod_type=$vr.modifier_type mod_value=$vr.modifier display_sign=true}
                                {/capture}
                                <option value="{$vr.variant_id}" {if $po.value == $vr.variant_id}{assign var="selected_variant" value=$vr.variant_id}selected="selected"{/if}>{$vr.variant_name} {if $show_modifiers}{hook name="products:options_modifiers"}{if $vr.modifier|floatval}({$smarty.capture.modifier|strip_tags|replace:' ':'' nofilter}){/if}{/hook}{/if}</option>
                            {/if}
                        {/foreach}
                    </select>
                {else}
                    <input type="hidden" name="{$name}[{$id}][product_options][{$po.option_id}]" value="{$po.value}" id="option_{$obj_prefix}{$id}_{$po.option_id}" />
                    <span>{__("na")}</span>
                {/if}
            {elseif $po.option_type == "R"} {*Radiobutton*}
                {if $po.variants}
                        <input type="hidden" name="{$name}[{$id}][product_options][{$po.option_id}]" value="{$po.value}" id="option_{$obj_prefix}{$id}_{$po.option_id}" />
                        <ul id="option_{$obj_prefix}{$id}_{$po.option_id}_group" class="product-options-elem">
                            {if !$po.disabled && !$disabled}
                                {foreach from=$po.variants item="vr" name="vars"}
                                    <li class="radio">
                                        <label id="option_description_{$id}_{$po.option_id}_{$vr.variant_id}" class="product-options-box option-items control-label">
                                            <input type="radio" class="radio" name="{$name}[{$id}][product_options][{$po.option_id}]" value="{$vr.variant_id}" {if $po.value == $vr.variant_id }{assign var="selected_variant" value=$vr.variant_id}checked="checked"{/if} onclick="{if $product.options_update}fn_change_options('{$obj_prefix}{$id}', '{$id}', '{$po.option_id}');{else} fn_change_variant_image('{$obj_prefix}{$id}', '{$po.option_id}', '{$vr.variant_id}');{/if}" {if $product.exclude_from_calculate && !$product.aoc || $po.disabled || $disabled}disabled="disabled"{/if} />
                                        {$vr.variant_name}&nbsp;{if  $show_modifiers}{hook name="products:options_modifiers"}{if $vr.modifier|floatval}({include file="common/modifier.tpl" mod_type=$vr.modifier_type mod_value=$vr.modifier display_sign=true}){/if}{/hook}{/if}</label></li>
                                {/foreach}
                            {elseif $po.value}
                                {$po.variants[$po.value].variant_name}
                            {/if}
                        </ul>
                        {if !$po.value && $product.options_type == "S" && !($po.disabled || $disabled)}<p class="product-options-description">{__("please_select_one")}</p>{elseif !$po.value && $product.options_type == "S" && ($po.disabled || $disabled)}<p class="product-options-description">{__("select_option_above")}</p>{/if}
                {else}
                    <input type="hidden" name="{$name}[{$id}][product_options][{$po.option_id}]" value="{$po.value}" id="option_{$obj_prefix}{$id}_{$po.option_id}" />
                    <span>{__("na")}</span>
                {/if}

            {elseif $po.option_type == "C"} {*Checkbox*}
                {foreach from=$po.variants item="vr"}
                {if $vr.position == 0}
                    <input id="unchecked_option_{$obj_prefix}{$id}_{$po.option_id}" type="hidden" name="{$name}[{$id}][product_options][{$po.option_id}]" value="{$vr.variant_id}" {if $po.disabled || $disabled}disabled="disabled"{/if} />
                {else}
                    <label class="cm-field-container">
                        <input id="option_{$obj_prefix}{$id}_{$po.option_id}" type="checkbox" name="{$name}[{$id}][product_options][{$po.option_id}]" value="{$vr.variant_id}" class="checkbox" {if $po.value == $vr.variant_id}checked="checked"{/if} {if $product.exclude_from_calculate && !$product.aoc || $po.disabled || $disabled}disabled="disabled"{/if} {if $product.options_update}onclick="fn_change_options('{$obj_prefix}{$id}', '{$id}', '{$po.option_id}');"{/if}/>
                        {if $show_modifiers}{hook name="products:options_modifiers"}{if $vr.modifier|floatval}({include file="common/modifier.tpl" mod_type=$vr.modifier_type mod_value=$vr.modifier display_sign=true}){/if}{/hook}{/if}
                    </label>
                {/if}
                {foreachelse}
                    <label class="product-options option-items"><input type="checkbox" class="checkbox" disabled="disabled" />
                    {if $show_modifiers}{hook name="products:options_modifiers"}{if $vr.modifier|floatval}({include file="common/modifier.tpl" mod_type=$vr.modifier_type mod_value=$vr.modifier display_sign=true}){/if}{/hook}{/if}</label>
                {/foreach}

            {elseif $po.option_type == "I"} {*Input*}
                <input id="option_{$obj_prefix}{$id}_{$po.option_id}" type="text" name="{$name}[{$id}][product_options][{$po.option_id}]" value="{$po.value|default:$po.inner_hint}" {if $product.exclude_from_calculate && !$product.aoc}disabled="disabled"{/if} class="form-control {if $po.inner_hint} cm-hint{/if}{if $product.exclude_from_calculate && !$product.aoc} disabled{/if}" {if $po.inner_hint}title="{$po.inner_hint}"{/if} />
            {elseif $po.option_type == "T"} {*Textarea*}
                <textarea id="option_{$obj_prefix}{$id}_{$po.option_id}" class="form-control {if $po.inner_hint} cm-hint{/if}{if $product.exclude_from_calculate && !$product.aoc} disabled{/if}" rows="3" name="{$name}[{$id}][product_options][{$po.option_id}]" {if $product.exclude_from_calculate && !$product.aoc}disabled="disabled"{/if} {if $po.inner_hint}title="{$po.inner_hint}"{/if} >{$po.value|default:$po.inner_hint}</textarea>
            {elseif $po.option_type == "F"} {*File*}
                {include file="common/fileuploader.tpl" images=$product.extra.custom_files[$po.option_id] var_name="`$name`[`$po.option_id``$id`]" multiupload=$po.multiupload hidden_name="`$name`[custom_files][`$po.option_id``$id`]" hidden_value="`$id`_`$po.option_id`" label_id="option_`$obj_prefix``$id`_`$po.option_id`" prefix=$obj_prefix}
            {/if}
            {/if}

            {if $po.comment}
                <div class="product-options-description text-muted">{$po.comment}</div>
            {/if}

            {capture name="variant_images"}
                {if !$po.disabled && !$disabled}
                    {foreach from=$po.variants item="var"}
                        {if $var.image_pair.image_id}
                            <a class="thumbnail product-variant-image {if $var.variant_id == $selected_variant}active{/if}">
                            {include file="common/image.tpl" class="product-options-image" images=$var.image_pair image_width="50" image_height="50" obj_id="variant_image_`$obj_prefix``$id`_`$po.option_id`_`$var.variant_id`" image_onclick="fn_set_option_value('`$obj_prefix``$id`', '`$po.option_id`', '`$var.variant_id`'); void(0);"}
                            </a>
                        {/if}
                    {/foreach}
                {/if}
            {/capture}
            {if $smarty.capture.variant_images|trim}
                <div class="row">
                    <div class="col-lg-7">
                        {$smarty.capture.variant_images nofilter}
                    </div>
                </div>
            {/if}
            </div>
        </div>
        {/foreach}
    </div>
</div>
{if $product.show_exception_warning == "Y"}
    <p id="warning_{$obj_prefix}{$id}" class="product-options-no-combinations">{__("nocombination")}</p>
{/if}
{/if}

{if !$no_script}
<script type="text/javascript">
(function(_, $) {
    $.ceEvent('on', 'ce.formpre_{$form_name|default:"product_form_`$obj_prefix``$id`"}', function(frm, elm) {
        if ($('#warning_{$obj_prefix}{$id}').length) {
            $.ceNotification('show', {
                type: 'W', 
                title: _.tr('warning'), 
                message: _.tr('cannot_buy'),
            });

            return false;
        }
            
        return true;
    });
}(Tygh, Tygh.$));
</script>
{/if}

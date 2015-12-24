{if $product_options}
    {foreach from=$product_options item=po}
        {if $po.value}
            {assign var="has_option" value=true}
            {break}
        {/if}
    {/foreach}

    {if $has_option}
        {if !$no_block}
        <div class="product-options-info">
            <label>{__("options")}:</label>
        {/if}
            {strip}
            {foreach from=$product_options item=po name=po_opt}
                {if ($po.option_type == "S" || $po.option_type == "R") && !$po.value}
                    {continue}
                {/if}

                {if $po.variants}
                    {assign var="var" value=$po.variants[$po.value]}
                {else}
                    {assign var="var" value=$po}
                {/if}

                {capture name="options_content"}
                    {if !$product.extra.custom_files[$po.option_id]}
                        {$var.variant_name|default:$var.value}
                    {/if}

                    {if $product.extra.custom_files[$po.option_id]}
                        {foreach from=$product.extra.custom_files[$po.option_id] item="file" name="po_files"}
                            {assign var="filename" value=$file.name|escape:url}
                            <a class="cm-no-ajax" href="{"orders.get_custom_file?order_id=`$order_info.order_id`&file=`$file.file`&filename=`$filename`"|fn_url}" title="{$file.name}">{$file.name|truncate:"40"}</a>
                            {if !$smarty.foreach.po_files.last}, {/if}
                        {/foreach}
                    {/if}

                    {if $settings.General.display_options_modifiers == "Y"}
                        {if $var.modifier|floatval}
                            &nbsp;({include file="common/modifier.tpl" mod_type=$var.modifier_type mod_value=$var.modifier display_sign=true})
                        {/if}
                    {/if}
                {/capture}

                {if $smarty.capture.options_content|trim and $smarty.capture.options_content|trim != '&nbsp;'}
                    <div class="product-option">
                        <span class="product-options-name">{$po.option_name}:&nbsp;</span>
                        <span class="product-options-content">
                            {$smarty.capture.options_content nofilter}{if $inline_option};{/if}&nbsp;
                        </span>
                    </div>
                {/if}
                {if $fields_prefix}<input type="hidden" name="{$fields_prefix}[{$po.option_id}]" value="{$po.value}" />{/if}
            {/foreach}
            {/strip}
        {if !$no_block}
        </div>
        {/if}
    {/if}
{/if}
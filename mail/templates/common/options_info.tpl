{if $product_options}
    {foreach from=$product_options item=po}
        {if $po.value}
            {assign var="has_option" value=true}
            {break}
        {/if}
    {/foreach}

    {if $has_option}
        <strong>{__("options")}:</strong>
        {foreach from=$product_options item=po name=po_opt}
            {if ($po.option_type == "S" || $po.option_type == "R") && !$po.value}
                {continue}
            {/if}

            {capture name="options_content_print"}
                {strip}
                {$po.variant_name}
                {if $oi.extra.custom_files[$po.option_id]}
                    {foreach from=$oi.extra.custom_files[$po.option_id] item="file" name="po_files"}
                        {$file.name}
                        {if !$smarty.foreach.po_files.last},&nbsp;{/if}
                    {/foreach}
                {/if}

                {if $settings.General.display_options_modifiers == "Y"}
                    {if !$skip_modifiers && $po.modifier|floatval}
                        &nbsp;({include file="common/modifier.tpl" mod_type=$po.modifier_type mod_value=$po.modifier display_sign=true})
                    {/if}
                {/if}
                {/strip}
            {/capture}

            {if $smarty.capture.options_content_print|trim and $smarty.capture.options_content_print|trim != '&nbsp;'}
                {if $option_displayed},&nbsp;{/if}
                {$po.option_name}:&nbsp;
                {$smarty.capture.options_content_print nofilter}
                {$option_displayed = true}
            {/if}
        {/foreach}
    {/if}
{else}
    &nbsp;
{/if}
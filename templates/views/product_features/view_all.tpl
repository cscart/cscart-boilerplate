{if $variants}
{$size = 4}
{split data=$variants size=$size assign="splitted_filter" preverse_keys=true}

<div class="features-all">
{foreach from=$splitted_filter item="group"}
    {foreach from=$group item="ranges" key="index"}
    {strip}
    <div class="features-all-group">
            {if $ranges}
                <h3>{$index}</h3>
                <ul class="features-all-list">
                {foreach from=$ranges item="range"}
                    <li class="features-all-list-item"><a href="{"product_features.view?variant_id=`$range.variant_id`"|fn_url}" class="features-all-list-a">{$range.variant|fn_text_placeholders}</a></li>
                {/foreach}
            </ul>
            {else}&nbsp;{/if}
    </div>
    {strip}
    {/foreach}
{/foreach}
</div>
{/if}
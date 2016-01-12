{if $variants}
{$size = 6}
{split data=$variants size=$size assign="splitted_filter" preverse_keys=true}

<div class="features-all">
{foreach from=$splitted_filter item="group"}
    <div class="row">
        {foreach from=$group item="ranges" key="index"}
        {strip}
        <div class="features-all-group col-lg-2 col-md-2 col-sm-2">
            {if $ranges}
                <h3>{$index}</h3>
                <ul class="list-unstyled features-all-list">
                {foreach from=$ranges item="range"}
                    <li class="features-all-list-item">
                        <a href="{"product_features.view?variant_id=`$range.variant_id`"|fn_url}" class="features-all-list-a">{$range.variant|fn_text_placeholders}</a>
                    </li>
                {/foreach}
                </ul>
            {/if}
        </div>
        {strip}
        {/foreach}
    </div>
{/foreach}
</div>
{/if}
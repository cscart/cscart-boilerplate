<div id="breadcrumbs_{$block.block_id}">
{if $breadcrumbs && $breadcrumbs|@sizeof > 1}
    <ol class="breadcrumb">
        {strip}
            {foreach from=$breadcrumbs item="bc" name="bcn" key="key"}
                {if $bc.link}
                    <li><a href="{$bc.link|fn_url}" class="{if $additional_class} {$additional_class}{/if}"{if $bc.nofollow} rel="nofollow"{/if}>{$bc.title|strip_tags|escape:"html" nofilter}</a></li>
                {else}
                    <li class="active">{$bc.title|strip_tags|escape:"html" nofilter}</li>
                {/if}
            {/foreach}
        {/strip}
    </ol>
    {include file="common/view_tools.tpl"}
{/if}
<!--breadcrumbs_{$block.block_id}--></div>

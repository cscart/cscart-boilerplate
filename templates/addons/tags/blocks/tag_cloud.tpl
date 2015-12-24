{** block-description:tag_cloud **}

{if $items}
<div class="tag-cloud">
    {foreach from=$items item="tag"}
        {$tag_name = $tag.tag|escape:url}
        <a href="{"tags.view?tag=`$tag_name`"|fn_url}" class="tag-cloud-item tag-level-{$tag.level}">{$tag.tag}</a>
    {/foreach}
</div>
{/if}
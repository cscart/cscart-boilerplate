{if $addons.tags.tags_for_pages == "Y"}
    {include file="addons/tags/views/tags/components/tags.tpl" object_type="A" object_id=$page.page_id object=$page}
{/if}
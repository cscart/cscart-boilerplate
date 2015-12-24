{if $object.tags}
<div id="content_tags_tab">
    <div class="form-group">
        <ul class="tags-list list-inline">
            {foreach from=$object.tags item="tag" name="tags"}
                {$tag_name = $tag.tag|escape:url}
                <li>
                    <a href="{"tags.view?tag=`$tag_name`"|fn_url}" class="badge badge-tag">
                        {$tag.tag}
                    </a>
                </li>
            {/foreach}
        </ul>
    </div>  
</div>
{/if}
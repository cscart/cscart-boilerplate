{** block-description:attachments **}

{if $attachments_data}
    <div class="attachments" id="content_attachments">
    {foreach from=$attachments_data item="file"}
        <p>
        {$file.description} ({$file.filename}, {$file.filesize|formatfilesize nofilter}) [<a class="cm-no-ajax" href="{"attachments.getfile?attachment_id=`$file.attachment_id`"|fn_url}">{__("download")}</a>]
        </p>
    {/foreach}
    </div>
{/if}
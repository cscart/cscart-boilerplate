{if $files}
<table class="table">
<thead>
    <tr>
        <th>{__("filename")}</th>
        <th>{__("filesize")}</th>
    </tr>
</thead>
{foreach from=$files item="file"}
<tr>
    <td style="width: 80%">
        <a class="cm-no-ajax" href="{"orders.get_file?file_id=`$file.file_id`&preview=Y"|fn_url}">
            <strong>{$file.file_name}</strong>
        </a>
        {if $file.readme || $file.license}
        <ul class="list-unstyled">
        {if $file.license}
            <li>
                <a class="cm-combination cursor-pointer" id="sw_license_{$file.file_id}">
                    <u>{__("licence_agreement")}</u>
                </a>
                <div class="hidden" id="license_{$file.file_id}">{$file.license nofilter}</div>
            </li>
        {/if}
        {if $file.readme}
            <li>
                <a class="cm-combination cursor-pointer" id="sw_readme_{$file.file_id}">
                    <u>{__("readme")}</u>
                </a>
                <div class="hidden" id="readme_{$file.file_id}">{$file.readme nofilter}</div>
            </li>
        {/if}
        </ul>
        {/if}
    </td>
    <td class="valign-top ">
        <strong>{$file.file_size|formatfilesize nofilter}</strong>
    </td>
{/foreach}
</table>
{/if}
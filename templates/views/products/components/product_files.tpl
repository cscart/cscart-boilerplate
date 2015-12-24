{if $files}
<table class="table">
<tr>
    <th>{__("filename")}</th>
    <th>{__("filesize")}</th>
</tr>
{foreach from=$files item="file"}
<tr>
    <td style="width: 80%">
        <a class="cm-no-ajax" href="{"orders.get_file?file_id=`$file.file_id`&preview=Y"|fn_url}"><strong>{$file.file_name}</strong></a>
        {if $file.readme || $file.license}
        <ul>
        {if $file.license}
            <li><a onclick="Tygh.$('#license_{$file.file_id}').toggle(); return false;">{__("licence_agreement")}</a></li>
            <div class="hidden" id="license_{$file.file_id}">{$file.license nofilter}</div>
        {/if}
        {if $file.readme}
            <li><a onclick="Tygh.$('#readme_{$file.file_id}').toggle(); return false;">{__("readme")}</a></li>
            <div class="hidden" id="readme_{$file.file_id}">{$file.readme nofilter}</div>
        {/if}
        </ul>
        {/if}
    </td>
    <td class="valign-top">
         <strong>{$file.file_size|formatfilesize nofilter}</strong>
    </td>
{/foreach}
</table>
{/if}
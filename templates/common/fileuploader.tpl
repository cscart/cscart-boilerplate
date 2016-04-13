{script src="design/themes/`$runtime.layout.theme_name`/js/fileuploader_scripts.js"}
{script src="js/tygh/node_cloning.js"}

{assign var="id_var_name" value="`$prefix`{$var_name|md5}"}

<div class="fileuploader cm-field-container">
    <input type="hidden" id="{$label_id}" value="{if $images}{$id_var_name}{/if}" />

    {foreach from=$images key="image_id" item="image"}
        <div class="fileuploader-file-section cm-uploaded-image" id="message_{$id_var_name}_{$image.file}" title="">
            <p class="cm-fu-file">
                {hook name="fileuploader:links"}
                    {if $image.location == "cart"}
                        {assign var="delete_link" value="checkout.delete_file?cart_id=`$id`&option_id=`$po.option_id`&file=`$image_id`&redirect_mode=cart"}
                        {assign var="download_link" value="checkout.get_custom_file?cart_id=`$id`&option_id=`$po.option_id`&file=`$image_id`"}
                    {/if}
                {/hook}
                {if $image.is_image}
                    <a href="{$image.detailed|fn_url}"><img src="{$image.thumbnail|fn_url}" /></a><br />
                {/if}

                {hook name="fileuploader:uploaded_files"}
                    {if $delete_link}
                        <a class="cm-ajax" href="{$delete_link|fn_url}">
                    {/if}
                    {if !($po.required == "Y" && $images|count == 1)}
                        <i id="clean_selection_{$id_var_name}_{$image.file}" title="{__("remove_this_item")}" onclick="Tygh.fileuploader.clean_selection(this.id); {if $multiupload != "Y"}Tygh.fileuploader.toggle_links('{$id_var_name}', 'show');{/if} Tygh.fileuploader.check_required_field('{$id_var_name}', '{$label_id}');" class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                    {/if}
                    {if $delete_link}
                        </a>
                    {/if}
                    <span class="fileuploader-filename">
                        {if $download_link}
                            <a class="cm-no-ajax" href="{$download_link|fn_url}">
                        {/if}
                        {$image.name}
                        {if $download_link}
                            </a>
                        {/if}
                    </span>
                {/hook}
            </p>
        </div>
    {/foreach}

    {hook name="fileuploader:uploader"}
    <div class="cleafix" id="file_uploader_{$id_var_name}">
        <div class="fileuploader-file-section" id="message_{$id_var_name}" title="">
            <p class="cm-fu-file hidden">
                <i id="clean_selection_{$id_var_name}" title="{__("remove_this_item")}" onclick="Tygh.fileuploader.clean_selection(this.id); {if $multiupload != "Y"}Tygh.fileuploader.toggle_links(this.id, 'show');{/if} Tygh.fileuploader.check_required_field('{$id_var_name}', '{$label_id}');" class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                    <span class="fileuploader-filename"></span>
            </p>
        </div>

        {strip}
        <div class="fileuploader-file-link {if $multiupload != "Y" && $images}hidden{/if}" id="link_container_{$id_var_name}">
            <input type="hidden" name="file_{$var_name}" value="{if $image_name}{$image_name}{/if}" id="file_{$id_var_name}" />
            <input type="hidden" name="type_{$var_name}" value="{if $image_name}local{/if}" id="type_{$id_var_name}" />
            <div class="fileuploader-file-local">
                <input type="file"  class="fileuploader-file-input" name="file_{$var_name}" id="local_{$id_var_name}" onchange="Tygh.fileuploader.show_loader(this.id); {if $multiupload == "Y"}Tygh.fileuploader.check_image(this.id);{else}Tygh.fileuploader.toggle_links(this.id, 'hide');{/if} Tygh.fileuploader.check_required_field('{$id_var_name}', '{$label_id}');" data-ca-empty-file="" onclick="Tygh.$(this).removeAttr('data-ca-empty-file');" multiple>
                <a data-ca-multi="Y" {if !$images}class="hidden-simple"{/if}>{$upload_another_file_text|default:__("upload_another_file")}</a><a data-ca-target-id="local_{$id_var_name}" data-ca-multi="N" class="btn btn-default fileuploader-a{if $images} hidden{/if}"> <i class="glyphicon glyphicon-upload fa fa-upload"></i> {$upload_file_text|default:__("upload_file")}</a>
            </div>
            {if $allow_url_uploading}
                &nbsp;{__("or")}&nbsp;
                <a onclick="Tygh.fileuploader.show_loader(this.id); {if $multiupload == "Y"}Tygh.fileuploader.check_image(this.id);{else}Tygh.fileuploader.toggle_links(this.id, 'hide');{/if} Tygh.fileuploader.check_required_field('{$id_var_name}', '{$label_id}');" id="url_{$id_var_name}">{__("specify_url")}</a>
            {/if}
            {if $hidden_name}
                <input type="hidden" name="{$hidden_name}" value="{$hidden_value}">
            {/if}
        </div>
        {/strip}
    </div>
    {/hook}

</div><!--fileuploader-->
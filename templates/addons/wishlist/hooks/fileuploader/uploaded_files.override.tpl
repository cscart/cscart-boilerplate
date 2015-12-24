{if $image.location == "wishlist"}
    <input type="hidden" name="{$name}[custom_files][uploaded][{$image.file}][product_id]" value="{$id}" />
    <input type="hidden" name="{$name}[custom_files][uploaded][{$image.file}][option_id]" value="{$po.option_id}" />
    <input type="hidden" name="{$name}[custom_files][uploaded][{$image.file}][name]" value="{$image.name}" />
    <input type="hidden" name="{$name}[custom_files][uploaded][{$image.file}][path]" value="{$image.file}" />
    
    {assign var="delete_link" value="wishlist.delete_file?cart_id=`$id`&option_id=`$po.option_id`&file=`$image_id`&redirect_mode=cart"}
    {if $delete_link}<a class="cm-ajax" href="{$delete_link|fn_url}">{/if}{if !($po.required == "Y" && $images|count == 1)}<i id="clean_selection_{$id_var_name}_{$image.file}" title="{__("remove_this_item")}" onclick="Tygh.fileuploader.clean_selection(this.id); {if $multiupload != "Y"}Tygh.fileuploader.toggle_links('{$id_var_name}', 'show');{/if} Tygh.fileuploader.check_required_field('{$id_var_name}', '{$label_id}');" class="icon-cancel-circle hand"></i>{/if}{if $delete_link}</a>{/if}<span>{if $download_link}<a href="{$download_link}">{/if}{$image.name}{if $download_link}</a>{/if}</span>
{/if}
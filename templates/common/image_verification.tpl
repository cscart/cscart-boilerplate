{if $option|fn_needs_image_verification == true}
    {assign var="is" value=$settings.Image_verification}
    
    {assign var="id" value="iv_"|uniqid}
    <div class="captcha form-group">
        <label for="verification_answer_{$id}" class="cm-required control-label">{__("image_verification_label")}</label>
        <p class="captcha-code">
            <img id="verification_image_{$id}" src="{"image.captcha?verification_id=$id&no_session=Y&$id"|fn_url}" alt="" onclick="this.src += '|1' ;"  width="{$is.width}" height="{$is.height}" class="cursor-pointer" />
            <i class="glyphicon glyphicon-refresh fa fa-refresh cursor-pointer" onclick="document.getElementById('verification_image_{$id}').src += '|1';"></i>
        </p>
        <input class="form-control cm-autocomplete-off" type="text" id="verification_answer_{$id}" name="verification_answer" value= "" />
        <input type="hidden" name="verification_id" value= "{$id}" />
        <div class="cm-field-container"></div>
        <span id="helpBlock" class="help-block {if $align}{$align}{/if}">{__("image_verification_body")}</span>
    </div>
{/if}

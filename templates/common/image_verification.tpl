{if $option|fn_needs_image_verification == true}
    {assign var="is" value=$settings.Image_verification}
    
    {assign var="id" value="iv_"|uniqid}
    <div class="captcha form-group">
        <label for="verification_answer_{$id}" class="cm-required control-label">{__("image_verification_label")}</label>
        <div class="row">
            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
                <input class="form-control cm-autocomplete-off" type="text" id="verification_answer_{$id}" name="verification_answer" value= "" />
                <input type="hidden" name="verification_id" value= "{$id}" />
                <div class="cm-field-container"></div>
            </div>
        
            <div class="captcha-code col-lg-4 col-md-4 col-sm-4 col-xs-4">
                <img id="verification_image_{$id}" src="{"image.captcha?verification_id=$id&no_session=Y&$id"|fn_url}" alt="" onclick="this.src += '|1' ;"  width="{$is.width}" height="{$is.height}" />
                <i class="glyphicon glyphicon-refresh fa fa-refresh" onclick="document.getElementById('verification_image_{$id}').src += '|1';"></i>
            </div>
        </div>
        <div {if $align} class="{$align}"{/if}>{__("image_verification_body")}</div>
    </div>
{/if}

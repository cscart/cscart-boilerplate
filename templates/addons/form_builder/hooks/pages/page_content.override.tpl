{if $page.page_type == $smarty.const.PAGE_TYPE_FORM}
    {if $smarty.request.sent == "Y"}

        {hook name="pages:form_sent"}
        {assign var="form_submit_const" value=$smarty.const.FORM_SUBMIT}
        <p>{$page.form.general.$form_submit_const nofilter}</p>
        {/hook}

        <div class="buttons-container panel panel-default">
            <div class="panel-body">
                {include file="common/button.tpl" text=__("continue") meta="btn-default" href=$continue_url|fn_url}
            </div>
        </div>
    {else}

    {if $page.description}
        <blockquote class="form-builder-description">
            {$page.description nofilter}
        </blockquote>
    {/if}

<div class="form-builder row">
    <div class="col-lg-6">
    <form action="{""|fn_url}" method="post" name="forms_form" enctype="multipart/form-data">
    <input type="hidden" name="fake" value="1" />
    <input type="hidden" name="page_id" value="{$page.page_id}" />

    {foreach from=$page.form.elements key="element_id" item="element" name="form_lements"}

    {if $element.element_type == $smarty.const.FORM_SEPARATOR}
        <hr class="form-builder-separator" />
    {elseif $element.element_type == $smarty.const.FORM_HEADER}

    {include file="common/subheader.tpl" title=$element.description}
    
    {elseif $element.element_type != $smarty.const.FORM_IP_ADDRESS && $element.element_type != $smarty.const.FORM_REFERER}
        <div class="form-group">
            <label for="{if $element.element_type == $smarty.const.FORM_FILE}type_{"fb_files[`$element.element_id`]"|md5}{else}elm_{$element.element_id}{/if}" class="control-label {if $element.required == "Y"}cm-required{/if}{if $element.element_type == $smarty.const.FORM_EMAIL} cm-email{/if}{if $element.element_type == $smarty.const.FORM_PHONE} cm-phone{/if} {if $element.element_type == $smarty.const.FORM_MULTIPLE_CB}cm-multiple-checkboxes{/if}">{$element.description}</label>

            {if $element.element_type == $smarty.const.FORM_SELECT}
                <select id="elm_{$element.element_id}" class="form-control" name="form_values[{$element.element_id}]">
                    <option label="" value="">- {__("select")} -</option>
                {foreach from=$element.variants item=var}
                    <option value="{$var.element_id}" {if $form_values.$element_id == $var.element_id}selected="selected"{/if}>{$var.description}</option>
                {/foreach}
                </select>
                
                
            {elseif $element.element_type == $smarty.const.FORM_RADIO}
                {foreach from=$element.variants item=var name="rd"}
                <div class="radio">
                    <label>
                        <input {if (!$form_values && $smarty.foreach.rd.iteration == 1) || ($form_values.$element_id == $var.element_id)}checked="checked"{/if} type="radio" name="form_values[{$element.element_id}]" value="{$var.element_id}" />{$var.description}&nbsp;&nbsp;
                    </label>
                </div>
                {/foreach}
                
            {elseif $element.element_type == $smarty.const.FORM_CHECKBOX}
            <div class="checkbox">
                <input type="hidden" name="form_values[{$element.element_id}]" value="N" />
                <input id="elm_{$element.element_id}" {if $form_values.$element_id == "Y"}checked="checked"{/if} type="checkbox" name="form_values[{$element.element_id}]" value="Y" />
            </div>
                
            {elseif $element.element_type == $smarty.const.FORM_MULTIPLE_SB}
                <select class="form-control" id="elm_{$element.element_id}" name="form_values[{$element.element_id}][]" multiple="multiple" >
                    {foreach from=$element.variants item=var}
                        <option value="{$var.element_id}" {if $var.element_id|in_array:$form_values.$element_id}selected="selected"{/if}>{$var.description}</option>
                    {/foreach}
                </select>
                
                
            {elseif $element.element_type == $smarty.const.FORM_MULTIPLE_CB}
                <div id="elm_{$element.element_id}">
                {foreach from=$element.variants item=var}
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" {if $var.element_id|in_array:$form_values.$element_id}checked="checked"{/if} id="elm_{$element.element_id}_{$var.element_id}" name="form_values[{$element.element_id}][]" value="{$var.element_id}" />
                            {$var.description}
                        </label>
                    </div>
                {/foreach}
                </div>
                
                
            {elseif $element.element_type == $smarty.const.FORM_INPUT}
                <input id="elm_{$element.element_id}" class="form-control {if $element.position == 1}cm-focus {/if}" size="50" type="text" name="form_values[{$element.element_id}]" value="{$form_values.$element_id}" />

            {elseif $element.element_type == $smarty.const.FORM_TEXTAREA}
                <textarea id="elm_{$element.element_id}" class="form-control" name="form_values[{$element.element_id}]" cols="67" rows="10">{$form_values.$element_id}</textarea>

            {elseif $element.element_type == $smarty.const.FORM_DATE}
                {include file="common/calendar.tpl" date_name="form_values[`$element.element_id`]" date_id="elm_`$element.element_id`" date_val=$form_values.$element_id}

            {elseif $element.element_type == $smarty.const.FORM_EMAIL || $element.element_type == $smarty.const.FORM_NUMBER || $element.element_type == $smarty.const.FORM_PHONE}

                {if $element.element_type == $smarty.const.FORM_EMAIL}
                <input type="hidden" name="customer_email" value="{$element.element_id}" />
                {/if}
                <input id="elm_{$element.element_id}" class="form-control {if $element.position == 1}cm-focus {/if}" size="50" type="text" name="form_values[{$element.element_id}]" value="{$form_values.$element_id}" />
                
            {elseif $element.element_type == $smarty.const.FORM_COUNTRIES}
                {$_country = $form_values.$element_id|default:$settings.General.default_country}
                <select id="elm_{$element.element_id}" name="form_values[{$element.element_id}]" class="form-control cm-country cm-location-billing">
                    <option value="">- {__("select_country")} -</option>
                    {assign var="countries" value=1|fn_get_simple_countries}
                    {foreach from=$countries item="country" key="code"}
                    <option value="{$code}" {if $_country == $code}selected="selected"{/if}>{$country}</option>
                    {/foreach}
                </select>

            {elseif $element.element_type == $smarty.const.FORM_STATES}

                {include file="views/profiles/components/profiles_scripts.tpl" states=1|fn_get_all_states}

                {$_state = $form_values.$element_id|default:$settings.General.default_state}
                <select class="form-control cm-state cm-location-billing" id="elm_{$element.element_id}" name="form_values[{$element.element_id}]">
                    <option label="" value="">- {__("select_state")} -</option>
                </select>
                <input type="text" class="cm-state cm-location-billing form-control hidden" id="elm_{$element.element_id}_d" name="form_values[{$element.element_id}]" size="32" maxlength="64" value="{$_state}" disabled="disabled" />
            
            {elseif $element.element_type == $smarty.const.FORM_FILE}
                {script src="js/tygh/fileuploader_scripts.js"}
                {include file="common/fileuploader.tpl" var_name="fb_files[`$element.element_id`]"}
            {/if}

            {hook name="pages:form_elements"}
            {/hook}
        </div>
    {/if}
    {/foreach}

    {include file="common/image_verification.tpl" option="form_builder"}

    <div class="buttons-container panel panel-default">
        <div class="panel-body">
            {include file="common/button.tpl" text=__("submit") meta="btn-primary" name="dispatch[pages.send_form]"}
        </div>
    </div>

    </form>
    </div>
</div>
{/if}
  {hook name="pages:page_content"}{/hook}
{/if}
{if $show_email}
    <div class="form-group">
        <label for="{$id_prefix}elm_email" class="cm-required cm-email control-label">{__("email")}<i>*</i></label>
        <input type="email" id="{$id_prefix}elm_email" name="user_data[email]" size="32" value="{$user_data.email}" class="form-control {$_class}" {$disabled_param} />
    </div>
{else}
    {if $profile_fields.$section}
        {if $address_flag}
            <div class="panel panel-default">
                <div class="panel-body">
                        {if $section == "S"}
                            <span>{__("shipping_same_as_billing")}</span>
                        {else}
                            <span>{__("text_billing_same_with_shipping")}</span>
                        {/if}
                    <div class="pull-right">
                        <label class="radio-inline control-label" for="sw_{$body_id}_suffix_no">
                            <input class="radio cm-switch-availability cm-switch-visibility" type="radio" name="ship_to_another" value="1" id="sw_{$body_id}_suffix_no" {if $ship_to_another}checked="checked"{/if} />
                            {__("no")}
                        </label>
                        <label class="radio-inline control-label" for="sw_{$body_id}_suffix_yes">
                            <input class="radio cm-switch-availability cm-switch-inverse cm-switch-visibility" type="radio" name="ship_to_another" value="0" id="sw_{$body_id}_suffix_yes" {if !$ship_to_another}checked="checked"{/if} />
                            {__("yes")}
                        </label>
                    </div>
                </div>
            </div>
        {else}
            <input type="hidden" name="ship_to_another" value="1" />
        {/if}

        {if ($address_flag && !$ship_to_another && ($section == "S" || $section == "B")) || $disabled_by_default}
            {assign var="disabled_param" value="disabled=\"disabled\""}
            {assign var="_class" value="disabled"}
            {assign var="hide_fields" value=true}
        {else}
            {assign var="disabled_param" value=""}
            {assign var="_class" value=""}
        {/if}

        {if $body_id || $grid_wrap}
            <div id="{$body_id}" class="{if $hide_fields}hidden{/if}">
                <div class="{$grid_wrap}">
        {/if}

        {if !$nothing_extra}
            <h3>{$title}</h3>
        {/if}

        {foreach from=$profile_fields.$section item=field name="profile_fields"}
        
        {if $field.field_name && $field.is_default == "Y"}
            {assign var="data_name" value="user_data"}
            {assign var="data_id" value=$field.field_name}
            {assign var="value" value=$user_data.$data_id}
        {else}
            {assign var="data_name" value="user_data[fields]"}
            {assign var="data_id" value=$field.field_id}
            {assign var="value" value=$user_data.fields.$data_id}
        {/if}

        {assign var="skip_field" value=false}
        {if $section == "S" || $section == "B"}
            {if $section == "S"}
                {assign var="_to" value="B"}
            {else}
                {assign var="_to" value="S"}
            {/if}
            {if !$profile_fields.$_to[$field.matching_id]}
                {assign var="skip_field" value=true}
            {/if}
        {/if}

        {hook name="profiles:profile_fields"}
        <div class="form-group {$field.class}">
            {if $pref_field_name != $field.description || $field.required == "Y"}
                <label for="{$id_prefix}elm_{$field.field_id}" class="cm-profile-field {if $field.required == "Y"}cm-required{/if}{if $field.field_type == "P"} cm-phone{/if}{if $field.field_type == "Z"} cm-zipcode{/if}{if $field.field_type == "E"} cm-email{/if} {if $field.field_type == "Z"}{if $section == "S"}cm-location-shipping{else}cm-location-billing{/if}{/if}">{$field.description}</label>
            {/if}

            {if $field.field_type == "A"}  {* State selectbox *}
                {$_country = $settings.General.default_country}
                {$_state = $value|default:$settings.General.default_state}

                <select {if $field.autocomplete_type}x-autocompletetype="{$field.autocomplete_type}"{/if} id="{$id_prefix}elm_{$field.field_id}" class="form-control cm-state {if $section == "S"}cm-location-shipping{else}cm-location-billing{/if} {if !$skip_field}{$_class}{/if}" name="{$data_name}[{$data_id}]" {if !$skip_field}{$disabled_param nofilter}{/if}>
                    <option value="">- {__("select_state")} -</option>
                    {if $states && $states.$_country}
                        {foreach from=$states.$_country item=state}
                            <option {if $_state == $state.code}selected="selected"{/if} value="{$state.code}">{$state.state}</option>
                        {/foreach}
                    {/if}
                </select><input {if $field.autocomplete_type}x-autocompletetype="{$field.autocomplete_type}"{/if} type="text" id="elm_{$field.field_id}_d" name="{$data_name}[{$data_id}]" size="32" maxlength="64" value="{$_state}" disabled="disabled" class="cm-state {if $section == "S"}cm-location-shipping{else}cm-location-billing{/if} form-control hidden {if $_class}disabled{/if}"/>

            {elseif $field.field_type == "O"}  {* Countries selectbox *}
                {assign var="_country" value=$value|default:$settings.General.default_country}
                <select {if $field.autocomplete_type}x-autocompletetype="{$field.autocomplete_type}"{/if} id="{$id_prefix}elm_{$field.field_id}" class="form-control cm-country {if $section == "S"}cm-location-shipping{else}cm-location-billing{/if} {if !$skip_field}{$_class}{else}cm-skip-avail-switch{/if}" name="{$data_name}[{$data_id}]" {if !$skip_field}{$disabled_param nofilter}{/if}>
                    {hook name="profiles:country_selectbox_items"}
                    <option value="">- {__("select_country")} -</option>
                    {foreach from=$countries item="country" key="code"}
                    <option {if $_country == $code}selected="selected"{/if} value="{$code}">{$country}</option>
                    {/foreach}
                    {/hook}
                </select>
            
            {elseif $field.field_type == "C"}  {* Checkbox *}
                <input type="hidden" name="{$data_name}[{$data_id}]" value="N" {if !$skip_field}{$disabled_param nofilter}{/if} />
                <input type="checkbox" id="{$id_prefix}elm_{$field.field_id}" name="{$data_name}[{$data_id}]" value="Y" {if $value == "Y"}checked="checked"{/if} class="checkbox {if !$skip_field}{$_class}{else}cm-skip-avail-switch{/if}" {if !$skip_field}{$disabled_param nofilter}{/if} />

            {elseif $field.field_type == "T"}  {* Textarea *}
                <textarea {if $field.autocomplete_type}x-autocompletetype="{$field.autocomplete_type}"{/if} class="form-control {if !$skip_field}{$_class}{else}cm-skip-avail-switch{/if}" id="{$id_prefix}elm_{$field.field_id}" name="{$data_name}[{$data_id}]" cols="32" rows="3" {if !$skip_field}{$disabled_param nofilter}{/if}>{$value}</textarea>
            
            {elseif $field.field_type == "D"}  {* Date *}
                {if !$skip_field}
                    {include file="common/calendar.tpl" date_id="`$id_prefix`elm_`$field.field_id`" date_name="`$data_name`[`$data_id`]" date_val=$value extra=$disabled_param}
                {else}
                    {include file="common/calendar.tpl" date_id="`$id_prefix`elm_`$field.field_id`" date_name="`$data_name`[`$data_id`]" date_val=$value}
                {/if}

            {elseif $field.field_type == "S"}  {* Selectbox *}
                <select {if $field.autocomplete_type}x-autocompletetype="{$field.autocomplete_type}"{/if} id="{$id_prefix}elm_{$field.field_id}" class="form-control {if !$skip_field}{$_class}{else}cm-skip-avail-switch{/if}" name="{$data_name}[{$data_id}]" {if !$skip_field}{$disabled_param nofilter}{/if}>
                    {if $field.required != "Y"}
                    <option value="">--</option>
                    {/if}
                    {foreach from=$field.values key=k item=v}
                    <option {if $value == $k}selected="selected"{/if} value="{$k}">{$v}</option>
                    {/foreach}
                </select>
            
            {elseif $field.field_type == "R"}  {* Radiogroup *}
                <div id="{$id_prefix}elm_{$field.field_id}">
                    {foreach from=$field.values key=k item=v name="rfe"}
                    <input class="radio {if !$skip_field}{$_class}{else}cm-skip-avail-switch{/if} {$id_prefix}elm_{$field.field_id}" type="radio" id="{$id_prefix}elm_{$field.field_id}_{$k}" name="{$data_name}[{$data_id}]" value="{$k}" {if (!$value && $smarty.foreach.rfe.first) || $value == $k}checked="checked"{/if} {if !$skip_field}{$disabled_param nofilter}{/if} /><span class="radio">{$v}</span>
                    {/foreach}
                </div>

            {elseif $field.field_type == "N"}  {* Address type *}
                <input class="radio {if !$skip_field}{$_class}{else}cm-skip-avail-switch{/if} {$id_prefix}elm_{$field.field_id}" type="radio" id="{$id_prefix}elm_{$field.field_id}_residential" name="{$data_name}[{$data_id}]" value="residential" {if !$value || $value == "residential"}checked="checked"{/if} {if !$skip_field}{$disabled_param nofilter}{/if} /><span class="radio">{__("address_residential")}</span>
                <input class="radio {if !$skip_field}{$_class}{else}cm-skip-avail-switch{/if} {$id_prefix}elm_{$field.field_id}" type="radio" id="{$id_prefix}elm_{$field.field_id}_commercial" name="{$data_name}[{$data_id}]" value="commercial" {if $value == "commercial"}checked="checked"{/if} {if !$skip_field}{$disabled_param nofilter}{/if} /><span class="radio">{__("address_commercial")}</span>

            {else}  {* Simple input *}
                <input {if $field.autocomplete_type}x-autocompletetype="{$field.autocomplete_type}"{/if} type="text" id="{$id_prefix}elm_{$field.field_id}" name="{$data_name}[{$data_id}]" size="32" value="{$value}" class="form-control {if !$skip_field}{$_class}{else}cm-skip-avail-switch{/if} {if $smarty.foreach.profile_fields.index == 0} cm-focus{/if}" {if !$skip_field}{$disabled_param nofilter}{/if} />
            {/if}

            {assign var="pref_field_name" value=$field.description}
        </div>
        {/hook}
        {/foreach}

        {if $body_id || $grid_wrap}
                </div>
            </div>
        {/if}
        

    {/if}
{/if}

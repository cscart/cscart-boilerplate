<div class="step-complete-wrapper clearfix">
    {if $section == "C"}
        {capture assign="fields_text"}
            {foreach from=$profile_fields.$section item="field_data"}

                {assign var="field_name" value=$field_data.field_name}

                {if $field_name == "firstname" || $field_name == "lastname"}
                    {assign var="user_$field_name" value=$user_data.$field_name}
                {elseif $field_name}
                    {if $field_name != "email" && $field_name != "company" && $field_name != "url"}
                        <strong>{$field_data.description}:</strong>&nbsp;
                    {/if}
                    {$user_data.$field_name}
                {/if}

            {/foreach}
        {/capture}
        {if $user_firstname || $user_lastname}<strong>{$user_firstname}{if $user_lastname}&nbsp;{$user_lastname}{/if}</strong>{/if}
        {$fields_text}

    {else}
        {if $text}
            <strong class="pull-left">{$text}: &nbsp;</strong>
        {/if}

        {assign var="prefix" value=$section|lower}
        {assign var="prefix_len" value="`$prefix`_"|strlen}

        {foreach from=$profile_fields.$section item="field_data"}

            {assign var="field_name" value=$field_data.field_name}
            {assign var="_field_name" value=$field_name|substr:$prefix_len}

            {if $field_name == "`$prefix`_firstname" ||
                $field_name == "`$prefix`_lastname" ||
                $field_name == "`$prefix`_address" ||
                $field_name == "`$prefix`_address_2" ||
                $field_name == "`$prefix`_city" ||
                $field_name == "`$prefix`_zipcode"}

                {* get value of base fields *}
                {assign var="user_$_field_name" value=$user_data.$field_name}

            {elseif $field_name == "`$prefix`_country" ||
                    $field_name == "`$prefix`_state"}

                {* get description of base fields *}
                {assign var="field_name_descr" value="`$field_name`_descr"}
                {assign var="user_$_field_name" value=$user_data.$field_name_descr}

            {/if}
        {/foreach}

        <div class="overflow-hidden">
        {if $user_firstname || $user_lastname}
            <p class="p-none"><strong>{$user_firstname}{if $user_lastname} {$user_lastname}{/if}</strong></p>
        {/if}
        {if $user_address}<p class="p-none">{$user_address}</p>{/if}
        {if $user_address_2}<p class="p-none">{$user_address_2}</p>{/if}
        {if $user_city}{assign var="user_location" value="$user_city"}{/if}
        {if $user_state}
            {if $user_location}{assign var="user_location" value="$user_location, "}{/if}
            {assign var="user_location" value="$user_location$user_state"}
        {/if}
        {if $user_zipcode}
            {assign var="user_location" value="$user_location $user_zipcode"}
        {/if}
        {if $user_location}<p class="p-none">{$user_location}</p>{/if}
        {if $user_country}<p class="p-none">{$user_country}</p>{/if}
        
        </div>
    {/if}

    {if $user_data.fields}
        {assign var="profile_section" value=$profile_fields.$section}
        {strip}
        {foreach from=$profile_section item="p_field" key="field_id"}
        {if $user_data.fields.$field_id}
            {assign var="field" value=$user_data.fields.$field_id}
            <p class="step-complete-text"><strong>{$p_field.description}:</strong>&nbsp;
            {if $p_field.field_type == "C"}  {* Checkbox *}
                {if $field == "Y"}{__("yes")}{else}{__("no")}{/if}
            {elseif $p_field.field_type == "D"}  {* Date *}
                {$field|date_format:$settings.Appearance.date_format}
            {elseif $p_field.field_type == "T"}  {* Textarea *}
                {$field|truncate:30:"...":true}
            {elseif $p_field.field_type == "R" || $p_field.field_type == "S"}  {* Radiogroup *}  {* Selectbox *}
                {foreach from=$p_field.values key="k" item="v" name="rfe"}
                {if !$field && $smarty.foreach.rfe.first}
                    {assign var="id" value=$smarty.foreach.rfe.first}
                    {$p_field.values.$id}
                {elseif $field == $k}
                    {$v}
                {/if}
                {/foreach}
            {else}  {* Simple input *}
                {$field}
            {/if}
            </p>
        {/if}
        {/foreach}
        {/strip}
    {/if}
</div>
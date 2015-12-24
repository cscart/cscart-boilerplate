{if $display_button_block}
    {foreach $provider_meta_data.all key="meta_name" item="meta_value"}
        <meta property="og:{$meta_name}" content="{$meta_value}" />
    {/foreach}

    {foreach from=$provider_settings item="provider_data"}
        {if $provider_data && $provider_data.meta_template}
            {include file="addons/social_buttons/meta_templates/`$provider_data.meta_template`"}
        {/if}
    {/foreach}
{/if}

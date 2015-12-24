{if $display_button_block}
    <ul class="list-inline social-buttons">
    {foreach from=$provider_settings item="provider_data"}
        {if $provider_data && $provider_data.template && $provider_data.data}
            <li>{include file="addons/social_buttons/providers/`$provider_data.template`"}</li>
        {/if}
    {/foreach}
    </ul>
{/if}

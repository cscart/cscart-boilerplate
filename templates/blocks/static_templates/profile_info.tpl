{if $runtime.controller == 'profiles'}
    {if $runtime.mode == 'add'}
    <div class="account-benefits text-center">
        {__("text_profile_benefits")}
    </div>
    {elseif $runtime.mode == 'update'}
        <div class="account-detail">
            {__("text_profile_details")}
        </div>
    {/if}
{/if}
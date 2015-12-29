{if is_array($providers_list)}
    {if !isset($redirect_url)}
        {assign value= $config.current_url var="redirect_url"}
    {/if}
    {__("hybrid_auth.social_login")}:
    <p>{$smarty.capture.hybrid_auth nofilter}
    {strip}
    <input type="hidden" name="redirect_url" value="{$redirect_url}" />
    <ul class="list-inline hybrid-auth-providers-list">
	{foreach from=$providers_list item="provider_data"}
        {if $provider_data.status == 'A'}
            <li>
                <a class="cm-login-provider hybrid-auth-icon" data-idp="{$provider_data.provider}"><img src="{$images_dir}/addons/hybrid_auth/icons/{$addons.hybrid_auth.icons_pack}/{$provider_data.provider}.png" title="{$provider_data.provider}" alt="{$provider_data.provider}" /></a>
            </li>
	    {/if}
    {/foreach}
    </ul>
    {/strip}
    </p>
{/if}
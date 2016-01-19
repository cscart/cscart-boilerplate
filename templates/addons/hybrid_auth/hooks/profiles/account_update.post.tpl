{if $providers_list}
    <h4>{__("hybrid_auth.link_provider")}</h4>
    <p>{__("hybrid_auth.text_link_provider")}</p>

    <div class="hybrid-auth-icons" id="hybrid_providers">
        <ul class="list-inline">
        {foreach from=$providers_list item="provider_data"}
        {if in_array($provider_data.provider, $linked_providers)}
            <li>
                <a class="cm-unlink-provider hybrid-auth-remove btn btn-xs btn-link" data-idp="{$provider_data.provider}">
                    <i class="glyphicon glyphicon-remove-sign fa fa-times-circle"></i>
                </a>
                <img src="{$images_dir}/addons/hybrid_auth/icons/{$addons.hybrid_auth.icons_pack}/{$provider_data.provider}.png" title="{__("hybrid_auth.linked_provider")}" alt="{$provider_data.provider}"/>
            </li>
        {/if}
        {/foreach}
        </ul>
        <ul class="list-inline">
        {foreach from=$providers_list item="provider_data"}
        {if !in_array($provider_data.provider, $linked_providers)}
            <li>
                <a class="cm-link-provider link-unlink-provider btn btn-xs btn-link" data-idp="{$provider_data.provider}">
                    <img src="{$images_dir}/addons/hybrid_auth/icons/{$addons.hybrid_auth.icons_pack}/{$provider_data.provider}.png" title="{__("hybrid_auth.not_linked_provider")}" alt="{$provider_data.provider}"/>
                </a>
            </li>
        {/if}
        {/foreach}
        </ul>
    <!--hybrid_providers--></div>
{/if}
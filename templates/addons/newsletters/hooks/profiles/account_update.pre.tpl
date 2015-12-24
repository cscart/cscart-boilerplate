{if $page_mailing_lists}
    {capture name="mailing_lists"}
        {assign var="show_newsletters_content" value=false}

        <div class="newsletters">
            <p>{__("text_signup_for_subscriptions")}</p>
            {foreach from=$page_mailing_lists item=list}
                {if $list.show_on_registration}
                    {assign var="show_newsletters_content" value=true}
                {/if}

                <div class="newsletters-item checkbox{if !$list.show_on_registration} hidden{/if}">
                    <label for="profile_mailing_list_{$list.list_id}">
                    <input id="profile_mailing_list_{$list.list_id}" type="checkbox" name="mailing_lists[]" value="{$list.list_id}" {if $user_mailing_lists[$list.list_id]}checked="checked"{/if} />{$list.object}</label>
                </div>
            {/foreach}
        </div>
    {/capture}

    {if $show_newsletters_content}
        <h4>{__("mailing_lists")}</h4>
        {$smarty.capture.mailing_lists nofilter}
    {/if}
{/if}

{capture name="mailing_lists"}
    {assign var="show_newsletters_content" value=false}
    <div class="newsletters subscription-container" id="subsciption_{$tab_id}">
        <input type="hidden" name="mailing_lists" value="" />
        {foreach from=$page_mailing_lists item=list}
            {if $list.show_on_checkout}
                {assign var="show_newsletters_content" value=true}
            {/if}
            <div class="newsletters-item checkbox {if !$list.show_on_checkout} hidden{/if}">
                <label><input type="checkbox" name="mailing_lists[]" value="{$list.list_id}" {if $user_mailing_lists[$list.list_id]}checked="checked"{/if} class="cm-news-subscribe" />{$list.object}</label>
            </div>
        {/foreach}
    <!--subsciption_{$tab_id}--></div>
{/capture}

{if $show_newsletters_content}
    <h4>{__("text_signup_for_subscriptions")}</h4>

    {$smarty.capture.mailing_lists nofilter}
{/if}
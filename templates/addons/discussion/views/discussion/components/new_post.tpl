<div class="discussion-post-popup hidden" id="new_post_dialog_{$obj_prefix}{$obj_id}" title="{$new_post_title}">
    <form action="{""|fn_url}" method="post" class="{if !$post_redirect_url}cm-ajax cm-form-dialog-closer{/if} posts-form" name="add_post_form" id="add_post_form_{$obj_prefix}{$obj_id}">

    <input type="hidden" name="result_ids" value="posts_list*,new_post*,average_rating*">
    <input type ="hidden" name="post_data[thread_id]" value="{$discussion.thread_id}" />
    <input type ="hidden" name="redirect_url" value="{$post_redirect_url|default:$config.current_url}" />
    <input type="hidden" name="selected_section" value="" />

    <div id="new_post_{$obj_prefix}{$obj_id}">

    <div class="form-group">
        <label for="dsc_name_{$obj_prefix}{$obj_id}" class="control-label cm-required">{__("your_name")}</label>
        <input type="text" id="dsc_name_{$obj_prefix}{$obj_id}" name="post_data[name]" value="{if $auth.user_id}{$user_info.firstname} {$user_info.lastname}{elseif $discussion.post_data.name}{$discussion.post_data.name}{/if}" size="50" class="form-control" />
    </div>

    {if $discussion.type == "R" || $discussion.type == "B"}
    <div class="form-group">
        {$rate_id = "rating_`$obj_prefix``$obj_id`"}
        <label for="{$rate_id}" class="control-label cm-required cm-multiple-radios">{__("your_rating")}</label>
        {include file="addons/discussion/views/discussion/components/rate.tpl" rate_id=$rate_id rate_name="post_data[rating_value]"}
    </div>
    {/if}

    {hook name="discussion:add_post"}
    {if $discussion.type == "C" || $discussion.type == "B"}
    <div class="form-group">
        <label for="dsc_message_{$obj_prefix}{$obj_id}" class="control-label cm-required">{__("your_message")}</label>
        <textarea id="dsc_message_{$obj_prefix}{$obj_id}" name="post_data[message]" class="form-control" rows="5" cols="72">{$discussion.post_data.message}</textarea>
    </div>
    {/if}
    {/hook}

    {include file="common/image_verification.tpl" option="discussion"}

    <!--new_post_{$obj_prefix}{$obj_id}--></div>

    <div class="buttons-container">
        {include file="common/button.tpl" text=__("submit") meta="btn-primary" name="dispatch[discussion.add]"}
    </div>

    </form>
</div>

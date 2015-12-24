{assign var="discussion" value=$object_id|fn_get_discussion:$object_type:true:$smarty.request}
{if $object_type == "P"}
{$new_post_title = __("write_review")}
{else}
{$new_post_title = __("new_post")}
{/if}
{if $discussion && $discussion.type != "D"}
    <div class="discussion-block" id="{if $container_id}{$container_id}{else}content_discussion{/if}">
        {if $wrap == true}
            {capture name="content"}
            {include file="common/subheader.tpl" title=$title}
        {/if}

        {if $subheader}
            <h4>{$subheader}</h4>
        {/if}

        <div id="posts_list_{$object_id}">
            {if $discussion.posts}
                {include file="common/pagination.tpl" id="pagination_contents_comments_`$object_id`" extra_url="&selected_section=discussion" search=$discussion.search}
                {foreach from=$discussion.posts item=post}
                    <div class="discussion-post-content">
                        {hook name="discussion:items_list_row"}
                        <div class="discussion-post {cycle values=", discussion-post_even"}" id="post_{$post.post_id}">

                            {if $discussion.type == "C" || $discussion.type == "B"}
                                <div class="discussion-post-message">{$post.message|escape|nl2br nofilter}</div>
                            {/if}
                    
                        </div>
                        <span><strong>{$post.name}</strong></span>
                        <span class="pull-right small">{$post.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}</span>
                        {if $discussion.type == "R" || $discussion.type == "B" && $post.rating_value > 0}
                            <div class="clearfix discussion-post-rating">
                                {include file="addons/discussion/views/discussion/components/stars.tpl" stars=$post.rating_value|fn_get_discussion_rating}
                            </div>
                        {/if}
                        {/hook}
                    </div>
                {/foreach}


                {include file="common/pagination.tpl" id="pagination_contents_comments_`$object_id`" extra_url="&selected_section=discussion" search=$discussion.search}
            {else}
                <p class="no-items">{__("no_posts_found")}</p>
            {/if}
        <!--posts_list_{$object_id}--></div>

        {if "CRB"|strpos:$discussion.type !== false && !$discussion.disable_adding}
            <div class="buttons-container">
                {include file="common/button.tpl" id="opener_new_post" text=$new_post_title target_id="new_post_dialog_`$obj_id`" meta="cm-dialog-opener cm-dialog-auto-size btn-primary" rel="nofollow" as="link"}
            </div>
            {if $object_type != "P"}
                {include file="addons/discussion/views/discussion/components/new_post.tpl" new_post_title=$new_post_title}
            {/if}
        {/if}

        {if $wrap == true}
            {/capture}
            {$smarty.capture.content nofilter}
        {else}
            {capture name="mainbox_title"}{$title}{/capture}
        {/if}
    </div>
{/if}
{$discussion = $object_id|fn_get_discussion:$object_type:true:$smarty.request}

{if $discussion && $discussion.type != "D"}
    {include file="common/subheader.tpl" title=$title}

    <div id="posts_list_{$object_id}">
    {if $discussion.posts}
        <div class="scroller-discussion-list">
            <div id="scroll_list_discussion" class="owl-carousel scroller-list">
                {foreach from=$discussion.posts item=post}
                    <div class="discussion-post-content scroller-discussion-list-item">

                        <a href="{"discussion.view?thread_id=`$discussion.thread_id`&post_id=`$post.post_id`"|fn_url}#post_{$post.post_id}">
                            <div class="discussion-post {cycle values=", discussion-post_even"}" id="post_{$post.post_id}">

                                {if $discussion.type == "C" || $discussion.type == "B"}
                                <div class="discussion-post-message">{$post.message|truncate:100|nl2br nofilter}</div>
                                {/if}
                                
                            </div>
                        </a>

                        <span class="discussion-post-author">{$post.name}</span>
                        <span class="discussion-post-date">{$post.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}</span>
                        {if $discussion.type == "R" || $discussion.type == "B" && $post.rating_value > 0}
                            <div class="clearfix discussion-post-rating">
                                <a href="{"discussion.view?thread_id=`$discussion.thread_id`&post_id=`$post.post_id`"|fn_url}#post_{$post.post_id}">
                                    {include file="addons/discussion/views/discussion/components/stars.tpl" stars=$post.rating_value|fn_get_discussion_rating}
                                </a>
                            </div>
                        {/if}
                    </div>
                {/foreach}
            </div>
        </div>
    {else}
        <p class="no-items">{__("no_data")}</p>
    {/if}
    <!--posts_list_{$object_id}--></div>

    {if $object_type == "P"}
        {$new_post_title = __("write_review")}
    {else}
        {$new_post_title = __("new_post")}
    {/if}

    {if "CRB"|strpos:$discussion.type !== false && !$discussion.disable_adding}
        <div class="buttons-container">
            {include file="common/button.tpl" id="opener_new_post" text=$new_post_title target_id="new_post_dialog_`$obj_id`" meta="cm-dialog-opener cm-dialog-auto-size btn-primary" rel="nofollow"}
        </div>
        {if $object_type != "P"}
            {include file="addons/discussion/views/discussion/components/new_post.tpl" new_post_title=$new_post_title}
        {/if}
    {/if}

    {$block = ["block_id" => "discussion", "properties" => ["item_quantity" => 2, "scroll_per_page" => "Y", "not_scroll_automatically" => "Y", "outside_navigation" => true]]}
    {include file="common/scroller_init.tpl" block=$block}

{/if}
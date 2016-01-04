{** block-description:discussion_title_home_page **}

{assign var="discussion" value=0|fn_get_discussion:"E":true:$block.properties}

{if $discussion && $discussion.type != "D" && $discussion.posts}

{assign var="obj_prefix" value="`$block.block_id`000"}

<div class="scroller-discussion-list">
    <div id="scroll_list_{$block.block_id}" class="owl-carousel scroller-list">

    {foreach from=$discussion.posts item=post}
        <div class="discussion-post-content scroller-discussion-list-item">
            {hook name="discussion:items_list_row"}
            <a href="{"discussion.view?thread_id=`$discussion.thread_id`&post_id=`$post.post_id`"|fn_url}#post_{$post.post_id}">
                <div class="discussion-post {cycle values=", discussion-post_even"}" id="post_{$post.post_id}">

                    {if $discussion.type == "C" || $discussion.type == "B"}
                    <div class="discussion-post-message">{$post.message|truncate:100|nl2br nofilter}</div>
                    {/if}
                    
                </div>
            </a>

            <span><strong>{$post.name}</strong></span>
            <span class="pull-right small">{$post.timestamp|date_format:"`$settings.Appearance.date_format`"}</span>
            {if $discussion.type == "R" || $discussion.type == "B" && $post.rating_value > 0}
                <div class="clearfix discussion-post-rating">
                    {include file="addons/discussion/views/discussion/components/stars.tpl" stars=$post.rating_value|fn_get_discussion_rating}
                </div>
            {/if}
            {/hook}
        </div>
    {/foreach}

    </div>
 </div>

{if $block.properties.outside_navigation == "Y"}
    <div class="owl-theme owl-controls">
        <div class="owl-controls clickable owl-controls-outside" id="owl_outside_nav_{$block.block_id}">
            <div class="owl-buttons">
                <div id="owl_prev_{$obj_prefix}" class="owl-prev"><i class="glyphicon glyphicon-menu-left fa fa-angle-left"></i></div>
                <div id="owl_next_{$obj_prefix}" class="owl-next"><i class="glyphicon glyphicon-menu-right fa fa-angle-right"></i></div>
            </div>
        </div>
    </div>
{/if}

{include file="common/scroller_init_with_quantity.tpl" prev_selector="#owl_prev_`$obj_prefix`" next_selector="#owl_next_`$obj_prefix`"}

{/if}

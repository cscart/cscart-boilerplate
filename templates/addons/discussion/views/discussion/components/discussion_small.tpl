{assign var="box_type" value=$box_type|default:"side"}
{assign var="discussion" value=$object_id|fn_get_discussion:$object_type:true:$smarty.request}

{if $discussion && $discussion.type != "D" && $discussion.posts}

{capture name="box"}

{foreach from=$posts item=post}
<p><strong>{__("author")}:</strong> {$post.name}</p>
{$post.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}

{if $discussion.type == "R" || $discussion.type == "B"}
    <p>{include file="addons/discussion/views/discussion/components/stars.tpl" stars=$post.rating_value|fn_get_discussion_rating}</p>
{/if}

{if $discussion.type == "C" || $discussion.type == "B"}
    <p>{$post.message|truncate:100|nl2br}</p>
{/if}

{/foreach}

<p class="right">
    <a href="{"discussion.view?thread_id=`$discussion.thread_id`"|fn_url}">{__("more_w_ellipsis")}</a>
</p>

{/capture}

{if $no_box}
{$smarty.capture.box nofilter}
{else}
{include file="common/`$box_type`box.tpl" title=$title content=$smarty.capture.box anchor="discussion"}
{/if}


{/if}
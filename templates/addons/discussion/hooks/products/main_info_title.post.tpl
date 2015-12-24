{if $product.discussion_type && $product.discussion_type != 'D'}
    <div class="discussion-rating-wrapper" id="average_rating_product">
        {assign var="rating" value="rating_`$obj_id`"}{$smarty.capture.$rating nofilter}

        {if $product.discussion.posts}
        <a class="discussion-review-a cm-external-click" data-ca-scroll="content_discussion" data-ca-external-click-id="discussion">{$product.discussion.search.total_items} {__("reviews", [$product.discussion.search.total_items])}</a>
        {/if}
        <a class="discussion-review-write cm-dialog-opener cm-dialog-auto-size" data-ca-target-id="new_post_dialog_{$obj_id}" rel="nofollow">{__("write_review")}</a>
    <!--average_rating_product--></div>
{/if}

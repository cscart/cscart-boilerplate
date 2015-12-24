{if $smarty.request.category_id}
    {if $addons.rss_feed.display_rss_feed_in_category == "Y"}{include file="addons/rss_feed/blocks/rss_feed.tpl" param="&category_id=`$smarty.request.category_id`"}{/if}
{/if}
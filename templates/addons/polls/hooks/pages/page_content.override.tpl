{if $page.page_type == $smarty.const.PAGE_TYPE_POLL}
    {include file="addons/polls/views/pages/components/poll.tpl" poll=$page.poll}
{/if}
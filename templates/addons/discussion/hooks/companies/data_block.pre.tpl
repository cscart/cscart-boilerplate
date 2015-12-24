{if $show_rating}

{if $company.average_rating}
    {$average_rating = $company.average_rating}
{elseif $company.discussion.average_rating}
    {$average_rating = $company.discussion.average_rating}
{/if}

{if $average_rating}
{include file="addons/discussion/views/discussion/components/stars.tpl" stars=$average_rating|fn_get_discussion_rating is_link=true}
{/if}

{/if}
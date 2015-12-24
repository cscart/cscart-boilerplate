{** block-description:tmpl_polls_central **}

{if $items}
{foreach from=$items item="poll"}
{include file="addons/polls/views/pages/components/poll.tpl" obj_prefix="`$block.block_id`_"}
{/foreach}
{/if}
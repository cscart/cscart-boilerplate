{include file="common/button.tpl" text=__("view_results") href="pages.view?page_id=`$poll.page_id`&action=results" target_id="polls_block_`$poll.page_id`" meta="cm-dialog-opener cm-dialog-auto-size btn-primary" rel="nofollow"}
<div id="polls_block_{$poll.page_id}" class="hidden poll-popup" title="{$poll.page|escape:quotes}"></div>

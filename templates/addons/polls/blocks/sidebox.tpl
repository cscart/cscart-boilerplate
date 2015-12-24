{** block-description:tmpl_polls_side **}

<div class="polls">
{foreach from=$items item=poll}
{if $smarty.request.page_id != $poll.page_id}
    <div class="panel panel-default polls">

    {if $poll.completed}
        <div class="panel-body">
            <h4 class="poll-header">{__("polls_have_completed")}</h4>
            {if $poll.show_results == "V" || $poll.show_results == "E"}
            <div class="polls-buttons">
                {include file="addons/polls/views/pages/components/poll_results_link.tpl"}
            </div>
            {/if}
        </div>
    {else}
        {if $poll.header}
            <div class="panel-heading">{$poll.header nofilter}</div>
        {/if}
        <div class="panel-body">
            <form name="{$form_name|default:"main_login_form"}" action="{""|fn_url}" method="post">
                <input type="hidden" name="page_id" value="{$poll.page_id}" />
                <input type="hidden" name="redirect_url" value="{$config.current_url}" />
                <input type="hidden" name="obj_prefix" value="{$block.block_id}" />

                {if $poll.questions}
                    {foreach from=$poll.questions item="question"}
                    <div class="poll">
                        <h4 class="poll-header">
                            {$question.description}{if $question.required == "Y"} <span class="poll-required-question">*</span>{/if}
                        </h4>
                        {if $question.type == "T"}
                            <textarea name="answer_text[{$question.item_id}]" class="form-control"></textarea>
                        {else}
                            <ul class="list-unstyled poll-list">
                                {foreach from=$question.answers item="answer"}
                                    <li class="poll-list-item">
                                        <div class="{if $question.type == "Q"}radio{else if $question.type == "M"}checkbox{/if}">
                                            <label for="var_{$block.block_id}_{$answer.item_id}">
                                            {if $question.type == "Q"}
                                                <input type="radio" id="var_{$block.block_id}_{$answer.item_id}" name="answer[{$question.item_id}]" value="{$answer.item_id}" />
                                            {else}
                                                <input type="checkbox" id="var_{$block.block_id}_{$answer.item_id}" name="answer[{$question.item_id}][{$answer.item_id}]" value="Y" />
                                            {/if}
                                            {$answer.description}</label>
                                            {if $answer.type == "O"}
                                                <input type="text" name="answer_more[{$question.item_id}][{$answer.item_id}]" class="form-control poll-list-input" value="" />
                                            {/if}
                                        </div>
                                    </li>
                                {/foreach}
                            </ul>
                        {/if}
                    </div>
                    {/foreach}
                {/if}

                {if $poll.footer}<div class="polls-footer">{$poll.footer nofilter}</div>{/if}
                
                {include file="common/image_verification.tpl" option="polls"}

                <div class=" buttons-conrainer">
                    {if $poll.show_results == "E"}
                        {include file="addons/polls/views/pages/components/poll_results_link.tpl" }
                    {/if}
                    {include file="common/button.tpl" text=__("submit") name="dispatch[pages.poll_submit]" meta="btn-primary"}
                </div>
            </form>
        </div>
    {/if}
    </div>
{/if}
{/foreach}
</div>
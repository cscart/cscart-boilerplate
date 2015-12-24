<div class="polls">
{if $poll.completed || ($poll.show_results == "E" && $smarty.request.action == "results")}
    {if $poll.show_results == "N"}
        <p>{__("text_you_have_already_filled_this_poll")}</p>
        {if $poll.results}<p>{$poll.results nofilter}</p>{/if}
    {else}
        {if $poll.results}
            <p>{$poll.results nofilter}</p>
        {/if}
        {if $poll.questions}
            <div class="polls-results">
                {foreach from=$poll.questions item="question"}
                    <div class="polls-results-item">
                        <h3 class="poll-header">{$question.description}</h3>
                        {if $question.type == "T"}
                            <div class="poll-txt-answer">{__("polls_answers_with_comments")}</div>
                            {include file="addons/polls/views/pages/components/graph_bar.tpl" value_width=$question.results.ratio color=$_color count=$question.results.count ratio=$question.results.ratio}
                        {else}
                            {foreach from=$question.answers item=answer}
                            {if $answer.results.max_ratio}
                                {assign var="_color" value="1"}
                            {else}
                                {assign var="_color" value=""}
                            {/if}
                                {include file="addons/polls/views/pages/components/graph_bar.tpl" value_width=$answer.results.ratio color=$_color count=$answer.results.count ratio=$answer.results.ratio answer_description=$answer.description}
                            {/foreach}
                        {/if}
                    </div>
                {/foreach}
                <div class="polls-total">{__("polls_total_votes")}: {$poll.summary.total}</div>
            </div>
        {/if}
    {/if}
    {if !$smarty.request.action == "results"}
        <div class="panel panel-default buttons-container">
            <div class="panel-body">
                {include file="common/button.tpl" text=__("continue_shopping") href=""|fn_url}
            </div>
        </div>
    {/if}
{else}
    <form name="{$form_name|default:"main_login_form"}" action="{""|fn_url}" method="post" class="form">
        <input type="hidden" name="page_id" value="{$poll.page_id}" />
        <input type="hidden" name="obj_prefix" value="{$obj_prefix}" />
        <input type="hidden" name="redirect_url" value="{$config.current_url}" />

        {if $poll.has_required_questions}{__("text_mandatory_fields")}{/if}
        
        {if $page.description}<p class="polls-description">{$page.description nofilter}</p>{/if}

        {if $poll.header}<div class="polls-header">{$poll.header nofilter}</div>{/if}

        {if $poll.questions}
            {foreach from=$poll.questions item="question"}
                <div class="poll">
                    <h4 class="poll-header">{$question.description}{if $question.required == "Y"}&nbsp;<span class="poll__required-question">*</span>{/if}</h4>

                    {if $question.type == "T"}
                        <textarea name="answer_text[{$question.item_id}]" class="form-control" cols="81" rows="10"></textarea>
                    {else}

                        <div class="poll-list">
                        {foreach from=$question.answers item="answer"}
                            <div class="{if $question.type == "Q"}radio{else}checkbox{/if}">
                                <label for="var_{$obj_prefix}{$answer.item_id}">
                                {if $question.type == "Q"}
                                    <input type="radio" name="answer[{$question.item_id}]" value="{$answer.item_id}" id="var_{$obj_prefix}{$answer.item_id}" class="radio" />
                                {else}
                                    <input type="checkbox" name="answer[{$question.item_id}][{$answer.item_id}]" value="Y" id="var_{$obj_prefix}{$answer.item_id}" />
                                {/if}
                                {$answer.description}</label>
                                {if $answer.type == "O"}<input type="text" name="answer_more[{$question.item_id}][{$answer.item_id}]" class="form-control" />{/if}
                            </div>
                        {/foreach}
                        </div>
                    {/if}
                </div>
            {/foreach}
        {/if}

        {if $poll.footer}<div class="polls-footer">{$poll.footer nofilter}</div>{/if}

        {include file="common/image_verification.tpl" option="polls"}

        <div class="panel panel-default buttons-container">
            <div class="panel-body">
                {if $poll.show_results == "E"}
                    {include file="addons/polls/views/pages/components/poll_results_link.tpl" }
                {/if}
                {include file="common/button.tpl" text=__("submit") name="dispatch[pages.poll_submit]" }
            </div>
        </div>
    </form>
{/if}
</div>
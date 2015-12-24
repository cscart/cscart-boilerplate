{strip}
<div class="polls-graph">
    <p class="polls-graph-title">{$answer_description}</p>
    <div class="progress">
        <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:  {$value_width|default:"0"}%;">
            {$ratio|default:"0.00"}% ({$count|default:"0"})
        </div>
    </div>
</div>
{/strip}
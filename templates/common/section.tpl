{assign var="id" value=$section_title|md5|string_format:"s_%s"}
{math equation="rand()" assign="rnd"}
{if $smarty.cookies.$id || $collapse}
    {assign var="collapse" value=true}
{else}
    {assign var="collapse" value=false}
{/if}

<div class="search-section panel panel-default {if $class} {$class}{/if}" id="ds_{$rnd}">
    <div class="panel-heading cursor-pointer {if !$collapse}open{/if} cm-combination cm-save-state cm-ss-reverse" id="sw_{$id}">
        <span>{$section_title nofilter}</span>
        <span class="search-section-switch pull-right">
        	<i class="switch-icon glyphicon glyphicon-triangle-bottom fa fa-caret-down"></i>
        </span>
    </div>
    
    <div id="{$id}" class="panel-body {$section_body_class} {if $collapse}hidden{/if}">
    	{$section_content nofilter}
    </div>
</div>
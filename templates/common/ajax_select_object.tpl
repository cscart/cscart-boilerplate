{if $label}
    <label class="select-object-title">{$label}</label>
{/if}

<div class="btn-group select-object">
    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <span id="sw_{$id}_wrap_" class="cm-combination">{$text}</span>
        <span class="caret"></span>
    </button>
    <ul class="dropdown-menu">
        <li>
            <div class="form">
                <input type="text" value="{__("search")}..." class="form-control cm-hint cm-ajax-content-input" data-ca-target-id="content_loader_{$id}" size="16" />
            </div>
        </li>
        <li role="separator" class="divider"></li>
        
        <li>
            <div id="scroller_{$id}">
                <ul class="list-unstyled cm-select-list" id="{$id}">
                    <li class="hidden">&nbsp;</li><!-- hidden li element for successfully html validation -->
                    {foreach from=$objects key="object_id" item="item"}
                        <li class="select-object-link"><a data-ca-action="{$item.value}">{$item.name}</a></li>
                    {/foreach}
                <!--{$id}--></ul>
            </div>
        </li>

        <li id="content_loader_{$id}" class="cm-ajax-content-more small-description" data-ca-target-url="{$data_url|fn_url}" data-ca-target-id="{$id}" data-ca-result-id="{$result_elm}">
            <a href="#">{__("loading")}</a>
        </li>
    </ul>
</div>

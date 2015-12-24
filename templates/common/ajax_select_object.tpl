<div class="select-vendor">
    {if $label}
        <label class="select-vendor-title">{$label}</label>
    {/if}

    <a class="select-block-a">
        <span id="sw_{$id}_wrap_" class="cm-combination">{$text}</span>
        <i class="glyphicon glyphicon-triangle-left fa fa-caret-left"></i>
    </a>

    <div id="{$id}_wrap_" class="select-block cm-popup-box hidden">
        <input type="text" value="{__("search")}..." class="form-control cm-hint cm-ajax-content-input" data-ca-target-id="content_loader_{$id}" size="16" />
        <div id="scroller_{$id}">
            <ul class="list-unstyled cm-select-list" id="{$id}">
                <li class="hidden">&nbsp;</li><!-- hidden li element for successfully html validation -->
                {foreach from=$objects key="object_id" item="item"}
                    <li><a data-ca-action="{$item.value}">{$item.name}</a></li>
                {/foreach}
            <!--{$id}--></ul>
            <ul>
                <li id="content_loader_{$id}" class="cm-ajax-content-more small-description" data-ca-target-url="{$data_url|fn_url}" data-ca-target-id="{$id}" data-ca-result-id="{$result_elm}">{__("loading")}</li>
            </ul>
        </div>
    </div>
</div>
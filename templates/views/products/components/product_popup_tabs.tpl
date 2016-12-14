{capture name="popupsbox"}
    {foreach from=$tabs item="tab" key="tab_id"}
        {if $tab.show_in_popup == "Y" && $tab.status == "A"}
            {assign var="product_tab_id" value="product_tab_`$tab.tab_id`"}
            {assign var="tab_content_capture" value="tab_content_capture_`$tab_id`"}

            {capture name=$tab_content_capture}
                {if $tab.tab_type == 'B'}
                    {render_block block_id=$tab.block_id dispatch="products.view" use_cache=false parse_js=false}
                {elseif $tab.tab_type == 'T'}
                    {include file=$tab.template product_tab_id=$product_tab_id force_ajax=true}
                {/if}
            {/capture}

            {if $smarty.capture.$tab_content_capture|trim}
                <li class="popup-tabs-item">
                    <i class="glyphicon glyphicon-new-window fa fa-external-link-square"></i>
                    <a id="{$tab.html_id}" class="cm-dialog-opener cursor-pointer" data-ca-target-id="content_block_popup_{$tab_id}" rel="nofollow">{$tab.name}</a>
                    <div id="content_block_popup_{$tab_id}" class="hidden" title="{$tab.name}" data-ca-keep-in-place="true">
                        {$smarty.capture.$tab_content_capture nofilter}
                    </div>
                </li>
            {/if}
        {/if}
    {/foreach}
{/capture}

{capture name="popupsbox_content"}
    {if $smarty.capture.popupsbox|trim}
        <ul class="list-inline popup-tabs">
            {$smarty.capture.popupsbox nofilter}
        </ul>
    {/if}
{/capture}
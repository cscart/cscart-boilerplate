{assign var="language_text" value=$text|default:__("select_descr_lang")}

{if $style == "graphic"}
    {if $text}<div class="hidden-xs hidden-sm">{$text}:</div>{/if}
    
    <div class="dropdown">
        <button class="btn btn-default dropdown-toggle" type="button" id="select_{$selected_id}_wrap_{$suffix}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            {$items.$selected_id.$key_name}{if $items.$selected_id.symbol} ({$items.$selected_id.symbol nofilter}){/if}
            <span class="caret"></span>
        </button>
        <ul class="dropdown-menu cm-select-list" aria-labelledby="select_{$selected_id}_wrap_{$suffix}">
            {foreach from=$items item=item key=id}
                <li>
                    <a rel="nofollow" href="{"`$link_tpl``$id`"|fn_url}" class="{if $suffix == "live_editor_box"}cm-lang-link{/if}" {if $display_icons == true}data-ca-country-code="{$item.country_code|lower}"{/if} data-ca-name="{$id}">
                    {$item.$key_name nofilter}{if $item.symbol} ({$item.symbol nofilter}){/if}
                    </a>
                </li>
            {/foreach}
        </ul>
    </div>
{else}
    {if $text}<label for="id_{$var_name}" class="hidden-xs hidden-sm">{$text}:</label>{/if}
    <select id="id_{$var_name}" name="{$var_name}" onchange="Tygh.$.redirect(this.value);">
        {foreach from=$items item=item key=id}
            <option value="{"`$link_tpl``$id`"|fn_url}" {if $id == $selected_id}selected="selected"{/if}>{$item.$key_name nofilter}</option>
        {/foreach}
    </select>
{/if}

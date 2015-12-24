{assign var="language_text" value=$text|default:__("select_descr_lang")}

{if $style == "graphic"}
    {if $text}<div class="ty-select-block__txt hidden-phone hidden-tablet">{$text}:</div>{/if}
    
    <a class="ty-select-block__a cm-combination" id="sw_select_{$selected_id}_wrap_{$suffix}">
        {if $display_icons == true}
            <i class="ty-select-block__a-flag ty-flag ty-flag-{$items.$selected_id.country_code|lower} cm-external-click" data-ca-external-click-id="sw_select_{$selected_id}_wrap_{$suffix}" ></i>
        {/if}
        <span class="ty-select-block__a-item {if $link_class}{$link_class}{/if}">{$items.$selected_id.$key_name}{if $items.$selected_id.symbol} ({$items.$selected_id.symbol nofilter}){/if}</span>
        <i class="ty-select-block__arrow ty-icon-down-micro"></i>
    </a>

    <div id="select_{$selected_id}_wrap_{$suffix}" class="ty-select-block cm-popup-box hidden">
        <ul class="cm-select-list ty-select-block__list ty-flags">
            {foreach from=$items item=item key=id}
                <li class="ty-select-block__list-item">
                    <a rel="nofollow" href="{"`$link_tpl``$id`"|fn_url}" class="ty-select-block__list-a {if $selected_id == $id}is-active{/if} {if $suffix == "live_editor_box"}cm-lang-link{/if}" {if $display_icons == true}data-ca-country-code="{$item.country_code|lower}"{/if} data-ca-name="{$id}">
                    {if $display_icons == true}
                        <i class="ty-flag ty-flag-{$item.country_code|lower}"></i>
                    {/if}
                    {$item.$key_name nofilter}{if $item.symbol} ({$item.symbol nofilter}){/if}
                    </a>
                </li>
            {/foreach}
        </ul>
    </div>
{else}
    {if $text}<label for="id_{$var_name}" class="ty-select-block__txt hidden-phone hidden-tablet">{$text}:</label>{/if}
    <select id="id_{$var_name}" name="{$var_name}" onchange="Tygh.$.redirect(this.value);" class="ty-valign">
        {foreach from=$items item=item key=id}
            <option value="{"`$link_tpl``$id`"|fn_url}" {if $id == $selected_id}selected="selected"{/if}>{$item.$key_name nofilter}</option>
        {/foreach}
    </select>
{/if}

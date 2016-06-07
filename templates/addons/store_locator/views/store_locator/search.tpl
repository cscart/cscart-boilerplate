{assign var="map_provider" value=$addons.store_locator.map_provider}
{assign var="map_provider_api" value="`$map_provider`_map_api"}
{assign var="map_customer_templates" value="C"|fn_get_store_locator_map_templates}
{assign var="map_container" value="map_canvas"}

{if $store_locations}
    {if $map_customer_templates && $map_customer_templates.$map_provider}
        {include file=$map_customer_templates.$map_provider}
    {/if}
    <div class="store-location row">
        <div class="store-location-map-wrapper col-lg-8 col-md-8 col-sm-8" id="{$map_container}"></div>
        <div class="wysiwyg-content store-location-locations-wrapper col-lg-4 col-md-4 col-sm-4">
            <div class="list-group" id="stores_list_box">
            {foreach from=$store_locations item=loc key=num name="locations"}
                <a href="#map_canvas" class="list-group-item cm-map-view-location cm-scroll {if $smarty.foreach.locations.first}active{/if}" id="loc_{$loc.store_location_id}" data-ca-latitude={$loc.latitude} data-ca-longitude={$loc.longitude}>
                    {if $loc.city || $loc.country_title}
                        <span class="store-location-country badge">{if $loc.city}{$loc.city}, {/if}{$loc.country_title}</span>
                    {/if}
                    <p class="lead"><strong>{$loc.name}</strong></p>
                    <div class="store-location-desc">{$loc.description nofilter}</div>
                </a>
            {/foreach}
            {if $store_locations|count > 0}
                <a href="#map_canvas" class="list-group-item cm-map-view-locations cm-scroll">{__("all_stores")}</a>
            {/if}
            </div>
        </div>
    </div>

    <script>
    (function ($, _) {
        $('#stores_list_box a').on('click', function() {
            $(this).addClass('active').siblings('a').removeClass('active');
        });
    })($, Tygh.$); 
    </script>
{else}
    <p class="well well-lg">{__("no_data")}</p>
{/if}

{capture name="mainbox_title"}{__("store_locator")}{/capture}
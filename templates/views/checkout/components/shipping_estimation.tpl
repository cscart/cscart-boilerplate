
{if $location == "sidebox"}
    {assign var="prefix" value="sidebox_"}
{/if}
{if $location == "popup"}
    {assign var="buttons_class" value="hidden"}
{else}
    {assign var="buttons_class" value="buttons-container"}
{/if}
{if $additional_id}
    {assign var="class_suffix" value="-`$additional_id`"}
    {assign var="id_suffix" value="_`$additional_id`"}
{/if}

{if !$cart}
    {$cart = $smarty.session.cart}
{/if}
{if $location != "sidebox" && $location != "popup"}

<div id="est_box{$id_suffix}" class="panel panel-default">
    <div class="panel-header">
    <h3>{__("calculate_shipping_cost")}</h3>
{/if}
    
        <div class="panel-body" id="shipping_estimation{if $location == "sidebox"}_sidebox{/if}{$id_suffix}">

            {$states = 1|fn_get_all_states}
            {if !$smarty.capture.states_built}
                {include file="views/profiles/components/profiles_scripts.tpl" states=$states}
                {capture name="states_built"}Y{/capture}
            {/if}

            <form class="cm-ajax" name="{$prefix}estimation_form{$id_suffix}" action="{""|fn_url}" method="post">
                {if $location == "sidebox"}<input type="hidden" name="location" value="sidebox" />{/if}
                {if $additional_id}<input type="hidden" name="additional_id" value="{$additional_id}" />{/if}
                <input type="hidden" name="result_ids" value="shipping_estimation{if $location == "sidebox"}_sidebox{/if}{$id_suffix},shipping_estimation_buttons" />

                {hook name="checkout:shipping_estimation_fields"}
                <div class="form-group">
                    <label for="{$prefix}elm_country{$id_suffix}" class="control-label">{__("country")}</label>
                    <select id="{$prefix}elm_country{$id_suffix}" class="cm-country cm-location-estimation{$class_suffix} form-control" name="customer_location[country]">
                        <option value="">- {__("select_country")} -</option>
                        {assign var="countries" value=1|fn_get_simple_countries}
                        {foreach from=$countries item="country" key="code"}
                        <option value="{$code}" {if ($cart.user_data.s_country == $code) || (!$cart.user_data.s_country && $code == $settings.General.default_country)}selected="selected"{/if}>{$country}</option>
                        {/foreach}
                    </select>
                </div>

                {$_state = $cart.user_data.s_state}

                {if $_state|fn_is_empty}
                    {$_state = $settings.General.default_state}
                {/if}


                <div class="form-group">
                    <label for="{$prefix}elm_state{$id_suffix}" class="control-label">{__("state")}</label>
                    <select class="cm-state cm-location-estimation{$class_suffix} {if !$states[$cart.user_data.s_country]}hidden{/if} form-control" id="{$prefix}elm_state{$id_suffix}" name="customer_location[state]">
                        <option value="">- {__("select_state")} -</option>
                        {foreach $states[$cart.user_data.s_country] as $state}
                            <option value="{$state.code}" {if $state.code == $_state}selected="selected"{/if}>{$state.state}</option>
                        {foreachelse}
                            <option label="" value="">- {__("select_state")} -</option>
                        {/foreach}
                    </select>
                    <input type="text" class="cm-state cm-location-estimation{$class_suffix}  {if $states[$cart.user_data.s_country]}hidden{/if} form-control" id="{$prefix}elm_state{$id_suffix}_d" name="customer_location[state]" size="20" maxlength="64" value="{$_state}" {if $states[$cart.user_data.s_country]}disabled="disabled"{/if} />
                </div>

                <div class="form-group">
                    <label for="{$prefix}elm_city{$id_suffix}" class="control-label">{__("city")}</label>
                    <input type="text" class="form-control" id="{$prefix}elm_city{$id_suffix}" name="customer_location[city]" size="32" value="{$cart.user_data.s_city}" />
                </div>

                <div class="form-group">
                    <label for="{$prefix}elm_zipcode{$id_suffix}" class="control-label">{__("zip_postal_code")}</label>
                    <input type="text" class="form-control" id="{$prefix}elm_zipcode{$id_suffix}" name="customer_location[zipcode]" size="20" value="{$cart.user_data.s_zipcode}" />
                </div>
                {/hook}
                
                <div class="{$buttons_class}">
                    {include file="common/button.tpl" text=__("get_rates") name="dispatch[checkout.shipping_estimation]" id="but_get_rates" as="link"}
                </div>

            </form>
            {if $runtime.mode == "shipping_estimation" || $smarty.request.show_shippings == "Y"}
                {if !$cart.shipping_failed && !$cart.company_shipping_failed}
                    {if $location == "popup"}
                        <h4>{__("select_shipping_method")}</h4>
                    {/if}
                    <form class="cm-ajax" name="{$prefix}select_shipping_form{$id_suffix}" action="{""|fn_url}" method="post">
                    <input type="hidden" name="redirect_mode" value="cart" />
                    <input type="hidden" name="result_ids" value="checkout_totals" />

                    {hook name="checkout:shipping_estimation"}

                    {foreach from=$product_groups key=group_key item=group name="s"}
                        <p>
                        <strong>{__("vendor")}:&nbsp;</strong>{$group.name|default:__("none")}
                        </p>
                        {if !"ULTIMATE"|fn_allowed_for || $product_groups|count > 1}
                            <ul class="list-unstyled">
                            {foreach from=$group.products item="product"}
                                <li>
                                    {if $product.product}
                                        {$product.product nofilter}
                                    {else}
                                        {$product.product_id|fn_get_product_name}
                                    {/if}
                                </li>
                            {/foreach}
                            </ul>
                        {/if}

                        {if $group.shippings && !$group.all_edp_free_shipping && !$group.shipping_no_required}
                            {foreach from=$group.shippings item="shipping" name="estimate_group_shipping"}
                                {if !$show_only_first_shipping || $smarty.foreach.estimate_group_shipping.first}
                                
                                    {if $cart.chosen_shipping.$group_key == $shipping.shipping_id}
                                        {assign var="checked" value="checked=\"checked\""}
                                    {else}
                                        {assign var="checked" value=""}
                                    {/if}

                                    {if $shipping.delivery_time}
                                        {assign var="delivery_time" value="(`$shipping.delivery_time`)"}
                                    {else}
                                        {assign var="delivery_time" value=""}
                                    {/if}

                                    {hook name="checkout:shipping_estimation_method"}
                                    {if $shipping.rate}
                                        {capture assign="rate"}{include file="common/price.tpl" value=$shipping.rate}{/capture}
                                        {if $shipping.inc_tax}
                                            {assign var="rate" value="`$rate` ("}
                                            {if $shipping.taxed_price && $shipping.taxed_price != $shipping.rate}
                                                {capture assign="tax"}{include file="common/price.tpl" value=$shipping.taxed_price }{/capture}
                                                {assign var="rate" value="`$rate` (`$tax` "}
                                            {/if}
                                            {assign var="inc_tax_lang" value=__('inc_tax')}
                                            {assign var="rate" value="`$rate``$inc_tax_lang`)"}
                                        {/if}
                                    {else}
                                        {assign var="rate" value=__("free_shipping")}
                                    {/if}

                                    <div class="radio">
                                        <label for="sh_{$group_key}_{$shipping.shipping_id}">
                                            <input
                                                type="radio"
                                                id="sh_{$group_key}_{$shipping.shipping_id}"
                                                name="shipping_ids[{$group_key}]"
                                                value="{$shipping.shipping_id}"
                                                onclick="fn_calculate_total_shipping();" {$checked}
                                            />
                                            {$shipping.shipping} {$delivery_time}
                                            {if $rate !== "_free_shipping"} {$rate nofilter}{/if}
                                        </label>
                                    </div>
                                    {/hook}
                                {/if}
                            {/foreach}

                        {else}
                            {if $group.all_edp_free_shipping || $group.shipping_no_required}
                                <p>{__("no_shipping_required")}</p>
                            {elseif $group.all_free_shipping || $group.free_shipping}
                                <p>{__("free_shipping")}</p>
                            {else}
                                <p>{__("text_no_shipping_methods")}</p>
                            {/if}
                        {/if}

                    {/foreach}
                    <div id="shipping_estimation_total">
                        <p><strong>{__("total")}:</strong>&nbsp;{include file="common/price.tpl" value=$cart.display_shipping_cost }</p>
                    <!--shipping_estimation_total--></div>
                    {/hook}

                    <div class="{$buttons_class}">
                        {include file="common/button.tpl" text=__("select") as="link" name="dispatch[checkout.update_shipping]" id="but_select_shipping" meta="cm-dialog-closer"}
                    </div>

                    </form>
                {else}
                    {__("text_no_shipping_methods")}
                {/if}

            {/if}
        <!--shipping_estimation{if $location == "sidebox"}_sidebox{/if}{$id_suffix}--></div>

{if $location != "sidebox" && $location != "popup"}
    </div>
</div>
{/if}

{if $location == "popup"}
<div class="panel-footer col-lg-12 buttons-container" id="shipping_estimation_buttons">
    {if $runtime.mode == "shipping_estimation" || $smarty.request.show_shippings == "Y"}
        {include file="common/button.tpl" text=__("recalculate_rates") external_click_id="but_get_rates" meta="btn-default cm-external-click" as="link"}
        <br>
        {include file="common/button.tpl" text=__("select_shipping_method") external_click_id="but_select_shipping" meta="btn-default cm-external-click cm-dialog-closer" as="link"}
    {else}
        {include file="common/button.tpl" text=__("get_rates") external_click_id="but_get_rates" meta="btn-default cm-external-click" as="link"}
    {/if}
<!--shipping_estimation_buttons--></div>
{/if}

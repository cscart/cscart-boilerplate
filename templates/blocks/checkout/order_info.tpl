{if $completed_steps.step_two}
    <ul class="list-unstyled order-info-list">
        {assign var="profile_fields" value="I"|fn_get_profile_fields}
        {if $profile_fields.B}
            <li>
                <strong>{__("billing_address")}:</strong>
                <div id="tygh_billing_adress" class="">
                    {foreach from=$profile_fields.B item="field"}
                        {assign var="value" value=$cart.user_data|fn_get_profile_field_value:$field}
                        {if $value}
                            <span class="{$field.field_name|replace:"_":"-"}">{$value}</span>
                        {/if}
                    {/foreach}
                </div>
            </li>
        {/if}

        {if $profile_fields.S}
            <li>
                <strong>{__("shipping_address")}:</strong>
                <div id="tygh_shipping_adress" class="list-unstyled">
                    {foreach from=$profile_fields.S item="field"}
                        {assign var="value" value=$cart.user_data|fn_get_profile_field_value:$field}
                        {if $value}
                            <span class="{$field.field_name|replace:"_":"-"}">{$value}</span>
                        {/if}
                    {/foreach}
                </div>
            </li>
        {/if}
        
        {if !$cart.shipping_failed && !empty($cart.chosen_shipping) && $cart.shipping_required}
            <li>
                <strong>{__("shipping_method")}:</strong>
                <div id="tygh_shipping_method" class="list-unstyled">
                    {foreach from=$cart.chosen_shipping key="group_key" item="shipping_id"}
                        <p>{$product_groups[$group_key].shippings[$shipping_id].shipping}</p>
                    {/foreach}
                </div>
            </li>
        {/if}
    </ul>
{/if}
{assign var="block_wrap" value="checkout_order_info_`$block.snapping_id`_wrap" scope="parent"}

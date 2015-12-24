<h3>{__("customer_information")}</h3>

{assign var="profile_fields" value=$location|fn_get_profile_fields}
{$contact_fields = $profile_fields.C}

<div class="profiles-info row">
    {if $profile_fields.B}
        <div id="tygh_order_billing_adress" class="profiles-info-billing col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <h4>{__("billing_address")}</h4>
            <div class="profiles-info-field">{include file="views/profiles/components/profile_fields_info.tpl" fields=$profile_fields.B title=__("billing_address")}</div>
        </div>
    {/if}
    {if $profile_fields.S}
        <div id="tygh_order_shipping_adress" class="profiles-info-shipping col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <h4>{__("shipping_address")}</h4>
            <div class="profiles-info-field">{include file="views/profiles/components/profile_fields_info.tpl" fields=$profile_fields.S title=__("shipping_address")}</div>
        </div>
    {/if}
    {if $contact_fields}
        <div class="profiles-info-item">
            {capture name="contact_information"}
                {include file="views/profiles/components/profile_fields_info.tpl" fields=$contact_fields title=__("contact_information")}
            {/capture}
            {if $smarty.capture.contact_information|trim != ""}
                <h5 class="profiles-info-title">{__("contact_information")}</h5>
                <div class="profiles-info-field">{$smarty.capture.contact_information nofilter}</div>
            {/if}
        </div>
    {/if}
</div>

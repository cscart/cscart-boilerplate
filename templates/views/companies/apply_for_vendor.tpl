{hook name="vendors:apply_page"}
<div class="apply-for-vendor">
    {include file="views/profiles/components/profiles_scripts.tpl"}

    <h2>{__("apply_for_vendor_account")}</h2>

    <div id="apply_for_vendor_account" > {* content detailed *}

        <form action="{"companies.apply_for_vendor"|fn_url}" method="post" name="apply_for_vendor_form">
            {hook name="vendors:apply_fields"}
            
            <div class="form-group">
                <label for="company_description_company" class="control-label cm-required">{__("company")}</label>
                <input type="text" name="company_data[company]" id="company_description_company" size="32" value="{$company_data.company}" class="form-control cm-focus" />
            </div>

            <div class="form-group">
                <label for="company_description">{__("description")}</label>
                <textarea id="company_description" name="company_data[company_description]" cols="55" rows="5" class="form-control">{$company_data.company_description}</textarea>
            </div>

            {if $languages|count > 1}
            <div class="form-group">
                <label class="control-label" for="company_language">{__("language")}</label>
                <select name="company_data[lang_code]" id="company_language" class="form-control">
                    {foreach from=$languages item="language" key="lang_code"}
                        <option value="{$lang_code}" {if $lang_code == $company_data.lang_code}selected="selected"{/if}>{$language.name}</option>
                    {/foreach}
                </select>
            </div>
            {else}
            <input type="hidden" name="company_data[lang_code]" value="{$languages|key}" />
            {/if}

            {if !$auth.user_id && $settings.Vendors.create_vendor_administrator_account == "Y"}

                {literal}
                <script type="text/javascript">

                function fn_toggle_required_fields() {
                    var $ = Tygh.$;
                    var f = $('#company_admin_firstname');
                    var l = $('#company_admin_lastname');
                    var flag = ($('#company_request_account_name').val() == '');

                    f.prop('disabled', flag).toggleClass('disabled', flag);
                    l.prop('disabled', flag).toggleClass('disabled', flag);

                    $('.cm-profile-field').each(function(index) {
                        var elm = $('#' + $(this).prop('for'));
                        if (elm.children() != null) {
                            // Traverse subitems
                            $('.' + $(this).prop('for')).prop('disabled', flag).toggleClass('disabled', flag);
                        }
                        elm.prop('disabled', flag).toggleClass('disabled', flag);
                    });
                }
                </script>
                {/literal}

                {assign var="disabled_by_default" value=false}
                <div class="form-group" id="company_description_admin_firstname">
                    <label for="company_admin_firstname" class="cm-required control-label">{__("first_name")}</label>
                    <input type="text" name="company_data[admin_firstname]" id="company_admin_firstname" size="32" value="{$company_data.admin_firstname}" class="form-control" />
                </div>
                <div class="form-group" id="company_description_admin_lastname">
                    <label for="company_admin_lastname" class="cm-required control-label">{__("last_name")}</label>
                    <input type="text" name="company_data[admin_lastname]" id="company_admin_lastname" size="32" value="{$company_data.admin_lastname}" class="form-control" />
                </div>

            {/if}

            {if !$auth.user_id}
                {include file="views/profiles/components/profile_fields.tpl" section="C" title=__("contact_information") disabled_by_default=$disabled_by_default}
            {else}
                <h3>{__("contact_information")}</h3>
            {/if}

            <div class="form-group">
                <label for="company_description_email" class="cm-required cm-email cm-trim control-label">{__("email")}</label>
                <input type="text" name="company_data[email]" id="company_description_email" size="32" value="{$company_data.email}" class="form-control" />
            </div>

            <div class="form-group">
                <label for="company_description_phone" class="cm-required control-label">{__("phone")}</label>
                <input type="text" name="company_data[phone]" id="company_description_phone" size="32" value="{$company_data.phone}" class="form-control" />
            </div>

            <div class="form-group">
                <label for="company_description_url" class="control-label">{__("url")}</label>
                <input type="text" name="company_data[url]" id="company_description_url" size="32" value="{$company_data.url}" class="form-control" />
            </div>

            <div class="form-group">
                <label for="company_description_fax" class="control-label">{__("fax")}</label>
                <input type="text" name="company_data[fax]" id="company_description_fax" size="32" value="{$company_data.fax}" class="form-control" />
            </div>


            {if !$auth.user_id}
                {include file="views/profiles/components/profile_fields.tpl" section="B" title=__("shipping_address") shipping_flag=false disabled_by_default=$disabled_by_default}
            {else}
                <h3>{__("shipping_address")}</h3>
            {/if}

            <div class="form-group">
                <label class="cm-required control-label" for="company_address_address">{__("address")}</label>
                <input type="text" name="company_data[address]" id="company_address_address" size="32" value="{$company_data.address}" class="form-control" />
            </div>

            <div class="form-group">
                <label class="cm-required control-label" for="company_address_city">{__("city")}</label>
                <input type="text" name="company_data[city]" id="company_address_city" size="32" value="{$company_data.city}" class="form-control" />
            </div>

            <div class="form-group shipping-country">
                <label for="company_address_country" class="cm-required control-label">{__("country")}</label>
                {assign var="_country" value=$company_data.country|default:$settings.General.default_country}
                <select class="cm-country cm-location-shipping form-control" id="company_address_country" name="company_data[country]">
                    <option value="">- {__("select_country")} -</option>
                    {foreach from=$countries item="country" key="code"}
                    <option {if $_country == $code}selected="selected"{/if} value="{$code}">{$country}</option>
                    {/foreach}
                </select>
            </div>

            {$_country = $company_data.country|default:$settings.General.default_country}
            {$_state = $company_data.state|default:$settings.General.default_state}

            <div class="form-group shipping-state">
                <label for="company_address_state" class="cm-required control-label">{__("state")}</label>
                <select id="company_address_state" name="company_data[state]" class="cm-state cm-location-shipping {if !$states.$_country}hidden{/if} form-control">
                    <option value="">- {__("select_state")} -</option>
                    {if $states && $states.$_country}
                        {foreach from=$states.$_country item=state}
                            <option {if $_state == $state.code}selected="selected"{/if} value="{$state.code}">{$state.state}</option>
                        {/foreach}
                    {/if}
                </select>
                <input type="text" id="company_address_state_d" name="company_data[state]" size="32" maxlength="64" value="{$_state}" {if $states.$_country}disabled="disabled"{/if} class="cm-state cm-location-shipping form-control {if $states.$_country}hidden{/if} cm-skip-avail-switch " />
            </div>

            <div class="form-group shipping-zip-code">
                <label for="company_address_zipcode" class="cm-required cm-zipcode cm-location-shipping control-label">{__("zip_postal_code")}</label>
                <input type="text" name="company_data[zipcode]" id="company_address_zipcode" size="32" value="{$company_data.zipcode}" class="form-control" />
            </div>
            {/hook}

            {include file="common/image_verification.tpl" option="apply_for_vendor_account" align="left"}

            <div class="buttons-container">
                {include file="common/button.tpl" text=__("submit") name="dispatch[companies.apply_for_vendor]" id="but_apply_for_vendor" meta="btn-primary"}
            </div>
        </form>
    </div>
</div>{* /apply_for_vendor_account *}
{/hook}
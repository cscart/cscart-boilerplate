{if "MULTIVENDOR"|fn_allowed_for && ($company_name || $company_id) && $settings.Vendors.display_vendor == "Y"}
    <div class="form-group{if !$capture_options_vs_qty} product-list-field{/if}">
        <label class="control-label">{__("vendor")}:</label>
        <a href="{"companies.products?company_id=`$company_id`"|fn_url}">{if $company_name}{$company_name}{else}{$company_id|fn_get_company_name}{/if}</a>
    </div>
{/if}

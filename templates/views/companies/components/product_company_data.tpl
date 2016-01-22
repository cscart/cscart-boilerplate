{if "MULTIVENDOR"|fn_allowed_for && ($company_name || $company_id) && $settings.Vendors.display_vendor == "Y"}
    <div class="form-group{if !$capture_options_vs_qty} product-list-field{/if} row clearfix">
        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5">
            <label class="control-label">{__("vendor")}:</label>
        </div>
        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-7">
            <a href="{"companies.products?company_id=`$company_id`"|fn_url}">{if $company_name}{$company_name}{else}{$company_id|fn_get_company_name}{/if}</a>
        </div>
    </div>
{/if}

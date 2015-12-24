{hook name="companies:view"}

{assign var="obj_id" value=$company_data.company_id}
{assign var="obj_id_prefix" value="`$obj_prefix``$obj_id`"}
    {include file="common/company_data.tpl" company=$company_data show_name=true show_descr=true show_rating=true show_logo=true hide_links=true}
    <div class="company-detail">
        <div id="block_company_{$company_data.company_id}" class="clearfix">
            <h2>{$company_data.company}</h2>

            <div class="actions">
                {hook name="companies:top_links"}
                    <a class="btn btn-default" href="{"companies.products?company_id=`$company_data.company_id`"|fn_url}">
                        {__("view_vendor_products")} ({$company_data.total_products} {__("items")})
                    </a>
                {/hook}
            </div>
            <div class="company-detail-info row">
                <div class="logo col-lg-2 col-md-2 col-sm-2">
                    <div class="thumbnail">
                        {assign var="capture_name" value="logo_`$obj_id`"}
                        {$smarty.capture.$capture_name nofilter}
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3">
                    <h4 class="company-detail-info-title">{__("contact_information")}</h4>
                    <ul class="list-unstyled">
                        {if $company_data.email}
                            <li>
                                <strong>{__("email")}:</strong>
                                <a href="mailto:{$company_data.email}">{$company_data.email}</a>
                            </li>
                        {/if}
                        {if $company_data.phone}
                            <li>
                                <strong>{__("phone")}:</strong>
                                <span>{$company_data.phone}</span>
                            </li>
                        {/if}
                        {if $company_data.fax}
                            <li>
                                <strong>{__("fax")}:</strong>
                                <span>{$company_data.fax}</span>
                            </li>
                        {/if}
                        {if $company_data.url}
                            <li>
                                <strong>{__("website")}:</strong>
                                <a href="{$company_data.url}">{$company_data.url}</a>
                            </li>
                        {/if}
                    </ul>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3">
                    <h4 class="company-detail-info-title">{__("shipping_address")}</h4>
                    <ul class="list-unstyled">
                        <li>
                            <span>{$company_data.address}</span>
                        </li>
                        <li>
                            <span>{$company_data.city}
                            , {$company_data.state|fn_get_state_name:$company_data.country} {$company_data.zipcode}</span>
                        </li>
                        <li>
                            <span>{$company_data.country|fn_get_country_name}</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        {capture name="tabsbox"}
            <div id="content_description" class="{if $selected_section && $selected_section != "description"}hidden{/if} tab-pane">
                {if $company_data.company_description}
                    <div class="wysiwyg-content">
                        {$company_data.company_description nofilter}
                    </div>
                {/if}
            </div>
            {hook name="companies:tabs"}
            {/hook}
        {/capture}

    </div>
    {include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section}
{/hook}
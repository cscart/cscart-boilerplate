{hook name="suppliers:view"}

{include file="common/company_data.tpl" company=$supplier show_name=true show_descr=true show_rating=true show_logo=true hide_links=true}

<div class="company-detail">

    <div id="block_company_{$supplier.supplier_id}">
        <div class="page-header">
            <h2>{$supplier.name}</h2>            
        </div>

        {hook name="suppliers:top_links"}
            <div id="company_products">
                <a href="{"products.search?supplier_id=`$supplier.supplier_id`&search_performed=Y"|fn_url}" class="btn btn-default">{__("view_supplier_products")} <strong>({$supplier.products|count} {__("items")})</strong></a>
            </div>
            <br>
        {/hook}

        <div class="company-page-info row">
            <div class="col-lg-4">
                <h4>{__("contact_information")}</h5>
                <ul class="list-unstyled company-page-info-contact">
                {if $supplier.email}
                    <li id="supplier_email">
                        <strong>{__("email")}:</strong>
                        <span><a href="mailto:{$supplier.email}">{$supplier.email}</a></span>
                    </li>
                {/if}
                {if $supplier.phone}
                    <li id="supplier_phone">
                        <strong>{__("phone")}:</strong>
                        <span>{$supplier.phone}</span>
                    </li>
                {/if}
                {if $supplier.fax}
                    <li id="supplier_phone">
                        <strong>{__("fax")}:</strong>
                        <span>{$supplier.fax}</span>
                    </li>
                {/if}
                {if $supplier.url}
                    <li id="supplier_website">
                        <strong>{__("website")}:</strong>
                        <span><a href="{$supplier.url}">{$supplier.url}</a></span>
                    </li>
                {/if}
                </ul>
            </div>
            <div class="col-lg-4 ">
                <h4>{__("shipping_address")}</h4>
                <ul class="list-unstyled company-page-info-shipping">
                    <li><span>{$supplier.address}</span></li>
                    <li><span>{$supplier.city}, {$supplier.state|fn_get_state_name:$supplier.country} {$supplier.zipcode}</span></li>
                    <li><span>{$supplier.country|fn_get_country_name}</span></li>
                </ul>
            </div>
        </div>

    </div>
</div>

{capture name="tabsbox"}

{hook name="suppliers:tabs"}
{/hook}

{/capture}
{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section}

{/hook}
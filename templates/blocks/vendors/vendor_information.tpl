{** block-description:block_vendor_information **}

<p class="vendor-information">
    <a href="{"companies.view?company_id=`$vendor_info.company_id`"|fn_url}">{$vendor_info.company}</a>
    {$vendor_info.company_description nofilter}
</p>
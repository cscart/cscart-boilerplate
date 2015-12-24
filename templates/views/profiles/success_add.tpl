{capture name="mainbox_title"}{__("successfully_registered")}{/capture}

<span class="success-registration-text">{__("success_registration_text")}</span>
<ul class="success-registration-list">
    {hook name="profiles:success_registration"}
        <li>
            <a href="{"profiles.update"|fn_url}" class="success-registration-a" rel="nofollow">{__("edit_profile")}</a>
            <span class="success-registration-info">{__("edit_profile_note")}</span>
        </li>
        <li>
            <a href="{"orders.search"|fn_url}" class="success-registration-a">{__("orders")}</a>
            <span class="success-registration-info">{__("track_orders")}</span>
        </li>
        <li>
            <a href="{"product_features.compare"|fn_url}" class="success-registration-a">{__("product_comparison_list")}</a>
            <span class="success-registration-info">{__("comparison_list_note")}</span>
        </li>
    {/hook}
</ul>

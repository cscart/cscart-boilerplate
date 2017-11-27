{** block-description:my_account **}
<div class="dropdown account-dropdown">
    <span class="btn btn-default dropdown-toggle" id="my_account_{$block.snapping_id}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
        <i class="glyphicon glyphicon-user fa fa-user"></i>&nbsp;
        <span {live_edit name="block:name:{$block.block_id}"}>{$title}</span>
        <span class="caret"></span>
    </span>

    <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="my_account_{$block.snapping_id}" id="account_info_{$block.snapping_id}">
        {assign var="return_current_url" value=$config.current_url|escape:url}
        {hook name="profiles:my_account_menu"}
            {if $auth.user_id}
                {if $user_info.firstname || $user_info.lastname}
                    <li class="dropdown-header">{$user_info.firstname} {$user_info.lastname}</li>
                {else}
                    <li class="dropdown-header">{$user_info.email}</li>
                {/if}
                <li role="separator" class="divider"></li>
                <li><a href="{"profiles.update"|fn_url}" rel="nofollow" >{__("profile_details")}</a></li>
                {if $settings.General.enable_edp == "Y"}
                <li><a href="{"orders.downloads"|fn_url}" rel="nofollow">{__("downloads")}</a></li>
                {/if}
            {elseif $user_data.firstname || $user_data.lastname}
                <li>{$user_data.firstname} {$user_data.lastname}</li>
            {elseif $user_data.email}
                <li>{$user_data.email}</li>
            {/if}
            <li><a href="{"orders.search"|fn_url}" rel="nofollow">{__("orders")}</a></li>
            {assign var="compared_products" value=""|fn_get_comparison_products}
            <li><a href="{"product_features.compare"|fn_url}" rel="nofollow">{__("view_comparison_list")}{if $compared_products} ({$compared_products|count}){/if}</a></li>
        {/hook}

        {if "MULTIVENDOR"|fn_allowed_for && $settings.Vendors.apply_for_vendor == "Y" && !$user_info.company_id}
            <li><a href="{"companies.apply_for_vendor?return_previous_url=`$return_current_url`"|fn_url}" rel="nofollow">{__("apply_for_vendor_account")}</a></li>
        {/if}

        {if $settings.Appearance.display_track_orders == 'Y'}
            <li role="separator" class="divider"></li>
            <li id="track_orders_block_{$block.snapping_id}">
                <form action="{""|fn_url}" method="POST" class="cm-ajax cm-post cm-ajax-full-render" name="track_order_quick">
                    <div class="form">
                        <input type="hidden" name="result_ids" value="track_orders_block_*" />
                        <input type="hidden" name="return_url" value="{$smarty.request.return_url|default:$config.current_url}" />
                        <label for="track_order_item{$block.snapping_id}" class="cm-required control-label">{__("track_my_order")}</label>
                        <div class="input-group">
                            <input type="text" size="20" class="form-control cm-hint" id="track_order_item{$block.snapping_id}" name="track_data" placeholder="{__("order_id")}{if !$auth.user_id}/{__("email")}{/if}" />
                            {include file="common/go.tpl" name="orders.track_request" alt=__("go")}
                        </div>
                    </div>
                    <div class="form">
                        {include file="common/image_verification.tpl" option="track_orders" align="left" sidebox=true}
                    </div>
                </form>
            <!--track_orders_block_{$block.snapping_id}--></li>
            <li role="separator" class="divider"></li>
        {/if}

        <li>
            <div class="buttons">
            {if $auth.user_id}
                <a href="{"auth.logout?redirect_url=`$return_current_url`"|fn_url}" rel="nofollow" class="btn btn-danger btn-block">{__("sign_out")}</a>
            {else}
                <a href="{if $runtime.controller == "auth" && $runtime.mode == "login_form"}{$config.current_url|fn_url}{else}{"auth.login_form?return_url=`$return_current_url`"|fn_url}{/if}" {if $settings.Security.secure_storefront != "partial"} data-ca-target-id="login_block{$block.snapping_id}" class="cm-dialog-opener cm-dialog-auto-size btn btn-default btn-sm"{else} class="btn btn-default btn-sm"{/if} rel="nofollow">{__("sign_in")}</a> <a href="{"profiles.add"|fn_url}" rel="nofollow" class="btn btn-success btn-sm">{__("register")}</a>
                {if $settings.Security.secure_storefront != "partial"}
                    <div  id="login_block{$block.snapping_id}" class="hidden" title="{__("sign_in")}">
                        <div>
                            {include file="views/auth/login_form.tpl" style="popup" id="popup`$block.snapping_id`"}
                        </div>
                    </div>
                {/if}
            {/if}
            </div>
        </li>
<!--account_info_{$block.snapping_id}--></ul>
</div>
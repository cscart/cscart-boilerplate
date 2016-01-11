<div id="{$id}">

    <form name="call_requests_form{if !$product}_main{/if}" id="form_{$id}" action="{""|fn_url}" method="post" class="cm-ajax{if !$product} cm-ajax-full-render{/if}" data-ca-product-form="product_form_{$obj_prefix}{$obj_id}">
        <input type="hidden" name="result_ids" value="{$id}" />
        <input type="hidden" name="return_url" value="{$config.current_url}" />

        {if $product}
            <input type="hidden" name="call_data[product_id]" value="{$product.product_id}" />
            <div class="cr-product-info-container">
                <div class="cr-product-info-image">
                    {include file="common/image.tpl" images=$product.main_pair image_width=$settings.Thumbnails.product_cart_thumbnail_width image_height=$settings.Thumbnails.product_cart_thumbnail_height}
                </div>
                <div class="cr-product-info-header">
                    <h3>{$product.product}</h3>
                </div>
            </div>
        {/if}

        <div class="form-group">
            <label class="control-label" for="call_data_{$id}_name">{__("your_name")}</label>
            <input id="call_data_{$id}_name" size="50" class="form-control" type="text" name="call_data[name]" value="{$call_data.name}" />
        </div>

        <div class="form-group">
            <label for="call_data_{$id}_phone" class="control-label cm-cr-mask-phone-lbl{if !$product} cm-required{/if}">{__("phone")}</label>
            <input id="call_data_{$id}_phone" class="form-control cm-cr-mask-phone" size="50" type="text" name="call_data[phone]" value="{$call_data.phone}" />
        </div>

        {if $product}

            <div class="text-center">— {__("or")} —</div>

            <div class="form-group">
                <label for="call_data_{$id}_email" class="control-label cm-email">{__("email")}</label>
                <input id="call_data_{$id}_email" class="form-control" size="50" type="text" name="call_data[email]" value="{$call_data.email}" />
            </div>

            <div class="cr-popup-error-box">
                <p class="cm-cr-error-box text-danger" style="display: none;">
                    {__("call_requests.enter_phone_or_email_text")}
                </p>
            </div>

        {else}

            <div class="form-group">
                <label for="call_data_{$id}_convenient_time_from" class="control-label">{__("call_requests.convenient_time")}</label>
                <div class="form-inline">
                    <input id="call_data_{$id}_convenient_time_from" class="form-control cm-cr-mask-time" size="5" type="text" name="call_data[time_from]" value="" placeholder="{$smarty.const.CALL_REQUESTS_DEFAULT_TIME_FROM}" /> -
                    <input id="call_data_{$id}_convenient_time_to" class="form-control cm-cr-mask-time" size="5" type="text" name="call_data[time_to]" value="" placeholder="{$smarty.const.CALL_REQUESTS_DEFAULT_TIME_TO}" />
                </div>
            </div>

        {/if}

        {include file="common/image_verification.tpl" option="call_request"}

        <div class="buttons-container">
            {include file="common/button.tpl" name="dispatch[call_requests.request]" text=__("submit") meta="btn-primary cm-form-dialog-closer"}
        </div>

    </form>

<!--{$id}--></div>

{capture name="buttons"}
    <div class="pull-right">
        {include file="common/button.tpl" text=__("close") meta="btn-info cm-notification-close"}
    </div>
{/capture}
{capture name="info"}

    <div class="clearfix">
        <br />
        <div class="pull-left"> {__('text_successful_request')}</div>
    </div>
{/capture}
{include file="views/products/components/notification.tpl" product_buttons=$smarty.capture.buttons product_info=$smarty.capture.info}
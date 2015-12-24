{capture name="buttons"}
    <div class="right">
        {include file="common/button.tpl" text=__("continue_shopping") meta="cm-notification-close"}
    </div>
{/capture}

{capture name="info"}
    {$notification_msg nofilter}
{/capture}

{include file="views/products/components/notification.tpl" product_buttons=$smarty.capture.buttons product_info=$smarty.capture.info}

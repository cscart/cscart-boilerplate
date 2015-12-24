{capture name="buttons"}
    <div class="pull-right">
        {include file="common/button.tpl" href="product_features.compare" text=__("view_comparison_list")}
    </div>
{/capture}
{include file="views/products/components/notification.tpl" product_buttons=$smarty.capture.buttons}

{script src="js/tygh/exceptions.js"}
{script src="js/tygh/checkout.js"}

{$smarty.capture.checkout_error_content nofilter}
{include file="views/checkout/components/checkout_steps.tpl"}

{capture name="mainbox_title"}
	<span class="checkout-title">{__("secure_checkout")}&nbsp;<i class="glyphicon glyphicon-lock fa fa-lock"></i></span>
{/capture}

{include file="common/letter_header.tpl"}

{__("hello")} {$order_info.firstname}<br /><br />

{__("text_applied_promotions")}<br />

{$promotion_data.name}<br /><br />
{$promotion_data.detailed_description nofilter}<br />

<b>{$bonus_data.coupon_code}</b>

{include file="common/letter_footer.tpl"}
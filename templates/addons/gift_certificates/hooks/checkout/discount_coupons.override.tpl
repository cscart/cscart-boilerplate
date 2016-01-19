<div class="gift-certificate-coupon input-group">
    <input type="text" class="form-control cm-hint" id="coupon_field{$position}" name="coupon_code" size="40" value="{__("promo_code_or_certificate")}" />
    {include file="common/go.tpl" name="checkout.apply_coupon" alt=__("apply") text=__("apply")}
</div>
<label for="coupon_field{$position}" class="hidden cm-required">{__("promo_code")}</label>
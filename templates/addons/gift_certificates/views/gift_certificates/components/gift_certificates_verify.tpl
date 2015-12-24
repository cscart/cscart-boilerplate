<div class="gift-certificate-validate">
    <form name="gift_certificate_verification_form" class="cm-ajax cm-form-dialog-opener cm-dialog-auto-size" action="{""|fn_url}">
        <input type="hidden" name="result_ids" value="gift_cert_verify" />
        <h3>{__("certificate_verification")}</h3>
        <div class="input-group">
            <input type="text" name="verify_code" id="id_verify_code" value="{__("enter_code")}" class="form-control cm-hint" />
            {include file="common/go.tpl" name="gift_certificates.verify" alt=__("apply") text=__("apply")}
        </div>
        <label for="id_verify_code" class="hidden cm-required">{__("gift_cert_code")}</label>
    </form>
</div>

<div title="{__("gift_certificate_verification")}" id="gift_cert_verify">
<!--gift_cert_verify--></div>
{script src="js/tygh/tabs.js"}

<div class="form-group">
    <label for="dateofbirth" class="cm-required control-label">{__("date_of_birth")}:</label>
    {include file="common/calendar.tpl" date_id="date_of_birth" date_name="payment_info[date_of_birth]" date_val=$cart.payment_info.date_of_birth|default:$user_data.birthday}
</div>
<div class="form-group">
    <label for="last4ssn" class="cm-required control-label">{__("last4ssn")}:</label>
    <input id="last4ssn" maxlength="4" size="35" type="text" name="payment_info[last4ssn]" value="{$cart.payment_info.last4ssn}" class="form-control cm-autocomplete-off cm-focus" />
</div>
<div class="form-group">
    <label for="phone_number" class="cm-required cm-regexp control-label" data-ca-regexp="{literal}^([0-9]{3}[ ]{1}[0-9]{3}[ ]{1}[0-9]{4})${/literal}" data-ca-message="{__("error_validator_phone_number")}">{__("phone")}:</label>
    <input id="phone_number" size="35" type="text" name="payment_info[phone]" value="{$cart.payment_info.phone|default:$user_data.b_phone|default:$user_data.phone}" class="form-control cm-autocomplete-off" />
</div>
<div class="form-group">
    <label for="passport_number" class="control-label">{__("passport_number")}:</label>
    <input id="passport_number" size="35" type="text" name="payment_info[passport_number]" value="{$cart.payment_info.passport_number}" class="form-control cm-autocomplete-off" />
</div>
<div class="form-group">
    <label for="drlicense_number" class="control-label">{__("drlicense_number")}:</label>
    <input id="drlicense_number" size="35" type="text" name="payment_info[drlicense_number]" value="{$cart.payment_info.drlicense_number}" class="form-control cm-autocomplete-off" />
</div>
<div class="form-group">
    <label for="routingcode" class="cm-required control-label">{__("routing_code")}:</label>
    <input id="routingcode" maxlength="9" size="35" type="text" name="payment_info[routing_code]" value="{$cart.payment_info.routing_code}" class="form-control cm-autocomplete-off" />
</div>
<div class="form-group">
    <label for="accountnr" class="cm-required control-label">{__("account_number")}:</label>
    <input id="accountnr" maxlength="20" size="35" type="text" name="payment_info[account_number]" value="{$cart.payment_info.account_number}" class="form-control cm-autocomplete-off" />
</div>
<div class="form-group">
    <label for="checknr" class="cm-required control-label">{__("check_number")}:</label>
    <input id="checknr" maxlength="10" size="35" type="text" name="payment_info[check_number]" value="{$cart.payment_info.check_number}" class="form-control cm-autocomplete-off" />
</div>
<div class="form-group">
    <label for="p21agree" class="cm-required control-label">{__("p21agree")} (<a class="cm-tooltip" title="{__("p21agree_tooltip")}">?</a>):</label>
    <input id="p21agree" maxlength="8" size="35" type="text" name="payment_info[mm_agree]" value="{$cart.payment_info.mm_agree}" class="form-control cm-autocomplete-off" />
</div>

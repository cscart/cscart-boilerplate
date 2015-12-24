<div class="clearfix">
    <div class="credit-card">
        <div class="form-group">
            <label for="credit_card_number_{$id_suffix}" class="control-label cm-cc-number cm-required">{__("card_number")}</label>
            <input size="35" type="text" id="credit_card_number_{$id_suffix}" name="payment_info[card_number]" value="" class="form-control cm-autocomplete-off" />
            <ul class="cc-icons cm-cc-icons">
                <li class="cc-default cm-cc-default"><span class="default">&nbsp;</span></li>
                <li class="cm-cc-visa"><span class="visa">&nbsp;</span></li>
                <li class="cm-cc-visa_electron"><span class="visa-electron">&nbsp;</span></li>
                <li class="cm-cc-mastercard"><span class="mastercard">&nbsp;</span></li>
                <li class="cm-cc-maestro"><span class="maestro">&nbsp;</span></li>
                <li class="cm-cc-amex"><span class="american-express">&nbsp;</span></li>
                <li class="cm-cc-discover"><span class="discover">&nbsp;</span></li>
            </ul>
        </div>

        <div class="form-group">
            <label for="credit_card_name_{$id_suffix}" class="control-label cm-required">{__("cardholder_name")}</label>
            <input size="35" type="text" id="credit_card_name_{$id_suffix}" name="payment_info[cardholder_name]" value="" class="cm-cc-name form-control uppercase" />
        </div>
    </div>
</div>

<div class="form-group">
    <label for="bank_routing_number" class="control-label cm-required">{__("order_status")}</label>
    <select name="payment_info[final_order_status]" class="form-control">
    	<option value="P" selected="selected">{__("processed")}</option>
    	<option value="F">{__("failed")}</option>
    	<option value="O">{__("open")}</option>
    	<option value="D">{__("declined")}</option>
    </select>
</div>
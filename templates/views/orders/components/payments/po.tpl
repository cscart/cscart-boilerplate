<div class="form-group">
    <label for="elm_po_number" class="cm-required control-label">{__("po_number")}:</label>
    <input id="elm_po_number" size="35" type="text" name="payment_info[po_number]" value="{$cart.payment_info.po_number}" class="form-control cm-focus">
</div>

<div class="form-group">
    <label for="elm_company_name" class="cm-required control-label">{__("company_name")}:</label>
    <input id="elm_company_name" size="35" type="text" name="payment_info[company_name]" value="{$cart.payment_info.company_name}" class="form-control">
</div>

<div class="form-group">
    <label for="elm_buyer_name" class="cm-required control-label">{__("buyer_name")}:</label>
    <input id="elm_buyer_name" size="35" type="text" name="payment_info[buyer_name]" value="{$cart.payment_info.buyer_name}" class="form-control">
</div>

<div class="form-group">
    <label for="elm_position" class="cm-required control-label">{__("position")}:</label>
    <input id="elm_position" size="35" type="text" name="payment_info[position]" value="{$cart.payment_info.position}" class="form-control">
</div>
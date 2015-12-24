{hook name="checkout:notes"}
    <div class="form-group">
      <label class="control-label" for="customer_notes">{__("type_comments_here")}</label>
      <textarea class="form-control cm-focus" id="customer_notes" name="customer_notes" cols="60" rows="3">{$cart.notes}</textarea>
    </div>
{/hook}
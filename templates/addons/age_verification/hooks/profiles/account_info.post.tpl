<div class="age-verification-birthday">
    {if !$nothing_extra}
        <h3>{__("age_verification")}</h3>
    {/if}

    <div class="form-group">
        <label class="control-label" for="birthday">{__("birthday")}</label>
        <div class="row">
            {include file="common/calendar.tpl" date_id="birthday" date_name="user_data[birthday]" date_val=$user_data.birthday}
        </div>
    </div>
</div>
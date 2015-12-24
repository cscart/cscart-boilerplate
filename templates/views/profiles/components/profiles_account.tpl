{if !$nothing_extra}
    <h3>{__("user_account_info")}</h3>
{/if}

{hook name="profiles:account_info"}
    <div class="form-group">
        <label for="email" class="cm-required cm-email cm-trim control-label">{__("email")}</label>
        <input type="text" id="email" name="user_data[email]" size="32" maxlength="128" value="{$user_data.email}" class="form-control cm-focus" />
    </div>

    <div class="form-group">
        <label for="password1" class="cm-required cm-password control-label">{__("password")}</label>
        <input type="password" id="password1" name="user_data[password1]" size="32" maxlength="32" value="{if $runtime.mode == "update"}            {/if}" class="form-control cm-autocomplete-off" />
    </div>

    <div class="form-group">
        <label for="password2" class="cm-required cm-password control-label">{__("confirm_password")}</label>
        <input type="password" id="password2" name="user_data[password2]" size="32" maxlength="32" value="{if $runtime.mode == "update"}            {/if}" class="form-control cm-autocomplete-off" />
    </div>
{/hook}
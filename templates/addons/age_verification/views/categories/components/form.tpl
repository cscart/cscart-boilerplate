<div class="row">
    <div class="col-lg-5">
        <form action="{""|fn_url}" method="post" name="age_verification" class="form">
            <div class="panel panel-default age-verification-panel">
                <div class="panel-body">
                    {if $age_warning_message}<p class="">{$age_warning_message}</p>{/if}
                    <input type="hidden" name="redirect_url" value="{$smarty.request.return_url}" />
                    <div class="form-group">
                        <label class="control-label" for="age">{__("your_age")}</label>
                        <input type="text" name="age" id="age" size="10" class="form-control">
                    </div>
                </div>
                <div class="panel-footer">
                    {include file="common/button.tpl" meta="btn-warning" text=__("verify") name="dispatch[age_verification.verify]"}
                </div>
            </div>
        </form>  
    </div>
</div>

{capture name="mainbox_title"}{$category_data.category nofilter}{/capture}
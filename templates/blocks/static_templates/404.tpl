<div class="container">
    <div class="row">
        <div class="col-md-12 text-center">
            <div class="error-template">
                <h1>{__("exception_title")}</h1>
                <h2>{$exception_status} {__("exception_error")}</h2>
                <div class="error-details">
                    <p>
                    {if $smarty.const.HTTPS === true}
                        {assign var="return_url" value=$config.https_location|fn_url}
                    {else}
                        {assign var="return_url" value=$config.http_location|fn_url}
                    {/if}

                    {if $exception_status == "403"}
                        {__("access_denied_text")}
                    {elseif $exception_status == "404"}
                        {__("page_not_found_text")}
                    {/if}
                    <br>
                    {__("exception_error_code")}
                    {if $exception_status == "403"}
                        {__("access_denied")}
                    {elseif $exception_status == "404"}
                        {__("page_not_found")}
                    {/if}
                    </p>
                </div>
                <div class="error-actions">
                    <a href="{$return_url}" class="btn btn-primary">
                        <span class="glyphicon glyphicon-home fa fa-home"></span>
                        {__("go_to_the_homepage")}
                    </a>
                    <a class="btn btn-default" onclick="history.go(-1);">
                        <span class="glyphicon glyphicon-circle-arrow-left fa fa-arrow-circle-left"></span>
                        {__("go_back")}
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
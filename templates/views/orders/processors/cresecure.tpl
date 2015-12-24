<h1 style="color: #2d2e2e;font: bold 200% Arial, Helvetica, sans-serif;">{__("payment_information")}</h1>
<p>
{__("text_form_cresecure_notice")}
</p>
<p>
<style type="text/css">
{literal}
.cresecure_payment_form {
    background-color: #f3f8fb;
    padding-left: 15px;
}

.cresecure_payment_form select {
    border: 1px solid #DFE6ED;
    color: #2D2D2D;
    background-color: #FFFFFF;
    font-family: Tahoma;
    font-size: 92%;
}

.cresecure_payment_form #PAN, #name, #cv_data {
    border: 1px solid #DFE6ED;
    color: #2D2D2D;
    background-color: #FFFFFF;
    font-family: Tahoma;
    font-size: 92%;
    padding: 3px 0;
    margin: 0 3px 0 0;
    vertical-align: middle;
    width: 250px;
}
.cresecure_payment_form #cv_data {
    width: 45px;
}

.cresecure_payment_form .main {
    color: #7C8E8E;
}
{/literal}
</style>
<div class="cresecure_payment_form">
[[FORM INSERT]]
</div>
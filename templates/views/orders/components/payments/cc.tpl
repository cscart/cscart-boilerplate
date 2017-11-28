{script src="js/lib/inputmask/jquery.inputmask.min.js"}
{script src="js/lib/creditcardvalidator/jquery.creditCardValidator.js"}
{if $card_id}
{assign var="id_suffix" value="`$card_id`"}
{else}
{assign var="id_suffix" value=""}
{/if}
<div class="row credit-card">
    {if $payment_list}
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
    {else}
        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
    {/if}
        <div class="panel panel-default ">
            <div class="panel-body">
                <div class="form-group">
                    <label for="credit_card_number_{$id_suffix}" class="cm-cc-number cm-required control-label">{__("card_number")}</label>
                    <input size="35" type="text" id="credit_card_number_{$id_suffix}" name="payment_info[card_number]" value="" class="form-control cm-focus cm-autocomplete-off" />
                </div>

                <div class="form-group form-inline">
                    <label for="credit_card_month_{$id_suffix}" class="cm-cc-date cm-cc-exp-month cm-required control-label">{__("valid_thru")}</label>
                    <label for="credit_card_year_{$id_suffix}" class="cm-required cm-cc-date cm-cc-exp-year hidden"></label>
                    <div class="form-group">
                        <input type="text" id="credit_card_month_{$id_suffix}" name="payment_info[expiry_month]" value="" size="2" maxlength="2" class="form-control " />
                    </div> /
                    <div class="form-group">
                        <input type="text" id="credit_card_year_{$id_suffix}"  name="payment_info[expiry_year]" value="" size="2" maxlength="2" class="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="credit_card_name_{$id_suffix}" class="cm-required control-label">{__("cardholder_name")}</label>
                    <input size="35" type="text" id="credit_card_name_{$id_suffix}" name="payment_info[cardholder_name]" value="" class="cm-cc-name form-control" />
                </div>
            </div>
        </div>
    </div>

    {if $payment_list}
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
    {else}
        <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12">
    {/if}
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="form-group">
                    <label for="credit_card_cvv2_{$id_suffix}" class="cm-required cm-integer cm-cc-cvv2 cm-autocomplete-off control-label">{__("cvv2")}</label>
                    <input type="text" id="credit_card_cvv2_{$id_suffix}" name="payment_info[cvv2]" value="" size="4" maxlength="4" class="form-control" />
                </div>
                <div class="dropdown">
                    <button type="button" class="btn btn-link btn-xs" data-toggle="dropdown" id="cvv_info" >{__("what_is_cvv2")}</button>
                    <div class="dropdown-menu"  style="min-width:400px;" area-labelledby="cvv_info">
                        <div class="media">
                            <div class="media-left">
                                <img src="{$images_dir}/visa_cvv.png" alt="" />
                            </div>
                            <div class="media-body">
                                <h5 >{__("visa_card_discover")}</h5>
                                <p>{__("credit_card_info")}</p>
                            </div>
                        </div>
                        <div class="media">
                            <div class="media-left">
                                <img src="{$images_dir}/express_cvv.png" alt="" />
                            </div>
                            <div class="media-body">
                                <h5 >{__("american_express")}</h5>
                                <p>{__("american_express_info")}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
(function(_, $) {
    $.ceEvent('on', 'ce.commoninit', function() {
        var icons = $('.cm-cc-icons li');
        var ccNumber = $(".cm-cc-number");
        var ccNumberInput = $("#" + ccNumber.attr("for"));
        var ccCv2 = $(".cm-cc-cvv2");
        var ccCv2Input = $("#" + ccCv2.attr("for"));
        var ccMonth = $(".cm-cc-exp-month");
        var ccMonthInput = $("#" + ccMonth.attr("for"));
        var ccYear = $(".cm-cc-exp-year");
        var ccYearInput = $("#" + ccYear.attr("for"));
        if(_.isTouch === false && jQuery.isEmptyObject(ccNumberInput.data("_inputmask")) == true) {
            
            ccNumberInput.inputmask("9999 9999 9999 9[99][9]", {
                placeholder: ' '
            });
            $.ceFormValidator('registerValidator', {
                class_name: 'cm-cc-number',
                message: '',
                func: function(id) {
                    return ccNumberInput.inputmask("isComplete");
                }
            });
            ccCv2Input.inputmask("999[9]", {
                placeholder: ''
            });
            $.ceFormValidator('registerValidator', {
                class_name: 'cm-cc-cvv2',
                message: '{__("error_validator_ccv")}',
                func: function(id) {
                    return ccCv2Input.inputmask("isComplete");
                }
            });
            ccMonthInput.inputmask("99", {
                placeholder: ''
            });
            ccYearInput.inputmask("99", {
                placeholder: ''
            });
            $.ceFormValidator('registerValidator', {
                class_name: 'cm-cc-date',
                message: '',
                func: function(id) {
                    return (ccYearInput.inputmask("isComplete") && ccMonthInput.inputmask("isComplete"));
                }
            });
        }
        ccNumberInput.validateCreditCard(function(result) {
            icons.removeClass('active');
            if (result.card_type) {
                icons.filter('.cm-cc-' + result.card_type.name).addClass('active');
                if (['visa_electron', 'maestro', 'laser'].indexOf(result.card_type.name) != -1) {
                    ccCv2.removeClass("cm-required");
                } else {
                    ccCv2.addClass("cm-required");
                }
            }
        });
        
    });
})(Tygh, Tygh.$);
</script>
{script src="js/lib/maskedinput/jquery.maskedinput.min.js"}

{script src="js/lib/inputmask/jquery.inputmask.min.js"}
{script src="js/lib/jquery-bind-first/jquery.bind-first-0.2.3.js"}
{script src="js/lib/inputmask-multi/jquery.inputmask-multi.js"}

<script type="text/javascript">
    (function(_, $) {
        _.call_requests_phone_masks_list = {$call_requests_phone_mask_codes nofilter};
        {if $addons.call_requests.phone_mask}
            _.call_phone_mask = '{$addons.call_requests.phone_mask}'
        {/if}

        _.tr({
            'call_requests.error_validator_phone': '{__("call_requests.error_validator_phone")|escape:"javascript"}'
        });
    }(Tygh, Tygh.$));
</script>

{script src="js/addons/call_requests/call_requests.js"}
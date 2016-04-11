<div class="payments-list row">
    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
        <ul class="list-group">
            {hook name="checkout:payment_method"}
                {foreach from=$payments item="payment"}
                    {if $payment_id == $payment.payment_id}
                        {$instructions = $payment.instructions}
                    {/if}
                    <li class="list-group-item {if $payment_id == $payment.payment_id}active{/if}">
                        <div class="radio">
                        <label>
                            <input id="payment_{$payment.payment_id}" class=" cm-select-payment" type="radio" name="payment_id" value="{$payment.payment_id}" data-ca-url="{$url}" data-ca-result-ids="{$result_ids}" {if $payment_id == $payment.payment_id}checked="checked"{/if} {if $payment.disabled}disabled{/if} />
                            {if $payment.image}
                                {include file="common/image.tpl" obj_id=$payment.payment_id images=$payment.image}
                            {/if}
                            <strong>{$payment.payment}</strong>
                          </label>
                        </div>
                        <div class="payments-list-description">
                            <span>{$payment.description}</span>
                        </div>
                    </li>
                    {if $payment_id == $payment.payment_id}
                        {if $payment.template && $payment.template != "cc_outside.tpl"}
                            {capture name="payment_template"}
                                {include file=$payment.template payment_list=true}
                            {/capture}
                            {if $smarty.capture.payment_template|trim}
                            <li class="list-group-item">
                                {$smarty.capture.payment_template nofilter}
                            </li>
                            {/if}
                        {/if}
                    {/if}
                {/foreach}
            {/hook}
        </ul>
    </div>
    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
        {$instructions nofilter}
    </div>
</div>

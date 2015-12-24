{if !$smarty.request.extra}
<script type="text/javascript">
(function(_, $) {

    _.tr('text_items_added', '{__("text_items_added")|escape:"javascript"}');
    _.tr('options', '{__("options")|escape:"javascript"}');

{if $smarty.request.display == "options" || $smarty.request.display == "options_amount" || $smarty.request.display == "options_price"}
    _.tr('no', '{__("no")|escape:"javascript"}');
    _.tr('yes', '{__("yes")|escape:"javascript"}');
    _.tr('aoc', '{__("any_option_combinations")|escape:"javascript"}');

    function _getDescription(obj, id) 
    {
        var p = {};
        var d = '';
        var aoc = $('#sw_option_' + id + '_AOC');
        if (aoc.length && aoc.prop('checked')) {
            d = _.tr('aoc');
        } else {
            $(':input', $('#option_' + id + '_AOC')).each( function() {
                var op = this;
                var j_op = $(this);
                
                if (typeof(op.name) == 'string' && op.name == '') {
                    return false;
                }

                var option_id = op.name.match(/\[(\d+)\]$/)[1];
                if (op.type == 'checkbox') {
                    var variant = (op.checked == false) ? _.tr('no') : _.tr('yes');
                }
                if (op.type == 'radio' && op.checked == true) {
                    var variant = $('#option_description_' + id + '_' + option_id + '_' + op.value).text();
                }
                if (op.type == 'select-one') {
                    var variant = op.options[op.selectedIndex].text;
                }
                if ((op.type == 'text' || op.type == 'textarea') && op.value != '') {
                    if (j_op.hasClass('cm-hint') && op.value == op.defaultValue) { //FIXME: We should not become attached to cm-hint class
                        var variant = '';
                    } else {
                        var variant = op.value;
                    }
                }
                if ((op.type == 'checkbox') || ((op.type == 'text' || op.type == 'textarea') && op.value != '') || (op.type == 'select-one') || (op.type == 'radio' && op.checked == true)) {
                    if (op.type == 'checkbox') {
                        p[option_id] = (op.checked == false) ? $('#unchecked_' + id + '_option_' + option_id).val() : op.value;
                    }else{
                        p[option_id] = (j_op.hasClass('cm-hint') && op.value == op.defaultValue) ? '' : op.value; //FIXME: We should not become attached to cm-hint class
                    }

                    d += (d ? ',  ' : '') + $('#option_description_' + id + '_' + option_id).text() + variant;
                }
            });
        }
        return {
            path: p, 
            desc: d != '' ? '<span>' + _.tr('options') + ':  </span>' + d : ''
        };
    }
{/if}

    $.ceEvent('on', 'ce.formpost_add_products', function(frm, elm) {
        var products = {};
        if ($('input.cm-item:checked', frm).length > 0) {
            $('input.cm-item:checked', frm).each( function() {
                var id = $(this).val();
                {if $smarty.request.display == "options" || $smarty.request.display == "options_amount" || $smarty.request.display == "options_price"}
                    products[id] = {
                        option: _getDescription(frm, id),
                        value: $('#product_' + id).val()
                    };
                {else}
                    products[id] = $('#product_' + id).val();
                {/if}
            });
            
            $.ceEvent('trigger', 'ce.picker_transfer_js_items', [products]);

            $.cePicker('add_js_item', frm.data('caResultId'), products, 'p', {});

            $.ceNotification('show', {
                type: 'N', 
                title: _.tr('notice'), 
                message: _.tr('text_items_added'), 
                message_state: 'I'
            });
        }
        
        return false;
    });
}(Tygh, Tygh.$));
</script>
{/if}

{include file="views/products/components/products_search_form.tpl" dispatch="products.picker" search_extra="<input type=\"hidden\" name=\"result_ids\" value=\"pagination_`$smarty.request.id`\">" put_request_vars=true form_meta="cm-ajax" simple_search_form=true}


<form action="{$smarty.request.extra|fn_url}" method="post" name="add_products" data-ca-result-id="{$smarty.request.id}" enctype="multipart/form-data">

{if $products}
{include file="blocks/list_templates/products_list.tpl" 
show_name=true 
show_sku=true 
show_rating=true 
show_features=true 
show_prod_descr=true 
show_old_price=true 
show_price=true 
show_clean_price=true 
show_list_discount=true 
show_discount_label=true 
show_product_amount=true 
show_product_options=true 
show_qty=true 
show_min_qty=true 
show_product_edp=true 
show_descr=true 
disable_ids="bulk_addition_" 
dont_show_points=true 
bulk_addition=true 
js_product_var=$smarty.request.extra|fn_is_empty
hide_form=true 
bulk_add=true 
hide_layouts=true 
hide_links=true
id="pagination_`$smarty.request.data_id`"
force_ajax=true
}


{else}
<div class="pagination-container" id="pagination_{$smarty.request.data_id}">
    <p class="no-items">{__("text_no_matching_results_found")}</p>
<!--pagination_{$smarty.request.data_id}--></div>
{/if}


{if $products}
<div class="buttons-container picker">
    {include file="common/add_close.tpl" text=__("add_products") close_text=__("add_products_and_close") is_js=$smarty.request.extra|fn_is_empty}
</div>
{/if}

</form>
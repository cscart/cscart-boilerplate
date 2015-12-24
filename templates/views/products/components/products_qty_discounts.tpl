<div class="qty-discount">
    <div class="qty-discount-label">{__("text_qty_discounts")}:</div>
    <table class="table qty-discount">
        <thead>
            <tr>
                <th>{__("quantity")}</th>
                {foreach from=$product.prices item="price"}
                    <th>{$price.lower_limit}+</th>
                {/foreach}
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>{__("price")}</td>
                {foreach from=$product.prices item="price"}
                    <td>{include file="common/price.tpl" value=$price.price}</td>
                {/foreach}
            </tr>
        </tbody>
    </table>
</div>
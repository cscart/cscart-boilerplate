{capture name="section"}
    {include file="views/orders/components/orders_search_form.tpl"}
{/capture}
{include file="common/section.tpl" section_title=__("search_options") section_content=$smarty.capture.section}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{if $search.sort_order == "asc"}
{assign var="sort_sign" value="<i class=\"glyphicon glyphicon-sort-by-attributes fa fa-sort-amount-asc\"></i>"}
{else}
{assign var="sort_sign" value="<i class=\"glyphicon glyphicon-sort-by-attributes-alt fa fa-sort-amount-desc\"></i>"}
{/if}
{if !$config.tweaks.disable_dhtml}
    {assign var="ajax_class" value="cm-ajax"}

{/if}

{include file="common/pagination.tpl"}

{if $orders}
<table class="table orders-search">
    <thead>
        <tr>
            <th><a class="{$ajax_class}" href="{"`$c_url`&sort_by=order_id&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("id")}</a> {if $search.sort_by == "order_id"}{$sort_sign nofilter}{/if}</th>
            <th><a class="{$ajax_class}" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("status")}</a> {if $search.sort_by == "status"}{$sort_sign nofilter}{/if}</th>
            <th><a class="{$ajax_class}" href="{"`$c_url`&sort_by=customer&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("customer")}</a> {if $search.sort_by == "customer"}{$sort_sign nofilter}{/if}</th>
            <th><a class="{$ajax_class}" href="{"`$c_url`&sort_by=date&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("date")}</a> {if $search.sort_by == "date"}{$sort_sign nofilter}{/if}</th>

            {hook name="orders:manage_header"}{/hook}

            <th><a class="{$ajax_class}" href="{"`$c_url`&sort_by=total&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("total")}</a>{if $search.sort_by == "total"}{$sort_sign nofilter}{/if}</th>
        </tr>
    </thead>
    {foreach from=$orders item="o"}
        <tr>
            <td>
                <a href="{"orders.details?order_id=`$o.order_id`"|fn_url}"><strong>#{$o.order_id}</strong></a>
            </td>
            <td>{include file="common/status.tpl" status=$o.status display="view"}</td>
            <td>
                <ul class="user-info list-unstyled">
                    <li>{$o.firstname} {$o.lastname}</li>
                    <li><a href="mailto:{$o.email|escape:url}">{$o.email}</a></li>
                </ul>
            </td>
            <td>
                <a href="{"orders.details?order_id=`$o.order_id`"|fn_url}">
                    {$o.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}
                </a>
            </td>

            {hook name="orders:manage_data"}{/hook}

            <td>{include file="common/price.tpl" value=$o.total}</td>
        </tr>
    {/foreach}
</table>
{else}
    <p class="well well-lg no-items">{__("text_no_orders")}</p>
{/if}
{include file="common/pagination.tpl"}

{capture name="mainbox_title"}{__("orders")}{/capture}
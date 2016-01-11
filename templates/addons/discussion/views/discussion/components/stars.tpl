<span class="stars">
    {if $is_link}
        {if ($runtime.controller == "products" || $runtime.controller == "companies") && $runtime.mode == "view"}
            <a class="cm-external-click" data-ca-scroll="content_discussion" data-ca-external-click-id="discussion">
        {else}
            <a href="{"products.view?product_id=`$product.product_id`&selected_section=discussion#discussion"|fn_url}">
        {/if}
    {/if}

    {section name="full_star" loop=$stars.full}
        <i class="glyphicon glyphicon-star fa fa-star"></i>
    {/section}

    {if $stars.part}
        <i class="glyphicon glyphicon-star-empty fa fa-star-o"></i>
    {/if}

    {section name="full_star" loop=$stars.empty}
        <i class="glyphicon glyphicon-star-empty fa fa-star-o"></i>
    {/section}

    {if $is_link}
        </a>
    {/if}
</span>
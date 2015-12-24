{if $product.discussion_type && $product.discussion_type != 'D'}
    {include file="addons/discussion/views/discussion/components/new_post.tpl" new_post_title=__("write_review") discussion=$product.discussion post_redirect_url="products.view?product_id=`$product.product_id`&selected_section=discussion#discussion"|fn_url}
{/if}
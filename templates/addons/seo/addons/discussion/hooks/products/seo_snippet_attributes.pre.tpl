{if $product.discussion.search.total_items && $product.discussion.average_rating}
<div itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"> 
    <meta itemprop="reviewCount" content="{$product.discussion.search.total_items}">
    <meta itemprop="ratingValue" content="{$product.discussion.average_rating}">
</div>
{/if}
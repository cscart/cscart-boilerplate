<div class="search-result">
    <a href="{if $page.page_type == $smarty.const.PAGE_TYPE_LINK && $page.link != ""}{$page.link|fn_url}{else}{"pages.view?page_id=`$page.page_id`"|fn_url}{/if}" class="product-title">{$page.page}</a>
    <p>{$page.description|strip_tags|truncate:380:"..." nofilter}</p>
</div>
{** block-description:store_locator **}

<form action="{""|fn_url}" method="get" name="store_locator_form">
    <div class="form-group">
        <div class="input-group">
            <input type="text" size="20" class="form-control" id="store_locator_search{$block.block_id}" name="q" value="{$store_locator_search.q}" placeholder="{__("search")}" />
            {include file="common/go.tpl" name="store_locator.search" alt=__("search")}
        </div>
    </div>
</form>
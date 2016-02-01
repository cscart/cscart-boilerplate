{assign var="columns" value=4}
{if !$wishlist_is_empty}

    {script src="js/tygh/exceptions.js"}

    {assign var="show_hr" value=false}
    {assign var="location" value="cart"}
{/if}
{if $products}
    {include file="blocks/list_templates/grid_list.tpl" 
        columns=$columns
        show_empty=true
        show_old_price=true 
        show_price=true 
        show_clean_price=true 
        show_list_discount=true
        no_pagination=true
        no_sorting=true
        show_add_to_cart=false
        is_wishlist=true}
{else}
    {math equation="100 / x" x=$columns|default:"2" assign="cell_width"}
    <div class="grid-list clearfix {if $wishlist_is_empty} wish-list-empty{/if}">
        {assign var="iteration" value=0}
        {capture name="iteration"}{$iteration}{/capture}
            {hook name="wishlist:view"}
            {/hook}
        {assign var="iteration" value=$smarty.capture.iteration}
        {if $iteration == 0 || $iteration % $columns != 0}
            {math assign="empty_count" equation="c - it%c" it=$iteration c=$columns}
            {section loop=$empty_count name="empty_rows"}
                {$cols = 12/$columns}
                <div class="col-lg-{$cols|floor}">
                    <div class="thumbnail wishlist-empty">
                        {__("empty")}
                    </div>
                </div>
            {/section}
        {/if}
    </div>
{/if}

{if !$wishlist_is_empty}
    <div class="panel panel-default buttons-container">
        <div class="panel-body">
            {include file="common/button.tpl" text=__("clear_wishlist") href="wishlist.clear" meta="btn-info"}
            {include file="common/button.tpl" href=$continue_url|fn_url text=__("continue_shopping")}
        </div>
    </div>
{else}
    <div class="panel panel-default buttons-container">
        <div class="panel-body">
            {include file="common/button.tpl" href=$continue_url|fn_url text=__("continue_shopping")}
        </div>
    </div>
{/if}

{capture name="mainbox_title"}{__("wishlist_content")}{/capture}

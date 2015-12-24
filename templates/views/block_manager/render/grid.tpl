{if $layout_data.layout_width != "fixed"}
    {if $parent_grid.width > 0}
        {$fluid_width = fn_get_grid_fluid_width($layout_data.width, $parent_grid.width, $grid.width)}
    {else}
        {$fluid_width = $grid.width}
    {/if}
{/if}

{if $grid.status == "A" && $content}
    {if $grid.alpha}<div class="row">{/if}
        {$width = $fluid_width|default:$grid.width}
        <section class="col-lg-{$width}{if $grid.offset} offset{$grid.offset}{/if}{if $grid.user_class} {$grid.user_class}{/if}{if $content_alignment == 'LEFT' || $content_alignment == 'RIGHT'} clearfix{/if}" >
            {$content nofilter}
        </section>
    {if $grid.omega}</div>{/if}
{/if}
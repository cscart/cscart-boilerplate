{split data=$categories size=$columns|default:"3" assign="splitted_categories"}
<div class="subcategories">
    {strip}
    {foreach from=$splitted_categories item="scats"}
        <div class="row">
            {foreach from=$scats item="category"}
                {if $category}
                    {$cols = 12/$columns}
                    <div class="col-lg-{$cols|floor} col-md-{$cols|floor} subcategories-block">
                        <a href="{"categories.view?category_id=`$category.category_id`"|fn_url}">
                            {if $category.main_pair}
                                {include file="common/image.tpl"
                                    show_detailed_link=false
                                    images=$category.main_pair
                                    no_ids=true
                                    image_id="category_image"
                                    image_width=$settings.Thumbnails.category_lists_thumbnail_width
                                    image_height=$settings.Thumbnails.category_lists_thumbnail_height
                                    class="subcategories-img"
                                }
                            {/if}
                            {$category.category}
                        </a>
                    </div>
                {/if}
            {/foreach}
        </div>
    {/foreach}
    {/strip}
</div>

{capture name="mainbox_title"}{$title}{/capture}
<div class="clearfix cm-field-container">
    <div class="rating" id="{$rate_id}">
        {foreach from =""|fn_get_discussion_ratings item="title" key="val"}
        {$item_rate_id = "`$rate_id`_`$val`"}
        <input type="radio" id="{$item_rate_id}" class="rating-check" name="{$rate_name}" value="{$val}" />
        <label class="rating-label" for="{$item_rate_id}" title="{$title}">
            <i class="glyphicon glyphicon-star-empty fa fa-star-o"></i>
            <i class="glyphicon glyphicon-star fa fa-star"></i>
        </label>
        {/foreach}
    </div>
</div>
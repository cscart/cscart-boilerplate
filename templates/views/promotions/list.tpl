<div class="wysiwyg-content">
{foreach from=$promotions key="promotion_id" item="promotion"}
    {hook name="promotions:list_item"}
        <h3>{$promotion.name}</h3>
        {$promotion.detailed_description|default:$promotion.short_description nofilter}
    {/hook}
{foreachelse}
    <p>{__("text_no_active_promotions")}</p>
{/foreach}
</div>

{capture name="mainbox_title"}{__("active_promotions")}{/capture}
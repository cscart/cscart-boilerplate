{include file="common/letter_header.tpl"}

{__("hello")},<br /><br />

{__("text_new_post_notification")}&nbsp;<b>{__($object_name)}</b>:&nbsp;{$object_data.description}
<br /><br />
<b>{__("person_name")}</b>:&nbsp;{$post_data.name}<br />
{if $post_data.rating_value}
<b>{__("rating")}</b>:&nbsp;{if $post_data.rating_value == "5"}{__("excellent")}{elseif $post_data.rating_value == "4"}{__("very_good")}{elseif $post_data.rating_value == "3"}{__("average")}{elseif $post_data.rating_value == "2"}{__("fair")}{elseif $post_data.rating_value == "1"}{__("poor")}{/if}
<br />
{/if}

{if $post_data.message}
<b>{__("message")}</b>:<br />
{$post_data.message|nl2br nofilter}
<br /><br />
{/if}

{if $post_data.status == 'N'}
<b>{__("text_approval_notice")}</b>
<br />
{/if}
{__("view")}:<br />
<a href="{$url|replace:'&amp;':'&'}">{$url|replace:'&amp;':'&'}</a>

{include file="common/letter_footer.tpl"}
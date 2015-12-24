{if $languages && $languages|count > 1}
<div class="dropdown" id="languages_{$block.block_id}">
    <button class="btn btn-default dropdown-toggle" type="button" id="languages" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
    	<i class="flag flag-{$languages[$smarty.const.CART_LANGUAGE].country_code|lower}"></i>
        <span class="hidden-xs">{$languages[$smarty.const.CART_LANGUAGE].name}</span>
        <span class="caret"></span>
    </button>
    <ul class="dropdown-menu" aria-labelledby="languages">
        {foreach from=$languages item=lang key=lang_id}
            <li>
            	<a href="{"`$config.current_url|fn_link_attach:"sl="``$lang.lang_code`"|fn_url}" rel="nofollow">
            		<i class="flag flag-{$lang.country_code|lower}"></i>
            		{$lang.name}
            	</a>
            </li>
        {/foreach}
    </ul>
<!--languages_{$block.block_id}--></div>
{/if}
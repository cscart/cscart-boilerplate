<ul class="list-unstyled entry-page-countries">
    {foreach name="countries" from=$countries key="code" item="url"}
        <li class="entry-page-item"><a class="entry-page-a" href="{$url}"><i class="flag flag-{$code|lower}"></i>{$country_descriptions.$code.country}</a></li>
    {/foreach}
</ul>
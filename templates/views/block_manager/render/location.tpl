
{if $containers.top_panel}
<section class="top-panel">
    {$containers.top_panel nofilter}
</section>
{/if}

{if $containers.header}
<header class="header">
    {$containers.header nofilter}
</header>
{/if}

{if $containers.content}
<section class="content">
    {$containers.content nofilter}
</section>
{/if}


{if $containers.footer}
<footer class="footer" id="tygh_footer">
    {$containers.footer nofilter}
</footer>
{/if}

{if "ULTIMATE"|fn_allowed_for}
    {* Show "Entry page" *}
    {if $show_entry_page}
        <div id="entry_page"></div>
            <script type="text/javascript">
                $('#entry_page').ceDialog('open', {$ldelim}href: fn_url('companies.entry_page'), resizable: false, title: '{__("choose_your_country")}', width: 325, height: 420, dialogClass: 'entry-page'{$rdelim});
            </script>
    {/if}
{/if}

{if $smarty.request.meta_redirect_url|fn_check_meta_redirect}
    <meta http-equiv="refresh" content="1;url={$smarty.request.meta_redirect_url|fn_check_meta_redirect|fn_url}" />
{/if}
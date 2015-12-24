<script type="text/javascript" data-no-defer>

    {if $redirect_url}
        var url = '{$redirect_url}';
        opener.location.href = url.replace(/\&amp;/g,'&');
    {else}
        opener.location.reload();
    {/if}

    close();

</script>
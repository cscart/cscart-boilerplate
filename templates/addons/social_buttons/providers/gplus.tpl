{if $addons.social_buttons.gplus_enable == "Y" && $provider_settings.gplus.data}
<div class="g-plusone" {$provider_settings.gplus.data nofilter}></div>
<script type="text/javascript" class="cm-ajax-force">
    (function() {
        var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
        po.src = 'https://apis.google.com/js/plusone.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
    })();
</script>
{/if}

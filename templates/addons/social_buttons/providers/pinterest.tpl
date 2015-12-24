{if $addons.social_buttons.pinterest_enable == "Y" && $provider_settings.pinterest.data}
<a href="//pinterest.com/pin/create/button/?url={$provider_settings.pinterest.data.url nofilter}&amp;media={$provider_settings.pinterest.data.media nofilter}&amp;description={$provider_settings.pinterest.data.description nofilter}" {$provider_settings.pinterest.data.params nofilter}><img src="//assets.pinterest.com/images/pidgets/pinit_fg_en_rect_red_{$addons.social_buttons.pinterest_size}.png" alt="Pinterest"></a>
<script type="text/javascript">
    (function(d){
        var f = d.getElementsByTagName('SCRIPT')[0], p = d.createElement('SCRIPT');
        p.type = 'text/javascript';
        p.async = true;
        p.src = '//assets.pinterest.com/js/pinit.js';
        f.parentNode.insertBefore(p, f);
    }(document));
</script>
{/if}

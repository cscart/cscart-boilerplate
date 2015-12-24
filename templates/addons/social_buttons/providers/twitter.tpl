{if $addons.social_buttons.twitter_enable == "Y" && $provider_settings.twitter.data}
<a href="https://twitter.com/share" class="twitter-share-button" {$provider_settings.twitter.data nofilter}>Tweet</a>
<script type="text/javascript" class="cm-ajax-force">
(function(_, $) {
    $(document).ready(function () {
        if($(".twitter-share-button").length > 0){
            if (typeof (twttr) != 'undefined') {
                twttr.widgets.load();
            } else {
                $.getScript('//platform.twitter.com/widgets.js');
            }
        }
    });
}(Tygh, Tygh.$));
</script>
{/if}

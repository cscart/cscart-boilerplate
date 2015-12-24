{if $addons.social_buttons.facebook_enable == "Y" && $provider_settings.facebook.data}
<div id="fb-root"></div>
<div class="fb-like" {$provider_settings.facebook.data nofilter}></div>
<script class="cm-ajax-force">
    (function(_, $) {
        if ($(".fb-like").length > 0) {
            if (typeof (FB) != 'undefined') {
                FB.init({ status: true, cookie: true, xfbml: true });
            } else {
                $.getScript("//connect.facebook.net/{$addons.social_buttons.facebook_lang}/all.js#xfbml=1&appId={$addons.social_buttons.facebook_app_id}", function () {
                    FB.init({ status: true, cookie: true, xfbml: true });
                });
            }
        }
    }(Tygh, Tygh.$));
</script>
{/if}

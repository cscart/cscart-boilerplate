{if $addons.social_buttons.vkontakte_enable == "Y" && $provider_settings.vkontakte.data && $addons.social_buttons.vkontakte_appid}
{script src="http://vkontakte.ru/js/api/openapi.js" charset="windows-1251"}
<script type="text/javascript" class="cm-ajax-force">
    VK.init({
        apiId: '{$addons.social_buttons.vkontakte_appid}',
        onlyWidgets: true
    });
</script>

<div id="vk_like"></div>
<script type="text/javascript" class="cm-ajax-force">
    VK.Widgets.Like('vk_like', {$provider_settings.vkontakte.data nofilter});
</script>
{/if}

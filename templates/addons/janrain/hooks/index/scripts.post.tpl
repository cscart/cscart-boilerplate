{if $smarty.request.return_url}
    {assign var="escaped_return_url" value=$smarty.request.return_url|escape:url}
{else}
    {assign var="escaped_return_url" value=$config.current_url|escape:url}
{/if}

<script type="text/javascript">
//<![CDATA[
(function() {
    if (typeof window.janrain !== 'object') window.janrain = {};
    var _languages = ['ar', 'bg', 'cs', 'da', 'de', 'el', 'en', 'es', 'fi', 'fr', 'he', 'hr', 'hu', 'id', 'it', 'ja', 'lt', 'nb', 'nl', 'no', 'pl', 'pt', 'ro', 'ru', 'sk', 'sl', 'sv', 'th', 'uk', 'zh'];
    window.janrain.settings = {
        type: 'modal',
        language: fn_get_listed_lang(_languages),
        tokenUrl: '{"auth.login?return_url=`$escaped_return_url`"|fn_url:"C":"current"}'
    };

    function isReady() { janrain.ready = true; };
    if (document.addEventListener) {
        document.addEventListener("DOMContentLoaded", isReady, false);
    } else {
        window.attachEvent('onload', isReady);
    }

    var e = document.createElement('script');
    e.type = 'text/javascript';
    e.id = 'janrainAuthWidget';

    if (document.location.protocol === 'https:') {
        e.src = 'https://rpxnow.com/js/lib/{$addons.janrain.appdomain|fn_janrain_parse_app_domain}/engage.js';
    } else {
        e.src = 'http://widget-cdn.rpxnow.com/js/lib/{$addons.janrain.appdomain|fn_janrain_parse_app_domain}/engage.js';
    }

    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(e, s);
})();
//]]>
</script>

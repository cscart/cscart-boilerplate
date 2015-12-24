<p>
{if $user_type == 'P' || $user_data.user_type == 'P'}
    {__("affiliate_text_letter_footer")}
{else}
    {__("customer_text_letter_footer")}
{/if}
</p>
</body>
</html>
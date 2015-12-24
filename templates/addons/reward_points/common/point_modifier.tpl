{strip}
    {if $product.points_info.reward}
        ({if $mod_value > 0}+{else}-{/if}{__("points_lowercase", [$mod_value|abs])}{if $mod_type != "A"}%{/if})
    {/if}
{/strip}
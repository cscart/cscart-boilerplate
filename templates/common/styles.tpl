{* To use fontawesome, uncomment this line and remove {style src="./tygh/icons.less"} *}
{* <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"> *}

{styles use_scheme=true reflect_less=$reflect_less}
{hook name="index:styles"}
    
    {style src="../lib/jqueryui/1.10.1/jqueryui.less"}
    {style src="../lib/bootstrap/3.3.6/css/bootstrap.min.css"}
    {style src="icons.less"}
    {style src="styles.less"}
    
{/hook}
{/styles}

{if $runtime.customization_mode.live_editor || $runtime.customization_mode.design}
        {style src="../lib/cs-cart/design_mode.css"}
{/if}

{if $runtime.customization_mode.theme_editor}
    {style src="tygh/theme_editor.css" area="A"}
{/if}

<input type="hidden" name="dispatch" value="{$name}" />
<span class="input-group-btn">
    <button  title="{$alt}" type="submit" class="btn btn-default">
        {$text}
        {if $icon}
            <i class="glyphicon {$icon}"></i>
        {else}
            <i class="glyphicon glyphicon-triangle-right fa fa-caret-right"></i>
        {/if}
    </button>
</span>
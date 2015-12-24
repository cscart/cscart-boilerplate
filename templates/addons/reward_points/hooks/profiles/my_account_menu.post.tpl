{if $auth.user_id}
<li><a href="{"reward_points.userlog"|fn_url}" rel="nofollow">{__("my_points")}&nbsp;<span class="reward-points-count">({$user_info.points|default:"0"})</span></a></li>
{/if}
{assign var='u_type' value=$user_data.user_type|fn_get_user_type_description|lower}
{$company_data.company_name nofilter}: {__("new_profile_notification", ["[user_type]" => $u_type])}
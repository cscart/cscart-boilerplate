{assign var="statuses" value=$smarty.const.STATUSES_RETURN|fn_get_simple_statuses:true:true}
    {assign var="reason" value=$ul.reason|unserialize}
    {__("rma_return")}&nbsp;<a href="{"rma.details?return_id=`$reason.return_id`"|fn_url}"><strong>#{$reason.return_id}</strong></a>:&nbsp;{$statuses[$reason.from]}&nbsp;&#8212;&#8250;&nbsp;{$statuses[$reason.to]}

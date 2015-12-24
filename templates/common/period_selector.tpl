<div class="period row">
    <div class="col-xs-3">
        <label>{__("period")}</label>
        <select class="form-control" name="period" id="period_selects">
            <option value="A" {if $period == "A" || !$period}selected="selected"{/if}>{__("all")}</option>
            <optgroup label="=============">
                <option value="D" {if $period == "D"}selected="selected"{/if}>{__("this_day")}</option>
                <option value="W" {if $period == "W"}selected="selected"{/if}>{__("this_week")}</option>
                <option value="M" {if $period == "M"}selected="selected"{/if}>{__("this_month")}</option>
                <option value="Y" {if $period == "Y"}selected="selected"{/if}>{__("this_year")}</option>
            </optgroup>
            <optgroup label="=============">
                <option value="LD" {if $period == "LD"}selected="selected"{/if}>{__("yesterday")}</option>
                <option value="LW" {if $period == "LW"}selected="selected"{/if}>{__("previous_week")}</option>
                <option value="LM" {if $period == "LM"}selected="selected"{/if}>{__("previous_month")}</option>
                <option value="LY" {if $period == "LY"}selected="selected"{/if}>{__("previous_year")}</option>
            </optgroup>
            <optgroup label="=============">
                <option value="HH" {if $period == "HH"}selected="selected"{/if}>{__("last_24hours")}</option>
                <option value="HW" {if $period == "HW"}selected="selected"{/if}>{__("last_n_days", ["[N]" => 7])}</option>
                <option value="HM" {if $period == "HM"}selected="selected"{/if}>{__("last_n_days", ["[N]" => 30])}</option>
            </optgroup>
            <optgroup label="=============">
                <option value="C" {if $period == "C"}selected="selected"{/if}>{__("custom")}</option>
            </optgroup>
        </select>
    </div>

    <div class="col-xs-6 calendar">
        <label>{__("select_dates")}</label>
        <div class="row">
            {include file="common/calendar.tpl" date_id="f_date" date_name="time_from" date_val=$search.time_from start_year=$settings.Company.company_start_year extra="onchange=\"Tygh.$('#period_selects').val('C');\""}
            <span class='pull-left col-xs-1'>&#8211;</span>
            {include file="common/calendar.tpl" date_id="t_date" date_name="time_to" date_val=$search.time_to  start_year=$settings.Company.company_start_year extra="onchange=\"Tygh.$('#period_selects').val('C');\""}
        </div>
    </div>

    {script src="js/tygh/period_selector.js"}
    <script type="text/javascript">
    Tygh.$(document).ready(function(){$ldelim}
        Tygh.$('#{$prefix}period_selects').cePeriodSelector({$ldelim}
            from: '{$prefix}f_date',
            to: '{$prefix}t_date'
        {$rdelim});
    {$rdelim});
    </script>
</div>
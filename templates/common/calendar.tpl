{if $settings.Appearance.calendar_date_format == "month_first"}
    {assign var="date_format" value="%m/%d/%Y"}
{else}
    {assign var="date_format" value="%d/%m/%Y"}
{/if}

<div class="calendar-block col-xs-5">
    <input type="text" id="{$date_id}" name="{$date_name}" class="form-control {if $date_meta} {$date_meta}{/if} cm-calendar" value="{if $date_val}{$date_val|date_format:"`$date_format`"}{/if}" {$extra} size="10" />
    <a class="cm-external-focus" data-ca-external-focus-id="{$date_id}">
        <i class="glyphicon glyphicon-calendar fa fa-calendar" title="{__("calendar")}"></i>
    </a>
</div>

<script type="text/javascript">
(function(_, $) {$ldelim}
    $.ceEvent('on', 'ce.commoninit', function(context) {

        $('#{$date_id}').datepicker({
            changeMonth: true,
            duration: 'fast',
            changeYear: true,
            numberOfMonths: 1,
            selectOtherMonths: true,
            showOtherMonths: true,
            firstDay: {if $settings.Appearance.calendar_week_format == "sunday_first"}0{else}1{/if},
            dayNamesMin: ['{__("weekday_abr_0")}', '{__("weekday_abr_1")}', '{__("weekday_abr_2")}', '{__("weekday_abr_3")}', '{__("weekday_abr_4")}', '{__("weekday_abr_5")}', '{__("weekday_abr_6")}'],
            monthNamesShort: ['{__("month_name_abr_1")}', '{__("month_name_abr_2")}', '{__("month_name_abr_3")}', '{__("month_name_abr_4")}', '{__("month_name_abr_5")}', '{__("month_name_abr_6")}', '{__("month_name_abr_7")}', '{__("month_name_abr_8")}', '{__("month_name_abr_9")}', '{__("month_name_abr_10")}', '{__("month_name_abr_11")}', '{__("month_name_abr_12")}'],
            yearRange: '{if $start_year}{$start_year}{else}c-100{/if}:c+10',
            dateFormat: '{if $settings.Appearance.calendar_date_format == "month_first"}mm/dd/yy{else}dd/mm/yy{/if}'
        });
    });
{$rdelim}(Tygh, Tygh.$));
</script>

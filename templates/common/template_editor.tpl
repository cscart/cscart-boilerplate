<div id="template_list_menu" class="template-list-menu"><div></div><ul class="pull-left"><li></li></ul></div>

<div id="template_editor_content" title="{__("file_editor")}" class="hidden">

    <div class="templates clearfix">
            <div class="templates-tree">
                <h4>{__("templates_tree")}</h4>
                <div class="templates-tree-wrapper">
                    <ul id="template_list" class="list-unstyled templates-list">
                        <li></li>
                    </ul>
                </div>
            </div>
            <div class="templates-content">
                <div id="template_text"></div>
            </div>
    </div>

    <div class="templates-buttons buttons-container">
        {include file="common/add_close.tpl" is_js=true close_text=__("save") close_onclick="fn_save_template();" onclick="fn_restore_template();" text=__("restore_from_repository")}
    </div>

</div>

{script src="js/lib/ace/ace.js"}
{script src="js/tygh/design_mode.js"}

<script type="text/javascript">
var current_url = '{$config.current_url}';
Tygh.tr('text_page_changed', '{__("text_page_changed")|escape:"javascript"}');
Tygh.tr('text_restore_question', '{__("text_restore_question")|escape:"javascript"}');
Tygh.tr('text_template_changed', '{__("text_template_changed")|escape:"javascript"}');
</script>

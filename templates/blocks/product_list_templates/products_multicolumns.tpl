{** template-description:tmpl_grid **}

{include file="blocks/list_templates/grid_list.tpl"
    show_old_price=true
    show_price=true
    show_rating=true
    show_clean_price=true
    show_list_discount=true
    show_add_to_cart=$show_add_to_cart|default:true
    but_role="action"
    show_discount_label=true
}
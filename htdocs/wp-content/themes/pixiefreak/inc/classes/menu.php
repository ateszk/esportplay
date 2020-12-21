<?php

class pixiefreak_Menu extends Walker_Nav_Menu
{
    /**
     * @param string  $output
     * @param WP_Post $item
     * @param int     $depth
     * @param array   $args
     * @param int     $id
     *
     * @return bool
    */
    public function start_el(&$output, $item, $depth = 0, $args = array(), $id = 0)
    {
        if ($item->title === '') {
            return false;
        }

        $idPrefix = !empty($args->menu_id) ? $args->menu_id . '-item' : 'menu-item';
        $menuItemId = $idPrefix . $item->ID;

        $indent       = ($depth) ? str_repeat("\t", $depth) : '';
        $value        = '';
        $classes      = empty($item->classes) ? array() : (array) $item->classes;
        $class_names  = join(' ', apply_filters('nav_menu_css_class', array_filter($classes), $item));
        $class_names  = ' class="' . esc_attr($class_names) . '"';
        $output      .= $indent . '<li id="'. $menuItemId . '"' . $value . $class_names .'>';
        $attributes   = !empty($item->attr_title) ? ' title="' . esc_attr($item->attr_title) .'"' : '';
        $attributes  .= !empty($item->target) ? ' target="' . esc_attr($item->target) .'"' : '';
        $attributes  .= !empty($item->xfn) ? ' rel="' . esc_attr($item->xfn) .'"' : '';
        $attributes  .= !empty($item->url) ? ' href="' . esc_attr($item->url) .'"' : '';
        $item_output  = !empty($args->before) ? $args->before : null;
        $link_before  = !empty($args->link_before) ? $args->link_before : null;
        $link_after   = !empty($args->link_after) ? $args->link_after : null;
        $after        = !empty($args->after) ? $args->after : null;

        $item_output .= '<a'. $attributes .'>';
        $item_output .= $link_before . '<span class="title">' . apply_filters('the_title', $item->title, $item->ID) . '</span>' . $link_after;
        if (!empty($item->description)) { $item_output .= '<span class="subtitle">' . $item->description . '</span>'; }
        $item_output .= '</a>';
        $item_output .= $after;
        $output      .= apply_filters('walker_nav_menu_start_el', $item_output, $item, $depth, $args);
    }
}
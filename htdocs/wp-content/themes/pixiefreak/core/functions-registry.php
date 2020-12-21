<?php

add_action('wp_enqueue_scripts',    'pixiefreak_styles');
add_action('wp_enqueue_scripts',    'pixiefreak_inline_css');
add_action('wp_enqueue_scripts',    'pixiefreak_scripts');
add_action('wp_enqueue_scripts',    'pixiefreak_inline_js');

add_action('widgets_init',          'pixiefreak_add_sidebar');
add_action('init',                  'pixiefreak_listen_rewrite_action');
add_action('init',                  'pixiefreak_add_menu');
add_action('customize_register',    'pixiefreak_customize_theme');
add_action('tgmpa_register',        'pixiefreak_register_required_plugins');

add_action('after_setup_theme',     'pixiefreak_woocommerce_support');
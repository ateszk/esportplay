<?php

add_theme_support( 'custom-logo', array(
	'height'        => 60,
	'width'         => 230,
	'flex-width'    => true,
	'flex-height'   => true,
) );
add_theme_support('post-thumbnails');
add_theme_support('title-tag');

add_image_size('news-big',    1920, 1080);
add_image_size('news-medium', 1280, 720);
add_image_size('news-small',  280, 350);

add_theme_support('automatic-feed-links');

add_filter('mce_buttons', 'pixiefreak_pagebreak_button', 1, 2);
add_filter( 'document_title_parts', 'pixiefreak_change_page_title' );
add_filter('comment_form_default_fields', 'pixiefreak_comment_fields');

add_filter( 'body_class','pixiefreak_body_classes' );
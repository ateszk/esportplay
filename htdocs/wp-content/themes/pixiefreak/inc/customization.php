<?php

// Function for customization
function customizer_library_add_sections( $sections, $wp_customize ) {
    foreach ($sections as $section ) {
        if (!isset($section['description'])) {
            $section['description'] = FALSE;
        }
        
        $wp_customize->add_section( $section['id'], $section );
    }
}

// Theme customization
function pixiefreak_customize_theme( $wp_customize ){
    $wp_customize->add_section('pixiefreak_general_customize', array(
        'title' => esc_html__('General', 'pixiefreak'),
        'priority' => 31
    ));

    // Primary color
    $wp_customize->add_setting('pixiefreak_primary_color', array(
        'default' => '#6931f9',
        'type' => 'theme_mod',
        'transport' => 'refresh',
        'sanitize_callback' => 'sanitize_hex_color'
    ));
    
    $wp_customize->add_control(new WP_Customize_Color_Control($wp_customize, 'primary_color', array(
        'label' => esc_html__('Primary Color', 'pixiefreak' ),
        'section' => 'pixiefreak_general_customize',
        'settings' => 'pixiefreak_primary_color',
    )));
}
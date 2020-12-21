<?php

/*
 * Define Customizer Panels
 */
add_action('customize_register', 'clpt_customize_register');
function clpt_customize_register($wp_customize)
{

    include_once('clpt_customizer_panel.php');

    /*
     * First we need to register a panel type. Without it, class inheritance won't work and we can't change the template of the panel.
     */
    $wp_customize->register_panel_type( 'CLPT_Customizer_Panel' );
    $wp_customize->add_panel(
        new CLPT_Customizer_Panel(
            $wp_customize,
            'clpt_panel',
            array(
                'priority'       => 31,
                'capability'     => 'edit_theme_options',
                'title'          => __('Custom Login Page', 'custom-login-page-templates'),
                'description'    => __('This section allows you to customize the login page of your website.', 'custom-login-page-templates'),
            )
        )
    );

    /*
     * Predefined Templates Section
     */
    $wp_customize->add_section( 'clpt_templates_section', array(
        'priority'  => 5,
        'title'     => __('Templates', 'custom-login-page-templates'),
        'panel'     => 'clpt_panel',
        )
    );

    $wp_customize->add_setting('clpt_template', array(
        'type'          => 'option',
        'capability'    => 'edit_theme_options',
        )
    );



    $wp_customize->add_control( 'clpt_template' , array(
            'label'    => __( 'Choose a Template', 'custom-login-page-templates' ),
            'section'  => 'clpt_templates_section',
            'priority' => 5,
            'settings' => 'clpt_template',
            'type'     => 'select',
            'choices'  => array(
                ''              => __( 'WordPress Default', 'custom-login-page-templates' ),
                'bootstrap'     => __( 'Bootstrap', 'custom-login-page-templates' ),
                'light'         => __( 'Light', 'custom-login-page-templates' ),
                'dark'          => __( 'Dark', 'custom-login-page-templates' ),
                'totheside'     => __( 'To The Side', 'custom-login-page-templates' ),
                'businesscard'  => __( 'Business Card', 'custom-login-page-templates' ),
            )
        )
    );

    /*
     * Logo Section
     */
    $wp_customize->add_section('clpt_images_section', array(
        'priority'  => 10,
        'title'     => __('Images', 'custom-login-page-templates'),
        'panel'     => 'clpt_panel',
        )
    );


    $wp_customize->add_setting('clpt_logo', array(
        'type'          => 'option',
        'capability'    => 'edit_theme_options',
        )
    );

    $wp_customize->add_control(
        new WP_Customize_Image_Control( $wp_customize, 'clpt_logo',
            array(
                'label'         => __('Login Logo', 'custom-login-page-templates'),
                'description'   => 'Will be limited to max 320x90px.',
                'section'       => 'clpt_images_section',
                'priority'      => 5,
                'settings'      => 'clpt_logo'
            )
        )
    );

    $wp_customize->add_setting('clpt_bg_image', array(
        'type'          => 'option',
        'capability'    => 'edit_theme_options',
        )
    );

    $wp_customize->add_control(
        new WP_Customize_Image_Control( $wp_customize , 'clpt_bg_image',
            array(
                'label'         => __('Background Image', 'custom-login-page-templates'),
                'description'   => 'Please use 1080p images. They will be centered and repeated.',
                'section'       => 'clpt_images_section',
                'priority'      => 10,
                'settings'      => 'clpt_bg_image'
            )
        )
    );


    $wp_customize->add_setting('clpt_potd', array(
            'type'          => 'option',
            'capability'    => 'edit_theme_options',
        )
    );

    $wp_customize->add_control(
        'clpt_potd',
        array(
            'label'         => __( 'Enable Picture Of The Day', 'custom-login-page-templates' ),
            'description'   => __( 'Uses Wikimedia Picture Of The Day API to bring you a beautiful new background image every day. This will overwrite your custom background image.', 'custom-login-page-templates' ),
            'section'       => 'clpt_images_section',
            'settings'      => 'clpt_potd',
            'type'          => 'radio',
            'choices'       => array(
                                'on'  => __( 'On', 'custom-login-page-templates' ),
                                'off' => __( 'Off', 'custom-login-page-templates' ),
            ),
        )
    );

    /* Custom CSS */
    $wp_customize->add_section( 'clpt_custom_css', array(
        'title'                 => __( 'Additional CSS' ),
        'priority'              => 20,
        'description_hidden'    => true,
        'panel'                 => 'clpt_panel',
        'description'           => sprintf( '%s<br /><a href="%s" class="external-link" target="_blank">%s<span class="screen-reader-text">%s</span></a>',
            __( 'CSS allows you to customize the appearance and layout of your site with code. Separate CSS is saved for each of your themes. In the editing area the Tab key enters a tab character. To move below this area by pressing Tab, press the Esc key followed by the Tab key.' ),
            esc_url( __( 'https://codex.wordpress.org/CSS' ) ),
            __( 'Learn more about CSS' ),
            __( '(link opens in a new window)' )
        ),
    ) );

    $custom_css_setting = new WP_Customize_Custom_CSS_Setting( $wp_customize, sprintf( 'custom_css[%s]', 'clpt' ), array(
        'capability'    => 'edit_theme_options',
        'default'       => sprintf( "/*\n%s\n*/", __( "You can add your own CSS here.\n\nClick the help icon above to learn more." ) ),
        'stylesheet'    => 'clpt'
    ) );
    $wp_customize->add_setting( $custom_css_setting );

    $wp_customize->add_control( 'clpt_custom_css', array(
        'type'     => 'textarea',
        'section'  => 'clpt_custom_css',
        'settings' => array( 'default' => $custom_css_setting->id ),
        'input_attrs' => array(
            'class' => 'code', // Ensures contents displayed as LTR instead of RTL.
        ),
    ) );

}

add_action( 'login_footer', 'clpt_customizer_style' );
function clpt_customizer_style() {
    $clpt_logo = esc_url_raw( get_option('clpt_logo') );
    $clpt_bg_image = esc_url_raw( get_option('clpt_bg_image') );
    $clpt_template = sanitize_text_field( get_option('clpt_template') );

    if( !empty($clpt_template) && file_exists(CLPT_DIR . 'templates/' . $clpt_template . '/style.css') ){
        wp_enqueue_style( 'clpt_' . $clpt_template, CLPT_URL . 'templates/' . $clpt_template . '/style.css', false );
    }

    ?>
    <style type="text/css">
        html, html > body {
        <?php if( !empty($clpt_bg_image)) : ?>
            background: url(<?php echo $clpt_bg_image; ?>) center center repeat !important;
            background-size: cover !important;
        <?php endif; ?>
        }

        body.login div#login h1:first-child{
        <?php if( !empty($clpt_logo)) : ?>
            display:none !important;
        <?php endif; ?>
        }
        .login form{
            margin-top: 0 !important;
        }
        #clpt-logo {
            text-align: center;
            padding: 20px;
        }
     </style>
    <?php

    $clpt_potd = sanitize_text_field( get_option('clpt_potd') );
    if ( $clpt_potd == 'on' ){
        // saving the picture of the day in a tranzient so we don't query on every wp-login.php load wikimedia
        if ( false === ( $clpt_potd_url = esc_url_raw( get_transient( 'clp_potd_url' ) ) ) ) {
            $clpt_potd_url = esc_url_raw( clpt_get_potd() );
            set_transient( 'clp_potd_url', $clpt_potd_url, 12 * HOUR_IN_SECONDS );
        }
        ?>
        <style type="text/css">
            html, html > body {
            <?php if( !empty($clpt_potd_url)) : ?>
                background: url(<?php echo $clpt_potd_url; ?>) center center repeat !important;
                background-size: cover !important;
            <?php endif; ?>
            }
        </style>
        <?php
    }

    wp_enqueue_script( 'customize-selective-refresh' );
}


add_action( 'login_head', 'clpt_wp_custom_css_cb', 101);
function clpt_wp_custom_css_cb() {
    $styles = wp_get_custom_css('clpt');
    if ( $styles || is_customize_preview() ) : ?>
        <style type="text/css" id="wp-custom-css">
            <?php echo strip_tags( $styles ); // Note that esc_html() cannot be used because `div &gt; span` is not interpreted properly. ?>
        </style>
    <?php endif;
}

function clpt_get_potd(){
    // first get picture of the day name (we can't get the url in single query)
    $request = wp_remote_get( 'https://commons.wikimedia.org/w/api.php?action=parse&format=json&formatversion=2&text=[[File:{{Potd/{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY2}}}}]]&prop=images&contentmodel=wikitext' );

    if( is_wp_error( $request ) ) {
        return false; // Bail early
    }
    $body = wp_remote_retrieve_body( $request );
    $data = json_decode( $body, true );
    $image_name = $data['parse']['images'][0];

    // then get the actual url to the picture of the day
    $request = wp_remote_get( "https://commons.wikimedia.org/w/api.php?action=query&format=json&titles=File:". $image_name . "&prop=imageinfo&iiprop=url&iiurlwidth=2000px" );

    if( is_wp_error( $request ) ) {
        return false; // Bail early
    }
    $body = wp_remote_retrieve_body( $request );
    $data = json_decode( $body, true );
    $img_data = reset( $data['query']['pages'] );
    $img_url = $img_data['imageinfo'][0]['thumburl'];

    return $img_url;
}

/*
 * Load up the logo as an image, not a background image, so we can have proper scaling without fixed width and height.
 */
add_filter( 'login_message', 'clpt_login_logo');
function clpt_login_logo( $message ){
    $clpt_logo = esc_url_raw(get_option('clpt_logo'));
    $site_title = sanitize_text_field( get_bloginfo( 'name', 'display' ) );
    $logo_html = '';

    if( !empty($clpt_logo) ){
        $logo_html .= "<h2 id='clpt-logo'><img style='max-width: 100%;' src='{$clpt_logo}' alt='{$site_title}'/></h2>";
    }
    return $logo_html . $message;
}

/*
 * We need to trigger wp_footer in login_footer for the customizer to work correctly.
 */
add_action('login_footer', 'clpt_trigger_wp_footer');
function clpt_trigger_wp_footer(){
    if (isset( $_GET['customize_changeset_uuid'] )){
        do_action( 'wp_footer' );
	}
}


/**
 * Binds JS handlers to make Theme Customizer preview reload changes asynchronously.
 */
function clpt_customize_preview_js() {
    wp_enqueue_script( 'clpt-customizer', CLPT_URL . 'assets/customizer.js', array( 'customize-preview' ), CLPT_VERSION, true );
}
add_action( 'customize_preview_init', 'clpt_customize_preview_js' );

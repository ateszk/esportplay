<?php
/**
 * Plugin Name: Custom Login Page Templates
 * Description: Custom Login Page Templates plugin allows you to easily customize your login page straight from WordPress Customizer! Comes with awesome looking predefined templates.
 * Author: Cozmoslabs, Madalin Ungureanu, Antohe Cristian,
 * Author URI:  https://www.cozmoslabs.com/
 * Version: 1.0

== Copyright ==
Copyright 2017 Cozmoslabs (www.cozmoslabs.com)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
*/


define( 'CLPT_VERSION','0.1' );
define( 'CLPT_DIR', plugin_dir_path( __FILE__ ) );
define( 'CLPT_URL', plugin_dir_url( __FILE__ ) );
define( 'CLPT_TRANSLATE_DIR', CLPT_DIR . '/translation');
define( 'CLPT_TRANSLATE_DOMAIN', 'custom-login-page-templates');

/**
 * Initialize the translation for the Plugin.
 *
 * @since v.0.1
 *
 * @return null
 */

function clpt_init_translation()
{
    $current_theme = wp_get_theme();
    if( !empty( $current_theme->stylesheet ) && file_exists( get_theme_root().'/'. $current_theme->stylesheet .'/local_clpt_lang' ) )
        load_plugin_textdomain( 'custom-login-page-templates', false, basename( dirname( __FILE__ ) ).'/../../themes/'.$current_theme->stylesheet.'/local_clpt_lang' );
    else
        load_plugin_textdomain( 'custom-login-page-templates', false, basename(dirname(__FILE__)) . '/languages/' );
}

add_action('init', 'clpt_init_translation', 8);

include( CLPT_DIR . 'includes/customizer.php' );

/**
 * Add admin bar link to Custom Login Page settings
 *
 * @since v.0.1
 *
 * @return null
 */
add_action( 'admin_bar_menu', 'clpt_link_login_customizer', 999 );
function clpt_link_login_customizer( WP_Admin_Bar $wp_admin_bar ) {
    $title = '<span class="ab-icon dashicons-admin-settings" style="margin-top: 3px; color: #fff;"></span><span class="ab-label">' . _x( 'Custom Login', 'custom-login-page-templates' ) . '</span>';
    $args = array(
        'id'    => 'clpt_customizer',
        'title' => $title,
        'href'  => admin_url('customize.php?autofocus[panel]=clpt_panel&url=') . wp_login_url(),
        'meta'  => array( 'class' => 'clpt-custom-login-settings' )
    );
    $wp_admin_bar->add_menu( $args );
}

/**
 * Add Plugin Action Links to Custom Login Page settings
 *
 * @since v.1.0
 *
 * @return array
 */
add_filter( 'plugin_action_links_' . plugin_basename(__FILE__), 'clpt_add_action_links' );

function clpt_add_action_links ( $links ) {
    $mylinks = array(
        '<a href="' . admin_url('customize.php?autofocus[panel]=clpt_panel&url=') . wp_login_url() . '">Settings</a>',
    );
    return array_merge( $links, $mylinks );
}

function clpt_admin_style() {
    wp_enqueue_style( 'admin_style', CLPT_URL . 'assets/admin.css',array(), CLPT_VERSION, false );
}
add_action( 'admin_enqueue_scripts', 'clpt_admin_style' );
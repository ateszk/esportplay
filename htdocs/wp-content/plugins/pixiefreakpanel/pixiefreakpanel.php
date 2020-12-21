<?php

/**
 * The plugin bootstrap file
 *
 * @wordpress-plugin
 * Plugin Name:       PixieFreak - Panel
 * Plugin URI:        http://www.pixiesquad.com
 * Description:       This plugin is intended to help customers with the Website administration and customization.
 * Version:           1.0.98
 * Author:            PixieSquad
 * Author URI:        http://www.pixiesquad.com/
 * Text Domain:       pixiefreak
 * Domain Path:       /languages
 */

// If this file is called directly, abort.
if (!defined('WPINC')) {
    die;
}

$app = function() {
    require __DIR__ . '/vendor/autoload.php';
    return (new FusionFramework\Kernel());
};

$includes = function() {
    require_once __DIR__ . '/pixiefreakpanel-widget.php';
    require_once __DIR__ . '/pixiefreakpanel-i18n.php';
    require_once __DIR__ . '/pixiefreakpanel-activator.php';
    require_once __DIR__ . '/pixiefreakpanel-deactivator.php';
};

$includes();

register_activation_hook  (__FILE__, function() { PixieFreakPanel_Activator::activate(); });
register_deactivation_hook(__FILE__, function() { PixieFreakPanel_Deactivator::deactivate(); });

$app()->run();

define('PIXIEFREAK_ACTIVATED', true);
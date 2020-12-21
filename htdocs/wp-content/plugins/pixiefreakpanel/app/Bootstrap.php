<?php

namespace PixieFreakPanel;

use FusionFramework\Request;
use PixieFreakPanel\Service\DatabaseToolkit;

class Bootstrap
{
    public function initMenu()
    {
        return [
            'parent' =>
            [
                'route' => 'general_index',
                'page_title'  => esc_html__('PixiePanel', 'pixiefreakpanel'),
                'optional_title' => esc_html__('General', 'pixiefreakpanel'),
                'menu_title' => esc_html__('PixiePanel', 'pixiefreakpanel'),
                'icon'   => plugin_dir_url(__FILE__) . '../resources/assets/admin/images/panel-logo.png',
            ],
            [
                'route' => 'about_index',
                'page_title' => esc_html__('About', 'pixiefreakpanel'),
                'menu_title' => esc_html__('About', 'pixiefreakpanel'),
                'icon' => ''
            ],
            [
                'route' => 'game_index',
                'page_title' => esc_html__('Game', 'pixiefreakpanel'),
                'menu_title' => esc_html__('Game', 'pixiefreakpanel'),
                'icon' => ''
            ],
            [
                'route' => 'gallery_index',
                'page_title' => esc_html__('Gallery', 'pixiefreakpanel'),
                'menu_title' => esc_html__('Gallery', 'pixiefreakpanel'),
                'icon' => ''
            ],
            [
                'route' => 'team_index',
                'page_title' => esc_html__('Team', 'pixiefreakpanel'),
                'menu_title' => esc_html__('Team', 'pixiefreakpanel'),
                'icon' => ''
            ],
            [
                'route' => 'tournament_index',
                'page_title' => esc_html__('Tournament', 'pixiefreakpanel'),
                'menu_title' => esc_html__('Tournament', 'pixiefreakpanel'),
                'icon' => ''
            ],
            [
                'route' => 'match_index',
                'page_title' => esc_html__('Match', 'pixiefreakpanel'),
                'menu_title' => esc_html__('Match', 'pixiefreakpanel'),
                'icon' => ''
            ],
            [
                'route' => 'stream_index',
                'page_title' => esc_html__('Stream', 'pixiefreakpanel'),
                'menu_title' => esc_html__('Stream', 'pixiefreakpanel'),
                'icon' => ''
            ],
            [
                'route' => 'gear_index',
                'page_title' => esc_html__('Gear', 'pixiefreakpanel'),
                'menu_title' => esc_html__('Gear', 'pixiefreakpanel'),
                'icon' => ''
            ],
            [
                'route' => 'sponsor_index',
                'page_title' => esc_html__('Sponsor', 'pixiefreakpanel'),
                'menu_title' => esc_html__('Sponsor', 'pixiefreakpanel'),
                'icon' => ''
            ]
        ];
    }

    public function initStyles(Request $request)
    {
	    $pageParam = $request->getRaw('page');
        if (!empty($pageParam)) {
            if (strpos($pageParam, 'pixiefreakpanel') !== false) {
                $theme_ver    = '1.0.0';
                $include_type = 'all';
                $access_map   = ['label' => 0, 'path' => 1, 'empty_arr' => 2, 'version' => 3, 'type' => 4];
                $styleArray   = [
                    ['pixiefreak_admin_style', 'assets/admin/css/style.admin.css', array(), $theme_ver, $include_type],
                    ['font-awesome', 'assets/css/font-awesome.min.css', array(), $theme_ver, $include_type],
                    ['jquery-ui-structure', 'assets/admin/css/jquery-ui.structure.min.css', array(), $theme_ver, $include_type],
                    ['jquery-ui-theme', 'assets/admin/css/jquery-ui.theme.min.css', array(), $theme_ver, $include_type],
                    ['jquery-ui', 'assets/admin/css/jquery-ui.min.css', array(), $theme_ver, $include_type],
                    ['datatables', 'assets/admin/css/datatables.min.css', array(), $theme_ver, $include_type],
                    ['tipsy', 'assets/admin/css/tipsy.css', array(), $theme_ver, $include_type],
                    ['jquery_datetimepicker', 'assets/admin/css/jquery.datetimepicker.min.css', array(), $theme_ver, $include_type],
                    ['select2', 'assets/admin/css/select2.min.css', array(), $theme_ver, $include_type],
                    ['iconpicker', 'assets/admin/css/iconpicker.min.css', array(), $theme_ver, $include_type],
                    ['bracket', 'assets/admin/css/jquery.bracket.min.css', array(), $theme_ver, $include_type]
                ];

                add_action('admin_enqueue_scripts', function() use($styleArray, $access_map) {
                    foreach ($styleArray as $item) {
                        wp_enqueue_style(
                            $item[$access_map['label']],
                            assets($item[$access_map['path']]),
                            $item[$access_map['empty_arr']],
                            $item[$access_map['version']],
                            $item[$access_map['type']]
                        );
                    }

                    $scriptArray = [
                        ['datablesjs', 'assets/admin/js/datatables.min.js', array('jquery'), '1.10.12', true],
                        ['jquery_tipsy', 'assets/admin/js/jquery.tipsy.js', array('jquery'), '1.0.0', true],
                        ['jquery_datetimepicker_fulljs', 'assets/admin/js/jquery.datetimepicker.full.min.js', array('jquery'), '1.0.0', true],
                        ['jquery_uijs', 'assets/admin/js/jquery-ui.min.js', array('jquery'), '1.12.1', true],
                        ['pixiehuge_admin_script', 'assets/admin/js/script.admin.js', array('jquery'), '1.0.0', true],
                        ['select2', 'assets/admin/js/select2.min.js', array('jquery'), '1.0.0', true],
                        ['iconpicker', 'assets/admin/js/iconpicker.min.js', array('jquery'), '1.0.0', true],
                        ['brackets', 'assets/admin/js/jquery.bracket.min.js', array('jquery'), '1.0.0', true],
                        ['panzoom', 'assets/admin/js/panzoom.min.js', array('jquery'), '1.0.0', true],
                        ['clipboard', 'assets/admin/js/clipboard.min.js', array('jquery'), '1.0.0', true]
                    ];

                    wp_enqueue_media();

                    foreach ($scriptArray as $item) {
                        wp_enqueue_script(
                            $item[0],
                            assets($item[1]),
                            $item[2],
                            $item[3],
                            $item[4]
                        );
                    }

                    wp_localize_script(
                        'pixiefreakpanel_admin_script',
                        'ajax_object',
                        array(
                            'ajax_url' => admin_url('admin-ajax.php'),
                            'pixiefreakpanel_value' => false
                        )
                    );
                });
            }
        }
    }

    public function initDatabaseToolkit()
    {
        DatabaseToolkit::migrate();
    }
}
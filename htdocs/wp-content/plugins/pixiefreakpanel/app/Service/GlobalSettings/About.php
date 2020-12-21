<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class About extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'about';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'who_we_are' => 'WHO WE ARE',
        'some_more' => 'Some more information about us',
        'media_kit' => [
            'show' => true,
            'link' => '#',
            'text' => 'Media kit'
        ],

        'all_teams' => [
            'show' => true,
            'link' => '#',
            'text' => 'All Teams'
        ],

        'about_first' => [
            'icon' => 'fas fa-map-marker-alt',
            'title' => 'Belgrade, Serbia',
            'subtitle' => 'Address 3',
            'show' => false
        ],

        'about_second' => [
            'icon' => 'fas fa-map-marker-alt',
            'title' => 'Belgrade, Serbia',
            'subtitle' => 'Address 3',
            'show' => false
        ],

        'about_third' => [
            'icon' => 'fas fa-map-marker-alt',
            'title' => 'Belgrade, Serbia',
            'subtitle' => 'Address 3',
            'show' => false
        ],

        'about_fourth' => [
            'icon' => 'fas fa-map-marker-alt',
            'title' => 'Belgrade, Serbia',
            'subtitle' => 'Address 3',
            'show' => false
        ],
    ];
}
<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class Teams extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'teams';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'teams_banner_image' => '',
        'title' => 'Welcome to the Teams',
        'subtitle' => 'Here you can find all of the teams we have',
        'cta_left' => [
            'text' => 'All',
            'link' => '#',
            'show' => true
        ],

        'cta_right' => [
            'text' => 'Popular',
            'link' => '#',
            'show' => true
        ]
    ];
}
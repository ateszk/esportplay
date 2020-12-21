<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class Tournament extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'tournament';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'tournament_banner_image' => '',
        'title' => 'Latest Matches & Results',
        'subtitle' => 'This is live update of matches our teams playing right now',
        'cta_top' => [
            'text' => 'Register a team',
            'link' => '#',
            'show' => true
        ],

        'cta_left' => [
            'text' => 'Buy tickets',
            'link' => '#',
            'show' => true
        ],

        'cta_right' => [
            'text' => 'Place to stay',
            'link' => '#',
            'show' => true
        ]
    ];
}
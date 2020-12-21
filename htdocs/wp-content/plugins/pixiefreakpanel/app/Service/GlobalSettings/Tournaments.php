<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class Tournaments extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'tournaments';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'banner_image' => '',
        'title' => 'Our tournaments',
        'subtitle' => 'This is where you can browse through our tournaments',
        'cta_left' => [
            'text' => 'Upcoming',
            'link' => '#',
            'show' => true
        ],

        'cta_right' => [
            'text' => 'Results',
            'link' => '#',
            'show' => true
        ]
    ];
}
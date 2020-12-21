<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class Sponsor extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'sponsor';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'banner_image' => '',
        'title' => 'Sponsors & Partners',
        'subtitle' => 'They support us so lets show them some love',
        'show_title' => true,
        'show_subtitle' => true,
        'cta' => [
            'text' => 'Become a sponsor',
            'link' => '#',
            'show' => true
        ]
    ];
}
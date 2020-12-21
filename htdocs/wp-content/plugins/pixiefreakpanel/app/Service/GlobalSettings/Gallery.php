<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class Gallery extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'gallery';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'banner_image' => '',
        'title' => 'See our events in pictures',
        'subtitle' => 'Here you can find our product to purchase'
    ];
}
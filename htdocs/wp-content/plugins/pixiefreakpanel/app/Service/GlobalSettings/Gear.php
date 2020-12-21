<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class Gear extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'gear';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'cta' => [
            'text' => 'Become a player',
            'link' => '#',
            'show' => true
        ]
    ];
}
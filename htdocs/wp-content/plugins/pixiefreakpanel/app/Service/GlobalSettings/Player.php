<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class Player extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'player';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'cta_player' => [
            'text' => 'Become a sponsor',
            'link' => '#',
            'show' => true,
            'icon' => 'fab fa-twitch'
        ]
    ];
}
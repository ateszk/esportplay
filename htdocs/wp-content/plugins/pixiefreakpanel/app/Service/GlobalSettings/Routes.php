<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class Routes extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'routes';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'routes' => [
            'match' => [
                'query' => 'match_slug',
                'route' => 'match'
            ],

            'player' => [
                'query' => 'player_slug',
                'route' => 'player'
            ],

            'team' => [
                'query' => 'team_slug',
                'route' => 'team'
            ],

            'tournament' => [
                'query' => 'tournament_slug',
                'route' => 'tournament'
            ],

            'stream' => [
                'query' => 'stream_slug',
                'route' => 'stream'
            ],

            'bracket' => [
                'query' => 'bracket_slug',
                'route' => 'bracket'
            ]
        ]
    ];
}
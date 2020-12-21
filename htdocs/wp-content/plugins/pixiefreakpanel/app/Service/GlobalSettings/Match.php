<?php

namespace PixieFreakPanel\Service\GlobalSettings;


class Match extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'match';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'title' => 'Latest Matches & Results',
        'subtitle' => 'This is live update of matches our teams playing right now',
        'cta_left' => [
            'text' => 'Upcoming',
            'link' => '#',
            'show' => true
        ],

        'cta_right' => [
            'text' => 'Results',
            'link' => '#',
            'show' => true
        ],

        'cta_match' => [
            'text' => 'Article',
            'link' => '#',
            'show' => true
        ],

        'banner_image' => ''
    ];
}
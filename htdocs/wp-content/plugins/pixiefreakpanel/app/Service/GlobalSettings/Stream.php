<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class Stream extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'stream';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'banner_image' => '',
	    'title' => 'Streams',
	    'subtitle' => 'This is where you can browse through our streams',
        'api' => [
            'youtube' => '',
            'twitch' => '',
            'mixer' => ''
        ]
    ];
}
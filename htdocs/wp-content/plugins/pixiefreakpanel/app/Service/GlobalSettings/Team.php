<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class Team extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'team';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'team_banner_image' => '',
        'roster_title' => 'Meet the Roster',
        'roster_subtitle' => 'Our roster our pride all on one place',
	    'cta' => [
	    	'text' => 'Become a player',
		    'link' => 'http://pixiesquad.com',
		    'show' => true,
	    ]
    ];
}
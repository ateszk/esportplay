<?php

namespace PixieFreakPanel\Service\GlobalSettings;

class General extends Resolver
{
    /**
     * @var string $moduleName
     */
    protected $moduleName = 'general';

    /**
     * @var array $constraints
     */
    protected $constraints = [
        'social' => [
            'facebook' => 'https://www.facebook.com/PixieSquad/',
            'twitter' => 'https://twitter.com/ThePixieSquad',
            'twitch' => 'https://www.twitch.tv/pixiesquad',
            'discord' => 'https://discord.gg/6njhTNg',
            'youtube' => 'https://www.youtube.com/channel/UCOgbPXMkH0IpL-co4X6T1Qg?&ab_channel=PixieSquad',
            'instagram' => 'https://www.instagram.com/ragebite',
            'steam' => 'https://steamcommunity.com/id/pixiesquad'
        ],
	    'default_background' => '',
	    'news_background' => '',
	    'notfound_background' => '',
        'copyright' => 'Powered by Pixiesquad 2013-2018 All Rights Reserved.',
        'show_socials_footer' => false,
        'show_search' => true,
        'show_copyright' => true,
        'section_order' => [
            'News',
            'Team',
            'Stream',
            'Tournament',
            'Shop',
            'Match Result',
        ],

        'section_visibility' => [
            'news' => true ,
            'team' => false,
            'stream' => false,
            'tournament' => false,
            'shop' => false,
            'match-result' => false,
        ],

        'get_in_touch_1' => [
            'icon' => 'fas fa-edit',
            'title' => 'Title 1',
            'subtitle' => 'Sub 1',
            'show' => false
        ],

        'get_in_touch_2' => [
            'icon' => 'fas fa-edit',
            'title' => 'Title 2',
            'subtitle' => 'Sub 2',
            'show' => false
        ],

        'get_in_touch_3' => [
            'icon' => 'fas fa-edit',
            'title' => 'Title 3',
            'subtitle' => 'Sub 3',
            'show' => false
        ],

        'get_in_touch_4' => [
            'icon' => 'fas fa-edit',
            'title' => 'Title 4',
            'subtitle' => 'Sub 4',
            'show' => false
        ],
    ];
}
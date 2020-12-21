<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;

class Stream extends ORM
{
    const TYPES = [
        1 => 'Youtube',
        2 => 'Twitch'
    ];

    /**
     * @var string $table
     */
    protected $table = 'stream';
}
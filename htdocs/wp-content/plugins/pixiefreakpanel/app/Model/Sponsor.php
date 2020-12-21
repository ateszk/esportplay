<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;

class Sponsor extends ORM
{
    const TYPE_DEFAULT = 1;
    const TYPE_HEAD    = 2;

    /**
     * @var string $table
     */
    protected $table = 'sponsor';
}
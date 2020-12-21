<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;

class Achievement extends ORM implements SortableInterface
{
    /**
     * @var string $table
     */
    protected $table = 'achievement';
}
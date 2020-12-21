<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;

class Gallery extends ORM implements SortableInterface
{
    /**
     * @var string $table
     */
    protected $table = 'gallery';
}
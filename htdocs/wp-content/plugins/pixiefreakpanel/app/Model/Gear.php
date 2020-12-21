<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;

class Gear extends ORM implements SortableInterface
{
    const TYPES = [
        'Mouse',
        'Headphones',
        'Keyboard'
    ];

    /**
     * @var string $table
     */
    protected $table = 'gear';
}
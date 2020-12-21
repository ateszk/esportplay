<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;

class Slider extends ORM implements SortableInterface
{
	/**
	 * @var string $table
	 */
	protected $table = 'slider';
}
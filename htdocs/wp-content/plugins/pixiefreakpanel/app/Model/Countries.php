<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;

class Countries extends ORM
{
    public static function all()
    {
        $string = preg_replace('/[\x00-\x1F\x80-\xFF]/', '', file_get_contents(__DIR__ .'/../../resources/languages.json'));
        return json_decode($string, true);
    }

    public static function findAll($shortCode)
    {
        foreach (self::all() as $country) {
            if ($country['code'] === $shortCode) {
                return $country;
            }
        }
    }
}
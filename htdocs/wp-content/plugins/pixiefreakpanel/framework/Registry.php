<?php

namespace FusionFramework;

class Registry
{
    /**
     * @var array $collection
     */
    protected static $collection = [];

    /**
     * @param  string $key
     * @return mixed
     */
    public static function get($key)
    {
        return self::$collection[$key];
    }

    /**
     * @param  string $key
     * @param  mixed $val
     * @return mixed
     */
    public static function set($key, $val)
    {
        return self::$collection[$key] = $val;
    }

    /**
     * @param  string $key
     * @return bool
     */
    public static function has($key)
    {
        return array_key_exists($key, self::$collection);
    }
}
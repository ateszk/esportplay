<?php

class pixiefreak_Settings implements ArrayAccess, Countable
{
    public function __construct()
    {}

    public function __set($name, $value)
    {
        return;
    }

    public function __get($name)
    {
        return;
    }

    public function __call($name, $arguments)
    {
        return;
    }

    public static function __callStatic($name, $arguments)
    {
        return;
    }

    public static function __set_state($an_array)
    {
        return;
    }

    public function offsetExists($offset)
    {
        return;
    }

    public function offsetGet($offset)
    {
        return;
    }

    public function offsetSet($offset, $value)
    {
        return;
    }

    public function offsetUnset($offset)
    {
        return;
    }

    public function count()
    {
        return 0;
    }

    public function get($test)
    {
        return [];
    }

    public function shouldShow($key)
    {
        return false;
    }
}
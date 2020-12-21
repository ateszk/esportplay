<?php

namespace FusionFramework\Database;

/**
 * Class ORMFusionObject
 *
 * @package FusionFramework\Database
 */
class ORMFusionObject implements \ArrayAccess, \Countable
{
    /**
     * @return string
     */
    public function toJSON()
    {
        return json_encode($this, JSON_NUMERIC_CHECK);
    }

    /**
     * @return array
     */
    public function toArray()
    {
        return (array) $this;
    }

    /**
     * @return string
     */
    public function __toString()
    {
        header('Content-Type: application/json;charset=utf-8');
        return json_encode($this, JSON_NUMERIC_CHECK);
    }

    /**
     * @param mixed $offset
     * @return mixed
     */
    public function offsetExists($offset)
    {
        return in_array($this->{$offset}, get_object_vars($this));
    }

    /**
     * @param mixed $offset
     * @return mixed
     */
    public function offsetGet($offset)
    {
        return $this->{$offset};
    }

    /**
     * @param mixed $offset
     * @param mixed $value
     * @return mixed
     */
    public function offsetSet($offset, $value)
    {
        $this->{$offset} = $value;
        return $this;
    }

    /**
     * @param mixed $offset
     * @return mixed
     */
    public function offsetUnset($offset)
    {
        unset($this->{$offset});
        return $this;
    }

    /**
     * @return int
     */
    public function count()
    {
        return count($this->toArray());
    }
}
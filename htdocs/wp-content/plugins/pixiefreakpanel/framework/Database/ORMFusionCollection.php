<?php

namespace FusionFramework\Database;

/**
 * Class ORMFusionCollection
 *
 * @package FusionFramework\Database
 */
class ORMFusionCollection implements \ArrayAccess, \Countable
{
    /**
     * @var null $pagination
     */
    private static $pagination = null;

    /**
     * @param mixed $offset
     * @param mixed $value
     */
    public function offsetSet($offset, $value)
    {
        $this->$offset = $value;
    }

    /**
     * @return string
     */
    public function toJSON()
    {
        return json_encode($this->toArray(), JSON_NUMERIC_CHECK);
    }

    /**
     * @return array
     */
    public function toArray()
    {
        $array = [];
        foreach ($this as  $fusionObj) {
            $array[] = (array) $fusionObj;
        }

        return $array;
    }

    /**
     * @param  string $field
     * @return array
     */
    public function ORMlist($field)
    {
        $list = [];
        foreach ($this as  $item) {
            $list[] = $item->{$field};
        }

        return $list;
    }

    /**
     * @param  int $offset
     * @return null
     */
    public function first($offset = 0)
    {
        return isset($this->$offset) ? $this->$offset : null;
    }

    /**
     * @return null
     */
    public function last()
    {
        $offset = count($this->toArray()) - 1;
        return isset($this->$offset) ? $this->$offset : null;
    }

    /**
     * @param  mixed $offset
     * @return bool
     */
    public function offsetExists($offset)
    {
        return isset($this->$offset);
    }

    /**
     * @param mixed $offset
     */
    public function offsetUnset($offset)
    {
        unset($this->$offset);
    }

    /**
     * @param  mixed $offset
     * @return null
     */
    public function offsetGet($offset)
    {
        return isset($this->$offset) ? $this->$offset : null;
    }

    /**
     * @param  string $key
     * @return null
     */
    public function item($key)
    {
        return isset($this->$key) ? $this->$key : null;
    }

    /**
     * @return string
     */
    public function __toString()
    {
        header('Content-Type: application/json;charset=utf-8');
        return  $this->toJSON();
    }

    /**
     * @return bool
     */
    public function isEmpty()
    {
        return empty($this->toArray());
    }

    /**
     * @return bool
     */
    public function isNotEmpty()
    {
        return !$this->isEmpty();
    }

    /**
     * @return int
     */
    public function count()
    {
        return count($this->toArray());
    }

    /**
     * @param  string $key
     * @return ORMFusionCollection
     */
    public function pluck($key)
    {
        $collection = new self();
        foreach ($this->toArray() as $item) {
            $collection[] = $item[$key];
        }

        return $collection;
    }

    /**
     * @return array
     */
    public function getPagination()
    {
        return !self::$pagination ? [] : self::$pagination;
    }

    /**
     * @param  array $pagination
     * @return $this
     */
    public function setPagination($pagination)
    {
        self::$pagination = $pagination;
        return $this;
    }
}
<?php

namespace FusionFramework;


class Request implements \ArrayAccess
{
    /**
     * Request parameters bag.
     *
     * @var array
     */
    protected $bag = [];

    /**
     * Array of Files from request.
     *
     * @var mixed
     */
    protected $files;

    /**
     * Request constructor.
     */
    public function __construct()
    {
        $this->bag = $this->getParameters();
    }

    /**
     * @return array|mixed
     */
    public function all()
    {
        return $this->bag;
    }

    /**
     * @param  array|string $variadic
     * @return mixed
     */
    public function only($variadic)
    {
        $filteredParameterBag = [];
        if (is_array($variadic)) {
            foreach ($variadic as $parameter) {
            	$param = $this->get($parameter);
                if (!empty($param)) {
                    $filteredParameterBag[] = $this->get($parameter);
                }
            }

            return $filteredParameterBag;
        }

        if (is_string($variadic)) {
            return $this->get($variadic);
        }

        return $filteredParameterBag;
    }

    /**
     * Returns true if parameter exist in parameters bag.
     *
     * @param  $parameter
     * @return bool
     */
    public function has($parameter)
    {
        return array_key_exists($parameter, $this->bag);
    }

    /**
     * Returns parameter from parameter bag if exists.
     *
     * @param  string $parameter
     * @return mixed
     */
    public function get($parameter)
    {
        if ($this->has($parameter)) {
            return $this->bag[$parameter];
        }
    }

    /**
     * @param  string $string
     * @param  string $param
     * @return mixed
     */
    public function getFromString($string, $param)
    {
        $parts = parse_url($string);
        parse_str($parts['query'], $query);
        return $query[$param];
    }

    /**
     * @param  string $parameter
     * @param  mixed  $value
     * @return Request
     */
    public function set($parameter, $value)
    {
        $this->bag[$parameter] = $value;
        return $this;
    }

    /**
     * @param  string $parameter
     * @param  mixed  $value
     * @return $this
     */
    public function add($parameter, $value)
    {
        $this->bag[$parameter] = $value;
        return $this;
    }

    /**
     * @param  string $parameter
     * @return mixed
     */
    public function getRaw($parameter)
    {
        $data = $this->isGet() ? $_GET : $_POST;
        return @$data[$parameter];
    }

    /**
     * Returns all parameter for current request method.
     *
     * @return mixed
     */
    protected function getParameters()
    {
        if ($this->isGet()) {
            $get = $_GET;
            return $get;
        } elseif ($this->isPost()) {
            $post = $_POST;
            return $post;
        }
    }

    /**
     * Return array of files from $_FILEs super global.
     *
     * @return array|mixed
     */
    public function getFiles()
    {
        $this->files = $this->injectFilesFromSuperGlobal();
        return $this->files;
    }

    /**
     * Returns specified parameter from parameter bag.
     *
     * @param  $parameter
     * @return mixed
     */
    public function getParameter($parameter)
    {
        $parameters = $this->bag;
        if (!empty($parameters) && array_key_exists($parameter, $parameters)) {
            return $parameters[$parameter];
        }
    }

    /**
     * Method injectFilesFromSuperGlobal used to inject data from
     * $_FILES super global to Request class property files.
     *
     * @return array|mixed
     */
    protected function injectFilesFromSuperGlobal()
    {
        // Return empty array if files not found.
        if (!isset($_FILES) || empty($_FILES)) {
            return [];
        }

        $files = [];
        foreach ($_FILES as $fileName => $file) {
            $files[$fileName] = $file;
        }

        // Return shifted file values.
        return $files;
    }

    /**
     * @return bool
     */
    public function isPost()
    {
        return $_SERVER['REQUEST_METHOD'] === 'POST';
    }

    /**
     * @return bool
     */
    public function isGet()
    {
        return $_SERVER['REQUEST_METHOD'] === 'GET';
    }

    /**
     * @return bool
     */
    public function isXmlHttpRequest()
    {
        return !empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
    }

    /**
     * @param  $name
     * @param  $value
     * @return Request
     */
    public function __set($name, $value)
    {
        $this->set($name, $value);
        return $this;
    }

    /**
     * @param  $name
     * @return mixed
     */
    public function __get($name)
    {
        return $this->get($name);
    }

    /**
     * @param mixed $offset
     * @return mixed
     */
    public function offsetExists($offset)
    {
        return array_key_exists($offset, $this->bag);
    }

    /**
     * @param mixed $offset
     * @return mixed
     */
    public function offsetGet($offset)
    {
        return $this->__get($offset);
    }

    /**
     * @param mixed $offset
     * @param mixed $value
     * @return mixed
     */
    public function offsetSet($offset, $value)
    {
        $this->__set($offset, $value);
        return $this;
    }

    /**
     * @param mixed $offset
     * @return mixed
     */
    public function offsetUnset($offset)
    {
        unset($this->bag[$offset]);
        return $this;
    }
}
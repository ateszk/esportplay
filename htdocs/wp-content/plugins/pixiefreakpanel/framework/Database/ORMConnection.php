<?php

namespace FusionFramework\Database;

class ORMConnection
{
    /**
     * @var null|ORMConnection
     */
    protected static $instance = null;

    /**
     * @var \PDO
     */
    protected $connection;

    /**
     * Connection constructor.
     */
    protected function __construct()
    {
        try
        {
            $user = DB_USER;
            $pass = DB_PASSWORD;
            $host = DB_HOST;
            $name = DB_NAME;
            $this->connection = new \PDO('mysql:host='.$host.';dbname='.$name.';charset=utf8', $user, $pass);
            $this->connection->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
            $this->connection->setAttribute(\PDO::ATTR_EMULATE_PREPARES, false);
        } catch (\Exception $ex) {
            die('Error establishing a DB connection.');
        }
    }

    protected function __clone()
    {}

    /**
     * @return null|ORMConnection
     */
    public static function getInstance()
    {
        if (!isset(static::$instance)) {
            static::$instance = new static;
        }

        return static::$instance;
    }

    /**
     * @return \PDO
     */
    public function getConnection()
    {
        return $this->connection;
    }
}
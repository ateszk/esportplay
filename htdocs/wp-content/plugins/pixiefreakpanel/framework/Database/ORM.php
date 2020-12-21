<?php

namespace FusionFramework\Database;

use PixieFreakPanel\Model\SortableInterface;

/**
 * Class ORM
 *
 * @package FusionFramework\Database
 */
class ORM
{
    protected
        $connection = null,
        $columns,
        $sql,
        $bindValues,
        $getSQL,
        $where,
        $orWhere,
        $whereCount = 0,
        $isOrWhere = false,
        $rowCount = 0,
        $limit,
        $orderBy,
        $lastIdInserted = 0,
        $table,
        $groupBy
    ;

    /**
     * @var array $pagination
     */
    private $pagination = [
        'previousPage' => null,
        'currentPage'  => 1,
        'nextPage' => null,
        'lastPage' => null,
        'totalRows' => null
    ];

    /**
     * ORM constructor.
     */
    public function __construct()
    {
        global $wpdb;
        $this->connection = ORMConnection::getInstance()->getConnection();
        $this->table = $wpdb->prefix .'pixiefreak_'. $this->table;
    }

    /**
     * @return ORM|static
     */
    public static function query()
    {
        return new static();
    }

    /**
     * @param  string $query
     * @param  array  $args
     * @param  bool   $quick
     * @return array|ORMFusionCollection|int
     */
    public function raw($query, $args = [], $quick = false)
    {
        $this->resetQuery();
        $this->getSQL = $query = trim($query);
        $this->bindValues = $args;

        if ($quick) {
            $statement = $this->connection->prepare($query);
            $statement->execute($this->bindValues);
            $this->rowCount = $statement->rowCount();

            return $statement->fetchAll();
        }

        if (strpos(strtoupper($query), 'SELECT') === 0) {
            $statement = $this->connection->prepare($query);
            $statement->execute($this->bindValues);
            $this->rowCount = $statement->rowCount();

            $rows = $statement->fetchAll(\PDO::FETCH_CLASS, ORMFusionObject::class);
            $collection = new ORMFusionCollection();
            $x = 0;

            foreach ($rows as $key => $row) {
                $collection->offsetSet($x++, $row);
            }

            return $collection;
        }

        $this->getSQL = $query;
        $statement = $this->connection->prepare($query);
        $statement->execute($this->bindValues);

        return $statement->rowCount();
    }

    /**
     * @return int
     */
    public function exec()
    {
        $this->sql .= $this->where;
        $this->getSQL = $this->sql;
        $statement = $this->connection->prepare($this->sql);
        $statement->execute($this->bindValues);
        return $statement->rowCount();
    }

    private function resetQuery()
    {
        $this->sql =
        $this->bindValues =
        $this->limit =
        $this->orderBy =
        $this->getSQL =
        $this->where =
        $this->orWhere = null;

        $this->whereCount =
        $this->rowCount =
        $this->lastIdInserted = 0;

        $this->isOrWhere = false;
    }

    /**
     * @param  null $id
     * @return $this|int
     */
    public function delete($id = null)
    {
        $this->resetQuery();

        $table = $this->table;
        $this->sql = "DELETE FROM `{$table}`";
        if (isset($id)) {
            if (is_null($id)) {
                $this->sql .= ' WHERE `id` = ?';
                $this->bindValues[] = $id;
            } else if (is_array($id)) {
                $idsArray = $id;
                $x = 0;

                foreach ($idsArray as $param) {
                    if ($x === 0) {
                        $this->where .= ' WHERE ';
                        $x++;
                    } else {
                        if ($this->isOrWhere) {
                            $this->where .= ' OR ';
                        } else {
                            $this->where .= ' AND ';
                        }

                        $x++;
                    }

                    $firstParam = reset($param);
                    if (($countParam = count($param)) == 1) {
                        $this->where .= '`id` = ?';
                        $this->bindValues[] = $firstParam;
                    } else if ($countParam == 2) {
                        $operatorFound = false;
                        foreach ($operators = explode(',', '=,>,<,>=,>=,<>') as $operator) {
                            if (strpos($firstParam, $operator) !== false) {
                                $operatorFound = true;
                                break;
                            }
                        }

                        $this->where = $operatorFound
                            ? $this->where .= $firstParam .'?'
                            : $this->where .= '`'.trim($firstParam).'` = ?';
                        ;

                        $this->bindValues[] = $firstParam;
                    } else if ($countParam == 3) {
                        $this->where .= '`'.trim(reset($param)). '` '. $param[1]. ' ?';
                        $this->bindValues[] = $param[2];
                    }
                }
            } else if (is_integer($id) || is_numeric($id)) {
                $this->sql .= ' WHERE `id` = ?';
                $this->bindValues[] = $id;
            }

            $this->sql .= $this->where;
            $this->getSQL = $this->sql;
            $statement = $this->connection->prepare($this->sql);
            $statement->execute($this->bindValues);

            return $statement->rowCount();
        }

        return $this;
    }

    /**
     * @param  array $fields
     * @param  null  $id
     * @return ORM
     */
    public function update($fields = [], $id = null)
    {
        $this->resetQuery();
        $set ='';
        $x = 1;

        $table = $this->table;
        foreach ($fields as $column => $field) {
            $set .= "`$column` = ?";
            $this->bindValues[] = $field;
            if ($x < count($fields)) {
                $set .= ", ";
            }

            $x++;
        }

        $this->sql = "UPDATE `{$table}` SET $set";
        if (isset($id)) {
            if (is_numeric($id)) {
                $this->sql .= " WHERE `id` = ?";
                $this->bindValues[] = $id;
            } else if (is_array($id)) {
                $arr = $id;
                $x = 0;
                foreach ($arr as $param) {
                    if ($x == 0) {
                        $this->where .= ' WHERE ';
                        $x++;
                    } else {
                        if ($this->isOrWhere) {
                            $this->where .= ' Or ';
                        } else {
                            $this->where .= ' AND ';
                        }

                        $x++;
                    }

                    $countParam = count($param);
                    if ($countParam == 1) {
                        $this->where .= "`id` = ?";
                        $this->bindValues[] =  $param[0];
                    } else if ($countParam == 2) {
                        $operatorFound = false;
                        foreach ($operators = explode(',', '=,>,<,>=,>=,<>') as $operator) {
                            if (strpos($param[0], $operator) !== false) {
                                $operatorFound = true;
                                break;
                            }
                        }

                        $this->where = $operatorFound
                            ? $this->where .= $param[0].' ?'
                            : $this->where .= '`'.trim($param[0]).'` = ?'
                        ;

                        $this->bindValues[] =  $param[1];
                    } else if ($countParam == 3) {
                        $this->where .= '`'.trim($param[0]). '` '. $param[1]. ' ?';
                        $this->bindValues[] =  $param[2];
                    }
                }
            }

            $this->sql .= $this->where;
            $this->getSQL = $this->sql;
            $statement = $this->connection->prepare($this->sql);
            $statement->execute($this->bindValues);

            return $statement->rowCount();
        }

        return $this;
    }

    /**
     * @param  array $fields
     * @return string|int
     */
    public function insert($fields = [])
    {
        $this->resetQuery();

        $table = $this->table;
        $keys = implode('`, `', array_keys($fields));
        $values = '';
        $x=1;

        foreach ($fields as $field => $value) {
            $values .='?';
            $this->bindValues[] =  $value;
            if ($x < count($fields)) {
                $values .=', ';
            }

            $x++;
        }

        $this->sql = "INSERT INTO `{$table}` (`{$keys}`) VALUES ({$values})";
        $this->getSQL = $this->sql;
        $statement = $this->connection->prepare($this->sql);
        $statement->execute($this->bindValues);
        $this->lastIdInserted = $this->connection->lastInsertId();

        $lastId = $this->lastIdInserted;
        $this->resetQuery();

        return $lastId;
    }

    /**
     * @return int
     */
    public function lastId()
    {
        return $this->lastIdInserted;
    }

    /**
     * @param $columns
     * @return $this
     */
    public function select($columns)
    {
        foreach ($columns = explode(',', $columns) as $key => $column) {
            $columns[$key] = trim($column);
        }

        $columns = implode('`, `', $columns);
        $this->columns = "`{$columns}`";

        return $this;
    }

    /**
     * @return ORM
     */
    public function where()
    {
        if ($this->whereCount == 0) {
            $this->where .= ' WHERE ';
            $this->whereCount += 1;
        } else {
            $this->where .= ' AND ';
        }

        $this->isOrWhere= false;

        $numArgs = func_num_args();
        $args = func_get_args();
        if ($numArgs == 1) {
            if (is_numeric($args[0])) {
                $this->where .= '`id` = ?';
                $this->bindValues[] =  $args[0];
            } else if (is_array($arr = reset($args))) {
                $x = 0;
                foreach ($arr as  $param) {
                    if ($x == 0) {
                        $x++;
                    } else {
                        if ($this->isOrWhere) {
                            $this->where .= ' Or ';
                        } else {
                            $this->where .= ' AND ';
                        }

                        $x++;
                    }
                    
                    $countParam = count($param);
                    if ($countParam == 1) {
                        $this->where .= '`id` = ?';
                        $this->bindValues[] =  $param[0];
                    } else if ($countParam == 2) {
                        $operatorFound = false;
                        foreach ($operators = explode(',', '=,>,<,>=,>=,<>,LIKE,like') as $operator) {
                            if ( strpos($param[0], $operator) !== false ) {
                                $operatorFound = true;
                                break;
                            }
                        }

                        $this->where = $operatorFound 
                            ? $this->where .= reset($param). ' ?'
                            : $this->where .= '`' .trim(reset($param)). '` = ?'
                        ;
                        
                        $this->bindValues[] =  $param[1];
                    } else if ($countParam == 3) {
                        $this->where .= '`' .trim(reset($param)). '` '. $param[1]. ' ?';
                        $this->bindValues[] =  $param[2];
                    }
                }
            }
        } else if ($numArgs == 2) {
            $operatorFound = false;
            foreach ($operators = explode(',', "=,>,<,>=,>=,<>,LIKE,like") as $operator) {
                if (strpos(reset($args), $operator) !== false) {
                    $operatorFound = true;
                    break;
                }
            }

            $this->where .= '`'.trim($args[0]).'` = ?';
            if ($operatorFound) {
                $this->where .= $args[0].' ?';
            }

            $this->bindValues[] =  $args[1];

        } else if ($numArgs == 3) {
            $this->where .= "`".trim($args[0]). "` ". $args[1]. " ?";
            $this->bindValues[] =  $args[2];
        }

        return $this;
    }

    /**
     * @param $id
     * @return null|ORMFusionObject
     */
    public function find($id)
    {
        return $this->where('id', $id)->get()->first();
    }

    public function groupBy($column)
    {
        $expr = ' GROUP BY ';
        $this->groupBy = !empty($this->groupBy) ? $this->groupBy .' '. $expr .$column : $expr . $column;
        return $this;
    }

    /**
     * @return $this
     */
    public function orWhere()
    {
        if ($this->whereCount == 0) {
            $this->where .= ' WHERE ';
            $this->whereCount+=1;
        } else {
            $this->where .= ' OR ';
        }
        
        $this->isOrWhere= true;
        $numArgs = func_num_args();
        $args = func_get_args();
        if ($numArgs == 1) {
            if (is_numeric($args[0])) {
                $this->where .= "`id` = ?";
                $this->bindValues[] =  $args[0];
            } else if (is_array($args[0])) {
                $arr = $args[0];
                $x = 0;
                foreach ($arr as  $param) {
                    if ($x == 0) {
                        $x++;
                    } else {
                        if ($this->isOrWhere) {
                            $this->where .= ' Or ';
                        } else {
                            $this->where .= ' AND ';
                        }
                        $x++;
                    }
                    
                    $countParam = count($param);
                    if ($countParam == 1) {
                        $this->where .= "`id` = ?";
                        $this->bindValues[] =  $param[0];
                    } else if ($countParam == 2) {
                        $operatorFound = false;
                        foreach ($operators = explode(',', "=,>,<,>=,>=,<>") as $operator) {
                            if (strpos($param[0], $operator) !== false) {
                                $operatorFound = true;
                                break;
                            }
                        }

                        $this->where .= '`'.trim($param[0]).'` = ?';
                        if ($operatorFound) {
                            $this->where .= $param[0].' ?';
                        }
                        $this->bindValues[] =  $param[1];
                    } else if ($countParam == 3) {
                        $this->where .= "`".trim($param[0]). "` ". $param[1]. " ?";
                        $this->bindValues[] =  $param[2];
                    }
                }
            }
        } else if ($numArgs == 2) {
            $operatorFound = false;
            foreach ($operators = explode(',', "=,>,<,>=,>=,<>") as $operator) {
                if (strpos($args[0], $operator) !== false) {
                    $operatorFound = true;
                    break;
                }
            }

            $this->where .= "`".trim($args[0])."` = ?";
            if ($operatorFound) {
                $this->where .= $args[0]." ?";
            }

            $this->bindValues[] =  $args[1];
        } else if ($numArgs == 3) {
            $this->where .= "`".trim($args[0]). "` ". $args[1]. " ?";
            $this->bindValues[] =  $args[2];
        }

        return $this;
    }

    /**
     * @return ORMFusionCollection
     */
    public function get()
    {
        if ($this instanceof SortableInterface) {
            $this->orderBy('order_number', 'ASC');
        }

        $this->assembleQuery();
        $this->getSQL = $this->sql;

        $statement = $this->connection->prepare($this->sql);

        $statement->execute($this->bindValues);
        $this->rowCount = $statement->rowCount();

        $rows = $statement->fetchAll(\PDO::FETCH_CLASS, ORMFusionObject::class);
        $collection = new ORMFusionCollection();

        $x=0;
        foreach ($rows as $key => $row) {
            $collection->offsetSet($x++,$row);
        }

        $this->resetQuery();

        return $collection;
    }

    private function assembleQuery()
    {
        if ($this->columns !== null) {
            $select = $this->columns;
        } else {
            $select = "*";
        }

        $this->sql = "SELECT $select FROM `$this->table`";

        if ($this->where !== null) {
            $this->sql .= $this->where;
        }

        if ($this->orderBy !== null) {
            $this->sql .= $this->orderBy;
        }

        if ($this->limit !== null) {
            $this->sql .= $this->limit;
        }

        if ($this->groupBy !== null) {
            $this->sql .= $this->groupBy;
        }
    }

    /**
     * @return array
     */
    public function rawGet()
    {
        $this->assembleQuery();
        $this->getSQL = $this->sql;

        $statement = $this->connection->prepare($this->sql);
        $statement->execute($this->bindValues);
        $this->rowCount = $statement->rowCount();

        return $statement->fetchAll();
    }

    /**
     * @param $limit
     * @param null $offset
     * @return $this
     */
    public function limit($limit, $offset=null)
    {
        $this->limit = is_null($offset)
            ? $this->limit = ' LIMIT ' . $limit
            : $this->limit = ' LIMIT ' .$limit. ' OFFSET ' . $offset
        ;

        return $this;
    }

    /**
     * Sort result in a particular order according to a column name
     *
     * @param  string $fieldName
     * @param  string $order
     * @return object
     */
    public function orderBy($fieldName, $order = 'ASC')
    {
        $fieldName = trim($fieldName);
        $order = trim(strtoupper($order));

        if ($fieldName !== null && ($order == 'ASC' || $order == 'DESC')) {
            if ($this->orderBy ==null ) {
                $this->orderBy = " ORDER BY $fieldName $order";
            } else {
                $this->orderBy .= ", $fieldName $order";
            }
        }

        return $this;
    }

    /**
     * @param  string     $page
     * @param  int|string $limit
     * @return array|ORMFusionCollection
     */
    public function paginate($page, $limit)
    {
        $countSQL = "SELECT COUNT(*) FROM `$this->table`";
        if ($this->where !== null) {
            $countSQL .= $this->where;
        }

        $statement = $this->connection->prepare($countSQL);
        $statement->execute($this->bindValues);
        $totalRows = $statement->fetch(\PDO::FETCH_NUM)[0];

        $offset = ($page - 1) * $limit;
        $this->pagination['currentPage'] = $page;
        $this->pagination['lastPage'] = ceil($totalRows/$limit);
        $this->pagination['nextPage'] = $page++;
        $this->pagination['previousPage'] = $page--;
        $this->pagination['totalRows'] = $totalRows;

        if ($this->pagination['lastPage'] ==  $page) {
            $this->pagination['nextPage'] = null;
        }

        if ($page == 1) {
            $this->pagination['previousPage'] = null;
        }

        if ($page > $this->pagination['lastPage']) {
            return [];
        }

        $this->assembleQuery();

        $sql = $this->sql . " LIMIT {$limit} OFFSET {$offset}";
        $this->getSQL = $sql;

        $statement = $this->connection->prepare($sql);
        $statement->execute($this->bindValues);
        $this->rowCount = $statement->rowCount();

        $rows = $statement->fetchAll(\PDO::FETCH_CLASS, ORMFusionObject::class);
        $collection = new ORMFusionCollection();

        $x = 0;
        foreach ($rows as $key => $row) {
            $collection->offsetSet($x++, $row);
        }

        $collection->setPagination($this->pagination());
        return $collection;
    }

    /**
     * @return mixed
     */
    public function count()
    {
        $countSQL = "SELECT COUNT(*) FROM `$this->table`";

        if ($this->where !== null) {
            $countSQL .= $this->where;
        }

        if ($this->limit !== null) {
            $countSQL .= $this->limit;
        }

        $statement = $this->connection->prepare($countSQL);
        $statement->execute($this->bindValues);

        $this->getSQL = $countSQL;

        return $statement->fetch(\PDO::FETCH_NUM)[0];
    }

    /**
     * @param  string $page
     * @param  int    $limit
     * @return array
     */
    public function rawPaginate($page, $limit)
    {
        $countSQL = "SELECT COUNT(*) FROM `$this->table`";
        if ($this->where !== null) {
            $countSQL .= $this->where;
        }

        $statement = $this->connection->prepare($countSQL);
        $statement->execute($this->bindValues);
        $totalRows = reset($statement->fetch(\PDO::FETCH_NUM));

        $offset = ($page-1) * $limit;
        $this->pagination['currentPage'] = $page;
        $this->pagination['lastPage'] = ceil($totalRows/$limit);
        $this->pagination['nextPage'] = $page++;
        $this->pagination['previousPage'] = $page--;
        $this->pagination['totalRows'] = $totalRows;

        if ($this->pagination['lastPage'] ==  $page) {
            $this->pagination['nextPage'] = null;
        }

        if ($page == 1) {
            $this->pagination['previousPage'] = null;
        }

        if ($page > $this->pagination['lastPage']) {
            return [];
        }

        $this->assembleQuery();

        $sql = $this->sql . " LIMIT {$limit} OFFSET {$offset}";
        $this->getSQL = $sql;

        $statement = $this->connection->prepare($sql);
        $statement->execute($this->bindValues);
        $this->rowCount = $statement->rowCount();

        return $statement->fetchAll();
    }

    /**
     * @param  string $table
     * @return ORM|static
     */
    public function setTable($table = '')
    {
        $this->table = $table;
        return $this;
    }

    /**
     * @return array
     */
    public function pagination()
    {
        return $this->pagination;
    }

    /**
     * @return mixed
     */
    public function getQuery()
    {
        return $this->sql . $this->where . '; ';
    }

    /**
     * @return int
     */
    public function getCount()
    {
        return $this->rowCount;
    }

    /**
     * @return int
     */
    public function rowCount()
    {
        return $this->rowCount;
    }

    /**
     * @param  string                              $junctionClassName
     * @param  string                              $collectionClassName
     * @param  string                              $junctionTableColName
     * @param  string                              $collectionTableColName
     * @param  ORMFusionObject|ORMFusionCollection $ORMFusionObject
     * @return array
     */
    public function collect(
        $junctionClassName,
        $collectionClassName,
        $junctionTableColName,
        $collectionTableColName,
        ORMFusionObject $ORMFusionObject
    )
    {
        $collection = [];
        foreach ($junctionClassName::query()->where($junctionTableColName, $ORMFusionObject->id)->get() as $item) {
            $collection[] = $collectionClassName::query()
                ->where('id', $item->{$collectionTableColName})
                ->get()
                ->first()
            ;
        }

        return $collection;
    }
}
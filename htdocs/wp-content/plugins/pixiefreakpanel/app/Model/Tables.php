<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;

/**
 * Class Tables
 *
 * @package pixiefreakpanel\Model
 */
class Tables
{
    /**
     * @return array
     */
    public static function dump()
    {
        global $wpdb;

        $output = [];
        foreach (glob(__DIR__ . '/*.php') as $file) {
            $normalizedTableName = substr($file, strrpos($file, '/') + 1);
            $normalizedTableName = str_replace('.php', '', $normalizedTableName);
            $normalizedTableName = strtolower(preg_replace('/[A-Z]/', '_$0', $normalizedTableName));
            $normalizedTableName = ltrim($normalizedTableName, '_');

            if (in_array($normalizedTableName, ['tables', 'countries', 'sortable_interface'])) { continue; }

            $normalizedTableName = $wpdb->prefix . 'pixiefreak_' . $normalizedTableName;
            $output[] =  $normalizedTableName;
        }

        return $output;
    }

    public static function clear()
    {
        foreach (self::dump() as $tableName) {
            ORM::query()->raw("DROP TABLE {$tableName};");
        }
    }
}
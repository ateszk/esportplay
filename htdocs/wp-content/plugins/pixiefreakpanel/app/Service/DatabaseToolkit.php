<?php

namespace PixieFreakPanel\Service;

use FusionFramework\Database\ORM;
use PixieFreakPanel\Service\GlobalSettings\About;
use PixieFreakPanel\Service\GlobalSettings\Gallery;
use PixieFreakPanel\Service\GlobalSettings\Gear;
use PixieFreakPanel\Service\GlobalSettings\General;
use PixieFreakPanel\Service\GlobalSettings\Match;
use PixieFreakPanel\Service\GlobalSettings\Player;
use PixieFreakPanel\Service\GlobalSettings\Resolver;
use PixieFreakPanel\Service\GlobalSettings\Routes;
use PixieFreakPanel\Service\GlobalSettings\Sponsor;
use PixieFreakPanel\Service\GlobalSettings\Stream;
use PixieFreakPanel\Service\GlobalSettings\Team;
use PixieFreakPanel\Service\GlobalSettings\Teams;
use PixieFreakPanel\Service\GlobalSettings\Tournament;
use PixieFreakPanel\Service\GlobalSettings\Tournaments;

class DatabaseToolkit
{
    public static function migrate($shouldMigrate = false)
    {
        if ($shouldMigrate) {
            require_once plugin_dir_path( dirname( __FILE__ ) ) . '/../database/scheme.php';
        }
    }

    public static function seed()
    {
        self::seedSettingsTable();
    }

    protected static function seedSettingsTable()
    {
        global $wpdb;
        $ORMQuery = ORM::query();
        $orm = $ORMQuery->setTable($wpdb->prefix .'pixiefreak_'. 'global_settings');
        foreach (DatabaseToolkit::getSettingsClasses() as $class) {
            $settingsClassObject = new $class();
            if ($settingsClassObject instanceof Resolver) {
                foreach ($settingsClassObject->getConstraints() as $key => $value) {
                    $record = $orm
                        ->where('module_name', $settingsClassObject->getModuleName())
                        ->where('key', $key)
                        ->get()
                    ;

                    if ($record->isEmpty()) {
                        if (is_array($value)) {
                            $orm->insert([
                                'module_name' => $settingsClassObject->getModuleName(),
                                'key' => $key,
                                'value' => json_encode($value, JSON_UNESCAPED_SLASHES|JSON_FORCE_OBJECT)
                            ]);

                            continue;
                        }

                        if (is_bool($value)) {
                            $orm->insert([
                                'module_name' => $settingsClassObject->getModuleName(),
                                'key' => $key,
                                'value' => $value
                            ]);

                            continue;
                        }

                        if (is_string($value)) {
                            $orm->insert([
                                'module_name' => $settingsClassObject->getModuleName(),
                                'key' => $key,
                                'value' => $value
                            ]);

                            continue;
                        }
                    }
                }
            }
        }
    }

    /**
     * @return array
     */
    public static function getSettingsClasses()
    {
        return [
            General::class,
            About::class,
            Sponsor::class,
            Gear::class,
            Stream::class,
            Gallery::class,
            Team::class,
            Teams::class,
            Player::class,
            Routes::class,
            Tournament::class,
            Tournaments::class,
            Match::class
        ];
    }
}
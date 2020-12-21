<?php

namespace PixieFreakPanel\Service\GlobalSettings;

use FusionFramework\Database\ORMFusionCollection;
use PixieFreakPanel\Model\GlobalSettings;

abstract class Resolver
{
    /**
     * @var string $module_name
     */
    protected $moduleName  = 'general';

    /**
     * @var array $moduleData
     */
    protected $moduleData  = [];

    /**
     * @var array $constraints
     */
    protected $constraints = [];

    /**
     * @var GlobalSettings $globalSettingsQuery
     */
    protected $globalSettingsQuery;

    /**
     * Resolver constructor.
     */
    public function __construct()
    {
        $this->globalSettingsQuery = GlobalSettings::query();

        $moduleData = $this->globalSettingsQuery
            ->where('module_name', $this->moduleName)
            ->get()
        ;

        $this->castTypes($moduleData);


        $this->moduleData = $moduleData;
    }

    /**
     * @param  ORMFusionCollection $data
     * @return array|bool|mixed|object
     */
    protected function castTypes(&$data)
    {
        if ($data instanceof ORMFusionCollection && $data->isNotEmpty()) {
            foreach ($data as &$record) {
                if ($record->value === 'false') {
                    $record->value = false;
                    return;
                }

                if ($record->value === 'true') {
                    $record->value = true;
                    return;
                }

                if ($record->value === 0) {
                    $record->value = 0;
                    return;
                }

                if ($record->value === 1) {
                    $record->value = 1;
                    return;
                }

                if (strpos($record->value, '{') !== false || strpos($record->value, '}') !== false) {
                    $record->value = json_decode($record->value, true);
                }
            }
        }

        return;
    }

    /**
     * @param  string $key
     * @param  bool   $isBooleanCheck
     * @return mixed
     */
    public function get($key, $isBooleanCheck = false)
    {
        foreach ($this->moduleData as $forKey => $value) {
            if (in_array($key, $value = $value->toArray())) {
                return $isBooleanCheck ? (bool) $value['value'] : $value['value'];
            }
        }

        $value = '';
        $constraints = $this->getConstraints();
        $shouldNormalize = false;
        if (strpos($key, '[') !== false || strpos($key, ']') !== false) {
            $accessors = array_filter(explode('#', str_replace(['[', ']'], '#', $key)));
            $shouldNormalize = true;
        }

        if (strpos($key, '.') !== false) {
            $shouldNormalize = true;
            $accessors = explode('.', $key);
        }

        if ($shouldNormalize) {
            foreach ($accessors as $accessor) {
                foreach ($this->moduleData->toArray() as $key => $data) {
                    if (in_array($accessor, $data)) {
                        $value = $data['value'];
                        continue 2;
                    }
                }


                if (empty($value)) {
                    $value = $isBooleanCheck
                        ? (bool) $constraints[$accessor]
                        : $constraints[$accessor]
                    ;
                } else if (array_key_exists($accessor, $value)) {
                    $value = $value[$accessor];
                } else  {
                    $value = $isBooleanCheck
                        ? (bool) $value[$accessor]
                        : $value[$accessor]
                    ;
                }
            }

            return $value;
        }

        return $isBooleanCheck
            ? (bool) $this->getConstraints()[$key]
            : $this->getConstraints()[$key]
        ;
    }

    /**
     * @return array
     */
    public function getConstraints()
    {
        return $this->constraints;
    }

    /**
     * @return mixed
     */
    public function getModuleName()
    {
        return $this->moduleName;
    }

    /**
     * @param  string $key
     * @return mixed
     */
    public function shouldShow($key)
    {
        return (bool) $this->get($key);
    }

    /**
     * @param  string $key
     * @return ORM
     */
    public function getValue($key)
    {
        return $this->get($key);
    }
}
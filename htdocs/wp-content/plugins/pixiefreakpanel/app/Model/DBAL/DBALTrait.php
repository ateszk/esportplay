<?php

namespace PixieFreakPanel\Model\DBAL;

use FusionFramework\Request;
use PixieFreakPanel\Model\GlobalSettings;
use PixieFreakPanel\Service\GlobalSettings\General;
use PixieFreakPanel\Service\GlobalSettings\Resolver;

trait DBALTrait
{
    protected $request;

    /**
     * DBALTrait constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        $this->request = $request;
    }

    /**
     * @param  string $className
     * @param  array  $excludeParams
     * @return DBALTrait
     */
    public function updateConstraints($className = General::class, $excludeParams = [])
    {
        $request  = $this->request;
        $model    = GlobalSettings::query();
        $settings = new $className();
        if ($settings instanceof Resolver) {
            foreach ($settings->getConstraints() as $key => $constraints) {

                $uniqueKey = $settings->getModuleName() .'_'. $key;
                if (in_array($uniqueKey, $excludeParams)) {
                    continue;
                }

                $this->preUpdate($uniqueKey, $constraints);

                if ($request->has($uniqueKey)) {
                    $data = str_replace($uniqueKey, $key, $this->resolveType($uniqueKey));
                    $model
                        ->update(['value' => $data])
                        ->where('module_name', $settings->getModuleName())
                        ->where('key', $key)
                        ->exec()
                    ;

                    $this->postUpdate($key, $constraints);
                }
            }
        }

        return $this;
    }

    /**
     * @param  string $key
     * @return mixed|string
     */
    private function resolveType($key)
    {
        return is_array($this->request->get($key))
            ? json_encode($this->request->get($key), JSON_UNESCAPED_SLASHES|JSON_FORCE_OBJECT)
            : $this->request->get($key)
        ;
    }

    /**
     * @param null $key
     * @param null $constraints
     */
    protected function preUpdate($key = null, &$constraints = null)
    {}

    /**
     * @param null $key
     * @param null $constraints
     */
    protected function postUpdate($key = null, &$constraints = null)
    {}
}
<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use FusionFramework\Response;
use PixieFreakPanel\Model\DBAL\DBALTrait;

class Controller
{
    /**
     * @var string $activeTab
     */
    protected $activeTab;

    /**
     * @var Request $request
     */
    protected $request;

    /**
     * @var Response $response
     */
    protected $response;

    /**
     * @var DBALTrait $DBAL
     */
    protected $DBAL;

    /**
     * Controller constructor.
     *
     * @param Request $request
     * @param string  $DBAL
     */
    public function __construct(Request $request, $DBAL = null)
    {
        if ($request->has('active-tab')) {
            $this->activeTab = $request->get('active-tab');
        }

        if (!is_null($DBAL)) {
            $this->DBAL = (new $DBAL($request));
        }

        $this->response = response();
    }

    /**
     * @return mixed|string
     */
    public function getActiveTab()
    {
        return $this->activeTab;
    }

    /**
     * @return array
     */
    public function defaultResponseData()
    {
        return ['notification' => esc_html__('Successfully saved.', 'pixiefreakpanel')];
    }

    /**
     * @param  array|string $parameter
     * @return array
     */
    public function resolveExcluding($parameter)
    {
        $request = request();
        $excludeParams = [];
        if (is_array($parameter)) {
            foreach ($parameter as $key => $value) {
                if (!empty($value) && is_string($value)) {
                    if (!$request->has($value) || empty(trim($request->get($value)))) {
                        $excludeParams[] = $value;
                    }
                }
            }

            return $excludeParams;
        }

        if (is_string($parameter) && !empty($parameter)) {
            if (!$request->has($parameter) || empty(trim($request->get($parameter)))) {
                $excludeParams[] = $parameter;
            }

            return $excludeParams;
        }

        return $excludeParams;
    }
}
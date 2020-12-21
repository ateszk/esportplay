<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use FusionFramework\Response;
use PixieFreakPanel\Model\DBAL\RoutesDBAL;
use PixieFreakPanel\Model\GlobalSettings;
use PixieFreakPanel\Service\GlobalSettings\Routes;

class RouteController extends Controller
{
    /**
     * RouteController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, RoutesDBAL::class);
    }

    /**
     * @param Request  $request
     * @param Response $response
     */
    public function update(Request $request, Response $response)
    {
        if ($request->isPost() || $request->isXmlHttpRequest()) {
            if ($request->has('task')) {
                $task = $request->get('task');
                if ($task === 'general_settings') {
                    $data = [];
                    foreach ($request->get('routes') as $routeName => $route) {
                        $data[$routeName] = [
                            'query' => $routeName.'_slug',
                            'route' => $route
                        ];
                    }

                    GlobalSettings::query()
                        ->update(['value' => json_encode($data, JSON_UNESCAPED_SLASHES)])
                        ->where('module_name', 'routes')
                        ->where('key', 'routes')
                        ->exec()
                    ;

                    return response()->redirect('general_index', $this->defaultResponseData(), $this->getActiveTab());
                }
            }

            $response->redirect('general_index', $this->defaultResponseData(), $this->getActiveTab());
        }

        $response->redirect('general_index', $this->defaultResponseData(), $this->getActiveTab());
    }
}
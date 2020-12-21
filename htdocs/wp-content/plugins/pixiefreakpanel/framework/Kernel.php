<?php

namespace FusionFramework;

use PixieFreakPanel\Bootstrap;

class Kernel
{
    /**
     * @param  Request|null   $request
     * @param  Router|null    $router
     * @param  Response|null  $response
     * @param  Bootstrap|null $bootstrap
     * @return void
     */
    public function run(
        Request   $request   = null,
        Response  $response  = null,
        Router    $router    = null,
        Bootstrap $bootstrap = null
    )
    {
        $request   = $request   ?: new Request();
        $response  = $response  ?: new Response();
        $router    = $router    ?: new Router();

        $bootstrappedApplication = $this->bootApplication(
            $bootstrap = $bootstrap ?: new Bootstrap()
        );

        // Registry bootstrap in sys register
        Registry::set('bootstrap', $bootstrap);

        $router->dispatch(
            $request,
            $response,
            $bootstrappedApplication
        );
    }

    /**
     * @param  Bootstrap $bootstrap
     * @return Bootstrap
     */
    protected function bootApplication(Bootstrap $bootstrap)
    {
        $reflector = new \ReflectionClass($bootstrap);
        foreach ($reflector->getMethods() as $methodObject) {
            $method = $methodObject->getName();
            if (4 < strlen($method) && substr($method, 0, 4) === 'init') {
                $allArgs = [];
                foreach ($reflector->getMethod($method)->getParameters() as $parameter) {
                    $parameterClass = $parameter->getClass();
                    if (!empty($parameterClass)) {
                        $normalizedClassName = $parameterClass->getName();
                        if (class_exists($normalizedClassName)) {
                            $allArgs[] = new $normalizedClassName;
                        }
                    } else {
                        $allArgs[] = $parameter;
                    }
                }

                call_user_func_array([$bootstrap, $method], $allArgs);
            }
        }

        return $bootstrap;
    }
}
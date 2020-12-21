<?php

namespace FusionFramework;

use PixieFreakPanel\Bootstrap;

class Router
{
    /** * @var Request|null */
    private $request   = null;

    /** * @var Response|null */
    private $response  = null;

    private $prefix    = 'pixiefreakpanel_';
    private $parentKey = '';
    private $registry  = [];

    /**
     * @param  Request|null   $request
     * @param  Response|null  $response
     * @param  Bootstrap|null $bootstrap
     * @throws \Exception
     */
    public function dispatch(
        Request   $request,
        Response  $response,
        Bootstrap $bootstrap
    )
    {
        $this->request  = $request;
        $this->response = $response;
        $prefix         = $this->prefix;
        $menuItems      = $bootstrap->initMenu();
        foreach ($menuItems as $key => $menuItem) {
            list($controllerClassName, $actionName) = explode('_', str_replace($prefix, '', $menuItem['route']));
            $resolvedControllerObject  = $this->registerControllerAction($controllerClassName, $actionName);
            $this->registry[$controllerClassName][] = $actionName;
            if (!empty($resolvedControllerObject)) {
                if ($key === 'parent') {
                    $this->parentKey = $prefix . $menuItem['route'];

                    add_action('admin_menu', function() use($menuItem, $prefix, $resolvedControllerObject, $actionName) {
                        add_menu_page(
                            esc_html__($menuItem['page_title'], $prefix),
                            esc_html__($menuItem['menu_title'], $prefix),
                            'manage_options',
                            $this->parentKey,
                            function () use ($resolvedControllerObject, $actionName) {
                                $request = $this->request;
                                $this->clearRequest($request);
                                return $resolvedControllerObject->{$actionName}($this->request, $this->response);
                            },
                            $menuItem['icon']
                        );
                    });

                    continue;
                }

                add_action('admin_menu', function() use($menuItem, $prefix, $resolvedControllerObject, $actionName) {
                    add_submenu_page(
                        $this->parentKey,
                        esc_html__($menuItem['page_title'], $prefix),
                        esc_html__($menuItem['menu_title'], $prefix),
                        'manage_options',
                        $prefix.$menuItem['route'],
                        function () use ($resolvedControllerObject, $actionName) {
                            $request = $this->request;
                            $this->clearRequest($request);
                            return $resolvedControllerObject->{$actionName}($this->request, $this->response);
                        }
                    );
                });
            }
        }

        $rawRouteName = $this->request->getRaw('page');
        $alreadyCalled = [];
	    $routeName = str_replace($this->prefix, '', $rawRouteName);
        if (!empty($routeName)) {
            if (count($exploded = explode('_', $routeName)) > 1) {
                list ($controllerClassName, $actionName) = explode('_', $routeName);
                foreach ($this->registry as $controllerName => $controllerActions) {
                    if (!in_array($actionName, $controllerActions) && $controllerName == $controllerClassName) {
                        $resolvedControllerObject = $this->registerControllerAction($controllerClassName, $actionName);
                        if (!empty($resolvedControllerObject)) {
                            add_action('admin_menu', function() use (
                                $resolvedControllerObject,
                                $actionName,
                                $routeName,
                                $controllerName
                            )
                            {
                                $hook = add_submenu_page(
                                    null,
                                    null,
                                    null,
                                    'manage_options',
                                    $this->prefix . $routeName,
                                    function () use ($resolvedControllerObject, $actionName) {
                                        $request = $this->request;
                                        $this->clearRequest($request);
                                        return $resolvedControllerObject->{$actionName}($request, $this->response);
                                    }
                                );

                                add_action( "admin_footer-$hook", function() use($controllerName) {
                                    $this->labelCurrentMenuItem($controllerName);
                                });
                            });
                        }
                    } else {
                        if (!in_array($controllerClassName, $alreadyCalled)) {
                            $resolvedControllerObject = $this->registerControllerAction($controllerClassName, $actionName);
                            if (!empty($resolvedControllerObject)) {
                                $alreadyCalled[] = $controllerClassName;
                                add_action('admin_menu', function() use (
                                    $resolvedControllerObject,
                                    $actionName,
                                    $routeName,
                                    $controllerName
                                )
                                {
                                    add_submenu_page(
                                        null,
                                        null,
                                        null,
                                        'manage_options',
                                        $this->prefix . $routeName,
                                        function () use ($resolvedControllerObject, $actionName) {
                                            $request = $this->request;
                                            $this->clearRequest($request);
                                            return $resolvedControllerObject->{$actionName}($request, $this->response);
                                        }
                                    );
                                });
                            }
                        }
                    }
                }
            }
        }
    }

    /**
     * @param  string $controller
     * @param  string $action
     * @throws \Exception
     * @return mixed
     */
    protected function registerControllerAction($controller, $action)
    {
        if (class_exists($ctrlClassName = "\\PixieFreakPanel\\Controller\\" .ucfirst($controller). 'Controller')) {
            $reflectedControllerClass = new \ReflectionClass(($ctrl = new $ctrlClassName($this->request)));
            if ($reflectedControllerClass->hasMethod($action) && $reflectedControllerClass->getMethod($action)->isPublic()) {
                return $ctrl;
            }
        }
    }

    /**
     * @param string $controllerName
     */
    private function labelCurrentMenuItem($controllerName = '')
    {
        ?>
            <script type="text/javascript">
                jQuery(document).ready(function($) {
                    $('#toplevel_page_<?php echo $this->parentKey; ?>')
                        .addClass('current wp-has-current-submenu wp-menu-open')
                        .children()
                        .addClass('wp-has-submenu wp-has-current-submenu wp-menu-open menu-top menu-icon-settings menu-top-last')
                    ;

                    $('#toplevel_page_<?php echo $this->parentKey; ?>')
                        .find("a[href='admin.php?page=pixiefreakpanel_<?php echo $controllerName; ?>_index']")
                        .parent()
                        .addClass('current')
                    ;
                });
            </script>
        <?php
    }

    /**
     * @param Request $request
     */
    private function clearRequest(Request &$request)
    {
        unset($request['page']);
    }
}
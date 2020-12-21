<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Database\ORM;
use FusionFramework\Request;

/**
 * Class SortableController
 *
 * @package pixiefreakpanel\Controller
 */
class SortableController extends Controller
{
    /**
     * @param Request $request
     */
    public function order(Request $request)
    {
        $isValidMethod = $request->isPost() || $request->isXmlHttpRequest();
        $hasRequiredRequestedData = $request->has('sorted_ids') && $request->has('model_name');
        if ($isValidMethod && $hasRequiredRequestedData) {
            if (class_exists($fcqn = $request->get('model_name'))) {
                foreach ($request->get('sorted_ids') as $orderNumber => $id) {
                    /** @var $fcqn ORM */
                    $fcqn::query()
                        ->update(['order_number' => $orderNumber])
                        ->where($id)
                        ->exec()
                    ;
                }

                return response()->json([
                    'success' => true
                ]);
            }
        }

        return response()->json([
            'success' => false
        ]);
    }
}
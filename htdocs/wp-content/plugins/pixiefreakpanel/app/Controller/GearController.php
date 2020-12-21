<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use FusionFramework\Response;
use PixieFreakPanel\Model\DBAL\GearDBAL;
use PixieFreakPanel\Model\Gear;

class GearController extends Controller
{
    /**
     * GearController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, GearDBAL::class);
    }

    public function index()
    {
        echo view('gear.index', [
            'sidebar' => 'gear',
            'gears' => Gear::query()->get()
        ]);
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
                    $this->DBAL->updateConstraints(\PixieFreakPanel\Service\GlobalSettings\Gear::class);
                    return response()->redirect('gear_index', $this->defaultResponseData(), $this->getActiveTab());
                }
            }

            $response->redirect('about_index', $this->defaultResponseData(), $this->getActiveTab());
        }

        $response->redirect('about_index', $this->defaultResponseData(), $this->getActiveTab());
    }

    /**
     * @param Request $request
     */
    public function createGear(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            $gearDBAL = $this->DBAL;
            $createdGear = Gear::query()->where((int)$gearDBAL->create())->get()->first();
            return response()->json(view('gear.tabs.partials.gear-table-tr', [
                'gear' => $createdGear
            ], false, true));
        }
    }

    /**
     * @param Request $request
     */
    public function getGear(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('gearId')) {
            $gearItem = Gear::query()->find($request->get('gearId'))->toArray();
            return response()->json($gearItem);
        }
    }

    /**
     * @param Request $request
     */
    public function removeGear(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('gearId')) {
            return response()->json($this->DBAL->remove());
        }
    }

    /**
     * @param Request $request
     */
    public function updateGear(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('gearId')) {
            return response()->json($this->DBAL->update());
        }
    }
}
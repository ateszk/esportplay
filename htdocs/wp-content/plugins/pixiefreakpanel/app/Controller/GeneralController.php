<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use PixieFreakPanel\Model\AboutStaff;
use PixieFreakPanel\Model\DBAL\GeneralDBAL;
use PixieFreakPanel\Model\GlobalSettings;
use PixieFreakPanel\Model\Slider;
use PixieFreakPanel\Service\DatabaseToolkit;
use PixieFreakPanel\Service\GlobalSettings\General;

class GeneralController extends Controller
{
    /**
     * GeneralController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, GeneralDBAL::class);
    }

    public function index()
    {
        echo view('general.index', [
        	'sidebar' => 'general',
	        'slides' => Slider::query()->get(),
        ]);
    }

	/**
	 * @param Request $request
	 */
	public function getSlider(Request $request)
	{
		if ($request->isXmlHttpRequest() && $request->has('slideId')) {
			$gearItem = Slider::query()->find($request->get('slideId'))->toArray();
			return response()->json($gearItem);
		}
	}

	/**
	 * @param Request $request
	 */
	public function updateSlider(Request $request)
	{
		if ($request->isXmlHttpRequest() && $request->has('slideId')) {
			return response()->json($this->DBAL->updateSlider());
		}
	}

	/**
	 * @param Request $request
	 */
	public function removeSlider(Request $request)
	{
		if ($request->isXmlHttpRequest() && $request->has('slideId')) {
			return response()->json($this->DBAL->removeSlider());
		}
	}

	/**
	 * @param Request $request
	 */
	public function createSlider(Request $request)
	{
		if ($request->isXmlHttpRequest()) {
			return response()->json($this->DBAL->createSlider());
		}
	}

    /**
     * @param Request $request
     */
    public function update(Request $request)
    {
        if ($request->isPost() || $request->isXmlHttpRequest()) {
            $this->DBAL
                ->updateConstraints(General::class, $this->resolveExcluding([
                	'general_default_background',
	                'general_notfound_background'
                ]))
                ->updateOrder()
            ;

            return response()->redirect('general_index', $this->defaultResponseData(), $this->getActiveTab());
        }

        return response()->redirect('general_index', $this->defaultResponseData(), $this->getActiveTab());
    }
}
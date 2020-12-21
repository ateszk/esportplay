<?php

namespace PixieFreakPanel\Model\DBAL;

use FusionFramework\Request;
use PixieFreakPanel\Model\GlobalSettings;
use PixieFreakPanel\Model\Slider;

class GeneralDBAL
{
    use DBALTrait;

    public function updateOrder()
    {
        $request = $this->request;
        $settingsModel = GlobalSettings::query();
        if ($request->has('trigger') && $request->get('trigger') === 'sortable') {
            $sortedSectionJson = $this->getOrderedJson($request);
            $settingsModel
                ->update(['value' => $sortedSectionJson])
                ->where('module_name', 'general')
                ->where('key', 'section_order')
                ->exec()
            ;

            return;
        }

        if ($request->get('trigger') === 'showable') {
            $els = pixiefreak_settings('general')->get('section_visibility');
            foreach ($els as $section => &$visible) {
                $visible = true;
            }

            foreach ($els as $section => &$visible) {
                $visible = (bool) $visible;
                $hiddenEls = $request->get('hiddenElements');
                if (in_array($section, $hiddenEls)) {
                    $visible = false;
                    continue;
                }
            }

            $settingsModel
                ->update(['value' => json_encode($els, JSON_UNESCAPED_SLASHES)])
                ->where('module_name', 'general')
                ->where('key', 'section_visibility')
                ->exec()
            ;

            return;
        }
    }

	/**
	 * @return string
	 */
	public function createSlider()
    {
	    $request = $this->request;
	    $data = [];
	    foreach ($request->get('values') as $key => $value) {
		    $data[$key] = $value;
	    }

	    return Slider::query()->insert($data);
    }

	/**
	 * @return string
	 */
	public function updateSlider()
    {
	    $request = $this->request;
	    $data  = [];
	    foreach ($request->get('values') as $key => $value) {
		    $data[$key] = $value;
	    }

	    if (empty($data['image'])) {
		    unset($data['image']);
	    }

	    return Slider::query()
               ->update($data)
               ->where($request->get('slideId'))
               ->exec()
	    ;
    }

	/**
	 * @return string
	 */
	public function removeSlider()
	{
	    $request = $this->request;
	    return Slider::query()->delete($request->get('slideId'));
    }

    /**
     * @param  Request $request
     * @return string
     */
	public function getOrderedJson(Request $request)
    {
        $orderedArray = [];
        $oldOrder     = pixiefreak_settings('general')->get('section_order');
        foreach ($request->get('sortedIds') as $key => $orderNumber) {
            $orderedArray[(int) $orderNumber] = $oldOrder[(int) $orderNumber];
        }

        return json_encode($orderedArray, JSON_UNESCAPED_SLASHES|JSON_FORCE_OBJECT);
    }
}
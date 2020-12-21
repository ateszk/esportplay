<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use FusionFramework\Response;
use PixieFreakPanel\Model\AboutStaff;
use PixieFreakPanel\Model\AboutStaffCategory;
use PixieFreakPanel\Model\DBAL\AboutDBAL;
use PixieFreakPanel\Service\GlobalSettings\About;

class AboutController extends Controller
{
    /**
     * AboutController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, AboutDBAL::class);
    }

    public function index()
    {
    	$aboutQuery = \PixieFreakPanel\Model\About::query();
        echo view('about.index', [
            'sidebar' => 'about',
            'about' => $aboutQuery->get()->first(),
            'staff' => AboutStaff::query()->get(),
            'categories' => AboutStaffCategory::query()->get()
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
                $aboutDBAL = $this->DBAL;
                if ($task === 'general_settings') {
                    $aboutDBAL->updateConstraints(About::class)->updateImages();

                    if ($request->has('description') && !empty($description = $request->get('description'))) {
                        $aboutQuery = \PixieFreakPanel\Model\About::query();
                        $aboutId = $aboutQuery->get()->first()->id;
                        $aboutQuery
                            ->update(['description' => $description])
                            ->where($aboutId)
                            ->exec()
                        ;
                    }

                    return response()->redirect('about_index', $this->defaultResponseData(), $this->getActiveTab());
                }
            }

            $response->redirect('about_index', $this->defaultResponseData(), $this->getActiveTab());
        }

        $response->redirect('about_index', $this->defaultResponseData(), $this->getActiveTab());
    }

    /**
     * @param Request $request
     */
    public function statisticUpdate(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            if ($request->has('values')) {
                return response()->json($this->DBAL->statistic());
            }
        }
    }

    /**
     * @param Request $request
     */
    public function getStaffMember(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('staffId')) {
            $staffMember = AboutStaff::query()->where($request->get('staffId'))->get()->toArray()[0];
            return response()->json($staffMember);
        }
    }

    /**
     * @param Request $request
     */
    public function updateStaffMember(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('staffId')) {
            return response()->json($this->DBAL->updateStaffMember());
        }
    }

    /**
     * @param Request $request
     */
    public function removeStaffMember(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('staffId')) {
            return response()->json($this->DBAL->removeStaffMember());
        }
    }

    /**
     * @param Request $request
     */
    public function createStaffMember(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json($this->DBAL->createStaffMember());
        }
    }

    /**
     * @param Request $request
     */
    public function addStaffMemberCategory(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('name')) {
            return response()->json($this->DBAL->addStaffMemberCategory());
        }
    }

    /**
     * @param Request $request
     */
    public function removeStaffMemberCategory(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('categoryId')) {
            return response()->json($this->DBAL->removeStaffMemberCategory());
        }
    }

    /**
     * @param Request $request
     */
    public function updateStaffMemberCategory(Request $request)
    {
        if ($request->isXmlHttpRequest()
            && $request->has('categoryId')
            && $request->has('name'))
        {
            return response()->json($this->DBAL->updateStaffMemberCategory());
        }
    }
}
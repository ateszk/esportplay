<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use FusionFramework\Response;
use PixieFreakPanel\Model\DBAL\SponsorDBAL;
use PixieFreakPanel\Model\Sponsor;

class SponsorController extends Controller
{
    /**
     * SponsorController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, SponsorDBAL::class);
    }

    public function index()
    {
        echo view('sponsor.index', [
            'sidebar' => 'sponsor',
            'sponsors' => Sponsor::query()->orderBy('order_number', 'ASC')->get()
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
                $sponsorDBAL = $this->DBAL;
                if ($task === 'general_settings') {
                    $sponsorDBAL->updateConstraints(
                        \PixieFreakPanel\Service\GlobalSettings\Sponsor::class,
                        $this->resolveExcluding('sponsor_banner_image')
                    );

                    return response()->redirect('sponsor_index', $this->defaultResponseData(), $this->getActiveTab());
                }

                if ($task === 'order' && $request->has('sortedIds')) {
                    $sponsorDBAL->updateSponsorOrder();
                    return response()->redirect('sponsor_index', $this->defaultResponseData(), $this->getActiveTab());
                }
            }

            $response->redirect('sponsor_index', $this->defaultResponseData(), $this->getActiveTab());
        }

        $response->redirect('sponsor_index', $this->defaultResponseData(), $this->getActiveTab());
    }

    /**
     * @param Request $request
     */
    public function createSponsor(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            $sponsorDBAL = $this->DBAL;
            $createdSponsor = Sponsor::query()->where((int)$sponsorDBAL->createSponsor())->get()->first();
            return response()->json(view('sponsor.tabs.partials.sponsor-table-tr', [
                'sponsor' => $createdSponsor
            ], false, true));
        }
    }

    /**
     * @param Request $request
     */
    public function removeSponsor(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('sponsorId')) {
            return response()->json($this->DBAL->removeSponsor());
        }
    }

    public function updateSponsor(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('sponsorId')) {
            return response()->json($this->DBAL->updateSponsor());
        }
    }

    /**
     * @param Request $request
     */
    public function getSponsor(Request $request)
    {;
        if ($request->isXmlHttpRequest() && $request->has('sponsorId')) {
            $staffMember = Sponsor::query()->where($request->get('sponsorId'))->get()->toArray()[0];
            return response()->json($staffMember);
        }
    }
}
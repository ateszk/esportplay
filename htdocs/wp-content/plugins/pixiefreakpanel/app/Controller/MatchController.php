<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use FusionFramework\Response;
use PixieFreakPanel\Model\DBAL\MatchDBAL;
use PixieFreakPanel\Model\Match;

class MatchController extends Controller
{
    /**
     * GearController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, MatchDBAL::class);
    }

    public function index()
    {
        echo view('match.index', [
            'sidebar' => 'match',
            'matches' => Match::query()->get()
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
                    $this->DBAL->updateConstraints(
                        \PixieFreakPanel\Service\GlobalSettings\Match::class,
                        $this->resolveExcluding('match_banner_image')
                    );

                    return response()->redirect('match_index', $this->defaultResponseData(), $this->getActiveTab());
                }
            }

            $response->redirect('match_index', $this->defaultResponseData(), $this->getActiveTab());
        }

        $response->redirect('match_index', $this->defaultResponseData(), $this->getActiveTab());
    }

    /**
     * @param Request $request
     */
    public function getMatch(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('matchId')) {
            $team = $this->DBAL->find($request->get('matchId'));
            return response()->json($team);
        }
    }

    /**
     * @param Request $request
     */
    public function updateMatch(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('matchId')) {
            return response()->json($this->DBAL->update());
        }
    }

    /**
     * @param Request $request
     */
    public function removeMatch(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('matchId')) {
            return response()->json($this->DBAL->remove());
        }
    }

    /**
     * @param Request $request
     */
    public function createMatch(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json($this->DBAL->create());
        }
    }
}
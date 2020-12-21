<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use PixieFreakPanel\Model\DBAL\PlayerDBAL;
use PixieFreakPanel\Model\PlayerGear;
use PixieFreakPanel\Model\PlayerStream;

class PlayerController extends Controller
{
    /**
     * PlayerController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, PlayerDBAL::class);
    }

    /**
     * @param Request $request
     */
    public function getPlayer(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('playerId')) {
            $player = $this->DBAL->find($request->get('playerId'));
            return response()->json($player);
        }
    }

    /**
     * @param Request $request
     */
    public function updatePlayer(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('playerId')) {
            return response()->json($this->DBAL->update());
        }
    }

    /**
     * @param Request $request
     */
    public function removePlayer(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('playerId')) {
            return response()->json($this->DBAL->remove());
        }
    }

    /**
     * @param Request $request
     */
    public function createPlayer(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json($this->DBAL->create());
        }
    }

    /**
     * @param Request $request
     */
    public function getPlayerStatistic(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json(view('team.tabs.partials.team-stats-modal-appendix', [
                'statistics' => $this->DBAL->getPlayerStatistic()
            ], false, true));
        }
    }

    /**
     * @param Request $request
     */
    public function updatePlayerStatistic(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json($this->DBAL->updateStatistic());
        }
    }

    /**
     * @param Request $request
     */
    public function getPlayerGear(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('playerId')) {
            $gearIdsCollection = PlayerGear::query()->where('player_id', $request->get('playerId'))->get();
            $gearIds = array_map(function($gear) {
                return $gear['gear_id'];
            }, $gearIdsCollection->toArray());

            return response()->json($gearIds);
        }
    }

    /**
     * @param Request $request
     */
    public function updatePlayerGear(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('playerId')) {
            return response()->json($this->DBAL->updatePlayerGear());
        }
    }

    /**
     * @param Request $request
     */
    public function getPlayerStream(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('playerId')) {
            $streamIdsCollection = PlayerStream::query()->where('player_id', $request->get('playerId'))->get();
            $streamIds = array_map(function($item) {
                return $item['stream_id'];
            }, $streamIdsCollection->toArray());

            return response()->json($streamIds);
        }
    }

    /**
     * @param Request $request
     */
    public function updatePlayerStream(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('playerId')) {
            return response()->json($this->DBAL->updatePlayerStream());
        }
    }
}
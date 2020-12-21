<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use PixieFreakPanel\Model\Achievement;
use PixieFreakPanel\Model\DBAL\AchievementDBAL;

class AchievementController extends Controller
{
    /**
     * AchievementController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, AchievementDBAL::class);
    }

    /**
     * @param Request $request
     */
    public function createAchievement(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            $achievementDBAL = $this->DBAL;
            $createdAchievement = Achievement::query()->where((int)$achievementDBAL->create())->get()->first();
            return response()->json(view('team.tabs.partials.team-achievement-table-tr', [
                'achievement' => $createdAchievement
            ], false, true));
        }
    }

    /**
     * @param Request $request
     */
    public function getAchievement(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('achievementId')) {
            $achievementItem = Achievement::query()->where($request->get('achievementId'))->get()->toArray()[0];
            return response()->json($achievementItem);
        }
    }

    /**
     * @param Request $request
     */
    public function removeAchievement(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('achievementId')) {
            return response()->json($this->DBAL->remove());
        }
    }

    /**
     * @param Request $request
     */
    public function updateAchievement(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('achievementId')) {
            return response()->json($this->DBAL->update());
        }
    }
}
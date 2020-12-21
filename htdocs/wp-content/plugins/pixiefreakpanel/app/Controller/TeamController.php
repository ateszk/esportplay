<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use FusionFramework\Response;
use PixieFreakPanel\Model\Achievement;
use PixieFreakPanel\Model\DBAL\PlayerDBAL;
use PixieFreakPanel\Model\DBAL\TeamDBAL;
use PixieFreakPanel\Model\Game;
use PixieFreakPanel\Model\TeamAchievement;
use PixieFreakPanel\Model\TeamPlayer;
use PixieFreakPanel\Model\TeamStream;
use PixieFreakPanel\Service\GlobalSettings\Player;
use PixieFreakPanel\Service\GlobalSettings\Team;
use PixieFreakPanel\Service\GlobalSettings\Teams;

class TeamController extends Controller
{
    /**
     * TeamController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, TeamDBAL::class);
    }

    /**
     * @param Request $request
     */
    public function index(Request $request)
    {
    	$playerDBAL = new PlayerDBAL($request);
        echo view('team.index', [
            'sidebar' => 'team',
            'teams' => $this->DBAL->teamList(),
            'games' => Game::query()->get(),
            'players' => $playerDBAL->playerList(),
            'achievements' => Achievement::query()->get()
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
                    $teamDBAL = $this->DBAL;
                    $teamDBAL
                        ->updateConstraints(Team::class, $this->resolveExcluding('team_team_banner_image'))
                        ->updateConstraints(Teams::class, $this->resolveExcluding('teams_teams_banner_image'))
                        ->updateConstraints(Player::class)
                    ;

                    return response()->redirect('team_index', $this->defaultResponseData(), $this->getActiveTab());
                }
            }

            $response->redirect('team_index', $this->defaultResponseData(), $this->getActiveTab());
        }

        $response->redirect('team_index', $this->defaultResponseData(), $this->getActiveTab());
    }

    /**
     * @param Request $request
     */
    public function getTeam(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            $team = $this->DBAL->find($request->get('teamId'));
            return response()->json($team);
        }
    }

    /**
     * @param Request $request
     */
    public function updateTeam(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            return response()->json($this->DBAL->update());
        }
    }

    /**
     * @param Request $request
     */
    public function removeTeam(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            return response()->json($this->DBAL->remove());
        }
    }

    /**
     * @param Request $request
     */
    public function createTeam(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json($this->DBAL->create());
        }
    }

    /**
     * @param Request $request
     */
    public function getTeamStatistic(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            return response()->json($this->DBAL->getStatistic());
        }
    }

    /**
     * @param Request $request
     */
    public function updateTeamStatistic(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            return response()->json($this->DBAL->updateStatistic());
        }
    }

    /**
     * @param Request $request
     */
    public function getTeamStream(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            $streamIdsCollection = TeamStream::query()->where('team_id', $request->get('teamId'))->get();
            $streamIds = array_map(function($item) {
                return $item['stream_id'];
            }, $streamIdsCollection->toArray());

            return response()->json($streamIds);
        }
    }

    /**
     * @param Request $request
     */
    public function getTeamAchievement(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            $achievementIdsCollection = TeamAchievement::query()->where('team_id', $request->get('teamId'))->get();
            $achievementIds = array_map(function($item) {
                return $item['achievement_id'];
            }, $achievementIdsCollection->toArray());

            return response()->json($achievementIds);
        }
    }

    /**
     * @param Request $request
     */
    public function updateTeamAchievement(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            return response()->json($this->DBAL->updateTeamAchievement());
        }
    }

    /**
     * @param Request $request
     */
    public function updateTeamStream(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            return response()->json($this->DBAL->updateTeamStream());
        }
    }

    /**
     * @param Request $request
     */
    public function getTeamPlayer(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            $streamIdsCollection = TeamPlayer::query()->where('team_id', $request->get('teamId'))->get();
            $streamIds = array_map(function($item) {
                return $item['player_id'];
            }, $streamIdsCollection->toArray());

            return response()->json($streamIds);
        }
    }

    /**
     * @param Request $request
     */
    public function updateTeamPlayer(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('teamId')) {
            return response()->json($this->DBAL->updateTeamPlayer());
        }
    }
}
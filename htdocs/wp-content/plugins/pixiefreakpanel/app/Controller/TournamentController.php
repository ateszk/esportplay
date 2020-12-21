<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use PixieFreakPanel\Model\Tournament;
use PixieFreakPanel\Model\TournamentGroup;
use PixieFreakPanel\Model\DBAL\TournamentDBAL;
use FusionFramework\Database\ORMFusionCollection;
use PixieFreakPanel\Model\TournamentTeam;
use PixieFreakPanel\Service\GlobalSettings\Tournaments;
use PixieFreakPanel\Service\GlobalSettings\Tournament as TournamentSettings;

class TournamentController extends Controller
{
    /**
     * TournamentController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, TournamentDBAL::class);
    }

    /**
     * @param Request $request
     */
    public function index(Request $request)
    {
        $viewData = [
            'sidebar' => 'tournament',
            'tournaments' => Tournament::query()->get(),
            'tournamentGroups' => TournamentGroup::query()->get()
        ];

        $viewData['tournamentGroupTeams'] = new ORMFusionCollection();
        if ($request->has('tournament-id')) {
            $viewData['tournamentGroupTeams'] = TournamentGroup::query()->team(
                $tournamentGroup = TournamentGroup::query()->find($request->get('tournament-id'))
            );

            $viewData['tournament'] = Tournament::query()->find($tournamentGroup->tournament_id);
        }

        if ($request->has('bracket-id')) {
            $viewData['tournament'] = Tournament::query()->find($request->get('bracket-id'));
        }

        echo view('tournament.index', $viewData);
    }

    /**
     * @param Request  $request
     */
    public function update(Request $request)
    {
        if ($request->isPost() || $request->isXmlHttpRequest()) {
            if ($request->has('task')) {
                $task = $request->get('task');
                if ($task === 'general_settings') {
                    $this->DBAL
                        ->updateConstraints(TournamentSettings::class, $this->resolveExcluding('tournament_tournament_banner_image'))
                        ->updateConstraints(Tournaments::class, $this->resolveExcluding('tournaments_banner_image'))
                    ;

                    return response()->redirect('tournament_index', $this->defaultResponseData(), $this->getActiveTab());
                }
            }

            return response()->redirect('tournament_index', $this->defaultResponseData(), $this->getActiveTab());
        }

        return response()->redirect('tournament_index', $this->defaultResponseData(), $this->getActiveTab());
    }

    /**
     * @param Request $request
     */
    public function getTournament(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentId')) {
            $team = $this->DBAL->find($request->get('tournamentId'));
            return response()->json($team);
        }
    }

    /**
     * @param Request $request
     */
    public function updateTournament(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentId')) {
            return response()->json($this->DBAL->update());
        }
    }

    /**
     * @param Request $request
     */
    public function removeTournament(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentId')) {
            return response()->json($this->DBAL->remove());
        }
    }

    /**
     * @param Request $request
     */
    public function createTournament(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json($this->DBAL->create());
        }
    }

    /**
     * @param Request $request
     */
    public function getTournamentGroup(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentGroupId')) {
            $team = $this->DBAL->findGroup($request->get('tournamentGroupId'));
            return response()->json($team);
        }
    }

    /**
     * @param Request $request
     */
    public function updateTournamentGroup(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentGroupId')) {
            return response()->json($this->DBAL->updateGroup());
        }
    }

    /**
     * @param Request $request
     */
    public function removeTournamentGroup(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentGroupId')) {
            return response()->json($this->DBAL->removeGroup());
        }
    }

    /**
     * @param Request $request
     */
    public function createTournamentGroup(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json($this->DBAL->createGroup());
        }
    }

    /**
     * @param Request $request
     */
    public function getTournamentGroupTeam(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentGroupTeamId')) {
            $team = $this->DBAL->findGroupTeam($request->get('tournamentGroupTeamId'));
            return response()->json($team);
        }
    }

    /**
     * @param Request $request
     */
    public function updateTournamentGroupTeam(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentGroupTeamId')) {
            return response()->json($this->DBAL->updateGroupTeam());
        }
    }

    /**
     * @param Request $request
     */
    public function removeTournamentGroupTeam(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentGroupTeamId')) {
            return response()->json($this->DBAL->removeGroupTeam());
        }
    }

    /**
     * @param Request $request
     */
    public function createTournamentGroupTeam(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json($this->DBAL->createGroupTeam());
        }
    }

    public function updateBracket(Request $request)
    {
        if ($request->has('tournamentId')) {
            $brackets = $request->get('bracket');
            if ($brackets === 'reset') {
                $brackets = '{teams : [[null, null]], results : []}';
                return Tournament::query()->update([
                    'brackets' => $brackets
                ], $request->get('tournamentId'));
            }

            Tournament::query()->update([
                'brackets' => str_replace('""', 'null', json_encode($brackets, JSON_UNESCAPED_SLASHES|JSON_NUMERIC_CHECK))
            ], $request->get('tournamentId'));
        }
    }

    /**
     * @param Request $request
     */
    public function getTournamentTeam(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentId')) {
            $teamIdsCollection = TournamentTeam::query()->where('tournament_id', $request->get('tournamentId'))->get();
            $teamIDS = array_map(function($item) {
                return $item['team_id'];
            }, $teamIdsCollection->toArray());

            return response()->json($teamIDS);
        }
    }

    /**
     * @param Request $request
     */
    public function updateTournamentTeam(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('tournamentId')) {
            return response()->json($this->DBAL->updateTournamentTeam());
        }
    }
}
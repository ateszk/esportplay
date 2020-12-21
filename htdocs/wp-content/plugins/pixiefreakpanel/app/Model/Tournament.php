<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;
use FusionFramework\Database\ORMFusionCollection;
use FusionFramework\Database\ORMFusionObject;

class Tournament extends ORM
{
    const BRACKETS = '{teams : [[null, null]], results : []}';

    const STATUSES = [
        1 => 'Upcoming',
        2 => 'Started',
        3 => 'Finished'
    ];

    /**
     * @var string $table
     */
    protected $table = 'tournament';

    /**
     * @param  ORMFusionObject $tournament
     * @return ORMFusionObject
     */
    public function game(ORMFusionObject $tournament)
    {
        return Game::query()->where('id', $tournament->game_id)->get()->first();
    }

    /**
     * @param  ORMFusionObject $tournament
     * @return ORMFusionCollection
     */
    public function groupTeam($tournament)
    {
        return TournamentGroupTeam::query()->where('tournament_id', $tournament->id)->get();
    }

    /**
     * @param  ORMFusionObject $tournament
     * @return ORMFusionCollection
     */
    public function teams(ORMFusionObject $tournament)
    {
        $teams = new ORMFusionCollection();
        foreach (TournamentGroupTeam::query()->where('tournament_id', $tournament->id)->get() as $tournamentGroupTeam) {
	        $team = Team::query()->where('id', $tournamentGroupTeam->tournament_group_team_id)->get();

	        if($team->isNotEmpty()) {
		        $teams->{$tournamentGroupTeam->tournament_group_team_id} = $team->first();
	        }
        }

        return $teams;
    }

    /**
     * @param  ORMFusionObject $tournament
     * @return ORMFusionCollection
     */
    public function groups(ORMFusionObject $tournament)
    {
        return TournamentGroup::query()->where('tournament_id', $tournament->id)->get();
    }

    /**
     * @param  ORMFusionObject $tournament
     * @return int
     */
    public function playersCount(ORMFusionObject $tournament)
    {
        $players = 0;
        foreach ($this->teams($tournament) as $team) {
            $players = $players + count(Team::query()->player($team));
        }

        return $players;
    }

    /**
     * @param  ORMFusionObject $tournament
     * @return string
     */
    public function brackets(ORMFusionObject $tournament)
    {
        $brackets = json_decode($tournament->brackets, true);
        foreach ($brackets['teams'] as &$roundTeam) {
            foreach ($roundTeam as $key => $teamName) {
                if (!empty($foundTeam = Team::query()->where('name', $teamName)->get()->first())) {
                    $roundTeam[$key] = [];
                    $roundTeam[$key]['name'] = $foundTeam->name;
                    $roundTeam[$key]['teamlogo'] = $foundTeam->team_logo;
                }
            }
        }

        if (empty($return = json_encode($brackets, JSON_UNESCAPED_SLASHES|JSON_NUMERIC_CHECK))) {
            return self::BRACKETS;
        }

        return $return;
    }
}
<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;
use FusionFramework\Database\ORMFusionObject;

class TournamentGroupTeam extends ORM
{
    /**
     * @var string $table
     */
    protected $table = 'tournament_group_team';

    /**
     * @param  ORMFusionObject $tournamentGroupTeam
     * @return null
     */
    public function team(ORMFusionObject $tournamentGroupTeam)
    {
        return Team::query()->where('id', $tournamentGroupTeam->tournament_group_team_id)->get()->first();
    }
}
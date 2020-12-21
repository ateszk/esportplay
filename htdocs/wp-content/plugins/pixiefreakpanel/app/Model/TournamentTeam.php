<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;
use FusionFramework\Database\ORMFusionObject;

class TournamentTeam extends ORM
{
    /**
     * @var string $table
     */
    protected $table = 'tournament_team';

    /**
     * @param  ORMFusionObject $tournament
     * @return mixed
     */
    public function team($tournament)
    {
        return $this->collect(TournamentTeam::class, Team::class, 'tournament_id', 'team_id', $tournament);
    }
}
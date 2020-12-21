<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;
use FusionFramework\Database\ORMFusionCollection;
use FusionFramework\Database\ORMFusionObject;

class TournamentGroup extends ORM implements SortableInterface
{
    /**
     * @var string $table
     */
    protected $table = 'tournament_group';

    /**
     * @param  ORMFusionObject $tournamentGroup
     * @return ORMFusionObject
     */
    public function tournament(ORMFusionObject $tournamentGroup)
    {
        return Tournament::query()->where('id', $tournamentGroup->tournament_id)->get()->first();
    }

    /**
     * @param  ORMFusionObject $tournamentGroup
     * @return ORMFusionCollection
     */
    public function team(ORMFusionObject $tournamentGroup)
    {
        return TournamentGroupTeam::query()->orderBy('point', 'desc')->where('tournament_id', $tournamentGroup->tournament_id)->where('tournament_group_id', $tournamentGroup->id)->get();
    }
}
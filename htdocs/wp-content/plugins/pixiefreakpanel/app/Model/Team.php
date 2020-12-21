<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;
use FusionFramework\Database\ORMFusionObject;

class Team extends ORM implements SortableInterface
{
    /**
     * @var string $table
     */
    protected $table = 'team';

    /**
     * @param  ORMFusionObject $team
     * @return array
     */
    public function stream($team)
    {
        return $this->collect(TeamStream::class, Stream::class, 'team_id', 'stream_id', $team);
    }

    /**
     * @param  ORMFusionObject $team
     * @return array
     */
    public function player($team)
    {
        return $this->collect(TeamPlayer::class, Player::class, 'team_id', 'player_id', $team);
    }

    /**
     * @param  ORMFusionObject $team
     * @return array
     */
    public function achievement($team)
    {
        return $this->collect(TeamAchievement::class, Achievement::class, 'team_id', 'achievement_id', $team);
    }

    /**
     * @return string
     */
    public function json()
    {
        $jsonArr = [];
        foreach (Team::query()->get() as $team) {
            $jsonArr[] = $team->name;
        }

        return json_encode($jsonArr, JSON_UNESCAPED_SLASHES);
    }
}
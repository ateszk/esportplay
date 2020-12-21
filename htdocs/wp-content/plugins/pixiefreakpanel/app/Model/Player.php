<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;
use FusionFramework\Database\ORMFusionObject;

class Player extends ORM implements SortableInterface
{
    /**
     * @var string $table
     */
    protected $table = 'player';

    /**
     * @param  ORMFusionObject $player
     * @return array|\FusionFramework\Database\ORMFusionCollection
     */
    public function team($player)
    {
        return $this->collect(TeamPlayer::class, Team::class, 'player_id', 'team_id', $player);
    }

    /**
     * @param  ORMFusionObject $player
     * @return array|\FusionFramework\Database\ORMFusionCollection
     */
    public function gear($player)
    {
        return $this->collect(PlayerGear::class, Gear::class, 'player_id', 'gear_id', $player);
    }

    /**
     * @param  ORMFusionObject $player
     * @return array|\FusionFramework\Database\ORMFusionCollection
     */
    public function stream($player)
    {
        return $this->collect(PlayerStream::class, Stream::class, 'player_id', 'stream_id', $player);
    }
}
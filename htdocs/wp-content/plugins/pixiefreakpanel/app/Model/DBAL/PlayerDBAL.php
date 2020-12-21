<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\Player;
use PixieFreakPanel\Model\PlayerGear;
use PixieFreakPanel\Model\PlayerStream;
use PixieFreakPanel\Model\Team;

class PlayerDBAL
{
    use DBALTrait;

    /**
     * @return \FusionFramework\Database\ORMFusionCollection
     */
    public function playerList()
    {
        $players = Player::query()->get();
        foreach ($players as &$player) {
            $player->team = Team::query()->where($player->team_id)->get()->first();
        }

        return $players;
    }

    /**
     * @param $playerId
     * @return array|mixed
     */
    public function find($playerId)
    {
        if (!empty($player = Player::query()->where('id', $playerId)->get()->toArray()[0])) {
            $socials = json_decode($player['social'], true);
            foreach (['facebook', 'instagram', 'discord', 'steam', 'twitch', 'twitter'] as $social) {
                $player[$social] = $socials[$social];
            }

            return $player;
        }
        
        return [];
    }

    /**
     * @return int|string
     */
    public function create()
    {
        $request = $this->request;
        $socialArray = [];
        $playerData  = [];
        foreach ($request->get('values') as $key => $value) {
            if (in_array($key, ['facebook', 'instagram', 'discord', 'steam', 'twitch', 'twitter'])) {
                $socialArray[$key] = $value;
                continue;
            }

            if ($key === 'nickname') {
                $playerData['slug'] = sanitize_title($value);
            }

            $playerData[$key] = $value;
        }

        $playerData['team_id'] = 0;
        $playerData['social'] = json_encode($socialArray, JSON_UNESCAPED_SLASHES);

        $statistic = [
            ['icon' => '', 'title' => '', 'label' => ''],
            ['icon' => '', 'title' => '', 'label' => ''],
            ['icon' => '', 'title' => '', 'label' => ''],
            ['icon' => '', 'title' => '', 'label' => '']
        ];

        $playerData['stats'] = json_encode($statistic, JSON_UNESCAPED_SLASHES);

        return Player::query()->insert($playerData);
    }

    /**
     * @return int
     */
    public function update()
    {
        $request = $this->request;
        $socialArray = [];
        $playerData = [];
        foreach ($request->get('values') as $key => $value) {
            if (in_array($key, ['facebook', 'instagram', 'discord', 'steam', 'twitch', 'twitter'])) {
                $socialArray[$key] = $value;
                continue;
            }

            if ($key === 'nickname') {
                $playerData['slug'] = sanitize_title($value);
            }

            $playerData[$key] = $value;
        }

        $playerData['social'] = json_encode($socialArray, JSON_UNESCAPED_SLASHES);

        return Player::query()
            ->update($playerData)
            ->where($request->get('playerId'))
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function remove()
    {
        $request = $this->request;
        $playerId  = $request->get('playerId');
        foreach (PlayerStream::query()->where('player_id', $playerId)->get() as $playerStream) {
            PlayerStream::query()->delete($playerStream->id);
        }

        foreach (PlayerGear::query()->where('player_id', $playerId)->get() as $playerGear) {
            PlayerGear::query()->delete($playerGear->id);
        }

        return Player::query()->delete($playerId);
    }

    /**
     * @return array|mixed|object
     */
    public function getPlayerStatistic()
    {
        $request = $this->request;
        $playerId = $request->get('playerId');
        return Player::query()->where($playerId)->get()->first()->stats;
    }

    /**
     * @return int
     */
    public function updateStatistic()
    {
        $request = $this->request;
        $statisticArray = array_chunk($request->get('values'), 3);
        foreach (array_chunk($request->get('values'), 3) as $key => $value) {
            $statisticArray[$key] = array_combine(['icon', 'title', 'label'], $value);
        }

        $statisticJson = json_encode($statisticArray, JSON_UNESCAPED_SLASHES);
        return Player::query()
            ->update(['stats' => $statisticJson])
            ->where($request->get('playerId'))
            ->exec()
        ;
    }

    public function updatePlayerGear()
    {
        $request = $this->request;
        $playerId = $request->get('playerId');
        foreach (PlayerGear::query()->where('player_id', $playerId)->get() as $playerGear) {
            PlayerGear::query()->delete($playerGear->id);
        }

        $gearIds = array_filter((array) $request->get('values'));
        foreach ($gearIds as $gearId) {
            PlayerGear::query()->insert([
                'player_id' => $playerId,
                'gear_id' => $gearId
            ]);
        }

        return true;
    }

    public function updatePlayerStream()
    {
        $request = $this->request;
        $playerId = $request->get('playerId');
        foreach (PlayerStream::query()->where('player_id', $playerId)->get() as $playerStream) {
            PlayerStream::query()->delete($playerStream->id);
        }

        $streamIds = array_filter((array) $request->get('values'));
        foreach ($streamIds as $streamId) {
            PlayerStream::query()->insert([
                'player_id' => $playerId,
                'stream_id' => $streamId
            ]);
        }

        return true;
    }
}
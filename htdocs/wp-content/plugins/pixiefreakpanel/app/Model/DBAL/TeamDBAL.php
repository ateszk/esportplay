<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\Game;
use PixieFreakPanel\Model\Team;
use PixieFreakPanel\Model\TeamAchievement;
use PixieFreakPanel\Model\TeamPlayer;
use PixieFreakPanel\Model\TeamStream;
use PixieFreakPanel\Service\GlobalSettings\Resolver;

class TeamDBAL extends Resolver
{
    use DBALTrait;

    /**
     * @return \FusionFramework\Database\ORMFusionCollection
     */
    public function teamList()
    {
        $teams = Team::query()->get();
        foreach ($teams as &$team) {
            $team->game = Game::query()->where('id', $team->game_id)->get()->first();
            $team->player = TeamPlayer::query()->where('team_id', $team->id)->get();
            $team->stream = TeamStream::query()->where('team_id', $team->id);
        }

        return $teams;
    }

    /**
     * @param $teamId
     * @return array|mixed
     */
    public function find($teamId)
    {
        if (!empty($team = Team::query()->where('id', $teamId)->get()->first())) {
            $team['player'] = [];
            $team['stream'] = [];

            if (!empty($players = TeamPlayer::query()->where('team_id', $team['id'])->get()->toArray())) {
                $team['players'] = $players;
            }

            if (!empty($streams = TeamStream::query()->where('team_id', $team['id'])->get()->toArray())) {
                $team['stream'] = $streams;
            }

            foreach (json_decode($team['social'], true) as $social => $ulr) {
                if (in_array($social, ['twitch', 'facebook', 'instagram', 'steam'])) {
                    $team[$social] = $ulr;
                }
            }

            return $team->toArray();
        }
    }

    /**
     * @return int|string
     */
    public function create()
    {
        $request = $this->request;
        $socialArray = [];
        $teamData  = [];
        foreach ($request->get('values') as $key => $value) {
            if (in_array($key, ['facebook', 'instagram', 'twitch', 'steam'])) {
                $socialArray[$key] = $value;
                continue;
            }

            if ($key === 'name') {
                $teamData['slug'] = sanitize_title($value);
            }

            $teamData[$key] = $value;
        }

        $teamData['social'] = json_encode($socialArray, JSON_UNESCAPED_SLASHES);

        return Team::query()->insert($teamData);
    }

    /**
     * @return int
     */
    public function update()
    {
        $request = $this->request;
        $socialArray = [];
        $teamData = [];
        foreach ($request->get('values') as $key => $value) {
            if (in_array($key, ['facebook', 'instagram', 'twitch', 'steam'])) {
                $socialArray[$key] = $value;
                continue;
            }

            if ($key === 'name') {
                $teamData['slug'] = sanitize_title($value);
            }

            $teamData[$key] = $value;
        }

        $teamData['social'] = json_encode($socialArray, JSON_UNESCAPED_SLASHES);

        return Team::query()
            ->update($teamData)
            ->where($request->get('teamId'))
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function remove()
    {
        $request = $this->request;
        $teamId  = $request->get('teamId');
        foreach (TeamPlayer::query()->where('team_id', $teamId)->get() as $teamPlayer) {
            TeamPlayer::query()->delete($teamPlayer->id);
        }

        foreach (TeamStream::query()->where('team_id', $teamId)->get() as $teamStream) {
            TeamStream::query()->delete($teamStream->id);
        }

        foreach (TeamAchievement::query()->where('team_id', $teamId)->get() as $teamAchievement) {
            TeamAchievement::query()->delete($teamAchievement->id);
        }

        return Team::query()->delete($teamId);
    }

    /**
     * @return array|mixed|object
     */
    public function getStatistic()
    {
        $request = $this->request;
        $teamId  = $request->get('teamId');
        return json_decode(Team::query()->where($teamId)->get()->first()->stats, true);
    }

    /**
     * @return int
     */
    public function updateStatistic()
    {
        $request = $this->request;
        $updateData = [];
        $requestData = $request->get('values');
        foreach (['win', 'loses', 'ties'] as $key) {
            $updateData[$key] = $requestData[$key];
        }

        return Team::query()
            ->update(['stats' => json_encode($updateData, JSON_UNESCAPED_SLASHES)])
            ->where($request->get('teamId'))
            ->exec()
        ;
    }

    public function updateTeamStream()
    {
        $request = $this->request;
        $teamId = $request->get('teamId');
        foreach (TeamStream::query()->where('team_id', $teamId)->get() as $teamStream) {
            TeamStream::query()->delete($teamStream->id);
        }

        $streamIds = array_filter((array) $request->get('values'));
        foreach ($streamIds as $streamId) {
            TeamStream::query()->insert([
                'team_id' => $teamId,
                'stream_id' => $streamId
            ]);
        }

        return true;
    }

    public function updateTeamAchievement()
    {
        $request = $this->request;
        $teamId = $request->get('teamId');
        foreach (TeamAchievement::query()->where('team_id', $teamId)->get() as $teamAchievement) {
            TeamAchievement::query()->delete($teamAchievement->id);
        }

        $achievementIds = array_filter((array) $request->get('values'));
        foreach ($achievementIds as $achievementId) {
            TeamAchievement::query()->insert([
                'team_id' => $teamId,
                'achievement_id' => $achievementId
            ]);
        }

        return true;
    }

    public function updateTeamPlayer()
    {
        $request = $this->request;
        $teamId = $request->get('teamId');
        foreach (TeamPlayer::query()->where('team_id', $teamId)->get() as $teamPlayer) {
            TeamPlayer::query()->delete($teamPlayer->id);
        }

        $playerIds = array_filter((array) $request->get('values'));
        foreach ($playerIds as $playerId) {
            TeamPlayer::query()->insert([
                'team_id' => $teamId,
                'player_id' => $playerId
            ]);
        }

        return true;
    }
}
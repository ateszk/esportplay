<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\Tournament;
use PixieFreakPanel\Model\TournamentGroup;
use PixieFreakPanel\Model\TournamentGroupTeam;
use PixieFreakPanel\Model\TournamentTeam;

class TournamentDBAL
{
    const SOCIALS = ['twitter', 'instagram', 'discord', 'steam', 'facebook'];

    use DBALTrait;

    /**
     * @param $tournamentId
     * @return array|mixed
     */
    public function find($tournamentId)
    {
        if (!empty($tournament = Tournament::query()->where('id', $tournamentId)->get()->first())) {
            foreach (json_decode($tournament['social'], true) as $social => $ulr) {
                $tournament[$social] = $ulr;
            }

            if (!empty($rr  = json_decode($tournament->random_rule, true))) {
                $tournament->rr_text = $key = key($rr);
                $tournament->rr_value = $rr[$key];
            }

            return $tournament->toArray();
        }
    }

    /**
     * @return int|string
     */
    public function create()
    {
        $request = $this->request;
        $socialArray = [];
        $tournamentData  = [];
        $randomRule = [];
        $requiredFields = ['team_number', 'group_number', 'prize_pool'];
        $data = $request->get('values');
        foreach ($requiredFields as $requiredField) {
            if (empty($data[$requiredField])) {
                $tournamentData[$requiredField] = 0;
                unset($data[$requiredField]);
            }
        }

        if (empty($data['start_date'])) {
            $tournamentData['start_date'] = date('Y-m-d H:i:s');
            unset($data['start_date']);
        }


        foreach ($data as $key => $value) {
            if (in_array($key, self::SOCIALS)) {
                $socialArray[$key] = $value;
                continue;
            }

            if ($key === 'name') {
                $tournamentData['slug'] = sanitize_title($value);
             }

            if ($key == 'rr_value' || $key == 'rr_text') {
                $randomRule[$request->get('values')['rr_text']] = $value;
                continue;
            }

            $tournamentData[$key] = $value;
        }

        $tournamentData['brackets'] = '{teams : [[\'Team 1\', \'Team 2\'], [null, null]], results : []}';
        $tournamentData['random_rule'] = json_encode($randomRule, JSON_UNESCAPED_SLASHES);
        $tournamentData['social'] = json_encode($socialArray, JSON_UNESCAPED_SLASHES);

        try {
            return Tournament::query()->insert($tournamentData);
        } catch (\Exception $ex) {
          //dd($ex->getMessage());
        }
    }

    /**
     * @return int
     */
    public function update()
    {
        $request = $this->request;
        $socialArray = [];
        $tournamentData = [];
        $randomRule = [];
        foreach ($request->get('values') as $key => $value) {
            if (in_array($key, self::SOCIALS)) {
                $socialArray[$key] = $value;
                continue;
            }

            if ($key === 'name') {
                $tournamentData['slug'] = sanitize_title($value);
            }

            if ($key == 'rr_value' || $key == 'rr_text') {
                $randomRule[$request->get('values')['rr_text']] = $value;
                continue;
            }

            $tournamentData[$key] = $value;
        }

        $tournamentData['random_rule'] = json_encode($randomRule, JSON_UNESCAPED_SLASHES);

        $tournamentData['social'] = json_encode($socialArray, JSON_UNESCAPED_SLASHES);

        return Tournament::query()
            ->update($tournamentData)
            ->where($request->get('tournamentId'))
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function remove()
    {
        $request = $this->request;
        $tournamentId = $request->get('tournamentId');
        foreach (TournamentGroup::query()->where('tournament_id', $tournamentId)->get() as $tournamentGroup) {
            TournamentGroup::query()->delete($tournamentGroup->id);
        }

        foreach (TournamentGroupTeam::query()->where('tournament_id', $tournamentId)->get() as $tournamentGroupTeam) {
            TournamentGroupTeam::query()->delete($tournamentGroupTeam->id);
        }

        return Tournament::query()->delete($tournamentId);
    }


    /**
     * @param  int $tournamentGroupId
     * @return array|mixed
     */
    public function findGroup($tournamentGroupId)
    {
        return TournamentGroup::query()->where('id', $tournamentGroupId)->get()->first()->toArray();
    }

    /**
     * @return int|string
     */
    public function createGroup()
    {
        $request = $this->request;
        $data    = $request->get('values');
        TournamentGroup::query()->insert($data);
    }

    /**
     * @return int
     */
    public function updateGroup()
    {
        $request = $this->request;

        return TournamentGroup::query()
            ->update($request->get('values'))
            ->where($request->get('tournamentGroupId'))
            ->exec()
            ;
    }

    /**
     * @return mixed
     */
    public function removeGroup()
    {
        $request = $this->request;
        $tournamentGroupId = $request->get('tournamentGroupId');
        foreach (TournamentGroupTeam::query()->where('tournament_id', $tournamentGroupId)->get() as $tournamentGroupTeam) {
            TournamentGroupTeam::query()->delete($tournamentGroupTeam->id);
        }

        return TournamentGroup::query()->delete($tournamentGroupId);
    }

    /**
     * @param  int $tournamentGroupTeamId
     * @return array|mixed
     */
    public function findGroupTeam($tournamentGroupTeamId)
    {
        return TournamentGroupTeam::query()->find($tournamentGroupTeamId)->toArray();
    }

    /**
     * @return int|string
     */
    public function createGroupTeam()
    {
        $request = $this->request;
        $data    = $request->get('values');

        $tournamentGroup = TournamentGroup::query()->find((int) $request->getFromString($_SERVER['HTTP_REFERER'], 'tournament-id'));
        $data['tournament_group_id'] = $tournamentGroup->id;
        $data['tournament_id'] = $tournamentGroup->tournament_id;

        TournamentGroupTeam::query()->insert($data);
    }

    /**
     * @return int
     */
    public function updateGroupTeam()
    {
        $request = $this->request;
        return TournamentGroupTeam::query()
            ->update($request->get('values'))
            ->where($request->get('tournamentGroupTeamId'))
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function removeGroupTeam()
    {
        $request = $this->request;
        return TournamentGroupTeam::query()->delete($request->get('tournamentGroupTeamId'));
    }

    /**
     * @return bool
     */
    public function updateTournamentTeam()
    {
        $request = $this->request;
        $tournamentId = $request->get('tournamentId');
        foreach (TournamentTeam::query()->where('tournament_id', $tournamentId)->get() as $tournamentTeam) {
            TournamentTeam::query()->delete($tournamentTeam->id);
        }

        $teamIds = array_filter((array) $request->get('values'));
        foreach ($teamIds as $teamId) {
            TournamentTeam::query()->insert([
                'tournament_id' => $tournamentId,
                'team_id' => $teamId
            ]);
        }

        return true;
    }
}
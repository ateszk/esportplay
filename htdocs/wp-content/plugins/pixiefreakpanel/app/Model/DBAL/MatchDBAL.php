<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\Match;
use PixieFreakPanel\Model\Team;

class MatchDBAL
{
    use DBALTrait;

    /**
     * @param  $matchId
     * @return array|mixed
     */
    public function find($matchId)
    {
        if (!empty($match = Match::query()->find($matchId))) {
            return $match->toArray();
        }
    }

    /**
     * @return int|string
     */
    public function create()
    {
        $request = $this->request;
        $matchData  = [];
        $values = $request->get('values');

        $requiredFields = ['team_a_result', 'team_b_result'];
        foreach ($requiredFields as $requiredField) {
            if (empty(($values[$requiredField]))) {
                unset($values[$requiredField]);
            }
        }

        if (empty($values['start_date'])) {
            $values['start_date'] = date('Y-m-d H:i:s');
            unset($values['start_date']);
        }

        foreach ($values as $key => $value) {
            if ($key === 'team_a_id') {
                if (count($teamA = Team::query()->find($value)) > 0) {
                    $matchData['team_a_name'] = $teamA->name;
                    $matchData['team_a_logo'] = $teamA->team_logo;
                }

                $matchData[$key] = $value;
                continue;
            }

            if ($key === 'team_b_id') {
                if (count($teamB = Team::query()->find($value)) > 0) {
                    $matchData['team_b_name'] = $teamB->name;
                    $matchData['team_b_logo'] = $teamB->team_logo;
                }

                $matchData[$key] = $value;
                continue;
            }

            $matchData[$key] = $value;
        }

        try {
            $lastId = Match::query()->insert($matchData);

            Match::query()
                ->update([
                    'slug' => sanitize_title(
                        $matchData['team_a_name'] . '-' . $matchData['team_b_name'] . '-' . $lastId
                    )
                ])
                ->where($lastId)
                ->exec()
            ;

            return $lastId;
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
        $matchData = [];
        foreach ($values = $request->get('values') as $key => $value) {
            if ($key === 'team_a_id') {
                if (count($teamA = Team::query()->find($value)) > 0) {
                    $matchData['team_a_name'] = $teamA->name;
                    $matchData['team_a_logo'] = $teamA->team_logo;
                } else {
                    $matchData['team_a_name'] = '';
                    $matchData['team_a_logo'] = '';
                }

                $matchData[$key] = $value;
                continue;
            }

            if ($key === 'team_b_id') {
                if (count($teamB = Team::query()->find($value)) > 0) {
                    $matchData['team_b_name'] = $teamB->name;
                    $matchData['team_b_logo'] = $teamB->team_logo;
                } else {
                    $matchData['team_b_name'] = '';
                    $matchData['team_b_logo'] = '';
                }

                $matchData[$key] = $value;
                continue;
            }

            $matchData[$key] = $value;
        }

        Match::query()
            ->update([
                'slug' => sanitize_title(
                    $matchData['team_a_name'] . '-' . $matchData['team_b_name'] . '-' . $request->get('matchId')
                )
            ])
            ->where($request->get('matchId'))
            ->exec()
        ;

        return Match::query()
            ->update($matchData)
            ->where($request->get('matchId'))
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function remove()
    {
        return Match::query()->delete($this->request->get('matchId'));
    }
}
<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\Achievement;
use PixieFreakPanel\Model\TeamAchievement;

class AchievementDBAL
{
    use DBALTrait;

    public function create()
    {
        $request = $this->request;
        $data = [];
        foreach ($request->get('values') as $key => $value) {
            $data[$key] = $value;
            if ($key === 'name') {
                $data['slug'] = sanitize_title($value);
                $data['title'] = $value;
            }
        }

        return Achievement::query()->insert($data);
    }

    public function remove()
    {
        $request = $this->request;
        foreach (TeamAchievement::query()->where('achievement_id', $request->get('achievementId'))->get() as $teamAchievement) {
            TeamAchievement::query()->delete($teamAchievement->id);
        }

        return Achievement::query()->delete($request->get('achievementId'));
    }

    public function update()
    {
        $request = $this->request;
        $data  = [];
        foreach ($request->get('values') as $key => $value) {
            $data[$key] = $value;

            if ($key === 'name') {
                $data['slug'] = sanitize_title($value);
                $data['title'] = $value;
            }
        }

        if (empty($data['thumbnail'])) {
            unset($data['thumbnail']);
        }

        return Achievement::query()
            ->update($data)
            ->where($request->get('achievementId'))
            ->exec()
        ;
    }
}
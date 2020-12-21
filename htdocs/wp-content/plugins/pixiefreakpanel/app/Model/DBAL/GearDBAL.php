<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\Gear;
use PixieFreakPanel\Model\PlayerGear;

class GearDBAL
{
    use DBALTrait;

    public function create()
    {
        $request = $this->request;
        $data = [];
        foreach ($request->get('values') as $key => $value) {
            $data[$key] = $value;
        }

        return Gear::query()->insert($data);
    }

    public function remove()
    {
        $request = $this->request;
        foreach (PlayerGear::query()->where('gear_id', $request->get('gearId'))->get() as $playerGear) {
            PlayerGear::query()->delete($playerGear->id);
        }

        return Gear::query()->delete($request->get('gearId'));
    }

    public function update()
    {
        $request = $this->request;
        $data  = [];
        foreach ($request->get('values') as $key => $value) {
            $data[$key] = $value;
        }

        if (empty($data['image'])) {
            unset($data['image']);
        }

        return Gear::query()
            ->update($data)
            ->where($request->get('gearId'))
            ->exec()
        ;
    }
}
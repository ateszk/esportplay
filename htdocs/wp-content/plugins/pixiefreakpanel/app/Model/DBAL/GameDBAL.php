<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\Game;

class GameDBAL
{
    use DBALTrait;

    public function get()
    {
        return Game::query()->find($this->request->get('gameId'))->toArray();
    }

    /**
     * @return mixed
     */
    public function update()
    {
        $values  = $this->request->get('values');
        $values['slug'] = sanitize_title($values['title']);

        if (empty($values['thumbnail'])) {
            unset($values['thumbnail']);
        }

        if (empty($values['cover'])) {
            unset($values['cover']);
        }

        return Game::query()
            ->update($values)
            ->where($this->request->get('gameId'))
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function remove()
    {
        $request = $this->request;
        return Game::query()->delete($request->get('gameId'));
    }

    /**
     * @return int|string
     */
    public function create()
    {
        $values  = $this->request->get('values');
        $values['slug'] = sanitize_title($values['name']);
        return Game::query()->insert($values);
    }
}
<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\PlayerStream;
use PixieFreakPanel\Model\Stream;
use PixieFreakPanel\Model\TeamStream;

class StreamDBAL
{
    use DBALTrait;

    /**
     * @return mixed
     */
    public function update()
    {
        $request = $this->request;
        $values  = $request->get('values');
        $values['slug'] = sanitize_title($values['title']);

        if (empty($values['thumbnail'])) {
            unset($values['thumbnail']);
        }

        return Stream::query()
            ->update($values)
            ->where($request->get('streamId'))
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function remove()
    {
        $request = $this->request;
        foreach (TeamStream::query()->where('stream_id', $request->get('streamId'))->get() as $item) {
            TeamStream::query()->delete($item->id);
        }

        foreach (PlayerStream::query()->where('stream_id', $request->get('streamId'))->get() as $item) {
            PlayerStream::query()->delete($item->id);
        }

        return Stream::query()->delete($request->get('streamId'));
    }

    /**
     * @return int|string
     */
    public function create()
    {
        $request = $this->request;
        $values  = $request->get('values');
        $values['slug'] = sanitize_title($values['title']);

        return Stream::query()->insert($values);
    }
}
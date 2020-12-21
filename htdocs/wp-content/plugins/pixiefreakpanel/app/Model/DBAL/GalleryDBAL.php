<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\Gallery;
use PixieFreakPanel\Model\GalleryCategory;
use PixieFreakPanel\Service\GlobalSettings\Resolver;

class GalleryDBAL extends Resolver
{
    use DBALTrait;

    /**
     * @return int|string
     */
    public function createPhoto()
    {
        $request = $this->request;
        return Gallery::query()->insert($request->get('values'));
    }

    /**
     * @return mixed
     */
    public function updatePhoto()
    {
        $request = $this->request;
        $update = [];
        if ($request->has('values') && !empty($request->get('values')['image'])) {
            $data = $request->get('values');
            $update['image'] = $data['image'];
        }

        if ($request->has('values') && !empty($request->get('values')['gallery_category_id'])) {
            $data = $request->get('values');
            $update['gallery_category_id'] = $data['gallery_category_id'];
        }

        return Gallery::query()
            ->update($update)
            ->where('id', (int) $request->get('galleryId'))
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function removePhoto()
    {
        $request = $this->request;
        return Gallery::query()->delete($request->get('galleryId'));
    }

    /**
     * @return int|string
     */
    public function createCategory()
    {
        $request = $this->request;
        return GalleryCategory::query()->insert($request->get('values'));
    }

    /**
     * @return mixed
     */
    public function updateCategory()
    {
        return GalleryCategory::query()
            ->update(['name' => $this->request->get('values')['name'] ?: ''])
            ->where('id', (int) $this->request->get('categoryId'))
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function removeCategory()
    {
        $request = $this->request;
        return GalleryCategory::query()->delete($request->get('categoryId'));
    }
}
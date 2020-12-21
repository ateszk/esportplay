<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use FusionFramework\Response;
use PixieFreakPanel\Model\DBAL\GalleryDBAL;
use PixieFreakPanel\Model\Gallery;
use PixieFreakPanel\Model\GalleryCategory;
use \PixieFreakPanel\Service\GlobalSettings\Gallery as GalleryService;

class GalleryController extends Controller
{
    /**
     * GalleryController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, GalleryDBAL::class);
    }

    public function index()
    {
        echo view('gallery.index', [
            'sidebar' => 'gallery',
            'photos' => Gallery::query()->get(),
            'categories' => GalleryCategory::query()->get()
        ]);
    }

    /**
     * @param Request  $request
     * @param Response $response
     */
    public function update(Request $request, Response $response)
    {
        if ($request->isPost() || $request->isXmlHttpRequest()) {
            if ($request->has('task')) {
                $task = $request->get('task');
                if ($task === 'general_settings') {
                    $galleryDBAL = $this->DBAL;
                    $galleryDBAL->updateConstraints(
                        GalleryService::class,
                        $this->resolveExcluding('gallery_banner_image')
                    );

                    $response->redirect('gallery_index', $this->defaultResponseData(), $this->getActiveTab());
                }
            }

            $response->redirect('gallery_index', $this->defaultResponseData(), $this->getActiveTab());
        }

        $response->redirect('gallery_index', $this->defaultResponseData(), $this->getActiveTab());
    }

    /**
     * @param Request $request
     */
    public function getPhoto(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('galleryId')) {
            $gallery = Gallery::query()->where($request->get('galleryId'))->get()->toArray()[0];
            return response()->json($gallery);
        }
    }

    /**
     * @param Request $request
     */
    public function updatePhoto(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('galleryId')) {
            return response()->json($this->DBAL->updatePhoto());
        }
    }

    /**
     * @param Request $request
     */
    public function removePhoto(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('galleryId')) {
            return response()->json($this->DBAL->removePhoto());
        }
    }

    /**
     * @param Request $request
     */
    public function createPhoto(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json($this->DBAL->createPhoto());
        }
    }

    /**
     * @param Request $request
     */
    public function getCategory(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('categoryId')) {
            $gallery = GalleryCategory::query()->where($request->get('categoryId'))->get()->toArray()[0];
            return response()->json($gallery);
        }
    }

    /**
     * @param Request $request
     */
    public function updateCategory(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('categoryId')) {
            return response()->json($this->DBAL->updateCategory());
        }
    }

    /**
     * @param Request $request
     */
    public function removeCategory(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('categoryId')) {
            return response()->json($this->DBAL->removeCategory());
        }
    }

    /**
     * @param Request $request
     */
    public function createCategory(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            return response()->json($this->DBAL->createCategory());
        }
    }
}
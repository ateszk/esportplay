<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use FusionFramework\Response;
use PixieFreakPanel\Model\DBAL\StreamDBAL;
use PixieFreakPanel\Model\GlobalSettings;
use PixieFreakPanel\Service\GlobalSettings\Stream;
use PixieFreakPanel\Service\Stream\API;

class StreamController extends Controller
{
    /**
     * StreamController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, StreamDBAL::class);
    }

    public function index()
    {
        echo view('stream.index', [
            'sidebar' => 'stream',
            'streams' => \PixieFreakPanel\Model\Stream::query()->get()
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
                $streamDBAL = $this->DBAL;
                if ($task === 'general_settings') {
                    $streamDBAL->updateConstraints(
                        Stream::class,
                        $this->resolveExcluding('stream_banner_image')
                    );

                    return response()->redirect('stream_index', $this->defaultResponseData(), $this->getActiveTab());
                }

                if ($task === 'order' && $request->has('sortedIds')) {
                    $streamDBAL->updateOrder();
                    return response()->redirect('stream_index', $this->defaultResponseData(), $this->getActiveTab());
                }
            }

            $response->redirect('stream_index', $this->defaultResponseData(), $this->getActiveTab());
        }

        $response->redirect('stream_index', $this->defaultResponseData(), $this->getActiveTab());
    }

    public function validateApi(Request $request)
    {
        if ($request->isPost() || $request->isXmlHttpRequest()) {
            if ($request->has('network')) {
                $isValid = API::handshake($key = $request->get('api'), strtolower($network = $request->get('network')));
                if (in_array($network = $request->get('network'), API::NETWORKS)) {
                    foreach ($update = pixiefreak_settings('stream')->get('api') as $networkName => $value) {
                        if ($isValid && ($networkName == $network)) {
                            $update[$networkName] = $key;
                        }
                    }

                    if ($isValid) {
                        return response()->json([GlobalSettings::query()
                            ->update(['value' => json_encode($update, JSON_UNESCAPED_SLASHES)])
                            ->where('module_name', 'stream')
                            ->where('key', 'api')
                            ->exec()
                        ]);
                    }

                    return response()->json(['invalid']);
                }
            }

            return response()->json(['invalid']);
        }

        return response()->json(['invalid']);
    }

    /**
     * @param Request $request
     */
    public function createStream(Request $request)
    {
        if ($request->isXmlHttpRequest()) {
            $streamDBAL = $this->DBAL;
            $createdStream = \PixieFreakPanel\Model\Stream::query()->where((int) $streamDBAL->create())->get()->first();
            return response()->json(
                view('stream.tabs.partials.stream-table-tr', [
                'stream' => $createdStream
                ], false, true)
            );
        }
    }

    /**
     * @param Request $request
     */
    public function removeStream(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('streamId')) {
            return response()->json($this->DBAL->remove());
        }
    }

    public function updateStream(Request $request)
    {
        if ($request->isXmlHttpRequest() && $request->has('streamId')) {
            return response()->json($this->DBAL->update());
        }
    }

    /**
     * @param Request $request
     */
    public function getStream(Request $request)
    {;
        if ($request->isXmlHttpRequest() && $request->has('streamId')) {
            $streamMember = \PixieFreakPanel\Model\Stream::query()->where($request->get('streamId'))->get()->toArray()[0];
            return response()->json($streamMember);
        }
    }
}
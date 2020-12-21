<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Request;
use PixieFreakPanel\Model\DBAL\GameDBAL;
use PixieFreakPanel\Model\Game;

class GameController extends Controller
{
    /**
     * GameController constructor.
     *
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        parent::__construct($request, GameDBAL::class);
    }

    public function index()
    {
        echo view('game.index', [
            'sidebar' => 'game',
            'games' => Game::query()->get()
        ]);
    }

    public function get()
    {
        return response()->json($this->DBAL->get());
    }

    public function create()
    {
        return response()->json($this->DBAL->create());
    }

    public function update()
    {
        return response()->json($this->DBAL->update());
    }

    public function remove()
    {
        return response()->json($this->DBAL->remove());
    }
}
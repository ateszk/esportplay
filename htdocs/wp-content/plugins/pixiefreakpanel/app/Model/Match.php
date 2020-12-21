<?php

namespace PixieFreakPanel\Model;

use FusionFramework\Database\ORM;

class Match extends ORM
{
    const STATUSES = [
        1 => 'Upcoming',
        3 => 'Finished'
    ];

    const TYPES = [
        1 => 'Offline',
        2 => 'Online'
    ];

    const COLS = [
        'id',
        'game_id',
        'name',
        'slug',
        'start_date',
        'tournament_id',
        'team_a_id',
        'team_a_name',
        'team_a_logo',
        'team_a_result',
        'team_b_id',
        'team_b_name',
        'team_b_logo',
        'team_b_result',
        'status',
        'type'
    ];

    /**
     * @var string $table
     */
    protected $table = 'match';
}
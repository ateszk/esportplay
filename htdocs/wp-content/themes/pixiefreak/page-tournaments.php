<?php /* Template Name: Tournaments */ ?>
<?php
    if(!pixiefreak_active()) {
        wp_redirect(get_home_url()); die();
    }
    $settings = pixiefreak_settings('tournaments');
    $tournaments = \PixieFreakPanel\Model\Tournament::query()->paginate(pixiefreak_pagination_page(), 8);
    $headerBackground = $settings->get('banner_image');
?>

<?php get_header(); ?>
<section class="page-hero">
    <div class="container">
        <h2><?php echo esc_html($settings->get('title')); ?></h2>
        <h4><?php echo esc_html($settings->get('subtitle')); ?></h4>

        <ul class="tab-nav">

            <li<?php echo !pixiefreak_get('filter') ? ' class="active"' : ''; ?>>
                <a href="javascript: void(0)" id="filter-all"
                   class="filterize"
                   data-filter-url="<?php echo esc_url(get_home_url(null, pixiefreak_getRoute('tournaments')));?>">
                    <i class="fas fa-list"></i>
                </a>
            </li>

            <?php foreach (\PixieFreakPanel\Model\Game::query()->get() as $game): ?>
                <?php if (\PixieFreakPanel\Model\Tournament::query()->where('game_id', (int) $game->id)->get()->count() <= 0): continue; endif; ?>
                <li<?php echo pixiefreak_get('filter') == $game->id ? ' class="active"' : ''; ?>>
                    <a href="javascript: void(0)" id="filter-<?php echo esc_attr($game->id); ?>"
                       class="filterize"  data-filter-url="<?php echo esc_url(get_home_url(null, pixiefreak_getRoute('tournaments') . '?filter=' . $game->id));?>">
                        <img src="<?php echo esc_url($game->thumbnail); ?>" alt="<?php echo esc_attr($game->name) ?>">
                    </a>
                </li>
            <?php endforeach; ?>
        </ul>
    </div>
</section>

<section class="tournaments">
    <div class="container">

        <?php if ($gameId = pixiefreak_get('filter')): ?>
            <?php $tournaments = \PixieFreakPanel\Model\Tournament::query()
                ->where('game_id', (int) $gameId)
                ->paginate(pixiefreak_pagination_page(), 8);
            ?>
        <?php endif; ?>

        <div class="tab-content">

            <ul id="recent"
                class="tournament-list active">
                <?php foreach ($tournaments as $tournament): ?>
                    <li class="tournament-box" style="background-image: url('<?php echo esc_html($tournament->thumbnail) ?>')">

                        <!-- Details about Tournament-->
                        <div class="tournament-body">
                            <!-- Tournament Name -->
                            <a href="<?php echo pixiefreak_route('tournament', $tournament->slug); ?>"
                               class="tournament-name">
                                <?php echo esc_attr($tournament->name); ?>
                            </a>
                            <!-- Tournament Date -->
                            <span class="date"><?php echo date('M.d.Y - h:i A', strtotime($tournament->start_date)); ?></span>

                            <!-- Game Logo -->
                            <figure>
                                <?php if (!empty($game = \PixieFreakPanel\Model\Tournament::query()->game($tournament))): ?>
                                <img src="<?php echo esc_url($game->thumbnail); ?>" alt="<?php echo esc_attr($game->name); ?>">
                                <?php endif; ?>
                            </figure>
                        </div>

                        <div class="tournament-footer">
                            <div class="col">
                                <?php $groups = \PixieFreakPanel\Model\TournamentGroup::query()->where('tournament_id', $tournament->id)->get(); ?>
                                <div class="col-item">
                                    <h5><?php echo esc_html($groups->count()); ?> <?php echo esc_html__('Csoportok', 'pixiefreak'); ?></h5>
                                    <p><?php echo esc_html($tournament->team_number); ?> <?php echo esc_html__('Csapatok', 'pixiefreak'); ?></p>
                                </div>
                                <?php if (!empty($randomRule = json_decode($tournament->random_rule, true))): ?>
                                    <div class="col-item">
                                        <h5><?php echo esc_html($key = key($randomRule)); ?></h5>
                                        <p><?php echo esc_html($randomRule[$key]); ?></p>
                                    </div>
                                <?php endif; ?>
                                <div class="col-item">
                                    <h5><?php echo esc_html__('Nyeremény', 'pixiefreak'); ?></h5>
                                    <p>$ <?php echo esc_html($tournament->prize_pool); ?> <?php echo esc_html__('USD', 'pixiefreak') ?></p>
                                </div>
                            </div>

                            <div class="col align-right">
                                <a href="<?php echo pixiefreak_route('tournament', $tournament->slug); ?>" class="btn-default">
                                    <?php echo esc_html__('Megnézem', 'pixiefreak'); ?> <i class="fas fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>

                    </li>
                <?php endforeach; ?>
            </ul>

            <?php echo pixiefreak_pagination($tournaments, 'tournaments'); ?>
        </div>
    </div>
</section>
<?php get_footer(); ?>

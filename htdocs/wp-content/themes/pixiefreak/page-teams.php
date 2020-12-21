<?php /* Template Name: Teams */ ?>
<?php
    if(!pixiefreak_active()) {
        wp_redirect(get_home_url()); die();
    }
    $settings = pixiefreak_settings('teams');
    $teams = \PixieFreakPanel\Model\Team::query()->where('my_team', 1)->paginate(pixiefreak_pagination_page(), 8);
    $headerBackground = $settings->get('teams_banner_image');
?>

    <?php get_header(); ?>


    <section class="page-hero">
        <div class="container">
            <h2><?php echo esc_html($settings->get('title')); ?></h2>
            <h4><?php echo esc_html($settings->get('subtitle')); ?></h4>
        </div>
    </section>

    <section class="teams page-bg">
        <div class="container">
            <div class="inner-page-header">
                <div class="headline">
                    <h4><?php echo esc_html__('Válaszd ki a szűrő opciót a jobb oldalon', 'pixiefreak'); ?></h4>
                    <span><?php echo esc_html__('alább találhatod a magyar csapatokat', 'pixiefreak'); ?></span>
                </div>

                <ul class="filter-list">
                    <li>
                        <label class="checkbox-container" for="filter-all">
                            <?php echo esc_html__('Összes', 'pixiefreak'); ?>
                            <input type="radio" name="filter" id="filter-all" class="filterize"
                                   data-filter-url="<?php echo esc_url(get_home_url(null, pixiefreak_getRoute('teams')));?>"
                                   <?php echo !pixiefreak_get('filter') ? 'checked=""' : ''; ?>>
                            <span class="checkmark"></span>
                        </label>
                    </li>

                    <?php foreach (\PixieFreakPanel\Model\Game::query()->get() as $game): ?>
                        <?php if (\PixieFreakPanel\Model\Team::query()->where('game_id', (int) $game->id)->get()->count() <= 0): continue; endif; ?>
                        <li>
                            <label class="checkbox-container"
                                   for="filter-<?php echo esc_attr($game->id); ?>"
                            >
                                <?php echo esc_html($game->name); ?>
                                <input type="radio" name="filter" id="filter-<?php echo esc_attr($game->id); ?>"
                                       class="filterize"
                                       data-filter-url="<?php echo esc_url(get_home_url(null, pixiefreak_getRoute('teams') . '?filter=' . $game->id));?>"
                                       <?php echo pixiefreak_get('filter') == $game->id ? 'checked=""' : ''; ?>>
                                <span class="checkmark"></span>
                            </label>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>

            <?php if ($gameId = pixiefreak_get('filter')): ?>
                <?php $teams = \PixieFreakPanel\Model\Team::query()
                    ->where('game_id', (int) $gameId)
		            ->where('my_team', 1)
                    ->paginate(pixiefreak_pagination_page(), 8);
                ?>
            <?php endif; ?>

            <div class="tab-content">
                <div class="team-list active">
                    <?php if (!empty($teams) > 0): ?>
                        <?php foreach ($teams as $team): ?>
                            <?php $game = \PixieFreakPanel\Model\Game::query()->where('id', $team->game_id)->get()->first() ?>
                            <div class="team-box">
                                <div class="team-body">
                                    <h3>
                                        <a href="<?php echo pixiefreak_route('team', $team->slug); ?>">
                                            <?php echo esc_html($team->name); ?>
                                        </a>
                                    </h3>

                                    <span><?php echo esc_html($game->name) ?></span>

                                    <?php if (!empty($players = \PixieFreakPanel\Model\Team::query()->player($team))): ?>
                                        <ul class="members">
                                            <?php $i=0; foreach ($players as $player): $i++;?>
                                                <?php if ($i > 4): continue; endif;?>
                                                <li>
                                                    <a href="<?php echo pixiefreak_route('player', $player->slug); ?>">
                                                        <img src="<?php echo esc_url($player->avatar); ?>" alt="<?php echo esc_attr($player->slug); ?>">
                                                    </a>
                                                </li>
                                            <?php endforeach; ?>
                                        </ul>
                                    <?php endif; ?>
                                </div>

                                <div class="team-foot">
                                    <div class="col">
                                        <h5><?php echo esc_html__('Származás', 'pixiefreak'); ?></h5>
	                                    <?php $country = \PixieFreakPanel\Model\Countries::findAll($team->country); ?>
                                        <p><?php echo esc_html($country['name']) ?></p>
                                    </div>

                                    <div class="col align-right">
                                        <a href="<?php echo pixiefreak_route('team', $team->slug); ?>" class="btn-default">
	                                        <?php echo esc_html__('Team page', 'pixiefreak'); ?> <i class="fas fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </div>

                <?php echo pixiefreak_pagination($teams, 'teams'); ?>
            </div>
        </div>
    </section>

<?php get_footer(); ?>
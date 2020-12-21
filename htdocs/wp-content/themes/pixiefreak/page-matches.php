<?php /* Template Name: Matches */ ?>
<?php
if(!pixiefreak_active()) {
	wp_redirect(get_home_url()); die();
}
$settings = pixiefreak_settings('match');

$headerBackground = $settings->get('banner_image')
?>

<?php get_header(); ?>

<section class="page-hero">
    <div class="container">
        <h2><?php echo esc_html($settings->get('title')); ?></h2>
        <h4><?php echo esc_html($settings->get('subtitle')); ?></h4>

        <ul class="tab-nav">
			<?php foreach ($statuses = \PixieFreakPanel\Model\Match::STATUSES as $key => $status): ?>
                <li<?php echo reset($statuses) === $status ? ' class="active"' : ''; ?>>
                    <a  href="#<?php echo esc_attr(strtolower($status) .'-match'); ?>"
                        class="btn-default"
                        data-toggle="tab">
						<?php if ($status == 'Upcoming'): ?>
							<?php echo esc_html__('Következő', 'pixiefreak'); ?>
						<?php else: ?>
							<?php echo esc_html__('Befejezett', 'pixiefreak'); ?>
						<?php endif; ?>
                    </a>
                </li>
			<?php endforeach; ?>
        </ul>
    </div>
</section>

<section class="matches">
    <div class="container">
        <div class="inner-page-header">
            <div class="headline">
                <h4><?php echo esc_html__('Válaszd ki a szűrő opciót a jobb oldalon', 'pixiefreak'); ?></h4>
                <span><?php echo esc_html__('alább találhatod a magyar mérkőzéseket', 'pixiefreak'); ?></span>
            </div>

            <ul class="filter-list">
                <li>
                    <label class="checkbox-container" for="filter-all">
						<?php echo esc_html__('Összes', 'pixiefreak'); ?>
                        <input type="radio" name="filter" id="filter-all" class="filterize"
                               data-filter-url="<?php echo esc_url(get_home_url(null, pixiefreak_getRoute('matches')));?>"
							<?php echo !pixiefreak_get('filter') ? 'checked=""' : ''; ?>>
                        <span class="checkmark"></span>
                    </label>
                </li>

				<?php foreach (\PixieFreakPanel\Model\Game::query()->get() as $game): ?>
					<?php
					if (empty(\PixieFreakPanel\Model\Match::query()->where('game_id', $game->id)->get()->first())) {
						continue;
					}
					?>
                    <li>
                        <label class="checkbox-container"
                               for="filter-<?php echo esc_attr($game->id); ?>"
                        >
							<?php echo esc_html($game->name); ?>
                            <input type="radio" name="filter" id="filter-<?php echo esc_attr($game->id); ?>"
                                   class="filterize"
                                   data-filter-url="<?php echo esc_url(get_home_url(null, pixiefreak_getRoute('matches') . '?filter=' . $game->id));?>"
								<?php echo pixiefreak_get('filter') == $game->id ? 'checked=""' : ''; ?>>
                            <span class="checkmark"></span>
                        </label>
                    </li>
				<?php endforeach; ?>
            </ul>
        </div>

        <div class="scrollbar-outer">
            <div class="tab-content">
				<?php foreach ($statuses as $key => $status): ?>
                    <ul class="match-list<?php echo reset($statuses) === $status ? ' active' : ''; ?>" id="<?php echo esc_attr(strtolower($status) .'-match'); ?>">
						<?php
						$matches = \PixieFreakPanel\Model\Match::query()->where('status', $key);
						if ($status == 'Finished') {
							$matches = $matches->orderBy('start_date', 'desc');
						}

						if ($gameId = pixiefreak_get('filter')) {
							$matches = $matches->where('game_id', (int) $gameId)->paginate(pixiefreak_pagination_page(), 8);
						} else {
							$matches = $matches->get();
						}
						?>
						<?php foreach ($matches as $match): ?>
                            <li class="match-box">
                                <div class="box-title">
									<?php $tournament = \PixieFreakPanel\Model\Tournament::query()->find($match->tournament_id); ?>
									<?php  if (count($tournament) > 0): ?>
                                        <span>
                                            <?php echo esc_html($tournament->name); ?>
                                        </span>
                                        <span class="date">
                                                <?php echo esc_html(date_i18n('d M Y h:i A', strtotime($match->start_date))); ?>
                                            <a href="<?php echo pixiefreak_route('match', $match->slug); ?>">
                                                        <?php echo esc_html__('Megnézem', 'pixiefreak'); ?>
                                                <i class="fas fa-play"></i>
                                                </a>
                                            </span>
									<?php endif; ?>
                                </div>

                                <div class="match-details">
									<?php
									$teamA = \PixieFreakPanel\Model\Team::query()->find($match->team_a_id);
									$teamB = \PixieFreakPanel\Model\Team::query()->find($match->team_b_id);
									?>
                                    <div class="team-box">
                                        <a href="<?php echo pixiefreak_route('team', $teamA->slug); ?>">
                                            <img src="<?php echo esc_url($teamA->team_logo); ?>" alt="<?php echo esc_attr($teamA->name) ?>">
                                        </a>

                                        <div class="team-details">
                                            <div class="team-name">
                                                <span><?php echo esc_html($teamA->name); ?></span>
                                            </div>

											<?php if (!empty($players = \PixieFreakPanel\Model\Team::query()->player($teamA))): ?>
                                                <ul class="members">
													<?php $i=0; foreach ($players as $player): $i++;?>
														<?php if ($i > 4): continue; endif;?>
                                                        <li>
                                                            <a href="<?php echo pixiefreak_route('player', $player->slug); ?>">
                                                                <img src="<?php echo esc_url($player->avatar); ?>" alt="<?php echo esc_attr($player->slug) ?>">
                                                            </a>
                                                        </li>
													<?php endforeach; ?>
                                                </ul>
											<?php endif; ?>
                                        </div>
                                    </div>

                                    <div class="col">
                                        <span class="result">
                                            <?php if ($match->status == array_flip(\PixieFreakPanel\Model\Match::STATUSES)['Upcoming']): ?>
	                                            <?php echo esc_html__('VS', 'pixiefreak'); ?>
                                            <?php else: ?>
	                                            <?php echo esc_html($match->team_a_result . ':' . $match->team_b_result); ?>
                                            <?php endif; ?>
                                        </span>
                                    </div>

									<?php if (!empty($teamB)): ?>
                                        <div class="team-box">
                                            <a href="<?php echo pixiefreak_route('team', $teamB->slug); ?>">
                                                <img src="<?php echo esc_url($teamB->team_logo); ?>" alt="<?php echo esc_attr($teamB->name); ?>">
                                            </a>

                                            <div>
                                                <div class="team-name">
                                                    <span><?php echo esc_html($teamB->name); ?></span>
                                                </div>

												<?php if (!empty($players = \PixieFreakPanel\Model\Team::query()->player($teamB))): ?>
                                                    <ul class="members">
														<?php $i=0; foreach ($players as $player): $i++;?>
															<?php if ($i > 4): continue; endif;?>
                                                            <li>
                                                                <a href="<?php echo pixiefreak_route('player', $player->slug); ?>">
                                                                    <img src="<?php echo esc_url($player->avatar); ?>" alt="<?php echo esc_attr($player->slug) ?>">
                                                                </a>
                                                            </li>
														<?php endforeach; ?>
                                                    </ul>
												<?php endif; ?>
                                            </div>
                                        </div>
									<?php endif; ?>
                                </div>

                                <span class="game-name"><?php echo esc_html(\PixieFreakPanel\Model\Game::query()->find($match->game_id)->name); ?></span>
                            </li>
						<?php endforeach; ?>
                    </ul>
				<?php endforeach; ?>
            </div>
        </div>
    </div>
</section>

<?php get_footer(); ?>

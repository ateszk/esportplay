<?php /* Template Name: Tournament */ ?>
<?php
if(!pixiefreak_active()) {
	wp_redirect(get_home_url()); die();
}
$slug = esc_attr(get_query_var('tournament_slug'));
$settings = pixiefreak_settings('tournament');
$tournament = \PixieFreakPanel\Model\Tournament::query()->where('slug', $slug)->get()->first();
if (empty($tournament)) {
	wp_redirect(get_home_url()); die();
}

$groups = \PixieFreakPanel\Model\TournamentGroup::query()->where('tournament_id', $tournament->id)->get();
$game = \PixieFreakPanel\Model\Tournament::query()->game($tournament);
$teams = \PixieFreakPanel\Model\Tournament::query()->teams($tournament);

$headerBackground = $tournament->cover;
$pageTagLine = $tournament->name;

?>

<?php get_header(); ?>

<!-- TOURNAMENT -->
<section class="tournament inner-page">
    <div class="container">
        <div class="inner-header" style="background-image: url('<?php echo esc_url($tournament->banner) ?>');">
            <div class="inner-header-info">
                <figure>
                    <img src="<?php echo esc_url($tournament->logo); ?>" alt="<?php echo esc_attr($tournament->name); ?>">
                </figure>

                <div class="inner-header-details">
                    <span><?php echo esc_attr($tournament->name); ?></span>

                    <ul>
                        <li>
                            <i class="fas fa-map-marker-alt"></i> <?php echo esc_html($tournament->location); ?>
                        </li>

                        <li>
                            <i class="fas fa-clock"></i> <?php echo date_i18n('d M Y H:i A', strtotime($tournament->start_date)); ?>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="inner-body">
            <article class="top">
                <div class="col left about">
                    <figure>
                        <img src="<?php echo esc_url($game->thumbnail); ?>" alt="<?php echo esc_attr($tournament->name); ?>">
                    </figure>
                </div>

                <div class="col right">

					<?php if ($settings->shouldShow('cta_left.show')): ?>
                        <a href="<?php echo esc_url($settings->get('cta_left.link')); ?>" class="btn btn-primary">
							<?php echo esc_attr($settings->get('cta_left.text')); ?>
                        </a>
					<?php endif; ?>

					<?php if ($settings->shouldShow('cta_right.show')): ?>
                        <a href="<?php echo esc_url($settings->get('cta_right.link')); ?>" class="btn btn-black">
							<?php echo esc_attr($settings->get('cta_right.text')); ?>
                        </a>
					<?php endif; ?>
                </div>
            </article>

            <article class="bottom">

                <div class="col left textarea">
                    <div class="text-head">
                        <h4><?php echo esc_html__('A versenyről', 'pixiefreak'); ?></h4>

						<?php if (!empty($socials = json_decode($tournament->social))): ?>
                            <ul class="social-list">
								<?php foreach ($socials as $socialName => $url): ?>
									<?php if (empty($url)): continue; endif;?>
                                    <li>
                                        <a href="<?php echo esc_url($url); ?>" target="_blank">
                                            <i class="fab fa-<?php echo esc_attr($socialName); ?>"></i>
                                        </a>
                                    </li>
								<?php endforeach; ?>
                            </ul>
						<?php endif; ?>
                    </div>

                    <div class="scrollbar-outer">
                        <p>
							<?php echo nl2br(wp_specialchars_decode($tournament->about)); ?>
                        </p>
                    </div>
                </div>

                <div class="col right">
                    <ul class="stats stats-tournament">
                        <li>
                            <h5><?php echo esc_html($tournament->team_number); ?> <?php echo esc_html__('Csapat', 'pixiefreak'); ?></h5>
                            <span><?php echo esc_html__('Jelentkezők', 'pixiefreak'); ?></span>
                        </li>
                        <li>
                            <h5><?php echo esc_html($groups->count()); ?> <?php echo esc_html__('Csoport', 'pixiefreak'); ?></h5>
                            <span><?php echo esc_html(\PixieFreakPanel\Model\Tournament::query()->playersCount($tournament)); ?> <?php echo esc_html__('Játékosok', 'pixiefreak'); ?></span>
                        </li>
                        <li>
                            <h5><?php echo esc_html__('Nyeremény', 'pixiefreak'); ?></h5>
                            <span>$ <?php echo esc_html($tournament->prize_pool); ?> <?php echo esc_html__('USD', 'pixiefreak') ?></span>
                        </li>
						<?php if (!empty($randomRule = json_decode($tournament->random_rule, true))): ?>
                            <li>
                                <h5>
									<?php echo esc_html($key = key($randomRule)); ?>
                                </h5>
                                <span>
                                        <?php echo esc_html($randomRule[$key]); ?>
                                    </span>
                            </li>
						<?php endif; ?>
                    </ul>
                </div>
            </article>
        </div>

        <!-- TEAMS -->
        <div class="teams">
            <!-- Inner page Header -->
            <div class="inner-page-header mb">
                <div class="headline">
                    <h4><?php echo esc_html__('Ismerd meg a versenyzőket', 'pixiefreak'); ?></h4>
                    <span><?php echo esc_html__('ők fognak részt venni ezen a versenyen', 'pixiefreak'); ?></span>
                </div>

            </div>

            <div class="tab-content">
                <div class="team-list active owl-carousel">
					<?php if (!empty($teams = \PixieFreakPanel\Model\TournamentTeam::query()->team($tournament))): ?>
						<?php foreach ($teams as $team): ?>
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
											<?php echo esc_html__('Csapat oldala', 'pixiefreak'); ?> <i class="fas fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
						<?php endforeach; ?>
					<?php endif; ?>
                </div>
            </div>
        </div>
    </div>

	<?php if (count($groups) > 0): ?>
        <div class="standings">
            <div class="section-header col-white center-column">
                <div class="section-title">
                    <h2><?php echo esc_html__('Nézd meg a ranglistát', 'pixiefreak'); ?></h2>
                    <span><?php echo esc_html__('Naprakészek vagyunk a torna összes statisztikájával kapcsolatban', 'pixiefreak'); ?></span>
                </div>
            </div>

            <div class="container">
				<?php if (!empty($groups)): ?>
					<?php foreach ($groups as $group): ?>
                        <ul class="col">

                            <li>
                                <span class="left-side"><?php echo esc_html($group->name); ?></span>
                            </li>

                            <li>
                                <div class="left-side">
                                    <span><?php echo esc_html__('Versenyző', 'pixiefreak'); ?></span>
                                </div>
                                <div class="right-side">
                                    <span><?php echo esc_html__('M', 'pixiefreak'); ?></span>
                                    <span><?php echo esc_html__('NY', 'pixiefreak'); ?></span>
                                    <span><?php echo esc_html__('GY', 'pixiefreak'); ?></span>
                                    <span><?php echo esc_html__('V', 'pixiefreak'); ?></span>
                                    <span><?php echo esc_html__('P', 'pixiefreak'); ?></span>
                                </div>
                            </li>

							<?php
							$groupTeams = \PixieFreakPanel\Model\TournamentGroup::query()->team(\PixieFreakPanel\Model\TournamentGroup::query()->find($group->id));
							?>
							<?php foreach ($groupTeams as $tournamentGroupTeam): ?>
								<?php $team = \PixieFreakPanel\Model\TournamentGroupTeam::query()->team($tournamentGroupTeam); ?>
                                <li>
                                    <a href="<?php echo pixiefreak_route('team', $team->slug); ?>">
                                        <div class="left-side">
                                            <figure>
                                                <img src="<?php echo esc_url($team->team_logo); ?>" alt="<?php echo esc_attr($team->name); ?>">
                                            </figure>
                                            <span>
                                                <?php echo esc_html($team->name); ?>
                                            </span>
                                        </div>

                                        <div class="right-side">
                                            <span><?php echo esc_html((int) $tournamentGroupTeam->win + (int) $tournamentGroupTeam->loss + (int) $tournamentGroupTeam->draw); ?></span>
                                            <span><?php echo esc_html((int) $tournamentGroupTeam->win); ?></span>
                                            <span><?php echo esc_html((int) $tournamentGroupTeam->draw); ?></span>
                                            <span><?php echo esc_html((int) $tournamentGroupTeam->loss); ?></span>
                                            <span><?php echo esc_html((int) $tournamentGroupTeam->point); ?></span>
                                        </div>
                                    </a>
                                </li>
							<?php endforeach; ?>
                        </ul>
					<?php endforeach; ?>
				<?php endif; ?>
            </div>
        </div>
	<?php endif; ?>

	<?php if (!empty(\PixieFreakPanel\Model\Tournament::query()->brackets($tournament))): ?>
        <div class="view-brackets">
            <div class="section-header col-white center-column">
                <div class="section-title">
                    <span><?php echo esc_html__('Szeretnéd megnézni, hogyan zajlik a verseny?', 'pixiefreak'); ?></span>
                    <h2><?php echo esc_html__('A csapatok összecsapásai!', 'pixiefreak'); ?></h2>
                </div>

                <a href="<?php echo pixiefreak_route('bracket', $tournament->slug); ?>" class="btn-default" target="_blank">
					<?php echo esc_html__('Ágrajz megtekintése', 'pixiefreak'); ?>
                </a>
            </div>
        </div>
	<?php endif; ?>

	<?php
	global $wpdb;

	$groupedMatches = \PixieFreakPanel\Model\Match::query()
	                                              ->raw("SELECT YEAR(start_date) as stYear, MONTH(start_date) as stMonth, DAY(start_date) as stDay, id
        FROM `{$wpdb->prefix}pixiefreak_match`
        WHERE `tournament_id`='{$tournament->id}'
        GROUP BY stYear, stMonth, stDay, id");
	?>

	<?php if (count($groupedMatches) > 0): ?>
        <div class="match-schedule">
            <div class="container">
                <div class="section-header">
                    <div class="section-title">
                        <span><?php echo esc_html__('Nézd meg a verseny', 'pixiefreak'); ?></span>
                        <h2><?php echo esc_html__('menetrendjét', 'pixiefreak'); ?></h2>
                    </div>

                    <ul class="tab-nav">
                        <li>
                            <a class="btn-default previous-day">
                                <i class="fas fa-angle-left"></i>
								<?php echo esc_html__('Előző Nap', 'pixiefreak'); ?>
                            </a>
                        </li>

                        <li>
                            <a class="btn-default next-day">
								<?php echo esc_html__('Következő Nap', 'pixiefreak'); ?>
                                <i class="fas fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="wrapper">
                    <ul class="daybanners">
						<?php $oldDate = 0; foreach ($groupedMatches as $key => $tmpObj): ?>
							<?php
							$date = $tmpObj['stYear'] . $tmpObj['stMonth'] . $tmpObj['stDay'];
							if($oldDate == $date) {
								continue;
							} else {
								$oldDate = $date;
							}
							?>
							<?php $match = \PixieFreakPanel\Model\Match::query()->find($tmpObj->id);?>
                            <li class="<?php echo reset($groupedMatches) === $tmpObj ? 'active': ''; ?>" data-selector="<?php echo esc_attr(date('d-m-y', strtotime($match->start_date))); ?>">
                                <a href="#<?php echo esc_attr(date('d-m-y', strtotime($match->start_date))); ?>" data-toggle="tab" class="active">
                                        <span class="day">
                                            <?php echo trim(
	                                            esc_html(date_i18n('l', strtotime($match->start_date))) .' &bull; ' .
	                                            esc_html__('Day', 'pixiefreak') .' '.
	                                            esc_html($key + 1)) ?>
                                        </span>
                                    <span class="date">
                                            <?php echo esc_html(date_i18n('d M Y', strtotime($match->start_date))); ?>
                                        </span>
                                </a>
                            </li>
						<?php endforeach; ?>
                    </ul>

                    <div class="tab-content">
						<?php $oldDate = 0; foreach ($groupedMatches as $tmpObj): ?>
							<?php
							$date = $tmpObj['stYear'] . $tmpObj['stMonth'] . $tmpObj['stDay'];
							if($oldDate == $date) {
								continue;
							} else {
								$oldDate = $date;
							}
							?>
							<?php $match = \PixieFreakPanel\Model\Match::query()->find($tmpObj->id);?>
                            <div id="<?php echo esc_attr(date_i18n('d-m-y', strtotime($match->start_date))); ?>"
                                 class="standing-box<?php echo reset($groupedMatches) === $tmpObj ? ' active': ''; ?>">
								<?php $matches = \PixieFreakPanel\Model\Match::query()->where('start_date', 'LIKE', date('Y-m-d', strtotime($match->start_date)).'%')->get(); ?>
								<?php foreach ($matches as $match): ?>
									<?php
									$teamA = \PixieFreakPanel\Model\Team::query()->find($match->team_a_id);
									$teamB = \PixieFreakPanel\Model\Team::query()->find($match->team_b_id);
									?>
                                    <a href="<?php echo pixiefreak_route('match', $match->slug); ?>" class="match-details">
                                        <div class="match-teams">
                                            <div class="team-info">
                                                <figure>
                                                    <img src="<?php echo esc_url($teamA->team_logo); ?>" alt="<?php echo esc_attr($teamA->name); ?>">
                                                </figure>
                                                <span><?php echo esc_html($teamA->name); ?></span>
                                            </div>

                                            <div class="vs">
	                                            <?php if ($match->status == array_flip(\PixieFreakPanel\Model\Match::STATUSES)['Upcoming']): ?>
		                                            <?php echo esc_html__('VS', 'pixiefreak'); ?>
	                                            <?php else: ?>
		                                            <?php echo esc_html($match->team_a_result . ':' . $match->team_b_result); ?>
	                                            <?php endif; ?>
                                            </div>

                                            <div class="team-info">
                                                <figure>
                                                    <img src="<?php echo esc_url($teamB->team_logo); ?>" alt="<?php echo esc_attr($teamB->name); ?>">
                                                </figure>
                                                <span><?php echo esc_html($teamB->name); ?></span>
                                            </div>
                                        </div>

                                        <div class="match-info">
                                                <span>
                                                    <i class="fas fa-clock"></i>
	                                                <?php echo esc_html__('Kezdődik:', 'pixiefreak'); ?>
	                                                <?php echo esc_html(date_i18n('h:i A', strtotime($match->start_date))); ?>
                                                </span>
                                        </div>
                                    </a>
								<?php endforeach; ?>
                            </div>
						<?php endforeach; ?>
                    </div>
                </div>
            </div>
        </div>
	<?php endif; ?>

	<?php if (count($matches = \PixieFreakPanel\Model\Match::query()->where('tournament_id', $tournament->id)->orderBy('start_date', 'desc')->get()) > 0): ?>
        <div class="matches page-bg">
            <div class="container">
                <div class="inner-page-header">
                    <div class="headline">
                        <h4><?php echo esc_html__('A tornával kapcsolatos mérkőzések', 'pixiefreak'); ?></h4>
                        <span><?php echo esc_html__('ezeket is érdemes megtekintened', 'pixiefreak'); ?></span>
                    </div>
                </div>

                <div class="tab-content">
                    <div class="scrollbar-outer">
                        <ul class="match-list active">
							<?php foreach ($matches as $match): ?>
                                <li class="match-box">
                                    <div class="box-title">
										<?php $tournament = \PixieFreakPanel\Model\Tournament::query()->find($match->tournament_id); ?>
										<?php if (count($tournament) > 0): ?>
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
                                                <img src="<?php echo esc_url($teamA->team_logo); ?>" alt="<?php echo esc_attr($teamA->name); ?>">
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
                    </div>
                </div>
            </div>
        </div>
	<?php endif; ?>

	<?php
	$original_query = $wp_query;
	$wp_query = null;
	$args = array('posts_per_page'=> 4, 'tag' => $tournament->slug);
	$wp_query = new WP_Query( $args );
	if ($wp_query->have_posts()):
		?>
        <section class="news">
            <div class="container">

                <div class="section-header col-white">
                    <div class="section-title">
                        <h2><?php echo esc_html__('Hírek a versenyről', 'pixiefreak'); ?></h2>
                        <span><?php echo esc_html__('Hasonló hírek', 'pixiefreak'); ?></span>
                    </div>
                </div>

                <div class="news-grid">
					<?php
					while ($wp_query->have_posts()) : $wp_query->the_post();
						?>
                        <article onclick="window.location='<?php echo esc_url(get_permalink()); ?>'"
                                 style="background-image: url('<?php echo esc_url(get_the_post_thumbnail_url()); ?>');">
                            <div class="overlay">
								<?php
								$post_categories = wp_get_post_categories(get_the_ID());
								$cats = array(); $i=0;
								foreach ($post_categories as $c) { $i++;
									if ($i > 1): continue; endif;
									$cat = get_category($c);
									$cats[] = array('name' => $cat->name, 'slug' => $cat->slug);
								}
								?>
								<?php foreach ($cats as $category): ?>
                                    <a class="category">
										<?php echo esc_html($category['name']); ?>
                                    </a>
								<?php endforeach; ?>

                                <h3>
                                    <a href="<?php echo esc_url(get_permalink()); ?>">
										<?php echo esc_html(get_the_title($post)); ?>
                                    </a>
                                </h3>

                                <div class="details">
                                <span class="date">
                                    <?php echo esc_html(get_the_date()); ?>
                                </span>
									<?php if (is_sticky($post->ID)): ?>
                                        <span class="sticky">
                                        <i class="fa fa-map-pin"></i> <?php echo esc_html__('Sticky', 'pixiefreak'); ?>
                                    </span>
									<?php endif; ?>
                                </div>
                            </div>
                        </article>
					<?php
					endwhile;
					$wp_query = null;
					$wp_query = $original_query;
					wp_reset_postdata();
					?>
                </div>
            </div>
        </section>
	<?php endif; ?>

</section>
<?php get_footer(); ?>

<?php /* Template Name: Match */ ?>
<?php
    $slug = esc_attr(get_query_var('match_slug'));
    if (empty($match = \PixieFreakPanel\Model\Match::query()->where('slug', $slug)->get()->first())) {
        wp_redirect(get_home_url()); die();
    }

    $game = \PixieFreakPanel\Model\Game::query()->find($match->game_id);

    $settings = pixiefreak_settings('match');
    $headerBackground = $settings->get('banner_image')
?>

    <?php get_header(); ?>

    <section class="match-page">
        <div class="container">
            <div class="featured-box" style="background-image: url('<?php echo esc_url($game->cover); ?>');">
                <div class="match-box">
                    <div class="box-title">
                        <figure>
                            <img src="<?php echo esc_url($game->thumbnail); ?>" alt="<?php echo esc_attr($game->name); ?>">
                        </figure>
                        <?php $tournament = \PixieFreakPanel\Model\Tournament::query()->find($match->tournament_id); ?>
                        <?php if (count($tournament) > 0): ?>
                            <span>
                                <?php echo esc_html($tournament->name); ?>
                            </span>
                            <span class="date">
                                <?php echo esc_html(date_i18n('d M Y h:i A', strtotime($match->start_date))); ?>
                                <?php if (!empty($match->stream_id) && !empty($stream = \PixieFreakPanel\Model\Stream::query()->find($match->stream_id))): ?>
                                    <a href="<?php echo pixiefreak_route('stream', $stream->slug); ?>" target="_blank">
                                        <?php echo esc_html__('Élő közvetítés', 'pixiefreak'); ?>
                                        <i class="fas fa-play"></i>
                                    </a>
                                <?php endif; ?>
                            </span>
                        <?php else: ?>
                            <span>
                                <?php echo esc_html__('Exibition', 'pixiefreak'); ?>
                            </span>
                            <span class="date">
                                <?php echo esc_html(date_i18n('d M Y h:i A', strtotime($match->start_date))); ?>
                                <?php if (!empty($match->stream_id) && !empty($stream = \PixieFreakPanel\Model\Stream::query()->find($match->stream_id))): ?>
                                    <a href="<?php echo pixiefreak_route('stream', $stream->slug); ?>" target="_blank">
                                        <?php echo esc_html__('Stream', 'pixiefreak'); ?>
                                        <i class="fas fa-play"></i>
                                    </a>
                                <?php endif; ?>
                            </span>
                        <?php endif; ?>
                    </div>

                    <?php
                        $ATeam = \PixieFreakPanel\Model\Team::query()->find($match->team_a_id);
                        $BTeam = \PixieFreakPanel\Model\Team::query()->find($match->team_b_id);
                    ?>

                    <div class="match-details">
                        <div class="team-box">
                            <a href="<?php echo pixiefreak_route('team', $ATeam->slug); ?>">
                                <img src="<?php echo esc_url($ATeam->team_logo); ?>" alt="<?php echo esc_attr($ATeam->name) ?>">
                            </a>

                            <div class="team-details">
                                <div class="team-name">
                                    <span><?php echo esc_html($ATeam->name); ?></span>
                                </div>

                                <?php if (!empty($players = \PixieFreakPanel\Model\Team::query()->player($ATeam))): ?>
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

                        <div class="team-box">
                            <a href="<?php echo pixiefreak_route('team', $BTeam->slug); ?>">
                                <img src="<?php echo esc_url($BTeam->team_logo); ?>" alt="<?php echo esc_attr($BTeam->name); ?>">
                            </a>

                            <div class="team-details">
                                <div class="team-name">
                                    <span><?php echo esc_html($BTeam->name); ?></span>
                                </div>

                                <?php if (!empty($players = \PixieFreakPanel\Model\Team::query()->player($BTeam))): ?>
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
                    </div>

                    <ul class="box-footer">
                        <li>
                            <span>
                                <?php if ($match->type == 0): ?>
                                    <?php echo esc_html__('Offline', 'pixiefreak'); ?>
                                <?php else: ?>
                                    <?php echo esc_html__('Online', 'pixiefreak'); ?>
                                <?php endif; ?>
                            </span>
                        </li>

                        <li>
                            <ul>
                                <li>
                                    <a href="<?php echo esc_url('https://www.facebook.com/share.php?u=' . get_permalink() . $match->slug); ?>"
                                       target="_blank"><i class="fab fa-facebook-f"></i></a>
                                </li>

                                <li>
                                    <a href="<?php echo esc_url('http://twitter.com/share?text='.$match->slug.'&url='.get_permalink() . $match->slug); ?>"
                                       target="_blank"><i class="fab fa-twitter"></i></a>
                                </li>

                                <li>
                                    <a href="" class="copy-btn" data-url="<?php echo esc_url(get_permalink() . $match->slug); ?>"
                                       target="_blank"><i class="far fa-copy"></i></a>
                                </li>
                            </ul>
                        </li>

                        <?php if (!empty($match->cta_match_text)): ?>
                            <li>
                                <a href="<?php echo esc_url($match->cta_match_link); ?>" target="_blank">
                                    <?php echo esc_html($match->cta_match_text); ?>
                                    <i class="fas fa-external-link-square-alt"></i>
                                </a>
                            </li>
                        <?php endif; ?>
                    </ul>
                </div>
            </div>

            <div class="inner-page-header">
                <div class="headline">
                    <h4><?php echo esc_html__('Nézd meg a mérkőzéseket', 'pixiefreak'); ?></h4>
                    <span><?php echo esc_html__('válassz ki egy csapatot', 'pixiefreak'); ?></span>
                </div>

                <ul class="tab-nav">
                    <li class="active">
                        <a href="#team-a-s" data-toggle="tab" class="btn-default">
		                    <?php echo esc_html($match['team_a_name']) ?>
                        </a>
                    </li>
                    <li>
                        <a href="#team-b-s" data-toggle="tab" class="btn-default">
	                        <?php echo esc_html($match['team_b_name']) ?>
                        </a>
                    </li>
                </ul>
            </div>

            <?php
                $teamAMatches = \PixieFreakPanel\Model\Match::query()->where('team_a_id', $ATeam->id)->orWhere('team_b_id', $ATeam->id)->limit(5)->get();
                $teamBMatches = \PixieFreakPanel\Model\Match::query()->where('team_b_id', $BTeam->id)->orWhere('team_a_id', $BTeam->id)->limit(5)->get();
            ?>
            <?php if (!empty($teamAMatches) || !empty($teamBMatches)): ?>
                <div class="tab-content">
                    <?php if (!empty($teamAMatches)): ?>
                        <ul id="team-a-s" class="match-list active">
                            <?php foreach ($teamAMatches as $teamAMatch): ?>
                            <?php if ($teamAMatch->id === $match->id): continue; endif; ?>
                                <li class="match-box">
                                    <div class="box-title">
                                        <?php $tournament = \PixieFreakPanel\Model\Tournament::query()->find($teamAMatch->tournament_id); ?>
                                        <?php if (count($tournament) > 0): ?>
                                            <span>
                                                <?php echo esc_html($tournament->name); ?>
                                            </span>
                                            <span class="date">
                                                <?php echo esc_html(date_i18n('d M Y h:i A', strtotime($teamAMatch->start_date))); ?>
                                                <a href="<?php echo pixiefreak_route('match', $teamAMatch->slug); ?>">
                                                    <?php echo esc_html__('Megnézem', 'pixiefreak'); ?>
                                                    <i class="fas fa-play"></i>
                                                </a>
                                            </span>
                                        <?php endif; ?>
                                    </div>

                                    <div class="match-details">
                                        <?php
                                        $teamA = \PixieFreakPanel\Model\Team::query()->find($teamAMatch->team_a_id);
                                        $teamB = \PixieFreakPanel\Model\Team::query()->find($teamAMatch->team_b_id);
                                        ?>
                                        <div class="team-box">
                                            <a href="<?php echo pixiefreak_route('team', $teamA->slug); ?>">
                                                <img src="<?php echo esc_url($teamA->team_logo); ?>" alt="<?php echo esc_attr($ATeam->name); ?>">
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
                                                <?php if ($teamAMatch->status == array_flip(\PixieFreakPanel\Model\Match::STATUSES)['Upcoming']): ?>
                                                    <?php echo esc_html__('VS', 'pixiefreak'); ?>
                                                <?php else: ?>
                                                    <?php echo esc_html($teamAMatch->team_a_result . ':' . $teamAMatch->team_b_result); ?>
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

                                    <span class="game-name"><?php echo esc_html(\PixieFreakPanel\Model\Game::query()->find($teamAMatch->game_id)->name); ?></span>
                                </li>
                            <?php endforeach; ?>
                        </ul>
                    <?php endif; ?>

                    <?php if (!empty($teamBMatches)): ?>
                        <ul id="team-b-s" class="match-list">
                            <?php foreach ($teamBMatches as $teamBMatch): ?>
                                <?php if ($teamBMatch->id === $match->id): continue; endif; ?>
                                <li class="match-box">
                                    <div class="box-title">
			                            <?php $tournament = \PixieFreakPanel\Model\Tournament::query()->find($teamAMatch->tournament_id); ?>
			                            <?php if (count($tournament) > 0): ?>
                                            <span>
                                                <?php echo esc_html($tournament->name); ?>
                                            </span>
                                            <span class="date">
                                                <?php echo esc_html(date_i18n('d M Y h:i A', strtotime($teamAMatch->start_date))); ?>
                                                <a href="<?php echo pixiefreak_route('match', $teamAMatch->slug); ?>">
                                                    <?php echo esc_html__('Megnézem', 'pixiefreak'); ?>
                                                    <i class="fas fa-play"></i>
                                                </a>
                                            </span>
			                            <?php endif; ?>
                                    </div>

                                    <div class="match-details">
			                            <?php
			                            $teamA = \PixieFreakPanel\Model\Team::query()->find($teamAMatch->team_a_id);
			                            $teamB = \PixieFreakPanel\Model\Team::query()->find($teamAMatch->team_b_id);
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
                                                <?php if ($teamAMatch->status == array_flip(\PixieFreakPanel\Model\Match::STATUSES)['Upcoming']): ?>
	                                                <?php echo esc_html__('VS', 'pixiefreak'); ?>
                                                <?php else: ?>
	                                                <?php echo esc_html($teamAMatch->team_a_result . ':' . $teamAMatch->team_b_result); ?>
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

                                    <span class="game-name"><?php echo esc_html(\PixieFreakPanel\Model\Game::query()->find($teamAMatch->game_id)->name); ?></span>
                                </li>
                            <?php endforeach; ?>
                        </ul>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>
    </section>

<?php get_footer(); ?>

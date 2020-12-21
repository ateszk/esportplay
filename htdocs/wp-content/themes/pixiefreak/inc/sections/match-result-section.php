<?php if (count(\PixieFreakPanel\Model\Match::query()->limit(4)->get()) > 0):?>
    <section class="matches">
        <div class="container">
            <div class="section-header center-column col-white">
                <div class="section-title">
                    <h2><?php echo esc_html__('MÉRKŐZÉSEK & EREDMÉNYEK', 'pixiefreak'); ?></h2>
                    <span><?php echo esc_html__('Ez a magyar csapatok által jelenleg lejátszott mérkőzések élő frissítése', 'pixiefreak'); ?></span>
                </div>
            </div>

            <ul class="tab-nav">
	            <?php foreach ($statuses = \PixieFreakPanel\Model\Match::STATUSES as $key => $status): ?>
                    <li class="<?php echo reset($statuses) === $status ? 'active' : ''; ?>">
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

            <div class="tab-content">
                <?php foreach ($statuses as $key => $status): ?>
                    <ul class="match-list<?php echo reset($statuses) === $status ? ' active' : ''; ?>" id="<?php echo esc_attr(strtolower($status) .'-match'); ?>">
	                    <?php
	                    $matches = \PixieFreakPanel\Model\Match::query()->where('status', $key);
	                    if ($status == 'Finished') {
		                    $matches = $matches->orderBy('start_date', 'desc');
	                    }
	                    ?>
		                <?php foreach ($matches->limit(4)->get() as $match): ?>
                        <?php if ($match->status != $key): continue; endif;?>
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
                                                <?php echo esc_html__('Megnézem', 'pixiefreak'); ?> <i class="fas fa-play"></i>
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

            <div class="section-footer mt">
                <div>
                    <h4><?php echo esc_html__('Ha több mérkőzést szeretnél látni', 'pixiefreak'); ?></h4>
                    <span><?php echo esc_html__('Látogass el egy speciális részre, hogy megtekinthesd mindet', 'pixiefreak'); ?></span>
                </div>
                <a href="<?php echo esc_url(get_home_url(null, 'matches/')); ?>" class="btn-default">
                    <?php echo esc_html__('Összes mérkőzés', 'pixiefreak'); ?>
                </a>
            </div>
        </div>
    </section>
<?php endif; ?>
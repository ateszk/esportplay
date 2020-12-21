<?php
$games = \PixieFreakPanel\Model\Game::query()->get();
$teams = \PixieFreakPanel\Model\Team::query()->where('my_team', 1)->limit(3)->get();
?>

<?php if (count($teams) > 0): ?>
    <section class="teams">
        <div class="container">
            <div class="section-header center-column col-white">
                <div class="section-title normal">
                    <h2><?php echo esc_html__('Csapatok', 'pixiefreak'); ?></h2>
                    <span><?php echo esc_html__('Ismerd meg a magyar csapatokat!', 'pixiefreak'); ?></span>
                </div>
            </div>

            <ul class="tab-nav">
            <?php $i = 0; foreach ($games as $game): ?>
                <?php if (\PixieFreakPanel\Model\Team::query()->where('game_id', (int) $game->id)->get()->count() <= 0): continue; endif; $i++; ?>
                <?php $activeClass = ($i == 1) ? 'active': ''; ?>
                <li class="<?php echo esc_attr($activeClass); ?>">
                    <a data-toggle="tab" href="#gamefilter-<?php echo esc_attr($game->id); ?>">
                        <img src="<?php echo esc_url($game->thumbnail); ?>" alt="<?php echo esc_attr($game->name) ?>">
                    </a>
                </li>
            <?php endforeach; ?>
            </ul>

            <div class="tab-content">
                <?php $i = 0; foreach ($games as $game): ?>
	                <?php if (\PixieFreakPanel\Model\Team::query()->where('game_id', (int) $game->id)->get()->count() <= 0): continue; endif; $i++; ?>
	                <?php $activeClass = ($i == 1) ? ' active': '';?>
                    <div id="gamefilter-<?php echo esc_attr($game->id); ?>" class="team-list<?php echo esc_attr($activeClass); ?>">
                    <?php foreach( \PixieFreakPanel\Model\Team::query()->where('game_id', $game->id)->where('my_team', 1)->limit(3)->get() as $team): ?>
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
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
<?php endif; ?>
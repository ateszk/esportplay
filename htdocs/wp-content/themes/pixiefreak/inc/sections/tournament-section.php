<?php $tournaments = \PixieFreakPanel\Model\Tournament::query()->get(); ?>

<?php if (count($tournaments) > 0): ?>
    <section class="tournaments">
        <div class="container">
            <div class="section-header border-bottom">
                <div class="section-title">
                    <h2><?php echo esc_html__('Versenyek', 'pixiefreak'); ?></h2>
                </div>

                <ul>
					<?php $activeStatus = ''; foreach ($statuses = \PixieFreakPanel\Model\Tournament::STATUSES as $key => $status): ?>
						<?php
						if (empty($activeStatus) && !empty(\PixieFreakPanel\Model\Tournament::query()->where('status', $key)->get()->first())) {
                            $activeStatus = $status;
						}
						?>
                        <li <?php echo $activeStatus == $status ? 'class="active"' : ''; ?> >
                            <a href="#<?php echo esc_attr(strtolower($status) .'-tournament'); ?>" data-toggle="tab">
								<?php if ($status == 'Upcoming'): ?>
									<?php echo esc_html__('Következik', 'pixiefreak'); ?>
								<?php elseif($status == 'Finished'): ?>
									<?php echo esc_html__('Befejezett', 'pixiefreak'); ?>
								<?php else: ?>
									<?php echo esc_html__('Elindult', 'pixiefreak'); ?>
								<?php endif; ?>
                            </a>
                        </li>
					<?php endforeach; ?>
                </ul>
            </div>

            <div class="tab-content">
				<?php foreach ($statuses as $key => $status):  ?>
                    <ul id="<?php echo esc_attr(strtolower($status) .'-tournament'); ?>"
                        class="tournament-list<?php echo $activeStatus == $status ? ' active' : ''; ?>">
						<?php foreach ($tournaments as $tournament): ?>
							<?php if ($tournament->status != strtolower($key)): continue; endif; ?>
                            <li class="tournament-box" style="background-image: url('<?php echo esc_html($tournament->thumbnail) ?>')">

                                <!-- Details about Tournament-->
                                <div class="tournament-body">

                                    <!-- Tournament Name -->
                                    <a href="<?php echo pixiefreak_route('tournament', $tournament->slug); ?>"
                                       class="tournament-name">
										<?php echo esc_attr($tournament->name); ?>
                                    </a>


                                    <!-- Tournament Date -->
                                    <span class="date"><?php echo date_i18n('M.d.Y - h:i A', strtotime($tournament->start_date)); ?></span>

                                    <!-- Game Logo -->
                                    <figure>
										<?php $game = \PixieFreakPanel\Model\Tournament::query()->game($tournament); ?>
                                        <img src="<?php echo esc_url($game->thumbnail); ?>" alt="<?php echo esc_attr($game->name); ?>">
                                    </figure>
                                </div>

                                <div class="tournament-footer">
                                    <div class="col">
										<?php $groups = \PixieFreakPanel\Model\TournamentGroup::query()->where('tournament_id', $tournament->id)->get(); ?>
                                        <div class="col-item">
                                            <h5><?php echo esc_html($groups->count()); ?> <?php echo esc_html__('Csoport', 'pixiefreak'); ?></h5>
                                            <p><?php echo esc_html($tournament->team_number); ?> <?php echo esc_html__('Csapatok', 'pixiefreak'); ?></p>
                                        </div>
										<?php if (!empty($randomRule = json_decode($tournament->random_rule, true))): ?>
                                            <div class="col-item">
                                                <h5><?php echo esc_html($randomRuleKey = key($randomRule)); ?></h5>
                                                <p><?php echo esc_html($randomRule[$randomRuleKey]); ?></p>
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
				<?php endforeach; ?>
            </div>
        </div>
    </section>
<?php endif; ?>
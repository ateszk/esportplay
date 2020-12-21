<?php /* Template Name: About */ ?>
<?php
if(!pixiefreak_active()) {
	wp_redirect(get_home_url()); die();
}
$about = \PixieFreakPanel\Model\About::query()->get()->first();
$aboutStaff = \PixieFreakPanel\Model\AboutStaff::query()->get();
$aboutStaffCategory = \PixieFreakPanel\Model\AboutStaffCategory::query()->get();
$settings = pixiefreak_settings('about');

$headerBackground = $about->cover;
?>
<?php get_header(); ?>

    <section class="inner-page">
        <div class="container">
            <div class="inner-header" style="background-image: url('<?php echo esc_url($about->banner) ; ?>');"></div>

            <div class="inner-body">
                <article class="top">
                    <div class="col left">
                        <h3><?php echo esc_html($settings->get('who_we_are')); ?></h3>
                        <p><?php echo esc_html($settings->get('some_more')); ?></p>
                    </div>

					<?php
					$shouldShowMediaKit = $settings->get('media_kit.show');
					$shouldShowAllTeams = $settings->get('all_teams.show');
					?>

					<?php if ($shouldShowMediaKit || $shouldShowAllTeams): ?>
                        <div class="col right">
							<?php if ($shouldShowMediaKit): ?>
                                <a href="<?php echo esc_url($settings->get('media_kit.link')); ?>" class="btn btn-primary about-btn">
									<?php echo esc_html($settings->get('media_kit.text')); ?>
                                </a>
							<?php endif; ?>
							<?php if ($shouldShowAllTeams): ?>
                                <a href="<?php echo esc_url($settings->get('all_teams.link')); ?>" class="btn btn-black about-btn">
									<?php echo esc_html($settings->get('all_teams.text')); ?>
                                </a>
							<?php endif; ?>
                        </div>
					<?php endif; ?>
                </article>

                <article class="bottom">
                    <div class="col left textarea">
						<?php if (!empty($about->description)): ?>
                            <div class="scrollbar-outer">
                                <p>
									<?php echo nl2br(wp_specialchars_decode($about->description)); ?>
                                </p>
                            </div>
						<?php endif; ?>
                    </div>
                    <div class="col right">
						<?php if (!empty($statistics = json_decode($about->stats, true))): ?>
                            <ul class="stats">
								<?php foreach ($statistics as $statistic): ?>
									<?php if (!empty($statistic['title'])): ?>
                                        <li>
                                            <i class="icon" style="background-image: url('<?php echo esc_html($statistic['icon']); ?>');"></i>
                                            <h5>
												<?php echo esc_html($statistic['label']); ?>
                                            </h5>
                                            <span>
                                                <?php echo esc_html($statistic['title']); ?>
                                            </span>
                                        </li>
									<?php endif; ?>
								<?php endforeach; ?>
                            </ul>
						<?php endif; ?>
                    </div>
                </article>
            </div>

            <div class="about-staff">
                <div class="section-header center-column col-white">
                    <div class="section-title">
                        <h2><?php echo esc_html__('Ismerd meg a csapatunkat', 'pixiefreak'); ?></h2>
                    </div>

					<?php if ($aboutStaffCategory->isNotEmpty()): ?>
                        <ul class="menu-list">
							<?php $i=0; foreach ($aboutStaffCategory as $category): $i++;?>
								<?php if ($i > 4): continue; endif; ?>
                                <li<?php echo reset($aboutStaffCategory) === $category ? ' class="active"' : ''; ?>>
                                    <a href="#stca<?php echo esc_attr($category->id); ?>" data-toggle="tab"><?php echo esc_html($category->name); ?></a>
                                </li>
							<?php endforeach; ?>
							<?php if (count($aboutStaffCategory) > 4): ?>
                                <li class="menu-item-has-children">
                                    <a href="javascript:;">
										<?php esc_html_e('Több', 'pixiefreak'); ?>
                                        <i class="fas fa-angle-down"></i>
                                    </a>
                                    <ul class="sub-menu">
										<?php foreach ($aboutStaffCategory as $key => $category): ?>
											<?php if (!in_array($key, range(0, 5))): ?>
                                                <li>
                                                    <a href="#stca<?php echo esc_attr($category->id); ?>" data-toggle="tab"><?php echo esc_html($category->name); ?></a>
                                                </li>
											<?php endif; ?>
										<?php endforeach; ?>
                                    </ul>
                                </li>
							<?php endif; ?>
                        </ul>
					<?php endif; ?>
                </div>

                <div class="tab-content">
					<?php if ($aboutStaffCategory->isNotEmpty()): ?>
						<?php $i=0; foreach ($aboutStaffCategory as $category): $i++;?>
							<?php $activeClass = ($i === 1) ? 'active' : ''; ?>
                            <ul class="card-list <?php echo esc_attr($activeClass); ?>" id="stca<?php echo esc_attr($category->id); ?>">
								<?php foreach ($aboutStaff as $staffMember): ?>
									<?php if ($staffMember->staff_category_id === $category->id): ?>
                                        <li class="card">
											<?php if (!empty($staffMember->avatar)): ?>
                                                <figure>
                                                    <img src="<?php echo esc_url($staffMember->avatar); ?>" alt="<?php echo esc_attr($staffMember->name); ?>">
                                                </figure>
											<?php endif; ?>
                                            <div class="card-info">
                                                <h4 class="title"><?php echo esc_html($staffMember->name); ?></h4>
                                                <span class="subtitle"><?php echo esc_html($staffMember->role); ?></span>
                                                <a href="mailto:<?php echo esc_html($staffMember->label); ?>"><span class="label"><?php echo esc_html($staffMember->label); ?></span></a>

												<?php if (!empty($socials = json_decode($staffMember->socials, true))): ?>
                                                    <ul class="social">
														<?php foreach ($socials as $key => $url): ?>
															<?php if (!empty(preg_match('/\S/', $url))): ?>
                                                                <li>
                                                                    <a href="<?php echo esc_url($url); ?>"
                                                                       target="_blank">
                                                                        <i class="fab fa-<?php echo esc_attr($key); ?>"></i>
                                                                    </a>
                                                                </li>
															<?php endif; ?>
														<?php endforeach; ?>
                                                    </ul>
												<?php endif; ?>
                                            </div>
                                        </li>
									<?php endif; ?>
								<?php endforeach; ?>
                            </ul>
						<?php endforeach; ?>
					<?php endif; ?>
                </div>
            </div>
        </div>
    </section>
    </section>

<?php get_footer(); ?>
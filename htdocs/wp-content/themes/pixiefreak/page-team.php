<?php /* Template Name: Team */ ?>
<?php
    if(!pixiefreak_active()) {
        wp_redirect(get_home_url()); die();
    }
    $slug = esc_attr(get_query_var('team_slug'));
    $settings = pixiefreak_settings('team');
    if (empty($team = \PixieFreakPanel\Model\Team::query()->where('slug', $slug)->get()->first())) {
        wp_redirect(get_home_url()); die();
    }

    $country = \PixieFreakPanel\Model\Countries::findAll($team->country);
    $headerBackground = $team->cover;
    $pageTagLine = $team->name;
?>

    <?php get_header(); ?>


    <section class="inner-page">
        <div class="container">
            <div class="inner-header" style="background-image: url('<?php echo esc_url($team->thumbnail); ?>');"></div>

            <div class="inner-body">
                <article class="top">
                    <div class="col left about">
                        <figure>
                            <img class="img-logo" src="<?php echo esc_url(\PixieFreakPanel\Model\Game::query()->find($team->game_id)->thumbnail); ?>" alt="<?php echo esc_attr($team->name); ?>">
                        </figure>
                        <div class="details">
                            <h4>
                                <?php echo esc_html($team->name); ?>
                                <i class="flag flag-<?php echo esc_attr(strtolower($country['code'])) ?>"></i>
                            </h4>
                            <p>
                                <?php echo esc_html__('Alakult', 'pixiefreak'); ?> <?php echo esc_html(date_i18n("d M  Y", strtotime($team->year_founded))); ?>
                            </p>
                        </div>
                    </div>

                    <div class="col right">
	                    <?php if (!empty($statistics = json_decode($team->stats))): ?>
                            <ul class="info-list">
			                    <?php foreach ($statistics as $key => $value): ?>
                                    <li>
                                        <span class="title"><?php echo esc_html($value); ?></span>
                                        <span class="subtitle">
                                            <?php if ($key == 'win'): ?>
                                                <?php esc_html_e('Nyereségek', 'pixiefreak') ?>
                                            <?php elseif($key == 'loses'): ?>
	                                            <?php esc_html_e('Vereségek', 'pixiefreak') ?>
                                            <?php else: ?>
	                                            <?php esc_html_e('Döntetlenek', 'pixiefreak') ?>
                                            <?php endif; ?>
                                        </span>
                                    </li>
			                    <?php endforeach; ?>
                            </ul>
	                    <?php endif; ?>
                    </div>
                </article>

                <article class="bottom">
                    <div class="col left textarea">
                        <div class="text-head">
                            <h4><?php echo esc_html__('A csapatról', 'pixiefreak'); ?></h4>

	                        <?php if (!empty($socials = json_decode($team->social, true))): ?>
                                <ul>
			                        <?php foreach ($socials as $socialName => $url): ?>
                                        <?php if (empty($url)) continue; ?>

				                        <?php if (!empty(preg_replace('/\s+/', '', $url))): ?>

                                            <li>
                                                <a href="<?php echo esc_url($url); ?>"
                                                   target="_blank">
                                                    <i class="fab fa-<?php echo esc_attr($socialName); ?>"></i>
                                                </a>
                                            </li>

				                        <?php endif; ?>

			                        <?php endforeach; ?>
                                </ul>
	                        <?php endif; ?>
                        </div>

                        <?php if (!empty($team->about)): ?>
                        <p>
	                        <?php echo nl2br(wp_specialchars_decode($team->about)); ?>
                        </p>
                        <?php endif; ?>
                    </div>
                    <div class="col right team-pg">
	                    <?php if (!empty($achievements = \PixieFreakPanel\Model\Team::query()->achievement($team))): ?>
                            <div class="achievements owl-carousel">
			                    <?php foreach ($achievements as $achievement): ?>
                                    <a target="_blank">
                                        <img src="<?php echo esc_url($achievement->thumbnail); ?>" alt="<?php echo esc_attr($achievement->name); ?>">
                                    </a>
			                    <?php endforeach; ?>
                            </div>
	                    <?php endif; ?>
                    </div>
                </article>
            </div>

            <div class="team-roster">
                <div class="section-header center-column col-white">
                    <div class="section-title">
                        <h2><?php echo esc_html($settings->get('roster_title')); ?></h2>
                        <span><?php echo esc_html($settings->get('roster_subtitle')); ?></span>
                    </div>

                    <?php if ($settings->get('cta.show')): ?>
                    <div class="actions">
                        <a href="<?php echo esc_url($settings->get('cta.link')); ?>" class="btn btn-default">
		                    <?php echo esc_html($settings->get('cta.text')); ?>
                        </a>
                    </div>
                    <?php endif; ?>
                </div>

                <div class="tab-content">
                    <ul class="card-list secondary-list active" id="Journalists">
                        <?php if (!empty($players = \PixieFreakPanel\Model\Team::query()->player($team))): ?>
                            <ul class="card-list active">
		                        <?php foreach ($players as $player): ?>

                                    <li class="card">
                                        <figure>
                                            <img src="<?php echo esc_url($player->avatar_transparent); ?>" alt="<?php echo esc_attr($player->nickname); ?>">
                                        </figure>
                                        <div class="card-info">
                                            <span class="label black text-uppercase"><?php echo esc_html($player->role); ?></span>
                                            <h4 class="title"><?php echo esc_html(ucfirst($player->first_name) .' '. ucfirst($player->last_name)); ?></h4>
                                            <span class="subtitle"><?php echo esc_html($player->nickname); ?></span>

                                            <a href="<?php echo pixiefreak_route('player', $player->slug); ?>" class="btn btn-default"><?php echo esc_html__('Profil', 'pixiefreak'); ?></a>
                                        </div>
                                    </li>

		                        <?php endforeach; ?>
                            </ul>
                        <?php endif; ?>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <?php if (!empty($streams = \PixieFreakPanel\Model\Team::query()->stream($team))): ?>
    <section class="streams">
        <div class="container">
            <div class="section-header">
                <!-- Title -->
                <div class="section-title">
                    <h2><?php echo esc_html__('View all streams', 'pixiefreak'); ?></h2>
                    <span><?php echo esc_html__('and get hyped in a minute', 'pixiefreak'); ?></span>
                </div>
            </div>
            <div class="tab-content">
                <div class="stream-list team-page-stream-list active">
		            <?php foreach ($streams as $stream): ?>
                        <div class="stream-box" style="background-image: url('<?php echo esc_attr($stream->thumbnail); ?>');">
                            <a href="<?php echo pixiefreak_route('stream', $stream->slug); ?>" class="overlay">

                                <div class="stream-views">
                            <span>
                                <i class="fas fa-eye"></i>
	                            <?php $stream->is_online == 1 ? esc_html_e('Online', 'pixiefreak') : esc_html_e('Offline', 'pixiefreak'); ?>
                            </span>
                                </div>

                                <i class="fas fa-play text--center"></i>

                                <div class="stream-desc">
                                    <div class="stream-info">
                                        <span class="streamer-name"><?php echo esc_attr($stream->title); ?></span>
                                        <span class="stream-name"><?php echo esc_attr($stream->subtitle); ?></span>
                                    </div>
                                </div>
                            </a>
                        </div>
		            <?php endforeach; ?>
                </div>
            </div>
        </div>
    </section>
    <?php endif; ?>

    <?php
        $original_query = $wp_query;
        $wp_query = null;
        $args = array('posts_per_page'=> 4, 'tag' => $team->slug);
        $wp_query = new WP_Query( $args );
        if ($wp_query->have_posts()):
    ?>
    <section class="news">
        <div class="container">

            <div class="section-header col-white">
                <div class="section-title">
                    <h2><?php echo esc_html__('Team news', 'pixiefreak'); ?></h2>
                    <span><?php echo esc_html__('Related news', 'pixiefreak'); ?></span>
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

<?php get_footer(); ?>

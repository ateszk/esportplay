<?php /* Template Name: Player */ ?>
<?php
    if(!pixiefreak_active()) {
        wp_redirect(get_home_url()); die();
    }
    $slug = esc_attr(get_query_var('player_slug'));
    $settings = pixiefreak_settings('player');
    if (empty($player = \PixieFreakPanel\Model\Player::query()->where('slug', $slug)->get()->first())) {
        wp_redirect(get_home_url()); die();
    }

    if (empty($team = \PixieFreakPanel\Model\Player::query()->team($player)[0])) {
        wp_redirect(get_home_url()); die();
    }

    $gears = \PixieFreakPanel\Model\Player::query()->gear($player);
    $country = \PixieFreakPanel\Model\Countries::findAll($player->country);
    $headerBackground = $player->cover;
    $pageTagLine = $player->nickname;
?>

    <?php get_header(); ?>

    <section class="player-page inner-page">
        <div class="container">
            <div class="inner-header" style="background-image: url('<?php echo esc_attr($player->banner); ?>');">
                <div class="inner-header-info">
                    <figure class="rounded">
                        <img src="<?php echo esc_url($player->avatar); ?>" alt="Manila Masters">
                    </figure>

                    <div class="inner-header-details">
                        <span><?php echo esc_html(ucfirst($player->first_name) .' '. ucfirst($player->last_name)); ?>
                            <i class="flag flag-<?php echo esc_attr(strtolower($country['code'])) ?>"></i></span>

                        <ul><li><?php echo esc_html($player->nickname); ?></li></ul>
                    </div>
                </div>
            </div>

            <div class="inner-body">
                <article class="top">
                    <div class="col left detail-left-list">
                        <ul>
                            <li>
                                <span class="label"><?php echo esc_html__('Csapat', 'pixiefreak'); ?></span>
                                <span class="name"><?php echo esc_html($team->name); ?></span>
                            </li>

                            <li>
                                <span class="label"><?php echo esc_html__('Életkor', 'pixiefreak'); ?></span>
                                <span class="name"><?php echo esc_html($player->birth_date); ?></span>
                            </li>

                            <li>
                                <span class="label"><?php echo esc_html__('Játékbeli Szerep', 'pixiefreak'); ?></span>
                                <span class="name"><?php echo esc_html($player->role); ?></span>
                            </li>
                        </ul>
                    </div>

                    <div class="col right">

	                    <?php if ($settings->shouldShow('cta_player.show')): ?>
                            <a href="<?php echo esc_url($settings->get('cta_player.link')); ?>"
                               target="_blank"
                               class="btn btn-primary"
                            >
			                    <?php echo esc_html($settings->get('cta_player.text')); ?>
                                <i class="<?php echo esc_attr($settings->get('cta_player.icon')); ?>"></i>
                            </a>
	                    <?php endif; ?>
                    </div>
                </article>

                <article class="bottom">
                    <div class="col left textarea">
                        <div class="text-head">
                            <h4>
	                            <?php echo esc_html__('Játékos leírás', 'pixiefreak'); ?>
                            </h4>

	                        <?php if (!empty($socials = json_decode($player->social, true))): ?>
                                <ul class="social-list">
                                    <?php foreach ($socials as $socialName => $url): ?>

				                        <?php if (!empty($url || $url !== '')): ?>
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

                        <div class="scrollbar-outer">
                            <p>
		                        <?php echo nl2br(wp_specialchars_decode($player->biography)); ?>
                            </p>
                        </div>
                    </div>
                    
                </article>
            </div>

	        <?php if (!empty($gears)): ?>
            <div class="gear-list">
                <div class="section-header col-white">
                    <!-- Title -->
                    <div class="section-title normal">
                        <h2><?php echo esc_html__('Perifériák', 'pixiefreak'); ?></h2>
                        <span><?php echo esc_html__('A játékos ezeket a perifériákat használja sikerei eléréséhez', 'pixiefreak'); ?></span>
                    </div>
                </div>

                <div class="tab-content">
                    <ul class="card-list secondary-list secondary-list-left active">
                        <?php foreach ($gears as $gear): ?>
                            <li class="card">
                                <div class="card-info">
                                    <div class="card-info-pad">
                                        <?php if ((bool) $gear->recommended): ?>
                                        <span class="label text-uppercase label-green">
                                            <?php echo esc_html__('Új', 'pixiefreak'); ?>
                                        </span>
                                        <?php endif; ?>

                                        <h4 class="title">
                                            <?php echo esc_html($gear->name); ?>
                                        </h4>

                                        <span class="subtitle">
                                            <?php if ($gear->type == 0): ?>
                                                <?php echo esc_html__('Egér', 'pixiefreak'); ?>
                                            <?php elseif ($gear->type == 1): ?>
                                                <?php echo esc_html__('Fej/Fülhallgató', 'pixiefreak'); ?>
                                            <?php else: ?>
                                                <?php echo esc_html__('Billentyűzet', 'pixiefreak'); ?>
                                            <?php endif; ?>
                                        </span>
                                    </div>

                                    <?php if (!empty($gear->link)): ?>
                                        <a href="<?php echo esc_url($gear->link); ?>" class="btn btn-default">
                                            <?php echo esc_html__('Megtekintés', 'pixiefreak'); ?>
                                        </a>
                                    <?php endif; ?>
                                </div>
                                <figure class="center">
                                    <img src="<?php echo esc_url($gear->image); ?>" alt="<?php echo esc_attr($gear->name) ?>">
                                </figure>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            </div>
	        <?php endif; ?>
        </div>
    </section>


    <?php if (!empty($streams = \PixieFreakPanel\Model\Player::query()->stream($player))): ?>
        <section class="streams on-player">
            <div class="container">
                <div class="section-header border-bottom">
                    <!-- Title -->
                    <div class="section-title">
                        <h2><?php echo esc_html__('Kövesd őt élőben', 'pixiefreak'); ?></h2>
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
    $args = array('posts_per_page'=> 4, 'tag' => $player->slug);
    $wp_query = new WP_Query( $args );
    if ($wp_query->have_posts()):
        ?>
        <section class="news">
            <div class="container">

                <div class="section-header col-white">
                    <div class="section-title">
                        <h2><?php echo esc_html__('Új csapatok', 'pixiefreak'); ?></h2>
                        <span><?php echo esc_html__('Hírek', 'pixiefreak'); ?></span>
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

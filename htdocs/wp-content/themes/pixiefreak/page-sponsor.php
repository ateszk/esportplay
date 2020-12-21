<?php /* Template Name: Sponsor */ ?>
<?php
if(!pixiefreak_active()) {
	wp_redirect(get_home_url()); die();
}
$settings = pixiefreak_settings('sponsor');
$headerBackground = esc_attr($settings->get('banner_image'));
?>
<?php get_header(); ?>

<section class="page-hero sponsorHero">
    <div class="container">
	    <?php if ($settings->shouldShow('show_title')): ?>
            <h2><?php echo esc_html($settings->get('title')); ?></h2>
	    <?php endif; ?>
	    <?php if ($settings->shouldShow('show_subtitle')): ?>
            <h4><?php echo esc_html($settings->get('subtitle')); ?></h4>
	    <?php endif; ?>


	    <?php if ($settings->shouldShow('cta.show')): ?>
            <div class="actions">
                <a href="<?php echo esc_url($settings->get('cta.link')); ?>" class="btn-default">
				    <?php echo esc_html($settings->get('cta.text')); ?>
                </a>
            </div>
	    <?php endif; ?>
    </div>
</section>

<section class="sponsors">
    <div class="head-sp">
        <div class="container">
            <?php
                $sponsors = \PixieFreakPanel\Model\Sponsor::query()->orderBy('order_number', 'ASC')->get();
                $headSponsors = [];
                $defaultSponsors = [];
            ?>

            <?php if ($sponsors->isNotEmpty()): ?>
                <?php foreach ($sponsors as $sponsor): ?>
                    <?php if ((int)$sponsor->type === \PixieFreakPanel\Model\Sponsor::TYPE_HEAD): ?>
                        <?php $headSponsors[] = $sponsor; ?>
                    <?php else: ?>
                        <?php $defaultSponsors[] = $sponsor; ?>
                    <?php endif; ?>
                <?php endforeach; ?>
            <?php endif; ?>

            <?php if (!empty($headSponsors)): ?>
                <ul class="sp-list">

                    <?php foreach ($headSponsors as $headSponsor): ?>
                        <li class="sp-box">
                            <figure>
                                <img src="<?php echo esc_url($headSponsor->logo); ?>" alt="<?php echo esc_attr($headSponsor->name); ?>">
                            </figure>

                            <p>
                                <?php echo esc_attr($headSponsor->about); ?>
                            </p>

                            <?php if (!empty($socials = json_decode($headSponsor->social, true))): ?>

                                <ul>
                                    <?php foreach ($socials as $social => $link): ?>
                                        <?php if (empty($link)) continue; ?>

                                        <li>
                                            <a href="<?php echo esc_url($link); ?>" target="_blank">
                                                <i class="fab fa-<?php echo esc_attr($social); ?>"></i>
                                            </a>
                                        </li>

                                    <?php endforeach; ?>
                                </ul>

                            <?php endif; ?>

                            <a href="<?php echo esc_url($headSponsor->url); ?>" class="btn-default">
	                            <?php esc_html_e('Website', 'pixiefreak'); ?>
                            </a>
                        </li>
                    <?php endforeach; ?>

                </ul>
            <?php endif; ?>
        </div>
    </div>

    <?php if (!empty($defaultSponsors)): ?>
        <div class="basic-sp">
            <div class="container">
                <ul class="sp-list">
                    <?php foreach ($defaultSponsors as $defaultSponsor): ?>
                        <li class="sp-box">
                            <figure>
                                <img src="<?php echo esc_url($defaultSponsor->logo); ?>" alt="<?php echo esc_attr($defaultSponsor->name); ?>">
                            </figure>

                            <p>
			                    <?php echo esc_attr($defaultSponsor->about); ?>
                            </p>

		                    <?php if (!empty($socials = json_decode($defaultSponsor->social, true))): ?>

                                <ul>
				                    <?php foreach ($socials as $social => $link): ?>
					                    <?php if (empty($link)) continue; ?>

                                        <li>
                                            <a href="<?php echo esc_url($link); ?>" target="_blank">
                                                <i class="fab fa-<?php echo esc_attr($social); ?>"></i>
                                            </a>
                                        </li>

				                    <?php endforeach; ?>
                                </ul>

		                    <?php endif; ?>

                            <a href="<?php echo esc_url($defaultSponsor->url); ?>" class="btn-default">
			                    <?php esc_html_e('Website', 'pixiefreak'); ?>
                            </a>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        </div>
    <?php endif ;?>
</section>

<?php get_footer(); ?>
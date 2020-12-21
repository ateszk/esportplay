<?php /* Template Name: Streams */ ?>
<?php
if(!pixiefreak_active()) {
	wp_redirect(get_home_url()); die();
}
$settings = pixiefreak_settings('stream');
$headerBackground = $settings->get('banner_image');
?>

<?php get_header(); ?>

<section class="page-hero">
    <div class="container">
        <h2><?php echo esc_html($settings->get('title')) ?></h2>
        <h4><?php echo esc_html($settings->get('subtitle')) ?></h4>

        <ul class="tab-nav">
            <li class="active">
                <a href="#all-stream" data-toggle="tab">
                    <i class="fas fa-list"></i>
                </a>
            </li>

            <li>
                <a href="#youtube-stream" data-toggle="tab">
                    <i class="fab fa-youtube"></i>
                </a>
            </li>

            <li>
                <a href="#twitch-stream" data-toggle="tab">
                    <i class="fab fa-twitch"></i>
                </a>
            </li>
        </ul>
    </div>
</section>

<section class="streams">
    <div class="container">

        <div class="tab-content">
            <div id="all-stream" class="stream-list active">
                <?php $streams = \PixieFreakPanel\Model\Stream::query()->get(); ?>
	            <?php foreach ($streams as $stream): ?>
                    <div class="stream-box" style="background-image: url('<?php echo esc_attr($stream->thumbnail); ?>');">
                        <a href="<?php echo pixiefreak_route('stream', $stream->slug); ?>" class="overlay">

                            <div class="stream-views">
                                <span>
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

            <?php if (!empty($streams)): ?>
                <?php foreach (\PixieFreakPanel\Model\Stream::TYPES as $key => $type): ?>
                    <div class="stream-list" id="<?php echo esc_attr(strtolower($type)); ?>-stream">
	                    <?php foreach ($streams as $stream): if ($stream->type != $key) { continue; } ?>
                            <div class="stream-box" style="background-image: url('<?php echo esc_attr($stream->thumbnail); ?>');">
                                <a href="<?php echo pixiefreak_route('stream', $stream->slug); ?>" class="overlay">

                                    <div class="stream-views">
                                        <span>
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
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
    </div>
</section>

<?php get_footer(); ?>

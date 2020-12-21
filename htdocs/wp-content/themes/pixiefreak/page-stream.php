<?php /* Template Name: Stream */ ?>
<?php
    if(!pixiefreak_active()) {
        wp_redirect(get_home_url()); die();
    }
    $slug = esc_attr(get_query_var('stream_slug'));
    if (empty($stream = \PixieFreakPanel\Model\Stream::query()->where('slug', $slug)->get()->first())) {
        wp_redirect(get_home_url()); die();
    }

    $settings = pixiefreak_settings('stream');
    $headerBackground = $settings->get('banner_image');

    $pageTagLine = $stream->title;
?>
<?php get_header(); ?>
<section class="page-hero">
    <div class="container">
        <h2><?php echo esc_html__('Élő közvetítések', 'pixiefreak') ?></h2>
        <h4><?php echo esc_html__('Itt böngészhetsz a közvetített versenyek között', 'pixiefreak') ?></h4>
    </div>
</section>

<div class="stream-page">
    <div class="news-container">

    <section class="news">
        <div class="section-header">
            <div class="section-title normal">
                <h2><?php echo esc_html__('Streamek', 'pixiefreak'); ?></h2>
            </div>
        </div>

        <div class="tab-content content">
            <div id="all" class="active">
                <?php if ($stream->type === 1): ?>
                    <iframe width="100%"
                            height="520"
                            src="<?php echo esc_url($stream->link); ?>"
                            frameborder="0"
                            allowfullscreen="true">
                    </iframe>
                <?php else: ?>
                    <iframe width="100%"
                            height="520"
                            src="<?php echo esc_url('//player.twitch.tv/?channel=' . substr($stream->link, strrpos($stream->link, '/') + 1));?>"
                            frameborder="0"
                            allowfullscreen>
                    </iframe>
                <?php endif; ?>
            </div>
        </div>
    </section>

    <?php get_sidebar(); ?>
</div>
</div>

<?php get_footer(); ?>

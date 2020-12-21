<?php
if(pixiefreak_active()) {
	$settings         = pixiefreak_settings( 'general' );
	$headerBackground = $settings->get( 'notfound_background' );
}
?>
<?php get_header(); ?>

<section class="page-hero not-found">
    <div class="container">
        <h2>
	        <?php echo esc_html__('404 Page not found!', 'pixiefreak'); ?>
        </h2>
        <h4>
	        <?php echo esc_html__('Random text goes here to show that page is not found', 'pixiefreak'); ?>
        </h4>

        <?php echo pixiefreak_custom_form() ?>
    </div>
</section>

<?php get_footer(); ?>
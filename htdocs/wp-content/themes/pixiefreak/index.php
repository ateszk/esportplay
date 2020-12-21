<?php get_header(); ?>

<?php
    $original_query = $wp_query;
    $wp_query = null;
    $args = array('posts_per_page'=> 2, 'orderby' => 'date', 'order' => 'DESC');
    $map = [1 => 'first', 2 => 'second', 3 => 'third'];
    $wp_query = new WP_Query( $args );
?>

<?php if (!empty($sections = pixiefreak_settings('general')->get('section_order'))): ?>
    <?php foreach ($sections as $section): ?>
        <?php
            $sectionAccessor = strtolower(str_replace(' ', '-', $section));
            $isVisible = pixiefreak_settings('general')->get('section_visibility')[$sectionAccessor];
        ?>

        <?php if ($isVisible): ?>
            <?php get_template_part('/inc/sections/' .$sectionAccessor. '-section'); ?>
        <?php endif; ?>

    <?php endforeach; ?>
<?php endif; ?>


<?php if (!pixiefreak_active()): ?>
    <?php get_template_part('/inc/sections/news-section'); ?>
<?php endif; ?>

<?php get_footer(); ?>
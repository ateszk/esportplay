<?php /* Template Name: Blank */ ?>
<?php
$noHeaderBackground = true;
?>
<?php get_header(); ?>

    <?php if(have_posts()): the_post(); $postID = array(get_the_ID());?>
        <section class="single-page">
            <div class="container">
                <?php the_content(); ?>
            </div>
        </section>
    <?php endif; ?>

<?php get_footer(); ?>
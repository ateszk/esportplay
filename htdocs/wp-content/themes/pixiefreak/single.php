<?php
$withOutHeader = false;
$hasPostThumbnail = has_post_thumbnail();
?>

<?php get_header(); ?>

<?php
    if (have_posts()) {
        the_post();
        $postID = array(get_the_ID());
    }
    $addClass = ['single-page'];
    if (!pixiefreak_active()) {
        $addClass[] = 'not-active-pixie';
    }
?>
<section id="post-<?php the_ID(); ?>" <?php post_class(implode(' ', $addClass)); ?>>
    <div class="container">

        <?php if (has_post_thumbnail()): ?>
            <figure class="featured-box">
                <img src="<?php the_post_thumbnail_url(); ?>" alt="<?php the_title_attribute(); ?>">
            </figure>
        <?php endif; ?>

        <div class="wrapper">
            <?php $fullWidth = true; ?>
            <?php if (pixiefreak_active()): $fullWidth = false; ?>
            <div class="social-widget">
                <?php $commentCount = get_post()->comment_count; ?>
                <?php if ($commentCount > 0): ?>
                    <div class="comment-counter">
                        <span><?php echo esc_html($commentCount); ?></span>
                        <span><?php esc_html_e('Hozzászólások', 'pixiefreak'); ?></span>
                    </div>
                <?php endif; ?>

                <ul class="share-post">
                    <li>
                        <a href="<?php echo esc_url(pixiefreak_sharer('mailto', get_the_permalink(), get_the_title())); ?>"
                           class="email-share">
                           <i class="fas fa-envelope"></i>
                        </a>
                    </li>

                    <li>
                        <a href="<?php echo esc_url(pixiefreak_sharer('facebook', get_the_permalink(), get_the_title())); ?>"
                           target="_blank"
                           class="fb-share">
                           <i class="fab fa-facebook-f"></i>
                        </a>
                    </li>
                    <li>
                        <a href="<?php echo esc_url(pixiefreak_sharer('twitter', get_the_permalink(), get_the_title())); ?>"
                           target="_blank"
                           class="twitter-share">
                           <i class="fab fa-twitter"></i>
                        </a>
                    </li>
                </ul>
            </div>
            <?php endif; ?>

            <?php $postClass = ($fullWidth) ? 'post full-width': 'post'; ?>
            <div class="<?php echo esc_attr($postClass) ?>">
                <h1 class="post-title"><?php the_title(); ?></h1>
                <span class="post-details">
                    <?php if (is_sticky()): ?>
                        <span class="sticky">
                            <i class="fa fa-map-pin"></i> <?php echo esc_html__('Sticky', 'pixiefreak'); ?>
                        </span>
                    <?php endif; ?>
                    <?php esc_html_e('Létrehozta', 'pixiefreak') ?>
                    <span class="author"><?php (get_the_author()) ? the_author_link() : '/' ?></span> <?php the_date() ?> <?php esc_html_e('a', 'pixiefreak'); ?>
                    <?php
                        $post_categories = wp_get_post_categories(get_the_ID());
                        $cats = array();

                        foreach($post_categories as $c){
                            $cat = get_category($c);
                            echo '<a href="'.get_category_link($cat).'">'.esc_html($cat->name).'</a>';
                        }
                    ?>
                </span>

                <?php the_content(); ?>

                <div class="clearfix"></div>

                <?php
                $defaults = array(
                    'before'           => '<div class="page-links"><span class="page-links-title">' . esc_html__( 'Oldalak:', 'pixiefreak') . '</span>',
                    'after'            => '</div>',
                    'next_or_number'   => 'number',
                    'separator'        => ' ',
                    'link_before' => '<span>',
                    'link_after'  => '</span>',
                    'nextpagelink'     => esc_html__( 'Következő oldal', 'pixiefreak'),
                    'previouspagelink' => esc_html__( 'Előző oldal', 'pixiefreak'),
                    'pagelink'         => '%',
                    'echo'             => true
                );

                wp_link_pages( $defaults );
                ?>

                <?php $posttags = get_the_tags(); ?>
                <?php if (!empty($posttags)): ?>
                <div class="post-tags">
                    <?php the_tags('<span>'.esc_html__('Tagek:', 'pixiefreak').'</span>', '', ''); ?>
                </div>
                <?php endif; ?>

            </div>
        </div>
         <?php
            if (comments_open() || get_comments_number()) {
                comments_template('/comments.php', true);
            }
        ?>
    </div>
</section>
<?php get_footer(); ?>
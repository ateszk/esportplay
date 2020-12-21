<?php $withOutHeader = false; ?>
<?php get_header(); ?>

<?php
if(have_posts()) {
	the_post();
	$postID = array(get_the_ID());

	$addClass = ['single-page'];
}
?>
<section class="<?php echo esc_attr(implode(' ', $addClass)); ?>">

    <div class="container">

	    <?php if (has_post_thumbnail()): ?>
            <figure class="featured-box">
                <img src="<?php the_post_thumbnail_url(); ?>" alt="<?php the_title_attribute(); ?>">
            </figure>
	    <?php endif; ?>

        <div class="wrapper">
	        <?php $fullWidth = true; ?>
	        <?php if (pixiefreak_active() && !pixiefreak_woo_page() && !pixiefreak_bbpress_page()): $fullWidth = false; ?>
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

            <?php
            $class = $fullWidth ? 'post full-width': '';
            if (pixiefreak_woo_page() || pixiefreak_bbpress_page()) {
               $class = 'page' . ($fullWidth ? ' full-width' : '');
            }
            ?>
            <div class="<?php echo esc_attr($class) ?>">

                <?php if(!pixiefreak_bbpress_page()): ?>
                <h1><?php the_title(); ?></h1>
                <?php endif; ?>


                <?php if (!pixiefreak_woo_page() && !pixiefreak_bbpress_page()): ?>
                <span class="post-details">
                        <?php if (is_sticky()): ?>
                            <span class="sticky">
                                <i class="fa fa-map-pin"></i> <?php echo esc_html__('Sticky', 'pixiefreak'); ?>
                            </span>
                        <?php endif; ?>
					<?php esc_html_e('Posted by', 'pixiefreak') ?>
                    <span class="author"><?php (get_the_author()) ? the_author_link() : '/' ?></span> <?php the_date() ?> <?php esc_html_e('in', 'pixiefreak'); ?>
					<?php
					$post_categories = wp_get_post_categories(get_the_ID());
					$cats = array();

					foreach($post_categories as $c){
						$cat = get_category($c);
						echo '<a href="'.get_category_link($cat).'">'.esc_html($cat->name).'</a>';
					}
					?>
                    </span>
                <?php endif; ?>

	            <?php the_content(); ?>

                <div class="clearfix"></div>
	            <?php
	            $defaults = array(
		            'before'           => '<div class="page-links"><span class="page-links-title">' . esc_html__( 'Pages:', 'pixiefreak') . '</span>',
		            'after'            => '</div>',
		            'next_or_number'   => 'number',
		            'separator'        => ' ',
		            'link_before' => '<span>',
		            'link_after'  => '</span>',
		            'nextpagelink'     => esc_html__( 'Next page', 'pixiefreak'),
		            'previouspagelink' => esc_html__( 'Previous page', 'pixiefreak'),
		            'pagelink'         => '%',
		            'echo'             => true
	            );

	            wp_link_pages( $defaults );
	            ?>
            </div>
        </div>
		<?php
		if (comments_open() || get_comments_number()) {
			comments_template();
		}
		?>
    </div>
</section>
<?php get_footer(); ?>

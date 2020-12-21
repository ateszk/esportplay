<?php
    global $paged;
    $args = array('posts_per_page' => get_option('posts_per_page'), 'paged' => $paged, 'orderby' => 'date', 'order' => 'DESC');
    query_posts($args);
?>

<?php if (have_posts()): ?>
    <section class="news">
        <div class="container">
            <div class="section-header">
                <div class="section-title normal">
                    <h2><?php echo esc_html__('Új hírek', 'pixiefreak'); ?></h2>
                </div>
            </div>

            <div class="tab-content content">
                <div id="all" class="news-grid active">
                    <?php
                    $postCount = 0;
                    while (have_posts()): the_post(); $postCount ++;?>
                        <?php if (pixiefreak_active() && $postCount > 4) { break; };?>
                        <?php $post = get_post(get_the_ID()); ?>

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
                    wp_reset_postdata();
                    ?>
                </div>
                <?php if (!pixiefreak_active()): ?>
                <div class="pagination post-navigation-list">
                    <div class="nav-previous alignleft">
                        <?php previous_posts_link( 'Newer posts'); ?>
                    </div>

                    <div class="nav-next alignright">
                        <?php next_posts_link( 'Older posts'); ?>
                    </div>
                </div>
                <?php endif; ?>
            </div>
        </div>
    </section>
<?php endif; ?>
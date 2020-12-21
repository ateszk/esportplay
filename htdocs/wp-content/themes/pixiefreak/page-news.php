<?php /* Template Name: News */ ?>

<?php get_header(); ?>

<section class="page-hero">
    <div class="container">
        <h2><?php echo esc_html__('HÍREK', 'pixiefreak') ?></h2>
        <h4><?php echo esc_html__('Itt böngészhetsz a híreink között', 'pixiefreak') ?></h4>
    </div>
</section>

<div class="news-page">
    <section class="news-container">

        <div class="news">
            <div class="section-header">
                <div class="section-title normal">
                    <h2><?php echo esc_html__('Hírcsatorna', 'pixiefreak'); ?></h2>
                </div>
                <ul>
                    <li class="active">
                        <a href="#all" data-toggle="tab" class="msnry"><?php echo esc_html__('Összes', 'pixiefreak'); ?></a>
                    </li>

                    <?php $i=0; foreach ($categories = get_categories() as $postCategory): $i++;?>
                        <?php if ($i > 3): continue; endif; ?>
                        <li>
                            <a href="#category-<?php echo esc_attr($postCategory->cat_ID); ?>" data-toggle="tab" class="msnry">
                                <?php echo esc_html($postCategory->name); ?>
                            </a>
                        </li>
                    <?php endforeach; ?>
                    <?php if (count($categories) > 4): ?>
                        <li class="menu-item-has-children">
                            <a href="#">
                                <?php esc_html_e('More', 'pixiefreak'); ?>
                                <i class="fas fa-angle-down"></i>
                            </a>
                            <ul class="sub-menu">
                                <?php foreach ($categories as $key => $postCategory): ?>
                                    <?php if (!in_array($key, range(0, 5))): ?>
                                        <li>
                                            <a href="#category-<?php echo esc_attr($postCategory->cat_ID); ?>" data-toggle="tab">
                                                <?php echo esc_html($postCategory->name); ?>
                                            </a>
                                        </li>
                                    <?php endif; ?>
                                <?php endforeach; ?>
                            </ul>
                        </li>
                    <?php endif; ?>
                </ul>
            </div>

            <div class="tab-content content">
                <div id="all" class="news-grid active">
                    <?php
                    global $paged;

                    $args = array('posts_per_page' => get_option('posts_per_page'), 'paged' => $paged, 'orderby' => 'date', 'order' => 'DESC');
                    query_posts($args);
                    $posts = new WP_Query($args);

                    while ($posts->have_posts()): $posts->the_post();?>
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
                <?php foreach ($categories as $postCategory): ?>
                    <div id="category-<?php echo esc_attr($postCategory->cat_ID); ?>" class="news-grid">
                        <?php
                        $args = array('posts_per_page' => get_option('posts_per_page'), 'orderby' => 'date', 'order' => 'DESC', 'category' => $postCategory->cat_ID);
                        $query = new WP_Query($args);
                        foreach (get_posts($args) as $post): ?>
                            <?php $GLOBALS['post'] = $post; ?>
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
                        endforeach;
                        wp_reset_postdata();
                        ?>
                    </div>
                <?php endforeach; ?>
            </div>

            <div class="pagination post-navigation-list">
                <div class="nav-previous alignleft">
			        <?php previous_posts_link( 'Newer posts', $posts->max_num_pages); ?>
                </div>

                <div class="nav-next alignright">
			        <?php next_posts_link( 'Older posts', $posts->max_num_pages); ?>
                </div>
            </div>
        </div>
	    <?php get_sidebar(); ?>
    </section>
</div>



<?php get_footer(); ?>

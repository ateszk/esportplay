<?php /* Template Name: Shop */ ?>
<?php
    if (!function_exists('is_woocommerce')) {
        wp_redirect(get_home_url()); die();
    }

    $args = array('orderby'  => 'dat');
    $products = wc_get_products( $args );
?>

<?php get_header(); ?>

    <section class="shop products">
        <div class="container">
            <div class="section-header">
                <div class="section-title">
                    <h2><?php echo esc_html__('Shop fusion', 'pixiefreak'); ?></h2>
                </div>
            </div>

            <div class="tab-content">
                <div class="recent">
                    <div class="shop-boxes">
                        <?php foreach ($products as $product): ?>
                            <article class="box">
                                <figure class="product-img">
                                    <img src="<?php echo esc_url(wp_get_attachment_image_src(get_post_thumbnail_id($product->get_id()), 'single-post-thumbnail')[0]) ?>"
                                         alt="<?php echo esc_attr($product->get_title()); ?>">
                                </figure>

                                <div class="product-details">
                                    <h4>
                                        <?php echo esc_html($product->get_title()); ?>
                                    </h4>
                                    <p>
                                        <?php echo esc_html($product->get_description()); ?>
                                    </p>
                                    <div class="shop-cta">
                                        <a href="<?php echo esc_url($product->get_permalink()); ?>" class="btn-default">
                                            <?php esc_html_e('Buy Now', 'pixiefreak'); ?>
                                        </a>

                                        <span class="price">
                                            <?php echo esc_html(
                                                strip_tags(wc_price($product->get_price()))
                                            ); ?>
                                        </span>
                                    </div>
                                </div>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>
        </div>
    </section>

<?php get_footer(); ?>
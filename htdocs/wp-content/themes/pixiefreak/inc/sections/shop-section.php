<?php
    if (!pixiefreak_active() || !class_exists(WooCommerce::class)) { return; }
    $args = array(
        'post_type' => 'product',
        'posts_per_page' => 3,
        'tax_query' => array(
            array(
                'taxonomy' => 'product_visibility',
                'field'    => 'name',
                'terms'    => 'featured',
            ),
        )
    );

    $featuredProducts = get_posts($args);
    $products = wc_get_products(array('orderby'  => 'date', 'posts_per_page' => 3));
    $excludeIds = array();
?>

<?php if (!empty($products) || !empty($featuredProducts)): ?>
    <section class="shop">

        <div class="container">
            <div class="section-header border-bottom">
                <div class="section-title normal">
                    <h2>
                        <?php esc_html_e('Shop fusion', 'pixiefreak'); ?>
                    </h2>
                </div>
            </div>

            <div class="tab-content">
                <div class="recent active">
                    <?php if (!empty($featuredProducts)): ?>
                        <div class="slider owl-carousel">
                            <?php foreach ($featuredProducts as $product): ?>
                            <?php $excludeIds[] = $product->ID; ?>
                            <?php $product = (new WC_Product_Factory())->get_product($product->ID); ?>
                                <div class="slide">
                                    <?php $featuredImg = wp_get_attachment_image_src(get_post_thumbnail_id($product->get_id()), 'single-post-thumbnail')[0]; ?>

                                    <?php if (!empty($featuredImg)): ?>
                                    <figure class="product-img">
                                        <img src="<?php echo esc_url($featuredImg) ?>"
                                             alt="<?php echo esc_attr($product->get_title()); ?>">
                                    </figure>
                                    <?php endif; ?>

                                    <div class="product-details">
                                        <?php if (!empty($product->get_sale_price()) && !empty($product->get_sale_price())): ?>
                                            <span class="discount"><?php echo esc_html__('Sale', 'pixiefreak'); ?></span>
                                        <?php endif; ?>

                                        <h3>
                                            <?php echo esc_html($product->get_title()); ?>
                                        </h3>

                                        <p>
                                            <?php echo pixiefreak_truncate(esc_html($product->get_description())); ?>
                                        </p>

                                        <div class="product-size">
                                            <div class="">
                                            </div>

                                            <div class="shop-cta">
                                                <a href="<?php echo esc_url($product->get_permalink()); ?>"
                                                   class="btn-default">
                                                    <?php esc_html_e('Buy Now', 'pixiefreak'); ?>
                                                </a>
                                                <span class="price">
                                                <?php echo esc_html(
                                                    strip_tags(wc_price($product->get_price()))
                                                ); ?>
                                            </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>

                    <?php if (!empty($products)): ?>
                        <div class="shop-boxes">
                            <?php foreach ($products as $product): ?>
                            <?php if (in_array($product->get_id(), $excludeIds)): continue; endif; ?>
                                <article class="box">
                                    <div class="product-details">
                                        <h4>
                                            <?php echo esc_html($product->get_title()); ?>
                                        </h4>

                                        <p>
                                            <?php echo pixiefreak_truncate(esc_html($product->get_description())); ?>
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
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </section>
<?php endif; ?>
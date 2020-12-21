<footer>
    <div class="container">
        <?php if (pixiefreak_active()): ?>
            <?php $sponsors = \PixieFreakPanel\Model\Sponsor::query()->orderBy('order_number', 'ASC')->get() ?>
            <?php if ($sponsors->isNotEmpty()): ?>
            <div class="sponsors">
                <div class="slider owl-carousel">
                    <?php foreach ($sponsors as $sponsor): ?>
                        <div class="slide">
                            <a href="<?php echo esc_url($sponsor->url); ?>" target="_blank">
                                <img src="<?php echo esc_url($sponsor->logo); ?>" alt="<?php echo esc_attr($sponsor->name); ?>">
                            </a>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endif; ?>
        <?php endif; ?>

        <div class="footer-content">
            <div class="footer-widget">
                <div class="logo">
	                <?php echo pixiefreak_custom_logo() ?>

	                <?php if (pixiefreak_active()): ?>
                        <?php if (pixiefreak_settings('general')->shouldShow('show_socials_footer')): ?>
                            <ul>
                                <?php foreach (pixiefreak_settings('general')->get('social') as $social => $link): ?>
	                                <?php if (empty($link)) continue; ?>
                                    <li>
                                        <a href="<?php echo esc_url($link); ?>" target="_blank">
                                            <i class="fab fa-<?php echo esc_attr($social); ?>"></i>
                                        </a>
                                    </li>
                                <?php endforeach; ?>
                            </ul>
                        <?php endif; ?>
                    <?php endif; ?>
                </div>
            </div>

            <?php if (pixiefreak_active() && pixiefreak_should_show_getIn()): ?>
                <div class="footer-widget contact-us">
                    <ul>
                        <?php
                            $touchSettings = pixiefreak_settings('general');
                            $touchShow = false;
                            $selector = 'get_in_touch_';
                        ?>

                        <li>
                            <?php esc_html_e('Kapcsolat', 'pixiefreak'); ?>
                        </li>

                        <?php foreach (range(1, 4) as $range): ?>
                            <?php if ($touchSettings->get($selector . $range)['show']): ?>
                                <li>
                                    <?php if (!empty($icon = $touchSettings->get($selector . $range . '.icon'))): ?>
                                        <i class="<?php echo esc_attr($icon); ?>"></i>
                                    <?php endif; ?>


                                    <div class="details">
                                        <?php if (!empty($title = $touchSettings->get($selector . $range . '.title'))): ?>
                                            <span>
                                                <?php echo esc_html($title); ?>
                                            </span>
                                        <?php endif; ?>
                                        <?php if (!empty($subtitle = $touchSettings->get($selector . $range . '.subtitle'))): ?>
                                            <a>
                                                <?php echo esc_html($subtitle); ?>
                                            </a>
                                        <?php endif; ?>
                                    </div>
                                </li>

                            <?php endif; ?>
                        <?php endforeach; ?>
                    </ul>
                </div>
            <?php endif; ?>

            <?php if (pixiefreak_active()): ?>
            <div class="footer-widget latest-news">
                <ul>
                    <li>
                        <?php esc_html_e('Legújabb hírek', 'pixiefreak'); ?>
                    </li>

                    <?php $original_query = $wp_query; $wp_query = new WP_Query(); $i=0; ?>
                    <?php if ($posts = get_posts(['posts_per_page' => '2'])): ?>
                        <?php foreach ($posts as $post): ?>
                            <li>
                                <a href="<?php echo esc_url(get_permalink()); ?>">
                                    <?php echo esc_html(the_title()); ?>
                                </a>
                            </li>
                        <?php endforeach;?>
                    <?php endif; ?>

                    <li>
                        <a href="<?php echo esc_url( home_url( '/news' ) ); ?>">
                            <?php echo esc_html__('Nézd meg az összes hírt itt', 'pixiefreak'); ?>
                            <i class="fas fa-arrow-right"></i>
                        </a>
                    </li>
                </ul>
            </div>
            <?php endif; ?>

	        <?php if (pixiefreak_should_show_menu('footer_left')): ?>
                <div class="footer-widget">
                    <?php wp_nav_menu([
                        'theme_location' => 'footer_left',
                        'menu_id' => 'footer_left',
                        'container' => false,
                        'walker' => (new pixiefreak_Menu()),
                        'items_wrap' => pixiefreak_header_left_wrap()
                    ]);
                    ?>
                </div>
	        <?php endif; ?>

            <?php if (pixiefreak_should_show_menu('footer_right')): ?>
                <div class="footer-widget">

                <?php wp_nav_menu([
                    'theme_location' => 'footer_right',
                    'menu_id' => 'footer_right',
                    'container' => false,
                    'walker' => (new pixiefreak_Menu()),
                    'items_wrap' => pixiefreak_header_right_wrap()
                ]);
                ?>
                </div>
            <?php endif; ?>
        </div>

        <?php $aboutInfoArrayMap = ['first', 'second', 'third', 'fourth']; ?>
	    <?php $aboutSettings = pixiefreak_settings('about'); ?>

        <?php if (pixiefreak_active()): ?>
            <div class="headquarter">
                <?php foreach ($aboutInfoArrayMap as $selector): ?>
                    <?php $accessor = 'about_' .$selector; ?>
                    <?php if ($aboutSettings->shouldShow($accessor . '.show')): ?>
                        <div class="hq-info">
                            <span class="city">
                                <?php if (!empty($icon = $aboutSettings->get($accessor . '.icon'))): ?>
                                    <i class="<?php echo esc_attr($icon); ?>"></i>
                                <?php endif; ?>

                                <?php if (!empty($title = $aboutSettings->get($accessor . '.title'))): ?>
                                    <?php echo esc_html($title); ?>
                                <?php endif; ?>
                            </span>

                            <?php if (!empty($subtitle = $aboutSettings->get($accessor . '.subtitle'))): ?>
                                <span class="address">
                                    <?php echo esc_html($subtitle); ?>
                                </span>

                            <?php endif; ?>
                        </div>

                    <?php endif; ?>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>

    <div class="bottom-bar">
        <div class="container">


            <div class="back-to-top">
                <i class="fas fa-angle-up"></i>
            </div>
            <div class="copyright">
                <p>
                    <a href="<?php echo get_site_url();?>"><?php echo get_bloginfo();?></a>
                    <?php if (!pixiefreak_active()): ?>
	                    <?php esc_html_e('Powered by Pixiesquad 2013-2018 All Rights Reserved.', 'pixiefreak') ?>
                    <?php else: ?>
                        <?php if (pixiefreak_settings('general')->shouldShow('show_copyright')): ?>
                            <?php echo esc_html(pixiefreak_settings('general')->get('copyright')); ?>
    	                <?php endif; ?>
                    <?php endif; ?>
                </p>
            </div>
        </div>
    </div>
</footer>

<div class="search-modal modal fade" id="searchModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content search-box">
            <div class="modal-body">
                <?php echo pixiefreak_modal_search_form(); ?>
            </div>
        </div>
    </div>
</div>

<div class="mobile-menu-modal modal fade in" id="mobileMenu" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content mobile-menu">
            <button type="button" class="btnclose" data-dismiss="modal">&times;</button>

            <div class="modal-body">
                <?php if (pixiefreak_should_show_menu('header_menu')): ?>
                    <?php wp_nav_menu([
                        'theme_location' => 'header_menu',
                        'menu_id' => 'mobile_menu',
                        'items_wrap' => pixiefreak_header_menu_wrap(),
                        'container' => false,
                        'walker' => (new pixiefreak_Menu())
                    ]);
                    ?>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<?php wp_footer();?>

</body>
</html>
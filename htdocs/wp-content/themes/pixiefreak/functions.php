<?php

require get_template_directory() .'/inc/customization.php';

// Stylesheet files
if (!function_exists('pixiefreak_styles')) {
    function pixiefreak_styles() {
        $css_version  = '1.0.0';
        $template_dir =  get_template_directory_uri();

        wp_enqueue_style('pixiefreak-style', $template_dir .'/style.css', [], $css_version);
        wp_enqueue_style('fontawesome', $template_dir .'/assets/css/fontawesome-all.css', [], $css_version);
        wp_enqueue_style('bootstrap', $template_dir .'/assets/css/bootstrap.min.css', [], $css_version);
        wp_enqueue_style('owl-carousel', $template_dir .'/assets/css/owl.carousel.min.css', [], $css_version);
        wp_enqueue_style('pixiefreak-main', $template_dir .'/assets/css/main.css', [], $css_version);
        wp_enqueue_style('lightboxgallery', $template_dir .'/assets/css/lightboxgallery-min.css', [], $css_version);
        wp_enqueue_style('jquery-bracket', $template_dir .'/assets/css/jquery.bracket.min.css', [], $css_version);
        wp_enqueue_style('jquery-scrollbar', $template_dir .'/assets/css/jquery.scrollbar.css', [], $css_version);

        // Google fonts
        $pixiefreak_google_fonts = function() {
            $font_url = '';
            if ('off' !== _x('on', 'Google font: on or off', 'pixiefreak')) {
                $font_url = add_query_arg(
                    'family',
                    urlencode('Montserrat:300,400,500,700,900'),
                    '//fonts.googleapis.com/css'
                );
            }

            return $font_url;
        };

        wp_enqueue_style('google-fonts', $pixiefreak_google_fonts(), [], $css_version);
        wp_add_inline_style('pixiefreak-main', pixiefreak_inline_css());
    }
}

// Inline style
if (!function_exists('pixiefreak_inline_css')) {
    function pixiefreak_inline_css() {
        if (empty($customizedColor = get_theme_mod('pixiefreak_primary_color'))) {
            $customizedColor = '#6931f9';
        }

        ob_start();
        include(get_template_directory() . '/inc/inline/stylesheet.php');
        $css = str_replace('<style>', '', ob_get_clean());
        $css = str_replace('</style>', '', $css);
        $css = trim(preg_replace('/\s\s+/', ' ', $css));


        $finalCss = str_replace('{{ color }}', esc_attr($customizedColor), $css);
        return $finalCss;
    }
}

if (!function_exists('pixiefreak_wc_product_gallery')) {
    function pixiefreak_wc_product_gallery() {
        add_theme_support('wc-product-gallery-zoom');
        add_theme_support('wc-product-gallery-lightbox');
        add_theme_support('wc-product-gallery-slider');
    }

    add_action('after_setup_theme', 'pixiefreak_wc_product_gallery');
}


if (!function_exists('pixiefreak_hex2rgba')) {
    function pixiefreak_hex2rgba($color, $opacity = null) {
        $default = 'rgb(0,0,0)';

        if (empty($color)) {
            return $default;
        }

        if ($color[0] == '#') {
            $color = substr($color, 1);
        }

        if (strlen($color) == 6) {
            $hex = array($color[0] . $color[1], $color[2] . $color[3], $color[4] . $color[5]);
        } elseif (strlen($color) == 3) {
            $hex = array($color[0] . $color[0], $color[1] . $color[1], $color[2] . $color[2]);
        } else {
            return $default;
        }

        $rgb = array_map('hexdec', $hex);

        if ($opacity) {
            if (abs($opacity) > 1) {
                $opacity = 1.0;
            }

            $output = 'rgba(' . implode(",", $rgb) . ',' . $opacity . ')';
        } else {
            $output = 'rgb(' . implode(",", $rgb) . ')';
        }

        //Return rgb(a) color string
        return esc_attr($output);
    }
}

// Javascript files
if (!function_exists('pixiefreak_scripts')) {
    function pixiefreak_scripts() {
        if ($GLOBALS['pagenow'] != 'wp-login.php' && !is_admin()) {
            $js_version   = '1.0.0';
            $template_dir = get_template_directory_uri();

            wp_enqueue_script('twitter-widgets', '//platform.twitter.com/widgets.js', ['jquery'], $js_version, true);
            wp_enqueue_script('bootstrap', $template_dir .'/assets/js/bootstrap.min.js', ['jquery'], $js_version, true);
            wp_enqueue_script('owl-carousel', $template_dir .'/assets/js/owl.carousel.min.js', ['jquery'], $js_version, true);
            wp_enqueue_script('jquery-scrollbar', $template_dir .'/assets/js/jquery.scrollbar.min.js', ['jquery'], $js_version, true);
            wp_enqueue_script('jquery-bracket', $template_dir .'/assets/js/jquery.bracket.min.js', ['jquery'], $js_version, true);
            wp_enqueue_script('jquery-panzoom', $template_dir .'/assets/js/jquery.panzoom.min.js', ['jquery'], $js_version, true);
            wp_enqueue_script('pixiefreak-main', $template_dir .'/assets/js/main.js', ['jquery'], $js_version, true);
            wp_enqueue_script('pixiefreak-hero', $template_dir .'/assets/js/hero-slider.js', ['jquery'], $js_version, true);
            wp_enqueue_script('lightboxgallery', $template_dir .'/assets/js/lightboxgallery-min.js', ['jquery'], $js_version, true);
        }

        if (is_singular() && comments_open() && (get_option('thread_comments') == 1)) {
            wp_register_script('comment-reply', 'wp-includes/js/comment-reply', ['jquery'], false, true);
            wp_enqueue_script('comment-reply');
        }

	    wp_add_inline_script('pixiefreak-main', pixiefreak_inline_js());
    }
}

// Inline javascript
if (!function_exists('pixiefreak_inline_js')) {
    function pixiefreak_inline_js() {
	    $js = '';
    	if (pixiefreak_active() && is_page_template('page-bracket.php')) {
		    $slug = esc_attr(get_query_var('bracket_slug'));
		    if (empty($tournament = \PixieFreakPanel\Model\Tournament::query()->where('slug', $slug)->get()->first())) {
			    wp_redirect(get_home_url()); die();
		    }

		    ob_start();
		    include(get_template_directory() . '/inc/inline/script.php');
		    $js = str_replace('<script>', '', ob_get_clean());
		    $js = str_replace('</script>', '', $js);
	    }

        return $js;
    }
}

// Asset handle function
if (!function_exists('pixiefreak_asset')) {
    function pixiefreak_asset($resourcePath = '') {
        echo esc_url(get_template_directory_uri() .'/'. $resourcePath);
    }
}

// WooCommerce
if (!function_exists('pixiefreak_woocommerce_support')) {
	function pixiefreak_woocommerce_support() {
		add_theme_support( 'woocommerce' );
	}
}

if( !function_exists('pixiefreak_check_for_woocommerce')) {
	function pixiefreak_check_for_woocommerce() {
		if ( ! defined( 'WC_VERSION' ) ) {
			return false;
		}

		return true;
	}
}

if( !function_exists('pixiefreak_woo_page')) {
	function pixiefreak_woo_page($page = '') {
		if (!pixiefreak_check_for_woocommerce()) {
			return false;
		}

		if ($page === 'cart') {
			return is_cart();
		} elseif ($page === 'product') {
			return is_product();
		} elseif ($page === 'checkout') {
			return is_checkout();
		}

		return is_cart() || is_product() || is_checkout();
	}
}

if( !function_exists('pixiefreak_bbpress_page')) {
	function pixiefreak_bbpress_page($page = '') {
		return (bool) function_exists ('is_bbpress') && is_bbpress();
	}
}


// Page break support
if(!function_exists('pixiefreak_pagebreak_button')) {
    /**
     * @param  mixed      $buttons
     * @param  int|string $id
     * @return mixed
    */
    function pixiefreak_pagebreak_button($buttons, $id) {
        if ('content' != $id)
            return $buttons;

        array_splice($buttons, 13, 0, 'wp_page');
        return $buttons;
    }
}

// Content with normalization
if (!isset($content_width)) {
    $content_width = 1170;
}

// WP Menu
if (!function_exists('pixiefreak_add_menu')) {
    function pixiefreak_add_menu() {
        register_nav_menu('header_menu',  esc_html__('Header Menu', 'pixiefreak'));
        register_nav_menu('footer_menu',  esc_html__('Useful Links', 'pixiefreak'));
        register_nav_menu('footer_left',  esc_html__('Footer Left Menu', 'pixiefreak'));
        register_nav_menu('footer_right', esc_html__('Footer Right Menu', 'pixiefreak'));

        load_theme_textdomain('pixiefreak', get_template_directory() . '/languages');
    }
}

// WP Header Menu wrapper
if (!function_exists('pixiefreak_header_menu_wrap')) {
    function pixiefreak_header_menu_wrap() {
        $wrap = '<ul id="%1$s" class="%2$s">';
        $wrap .= '%3$s';

        if (pixiefreak_settings('general')->shouldShow('show_search')) {
            $wrap .= '<li class="search"><a href="#searchModal" data-toggle="modal"><i class="fas fa-search"></i></a></li>';
        }

        $wrap .= '</ul>';
        return $wrap;
    }
}

// WP Header Menu wrapper
if (!function_exists('pixiefreak_header_left_wrap')) {
    function pixiefreak_header_left_wrap() {
        $wrap  = '<ul id="%1$s" class="%2$s">';
        $wrap .= '<li>' .esc_html__('Menu Left', 'pixiefreak') . '</li>';
        $wrap .= '%3$s';
        $wrap .= '</ul>';
        return $wrap;
    }
}

// WP Header Menu wrapper
if (!function_exists('pixiefreak_header_right_wrap')) {
    function pixiefreak_header_right_wrap() {
        $wrap  = '<ul id="%1$s" class="%2$s">';
        $wrap .= '<li>' .esc_html__('Menu Right', 'pixiefreak') . '</li>';
        $wrap .= '%3$s';
        $wrap .= '</ul>';
        return $wrap;
    }
}

// Age calculator
if (!function_exists('pixiefreak_calc_age')) {
    /**
     * @param  string $date
     * @return int
    */
    function pixiefreak_calc_age($date) {
        return (new DateTime($date))->diff(new DateTime())->y;
    }
}

// Route rewrites
if (!function_exists('pixiefreak_listen_rewrite_action')) {
    function pixiefreak_listen_rewrite_action() {
        $routeList = pixiefreak_settings('routes')->get('routes');
        foreach ($routeList as $moduleName => $arguments) {
            $route = $arguments['route'];
            $query = $arguments['query'];

            list(
                $regexTag,
                $regexRewriteFirst,
                $regexRewriteSecond,
                $matchesFirst,
                $matchesSecond
            ) = [
                '([^/]*)',
                '/([^/]+)$',
                '/([^/]+)/page/([^/]+)$',
                '=$matches[1]',
                '=$matches[1]&paged=$matches[2]'
            ];

            add_rewrite_tag("%{$query}%", $regexTag);

            add_rewrite_rule(
                '^' .$route. $regexRewriteFirst,
                'index.php?pagename=' .$route. '&' .$query. $matchesFirst,
                'top'
            );

            add_rewrite_rule(
                '^' .$route. $regexRewriteSecond,
                'index.php?pagename=' .$route. '&' .$query. $matchesSecond,
                'top'
            );
        }

        flush_rewrite_rules();
    }
}

// Is plugin active
if (!function_exists('pixiefreak_active')) {
    /**
     * @return bool
    */
    function pixiefreak_active() {
        return defined('PIXIEFREAK_ACTIVATED') && PIXIEFREAK_ACTIVATED;
    }
}

if (!function_exists('pixiefreak_should_show_menu')) {
    /**
     * @param  string $location
     * @return bool
    */
    function pixiefreak_should_show_menu($location) {
        $theme_locations = get_nav_menu_locations();
        return !empty($theme_locations[$location])
               && is_object(get_term( $theme_locations[$location], 'nav_menu' ))
               && has_nav_menu($location)
        ;
    }
}

if (!function_exists('pixiefreak_body_classes')) {
	function pixiefreak_body_classes( $classes ) {

		if(!is_home() && !pixiefreak_is('woo')) {
			$classes[] = 'is-inner-page';
		}

		return $classes;

	}
}

// Monkey patch function
if (!defined('PIXIEFREAK_ACTIVATED')) {
    /**
     * @param  string $module
     * @return pixiefreak_Settings
    */
	function pixiefreak_settings($module) {
        require_once get_template_directory() . '/inc/classes/settings.php';
        return new pixiefreak_Settings();
    }
}

// Is Woo or BBPress
if (!function_exists('pixiefreak_is')) {
    /**
     * @param  string $what
     * @return bool
    */
    function pixiefreak_is($what) {
        return $what === 'bbpress'
            ? function_exists ('is_bbpress') && is_bbpress()
            : function_exists ('is_woocommerce') && is_woocommerce()
        ;
    }
}

// Custom routing
if (!function_exists('pixiefreak_route')) {
	function pixiefreak_header_class() {
		global $headerBackground;
		global $hasPostThumbnail;
		global $noHeaderBackground;

		if(pixiefreak_active() && !isset($headerBackground)) {
			$settings = pixiefreak_settings('general');
			$headerBackground = $settings->get('default_background');
		}

		if (!pixiefreak_active() || (isset($noHeaderBackground) && $noHeaderBackground)) {
			return ' class="is-page"';
		} elseif (is_home()) {
			if (pixiefreak_active()) {
				$slides = \PixieFreakPanel\Model\Slider::query()->get();
				if($slides->isEmpty()) {
					return ' class="is-page"';
				}
			}
			return '';
		} elseif(pixiefreak_woo_page() || pixiefreak_bbpress_page()) {
			return ' class="is-page"';
		} else {
			$dataImg = (isset($hasPostThumbnail) && !$hasPostThumbnail) ? ''
				: (!pixiefreak_is('woo') ? ' data-image="' . esc_url($headerBackground) : '');

			return ' class="is-page"'. $dataImg .'" ';
		}
	}
}
// Custom routing
if (!function_exists('pixiefreak_route')) {
    /**
     * @param  string $route
     * @param  string $appendixes
     * @return string
    */
    function pixiefreak_route($route, $appendixes) {
        $translatedRoute = pixiefreak_settings('routes')->get('routes');
        if (array_key_exists($route, $translatedRoute)) {
            $route = $translatedRoute[$route]['route'];
        }

        return esc_url(get_home_url(null, $route .'/'. $appendixes));
    }
}
if (!function_exists('pixiefreak_getRoute')) {
	function pixiefreak_getRoute($route) {
		$translatedRoute = pixiefreak_settings('routes')->get('routes');
		if (array_key_exists($route, $translatedRoute)) {
			$route = $translatedRoute[$route]['route'];
		}
		return $route;
	}
}

// Request get
if (!function_exists('pixiefreak_get')) {
    /**
     * @param  string $key
     * @param  mixed  $default
     * @return mixed
    */
    function pixiefreak_get($key, $default = null) {
        return isset($_REQUEST[$key]) && !empty($_REQUEST[$key])
            ? $_REQUEST[$key]
            : $default
        ;
    }
}

if (!function_exists('pixiefreak_truncate')) {
    /**
     * @param  string $string
     * @param  int    $length
     * @param  string $append
     * @return array|string
    */
    function pixiefreak_truncate($string, $length = 145, $append = '&hellip;') {
        return (strlen($string) > $length) ? substr($string, 0, $length) . $append : $string;
    }
}

// Pagination map helper
if (!function_exists('pixiefreak_pagination')) {
    /**
     * @param  \FusionFramework\Database\ORMFusionCollection $collection
     * @param  string                                        $route
     * @return string
    */
    function pixiefreak_pagination($collection, $route) {
        if (!$collection instanceof \FusionFramework\Database\ORMFusionCollection) {
            return null;
        }

        $html  = '<ul class="pagination">';
        $phold = '<li><a {{ href }} {{ class }}>{{ page }}</a></li>';
        $pages = $collection->getPagination()['lastPage'];
        foreach (range(1, $pages) as $page) {
            if ((int) get_query_var('paged') == $page) {
                $li = str_replace('{{ class }}', 'class="active"', $phold);
                $li = str_replace('{{ page }}', $page, $li);
                $li = str_replace('{{ href }}', '', $li);
                $html .= $li;
                continue;
            }

            if ($page == 1 && empty(get_query_var('paged'))) {
                $li = str_replace('{{ class }}', 'class="active"', $phold);
                $li = str_replace('{{ href }}', '', $li);
                $li = str_replace('{{ page }}', $page, $li);
                $html .= $li;
                continue;
            }

            $li = str_replace('{{ page }}', $page, $phold);
            $li = str_replace('{{ href }}', 'href="'.esc_url(get_home_url(null, $route .'/page/'.$page)).'"', $li);
            $li = str_replace('{{ class }}', '', $li);
            $html .= $li;
        }

        $html .= '</ul>';

        if ($pages > 1) {
            return $html;
        }
    }
}

// Custom form
if (!function_exists('pixiefreak_custom_form')) {
    /**
     * @return string
    */
    function pixiefreak_custom_form() {
        $form = '<form role="search" method="get" id="searchform" class="searchform" action="' . esc_url(home_url('/')) . '" >
            <input type="text" value="' . get_search_query() . '" name="s" id="s" />
            <button type="submit"><i class="fa fa-search"></i></button>
        </form>';

        return $form;
    }
}
if (!function_exists('pixiefreak_modal_search_form')) {
    /**
     * @return string
    */
    function pixiefreak_modal_search_form() {
        $form = '<form method="get" action="' . site_url() . '">
		    <button type="submit"><i class="fa fa-search"></i></button>
		    <input type="text" class="search_field" placeholder="' . esc_attr__('Search', 'pixiefreak') . '" value="" name="s">
		    <a class="close" data-dismiss="modal"><i class="fas fa-times"></i></a>
		</form>';

        return $form;
    }
}

// Pagination page
if (!function_exists('pixiefreak_pagination_page')) {
    /**
     * @return int
    */
    function pixiefreak_pagination_page() {
        return get_query_var('paged') ?: 1;
    }
}

// Wordpress sidebar
if (!function_exists('pixiefreak_add_sidebar')) {
    function pixiefreak_add_sidebar() {
        if (function_exists('register_sidebar')) {
            register_sidebar(array(
                'name' => esc_html__('Side Area', 'pixiefreak'),
                'description' => esc_html__('The widgets on side area go here. Just drag the ones you want here.', 'pixiefreak'),
                'id' => 'pixiefreak-aside-1',
                'before_widget' => '<article id="%1$s" class="sidebar-widget">',
                'after_widget' => '</article>',
                'before_title' => '<h3>',
                'after_title' => '</h3>'
            ));
        }
    }
}

// Plugin force activation
require get_template_directory() . '/core/tgm/class-tgm-plugin-activation.php';
if (!function_exists('pixiefreak_register_required_plugins')) {
    function pixiefreak_register_required_plugins() {
        tgmpa(
            array(
                array(
                    'name' => 'PixiePanel',
                    'slug' => 'pixiefreakpanel',
                    'source' => get_template_directory_uri() . '/core/tgm/plugins/pixiefreakpanel.zip',
                    'required' => false,
                    'version' => '1.0.98.',
                    'force_activation' => false,
                    'force_deactivation' => false,
                    'external_url' => false,
                    'is_callable' => '',
                )
            ),
            array(
                'id' => 'pixiefreak',
                'default_path' => '',
                'menu' => 'tgmpa-install-plugins',
                'has_notices' => true,
                'dismissable' => true,
                'dismiss_msg' => '',
                'is_automatic' => false,
                'message' => '',
            )
        );
    }
}

// Custom comment template
if (!function_exists('pixiefreak_comment')) {
    /**
     * @param mixed $comments
     * @param mixed $args
     * @param mixed $depth
    */
    function pixiefreak_comment($comments, $args, $depth) {
        extract([
            'comments' => $comments,
            'args' => $args,
            'depth' => $depth
        ]);

        include get_template_directory() . '/inc/comment.php';
    }
}

if (!function_exists('pixiefreak_custom_logo')) {
	function pixiefreak_custom_logo() {

		$custom_logo_id = get_theme_mod( 'custom_logo' );
		$defaultLogo = get_template_directory_uri() . '/images/logo.png';

		if ($custom_logo_id) {
			$custom_logo_attr = array(
				'class'    => 'custom-logo',
			);
			$image_alt = get_post_meta($custom_logo_id, '_wp_attachment_image_alt', true);
			if ( empty( $image_alt ) ) {
				$custom_logo_attr['alt'] = get_bloginfo('name', 'display');
			}

			$img = wp_get_attachment_image($custom_logo_id, 'full', false, $custom_logo_attr);

			if(empty($img)) {
				$html = sprintf(
					'<a href="%1$s" class="custom-logo-link"><img width="230" height="41" src="%2$s" class="custom-logo" alt="%3$s"></a>',
					esc_url(home_url( '/' )), esc_url($defaultLogo), esc_attr(get_bloginfo('name'))
				);
			} else {
				$html = sprintf(
					'<a href="%1$s" class="custom-logo-link" rel="home">%2$s</a>',
					esc_url(home_url( '/' )),
					$img
				);
			}

		} elseif (is_customize_preview()) {
			$html = sprintf(
				'<a href="%1$s" class="custom-logo-link" style="display:none;"><img class="custom-logo"/></a>',
				esc_url(home_url( '/' ))
			);
		} else {
			$html = sprintf(
				'<a href="%1$s" class="custom-logo-link"><img width="230" height="41" src="%2$s" class="custom-logo" alt="%3$s"></a>',
				esc_url(home_url( '/' )), esc_url($defaultLogo), esc_attr(get_bloginfo('name'))
			);
		}

		return $html;
	}
}

// Custom child comment template
if (!function_exists('pixiefreak_comment_child')) {
    /**
     * @param mixed $comment
     * @param int   $parentId
    */
    function pixiefreak_comment_child($comment, $parentId) {
        extract(['comment' => $comment, 'parentId' => $parentId]);
        include get_template_directory() . '/inc/comment-child.php';
    }
}

if(!function_exists('pixiefreak_comment_fields')) {
	function pixiefreak_comment_fields($fields) {

		$commenter = wp_get_current_commenter();
		$req = get_option( 'require_name_email' );
		$aria_req = ( $req ? " aria-required='true'" : '' );

		$fields =  array(
			'author' =>
				'<input id="author" name="author" type="text" value="' . esc_attr( $commenter['comment_author'] ) .
				'" placeholder="' . esc_attr__('Name', 'pixiefreak') . ( $req ? '*' : '' ).'" size="30"' . $aria_req . ' />',
			'email' =>
				'<input id="email" name="email" type="text" value="' . esc_attr( $commenter['comment_author_email'] ) .
				'" placeholder="' . esc_attr__('Email', 'pixiefreak') . ( $req ? '*' : '' ).'" size="30"' . $aria_req . ' />',
			'url' =>
				'<div class="form-field"><input id="url" name="url" type="text" value="' . esc_attr( $commenter['comment_author_url'] ) .
				'" placeholder="' . esc_attr__('Website', 'pixiefreak') . '" size="30" /></div>',
		);

		$divOpened = false;
		foreach ($fields as $field => $value) {
			if($field == 'author') {
				$divOpened = true;
				$fields[$field] = '<div class="form-field">' . $value;
			} elseif ($field == 'email') {
				$divOpened = false;
				$fields[$field] = $value . '</div>';
			}

			if ($divOpened && end($fields) == $fields[$field]) {
				$fields[$field] = $value . '</div>';
			}
		}


		return $fields;
	}
}

// Custom comment form
if (!function_exists('pixiefreak_comment_form')) {
    function pixiefreak_comment_form() {

	    $comments_args = array(
		    'title_reply'=> esc_html__('Write a Reply or Comment', 'pixiefreak'),
		    'title_reply_before' => '<div class="title"><h3 id="reply-title" class="pixiefreak-add-reply-text">',
		    'title_reply_after' => '</h3></div>',
		    'comment_notes_before'  => '',
		    'label_submit'         => esc_html__('Post Comment', 'pixiefreak'),
		    'submit_button'        => '<button name="%1$s" type="submit" id="%2$s" class="%3$s">%4$s</button>',
		    'email_field'         => '<div class="form-field">%1$s %2$s</div>',
		    'submit_field'         => '<div class="form-field">%1$s %2$s</div>',
		    'comment_field' =>  '<div class="form-field"><textarea id="comment" name="comment" cols="45" rows="8" aria-required="true" placeholder="' . esc_html__('Comment', 'pixiefreak') . '"></textarea></div>',
	    );

	    return comment_form($comments_args);
    }
}

if (!function_exists('pixiefreak_change_page_title')) {
	function pixiefreak_change_page_title($title_parts) {
		global $pageTagLine;

		if(isset($pageTagLine) && !empty($pageTagLine)) {
			$title_parts['tagline'] = $pageTagLine;
		}

		return $title_parts;

	}
}
if (!function_exists('pixiefreak_should_show_getIn')) {
	function pixiefreak_should_show_getIn() {
		$touchSettings = pixiefreak_settings('general');
		$selector = 'get_in_touch_';
		$show = false;

		foreach (range(1, 4) as $range) {
			if($touchSettings->get($selector . $range)['show']) {
				$show = true;
				break;
			}
		}

		return $show;
	}
}

require get_template_directory() . '/core/functions-registry.php';
require get_template_directory() . '/core/support-registry.php';
require get_template_directory() . '/inc/classes/menu.php';
<?php

if (!function_exists('response')) {
    /**
     * @return \FusionFramework\Response
     */
    function response() {
       return (new \FusionFramework\Response());
    }
}

if (!function_exists('request')) {
    /**
     * @return \FusionFramework\Request
     */
    function request() {
        return (new \FusionFramework\Request());
    }
}

if (!function_exists('view')) {
    /**
     * @param  string $path
     * @param  array  $viewArgs
     * @param  bool   $renderLayout
     * @param  bool   $returnAsString
     * @return string
     */
    function view($path = '', $viewArgs = [], $renderLayout = true, $returnAsString = false) {
        return (new \FusionFramework\View())->render($path, $viewArgs, $renderLayout, $returnAsString);
    }
}

if (!function_exists('class_slasher')) {
    /**
     * @param  string $className
     * @return mixed
     */
    function class_slasher($className) {
        return str_replace("\\", "\\\\", $className);
    }
}

if (!function_exists('assets')) {
    /**
     * @param  string $resourcePath
     * @return string
     */
    function assets($resourcePath = '') {
        $normalizedResourcePath = str_replace('//', '/', $resourcePath);
        return esc_url(plugins_url() .'/pixiefreakpanel/resources/'. $normalizedResourcePath);
    }
}

if (!function_exists('pixiefreak_settings')) {
    /**
     * @param  string $moduleName
     * @return \PixieFreakPanel\Service\GlobalSettings\Resolver
     */
    function pixiefreak_settings($moduleName = 'General') {
        $globalSettingsClassName = "\\PixieFreakPanel\\Service\\GlobalSettings\\" . ucfirst($moduleName);
        if (!\FusionFramework\Registry::has('settings_object' . $moduleName)) {
            \FusionFramework\Registry::set('settings_object' . $moduleName, new $globalSettingsClassName());
        }

        return \FusionFramework\Registry::get('settings_object' . $moduleName);
    }
}

if (!function_exists('route')) {
    /**
     * @param  string $route
     * @param  bool   $fullRoute
     * @param  array  $arguments
     * @return string
     */
    function route($route, $fullRoute = true, $arguments = []) {
        $prefix = $fullRoute ? 'admin.php?page=' : '';

        $args = '';
        foreach ($arguments as $key => $value) {
            $args .= '&' .$key. '=' . $value;
        }

        echo  ($prefix . 'pixiefreakpanel_' . esc_attr($route) . $args);
    }
}

if (!function_exists('form_route')) {
    /**
     * @param  string $param
     * @return string
     */
    function form_route($param = '') {
        $param = $param ? 'pixiefreakpanel_' . $param : $_GET['page'];
        echo '<input type="hidden" name="page" value="' .esc_attr($param). '">';
    }
}

// PF Sharer
if (!function_exists('pixiefreak_sharer')) {
	/**
	 * @param  string $social
	 * @param  string $link
	 * @param  string $title
	 * @return string
	 */
	function pixiefreak_sharer($social, $link, $title) {
		switch ($social) {
			case 'twitter':
				return 'https://twitter.com/share?url=' . esc_url($link) . '&text=' . esc_attr($title);
			case 'mailto':
				return 'mailto:?subject='.esc_attr($title).'&body= ' .esc_html__('Check out this post', 'pixiefreak') . esc_url($link) . '.';
			case 'facebook':
				return 'http://www.facebook.com/sharer.php?s=100&p[title]=' . esc_attr($title) . '&p[url]=' . esc_url($link) . '';
		}
	}
}


if (!function_exists('pixiefreak_my_mce_custom_styles')) {
	/**
	 * @param  mixed $init
	 * @return mixed
	 */
	function pixiefreak_my_mce_custom_styles($init) {
		$default_colours =
			'"000000", "Black",
            "993300",  "Burnt orange",
            "333300",  "Dark olive",
            "003300",  "Dark green",
            "003366",  "Dark azure",
            "000080",  "Navy Blue",
            "333399",  "Indigo",
            "333333",  "Very dark gray",
            "800000",  "Maroon",
            "FF6600",  "Orange",
            "808000",  "Olive",
            "008000",  "Green",
            "008080",  "Teal",
            "0000FF",  "Blue",
            "666699",  "Grayish blue",
            "808080",  "Gray",
            "FF0000",  "Red",
            "FF9900",  "Amber",
            "99CC00",  "Yellow green",
            "339966",  "Sea green",
            "33CCCC",  "Turquoise",
            "3366FF",  "Royal blue",
            "800080",  "Purple",
            "999999",  "Medium gray",
            "FF00FF",  "Magenta",
            "FFCC00",  "Gold",
            "FFFF00",  "Yellow",
            "00FF00",  "Lime",
            "00FFFF",  "Aqua",
            "00CCFF",  "Sky blue",
            "993366",  "Red violet",
            "FFFFFF",  "White",
            "FF99CC",  "Pink",
            "FFCC99",  "Peach",
            "FFFF99",  "Light yellow",
            "CCFFCC",  "Pale green",
            "CCFFFF",  "Pale cyan",
            "99CCFF",  "Light sky blue",
            "CC99FF",  "Plum"'
		;

		$custom_colours =  '"435665", "pixiefreak"';
		$init['textcolor_map'] = '['.$default_colours.','.$custom_colours.']';
		$init['textcolor_rows'] = 6;

		return $init;
	}
	add_filter('tiny_mce_before_init', 'pixiefreak_my_mce_custom_styles');
}
if (!function_exists('dd')) {
    /**
     * @param array ...$args
     */
    function dd($args) {
        var_dump($args); die;
    }
}

if (!function_exists('settings_checkbox')) {
    /**
     * @param  string $module
     * @param  string $key
     * @param  array  $switchText
     */
    function settings_checkbox($module, $key, array $switchText = []) {
        $settings = pixiefreak_settings($module);
        if (strpos($key, '.') !== false) {
            $accessors = explode('.', $key);
            $value = $settings->getValue(reset($accessors));
            if (is_array($value)) {
                $value = $value[$accessors[1]];
            }

            $key = str_replace('.', '[', $key) . ']';
        } else {
            $value = $settings->getValue($key);
        }

	    $resSwitch = reset($switchText);

        $yes = !empty($resSwitch) && is_string($resSwitch) ? $resSwitch : esc_html__('YES', 'pixiefreakpanel');
        $no = !empty($switchText[1]) && is_string($switchText[1]) ? $switchText[1] : esc_html__('NO', 'pixiefreakpanel');
        ?>
            <?php $settings = pixiefreak_settings($module); ?>
            <input type="hidden"   name="<?php echo $module .'_'. $key; ?>" value="0">
            <input type="checkbox" name="<?php echo $module .'_'. $key; ?>" value="<?php echo $value; ?>"
                class="<?php echo $key; ?>"
                <?php echo $settings->shouldShow($key) ? 'checked=""' : '' ?>>
            <div class="labelCheckbox <?php echo $settings->shouldShow($key) ? 'checked' : '' ?>">
                <span class="check on" data-id="<?php echo $module .'_'. $key; ?>"><?php echo $yes; ?></span>
                <span class="check off" data-id="<?php echo $module .'_'. $key; ?>"><?php echo $no; ?></span>
            </div>
        <?php
    }
}

if (!function_exists('settings_input')) {
    /**
     * @param  string $module
     * @param  string $key
     * @param  string $type
     * @param  string $icon
     * @param  string $placeholder
     */
    function settings_input($module, $key, $type = 'text', $icon = '', $placeholder = '') {
        $settings = pixiefreak_settings($module);
        if (strpos($key, '.') !== false) {
            $accessors = explode('.', $key);
            $value = $settings->getValue(reset($accessors));
            if (is_array($value)) {
                $value = $value[$accessors[1]];
            }

            $key = str_replace('.', '[', $key) . ']';
        } else {
            $value = $settings->getValue($key);
        }

        $icon = !empty($icon) ? '<i class="social-icon '.$icon.'"></i>' : '';
        $plc = !empty($placeholder) ? ' placeholder="'.$placeholder.'"' : '';

        ?>
            <?php echo $icon; ?>
            <input type="<?php echo $type; ?>"
                   name="<?php echo $module .'_'. $key; ?>"
                   value="<?php echo $value; ?>"
                    <?php echo $plc; ?>
            >
        <?php
    }
}

if (!function_exists('textarea')) {
    /**
     * @param string $text
     * @param string $name
     * @param array  $settings
     */
    function textarea($text, $name = '', array $settings = []) {
        $settings['textarea_name'] = $name;
        if (empty($settings)) {
            $settings = [
                'textarea_name' => 'pixiehuge-about-description',
                'media_buttons' => false,
                'teeny'         => true,
                'quicktags'     => [
                    'buttons' => 'strong,em,del,ul,ol,li,close'
                ]
            ];
        }

        wp_editor($text , $name, $settings);
    }
}

if (!function_exists('input')) {
    /**
     * @param string $type
     * @param string $name
     * @param string $default
     * @param string $class
     * @param string $placeholderText
     */
    function input($type = 'text', $name, $default, $class = '', $placeholderText = '') {
        $value = !empty($default) ? ' value="'.$default.'"' : '';
        $class = !empty($class) ? ' class="'.$class.'"' : '';
        $placeholder = empty($placeholderText) ? '' : ' placeholder="'. $placeholderText . '"';
        echo '<input type="'.$type.'" name="'.$name.'"'.$value . $class. $placeholder.'>';
    }
}

if (!function_exists('label')) {
    /**
     * @param string $text
     */
    function label($text = '') {
        ?>
            <label class="label-fs"><?php echo $text; ?></label>
        <?php
    }
}

if (!function_exists('submit')) {
    /**
     * @param string $route
     * @param string $label
     * @param string $appendixes
     */
    function submit($route, $label = '', $appendixes = '') {
        ?>
            <p class="submit" <?php echo !empty($appendixes) ? 'style="'.$appendixes.'"' : ''; ?>>
                <?php form_route($route); ?>
                <input type="submit"
                       name="submitBtn"
                       value="<?php echo $label ?: esc_html('SAVE CHANGES'); ?>"
                       id="submit-<?php echo $route; ?>"
                       class="button button-primary">

                <input type="hidden" name="active-tab" class="active-tab">
            </p>
        <?php
    }
}

if (!function_exists('___')) {
    /**
     * @param  string $string
     * @param  bool   $echo
     * @return mixed
     */
    function ___($string = '', $echo = false) {
        if ($echo) {
            echo esc_html__($string, 'pixiefreakpanel');
            return;
        }

        return esc_html__($string, 'pixiefreakpanel');
    }
}

if (!function_exists('has_notification')) {
    /**
     * @param  mixed $notification
     * @return bool
     */
    function has_notification($notification) {
        return (isset($notification) && !empty($notification));
    }
}

if (!function_exists('get_notification')) {
    /**
     * @return string
     */
    function get_notification() {
        return request()->has('notification') ? request()->get('notification') : '';
    }
}


if (!function_exists('notification_push_state_js')) {
    /**
     * @return string
     */
    function notification_push_state_js() {
        ?>
            <script>
                jQuery('.pushState').on('click', function() {
                    var url = document.location.href, urlParts = url.split('?');
                    if (urlParts.length >= 2) {
                        var baseUrl     = urlParts.shift(),
                            queryString = urlParts.join('?'),
                            prefix      = encodeURIComponent('notification') + '=',
                            pars = queryString.split(/[&;]/g)
                        ;

                        for (var i= pars.length; i-->0;) {
                            if (pars[i].lastIndexOf(prefix, 0) !== -1) {
                                pars.splice(i, 1);
                            }
                        }

                        window.history.pushState('', document.title, baseUrl +'?'+ pars.join('&'));
                    }
                });
            </script>
        <?php
    }
}

if (!function_exists('scripts')) {
    /**
     * @param  string $directory
     * @param  string $name
     * @return mixed
     */
    function scripts($directory, $name) {
        return include ($directory . '/../scripts/'. $name .'.phtml');
    }
}

if (!function_exists('post_slug_builder')) {
    /**
     * @param  string   $key
     * @param  string   $slug
     * @return string
     */
    function post_slug_builder($key, $slug) {
        $result = $key;

    ?>

    <a class="get-post-tag btns"
       title="<?php ___('Click here to copy tag for post which you want to show on this ' . ucfirst($key) . ' page.', true); ?>"
       data-clipboard-text="<?php echo esc_attr($slug); ?>">
        <i class="fa fa-clipboard"></i>
    </a>

    <?php
    }
}

if (!function_exists('screenshots_path')) {
    /**
     * @param  string $image
     * @return string
     */
    function screenshots_path($image) {
        return plugins_url('pixiefreakpanel/resources/assets/images/ss/' . $image);
    }
}
<?php

class PixieFreakPanel_Activator
{
	/**
	 * Short Description. (use period)
	 *
	 * Long Description.
	 *
	 * @since    1.0.0
	 */
	public static function activate()
	{
        \PixieFreakPanel\Service\DatabaseToolkit::migrate(true);
        \PixieFreakPanel\Service\DatabaseToolkit::seed();

        \PixieFreakPanel\Model\About::query()->insert([
            'cover' => '/wp-content/themes/pixiefreak/assets/img/page-hero-bg.jpg',
            'description' => 'About description.',
            'stats' => '[{"icon":"","title":"","label":""},{"icon":"","title":"","label":""},{"icon":"","title":"","label":""},{"icon":"","title":"","label":""}]'
        ]);

        \PixieFreakPanel\Model\AboutStaffCategory::query()->insert([
            'name' => 'Uncategorized'
        ]);

        \PixieFreakPanel\Model\GalleryCategory::query()->insert([
            'name' => 'Uncategorized'
        ]);
    }

	public static function get_page_title_for_slug($page_slug)
	{
		$page = get_page_by_path( $page_slug , OBJECT );

		return isset($page);
	}

	public static function pages()
    {
        foreach (get_page_templates() as $templateName => $filePath)
        {
	        if (self::get_page_title_for_slug($slug = sanitize_title(str_replace('Page', '', $templateName)))) {
	        	continue;
	        }

            $page = array(
                'post_title'    => $templateName,
                'post_content'  => '',
                'post_name'     => $slug,
                'post_status'   => 'publish',
                'post_date'     => date('Y-m-d H:i:s', strtotime("+0 min")),
                'post_author'   => get_current_user_id(),
                'post_type'     => 'page',
                'page_template' => $filePath
            );

            wp_insert_post($page);
        }
    }
}
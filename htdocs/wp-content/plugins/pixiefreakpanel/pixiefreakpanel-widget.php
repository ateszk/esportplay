<?php

class PixieFreakPanel_LatestNews_Widget extends WP_Widget
{
    /**
     * PixieFreakPanel_LatestNews_Widget constructor.
     */
	public function __construct()
    {
		parent::__construct(
            'pixiefreakpanel_latest_news_widget',
            esc_html__('PixieFreak | Latest News', 'pixiefreakpanel'), [
                'description' => esc_html__('This is your most popular news widget', 'pixiefreakpanel'),
                'classname' => 'latest-article'
            ]
		);
	}

	/**
	 * @param $args
	 * @param $instance
	 */
	public function widget($args, $instance)
    {
		$title = apply_filters('widget_title', $instance['title']);

		echo $args['before_widget'];

		if (!empty($title)) {
            echo $args['before_title'] . $title . $args['after_title'];
        }

        $posts = new WP_Query(array(
            'post_type' => 'post',
            'posts_per_page' => 5,
            'order' => 'DESC',
            'orderby' => 'date'
        ));

        echo '<ul class="post-list">';

        ?>

        <?php if ($posts->have_posts()): ?>
            <?php while ($posts->have_posts()): ?>
                <?php
                    $posts->the_post();
                    $categories = '<div class="categories">';
		            $cat = get_the_category();
                    if (!empty($cat)) {
                        foreach ($cat as $catItem) {
                            $categories .= '<a href="' . esc_url(get_category_link($catItem->term_id)) . '">' .esc_attr($catItem->name). '</a>';
                        }
                    }

                    $categories = $categories . '</div>';
                ?>
                <li>
                    <?php echo $categories; ?>
                    <a href="<?php echo esc_url(get_permalink()); ?>" class="title">
                        <?php the_title(); ?>
                    </a>
                    <span class="date">
                        <?php echo esc_html(get_the_date()); ?>
                    </span>
                </li>
            <?php endwhile; ?>
        <?php else: ?>
            <?php esc_html_e('There is no posts, yet.', 'pixiefreakpanel'); ?>
        <?php endif; ?>

        <?php

        echo '</ul>';

        echo $args['after_widget'];
	}

	/**
	 * @param $instance
	 */
	public function form( $instance )
    {
		if (isset($instance['title'])) {
			$title = $instance[ 'title' ];
		} else {
			$title = esc_html__( 'Latest News', 'pixiehugepanel' );
		}
		?>
			<p>
			<label for="<?php echo $this->get_field_id( 'title' ); ?>"><?php _e( 'Title:' ); ?></label>
			<input class="widefat" id="<?php echo $this->get_field_id( 'title' ); ?>" name="<?php echo $this->get_field_name( 'title' ); ?>" type="text" value="<?php echo esc_attr( $title ); ?>" />
			</p>
		<?php
	}

	/**
	 * @param $new_instance
	 * @param $old_instance
	 *
	 * @return array
	 */
	public function update( $new_instance, $old_instance )
    {
		$instance = array();
		$instance['title'] = ( ! empty( $new_instance['title'] ) ) ? strip_tags( $new_instance['title'] ) : '';
		return $instance;
	}
}

class PixieFreakPanel_PopularNews_Widget extends WP_Widget
{
    /**
     * PixieFreakPanelPopularNews_Widget constructor.
     */
	public function __construct()
    {
		parent::__construct(
			'pixiefreak_most_popular_news_widget',
			esc_html__('PixieFreak | Popular Articles', 'pixiefreakpanel'), [
                'description' => esc_html__('These are your latest popular articles.', 'pixiefreakpanel'),
                'classname' => 'most-popular'
            ]
		);
	}

	/**
	 * @param $args
	 * @param $instance
	 */
	public function widget($args, $instance)
    {
        $title = apply_filters('widget_title', $instance['title']);

        echo $args['before_widget'];

        if (!empty($title)) {
            echo $args['before_title'] . $title . $args['after_title'];
        }

        $posts = new WP_Query(array(
            'post_type' => 'post',
            'posts_per_page' => 2,
            'order' => 'DESC',
            'orderby' => 'comment_count'
        ));

        echo '<ul class="widget">';

        ?>

        <?php if ($posts->have_posts()): ?>
        <?php while ($posts->have_posts()): ?>
            <?php
            $posts->the_post();
            $categories = '<div class="categories">';
		    $cat = get_the_category();
            if (!empty($cat)) {
                foreach ($cat as $catItem) {
                    $categories .= '<a href="' . esc_url(get_category_link($catItem->term_id)) . '">' .esc_attr($catItem->name). '</a>';
                }
            }

            $categories = $categories . '</div>';
            ?>
            <li>
                <?php echo $categories; ?>
                <a href="<?php echo esc_url(get_permalink()); ?>" class="title">
                    <?php the_title(); ?>
                </a>
                <span class="date">
                    <?php echo esc_html(get_the_date()); ?>
                </span>
            </li>
        <?php endwhile; ?>
    <?php else: ?>
        <?php esc_html_e('There is no posts, yet.', 'pixiefreakpanel'); ?>
    <?php endif; ?>

        <?php

        echo '</ul>';

        echo $args['after_widget'];
	}

	/**
	 * @param $instance
	 */
	public function form($instance)
    {
		if (isset($instance['title'])) {
			$title = $instance['title'];
		} else {
			$title = esc_html__('Popular Articles', 'pixiefreakpanel');
		}
    ?>
			<p>
                <label for="<?php echo $this->get_field_id('title'); ?>">
                    <?php _e( 'Title:' ); ?>
                </label>

                <input class="widefat"
                       id="<?php echo $this->get_field_id('title'); ?>"
                       name="<?php echo $this->get_field_name( 'title' ); ?>"
                       type="text"
                       value="<?php echo esc_attr( $title ); ?>"
                />
            </p>
		<?php
	}

	/**
	 * @param $new_instance
	 * @param $old_instance
	 *
	 * @return array
     */
	public function update($new_instance, $old_instance)
    {
		$instance = array();
		$instance['title'] = (!empty($new_instance['title'])) ? strip_tags($new_instance['title']) : '';
		return $instance;
	}
}

add_action('widgets_init', function () {
    register_widget('PixieFreakPanel_LatestNews_Widget');
    register_widget('PixieFreakPanel_PopularNews_Widget');
});
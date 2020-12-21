<?php if (post_password_required()) { return; } ?>


<?php
    global $fullWidth;
    $class = 'comment-container';
    if(isset($fullWidth) && !empty($fullWidth)) {
        $class .= ' full-width';
    }
?>
<article class="<?php echo esc_attr($class) ?>">
	<?php if (have_comments()): ?>
        <div class="comment-headtitle">
            <h3 id="pingbacks">
				<?php
				printf( _nx( 'Hozzászólók &ldquo;%2$s&rdquo;', '%1$s hozzászólások a &ldquo;%2$s&rdquo;', get_comments_number(), 'comments title', 'pixiefreak' ),
					number_format_i18n( get_comments_number() ), get_the_title() );
				?>
            </h3>
        </div>

		<?php if (!empty($comments_by_type['pingback'])): ?>
			<ul class="pingback">
				<?php
				wp_list_comments( array(
					'type' => 'pingback',
					'short_ping'  => true,
				) );
				?>
            </ul>
		<?php endif; ?>
		<?php if (!empty($comments_by_type['trackback'])): ?>
            <ul class="pingback">
                <?php
                wp_list_comments( array(
                    'type' => 'trackback',
                    'short_ping'  => true,
                ) );
			    ?>
            </ul>
		<?php endif; ?>
        <?php if (!empty($comments_by_type['comment'])): ?>
            <ul>
            <?php wp_list_comments('type=comment&callback=pixiefreak_comment'); ?>
            </ul>
        <?php endif; ?>

        <?php if (get_comment_pages_count() > 1 && get_option('page_comments')): ?>
            <nav id="comment-nav-below" class="navigation comment-navigation" role="navigation">
                <h1 class="screen-reader-text">
					<?php esc_html_e('Hozzászólás navigálás', 'pixiefreak'); ?>
                </h1>
                <div class="nav-previous">
					<?php previous_comments_link(esc_html__('&larr; Régi hozzászólások', 'pixiefreak')); ?>
                </div>
                <div class="nav-next">
					<?php next_comments_link(esc_html__('Újabb hozzászólások &rarr;', 'pixiefreak')); ?>
                </div>
            </nav>
		<?php endif; ?>

    <?php endif; ?>

	<?php
	// If comments are closed and there are comments, let's leave a little note, shall we?
	if ( ! comments_open() && get_comments_number() && post_type_supports( get_post_type(), 'comments' ) ) :
		?>
        <p class="no-comments"><?php _e( 'Comments are closed.', 'pixiefreak' ); ?></p>
	<?php endif; ?>

    <?php if (comments_open()) : ?>
        <?php pixiefreak_comment_form(); ?>
    <?php endif; ?>
</article>
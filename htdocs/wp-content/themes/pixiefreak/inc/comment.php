<?php
    $commentId = get_comment_ID();
    $author = get_comment_author($commentId);
    $authorEmail = get_comment_author_email($commentId);
    $avatar = get_avatar_url($authorEmail);
    $commentDate = get_comment_date(get_option('date_format'), $commentId);
    $commentType = get_comment_type();
?>
<li <?php comment_class(); ?> id="li-comment-<?php comment_ID() ?>">
    <div class="the_comment">
        <figure class="comment-author-avatar">
            <img src="<?php echo esc_url($avatar); ?>"
                 alt="<?php echo esc_attr($author); ?>">
        </figure>

        <div class="comment-body">
            <div class="comment-meta">
                <a class="comment-meta-author">
				    <?php echo esc_html($author); ?>
                </a>
                &#124;
                <a class="comment-meta-date">
				    <?php echo esc_html($commentDate); ?>
                </a>
            </div>

            <div class="comment-content">
	            <?php comment_text() ?>

			    <?php if (comments_open()) : ?>
                    <ul class="comment-options">
	                    <?php comment_reply_link(array_merge( $args, array('depth' => $depth, 'before' => '<li>', 'after' => '</li>', 'reply_text' => '<i class="fas fa-reply"></i> ' . esc_html__('Válasz', 'pixiefreak'), 'max_depth' => $args['max_depth']))) ?>

                        <?php if (current_user_can('edit_posts')): ?>
                            <li>
                                <a href="<?php echo admin_url('comment.php?action=cdc&c='.$commentId); ?>">
                                    <i class="fas fa-trash"></i>
								    <?php esc_html_e('Törlés', 'pixiefreak'); ?>
                                </a>
                            </li>
                            <li>
                                <a href="<?php echo admin_url('comment.php?action=cdc&dt=spam&c='.$commentId); ?>">
                                    <i class="fas fa-ban"></i>
								    <?php esc_html_e('Blokkolás', 'pixiefreak'); ?>
                                </a>
                            </li>
					    <?php endif; ?>
                    </ul>
			    <?php endif; ?>
            </div>
        </div>
    </div>
</li>
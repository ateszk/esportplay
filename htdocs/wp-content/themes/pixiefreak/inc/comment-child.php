<?php
    $commentId = $comment->comment_ID;
    $author = get_comment_author($commentId);
    $authorEmail = get_comment_author_email($commentId);
    $avatar = get_avatar_url($authorEmail);
    $commentDate = get_comment_date('d M Y', $commentId);
?>

<li>
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
			    <?php echo esc_html__('Posted', 'pixiefreak'); ?>
                <a class="comment-meta-date">
				    <?php echo esc_html($commentDate); ?>
                </a>
            </div>

            <div class="comment-content">
                <p>
				    <?php echo esc_html(get_comment_text($commentId)); ?>
                </p>

			    <?php if (comments_open()) : ?>
                    <ul class="comment-options">
                        <li>
                            <a onClick="processCommentForm('<?php echo esc_html($author); ?>', <?php echo esc_html(get_the_ID()); ?>, <?php echo esc_html($parentId); ?>)">
                                <i class="fas fa-reply"></i>
							    <?php esc_html_e('Válasz', 'pixiefreak'); ?>
                            </a>
                        </li>
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

    <?php
        $comments = get_comments(array(
            'post_id'   => get_the_ID(),
            'status'    => 'approve',
            'order'     => 'DESC',
            'parent'    => $commentId,
        ));
    ?>

    <?php if (!empty($comments)): ?>
        <ul class="comment-child">
            <?php foreach ($comments as $comment): ?>
                <?php pixiefreak_comment_child($comment, $commentId) ?>
            <?php endforeach; ?>
        </ul>
    <?php endif; ?>
</li>
<?php /* Template Name: Gallery */ ?>
<?php
if(!pixiefreak_active()) {
	wp_redirect(get_home_url()); die();
}
?>
<?php get_header(); ?>

<?php
$settings = pixiefreak_settings('gallery');
$categories = \PixieFreakPanel\Model\GalleryCategory::query()->get();
$photos = \PixieFreakPanel\Model\Gallery::query()->get();
?>

    <section class="page-hero">
        <div class="section-title">
            <h2><?php echo esc_html($settings->get('title')); ?></h2>
            <h4><?php echo esc_html($settings->get('subtitle')); ?></h4>
        </div>
    </section>

    <section class="gallery">
        <div class="container">
            <div class="section-header border-bottom">
                <div class="section-title">
                    <h2><?php echo esc_html__('Galléria', 'pixiefreak'); ?></h2>
                </div>

				<?php if ($categories->isNotEmpty()): ?>
                    <ul>
						<?php $i=0; foreach ($categories as $category): $i++;?>
							<?php  if(!\PixieFreakPanel\Model\Gallery::query()->where('gallery_category_id', $category->id)->count()) { continue; } ?>
							<?php if ($i > 4): continue; endif; ?>
                            <li<?php echo reset($categories) === $category ? ' class="active"' : ''; ?>>
                                <a href="#cat-<?php echo esc_attr($category->id); ?>" data-toggle="tab">
									<?php echo esc_html("{$category->name}"); ?>
                                </a>
                            </li>

						<?php endforeach; ?>
						<?php if (count($categories) > 3): ?>
                            <li class="menu-item-has-children">
                                <a href="#">
									<?php esc_html_e('More', 'pixiefreak'); ?>
                                    <i class="fas fa-angle-down"></i>
                                </a>
                                <ul class="sub-menu">
									<?php foreach ($categories as $key => $category): ?>
										<?php  if(!\PixieFreakPanel\Model\Gallery::query()->where('gallery_category_id', $category->id)->count()) { continue; } ?>
										<?php if (!in_array($key, range(0, 3))): ?>
                                            <li>
                                                <a href="#cat-<?php echo esc_attr($category->id); ?>" data-toggle="tab">
													<?php echo esc_html("{$category->name}"); ?>
                                                </a>
                                            </li>
										<?php endif; ?>
									<?php endforeach; ?>
                                </ul>
                            </li>
						<?php endif; ?>
                    </ul>
				<?php endif; ?>
            </div>

            <div class="lightboxgallery-gallery gallery-images tab-content">
				<?php if ($categories->isNotEmpty()): ?>
					<?php foreach ($categories as $category): ?>
                        <div id="cat-<?php echo esc_attr($category->id); ?>" class="<?php echo reset($categories) === $category ? ' active' : ''; ?>">
							<?php if ($photos->isNotEmpty()): ?>
								<?php foreach ($photos as $photo): ?>
									<?php if ($photo->gallery_category_id == $category->id): ?>
                                        <a class="lightboxgallery-gallery-item"
                                           href="<?php echo esc_url($photo->image); ?>"
                                           style="background-image: url('<?php echo esc_attr($photo->image); ?>');">
                                            <span class="text-invisible"><?php echo esc_attr($photo->id) ?></span>
                                        </a>
									<?php endif; ?>
								<?php endforeach; ?>
							<?php endif; ?>
                        </div>
					<?php endforeach; ?>
				<?php endif; ?>
            </div>
        </div>
    </section>

<?php get_footer(); ?>
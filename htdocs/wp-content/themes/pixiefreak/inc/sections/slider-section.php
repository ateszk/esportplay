<?php
	$slides = \PixieFreakPanel\Model\Slider::query()->limit(4)->get();
?>

<?php if ($slides->isNotEmpty()): ?>
<!--HERO SLIDER-->
<div class="hero-slider owl-carousel">

	<?php foreach ($slides as $slide): ?>
	<div class="slide" data-hash="<?php echo esc_attr('head-slide-' . $slide->id) ?>" style="background-image: url('<?php echo esc_url($slide->image) ?>');">
		<div class="container">
			<!-- Slider Caption -->
			<div class="slide-caption">

				<?php if (!empty($slide->tag)): ?>
				<span><?php echo esc_attr($slide->tag) ?></span>
				<?php endif; ?>

				<?php if (!empty($slide->heading_text)): ?>
				<h1>
					<?php echo esc_attr($slide->heading_text) ?>
				</h1>
				<?php endif; ?>

				<?php if (!empty($slide->cta_text)): ?>
				<a href="<?php echo !empty($slide->cta_link) ? esc_url($slide->cta_link) : '#' ?>" class="btn-default">
					<?php echo esc_attr($slide->cta_text) ?> <i class="fas fa-arrow-right"></i>
				</a>
				<?php endif; ?>
			</div>
		</div>
	</div>
	<?php endforeach; ?>
</div>

<!-- Slider Thumbnails -->
<div class="slider-thumbnails">

	<div class="slider-progress-bar">
		<div class="progress-line" style="width: 0%;"></div>
	</div>

	<ul class="thumbnails owl-carousel">
		<?php foreach ($slides as $slide): ?>
		<li>
			<!-- Thumbnail -->
			<a href="#<?php echo esc_attr('head-slide-' . $slide->id) ?>" class="slide slide-item<?php echo (reset($slides) == $slide) ? ' active': '' ?>"
			   style="background-image: url('<?php echo esc_url($slide->thumbnail) ?>');"></a>
		</li>
		<?php endforeach; ?>
	</ul>
</div>
<!-- /Slider Thumbnails -->
<?php endif; ?>
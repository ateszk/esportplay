<!DOCTYPE html>
<html <?php language_attributes(); ?> class="no-js">
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="<?php bloginfo('description'); ?>">
	<?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>
<!-- HEADER -->
<header<?php echo pixiefreak_header_class() ?>>
    <nav class="nav-placeholder">
        <div class="container">
            <!-- Mobile Sandwich Button -->
            <button class="sandwich-btn" data-target="#mobileMenu" data-toggle="modal">
                <span></span>
                <span></span>
                <span></span>
            </button>

            <?php echo pixiefreak_custom_logo() ?>

			<?php if (pixiefreak_should_show_menu('header_menu')): ?>
				<?php wp_nav_menu([
					'theme_location' => 'header_menu',
					'menu_id' => 'header_menu',
					'menu_class' => 'navbar',
					'items_wrap' => pixiefreak_header_menu_wrap(),
					'container' => false,
					'walker' => (new pixiefreak_Menu())
				]);
				?>
			<?php endif; ?>
        </div>
    </nav>

	<?php if(pixiefreak_active() && is_home()): ?>
		<?php get_template_part('/inc/sections/slider-section'); ?>
	<?php endif; ?>
</header>
<!-- /HEADER -->

<?php /* Template Name: Bracket */ ?>
<?php
    if(!pixiefreak_active()) {
        wp_redirect(get_home_url()); die();
    }
    $slug = esc_attr(get_query_var('bracket_slug'));
    if (empty($tournament = \PixieFreakPanel\Model\Tournament::query()->where('slug', $slug)->get()->first())) {
        wp_redirect(get_home_url()); die();
    }
?>

    <?php get_header(); ?>

    <section class="page-hero">
        <div class="container">
            <h2>
		        <?php echo esc_html__('Több információ az ágrajzról!', 'pixiefreak'); ?>
            </h2>
            <h4>
                <?php echo esc_html__('Itt megtekintheted az általad kiválaszott verseny ágrajzát', 'pixiefreak'); ?>
            </h4>
            <ul class="tab-nav">
                <li>
                    <a href="<?php echo pixiefreak_route('tournament', $tournament->slug); ?>" class="btn-default active">
		                <?php echo esc_html__('Vissza a versenyoldalra', 'pixiefreak'); ?>
                    </a>
                </li>
            </ul>
        </div>
    </section>

    <section class="brackets page-bg">
        <div class="container">
            <div class="zoomInOut">
                <button class="zoomOut"><i class="fas fa-minus"></i></button>
                <button class="zoomIn"><i class="fas fa-plus"></i></button>
            </div>

            <div class="bracket-wrapper">
                <div class="panzoom-elements"></div>
            </div>
        </div>
    </section>
<?php get_footer(); ?>

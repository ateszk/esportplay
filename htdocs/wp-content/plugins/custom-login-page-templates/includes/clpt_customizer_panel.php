<?php
class CLPT_Customizer_Panel extends WP_Customize_Panel {

    public $type = 'clpt_custom_panel';

    /**
    * Outputs the structure for the customizer panel
    *
    * @since  1.0.0
    * @access public
    * @return void
    */
    protected function content_template() {
        ?>
        <li class="panel-meta customize-info accordion-section <# if ( ! data.description ) { #> cannot-expand<# } #>">
            <button class="customize-panel-back" tabindex="-1"><span class="screen-reader-text"><?php _e( 'Back' ); ?></span></button>
            <div class="accordion-section-title">
				<span class="preview-notice"><?php
                    /* translators: %s: the site/panel title in the Customizer */
                    echo sprintf( __( 'You are customizing %s' ), '<strong class="panel-title">{{ data.title }}</strong>' );
                    ?></span>
                <# if ( data.description ) { #>
                    <button class="customize-help-toggle dashicons dashicons-editor-help" tabindex="0" aria-expanded="false"><span class="screen-reader-text"><?php _e( 'Help' ); ?></span></button>
                    <# } #>
            </div>
            <# if ( data.description ) { #>
                <div class="description customize-panel-description">
                    {{{ data.description }}}
                </div>
                <# } #>
        <div class="clpt-goto-wplogin" style="border-top: 1px solid #ddd; padding: 12px;">
            <p><?php _e('In order to see what effect these changes make, please go to wp-login.php using the button bellow', 'custom-login-page-templates'); ?></p>
            <a class="button button-secondary" href="<?php echo admin_url('customize.php?autofocus[panel]=clpt_panel&url=') . wp_login_url(); ?>">wp-login.php</a>
        </div>
        </li>
        <?php
    }
}
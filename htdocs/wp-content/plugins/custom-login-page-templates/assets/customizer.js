/**
 * Theme Customizer enhancements for a better user experience.
 *
 * Contains handlers to make Theme Customizer preview reload changes asynchronously.
 */

( function( $ ) {

    /* Site title and description. */
    wp.customize( 'custom_css[clpt]', function( value ) {

        value.bind( function( to ) {
            $( '#wp-custom-css' ).text( to );
        } );
    } );


} )( jQuery );

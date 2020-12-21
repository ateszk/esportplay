( function( $ ) {
    "use strict";

    // hex to rgb
    function hexToRgb(hex) {
        // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
        var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
        hex = hex.replace(shorthandRegex, function(m, r, g, b) {
            return r + r + g + g + b + b;
        });

        var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
        return result ? {
            r: parseInt(result[1], 16),
            g: parseInt(result[2], 16),
            b: parseInt(result[3], 16)
        } : null;
    }

    // top bar color
    wp.customize( 'pixie_top_bar_color', function( value ) {
        value.bind( function( to ) {
            var currColor = $("#topbar").css("background-color");
            var newColor;

            if( to.indexOf("#") != -1) // if is hex
                newColor = hexToRgb(to).r + ", " + hexToRgb(to).g + ", " + hexToRgb(to).b;  
            else
                newColor = to.replace("rgb(","").replace(")", "");
             

            if( currColor.indexOf('a') != -1){ // if it is rgba
                var opacity = currColor.substr( currColor.lastIndexOf(',') + 1); // , 1 )
                $( '#topbar' ).css( 'background-color', "rgba(" + newColor + ", "+ opacity);

            }else{
                $( '#topbar' ).css( 'background-color', "rgb(" + newColor + ")");
            }
        });
    });

    // top bar opacity
    wp.customize( 'pixie_top_bar_opacity', function( value ) {
        value.bind( function( to ) {
            var opacity = to/100;
            var currentColor = $("#topbar").css('background-color');

            if( currentColor.indexOf('a') == -1){ // if is not rgba
                currentColor = currentColor.replace("rgb(", "").replace(")", "");
            }else{ // if is rgba
                currentColor = currentColor.replace("rgba(", "").replace(")", "");
                currentColor = currentColor.substr(0, currentColor.lastIndexOf(',') );
            }

            var newColor = 'rgba('+ currentColor + ', ' + opacity + ')';
            $('#topbar').css('background-color', newColor);
        });
    });


    // Logo
    wp.customize( 'pixie_logo_customize', function( value ) {
        value.bind(function( to ) {
            $('.change-logo-img').attr('src', to);
        });
    });

    // top bar opacity
    wp.customize( 'pixie_logo_opacity', function( value ) {
        value.bind( function( to ) {
            var opacity = to/100;
            $('#mainLogo').hover(function(){
                $(this).css('opacity', opacity);
            });
        });
    });


} )( jQuery );
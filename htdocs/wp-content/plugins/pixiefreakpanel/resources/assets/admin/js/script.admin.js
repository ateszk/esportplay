(function($){
    "use strict";
    /* Copy to field name */
    $(".form-table tr th").each(function(){
        var newText = $(this).next("td").children("p.description").html();
        if( newText != undefined)
            $(this).append('<p class="description">' + newText + '</p>');
    });

    /* Redirect */
    var redirectUrl = $('#redirectUrl').val();
    if(redirectUrl.length > 0) {
        window.location = redirectUrl;
    }
    /* Pixi Admin Pick */
    var hash = window.location.hash.substr(1);
    if( hash.length == 0)
        hash = "home";

    $(".admin-section#"+hash).fadeIn(300);
    $("li.admin-pick a[href='#"+hash+"']").parent("li.admin-pick").addClass("active");

    // Active class managment
    $(".admin-pick").on("click tap",function (e){
        // content managment
        var newSection = $(this).children("a").attr("href");
        
        history.pushState({}, '', newSection);
        e.preventDefault();

        // remove and add classes
        $(".admin-pick").removeClass('active');
        $(this).addClass("active");

        $(".admin-section").hide();
        $(newSection).fadeIn(300);
    });

    /* Pixie checkbox label */
    $(".labelCheckbox .check.off").on("click tap", function(){
        // parent labelCheckbox
        var label = $(this).parent('.labelCheckbox');
        label.removeClass('checked');
        label.prev('input').prop('checked',false).removeAttr('checked');
    });
    $(".labelCheckbox .check.on").on("click tap", function(){
        // parent labelCheckbox
        var label = $(this).parent('.labelCheckbox');
        console.log(label);
        label.addClass('checked');
        label.prev('input').prop('checked',true).attr('checked', 'checked');
    });


    /* Pixie select options */
    $(".select-holder").each(function(){
        var select = $(this).find("select");
        var selectVal = select.val();

        // list all options
        select.find("option").each(function (){
            var optionValue = $(this).val();
            var optionHtml = $(this).html();
            
            var optionClass = function(){
                if( optionValue == selectVal ) return "selected";
                return "";
            }
            $(this).parent("select").after('<span id="' +optionValue+ '" class="select-option '+optionClass()+'">' +optionHtml+ '</span>');
        });

        // enable click
        $(".select-option").on("click tap", function(){
            // set value
            var idSelected = $(this).attr("id");
            select.val(idSelected);
            
            // change classes
            $(".select-option").removeClass("selected");
            $(this).addClass("selected");

            // change elements
            $('.um-selector.active').removeClass('active');
            $('.um-'+idSelected+'-selector').addClass('active');
        });

    });



    /* VARS */
    var attr, logoImage, logoImageHome, logoImageAway, AvatarImage, gameLogo, bgImage, matchIcon, teamOne, teamTwo;
    
    /* FUNCTIONS */
 

    /* EVENTS HANDLERS */
    $("#uploadLogo").on('click tap', function(event){
        event.preventDefault();
            
        if ( logoImage ){
            logoImage.open();
            return;
        }

        logoImage = wp.media.frames.file_frame = wp.media({
            title: 'Choose logo',
            button: {
                text: 'Choose logo'
            },
            multiple: false,
        });

        // putting in hidden value
        logoImage.on('select', function(){
            attr = logoImage.state().get('selection').first().toJSON();
            $('input#previewLogo').val(attr.url);
            $('.image-preview-holder.previewLogo').html('<img class="image-preview" src="' + attr.url + '"/></div>');
        });

        logoImage.open();
    });
    $("#uploadLogoHome").on('click tap', function(event){
        event.preventDefault();
            
        if ( logoImageHome ){
            logoImageHome.open();
            return;
        }

        logoImageHome = wp.media.frames.file_frame = wp.media({
            title: 'Choose logo',
            button: {
                text: 'Choose logo'
            },
            multiple: false,
        });

        // putting in hidden value
        logoImageHome.on('select', function(){
            attr = logoImageHome.state().get('selection').first().toJSON();
            $('input#previewLogoHome').val(attr.url);
            $('.image-preview-holder.previewLogoHome').html('<img class="image-preview" src="' + attr.url + '"/></div>');
        });

        logoImageHome.open();
    });
    $("#uploadLogoAway").on('click tap', function(event){
        event.preventDefault();
            
        if ( logoImageAway ){
            logoImageAway.open();
            return;
        }

        logoImageAway = wp.media.frames.file_frame = wp.media({
            title: 'Choose logo',
            button: {
                text: 'Choose logo'
            },
            multiple: false,
        });

        // putting in hidden value
        logoImageAway.on('select', function(){
            attr = logoImageAway.state().get('selection').first().toJSON();
            $('input#previewLogoAway').val(attr.url);
            $('.image-preview-holder.previewLogoAway').html('<img class="image-preview" src="' + attr.url + '"/></div>');
        });

        logoImageAway.open();
    });
    $("#uploadAvatar").on('click tap', function(event){
        event.preventDefault();
            
        if ( AvatarImage ){
            AvatarImage.open();
            return;
        }

        AvatarImage = wp.media.frames.file_frame = wp.media({
            title: 'Choose an avatar',
            button: {
                text: 'Choose an avatar'
            },
            multiple: false,
        });

        // putting in hidden value
        AvatarImage.on('select', function(){
            attr = AvatarImage.state().get('selection').first().toJSON();
            $('input#previewAvatar').val(attr.url);
            $('.image-preview-holder.previewAvatar').html('<img class="image-preview" src="' + attr.url + '"/></div>');
        });

        AvatarImage.open();
    });
    var up_photos;
    $("#uploadPhotos").on('click tap', function(event){
        event.preventDefault();
            
        if ( up_photos ){
            up_photos.open();
            return;
        }

        up_photos = wp.media.frames.file_frame = wp.media({
            title: 'Choose images',
            button: {
                text: 'Choose images'
            },
            multiple: true,
        });

        // putting in hidden value
        up_photos.on('select', function(){
            attr = up_photos.state().get('selection');
            
            attr.map(function (attachment) {
                attachment = attachment.toJSON();
                $('.photoPreviews').append('<div class="image-preview-holder previewPhotos"><div class="img" style="background-image: url(' + attachment.url + ')"><span onclick="removeFromGallery()"></span></div><input type="hidden" name="photos[]" value="' + attachment.url + '"><span class="fa fa-close removeUPPhoto"></span></div>');
            });
            
        });

        up_photos.open();
    });
    $("#uploadGameLogo").on('click tap', function(event){
        event.preventDefault();
            
        if ( gameLogo ){
            gameLogo.open();
            return;
        }

        gameLogo = wp.media.frames.file_frame = wp.media({
            title: 'Choose a game logo',
            button: {
                text: 'Choose logo'
            },
            multiple: false,
        });

        // putting in hidden value
        gameLogo.on('select', function(){
            attr = gameLogo.state().get('selection').first().toJSON();
            $('input#previewGameLogo').val(attr.url);
            $('.image-preview-holder.previewGameLogo').html('<img class="image-preview" src="' + attr.url + '"/></div>');
        });

        gameLogo.open();
    });
    var SponsorLogo;
    $("#uploadSponsorLogo").on('click tap', function(event){
        event.preventDefault();
            
        if ( SponsorLogo ){
            SponsorLogo.open();
            return;
        }

        SponsorLogo = wp.media.frames.file_frame = wp.media({
            title: 'Choose logo',
            button: {
                text: 'Choose logo'
            },
            multiple: false,
        });

        // putting in hidden value
        SponsorLogo.on('select', function(){
            attr = SponsorLogo.state().get('selection').first().toJSON();
            $('input#previewSponsorLogo').val(attr.url);
            $('.image-preview-holder.previewSponsorLogo').html('<img class="image-preview" src="' + attr.url + '"/></div>');
        });

        SponsorLogo.open();
    });
    $("#uploadBG").on('click tap', function(event){
        event.preventDefault();

        if ( bgImage ){
            bgImage.open();
            return;
        }

        bgImage = wp.media.frames.file_frame = wp.media({
            title: 'Choose a backgroud',
            button: {
                text: 'Choose'
            },
            multiple: false,
        });

        // putting in hidden value
        bgImage.on('select', function(){
            attr = bgImage.state().get('selection').first().toJSON();
            $('input#previewBG').val(attr.url);
            $('.image-preview-holder.previewBG').html('<img class="image-preview" src="' + attr.url + '"/></div>');
        });

        bgImage.open();
    });
    $("#resetteamBG").on('click tap', function(){
        $( 'input#teamBG' ).val(''); // remove value
        $( '.team-options-form' ).submit(); // submit form
    });
    // Cover
    var teamCoverBg;
    $("#uploadTeamCover").on('click tap', function(event){
        event.preventDefault();

        if ( teamCoverBg ){
            teamCoverBg.open();
            return;
        }

        teamCoverBg = wp.media.frames.file_frame = wp.media({
            title: 'Choose a backgroud',
            button: {
                text: 'Choose'
            },
            multiple: false,
        });

        // putting in hidden value
        teamCoverBg.on('select', function(){
            attr = teamCoverBg.state().get('selection').first().toJSON();
            $('input#previewTeamCover').val(attr.url);
            $('.image-preview-holder.previewTeamCover').html('<img class="image-preview" src="' + attr.url + '"/></div>');
        });

        teamCoverBg.open();
    });
    // Map's image
    var mapImage;
    $("#uploadmapImage").on('click tap', function(event){
        event.preventDefault();

        if ( mapImage ){
            mapImage.open();
            return;
        }

        mapImage = wp.media.frames.file_frame = wp.media({
            title: 'Choose a image',
            button: {
                text: 'Choose'
            },
            multiple: false,
        });

        // putting in hidden value
        mapImage.on('select', function(){
            attr = mapImage.state().get('selection').first().toJSON();
            $('input#previewmapImage').val(attr.url);
            $('.image-preview-holder.previewmapImage').html('<img class="image-preview" src="' + attr.url + '"/></div>');
        });

        mapImage.open();
    });
    // Contact img
    var contactImg;
    $("#uploadcontactImg").on('click tap', function(event){
        event.preventDefault();

        if ( contactImg ){
            contactImg.open();
            return;
        }

        contactImg = wp.media.frames.file_frame = wp.media({
            title: 'Choose icon',
            button: {
                text: 'Choose'
            },
            multiple: false,
        });

        // putting in hidden value
        contactImg.on('select', function(){
            attr = contactImg.state().get('selection').first().toJSON();
            $('input#previewcontactImg').val(attr.url);
            $('.image-preview-holder.previewcontactImg').html('<img class="image-preview" src="' + attr.url + '"/></div>');
        });

        contactImg.open();
    });
    $("#resetTeamLogo").on('click tap', function(){
        $( 'input#TeamLogo' ).val(''); // remove value
        $( '.team-options-form' ).submit(); // submit form
    });

    // team logo
    var teamLogo;
    $("#uploadteamLogo").on('click tap',
        function(event){
            event.preventDefault();

            if ( teamLogo ){
                teamLogo.open();
                return;
            }

            teamLogo = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            teamLogo.on('select', function(){
                attr = teamLogo.state().get('selection').first().toJSON();
                $('input#teamLogo').val(attr.url);
                $('#resetteamLogo').fadeIn(300);
                $('.image-preview-holder.teamLogo').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            teamLogo.open();
        });

    // team thumbnail
    var teamThumbnail;
    $("#uploadteamThumbnail").on('click tap',
        function(event){
            event.preventDefault();

            if ( teamThumbnail ){
                teamThumbnail.open();
                return;
            }

            teamThumbnail = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            teamThumbnail.on('select', function(){
                attr = teamThumbnail.state().get('selection').first().toJSON();
                $('input#teamThumbnail').val(attr.url);
                $('#resetteamThumbnail').fadeIn(300);
                $('.image-preview-holder.teamThumbnail').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

        teamThumbnail.open();
    });
    // Icon
    $("#resetIcon").on('click tap', function(){
        $( 'input#previewIcon' ).val(''); // remove value
        $('.image-preview-holder.previewIcon').html('');
    });

    // team bg
    var teamBG;
    $("#uploadteamBG").on('click tap', 
        function(event){
            event.preventDefault();
            
            if ( teamBG ){
                teamBG.open();
                return;
            }

            teamBG = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            teamBG.on('select', function(){
                attr = teamBG.state().get('selection').first().toJSON();
                $('input#teamBG').val(attr.url);
                $('#resetteamBG').fadeIn(300);    
                $('.image-preview-holder.previewteamBG').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            teamBG.open();
        });
    // Icon
    $("#resetIcon").on('click tap', function(){
        $( 'input#previewIcon' ).val(''); // remove value
        $('.image-preview-holder.previewIcon').html('');
    });
    var iconMini;
    $("#uploadIcon").on('click tap', 
        function(event){
            event.preventDefault();
            
            if ( iconMini ){
                iconMini.open();
                return;
            }

            iconMini = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            iconMini.on('select', function(){
                attr = iconMini.state().get('selection').first().toJSON();
                $('input#previewIcon').val(attr.url);
                $('#resetIcon').fadeIn(300);    
                $('.image-preview-holder.previewIcon').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            iconMini.open();
        });
    // Ad space
    var adImage;
    $("#resetAdImage").on('click tap', function(){
        $( 'input#adImage' ).val(''); // remove value
        $( '.sponsor-options-form' ).submit(); // submit form
    });

    $("#uploadAd").on('click tap', 
        function(event){
            event.preventDefault();
            
            if ( adImage ){
                adImage.open();
                return;
            }

            adImage = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            adImage.on('select', function(){
                attr = adImage.state().get('selection').first().toJSON();
                $('input#adImage').val(attr.url);
                $('#resetAdImage').fadeIn(300);    
                $('.image-preview-holder.adImage').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            adImage.open();
        });
    // Match Background
    var MatchBG;
    $("#resetMatchBG").on('click tap', function(){
        $( 'input#MatchBG' ).val(''); // remove value
        $( '.match-options-form' ).submit(); // submit form
    });

    $("#uploadMatchBG").on('click tap', 
        function(event){
            event.preventDefault();
            
            if ( MatchBG ){
                MatchBG.open();
                return;
            }

            MatchBG = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            MatchBG.on('select', function(){
                attr = MatchBG.state().get('selection').first().toJSON();
                $('input#MatchBG').val(attr.url);
                $('#resetMatchBG').fadeIn(300);    
                $('.image-preview-holder.MatchBG').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            MatchBG.open();
        });
        
    // Gallery Background
    var galleryBG;
    $("#resetgalleryBG").on('click tap', function(){
        $( 'input#galleryBG' ).val(''); // remove value
        $( '.gallery-options-form' ).submit(); // submit form
    });

    $("#uploadgalleryBG").on('click tap', 
        function(event){
            event.preventDefault();
            
            if ( galleryBG ){
                    galleryBG.open();
                return;
            }

                galleryBG = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
                galleryBG.on('select', function(){
                attr = galleryBG.state().get('selection').first().toJSON();
                $('input#galleryBG').val(attr.url);
                $('#resetgalleryBG').fadeIn(300);    
                $('.image-preview-holder.galleryBG').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

                galleryBG.open();
        });
    // About Background
    var aboutBG;
    $("#resetaboutBG").on('click tap', function(){
        $( 'input#aboutBG' ).val(''); // remove value
        $( '.about-options-form' ).submit(); // submit form
    });

    $("#uploadaboutBG").on('click tap', 
        function(event){
            event.preventDefault();
            
            if ( aboutBG ){
                aboutBG.open();
                return;
            }

            aboutBG = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            aboutBG.on('select', function(){
                attr = aboutBG.state().get('selection').first().toJSON();
                $('input#aboutBG').val(attr.url);
                $('#resetaboutBG').fadeIn(300);    
                $('.image-preview-holder.aboutBG').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            aboutBG.open();
        });
    var aboutFooterBG;
    $("#resetaboutFooterBG").on('click tap', function(){
        $( 'input#aboutFooterBG' ).val(''); // remove value
        $( '.about-options-form' ).submit(); // submit form
    });

    $("#uploadaboutFooterBG").on('click tap', 
        function(event){
            event.preventDefault();
            
            if ( aboutFooterBG ){
                aboutFooterBG.open();
                return;
            }

            aboutFooterBG = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            aboutFooterBG.on('select', function(){
                attr = aboutFooterBG.state().get('selection').first().toJSON();
                $('input#aboutFooterBG').val(attr.url);
                $('#resetaboutFooterBG').fadeIn(300);    
                $('.image-preview-holder.aboutFooterBG').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            aboutFooterBG.open();
        });
    // Header Background
    var HeaderBG;
    $("#resetHeaderBG").on('click tap', function(){
        $( 'input#HeaderBG' ).val(''); // remove value
        $( '.header-options-form' ).submit(); // submit form
    });

    $("#uploadHeaderBG").on('click tap', 
        function(event){
            event.preventDefault();
            
            if ( HeaderBG ){
                HeaderBG.open();
                return;
            }

            HeaderBG = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            HeaderBG.on('select', function(){
                attr = HeaderBG.state().get('selection').first().toJSON();
                $('input#HeaderBG').val(attr.url);
                $('#resetHeaderBG').fadeIn(300);    
                $('.image-preview-holder.HeaderBG').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            HeaderBG.open();
        });

    // Twitter Background
    var TwitterBG;
    $("#resetTwitterBG").on('click tap', function(){
        $( 'input#TwitterBG' ).val(''); // remove value
        $( '.header-options-form' ).submit(); // submit form
    });

    $("#uploadTwitterBG").on('click tap',
        function(event){
            event.preventDefault();

            if ( TwitterBG ){
                TwitterBG.open();
                return;
            }

            TwitterBG = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            TwitterBG.on('select', function(){
                attr = TwitterBG.state().get('selection').first().toJSON();
                $('input#TwitterBG').val(attr.url);
                $('#resetTwitterBG').fadeIn(300);
                $('.image-preview-holder.TwitterBG').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            TwitterBG.open();
        });
    // Role Icon
    var roleBg;
    $("#resetroleBg").on('click tap', function(){
        $( 'input#roleBg' ).val(''); // remove value
        $( '.header-options-form' ).submit(); // submit form
    });

    $("#uploadroleBg").on('click tap',
        function(event){
            event.preventDefault();

            if ( roleBg ){
                roleBg.open();
                return;
            }

            roleBg = wp.media.frames.file_frame = wp.media({
                title: 'Choose a icon',
                button: {
                    text: 'Choose icon'
                },
                multiple: false,
            });

            // putting in hidden value
            roleBg.on('select', function(){
                attr = roleBg.state().get('selection').first().toJSON();
                $('input#roleBg').val(attr.url);
                $('#resetroleBg').fadeIn(300);
                $('.image-preview-holder.roleBg').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            roleBg.open();
        });
    // Player's Cover
    var playerCover;
    $("#resetplayerCover").on('click tap', function(){
        $( 'input#playerCover' ).val(''); // remove value
        $( '.header-options-form' ).submit(); // submit form
    });

    $("#uploadplayerCover").on('click tap',
        function(event){
            event.preventDefault();

            if ( playerCover ){
                playerCover.open();
                return;
            }

            playerCover = wp.media.frames.file_frame = wp.media({
                title: 'Choose a cover',
                button: {
                    text: 'Choose cover'
                },
                multiple: false,
            });

            // putting in hidden value
            playerCover.on('select', function(){
                attr = playerCover.state().get('selection').first().toJSON();
                $('input#playerCover').val(attr.url);
                $('#resetplayerCover').fadeIn(300);
                $('.image-preview-holder.playerCover').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            playerCover.open();
        });


    // Footer Background
    var FooterBG;
    $("#resetFooterBG").on('click tap', function(){
        $( 'input#FooterBG' ).val(''); // remove value
        $( '.footer-options-form' ).submit(); // submit form
    });

    $("#uploadFooterBG").on('click tap', 
        function(event){
            event.preventDefault();
            
            if ( FooterBG ){
                FooterBG.open();
                return;
            }

            FooterBG = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            FooterBG.on('select', function(){
                attr = FooterBG.state().get('selection').first().toJSON();
                $('input#FooterBG').val(attr.url);
                $('#resetFooterBG').fadeIn(300);    
                $('.image-preview-holder.FooterBG').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            FooterBG.open();
        });
    // Sponsor Background
    var sponsorBackground;
    $("#resetsponsorBackground").on('click tap', function(){
        $( 'input#sponsorBackground' ).val(''); // remove value
        $( '.sponsor-options-form' ).submit(); // submit form
    });

    $("#uploadsponsorBackground").on('click tap', 
        function(event){
            event.preventDefault();
            
            if ( sponsorBackground ){
                sponsorBackground.open();
                return;
            }

            sponsorBackground = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            sponsorBackground.on('select', function(){
                attr = sponsorBackground.state().get('selection').first().toJSON();
                $('input#sponsorBackground').val(attr.url);
                $('#resetsponsorBackground').fadeIn(300);    
                $('.image-preview-holder.sponsorBackground').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            sponsorBackground.open();
        });
    // Sponsor Background
    var sponsorCustomBackground;
    $("#resetsponsorCustomBackground").on('click tap', function(){
        $( 'input#sponsorCustomBackground' ).val(''); // remove value
        $( '.sponsor-options-form' ).submit(); // submit form
    });

    $("#uploadsponsorCustomBackground").on('click tap',
        function(event){
            event.preventDefault();

            if ( sponsorCustomBackground ){
                sponsorCustomBackground.open();
                return;
            }

            sponsorCustomBackground = wp.media.frames.file_frame = wp.media({
                title: 'Choose a image',
                button: {
                    text: 'Choose image'
                },
                multiple: false,
            });

            // putting in hidden value
            sponsorCustomBackground.on('select', function(){
                attr = sponsorCustomBackground.state().get('selection').first().toJSON();
                $('input#sponsorCustomBackground').val(attr.url);
                $('#resetsponsorCustomBackground').fadeIn(300);
                $('.image-preview-holder.sponsorCustomBackground').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            sponsorCustomBackground.open();
        });


    // upload team's icons for upcoming match
    $("#umTeamOne").on('click tap', 
        function(e){
            e.preventDefault();
            
            if ( teamOne ){
                teamOne.open();
                return;
            }

            teamOne = wp.media.frames.file_frame = wp.media({
                title: 'Choose an Team Icon 1',
                button: {
                    text: 'Choose Icon'
                },
                multiple: false,
            });
            
            // putting in hidden value
            teamOne.on('select', function(){
                attr = teamOne.state().get('selection').first().toJSON();
                $('input#umImgTeamOne').val(attr.url);
                $("#umTeamOne").hide();
                $("#resetTeamOne").fadeIn(300);
                $('.image-preview-icon#team1').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });
            
            teamOne.open();
        });
    $("#umTeamTwo").on('click tap', 
        function(e){
            e.preventDefault();
            
            if ( teamTwo ){
                teamTwo.open();
                return;
            }

            teamTwo = wp.media.frames.file_frame = wp.media({
                title: 'Choose an Team Icon 2',
                button: {
                    text: 'Choose Icon'
                },
                multiple: false,
            });
            
            // putting in hidden value
            teamTwo.on('select', function(){
                attr = teamTwo.state().get('selection').first().toJSON();
                $('input#umImgTeamTwo').val(attr.url);
                $("#umTeamTwo").hide();
                $("#resetTeamTwo").fadeIn(300);
                $('.image-preview-icon#team2').html('<img class="image-preview" src="' + attr.url + '"/></div>');
            });

            teamTwo.open();
        });

    // reset team icons
    $("#resetIcon").on('click tap',
        function(){
            $( 'input#umIcon' ).val(''); // remove value
            $( '.header-options-form' ).submit(); // submit form
            return;
        });
    $("#resetTeamOne").on('click tap',
        function(){
            $( 'input#umImgTeamOne' ).val(''); // remove value
            $( '.header-options-form' ).submit(); // submit form
            return;
        });
    $("#resetTeamTwo").on('click tap',
        function(){
            $( 'input#umImgTeamTwo' ).val(''); // remove value
            $( '.header-options-form' ).submit(); // submit form
            return;
        });  


    // font awesome 
    // find font in list
    
    $('input.fontawesome')
    .on('keyup keydown change',function(){ // on type
        var needle = $(this).val(); // current value
        var items = $(this).next().children('li'); // list of all fonts
        var finded = $(this).next().children("li:contains('"+ needle +"')"); // list of containing fonts
        
        items.removeClass('show'); // hide all fonts
        if( needle.length > 2 || finded.length < 30 ) // if there is fewer than 30 result
            finded.addClass('show'); // show only matching one

    })
    .next().children('li').on('click', function(event){ // click on list of icons
        var fontClass = $(this).children('span.font-name').html(); // pick clicked font
        
        // put the selected font in input
        $(this).parent('.fontawesome').prev('input').val(fontClass);
        // display on demo icon
        $(this).parent('.fontawesome').prev('input').prev("#show-icon").attr('class', 'fa '+fontClass);
        // hide all fonts
        $('.fontawesome li').removeClass('show');
        // stop event if it's clicked outside
        event.stopPropagation();

    });
    $(window).click(function() {
        //Hide the menus if list items
        $('.fontawesome li').removeClass('show');
    });


    // Export settings on click
    $("#export-setting").on("click focus", function(){
        $(this).select();
    });

    $("input.datepicker").datetimepicker({
        step: 5,
        format: 'd M Y H:i'
    });

})(jQuery);

jQuery(document).on('click tap', '.removeUPPhoto', function (e) {

    $(this).parent().remove();
});
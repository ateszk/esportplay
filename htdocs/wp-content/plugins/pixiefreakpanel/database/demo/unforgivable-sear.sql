

CREATE TABLE `wp_pixiefreak_about` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cover` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `banner` varchar(500) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `stats` text COLLATE utf8mb4_unicode_520_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_about VALUES
("1","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/8.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_about.jpg","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibusde marum","[{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/founded-icon.png\",\"title\":\"FOUNDED\",\"label\":\"2013\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/earnings-icon.png\",\"title\":\"EARNINGS\",\"label\":\"$25m\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/teams-icon.png\",\"title\":\"TEAMS\",\"label\":\"34\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/tournamenrts-icon.png\",\"title\":\"TROPHIES\",\"label\":\"78\"}]","2018-10-22 11:54:38");

CREATE TABLE `wp_pixiefreak_about_staff` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `role` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `socials` text COLLATE utf8mb4_unicode_520_ci,
  `avatar` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `staff_category_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_about_staff VALUES
("1","moma@freak.com","Momcilo Jasikovac","Senior Journalist","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"linkedin\":\"https://pixiesquad.com/\"}","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/moma.png","1","2018-10-22 13:53:34"),
("2","wick@freak.com","Boris Wick","CEO","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"linkedin\":\"https://pixiesquad.com/\"}","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/wick.png","1","2018-10-22 14:05:12"),
("3","stameni@freak.com","Stamenix Dan","Senior artist","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"linkedin\":\"https://pixiesquad.com/\"}","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/stamenix.png","1","2018-10-22 14:13:38"),
("4","djole@freak.com","Djole Djuza","Senior QR","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"linkedin\":\"https://pixiesquad.com/\"}","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/djuza.png","1","2018-10-22 14:15:06"),
("5","alex@freak.com","Alexy Dev","CCO","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\",\"linkedin\":\"https://www.pixiesquad.com/\"}","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/alex.png","1","2018-10-22 14:16:00"),
("6","misa@freak.com","Misa Second","Twin","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\",\"linkedin\":\"https://www.pixiesquad.com/\"}","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/moma.png","1","2018-10-22 14:18:03"),
("7","danijel@freak.com","Danijel Mix2","Product Designer","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\",\"linkedin\":\"https://www.pixiesquad.com/\"}","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/stamenix.png","2","2018-10-22 14:18:51"),
("8","wicked@freak.com","Boris Wick","Senior Artist","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\",\"linkedin\":\"https://www.pixiesquad.com/\"}","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/wick.png","2","2018-10-22 14:19:29"),
("9","alex@freak.com","Aleksandar Dev","Web Developer","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\",\"linkedin\":\"https://www.pixiesquad.com/\"}","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/alex.png","2","2018-10-22 14:20:07"),
("10","djox@gmail.com","Mini Djole","Dev Ops","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\",\"linkedin\":\"https://www.pixiesquad.com/\"}","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/djuza.png","3","2018-10-22 14:20:50");

CREATE TABLE `wp_pixiefreak_about_staff_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_about_staff_category VALUES
("1","JOURNALISTS","2018-10-22 11:54:38"),
("2","ANALYTICS","2018-10-22 13:52:08"),
("3","MANAGEMENT","2018-10-22 13:52:17");

CREATE TABLE `wp_pixiefreak_achievement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `title` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `thumbnail` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_achievement VALUES
("2","Achievement01","Achievement01","achievement01","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/achievement_01.png","0","2018-10-22 17:48:29"),
("3","Achievement02","Achievement02","achievement02","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/achievement_02.png","0","2018-10-22 17:48:36"),
("4","Achievement03","Achievement03","achievement03","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/achievement_03.png","0","2018-10-22 17:48:45");

CREATE TABLE `wp_pixiefreak_gallery` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_category_id` int(11) DEFAULT '1',
  `image` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_gallery VALUES
("1","3","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0223.jpg",NULL,"0","2018-10-24 10:09:47"),
("2","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0b.jpg",NULL,"0","2018-10-24 15:20:52"),
("3","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0aa.jpg",NULL,"0","2018-10-24 15:21:14"),
("4","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0223.jpg",NULL,"0","2018-10-24 15:21:29"),
("5","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0223a.jpg",NULL,"0","2018-10-24 15:21:47"),
("6","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0az.jpg",NULL,"0","2018-10-24 15:24:10"),
("7","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0b.jpg",NULL,"0","2018-10-24 15:24:26");

CREATE TABLE `wp_pixiefreak_gallery_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_gallery_category VALUES
("1","Uncategorized",NULL,"2018-10-22 11:54:38"),
("2","IMAGES",NULL,"2018-10-24 10:03:21"),
("3","FUN",NULL,"2018-10-24 10:04:04"),
("4","PARTY",NULL,"2018-10-24 10:04:13");

CREATE TABLE `wp_pixiefreak_game` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `thumbnail` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cover` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_game VALUES
("1","Fortnite",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/test.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/match-page.jpg","2018-10-22 14:28:43"),
("2","Call of Duty WW2",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/ww2logo.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/match-page.jpg","2018-10-22 14:33:53"),
("3","FIFA 2018",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/fifa_logo.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/match-page.jpg","2018-10-22 14:34:05"),
("4","Counter-Strike: Global Offensive",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/csgo_logo.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/match-page.jpg","2018-10-22 14:34:25");

CREATE TABLE `wp_pixiefreak_gear` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `image` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `link` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `recommended` int(11) DEFAULT NULL,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_gear VALUES
("1","LOGITECH H9189","0","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1-a.png","http://pixiesquad.com","1","0","2018-10-22 16:54:45"),
("2","LOGITECH H9189","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3a.png","https://pixiesquad.com/","1","0","2018-10-22 16:55:16"),
("3","LOGITECH H9189","2","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3a.png","https://pixiesquad.com/","1","0","2018-10-22 16:55:42");

CREATE TABLE `wp_pixiefreak_global_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_520_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_global_settings VALUES
("1","general","social","{\"facebook\":\"https://www.facebook.com/PixieSquad/\",\"twitter\":\"https://twitter.com/ThePixieSquad\",\"twitch\":\"https://www.twitch.tv/pixiesquad\",\"discord\":\"https://discord.gg/6njhTNg\",\"youtube\":\"https://www.youtube.com/channel/UCOgbPXMkH0IpL-co4X6T1Qg?&ab_channel=PixieSquad\",\"instagram\":\"https://www.instagram.com/ragebite\",\"steam\":\"https://steamcommunity.com/id/pixiesquad\"}","2018-10-22 11:54:38"),
("2","general","copyright","Powered by Pixiesquad 2013-2018 All Rights Reserved.","2018-10-22 11:54:38"),
("3","general","show_socials_header","1","2018-10-22 11:54:38"),
("4","general","show_socials_footer","1","2018-10-22 11:54:38"),
("5","general","show_search","1","2018-10-22 11:54:38"),
("6","general","show_copyright","1","2018-10-22 11:54:38"),
("7","general","section_order","{\"1\":\"News\",\"2\":\"Team\",\"3\":\"Stream\",\"4\":\"Tournament\",\"5\":\"Shop\",\"6\":\"Match Result\"}","2018-10-22 11:54:38"),
("8","general","section_visibility","{\"sponsor\":true,\"news\":true,\"team\":true,\"stream\":true,\"tournament\":true,\"shop\":true,\"shop\":false,\"match-result\":true}","2018-10-22 11:54:38"),
("9","general","get_in_touch_1","{\"icon\":\"fas fa-edit\",\"title\":\"Press department\",\"subtitle\":\"press@pixiefusion.com\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("10","general","get_in_touch_2","{\"icon\":\"fas fa-bookmark\",\"title\":\"Sponsorships\",\"subtitle\":\"press@pixiefusion.com\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("11","general","get_in_touch_3","{\"icon\":\"fab fa-hotjar\",\"title\":\"Marketing\",\"subtitle\":\"press@pixiefusion.com\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("12","general","get_in_touch_4","{\"icon\":\"fas fa-bell\",\"title\":\"Media\",\"subtitle\":\"press@pixiefusion.com\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("13","about","who_we_are","WHO WE ARE","2018-10-22 11:54:38"),
("14","about","some_more","Learn more information about the organization","2018-10-22 11:54:38"),
("15","about","media_kit","{\"text\":\"Media kit\",\"link\":\"#\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("16","about","all_teams","{\"text\":\"All Teams\",\"link\":\"#\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("17","about","about_first","{\"icon\":\"fas fa-map-marker-alt\",\"title\":\"Belgrade, Serbia\",\"subtitle\":\"Kielbasnicza 6/3, 50-108\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("18","about","about_second","{\"icon\":\"fas fa-map-marker-alt\",\"title\":\"Warsaw (HQ)\",\"subtitle\":\"Finlandzka 10, 03-903\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("19","about","about_third","{\"icon\":\"fas fa-map-marker-alt\",\"title\":\"Atlanta\",\"subtitle\":\"3423 Piedmont Rd NE, GA 30305\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("20","about","about_fourth","{\"icon\":\"fas fa-map-marker-alt\",\"title\":\"Poznan\",\"subtitle\":\"Kielbasnicza 6/3, 50-108\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("21","sponsor","banner_image","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg","2018-10-22 11:54:38"),
("22","sponsor","title","Sponsors & Partners","2018-10-22 11:54:38"),
("23","sponsor","subtitle","They support our organization","2018-10-22 11:54:38"),
("24","sponsor","show_title","1","2018-10-22 11:54:38"),
("25","sponsor","show_subtitle","1","2018-10-22 11:54:38"),
("26","sponsor","cta","{\"text\":\"Become a sponsor\",\"link\":\"https://www.pixiesquad.com/\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("27","gear","cta","{\"text\":\"Become a player\",\"link\":\"#\",\"show\":true}","2018-10-22 11:54:38"),
("28","stream","banner_image","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/5.jpg","2018-10-22 11:54:38"),
("29","stream","api","{\"youtube\":\"AIzaSyAxayP_9dvJiFLUWh9tAqmQamA_A5dp460\",\"twitch\":\"tbw3tkm7nanmocbga94p30rbv230ad\",\"mixer\":\"\"}","2018-10-22 11:54:38"),
("30","gallery","banner_image","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/01.jpg","2018-10-22 11:54:38"),
("31","gallery","title","See our events in pictures","2018-10-22 11:54:38"),
("32","gallery","subtitle","And stay updated with the atmosphere ","2018-10-22 11:54:38"),
("33","team","team_banner_image","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_02.png","2018-10-22 11:54:38"),
("34","team","roster_title","Meet the Roster","2018-10-22 11:54:38"),
("35","team","roster_subtitle","Our roster our pride all on one place","2018-10-22 11:54:38"),
("36","team","cta","{\"text\":\"Become a player\",\"link\":\"http://pixiesquad.com\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("37","teams","teams_banner_image","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg","2018-10-22 11:54:38"),
("38","teams","title","Welcome to our Teams","2018-10-22 11:54:38"),
("39","teams","subtitle","Here you can find all of the teams that we have","2018-10-22 11:54:38"),
("40","teams","cta_left","{\"text\":\"All\",\"link\":\"#\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("41","teams","cta_right","{\"text\":\"Popular\",\"link\":\"#\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("42","player","cta_player","{\"text\":\"Become a sponsor\",\"link\":\"#\",\"icon\":\"\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("43","routes","routes","{\"match\":{\"query\":\"match_slug\",\"route\":\"match\"},\"player\":{\"query\":\"player_slug\",\"route\":\"player\"},\"team\":{\"query\":\"team_slug\",\"route\":\"team\"},\"tournament\":{\"query\":\"tournament_slug\",\"route\":\"tournament\"},\"stream\":{\"query\":\"stream_slug\",\"route\":\"stream\"},\"bracket\":{\"query\":\"bracket_slug\",\"route\":\"bracket\"}}","2018-10-22 11:54:38"),
("44","tournament","tournament_banner_image","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/background-copy-1.jpg","2018-10-22 11:54:38"),
("45","tournament","title","Our tournaments","2018-10-22 11:54:38"),
("46","tournament","subtitle","This is where you can browse through our tournaments","2018-10-22 11:54:38"),
("47","tournament","cta_top","{\"text\":\"a\",\"link\":\"#\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("48","tournament","cta_left","{\"text\":\"REGISTER\",\"link\":\"http://pixiesquad.com\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("49","tournament","cta_right","{\"text\":\"PLACE TO STAY\",\"link\":\"http://pixiesquad.com\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("50","tournaments","banner_image","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg","2018-10-22 11:54:38"),
("51","tournaments","title","Our tournaments","2018-10-22 11:54:38"),
("52","tournaments","subtitle","This is where you can browse through our tournaments","2018-10-22 11:54:38"),
("53","tournaments","cta_left","{\"text\":\"Upcoming\",\"link\":\"#\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("54","tournaments","cta_right","{\"text\":\"Results\",\"link\":\"#\",\"show\":\"1\"}","2018-10-22 11:54:38"),
("55","match","title","Latest Matches & Results","2018-10-22 11:54:38"),
("56","match","subtitle","This is live update of matches our teams playing right now","2018-10-22 11:54:38"),
("57","match","cta_left","{\"text\":\"Upcoming\",\"link\":\"#\",\"show\":\"0\"}","2018-10-22 11:54:38"),
("58","match","cta_right","{\"text\":\"Results\",\"link\":\"#\",\"show\":\"0\"}","2018-10-22 11:54:38"),
("59","match","cta_match","{\"text\":\"Article\",\"link\":\"#\",\"show\":true}","2018-10-22 11:54:38"),
("60","match","banner_image","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/8.jpg","2018-10-22 11:54:38"),
("61","general","default_background","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/5.jpg","2018-10-26 10:31:07"),
("62","general","notfound_background","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/1.jpg","2018-10-26 10:31:07");

CREATE TABLE `wp_pixiefreak_match` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `game_id` int(11) NOT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tournament_id` int(11) DEFAULT '0',
  `team_a_id` int(11) DEFAULT NULL,
  `team_a_name` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `team_a_logo` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `team_a_result` int(11) DEFAULT NULL,
  `team_b_id` int(11) DEFAULT NULL,
  `team_b_name` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `team_b_logo` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `team_b_result` int(11) DEFAULT NULL,
  `status` int(2) DEFAULT NULL,
  `cta_match_text` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cta_match_link` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `stream_id` int(11) DEFAULT NULL,
  `type` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_match VALUES
("1","1","team-flawed-a","2018-10-03 14:57:57","1","1","Team Flawed Bot","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_01.png","3","4","Fnatic eSports","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_02.png","2","3",NULL,NULL,"1","2","2018-10-23 12:58:24"),
("2","2","fortuna-esports-gambit-gaming-3","2018-10-02 17:30:43","1","6","Fortuna eSports","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_05.png","3","5","Gambit Gaming","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_06.png","2","3",NULL,NULL,"1","2","2018-10-23 15:31:02"),
("3","3","fnatic-esports-wings-gaming-3","2018-10-03 17:38:26","1","4","Fnatic eSports","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_02.png",NULL,"2","Wings Gaming","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_03.png",NULL,"1",NULL,NULL,"3","2","2018-10-23 15:39:32"),
("4","1","team-flawed-fortuna-esports-4","2018-10-02 17:43:54","1","1","Team Flawed Bot","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_01.png",NULL,"6","Fortuna eSports","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_05.png",NULL,"1",NULL,NULL,"2","2","2018-10-23 15:44:23"),
("5","1","gambit-gaming-fnatic-esports-5","2018-10-02 17:50:54","1","5","Gambit Gaming","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_06.png","1","4","Fnatic eSports","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_02.png","3","3",NULL,NULL,"1","2","2018-10-23 15:51:14"),
("6","1","invictus-gaming-fnatic-esports-6","2018-10-02 17:54:00","1","3","Invictus Gaming","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_04.png",NULL,"4","Fnatic eSports","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_02.png",NULL,"1",NULL,NULL,"2","2","2018-10-23 15:54:26");

CREATE TABLE `wp_pixiefreak_player` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `last_name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `nickname` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `team_id` int(11) NOT NULL,
  `avatar` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `avatar_transparent` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `banner` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `thumbnail` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cover` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `stats` text COLLATE utf8mb4_unicode_520_ci,
  `biography` text COLLATE utf8mb4_unicode_520_ci,
  `country` varchar(15) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `birth_date` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '0',
  `social` text COLLATE utf8mb4_unicode_520_ci,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_player VALUES
("1","Zenim","Deniro","Ultramenix","RIFFLER","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/wick.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_player.jpg","ultramenix",NULL,"http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg","[{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1.png\",\"title\":\"Deaths\",\"label\":\"723\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4.png\",\"title\":\"KILLS\",\"label\":\"234\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3.png\",\"title\":\"ROFFILE\",\"label\":\"354\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2.png\",\"title\":\"HEADSHOTS\",\"label\":\"689\"}]","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","PT","23","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"discord\":\"https://www.pixiesquad.com/\",\"steam\":\"https://www.pixiesquad.com/\",\"twitch\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\"}","0","2018-10-22 14:42:26"),
("2","Daniel ","Master","Stamenix","Sniper","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/player_852.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/stamenix.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_player.jpg","stamenix",NULL,"http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/8.jpg","[{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4.png\",\"title\":\"DEATHS\",\"label\":\"234\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2.png\",\"title\":\"KILLS\",\"label\":\"900\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3.png\",\"title\":\"RIFFLE\",\"label\":\"139\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1.png\",\"title\":\"HEADSHOTS\",\"label\":\"740\"}]","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","GR","23","{\"facebook\":\"http://pixiesquad.com\",\"instagram\":\"http://pixiesquad.com\",\"discord\":\"http://pixiesquad.com\",\"steam\":\"http://pixiesquad.com\",\"twitch\":\"http://pixiesquad.com\",\"twitter\":\"http://pixiesquad.com\"}","0","2018-10-22 17:36:34"),
("3","Djordje","Djuza","George","Captain","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/player_89.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/djuza.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_player.jpg","george",NULL,"http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/8.jpg","[{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4.png\",\"title\":\"DEATHS\",\"label\":\"900\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3.png\",\"title\":\"KILLS\",\"label\":\"231\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1.png\",\"title\":\"HEADSHOTS\",\"label\":\"450\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2.png\",\"title\":\"SNIPERS\",\"label\":\"300\"}]","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","AM","23","{\"facebook\":\"http://pixiesquad.com\",\"instagram\":\"http://pixiesquad.com\",\"discord\":\"http://pixiesquad.com\",\"steam\":\"http://pixiesquad.com\",\"twitch\":\"http://pixiesquad.com\",\"twitter\":\"http://pixiesquad.com\"}","0","2018-10-23 12:19:57"),
("4","Master","Mind","m89s","SNIPER","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/player_9111.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/moma.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_player.jpg","m89s",NULL,"http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/1.jpg","[{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4.png\",\"title\":\"DEATHS\",\"label\":\"234\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2.png\",\"title\":\"KILLS\",\"label\":\"900\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1.png\",\"title\":\"HEAD SHOTS\",\"label\":\"456\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3.png\",\"title\":\"RIFFLE\",\"label\":\"34\"}]","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.\n\n","FR","32","{\"facebook\":\"http://pixiesquad.com\",\"instagram\":\"http://pixiesquad.com\",\"discord\":\"http://pixiesquad.com\",\"steam\":\"http://pixiesquad.com\",\"twitch\":\"http://pixiesquad.com\",\"twitter\":\"http://pixiesquad.com\"}","0","2018-10-23 12:25:05"),
("5","Alex","Andar","Alexyyy","RIFFLE","0","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/player_94.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/alex.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_player.jpg","alexyyy",NULL,"http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg","[{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4.png\",\"title\":\"KILLS\",\"label\":\"589\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2.png\",\"title\":\"DEATHS\",\"label\":\"350\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1.png\",\"title\":\"HEAD SHOTS\",\"label\":\"200\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3.png\",\"title\":\"RIFFLE\",\"label\":\"35\"}]","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","DE","18","{\"facebook\":\"pixiesquad.com\",\"instagram\":\"pixiesquad.com\",\"discord\":\"pixiesquad.com\",\"steam\":\"pixiesquad.com\",\"twitch\":\"pixiesquad.com\",\"twitter\":\"pixiesquad.com\"}","0","2018-10-23 12:26:53"),
("6","Raf","Camora","rafkabrat","SINGER","0","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/player_92.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/stamenix.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_player.jpg","rafkabrat",NULL,"http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg","[{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4.png\",\"title\":\"DEATHS\",\"label\":\"410\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2.png\",\"title\":\"KILLS\",\"label\":\"200\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1.png\",\"title\":\"HEAD SHOTS\",\"label\":\"256\"},{\"icon\":\"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3.png\",\"title\":\"RIFFLE\",\"label\":\"579\"}]","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","IT","34","{\"facebook\":\"pixiesquad.com\",\"instagram\":\"pixiesquad.com\",\"discord\":\"pixiesquad.com\",\"steam\":\"pixiesquad.com\",\"twitch\":\"pixiesquad.com\",\"twitter\":\"pixiesquad.com\"}","0","2018-10-23 12:30:55");

CREATE TABLE `wp_pixiefreak_player_gear` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) DEFAULT NULL,
  `gear_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_player_gear VALUES
("8","1","1","2018-10-22 17:40:52"),
("9","1","2","2018-10-22 17:40:52"),
("10","1","3","2018-10-22 17:40:52"),
("11","2","1","2018-10-22 18:14:36"),
("12","2","2","2018-10-22 18:14:36"),
("13","2","3","2018-10-22 18:14:36"),
("14","3","1","2018-10-23 12:20:07"),
("15","3","2","2018-10-23 12:20:07"),
("16","3","3","2018-10-23 12:20:07"),
("17","4","1","2018-10-23 15:12:13"),
("18","4","2","2018-10-23 15:12:13"),
("19","4","3","2018-10-23 15:12:13"),
("20","5","1","2018-10-23 15:13:48"),
("21","5","2","2018-10-23 15:13:48"),
("22","5","3","2018-10-23 15:13:48"),
("23","6","1","2018-10-23 15:16:26"),
("24","6","2","2018-10-23 15:16:26"),
("25","6","3","2018-10-23 15:16:26");

CREATE TABLE `wp_pixiefreak_player_stream` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) DEFAULT NULL,
  `stream_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_player_stream VALUES
("1","1","1","2018-10-23 15:08:17"),
("2","1","2","2018-10-23 15:08:17"),
("3","1","3","2018-10-23 15:08:17"),
("7","6","1","2018-10-23 15:08:31"),
("8","6","2","2018-10-23 15:08:31"),
("9","6","3","2018-10-23 15:08:31"),
("10","5","1","2018-10-23 15:08:37"),
("11","5","2","2018-10-23 15:08:37"),
("12","5","3","2018-10-23 15:08:37"),
("13","4","1","2018-10-23 15:08:44"),
("14","4","2","2018-10-23 15:08:44"),
("15","4","3","2018-10-23 15:08:44"),
("16","3","1","2018-10-23 15:08:50"),
("17","3","2","2018-10-23 15:08:50"),
("18","3","3","2018-10-23 15:08:50"),
("19","2","1","2018-10-23 15:08:54"),
("20","2","2","2018-10-23 15:08:54"),
("21","2","3","2018-10-23 15:08:54");

CREATE TABLE `wp_pixiefreak_slider` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `heading_text` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `tag` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `image` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `thumbnail` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cta_text` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cta_link` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_slider VALUES
("5","We organize eSports tournaments for professional and amateur gamers","PIXIEFREAK GAMING","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/slide-02-1.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/thumb_4.png","BUY NOW","https://themeforest.net/item/pixiefreak-esports-gaming-theme-for-teams-tournaments/22790412&ref=PixieSquad","0","2018-10-22 16:03:57"),
("6","Crafted for Esports & Gamers only","WordPress Theme ","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/slide_04-1.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/thumb_1.png","GET NOW","https://themeforest.net/item/pixiefreak-esports-gaming-theme-for-teams-tournaments/22790412&ref=PixieSquad","0","2018-10-22 16:10:07"),
("7","We organize eSports tournaments for professional and amateur gamers","PIXIEFREAK GAMING","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/slide_03-1.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/thumb_3.png","READ MORE","https://themeforest.net/item/pixiefreak-esports-gaming-theme-for-teams-tournaments/22790412&ref=PixieSquad","0","2018-10-22 16:16:18"),
("8","We organize eSports tournaments for professional and amateur gamers","PIXIEFREAK GAMING","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/slide_01-1.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/thumb_2.png","READ MORE","https://www.pixiesquad.com","0","2018-10-22 16:20:57");

CREATE TABLE `wp_pixiefreak_sponsor` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `logo` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `url` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `about` text COLLATE utf8mb4_unicode_520_ci,
  `social` text COLLATE utf8mb4_unicode_520_ci,
  `type` int(11) DEFAULT NULL,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_sponsor VALUES
("1","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1-1.png","http://pixiesquad.com","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"twitch\":\"https://pixiesquad.com/\",\"steam\":\"https://pixiesquad.com/\"}","2","0","2018-10-22 15:06:37"),
("2",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3-1.png","https://pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"twitch\":\"https://pixiesquad.com/\",\"steam\":\"https://pixiesquad.com/\"}","2","0","2018-10-22 15:07:17"),
("3","ss","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2-1.png","https://pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"twitch\":\"https://pixiesquad.com/\",\"steam\":\"https://pixiesquad.com/\"}","2","0","2018-10-22 15:08:04"),
("4",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1-1.png","https://pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"twitch\":\"https://pixiesquad.com/\",\"steam\":\"https://pixiesquad.com/\"}","2","0","2018-10-22 15:08:40"),
("5",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/8.png","https://pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"twitch\":\"https://pixiesquad.com/\",\"steam\":\"https://pixiesquad.com/\"}","2","0","2018-10-22 15:09:19"),
("6",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/7.png","https://pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"twitch\":\"https://pixiesquad.com/\",\"steam\":\"https://pixiesquad.com/\"}","2","0","2018-10-22 15:09:44"),
("7",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/6.png","https://pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"twitch\":\"https://pixiesquad.com/\",\"steam\":\"https://pixiesquad.com/\"}","2","0","2018-10-22 15:10:15"),
("8",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/5.png","https://pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://pixiesquad.com/\",\"instagram\":\"https://pixiesquad.com/\",\"twitter\":\"https://pixiesquad.com/\",\"twitch\":\"https://pixiesquad.com/\",\"steam\":\"https://pixiesquad.com/\"}","2","0","2018-10-22 15:10:38"),
("11","3","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/7.png","https://www.pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.\n\n","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\",\"twitch\":\"https://www.pixiesquad.com/\",\"steam\":\"https://www.pixiesquad.com/\"}","1","0","2018-10-23 15:21:11"),
("12",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4-1.png","https://www.pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\",\"twitch\":\"https://www.pixiesquad.com/\",\"steam\":\"https://www.pixiesquad.com/\"}","1","0","2018-10-23 15:21:53"),
("13",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1-1.png","https://www.pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\",\"twitch\":\"https://www.pixiesquad.com/\",\"steam\":\"https://www.pixiesquad.com/\"}","1","0","2018-10-23 15:23:08"),
("14",NULL,"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3-1.png","https://www.pixiesquad.com/","Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quod minus id quod maxime placeat facere.","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitter\":\"https://www.pixiesquad.com/\",\"twitch\":\"https://www.pixiesquad.com/\",\"steam\":\"https://www.pixiesquad.com/\"}","1","0","2018-10-23 15:23:44");

CREATE TABLE `wp_pixiefreak_stream` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `subtitle` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `thumbnail` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `link` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_online` int(11) DEFAULT NULL,
  `view` int(11) DEFAULT '0',
  `order_number` int(11) DEFAULT '0',
  `type` int(2) DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_stream VALUES
("1","FILIP MRAVIC","BLOCKBUSTER SKIN UNLOCKED","filip-mravic","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/stream01.png","https://www.twitch.tv/drdisrespectlive","1","0","0","2","2018-10-22 18:51:40"),
("2","BORIS WICK","LCK Summer: HLE vs. BBQ - MVP vs. GRF","boris-wick","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/stream_03.png","https://www.twitch.tv/drdisrespectlive","1","0","0","1","2018-10-23 15:04:05"),
("3","ALEX","Mythic Argus with 2nd Split ","alex","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/stream_02.png","https://www.twitch.tv/drdisrespectlive","2","0","0","1","2018-10-23 15:05:52");

CREATE TABLE `wp_pixiefreak_team` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `subtitle` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `country` varchar(500) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `game_id` int(11) NOT NULL,
  `team_logo` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cover` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `thumbnail` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `stats` text COLLATE utf8mb4_unicode_520_ci,
  `about` text COLLATE utf8mb4_unicode_520_ci,
  `my_team` int(1) DEFAULT NULL,
  `year_founded` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `social` text COLLATE utf8mb4_unicode_520_ci,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_team VALUES
("1","Team Flawed Bot","Team Flawed Bot",NULL,"team-flawed-bot","RS","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_01.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/5.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_012.jpg","{\"win\":\"454\",\"loses\":\"673\",\"ties\":\"68\"}","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","1","2018-10-11 16:35:54","{\"facebook\":\"https://www.pixiesquad.com/\",\"instagram\":\"https://www.pixiesquad.com/\",\"twitch\":\"https://www.pixiesquad.com/\",\"steam\":\"https://www.pixiesquad.com/\"}","0","2018-10-22 14:36:07"),
("2","Wings Gaming","wing","aaaaaaaaaaaaaaaa","wings-gaming","AU","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_03.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_012.jpg","{\"win\":\"456\",\"loses\":\"332\",\"ties\":\"98\"}","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.\n\n","1","2018-05-29 21:17:00","{\"facebook\":\"http://pixiesquad.com\",\"instagram\":\"http://pixiesquad.com\",\"twitch\":\"http://pixiesquad.com\",\"steam\":\"http://pixiesquad.com\"}","0","2018-10-22 19:17:12"),
("3","Invictus Gaming","inv","bgh","invictus-gaming","FI","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_04.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/4.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_012.jpg","{\"win\":\"900\",\"loses\":\"521\",\"ties\":\"780\"}","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.\n","1","2010-12-15 21:19:44","{\"facebook\":\"pixiesquad.com\",\"instagram\":\"pixiesquad.com\",\"twitch\":\"pixiesquad.com\",\"steam\":\"pixiesquad.com\"}","0","2018-10-22 19:20:04"),
("4","Fnatic eSports","fnatic",NULL,"fnatic-esports","DK","2","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_02.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/01.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_012.jpg","{\"win\":\"670\",\"loses\":\"500\",\"ties\":\"45\"}","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","1","2018-10-12 21:21:49","{\"facebook\":\"pixiesquad.com\",\"instagram\":\"pixiesquad.com\",\"twitch\":\"pixiesquad.com\",\"steam\":\"pixiesquad.com\"}","0","2018-10-22 19:21:58"),
("5","Gambit Gaming","gambit","nesto","gambit-gaming","AT","3","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_06.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/03.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_012.jpg","{\"win\":\"545\",\"loses\":\"400\",\"ties\":\"337\"}","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","1","2018-10-01 21:36:58","{\"facebook\":\"pixiesquad.com\",\"instagram\":\"pixiesquad.com\",\"twitch\":\"pixiesquad.com\",\"steam\":\"pixiesquad.com\"}","0","2018-10-22 19:37:10"),
("6","Fortuna eSports","fortuna","kidaj","fortuna-esports","NL","1","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_05.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/03.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_012.jpg","{\"win\":\"290\",\"loses\":\"278\",\"ties\":\"790\"}","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","1","2018-10-24 21:38:39","{\"facebook\":\"pixiesquad.com\",\"instagram\":\"pixiesquad.com\",\"twitch\":\"pixiesquad.com\",\"steam\":\"pixiesquad.com\"}","0","2018-10-22 19:39:09");

CREATE TABLE `wp_pixiefreak_team_achievement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `achievement_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_team_achievement VALUES
("1","1","2","2018-10-22 17:49:48"),
("2","1","3","2018-10-22 17:49:48"),
("3","1","4","2018-10-22 17:49:48"),
("4","2","2","2018-10-22 19:17:51"),
("5","2","3","2018-10-22 19:17:51"),
("6","2","4","2018-10-22 19:17:51"),
("7","3","2","2018-10-22 19:20:16"),
("8","3","3","2018-10-22 19:20:16"),
("9","3","4","2018-10-22 19:20:16"),
("10","4","2","2018-10-22 19:35:21"),
("11","4","3","2018-10-22 19:35:21"),
("12","4","4","2018-10-22 19:35:21"),
("13","5","2","2018-10-22 19:37:20"),
("14","5","3","2018-10-22 19:37:20"),
("15","5","4","2018-10-22 19:37:20"),
("16","6","2","2018-10-22 19:39:19"),
("17","6","3","2018-10-22 19:39:19"),
("18","6","4","2018-10-22 19:39:19");

CREATE TABLE `wp_pixiefreak_team_player` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `player_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_team_player VALUES
("20","1","1","2018-10-23 12:31:04"),
("21","1","2","2018-10-23 12:31:04"),
("22","1","3","2018-10-23 12:31:04"),
("23","1","4","2018-10-23 12:31:04"),
("24","1","5","2018-10-23 12:31:04"),
("25","1","6","2018-10-23 12:31:04"),
("26","2","1","2018-10-23 12:31:30"),
("27","2","2","2018-10-23 12:31:30"),
("28","2","3","2018-10-23 12:31:30"),
("29","2","4","2018-10-23 12:31:30"),
("30","2","5","2018-10-23 12:31:30"),
("31","2","6","2018-10-23 12:31:30"),
("32","3","1","2018-10-23 12:31:50"),
("33","3","2","2018-10-23 12:31:50"),
("34","3","3","2018-10-23 12:31:50"),
("35","3","4","2018-10-23 12:31:50"),
("36","3","5","2018-10-23 12:31:50"),
("37","3","6","2018-10-23 12:31:50"),
("38","4","1","2018-10-23 12:32:15"),
("39","4","2","2018-10-23 12:32:15"),
("40","4","3","2018-10-23 12:32:15"),
("41","4","4","2018-10-23 12:32:15"),
("42","4","5","2018-10-23 12:32:15"),
("43","4","6","2018-10-23 12:32:15"),
("44","5","1","2018-10-23 12:32:29"),
("45","5","2","2018-10-23 12:32:29"),
("46","5","3","2018-10-23 12:32:29"),
("47","5","4","2018-10-23 12:32:29"),
("48","5","5","2018-10-23 12:32:29"),
("49","5","6","2018-10-23 12:32:29"),
("50","6","1","2018-10-23 12:32:45"),
("51","6","2","2018-10-23 12:32:45"),
("52","6","3","2018-10-23 12:32:45"),
("53","6","4","2018-10-23 12:32:45"),
("54","6","5","2018-10-23 12:32:45"),
("55","6","6","2018-10-23 12:32:45");

CREATE TABLE `wp_pixiefreak_team_stream` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `stream_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_team_stream VALUES
("1","1","1","2018-10-23 15:07:15"),
("2","1","2","2018-10-23 15:07:15"),
("3","1","3","2018-10-23 15:07:15"),
("4","2","1","2018-10-23 15:07:22"),
("5","2","2","2018-10-23 15:07:22"),
("6","2","3","2018-10-23 15:07:22"),
("7","3","1","2018-10-23 15:07:29"),
("8","3","2","2018-10-23 15:07:29"),
("9","3","3","2018-10-23 15:07:29"),
("10","6","1","2018-10-23 15:07:35"),
("11","6","2","2018-10-23 15:07:35"),
("12","6","3","2018-10-23 15:07:35"),
("13","5","1","2018-10-23 15:07:42"),
("14","5","2","2018-10-23 15:07:42"),
("15","5","3","2018-10-23 15:07:42"),
("16","4","1","2018-10-23 15:07:48"),
("17","4","2","2018-10-23 15:07:48"),
("18","4","3","2018-10-23 15:07:48");

CREATE TABLE `wp_pixiefreak_tournament` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cover` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `logo` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `thumbnail` varchar(500) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `banner` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `location` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `game_id` int(11) NOT NULL,
  `about` text COLLATE utf8mb4_unicode_520_ci,
  `social` text COLLATE utf8mb4_unicode_520_ci,
  `team_number` int(11) DEFAULT NULL,
  `group_number` int(11) DEFAULT NULL,
  `prize_pool` int(11) DEFAULT NULL,
  `random_rule` text COLLATE utf8mb4_unicode_520_ci,
  `status` int(2) DEFAULT NULL,
  `brackets` text COLLATE utf8mb4_unicode_520_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_tournament VALUES
("1","Manila masters Toronto 4v4","manila-masters-toronto-4v4","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/8.jpg","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/tournament_logo.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/thumb_02.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/04-1.jpg","Toronto Canada","2018-10-09 14:35:33","1","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","{\"twitter\":\"pixiesquad.com\",\"instagram\":\"pixiesquad.com\",\"facebook\":\"pixiesquad.com\",\"discord\":\"pixiesquad.com\",\"steam\":\"pixiesquad.com\"}","62","2","450","{\"PLAYOUT\":\"ROUND ROBIN\"}","1","{\"teams\":[[\"Team Flawed Bot\",\"Wings Gaming\"],[\"Gambit Gaming\",\"Fnatic eSports\"]],\"results\":[[[[1,2],[2,1]],[[null,null]]]]}","2018-10-23 12:36:30"),
("2","EU WINNERS League - Starter Division","eu-winners-league-starter-division","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/logoaaa.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/thumb_01.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/02-1.jpg","Belin Germany","2018-10-25 13:06:06","4","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","{\"twitter\":\"http://pixiesquad.com\",\"instagram\":\"http://pixiesquad.com\",\"facebook\":\"http://pixiesquad.com\",\"discord\":\"http://pixiesquad.com\",\"steam\":\"http://pixiesquad.com\"}","32","2","300","{\"PLAYOUT\":\"ROUND ROBIN\"}","1","{\"teams\":[[\"Team Flawed Bot\",\"Wings Gaming\"],[\"Gambit Gaming\",\"Fnatic eSports\"]],\"results\":[[[[1,2],[2,1]],[[null,null]]]]}","2018-10-23 12:36:30"),
("3","ENDPOINTGG VS CEX ESPORTS [2]","endpointgg-vs-cex-esports-2","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/04.jpg","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/logo____000.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/thumb_03.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/03-1.jpg","Longon UK","2018-10-10 14:35:33","2","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","{\"twitter\":\"pixiesquad.com\",\"instagram\":\"pixiesquad.com\",\"facebook\":\"pixiesquad.com\",\"discord\":\"pixiesquad.com\",\"steam\":\"pixiesquad.com\"}","22","2","1000","{\"PLAYOUT\":\"ROUND ROBIN\"}","1","{\"teams\":[[\"Team Flawed Bot\",\"Wings Gaming\"],[\"Gambit Gaming\",\"Fnatic eSports\"]],\"results\":[[[[1,2],[2,1]],[[null,null]]]]}","2018-10-23 12:36:30"),
("4","TORNEO SPANISH PRO LEAGUE","torneo-spanish-pro-league","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/5.jpg","http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/tournament_logo2.png","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/thumb_04.jpg","http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/01-1.jpg","Toronto Canada","2018-10-09 14:35:33","1","Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard\'s Terms Of Use.","{\"twitter\":\"pixiesquad.com\",\"instagram\":\"pixiesquad.com\",\"facebook\":\"pixiesquad.com\",\"discord\":\"pixiesquad.com\",\"steam\":\"pixiesquad.com\"}","62","6","4500","{\"PLAYOUT\":\"ROUND ROBIN\"}","1","{\"teams\":[[\"Team Flawed Bot\",\"Wings Gaming\"],[\"Gambit Gaming\",\"Fnatic eSports\"]],\"results\":[[[[1,2],[2,1]],[[null,null]]]]}","2018-10-23 12:36:30");

CREATE TABLE `wp_pixiefreak_tournament_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tournament_id` int(11) DEFAULT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_tournament_group VALUES
("1","1","GROUP A","1","2018-10-23 12:50:13"),
("2","1","GROUP B","2","2018-10-23 12:53:35"),
("3","2","GROUP A","1","2018-10-23 12:53:35"),
("4","2","GROUP B","2","2018-10-23 12:53:35"),
("5","3","GROUP A","1","2018-10-23 12:53:35"),
("6","3","GROUP B","2","2018-10-23 12:53:35"),
("7","4","GROUP A","1","2018-10-23 12:53:35"),
("8","4","GROUP B","2","2018-10-23 12:53:35");

CREATE TABLE `wp_pixiefreak_tournament_group_team` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tournament_id` int(11) DEFAULT NULL,
  `tournament_group_id` int(11) DEFAULT NULL,
  `tournament_group_team_id` int(11) DEFAULT NULL,
  `win` int(11) DEFAULT NULL,
  `loss` int(11) DEFAULT NULL,
  `draw` int(11) DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_tournament_group_team VALUES
("1","1","1","1","23","22","1","123","2018-10-23 12:50:36"),
("2","1","1","2","23","21","0","78","2018-10-23 12:50:50"),
("3","1","1","3","34","90","2","19","2018-10-23 12:51:08"),
("4","1","1","4","56","78","34","23","2018-10-23 12:51:20"),
("5","1","1","5","23","6","2","2","2018-10-23 12:51:32"),
("6","1","1","6","0","3","9","3","2018-10-23 12:51:48"),
("7","1","2","1","34","12","0","89","2018-10-23 12:53:59"),
("8","1","2","2","26","20","9","30","2018-10-23 12:54:14"),
("9","1","2","3","23","1","1","23","2018-10-23 12:54:26"),
("10","1","2","4","45","32","11","23","2018-10-23 12:54:39"),
("11","1","2","6","34","2","22","22","2018-10-23 12:54:57"),
("12","1","2","5","3","2","9","0","2018-10-23 12:55:10"),
("13","2","3","1","23","22","1","123","2018-10-23 12:50:36"),
("14","2","3","2","23","21","0","78","2018-10-23 12:50:50"),
("15","2","3","3","34","90","2","19","2018-10-23 12:51:08"),
("16","2","3","4","56","78","34","23","2018-10-23 12:51:20"),
("17","2","3","5","23","6","2","2","2018-10-23 12:51:32"),
("18","2","3","6","0","3","9","3","2018-10-23 12:51:48"),
("19","2","4","1","34","12","0","89","2018-10-23 12:53:59"),
("20","2","4","2","26","20","9","30","2018-10-23 12:54:14"),
("21","2","4","3","23","1","1","23","2018-10-23 12:54:26"),
("22","2","4","4","45","32","11","23","2018-10-23 12:54:39"),
("23","2","4","6","34","2","22","22","2018-10-23 12:54:57"),
("24","2","4","5","3","2","9","0","2018-10-23 12:55:10"),
("25","3","5","1","23","22","1","123","2018-10-23 12:50:36"),
("26","3","5","2","23","21","0","78","2018-10-23 12:50:50"),
("27","3","5","3","34","90","2","19","2018-10-23 12:51:08"),
("28","3","5","4","56","78","34","23","2018-10-23 12:51:20"),
("29","3","5","5","23","6","2","2","2018-10-23 12:51:32"),
("30","3","5","6","0","3","9","3","2018-10-23 12:51:48"),
("31","3","6","1","34","12","0","89","2018-10-23 12:53:59"),
("32","3","6","2","26","20","9","30","2018-10-23 12:54:14"),
("33","3","6","3","23","1","1","23","2018-10-23 12:54:26"),
("34","3","6","4","45","32","11","23","2018-10-23 12:54:39"),
("35","3","6","6","34","2","22","22","2018-10-23 12:54:57"),
("36","3","6","5","3","2","9","0","2018-10-23 12:55:10"),
("37","4","7","1","23","22","1","123","2018-10-23 12:50:36"),
("38","4","7","2","23","21","0","78","2018-10-23 12:50:50"),
("39","4","7","3","34","90","2","19","2018-10-23 12:51:08"),
("40","4","7","4","56","78","34","23","2018-10-23 12:51:20"),
("41","4","7","5","23","6","2","2","2018-10-23 12:51:32"),
("42","4","7","6","0","3","9","3","2018-10-23 12:51:48"),
("43","4","8","1","34","12","0","89","2018-10-23 12:53:59"),
("44","4","8","2","26","20","9","30","2018-10-23 12:54:14"),
("45","4","8","3","23","1","1","23","2018-10-23 12:54:26"),
("46","4","8","4","45","32","11","23","2018-10-23 12:54:39"),
("47","4","8","6","34","2","22","22","2018-10-23 12:54:57"),
("48","4","9","5","3","2","9","0","2018-10-23 12:55:10");

CREATE TABLE `wp_pixiefreak_tournament_team` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tournament_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


INSERT INTO wp_pixiefreak_tournament_team VALUES
("7","1","1","2018-10-23 13:20:12"),
("8","1","2","2018-10-23 13:20:12"),
("9","1","3","2018-10-23 13:20:12"),
("10","1","4","2018-10-23 13:20:12"),
("11","1","5","2018-10-23 13:20:12"),
("12","1","6","2018-10-23 13:20:12"),
("13","2","1","2018-10-23 13:20:12"),
("14","2","2","2018-10-23 13:20:12"),
("15","2","3","2018-10-23 13:20:12"),
("16","2","4","2018-10-23 13:20:12"),
("17","2","5","2018-10-23 13:20:12"),
("18","2","6","2018-10-23 13:20:12"),
("19","3","1","2018-10-23 13:20:12"),
("20","3","2","2018-10-23 13:20:12"),
("21","3","3","2018-10-23 13:20:12"),
("22","3","4","2018-10-23 13:20:12"),
("23","3","5","2018-10-23 13:20:12"),
("24","3","6","2018-10-23 13:20:12"),
("25","4","1","2018-10-23 13:20:12"),
("26","4","2","2018-10-23 13:20:12"),
("27","4","3","2018-10-23 13:20:12"),
("28","4","4","2018-10-23 13:20:12"),
("29","4","5","2018-10-23 13:20:12"),
("30","4","6","2018-10-23 13:20:12");

 INSERT INTO wp_options  VALUES (NULL, 'theme_mods_pixiefreak', 'a:7:{i:0;b:0;s:18:"nav_menu_locations";a:4:{s:11:"header_menu";i:16;s:11:"footer_left";i:14;s:12:"footer_right";i:15;s:11:"footer_menu";i:16;}s:18:"custom_css_post_id";i:-1;s:16:"sidebars_widgets";a:2:{s:4:"time";i:1540209119;s:4:"data";a:2:{s:19:"wp_inactive_widgets";a:6:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";i:3;s:10:"archives-2";i:4;s:12:"categories-2";i:5;s:6:"meta-2";}s:18:"pixiefreak-aside-1";a:0:{}}}s:24:"pixiefreak_primary_color";s:7:"#dd3333";s:25:"pixiefreak_logo_customize";s:93:"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/logo-1.png";s:11:"custom_logo";i:105;}', 'yes');
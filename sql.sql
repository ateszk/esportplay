-- phpMyAdmin SQL Dump
-- version 3.5.FORPSI
-- http://www.phpmyadmin.net
--
-- Hoszt: 185.129.138.42
-- Létrehozás ideje: 2020. dec. 09. 00:34
-- Szerver verzió: 5.7.32-35-log
-- PHP verzió: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Adatbázis: `b18914`
--
CREATE DATABASE `b18914` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `b18914`;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_`
--

CREATE TABLE IF NOT EXISTS `wp_` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `component` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `primary_link` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `date_recorded` datetime NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT '0',
  `mptt_left` int(11) NOT NULL DEFAULT '0',
  `mptt_right` int(11) NOT NULL DEFAULT '0',
  `is_spam` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `date_recorded` (`date_recorded`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  KEY `secondary_item_id` (`secondary_item_id`),
  KEY `component` (`component`),
  KEY `type` (`type`),
  KEY `mptt_left` (`mptt_left`),
  KEY `mptt_right` (`mptt_right`),
  KEY `hide_sitewide` (`hide_sitewide`),
  KEY `is_spam` (`is_spam`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=2 ;

--
-- A tábla adatainak kiíratása `wp_`
--

INSERT INTO `wp_` (`id`, `user_id`, `component`, `type`, `action`, `content`, `primary_link`, `item_id`, `secondary_item_id`, `date_recorded`, `hide_sitewide`, `mptt_left`, `mptt_right`, `is_spam`) VALUES
(1, 1, 'members', 'last_activity', '', '', '', 0, NULL, '2020-11-29 14:57:46', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp__meta`
--

CREATE TABLE IF NOT EXISTS `wp__meta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `activity_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_friends`
--

CREATE TABLE IF NOT EXISTS `wp_bp_friends` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `initiator_user_id` bigint(20) NOT NULL,
  `friend_user_id` bigint(20) NOT NULL,
  `is_confirmed` tinyint(1) DEFAULT '0',
  `is_limited` tinyint(1) DEFAULT '0',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `initiator_user_id` (`initiator_user_id`),
  KEY `friend_user_id` (`friend_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_groups`
--

CREATE TABLE IF NOT EXISTS `wp_bp_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creator_id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  `parent_id` bigint(20) NOT NULL DEFAULT '0',
  `enable_forum` tinyint(1) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `status` (`status`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_groups_groupmeta`
--

CREATE TABLE IF NOT EXISTS `wp_bp_groups_groupmeta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_groups_members`
--

CREATE TABLE IF NOT EXISTS `wp_bp_groups_members` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `inviter_id` bigint(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `is_mod` tinyint(1) NOT NULL DEFAULT '0',
  `user_title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_modified` datetime NOT NULL,
  `comments` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `is_banned` tinyint(1) NOT NULL DEFAULT '0',
  `invite_sent` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `is_admin` (`is_admin`),
  KEY `is_mod` (`is_mod`),
  KEY `user_id` (`user_id`),
  KEY `inviter_id` (`inviter_id`),
  KEY `is_confirmed` (`is_confirmed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_invitations`
--

CREATE TABLE IF NOT EXISTS `wp_bp_invitations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `inviter_id` bigint(20) NOT NULL,
  `invitee_email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `type` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'invite',
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `date_modified` datetime NOT NULL,
  `invite_sent` tinyint(1) NOT NULL DEFAULT '0',
  `accepted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `inviter_id` (`inviter_id`),
  KEY `invitee_email` (`invitee_email`),
  KEY `class` (`class`),
  KEY `item_id` (`item_id`),
  KEY `secondary_item_id` (`secondary_item_id`),
  KEY `type` (`type`),
  KEY `invite_sent` (`invite_sent`),
  KEY `accepted` (`accepted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_messages_messages`
--

CREATE TABLE IF NOT EXISTS `wp_bp_messages_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `thread_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_sent` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `thread_id` (`thread_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_messages_meta`
--

CREATE TABLE IF NOT EXISTS `wp_bp_messages_meta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `message_id` (`message_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_messages_notices`
--

CREATE TABLE IF NOT EXISTS `wp_bp_messages_notices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subject` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_messages_recipients`
--

CREATE TABLE IF NOT EXISTS `wp_bp_messages_recipients` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `thread_id` bigint(20) NOT NULL,
  `unread_count` int(10) NOT NULL DEFAULT '0',
  `sender_only` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `thread_id` (`thread_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `sender_only` (`sender_only`),
  KEY `unread_count` (`unread_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_notifications`
--

CREATE TABLE IF NOT EXISTS `wp_bp_notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `component_name` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `component_action` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_notified` datetime NOT NULL,
  `is_new` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `secondary_item_id` (`secondary_item_id`),
  KEY `user_id` (`user_id`),
  KEY `is_new` (`is_new`),
  KEY `component_name` (`component_name`),
  KEY `component_action` (`component_action`),
  KEY `useritem` (`user_id`,`is_new`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_notifications_meta`
--

CREATE TABLE IF NOT EXISTS `wp_bp_notifications_meta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `notification_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `notification_id` (`notification_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_user_blogs`
--

CREATE TABLE IF NOT EXISTS `wp_bp_user_blogs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `blog_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `blog_id` (`blog_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=2 ;

--
-- A tábla adatainak kiíratása `wp_bp_user_blogs`
--

INSERT INTO `wp_bp_user_blogs` (`id`, `user_id`, `blog_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_user_blogs_blogmeta`
--

CREATE TABLE IF NOT EXISTS `wp_bp_user_blogs_blogmeta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `blog_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `blog_id` (`blog_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=9 ;

--
-- A tábla adatainak kiíratása `wp_bp_user_blogs_blogmeta`
--

INSERT INTO `wp_bp_user_blogs_blogmeta` (`id`, `blog_id`, `meta_key`, `meta_value`) VALUES
(1, 1, 'url', 'http://localhost'),
(2, 1, 'name', 'huPlay!'),
(3, 1, 'description', 'Magyar E-Sport versenyek egy helyen!'),
(4, 1, 'last_activity', '2020-11-29 14:57:32'),
(5, 1, 'close_comments_for_old_posts', '0'),
(6, 1, 'close_comments_days_old', '14'),
(7, 1, 'thread_comments_depth', '5'),
(8, 1, 'comment_moderation', '0');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_xprofile_data`
--

CREATE TABLE IF NOT EXISTS `wp_bp_xprofile_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_xprofile_fields`
--

CREATE TABLE IF NOT EXISTS `wp_bp_xprofile_fields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) unsigned NOT NULL,
  `parent_id` bigint(20) unsigned NOT NULL,
  `type` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `is_default_option` tinyint(1) NOT NULL DEFAULT '0',
  `field_order` bigint(20) NOT NULL DEFAULT '0',
  `option_order` bigint(20) NOT NULL DEFAULT '0',
  `order_by` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `can_delete` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `parent_id` (`parent_id`),
  KEY `field_order` (`field_order`),
  KEY `can_delete` (`can_delete`),
  KEY `is_required` (`is_required`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=2 ;

--
-- A tábla adatainak kiíratása `wp_bp_xprofile_fields`
--

INSERT INTO `wp_bp_xprofile_fields` (`id`, `group_id`, `parent_id`, `type`, `name`, `description`, `is_required`, `is_default_option`, `field_order`, `option_order`, `order_by`, `can_delete`) VALUES
(1, 1, 0, 'textbox', 'Name', '', 1, 0, 0, 0, '', 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_xprofile_groups`
--

CREATE TABLE IF NOT EXISTS `wp_bp_xprofile_groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_order` bigint(20) NOT NULL DEFAULT '0',
  `can_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `can_delete` (`can_delete`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=2 ;

--
-- A tábla adatainak kiíratása `wp_bp_xprofile_groups`
--

INSERT INTO `wp_bp_xprofile_groups` (`id`, `name`, `description`, `group_order`, `can_delete`) VALUES
(1, 'Base', '', 0, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_bp_xprofile_meta`
--

CREATE TABLE IF NOT EXISTS `wp_bp_xprofile_meta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) NOT NULL,
  `object_type` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `object_id` (`object_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=2 ;

--
-- A tábla adatainak kiíratása `wp_bp_xprofile_meta`
--

INSERT INTO `wp_bp_xprofile_meta` (`id`, `object_id`, `object_type`, `meta_key`, `meta_value`) VALUES
(1, 1, 'field', 'allow_custom_visibility', 'disabled');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_commentmeta`
--

CREATE TABLE IF NOT EXISTS `wp_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=4 ;

--
-- A tábla adatainak kiíratása `wp_commentmeta`
--

INSERT INTO `wp_commentmeta` (`meta_id`, `comment_id`, `meta_key`, `meta_value`) VALUES
(1, 5, 'akismet_history', 'a:3:{s:4:"time";d:1607182900.2189300060272216796875;s:5:"event";s:12:"status-trash";s:4:"user";s:5:"admin";}'),
(2, 5, '_wp_trash_meta_status', '0'),
(3, 5, '_wp_trash_meta_time', '1607182900');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_comments`
--

CREATE TABLE IF NOT EXISTS `wp_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'comment',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=6 ;

--
-- A tábla adatainak kiíratása `wp_comments`
--

INSERT INTO `wp_comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`) VALUES
(1, 1, 'WordPress Commenter', 'wapuu@wordpress.example', 'https://wordpress.org/', '', '2020-12-05 10:40:40', '2020-12-05 10:40:40', 'Üdvözlet! Ez egy hozzászólás.\nA hozzászólások moderálásához, szerkesztéséhez és törléséhez látogassunk el a honlapunk vezérlőpultjának\nHozzászólások menüpontjához.\nA hozzászólok avatarját a <a href="https://gravatar.com">Gravatar</a> biztosítja.', 0, '1', '', 'comment', 0, 0),
(3, 228, 'WordPress Commenter', 'wapuu@wordpress.example', 'https://wordpress.org/', '', '2020-11-28 19:54:36', '2020-11-28 19:54:36', 'Üdvözlet! Ez egy hozzászólás.\nA hozzászólások moderálásához, szerkesztéséhez és törléséhez látogassunk el a honlapunk vezérlőpultjának\nHozzászólások menüpontjához.\nA hozzászólok avatarját a <a href="https://gravatar.com" rel="nofollow ugc">Gravatar</a> biztosítja.', 0, '1', '', 'comment', 0, 0),
(4, 116, 'admin', 'kissattilak@gmail.com', 'http://esportplay.hu', '84.236.111.159', '2020-12-05 15:30:23', '2020-12-05 14:30:23', 'asdasd', 0, '1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.66 Safari/537.36', 'comment', 0, 1),
(5, 1, 'itzatesz', 'ateszkvideo@gmail.com', '', '84.236.111.159', '2020-12-05 15:43:03', '2020-12-05 14:43:03', 'Azta', 0, 'trash', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.66 Safari/537.36', 'comment', 0, 3);

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_links`
--

CREATE TABLE IF NOT EXISTS `wp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_options`
--

CREATE TABLE IF NOT EXISTS `wp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=503 ;

--
-- A tábla adatainak kiíratása `wp_options`
--

INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(1, 'siteurl', 'http://esportplay.hu', 'yes'),
(2, 'home', 'http://esportplay.hu', 'yes'),
(3, 'blogname', 'Esport Play', 'yes'),
(4, 'blogdescription', 'Magyar E-Sport versenyek egy helyen!', 'yes'),
(5, 'users_can_register', '1', 'yes'),
(6, 'admin_email', 'kissattilak@gmail.com', 'yes'),
(7, 'start_of_week', '1', 'yes'),
(8, 'use_balanceTags', '0', 'yes'),
(9, 'use_smilies', '1', 'yes'),
(10, 'require_name_email', '1', 'yes'),
(11, 'comments_notify', '1', 'yes'),
(12, 'posts_per_rss', '10', 'yes'),
(13, 'rss_use_excerpt', '0', 'yes'),
(14, 'mailserver_url', 'mail.example.com', 'yes'),
(15, 'mailserver_login', 'login@example.com', 'yes'),
(16, 'mailserver_pass', 'password', 'yes'),
(17, 'mailserver_port', '110', 'yes'),
(18, 'default_category', '1', 'yes'),
(19, 'default_comment_status', 'open', 'yes'),
(20, 'default_ping_status', 'open', 'yes'),
(21, 'default_pingback_flag', '0', 'yes'),
(22, 'posts_per_page', '10', 'yes'),
(23, 'date_format', 'Y.m.d.', 'yes'),
(24, 'time_format', 'H:i', 'yes'),
(25, 'links_updated_date_format', 'Y.m.d. H:i', 'yes'),
(26, 'comment_moderation', '0', 'yes'),
(27, 'moderation_notify', '1', 'yes'),
(28, 'permalink_structure', '/%year%/%monthnum%/%day%/%postname%/', 'yes'),
(29, 'rewrite_rules', 'a:108:{s:11:"^wp-json/?$";s:22:"index.php?rest_route=/";s:14:"^wp-json/(.*)?";s:33:"index.php?rest_route=/$matches[1]";s:21:"^index.php/wp-json/?$";s:22:"index.php?rest_route=/";s:24:"^index.php/wp-json/(.*)?";s:33:"index.php?rest_route=/$matches[1]";s:17:"^wp-sitemap\\.xml$";s:23:"index.php?sitemap=index";s:17:"^wp-sitemap\\.xsl$";s:36:"index.php?sitemap-stylesheet=sitemap";s:23:"^wp-sitemap-index\\.xsl$";s:34:"index.php?sitemap-stylesheet=index";s:48:"^wp-sitemap-([a-z]+?)-([a-z\\d_-]+?)-(\\d+?)\\.xml$";s:75:"index.php?sitemap=$matches[1]&sitemap-subtype=$matches[2]&paged=$matches[3]";s:34:"^wp-sitemap-([a-z]+?)-(\\d+?)\\.xml$";s:47:"index.php?sitemap=$matches[1]&paged=$matches[2]";s:15:"^match/([^/]+)$";s:47:"index.php?pagename=match&match_slug=$matches[1]";s:28:"^match/([^/]+)/page/([^/]+)$";s:65:"index.php?pagename=match&match_slug=$matches[1]&paged=$matches[2]";s:16:"^player/([^/]+)$";s:49:"index.php?pagename=player&player_slug=$matches[1]";s:29:"^player/([^/]+)/page/([^/]+)$";s:67:"index.php?pagename=player&player_slug=$matches[1]&paged=$matches[2]";s:14:"^team/([^/]+)$";s:45:"index.php?pagename=team&team_slug=$matches[1]";s:27:"^team/([^/]+)/page/([^/]+)$";s:63:"index.php?pagename=team&team_slug=$matches[1]&paged=$matches[2]";s:20:"^tournament/([^/]+)$";s:57:"index.php?pagename=tournament&tournament_slug=$matches[1]";s:33:"^tournament/([^/]+)/page/([^/]+)$";s:75:"index.php?pagename=tournament&tournament_slug=$matches[1]&paged=$matches[2]";s:16:"^stream/([^/]+)$";s:49:"index.php?pagename=stream&stream_slug=$matches[1]";s:29:"^stream/([^/]+)/page/([^/]+)$";s:67:"index.php?pagename=stream&stream_slug=$matches[1]&paged=$matches[2]";s:17:"^bracket/([^/]+)$";s:51:"index.php?pagename=bracket&bracket_slug=$matches[1]";s:30:"^bracket/([^/]+)/page/([^/]+)$";s:69:"index.php?pagename=bracket&bracket_slug=$matches[1]&paged=$matches[2]";s:47:"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:52:"index.php?category_name=$matches[1]&feed=$matches[2]";s:42:"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$";s:52:"index.php?category_name=$matches[1]&feed=$matches[2]";s:23:"category/(.+?)/embed/?$";s:46:"index.php?category_name=$matches[1]&embed=true";s:35:"category/(.+?)/page/?([0-9]{1,})/?$";s:53:"index.php?category_name=$matches[1]&paged=$matches[2]";s:17:"category/(.+?)/?$";s:35:"index.php?category_name=$matches[1]";s:44:"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?tag=$matches[1]&feed=$matches[2]";s:39:"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?tag=$matches[1]&feed=$matches[2]";s:20:"tag/([^/]+)/embed/?$";s:36:"index.php?tag=$matches[1]&embed=true";s:32:"tag/([^/]+)/page/?([0-9]{1,})/?$";s:43:"index.php?tag=$matches[1]&paged=$matches[2]";s:14:"tag/([^/]+)/?$";s:25:"index.php?tag=$matches[1]";s:45:"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?post_format=$matches[1]&feed=$matches[2]";s:40:"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?post_format=$matches[1]&feed=$matches[2]";s:21:"type/([^/]+)/embed/?$";s:44:"index.php?post_format=$matches[1]&embed=true";s:33:"type/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?post_format=$matches[1]&paged=$matches[2]";s:15:"type/([^/]+)/?$";s:33:"index.php?post_format=$matches[1]";s:12:"robots\\.txt$";s:18:"index.php?robots=1";s:13:"favicon\\.ico$";s:19:"index.php?favicon=1";s:48:".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$";s:18:"index.php?feed=old";s:20:".*wp-app\\.php(/.*)?$";s:19:"index.php?error=403";s:18:".*wp-register.php$";s:23:"index.php?register=true";s:32:"feed/(feed|rdf|rss|rss2|atom)/?$";s:27:"index.php?&feed=$matches[1]";s:27:"(feed|rdf|rss|rss2|atom)/?$";s:27:"index.php?&feed=$matches[1]";s:8:"embed/?$";s:21:"index.php?&embed=true";s:20:"page/?([0-9]{1,})/?$";s:28:"index.php?&paged=$matches[1]";s:41:"comments/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?&feed=$matches[1]&withcomments=1";s:36:"comments/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?&feed=$matches[1]&withcomments=1";s:17:"comments/embed/?$";s:21:"index.php?&embed=true";s:44:"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:40:"index.php?s=$matches[1]&feed=$matches[2]";s:39:"search/(.+)/(feed|rdf|rss|rss2|atom)/?$";s:40:"index.php?s=$matches[1]&feed=$matches[2]";s:20:"search/(.+)/embed/?$";s:34:"index.php?s=$matches[1]&embed=true";s:32:"search/(.+)/page/?([0-9]{1,})/?$";s:41:"index.php?s=$matches[1]&paged=$matches[2]";s:14:"search/(.+)/?$";s:23:"index.php?s=$matches[1]";s:47:"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?author_name=$matches[1]&feed=$matches[2]";s:42:"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?author_name=$matches[1]&feed=$matches[2]";s:23:"author/([^/]+)/embed/?$";s:44:"index.php?author_name=$matches[1]&embed=true";s:35:"author/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?author_name=$matches[1]&paged=$matches[2]";s:17:"author/([^/]+)/?$";s:33:"index.php?author_name=$matches[1]";s:69:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$";s:80:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]";s:64:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$";s:80:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]";s:45:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$";s:74:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true";s:57:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$";s:81:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]";s:39:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$";s:63:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]";s:56:"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$";s:64:"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]";s:51:"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$";s:64:"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]";s:32:"([0-9]{4})/([0-9]{1,2})/embed/?$";s:58:"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true";s:44:"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$";s:65:"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]";s:26:"([0-9]{4})/([0-9]{1,2})/?$";s:47:"index.php?year=$matches[1]&monthnum=$matches[2]";s:43:"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?year=$matches[1]&feed=$matches[2]";s:38:"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?year=$matches[1]&feed=$matches[2]";s:19:"([0-9]{4})/embed/?$";s:37:"index.php?year=$matches[1]&embed=true";s:31:"([0-9]{4})/page/?([0-9]{1,})/?$";s:44:"index.php?year=$matches[1]&paged=$matches[2]";s:13:"([0-9]{4})/?$";s:26:"index.php?year=$matches[1]";s:58:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:68:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:88:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:83:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:83:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:64:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:53:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/embed/?$";s:91:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&embed=true";s:57:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/trackback/?$";s:85:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&tb=1";s:77:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:97:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]";s:72:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:97:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]";s:65:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/page/?([0-9]{1,})/?$";s:98:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&paged=$matches[5]";s:72:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/comment-page-([0-9]{1,})/?$";s:98:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&cpage=$matches[5]";s:61:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)(?:/([0-9]+))?/?$";s:97:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&page=$matches[5]";s:47:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:57:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:77:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:72:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:72:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:53:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:64:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$";s:81:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&cpage=$matches[4]";s:51:"([0-9]{4})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$";s:65:"index.php?year=$matches[1]&monthnum=$matches[2]&cpage=$matches[3]";s:38:"([0-9]{4})/comment-page-([0-9]{1,})/?$";s:44:"index.php?year=$matches[1]&cpage=$matches[2]";s:27:".?.+?/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:37:".?.+?/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:57:".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:33:".?.+?/attachment/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:16:"(.?.+?)/embed/?$";s:41:"index.php?pagename=$matches[1]&embed=true";s:20:"(.?.+?)/trackback/?$";s:35:"index.php?pagename=$matches[1]&tb=1";s:40:"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?pagename=$matches[1]&feed=$matches[2]";s:35:"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?pagename=$matches[1]&feed=$matches[2]";s:28:"(.?.+?)/page/?([0-9]{1,})/?$";s:48:"index.php?pagename=$matches[1]&paged=$matches[2]";s:35:"(.?.+?)/comment-page-([0-9]{1,})/?$";s:48:"index.php?pagename=$matches[1]&cpage=$matches[2]";s:24:"(.?.+?)(?:/([0-9]+))?/?$";s:47:"index.php?pagename=$matches[1]&page=$matches[2]";}', 'yes'),
(437, 'widget_theme-my-login', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(452, '_site_transient_update_plugins', 'O:8:"stdClass":5:{s:12:"last_checked";i:1607393772;s:7:"checked";a:6:{s:19:"akismet/akismet.php";s:5:"4.1.7";s:54:"custom-login-page-templates/custom-login-templates.php";s:3:"1.0";s:9:"hello.php";s:5:"1.7.2";s:35:"pixiefreakpanel/pixiefreakpanel.php";s:6:"1.0.98";s:33:"theme-my-login/theme-my-login.php";s:5:"7.1.2";s:41:"wordpress-importer/wordpress-importer.php";s:3:"0.7";}s:8:"response";a:0:{}s:12:"translations";a:0:{}s:9:"no_update";a:5:{s:19:"akismet/akismet.php";O:8:"stdClass":9:{s:2:"id";s:21:"w.org/plugins/akismet";s:4:"slug";s:7:"akismet";s:6:"plugin";s:19:"akismet/akismet.php";s:11:"new_version";s:5:"4.1.7";s:3:"url";s:38:"https://wordpress.org/plugins/akismet/";s:7:"package";s:56:"https://downloads.wordpress.org/plugin/akismet.4.1.7.zip";s:5:"icons";a:2:{s:2:"2x";s:59:"https://ps.w.org/akismet/assets/icon-256x256.png?rev=969272";s:2:"1x";s:59:"https://ps.w.org/akismet/assets/icon-128x128.png?rev=969272";}s:7:"banners";a:1:{s:2:"1x";s:61:"https://ps.w.org/akismet/assets/banner-772x250.jpg?rev=479904";}s:11:"banners_rtl";a:0:{}}s:54:"custom-login-page-templates/custom-login-templates.php";O:8:"stdClass":9:{s:2:"id";s:41:"w.org/plugins/custom-login-page-templates";s:4:"slug";s:27:"custom-login-page-templates";s:6:"plugin";s:54:"custom-login-page-templates/custom-login-templates.php";s:11:"new_version";s:3:"1.0";s:3:"url";s:58:"https://wordpress.org/plugins/custom-login-page-templates/";s:7:"package";s:74:"https://downloads.wordpress.org/plugin/custom-login-page-templates.1.0.zip";s:5:"icons";a:2:{s:2:"2x";s:80:"https://ps.w.org/custom-login-page-templates/assets/icon-256x256.png?rev=1667452";s:2:"1x";s:80:"https://ps.w.org/custom-login-page-templates/assets/icon-128x128.png?rev=1667452";}s:7:"banners";a:2:{s:2:"2x";s:83:"https://ps.w.org/custom-login-page-templates/assets/banner-1544x500.png?rev=1667452";s:2:"1x";s:82:"https://ps.w.org/custom-login-page-templates/assets/banner-772x250.png?rev=1667452";}s:11:"banners_rtl";a:0:{}}s:9:"hello.php";O:8:"stdClass":9:{s:2:"id";s:25:"w.org/plugins/hello-dolly";s:4:"slug";s:11:"hello-dolly";s:6:"plugin";s:9:"hello.php";s:11:"new_version";s:5:"1.7.2";s:3:"url";s:42:"https://wordpress.org/plugins/hello-dolly/";s:7:"package";s:60:"https://downloads.wordpress.org/plugin/hello-dolly.1.7.2.zip";s:5:"icons";a:2:{s:2:"2x";s:64:"https://ps.w.org/hello-dolly/assets/icon-256x256.jpg?rev=2052855";s:2:"1x";s:64:"https://ps.w.org/hello-dolly/assets/icon-128x128.jpg?rev=2052855";}s:7:"banners";a:1:{s:2:"1x";s:66:"https://ps.w.org/hello-dolly/assets/banner-772x250.jpg?rev=2052855";}s:11:"banners_rtl";a:0:{}}s:33:"theme-my-login/theme-my-login.php";O:8:"stdClass":9:{s:2:"id";s:28:"w.org/plugins/theme-my-login";s:4:"slug";s:14:"theme-my-login";s:6:"plugin";s:33:"theme-my-login/theme-my-login.php";s:11:"new_version";s:5:"7.1.2";s:3:"url";s:45:"https://wordpress.org/plugins/theme-my-login/";s:7:"package";s:57:"https://downloads.wordpress.org/plugin/theme-my-login.zip";s:5:"icons";a:2:{s:2:"2x";s:67:"https://ps.w.org/theme-my-login/assets/icon-256x256.png?rev=1891232";s:2:"1x";s:67:"https://ps.w.org/theme-my-login/assets/icon-128x128.png?rev=1891232";}s:7:"banners";a:2:{s:2:"2x";s:70:"https://ps.w.org/theme-my-login/assets/banner-1544x500.png?rev=1891232";s:2:"1x";s:69:"https://ps.w.org/theme-my-login/assets/banner-772x250.png?rev=1891232";}s:11:"banners_rtl";a:0:{}}s:41:"wordpress-importer/wordpress-importer.php";O:8:"stdClass":9:{s:2:"id";s:32:"w.org/plugins/wordpress-importer";s:4:"slug";s:18:"wordpress-importer";s:6:"plugin";s:41:"wordpress-importer/wordpress-importer.php";s:11:"new_version";s:3:"0.7";s:3:"url";s:49:"https://wordpress.org/plugins/wordpress-importer/";s:7:"package";s:65:"https://downloads.wordpress.org/plugin/wordpress-importer.0.7.zip";s:5:"icons";a:3:{s:2:"2x";s:71:"https://ps.w.org/wordpress-importer/assets/icon-256x256.png?rev=1908375";s:2:"1x";s:63:"https://ps.w.org/wordpress-importer/assets/icon.svg?rev=1908375";s:3:"svg";s:63:"https://ps.w.org/wordpress-importer/assets/icon.svg?rev=1908375";}s:7:"banners";a:1:{s:2:"1x";s:72:"https://ps.w.org/wordpress-importer/assets/banner-772x250.png?rev=547654";}s:11:"banners_rtl";a:0:{}}}}', 'no'),
(30, 'hack_file', '0', 'yes'),
(31, 'blog_charset', 'UTF-8', 'yes'),
(32, 'moderation_keys', '', 'no'),
(33, 'active_plugins', 'a:4:{i:0;s:19:"akismet/akismet.php";i:1;s:54:"custom-login-page-templates/custom-login-templates.php";i:2;s:35:"pixiefreakpanel/pixiefreakpanel.php";i:3;s:41:"wordpress-importer/wordpress-importer.php";}', 'yes'),
(34, 'category_base', '', 'yes'),
(35, 'ping_sites', 'http://rpc.pingomatic.com/', 'yes'),
(36, 'comment_max_links', '2', 'yes'),
(37, 'gmt_offset', '1', 'yes'),
(38, 'default_email_category', '1', 'yes'),
(39, 'recently_edited', 'a:5:{i:0;s:72:"/web/htdocs5/esportplayhu/home/www/wp-content/themes/pixiefreak/page.php";i:1;s:78:"/web/htdocs5/esportplayhu/home/www/wp-content/themes/pixiefreak/page-about.php";i:2;s:80:"/web/htdocs5/esportplayhu/home/www/wp-content/themes/pixiefreak/page-sponsor.php";i:3;s:79:"/web/htdocs5/esportplayhu/home/www/wp-content/themes/pixiefreak/page-stream.php";i:4;s:73:"/web/htdocs5/esportplayhu/home/www/wp-content/themes/pixiefreak/style.css";}', 'no'),
(40, 'template', 'pixiefreak', 'yes'),
(41, 'stylesheet', 'pixiefreak', 'yes'),
(42, 'comment_registration', '0', 'yes'),
(43, 'html_type', 'text/html', 'yes'),
(44, 'use_trackback', '0', 'yes'),
(45, 'default_role', 'subscriber', 'yes'),
(46, 'db_version', '48748', 'yes'),
(47, 'uploads_use_yearmonth_folders', '1', 'yes'),
(48, 'upload_path', '', 'yes'),
(49, 'blog_public', '0', 'yes'),
(50, 'default_link_category', '2', 'yes'),
(51, 'show_on_front', 'posts', 'yes'),
(52, 'tag_base', '', 'yes'),
(53, 'show_avatars', '1', 'yes'),
(54, 'avatar_rating', 'G', 'yes'),
(55, 'upload_url_path', '', 'yes'),
(56, 'thumbnail_size_w', '150', 'yes'),
(57, 'thumbnail_size_h', '150', 'yes'),
(58, 'thumbnail_crop', '1', 'yes'),
(59, 'medium_size_w', '300', 'yes'),
(60, 'medium_size_h', '300', 'yes'),
(61, 'avatar_default', 'mystery', 'yes'),
(62, 'large_size_w', '1024', 'yes'),
(63, 'large_size_h', '1024', 'yes'),
(64, 'image_default_link_type', 'none', 'yes'),
(65, 'image_default_size', '', 'yes'),
(66, 'image_default_align', '', 'yes'),
(67, 'close_comments_for_old_posts', '0', 'yes'),
(68, 'close_comments_days_old', '14', 'yes'),
(69, 'thread_comments', '1', 'yes'),
(70, 'thread_comments_depth', '5', 'yes'),
(71, 'page_comments', '0', 'yes'),
(72, 'comments_per_page', '50', 'yes'),
(73, 'default_comments_page', 'newest', 'yes'),
(74, 'comment_order', 'asc', 'yes'),
(75, 'sticky_posts', 'a:0:{}', 'yes'),
(76, 'widget_categories', 'a:2:{i:2;a:4:{s:5:"title";s:0:"";s:5:"count";i:0;s:12:"hierarchical";i:0;s:8:"dropdown";i:0;}s:12:"_multiwidget";i:1;}', 'yes'),
(77, 'widget_text', 'a:2:{i:1;a:0:{}s:12:"_multiwidget";i:1;}', 'yes'),
(78, 'widget_rss', 'a:2:{i:1;a:0:{}s:12:"_multiwidget";i:1;}', 'yes'),
(79, 'uninstall_plugins', 'a:0:{}', 'no'),
(80, 'timezone_string', '', 'yes'),
(81, 'page_for_posts', '0', 'yes'),
(82, 'page_on_front', '0', 'yes'),
(83, 'default_post_format', '0', 'yes'),
(84, 'link_manager_enabled', '0', 'yes'),
(85, 'finished_splitting_shared_terms', '1', 'yes'),
(86, 'site_icon', '265', 'yes'),
(87, 'medium_large_size_w', '768', 'yes'),
(88, 'medium_large_size_h', '0', 'yes'),
(89, 'wp_page_for_privacy_policy', '3', 'yes'),
(90, 'show_comments_cookies_opt_in', '1', 'yes'),
(91, 'admin_email_lifespan', '1622716839', 'yes'),
(92, 'disallowed_keys', '', 'no'),
(93, 'comment_previously_approved', '1', 'yes'),
(94, 'auto_plugin_theme_update_emails', 'a:0:{}', 'no'),
(95, 'initial_db_version', '48748', 'yes'),
(96, 'wp_user_roles', 'a:5:{s:13:"administrator";a:2:{s:4:"name";s:13:"Administrator";s:12:"capabilities";a:61:{s:13:"switch_themes";b:1;s:11:"edit_themes";b:1;s:16:"activate_plugins";b:1;s:12:"edit_plugins";b:1;s:10:"edit_users";b:1;s:10:"edit_files";b:1;s:14:"manage_options";b:1;s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:6:"import";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:8:"level_10";b:1;s:7:"level_9";b:1;s:7:"level_8";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;s:12:"delete_users";b:1;s:12:"create_users";b:1;s:17:"unfiltered_upload";b:1;s:14:"edit_dashboard";b:1;s:14:"update_plugins";b:1;s:14:"delete_plugins";b:1;s:15:"install_plugins";b:1;s:13:"update_themes";b:1;s:14:"install_themes";b:1;s:11:"update_core";b:1;s:10:"list_users";b:1;s:12:"remove_users";b:1;s:13:"promote_users";b:1;s:18:"edit_theme_options";b:1;s:13:"delete_themes";b:1;s:6:"export";b:1;}}s:6:"editor";a:2:{s:4:"name";s:6:"Editor";s:12:"capabilities";a:34:{s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;}}s:6:"author";a:2:{s:4:"name";s:6:"Author";s:12:"capabilities";a:10:{s:12:"upload_files";b:1;s:10:"edit_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:4:"read";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;s:22:"delete_published_posts";b:1;}}s:11:"contributor";a:2:{s:4:"name";s:11:"Contributor";s:12:"capabilities";a:5:{s:10:"edit_posts";b:1;s:4:"read";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;}}s:10:"subscriber";a:2:{s:4:"name";s:10:"Subscriber";s:12:"capabilities";a:2:{s:4:"read";b:1;s:7:"level_0";b:1;}}}', 'yes'),
(97, 'fresh_site', '0', 'yes'),
(98, 'WPLANG', 'hu_HU', 'yes'),
(99, 'widget_search', 'a:2:{i:2;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes'),
(100, 'widget_recent-posts', 'a:2:{i:2;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}s:12:"_multiwidget";i:1;}', 'yes'),
(101, 'widget_recent-comments', 'a:2:{i:2;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}s:12:"_multiwidget";i:1;}', 'yes'),
(102, 'widget_archives', 'a:2:{i:2;a:3:{s:5:"title";s:0:"";s:5:"count";i:0;s:8:"dropdown";i:0;}s:12:"_multiwidget";i:1;}', 'yes'),
(103, 'widget_meta', 'a:2:{i:2;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes'),
(104, 'sidebars_widgets', 'a:4:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:3:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";}s:9:"sidebar-2";a:3:{i:0;s:10:"archives-2";i:1;s:12:"categories-2";i:2;s:6:"meta-2";}s:13:"array_version";i:3;}', 'yes'),
(105, 'cron', 'a:5:{i:1607424041;a:1:{s:32:"recovery_mode_clean_expired_keys";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1607424042;a:4:{s:16:"wp_version_check";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:17:"wp_update_plugins";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:16:"wp_update_themes";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:34:"wp_privacy_delete_old_export_files";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:6:"hourly";s:4:"args";a:0:{}s:8:"interval";i:3600;}}}i:1607424057;a:2:{s:19:"wp_scheduled_delete";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:25:"delete_expired_transients";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1607856041;a:1:{s:30:"wp_site_health_scheduled_check";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:6:"weekly";s:4:"args";a:0:{}s:8:"interval";i:604800;}}}s:7:"version";i:2;}', 'yes'),
(438, '_tml_installed_at', '1607182494', 'no'),
(439, '_tml_updated_at', '1607182494', 'no'),
(440, '_tml_version', '7.1.2', 'no'),
(106, 'widget_pages', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(107, 'widget_calendar', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(108, 'widget_media_audio', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(109, 'widget_media_image', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(110, 'widget_media_gallery', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(111, 'widget_media_video', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(112, 'widget_tag_cloud', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(113, 'widget_nav_menu', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(114, 'widget_custom_html', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(116, 'theme_mods_twentytwenty', 'a:2:{s:18:"custom_css_post_id";i:-1;s:16:"sidebars_widgets";a:2:{s:4:"time";i:1607165220;s:4:"data";a:3:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:3:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";}s:9:"sidebar-2";a:3:{i:0;s:10:"archives-2";i:1;s:12:"categories-2";i:2;s:6:"meta-2";}}}}', 'yes'),
(117, 'recovery_keys', 'a:0:{}', 'yes'),
(172, 'theme_switched_via_customizer', '', 'yes'),
(137, 'can_compress_scripts', '1', 'no'),
(171, 'theme_switched', '', 'yes'),
(500, '_site_transient_timeout_theme_roots', '1607395572', 'no'),
(501, '_site_transient_theme_roots', 'a:5:{s:10:"pixiefreak";s:7:"/themes";s:14:"twentynineteen";s:7:"/themes";s:15:"twentyseventeen";s:7:"/themes";s:13:"twentysixteen";s:7:"/themes";s:12:"twentytwenty";s:7:"/themes";}', 'no'),
(173, 'customize_stashed_theme_mods', 'a:0:{}', 'no'),
(436, '_site_transient_update_themes', 'O:8:"stdClass":5:{s:12:"last_checked";i:1607393772;s:7:"checked";a:5:{s:10:"pixiefreak";s:6:"1.0.98";s:14:"twentynineteen";s:3:"1.7";s:15:"twentyseventeen";s:3:"2.4";s:13:"twentysixteen";s:3:"2.2";s:12:"twentytwenty";s:3:"1.5";}s:8:"response";a:0:{}s:9:"no_update";a:4:{s:14:"twentynineteen";a:6:{s:5:"theme";s:14:"twentynineteen";s:11:"new_version";s:3:"1.7";s:3:"url";s:44:"https://wordpress.org/themes/twentynineteen/";s:7:"package";s:60:"https://downloads.wordpress.org/theme/twentynineteen.1.7.zip";s:8:"requires";s:5:"4.9.6";s:12:"requires_php";s:5:"5.2.4";}s:15:"twentyseventeen";a:6:{s:5:"theme";s:15:"twentyseventeen";s:11:"new_version";s:3:"2.4";s:3:"url";s:45:"https://wordpress.org/themes/twentyseventeen/";s:7:"package";s:61:"https://downloads.wordpress.org/theme/twentyseventeen.2.4.zip";s:8:"requires";s:3:"4.7";s:12:"requires_php";s:5:"5.2.4";}s:13:"twentysixteen";a:6:{s:5:"theme";s:13:"twentysixteen";s:11:"new_version";s:3:"2.2";s:3:"url";s:43:"https://wordpress.org/themes/twentysixteen/";s:7:"package";s:59:"https://downloads.wordpress.org/theme/twentysixteen.2.2.zip";s:8:"requires";s:3:"4.4";s:12:"requires_php";s:5:"5.2.4";}s:12:"twentytwenty";a:6:{s:5:"theme";s:12:"twentytwenty";s:11:"new_version";s:3:"1.5";s:3:"url";s:42:"https://wordpress.org/themes/twentytwenty/";s:7:"package";s:58:"https://downloads.wordpress.org/theme/twentytwenty.1.5.zip";s:8:"requires";s:3:"4.7";s:12:"requires_php";s:5:"5.2.4";}}s:12:"translations";a:0:{}}', 'no'),
(434, '_site_transient_update_core', 'O:8:"stdClass":4:{s:7:"updates";a:1:{i:0;O:8:"stdClass":10:{s:8:"response";s:6:"latest";s:8:"download";s:59:"https://downloads.wordpress.org/release/wordpress-5.5.3.zip";s:6:"locale";s:5:"hu_HU";s:8:"packages";O:8:"stdClass":5:{s:4:"full";s:59:"https://downloads.wordpress.org/release/wordpress-5.5.3.zip";s:10:"no_content";s:70:"https://downloads.wordpress.org/release/wordpress-5.5.3-no-content.zip";s:11:"new_bundled";s:71:"https://downloads.wordpress.org/release/wordpress-5.5.3-new-bundled.zip";s:7:"partial";s:0:"";s:8:"rollback";s:0:"";}s:7:"current";s:5:"5.5.3";s:7:"version";s:5:"5.5.3";s:11:"php_version";s:6:"5.6.20";s:13:"mysql_version";s:3:"5.0";s:11:"new_bundled";s:3:"5.3";s:15:"partial_version";s:0:"";}}s:12:"last_checked";i:1607393771;s:15:"version_checked";s:5:"5.5.3";s:12:"translations";a:0:{}}', 'no'),
(127, '_site_transient_timeout_browser_0348215151a4c646280509d77ae2365a', '1607769652', 'no'),
(128, '_site_transient_browser_0348215151a4c646280509d77ae2365a', 'a:10:{s:4:"name";s:6:"Chrome";s:7:"version";s:12:"87.0.4280.66";s:8:"platform";s:7:"Windows";s:10:"update_url";s:29:"https://www.google.com/chrome";s:7:"img_src";s:43:"http://s.w.org/images/browsers/chrome.png?1";s:11:"img_src_ssl";s:44:"https://s.w.org/images/browsers/chrome.png?1";s:15:"current_version";s:2:"18";s:7:"upgrade";b:0;s:8:"insecure";b:0;s:6:"mobile";b:0;}', 'no'),
(129, '_site_transient_timeout_php_check_09a2ad9330cccb8a83c2e6443b87150f', '1607769653', 'no'),
(130, '_site_transient_php_check_09a2ad9330cccb8a83c2e6443b87150f', 'a:5:{s:19:"recommended_version";s:3:"7.4";s:15:"minimum_version";s:6:"5.6.20";s:12:"is_supported";b:1;s:9:"is_secure";b:1;s:13:"is_acceptable";b:1;}', 'no'),
(170, 'current_theme', 'PixieFreak', 'yes'),
(136, 'auto_core_update_notified', 'a:4:{s:4:"type";s:7:"success";s:5:"email";s:21:"kissattilak@gmail.com";s:7:"version";s:5:"5.5.3";s:9:"timestamp";i:1607164856;}', 'no'),
(165, 'adminhash', 'a:2:{s:4:"hash";s:32:"acdecc3087d54d0de21adae782c8e069";s:8:"newemail";s:24:"postmaster@esportplay.hu";}', 'yes'),
(163, 'finished_updating_comment_type', '1', 'yes'),
(154, 'recently_activated', 'a:1:{s:33:"theme-my-login/theme-my-login.php";i:1607182936;}', 'yes'),
(158, 'widget_akismet_widget', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(156, 'auto_update_plugins', 'a:3:{i:0;s:19:"akismet/akismet.php";i:1;s:54:"custom-login-page-templates/custom-login-templates.php";i:2;s:33:"theme-my-login/theme-my-login.php";}', 'no'),
(164, 'new_admin_email', 'kissattilak@gmail.com', 'yes'),
(180, 'widget_pixiefreakpanel_latest_news_widget', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(181, 'widget_pixiefreak_most_popular_news_widget', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(285, 'category_children', 'a:0:{}', 'yes'),
(289, 'theme_mods_pixiefreak', 'a:4:{s:18:"custom_css_post_id";i:-1;s:24:"pixiefreak_primary_color";s:7:"#ed2f2f";s:18:"nav_menu_locations";a:2:{s:11:"header_menu";i:51;s:11:"footer_menu";i:0;}s:11:"custom_logo";i:293;}', 'yes'),
(427, 'recovery_mode_email_last_sent', '1607172971', 'yes'),
(453, 'clpt_template', 'businesscard', 'yes'),
(454, 'clpt_logo', 'http://esportplay.hu/wp-content/uploads/2020/12/qwfqwfcqwqwx.png', 'yes'),
(455, 'clpt_potd', 'on', 'yes'),
(456, 'clpt_bg_image', 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-1.png', 'yes'),
(459, '_site_transient_timeout_browser_f1de45f01dce7e118773299a62ee3415', '1607788342', 'no'),
(460, '_site_transient_browser_f1de45f01dce7e118773299a62ee3415', 'a:10:{s:4:"name";s:7:"unknown";s:7:"version";s:0:"";s:8:"platform";s:0:"";s:10:"update_url";s:0:"";s:7:"img_src";s:0:"";s:11:"img_src_ssl";s:0:"";s:15:"current_version";s:0:"";s:7:"upgrade";b:0;s:8:"insecure";b:0;s:6:"mobile";b:0;}', 'no'),
(461, '_transient_health-check-site-status-result', '{"good":11,"recommended":9,"critical":0}', 'yes');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_about`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_about` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cover` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `banner` varchar(500) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `stats` text COLLATE utf8mb4_unicode_520_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=2 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_about`
--

INSERT INTO `wp_pixiefreak_about` (`id`, `cover`, `banner`, `description`, `stats`, `created_at`) VALUES
(1, 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/8.jpg', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_about.jpg', 'Magyarország jelenleg egyetlen E-Sport Verseny szervezésére alkalmas weboldala vagyunk. 2020 karácsonyán indult el weboldalunk, célunk az hogy egy biztos versenyszervezésre alkalmas platformot tudjunk biztosítani a magyar E-Sportnak.', '[{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/founded-icon.png","title":"K\\u00c9SZ\\u00dcLT","label":"2020"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/earnings-icon.png","title":"NON-PROFIT","label":"100%"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/teams-icon.png","title":"CSAPATUNK","label":"8"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/tournamenrts-icon.png","title":"C\\u00c9LOK","label":"13"}]', '2018-10-22 11:54:38');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_about_staff`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_about_staff` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `role` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `socials` text COLLATE utf8mb4_unicode_520_ci,
  `avatar` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `staff_category_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=12 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_about_staff`
--

INSERT INTO `wp_pixiefreak_about_staff` (`id`, `label`, `name`, `role`, `socials`, `avatar`, `staff_category_id`, `created_at`) VALUES
(10, 'info@esportplay.hu', 'Kiss "itzatesz" Attila', 'CEO', '{"facebook":"","instagram":"","twitter":"https://twitter.com/itzatesz","linkedin":""}', 'http://esportplay.hu/wp-content/uploads/2020/12/Y1xbB3zPGFWArTjRZPRGb.png', 3, '2018-10-22 14:20:50'),
(11, 'info@esportplay.hu', 'Kiss "itzatesz" Attila', 'CEO', '{"facebook":"","instagram":"","twitter":"https://twitter.com/itzatesz","linkedin":""}', 'http://esportplay.hu/wp-content/uploads/2020/12/Y1xbB3zPGFWArTjRZPRGb.png', 1, '2020-12-05 18:47:47');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_about_staff_category`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_about_staff_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=5 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_about_staff_category`
--

INSERT INTO `wp_pixiefreak_about_staff_category` (`id`, `name`, `created_at`) VALUES
(1, 'VERSENYBÍRÓK', '2018-10-22 11:54:38'),
(2, 'KOMMENTÁTOROK', '2018-10-22 13:52:08'),
(3, 'MANAGEMENT', '2018-10-22 13:52:17'),
(4, 'HÍRSZERZŐK', '2020-12-05 17:33:39');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_achievement`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_achievement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `title` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `thumbnail` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=6 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_achievement`
--

INSERT INTO `wp_pixiefreak_achievement` (`id`, `name`, `title`, `slug`, `thumbnail`, `order_number`, `created_at`) VALUES
(2, 'LG Ultragear Warmup Kupa 2020 - 1st', 'LG Ultragear Warmup Kupa 2020 - 1st', 'lg-ultragear-warmup-kupa-2020-1st', 'http://esportplay.hu/wp-content/uploads/2020/12/asd.png', 0, '2018-10-22 17:48:29'),
(5, 'LG Ultragear Warmup Kupa 2020 - 2nd', 'LG Ultragear Warmup Kupa 2020 - 2nd', 'lg-ultragear-warmup-kupa-2020-2nd', 'http://esportplay.hu/wp-content/uploads/2020/12/asd-1.png', 0, '2020-12-05 19:05:16');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_gallery`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_gallery` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_category_id` int(11) DEFAULT '1',
  `image` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=8 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_gallery`
--

INSERT INTO `wp_pixiefreak_gallery` (`id`, `gallery_category_id`, `image`, `slug`, `order_number`, `created_at`) VALUES
(1, 3, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0223.jpg', NULL, 0, '2018-10-24 10:09:47'),
(2, 1, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0b.jpg', NULL, 0, '2018-10-24 15:20:52'),
(3, 1, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0aa.jpg', NULL, 0, '2018-10-24 15:21:14'),
(4, 1, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0223.jpg', NULL, 0, '2018-10-24 15:21:29'),
(5, 1, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0223a.jpg', NULL, 0, '2018-10-24 15:21:47'),
(6, 1, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0az.jpg', NULL, 0, '2018-10-24 15:24:10'),
(7, 1, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/img_0b.jpg', NULL, 0, '2018-10-24 15:24:26');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_gallery_category`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_gallery_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=5 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_gallery_category`
--

INSERT INTO `wp_pixiefreak_gallery_category` (`id`, `name`, `slug`, `created_at`) VALUES
(1, 'Kategorizálatlan', NULL, '2018-10-22 11:54:38'),
(2, 'KÉPEK', NULL, '2018-10-24 10:03:21');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_game`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_game` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `slug` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `thumbnail` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cover` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=6 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_game`
--

INSERT INTO `wp_pixiefreak_game` (`id`, `name`, `slug`, `thumbnail`, `cover`, `created_at`) VALUES
(1, 'Rainbow Six Siege', '', 'http://esportplay.hu/wp-content/uploads/2020/12/Nevtelen-2.png', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/match-page.jpg', '2018-10-22 14:28:43'),
(2, 'League of Legends', '', 'http://esportplay.hu/wp-content/uploads/2020/12/wcwcw.png', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/match-page.jpg', '2018-10-22 14:33:53'),
(4, 'Counter-Strike: Global Offensive', NULL, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/csgo_logo.png', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/match-page.jpg', '2018-10-22 14:34:25'),
(5, 'FIFA 21', '', 'http://esportplay.hu/wp-content/uploads/2020/12/qwcqwcqc.png', '', '2020-11-28 22:27:13');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_gear`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_gear` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `image` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `link` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `recommended` int(11) DEFAULT NULL,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=5 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_gear`
--

INSERT INTO `wp_pixiefreak_gear` (`id`, `name`, `type`, `image`, `link`, `recommended`, `order_number`, `created_at`) VALUES
(1, 'LOGITECH H9189', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1-a.png', '', 2, 0, '2018-10-22 16:54:45'),
(2, 'LOGITECH H9189', 1, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3a.png', '', 2, 0, '2018-10-22 16:55:16'),
(3, 'LOGITECH H9189', 2, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3a.png', '', 1, 0, '2018-10-22 16:55:42'),
(4, 'Billentyuzet', 2, 'http://esportplay.hu/wp-content/uploads/2020/12/DdbZTQYVQAAMPMP.jpg', '', 2, 0, '2020-12-05 20:01:21');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_global_settings`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_global_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_520_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=63 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_global_settings`
--

INSERT INTO `wp_pixiefreak_global_settings` (`id`, `module_name`, `key`, `value`, `created_at`) VALUES
(1, 'general', 'social', '{"facebook":"https://www.facebook.com/hrchivatalos","twitter":"https://twitter.com/r6hrc","twitch":"https://www.twitch.tv/esport1tv","discord":"","youtube":"https://www.youtube.com/channel/UCkdzqQekXHKJubFdbYEs-7g","instagram":"https://www.instagram.com/magyaresportbajnoksag/","steam":""}', '2018-10-22 11:54:38'),
(2, 'general', 'copyright', 'Powered by Forpsi.hu 2020-2021 All Rights Reserved.', '2018-10-22 11:54:38'),
(3, 'general', 'show_socials_header', '1', '2018-10-22 11:54:38'),
(4, 'general', 'show_socials_footer', '1', '2018-10-22 11:54:38'),
(5, 'general', 'show_search', '1', '2018-10-22 11:54:38'),
(6, 'general', 'show_copyright', '1', '2018-10-22 11:54:38'),
(7, 'general', 'section_order', '{"1":"News","2":"Team","3":"Stream","4":"Tournament","5":"Shop","6":"Match Result"}', '2018-10-22 11:54:38'),
(8, 'general', 'section_visibility', '{"sponsor":true,"news":true,"team":true,"stream":true,"tournament":true,"shop":false,"match-result":true}', '2018-10-22 11:54:38'),
(9, 'general', 'get_in_touch_1', '{"icon":"fas fa-info","title":"\\u00c1ltal\\u00e1nos inform\\u00e1ci\\u00f3k","subtitle":"info@esportplay.hu","show":"1"}', '2018-10-22 11:54:38'),
(10, 'general', 'get_in_touch_2', '{"icon":"fas fa-bookmark","title":"Partner \\u00fcgyint\\u00e9z\\u00e9s","subtitle":"partner@esportplay.hu","show":"1"}', '2018-10-22 11:54:38'),
(11, 'general', 'get_in_touch_3', '{"icon":"fab fa-hotjar","title":"Marketing","subtitle":"press@pixiefusion.com","show":"0"}', '2018-10-22 11:54:38'),
(12, 'general', 'get_in_touch_4', '{"icon":"fas fa-bell","title":"M\\u00e9dia","subtitle":"media@esportplay.hu","show":"1"}', '2018-10-22 11:54:38'),
(13, 'about', 'who_we_are', 'KIK VAGYUNK', '2018-10-22 11:54:38'),
(14, 'about', 'some_more', 'Tudj meg többet a csapatról', '2018-10-22 11:54:38'),
(15, 'about', 'media_kit', '{"text":"Media kit","link":"#","show":"0"}', '2018-10-22 11:54:38'),
(16, 'about', 'all_teams', '{"text":"Jelentkez\\u00e9s","link":"#","show":"1"}', '2018-10-22 11:54:38'),
(17, 'about', 'about_first', '{"icon":"fas fa-map-marker-alt","title":"Belgrade, Serbia","subtitle":"Kielbasnicza 6/3, 50-108","show":"0"}', '2018-10-22 11:54:38'),
(18, 'about', 'about_second', '{"icon":"fas fa-map-marker-alt","title":"Warsaw (HQ)","subtitle":"Finlandzka 10, 03-903","show":"0"}', '2018-10-22 11:54:38'),
(19, 'about', 'about_third', '{"icon":"fas fa-map-marker-alt","title":"Atlanta","subtitle":"3423 Piedmont Rd NE, GA 30305","show":"0"}', '2018-10-22 11:54:38'),
(20, 'about', 'about_fourth', '{"icon":"fas fa-map-marker-alt","title":"Poznan","subtitle":"Kielbasnicza 6/3, 50-108","show":"0"}', '2018-10-22 11:54:38'),
(21, 'sponsor', 'banner_image', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg', '2018-10-22 11:54:38'),
(22, 'sponsor', 'title', 'Partnereink', '2018-10-22 11:54:38'),
(23, 'sponsor', 'subtitle', 'Támogatásukkal sikeresebb és tartalmasabb az oldalunk', '2018-10-22 11:54:38'),
(24, 'sponsor', 'show_title', '1', '2018-10-22 11:54:38'),
(25, 'sponsor', 'show_subtitle', '1', '2018-10-22 11:54:38'),
(26, 'sponsor', 'cta', '{"text":"MEG\\u00c1LLAPOD\\u00c1S","link":"","show":"1"}', '2018-10-22 11:54:38'),
(27, 'gear', 'cta', '{"text":"Become a player","link":"#","show":true}', '2018-10-22 11:54:38'),
(28, 'stream', 'banner_image', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/5.jpg', '2018-10-22 11:54:38'),
(29, 'stream', 'api', '{"youtube":"AIzaSyAxayP_9dvJiFLUWh9tAqmQamA_A5dp460","twitch":"tbw3tkm7nanmocbga94p30rbv230ad","mixer":""}', '2018-10-22 11:54:38'),
(30, 'gallery', 'banner_image', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/01.jpg', '2018-10-22 11:54:38'),
(31, 'gallery', 'title', 'Nézz képeket a rendezvényekről', '2018-10-22 11:54:38'),
(32, 'gallery', 'subtitle', 'Légy friss az újdonsággokkal', '2018-10-22 11:54:38'),
(33, 'team', 'team_banner_image', 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/team_logo_02.png', '2018-10-22 11:54:38'),
(34, 'team', 'roster_title', 'Ismerd meg a játékosokat', '2018-10-22 11:54:38'),
(35, 'team', 'roster_subtitle', 'A csapat büszke játékosai egy helyen', '2018-10-22 11:54:38'),
(36, 'team', 'cta', '{"text":"A csapat oldala","link":"","show":"1"}', '2018-10-22 11:54:38'),
(37, 'teams', 'teams_banner_image', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg', '2018-10-22 11:54:38'),
(38, 'teams', 'title', 'A Magyar csapatok', '2018-10-22 11:54:38'),
(39, 'teams', 'subtitle', 'Itt megtalálhatod a magyar csapatok többségét', '2018-10-22 11:54:38'),
(40, 'teams', 'cta_left', '{"text":"All","link":"#","show":"1"}', '2018-10-22 11:54:38'),
(41, 'teams', 'cta_right', '{"text":"Popular","link":"#","show":"1"}', '2018-10-22 11:54:38'),
(42, 'player', 'cta_player', '{"text":"FELKERES\\u00c9S","link":"#","icon":"fas fa-audio-description","show":"1"}', '2018-10-22 11:54:38'),
(43, 'routes', 'routes', '{"match":{"query":"match_slug","route":"match"},"player":{"query":"player_slug","route":"player"},"team":{"query":"team_slug","route":"team"},"tournament":{"query":"tournament_slug","route":"tournament"},"stream":{"query":"stream_slug","route":"stream"},"bracket":{"query":"bracket_slug","route":"bracket"}}', '2018-10-22 11:54:38'),
(44, 'tournament', 'tournament_banner_image', 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/background-copy-1.jpg', '2018-10-22 11:54:38'),
(45, 'tournament', 'title', 'Our tournaments', '2018-10-22 11:54:38'),
(46, 'tournament', 'subtitle', 'This is where you can browse through our tournaments', '2018-10-22 11:54:38'),
(47, 'tournament', 'cta_top', '{"text":"a","link":"#","show":"1"}', '2018-10-22 11:54:38'),
(48, 'tournament', 'cta_left', '{"text":"JELENTKEZ\\u00c9S","link":"","show":"1"}', '2018-10-22 11:54:38'),
(49, 'tournament', 'cta_right', '{"text":"HELY IG\\u00c9NYL\\u00c9S","link":"","show":"0"}', '2018-10-22 11:54:38'),
(50, 'tournaments', 'banner_image', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg', '2018-10-22 11:54:38'),
(51, 'tournaments', 'title', 'Versenyek', '2018-10-22 11:54:38'),
(52, 'tournaments', 'subtitle', 'Itt megtalálhatsz minden hivatalos Magyar E-Sport versenyt', '2018-10-22 11:54:38'),
(53, 'tournaments', 'cta_left', '{"text":"Upcoming","link":"#","show":"1"}', '2018-10-22 11:54:38'),
(54, 'tournaments', 'cta_right', '{"text":"Results","link":"#","show":"1"}', '2018-10-22 11:54:38'),
(55, 'match', 'title', 'Korábbi mérkőzések & eredmények', '2018-10-22 11:54:38'),
(56, 'match', 'subtitle', 'Ez egy folyamatos frissítés alatt álló szekció', '2018-10-22 11:54:38'),
(57, 'match', 'cta_left', '{"text":"Upcoming","link":"#","show":"0"}', '2018-10-22 11:54:38'),
(58, 'match', 'cta_right', '{"text":"Results","link":"#","show":"0"}', '2018-10-22 11:54:38'),
(59, 'match', 'cta_match', '{"text":"Article","link":"#","show":true}', '2018-10-22 11:54:38'),
(60, 'match', 'banner_image', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/8.jpg', '2018-10-22 11:54:38'),
(61, 'general', 'default_background', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/5.jpg', '2018-10-26 10:31:07'),
(62, 'general', 'notfound_background', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/1.jpg', '2018-10-26 10:31:07');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_match`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_match` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=40 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_match`
--

INSERT INTO `wp_pixiefreak_match` (`id`, `game_id`, `slug`, `start_date`, `tournament_id`, `team_a_id`, `team_a_name`, `team_a_logo`, `team_a_result`, `team_b_id`, `team_b_name`, `team_b_logo`, `team_b_result`, `status`, `cta_match_text`, `cta_match_link`, `stream_id`, `type`, `created_at`) VALUES
(14, 1, 'kmk-bravo-conqueror-grizzlys-14', '2020-12-05 18:23:33', 5, 15, 'KmK Bravo', 'http://esportplay.hu/wp-content/uploads/2020/12/1605446609632.jpg', 1, 9, 'Conqueror Grizzlys', 'http://esportplay.hu/wp-content/uploads/2020/12/1606485698267.jpg', 0, 3, '', '', 0, 2, '2020-12-05 18:23:33'),
(15, 1, 'lfo-lvlup-esport-15', '2020-12-05 18:25:36', 5, 25, 'LFO', '', 0, 17, 'LvLUp Esport', 'http://esportplay.hu/wp-content/uploads/2020/12/1599839767029.png', 1, 3, '', '', 4, 2, '2020-12-05 18:25:36'),
(16, 1, 'cartel-arrow-gaming-16', '2020-12-05 18:26:03', 5, 23, 'Cartel', 'http://esportplay.hu/wp-content/uploads/2020/12/1605294552471.png', 0, 19, 'Arrow Gaming', 'http://esportplay.hu/wp-content/uploads/2020/12/1605813791071.png', 1, 3, '', '', 4, 2, '2020-12-05 18:26:03'),
(17, 1, 'necrotic-esports-homeless-17', '2020-12-05 18:26:29', 5, 16, 'Necrotic Esports', 'http://esportplay.hu/wp-content/uploads/2020/12/1605895092964.png', 0, 24, 'Homeless', '', 1, 3, '', '', 4, 2, '2020-12-05 18:26:29'),
(18, 1, 'hol-a-refrag-s4-18', '2020-12-05 18:26:55', 5, 27, 'Hol a refrag?', '', 1, 18, 'S4', 'http://esportplay.hu/wp-content/uploads/2020/12/1592040949034.png', 0, 3, '', '', 4, 2, '2020-12-05 18:26:55'),
(19, 1, 'nice-gaming-all-stars-19', '2020-12-05 18:27:20', 5, 26, 'Nice Gaming', '', 1, 10, 'All Stars', 'http://esportplay.hu/wp-content/uploads/2020/12/1605790863194.jpg', 0, 3, '', '', 4, 2, '2020-12-05 18:27:20'),
(20, 1, 'compisranked-bekescsabai-esport-egyesulet-black-20', '2020-12-05 18:27:51', 5, 12, 'CompIsRanked', 'http://esportplay.hu/wp-content/uploads/2020/12/1605697469945.jpg', 1, 11, 'BÉKÉSCSABAI ESPORT EGYESÜLET BLACK', 'http://esportplay.hu/wp-content/uploads/2020/12/1591557903247.jpg', 0, 3, '', '', 4, 2, '2020-12-05 18:27:51'),
(21, 1, 'team-spiritus-eaglesports-21', '2020-12-05 18:28:22', 5, 13, 'Team Spiritus', 'http://esportplay.hu/wp-content/uploads/2020/12/1605650349538.png', 0, 14, 'EagleSports', 'http://esportplay.hu/wp-content/uploads/2020/12/1605951181721.png', 1, 3, '', '', 4, 2, '2020-12-05 18:28:22'),
(22, 1, 'kmk-bravo-lvlup-esport-22', '2020-12-05 18:28:50', 5, 15, 'KmK Bravo', 'http://esportplay.hu/wp-content/uploads/2020/12/1605446609632.jpg', 2, 17, 'LvLUp Esport', 'http://esportplay.hu/wp-content/uploads/2020/12/1599839767029.png', 0, 3, '', '', 4, 2, '2020-12-05 18:28:50'),
(23, 1, 'arrow-gaming-homeless-23', '2020-12-05 18:29:18', 5, 19, 'Arrow Gaming', 'http://esportplay.hu/wp-content/uploads/2020/12/1605813791071.png', 0, 24, 'Homeless', '', 2, 3, '', '', 4, 2, '2020-12-05 18:29:18'),
(24, 1, 'hol-a-refrag-nice-gaming-24', '2020-12-05 18:29:48', 5, 27, 'Hol a refrag?', '', 0, 26, 'Nice Gaming', '', 2, 3, '', '', 4, 2, '2020-12-05 18:29:48'),
(25, 1, 'compisranked-eaglesports-25', '2020-12-05 18:30:21', 5, 12, 'CompIsRanked', 'http://esportplay.hu/wp-content/uploads/2020/12/1605697469945.jpg', 2, 14, 'EagleSports', 'http://esportplay.hu/wp-content/uploads/2020/12/1605951181721.png', 0, 3, '', '', 4, 2, '2020-12-05 18:30:21'),
(26, 1, 'illes-akademia-spirit-nice-gaming-26', '2020-12-05 18:57:10', 6, 29, 'Illes Akademia Spirit', 'http://esportplay.hu/wp-content/uploads/2020/12/1605980084802.png', 1, 26, 'Nice Gaming', '', 0, 3, '', '', 4, 2, '2020-12-05 18:57:10'),
(27, 1, 'wild-multigaming-kmk-bravo-27', '2020-12-05 18:57:31', 6, 8, 'WiLD Multigaming', 'http://esportplay.hu/wp-content/uploads/2020/12/WiLD_MultiGaminglogo_square.png', 1, 15, 'KmK Bravo', 'http://esportplay.hu/wp-content/uploads/2020/12/1605446609632.jpg', NULL, 1, '', '', 4, 2, '2020-12-05 18:57:31'),
(28, 1, 'team-plague-compisranked-28', '2020-12-05 18:58:06', 6, 28, 'Team Plague', 'http://esportplay.hu/wp-content/uploads/2020/12/1604848919602.jpg', 1, 12, 'CompIsRanked', 'http://esportplay.hu/wp-content/uploads/2020/12/1605697469945.jpg', 0, 1, '', '', 4, 2, '2020-12-05 18:58:06'),
(29, 1, 'genesis-gaming-homeless-29', '2020-12-05 18:58:45', 6, 30, 'Genesis Gaming', 'http://esportplay.hu/wp-content/uploads/2020/12/1605982928427.jpg', 0, 24, 'Homeless', '', 1, 3, '', '', 4, 2, '2020-12-05 18:58:45'),
(30, 1, 'illes-akademia-spirit-kmk-bravo-30', '2020-12-05 18:59:14', 6, 29, 'Illes Akademia Spirit', 'http://esportplay.hu/wp-content/uploads/2020/12/1605980084802.png', 1, 15, 'KmK Bravo', 'http://esportplay.hu/wp-content/uploads/2020/12/1605446609632.jpg', 0, 1, '', '', 4, 2, '2020-12-05 18:59:14'),
(31, 1, 'compisranked-genesis-gaming-31', '2020-12-05 18:59:43', 6, 12, 'CompIsRanked', 'http://esportplay.hu/wp-content/uploads/2020/12/1605697469945.jpg', 0, 30, 'Genesis Gaming', 'http://esportplay.hu/wp-content/uploads/2020/12/1605982928427.jpg', 1, 3, '', '', 4, 2, '2020-12-05 18:59:43'),
(32, 1, 'nice-gaming-wild-multigaming-32', '2020-12-05 19:00:11', 6, 26, 'Nice Gaming', '', 0, 8, 'WiLD Multigaming', 'http://esportplay.hu/wp-content/uploads/2020/12/WiLD_MultiGaminglogo_square.png', 1, 1, '', '', 4, 2, '2020-12-05 19:00:11'),
(33, 1, 'team-plague-homeless-33', '2020-12-05 19:00:40', 6, 28, 'Team Plague', 'http://esportplay.hu/wp-content/uploads/2020/12/1604848919602.jpg', 1, 24, 'Homeless', '', 0, 1, '', '', 4, 2, '2020-12-05 19:00:40'),
(34, 1, 'illes-akademia-spirit-homeless-34', '2020-12-05 19:01:23', 6, 29, 'Illes Akademia Spirit', 'http://esportplay.hu/wp-content/uploads/2020/12/1605980084802.png', 1, 24, 'Homeless', '', 0, 3, '', '', 4, 2, '2020-12-05 19:01:23'),
(35, 1, 'genesis-gaming-nice-gaming-35', '2020-12-05 19:01:48', 6, 30, 'Genesis Gaming', 'http://esportplay.hu/wp-content/uploads/2020/12/1605982928427.jpg', 1, 26, 'Nice Gaming', '', 0, 3, '', '', 4, 2, '2020-12-05 19:01:48'),
(36, 1, 'illes-akademia-spirit-genesis-gaming-36', '2020-12-05 19:02:21', 6, 29, 'Illes Akademia Spirit', 'http://esportplay.hu/wp-content/uploads/2020/12/1605980084802.png', 1, 30, 'Genesis Gaming', 'http://esportplay.hu/wp-content/uploads/2020/12/1605982928427.jpg', 0, 3, '', '', 4, 2, '2020-12-05 19:02:21'),
(37, 1, 'wild-multigaming-team-plague-37', '2020-12-05 19:02:53', 6, 8, 'WiLD Multigaming', 'http://esportplay.hu/wp-content/uploads/2020/12/WiLD_MultiGaminglogo_square.png', 2, 28, 'Team Plague', 'http://esportplay.hu/wp-content/uploads/2020/12/1604848919602.jpg', 1, 3, '', '', 4, 2, '2020-12-05 19:02:53'),
(38, 1, 'illes-akademia-spirit-team-plague-38', '2020-12-05 19:03:24', 6, 29, 'Illes Akademia Spirit', 'http://esportplay.hu/wp-content/uploads/2020/12/1605980084802.png', 2, 28, 'Team Plague', 'http://esportplay.hu/wp-content/uploads/2020/12/1604848919602.jpg', 0, 3, '', '', 4, 2, '2020-12-05 19:03:24'),
(39, 1, 'wild-multigaming-illes-akademia-spirit-39', '2020-12-05 19:03:43', 6, 8, 'WiLD Multigaming', 'http://esportplay.hu/wp-content/uploads/2020/12/WiLD_MultiGaminglogo_square.png', 2, 29, 'Illes Akademia Spirit', 'http://esportplay.hu/wp-content/uploads/2020/12/1605980084802.png', 1, 1, '', '', 4, 2, '2020-12-05 19:03:43');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_player`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_player` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=8 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_player`
--

INSERT INTO `wp_pixiefreak_player` (`id`, `first_name`, `last_name`, `nickname`, `role`, `team_id`, `avatar`, `avatar_transparent`, `banner`, `slug`, `thumbnail`, `cover`, `stats`, `biography`, `country`, `birth_date`, `social`, `order_number`, `created_at`) VALUES
(3, 'Djordje', 'Djuza', 'George', 'Captain', 1, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/player_89.jpg', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/djuza.png', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_player.jpg', 'george', NULL, 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/8.jpg', '[{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4.png","title":"DEATHS","label":"900"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3.png","title":"KILLS","label":"231"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1.png","title":"HEADSHOTS","label":"450"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2.png","title":"SNIPERS","label":"300"}]', 'Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard''s Terms Of Use.', 'AM', '23', '{"facebook":"","instagram":"","discord":"","steam":"","twitch":"","twitter":""}', 0, '2018-10-23 12:19:57'),
(4, 'Master', 'Mind', 'm89s', 'SNIPER', 1, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/player_9111.jpg', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/moma.png', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_player.jpg', 'm89s', NULL, 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/1.jpg', '[{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4.png","title":"DEATHS","label":"234"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2.png","title":"KILLS","label":"900"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1.png","title":"HEAD SHOTS","label":"456"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3.png","title":"RIFFLE","label":"34"}]', 'Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard''s Terms Of Use.\n\n', 'FR', '32', '{"facebook":"","instagram":"","discord":"","steam":"","twitch":"","twitter":""}', 0, '2018-10-23 12:25:05'),
(5, 'Alex', 'Andar', 'Alexyyy', 'RIFFLE', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/player_94.jpg', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/alex.png', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_player.jpg', 'alexyyy', NULL, 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg', '[{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4.png","title":"KILLS","label":"589"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2.png","title":"DEATHS","label":"350"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1.png","title":"HEAD SHOTS","label":"200"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3.png","title":"RIFFLE","label":"35"}]', 'Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard''s Terms Of Use.', 'DE', '18', '{"facebook":"","instagram":"","discord":"","steam":"","twitch":"","twitter":""}', 0, '2018-10-23 12:26:53'),
(6, 'Raf', 'Camora', 'rafkabrat', 'SINGER', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/player_92.jpg', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/stamenix.png', 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/cover_player.jpg', 'rafkabrat', NULL, 'http://themes.pixiesquad.com/pixiefreak/unforgivable-sear/wp-content/uploads/2018/11/9.jpg', '[{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/4.png","title":"DEATHS","label":"410"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/2.png","title":"KILLS","label":"200"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/1.png","title":"HEAD SHOTS","label":"256"},{"icon":"http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-content/uploads/2018/10/3.png","title":"RIFFLE","label":"579"}]', 'Prior to major incidents in the Overwatch League, there were known cases of controversial acts. His account was suspended twice for violating Blizzard''s Terms Of Use.', 'IT', '34', '{"facebook":"","instagram":"","discord":"","steam":"","twitch":"","twitter":""}', 0, '2018-10-23 12:30:55'),
(7, 'Nem', 'Tudom', 'Strajk', 'Support', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/VrLzVW10_400x400.png', 'http://esportplay.hu/wp-content/uploads/2020/12/VrLzVW10_400x400.png', 'http://esportplay.hu/wp-content/uploads/2020/12/asdasd.png', 'strajk', NULL, 'http://esportplay.hu/wp-content/uploads/2020/12/67061218_2651847281506495_3289316139754061824_n.jpg', '[{"icon":"","title":"","label":""},{"icon":"","title":"","label":""},{"icon":"","title":"","label":""},{"icon":"","title":"","label":""}]', 'Contact or Business inquiries : expired17official@gmail.com\nDuos: @PanikyFPS | @REDGROOVE\n@Twitch partner', 'HU', '15', '{"facebook":"","instagram":"","discord":"","steam":"","twitch":"","twitter":"https://twitter.com/STRiKE_R6"}', 0, '2020-12-05 20:09:15');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_player_gear`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_player_gear` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) DEFAULT NULL,
  `gear_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=29 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_player_gear`
--

INSERT INTO `wp_pixiefreak_player_gear` (`id`, `player_id`, `gear_id`, `created_at`) VALUES
(14, 3, 1, '2018-10-23 12:20:07'),
(15, 3, 2, '2018-10-23 12:20:07'),
(16, 3, 3, '2018-10-23 12:20:07'),
(17, 4, 1, '2018-10-23 15:12:13'),
(18, 4, 2, '2018-10-23 15:12:13'),
(19, 4, 3, '2018-10-23 15:12:13'),
(20, 5, 1, '2018-10-23 15:13:48'),
(21, 5, 2, '2018-10-23 15:13:48'),
(22, 5, 3, '2018-10-23 15:13:48'),
(23, 6, 1, '2018-10-23 15:16:26'),
(24, 6, 2, '2018-10-23 15:16:26'),
(25, 6, 3, '2018-10-23 15:16:26'),
(26, 7, 2, '2020-12-05 20:11:05'),
(27, 7, 3, '2020-12-05 20:11:05'),
(28, 7, 4, '2020-12-05 20:11:05');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_player_stream`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_player_stream` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) DEFAULT NULL,
  `stream_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=22 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_slider`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_slider` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=10 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_slider`
--

INSERT INTO `wp_pixiefreak_slider` (`id`, `heading_text`, `tag`, `image`, `thumbnail`, `cta_text`, `cta_link`, `order_number`, `created_at`) VALUES
(5, 'E-Sport versenyek profi és amatőr játékosok számára', 'ESPORTPLAY.HU', 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-1.png', 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o.png', 'TOVÁBB', '', 0, '2018-10-22 16:03:57'),
(6, 'Jelentkezz Magyarország legnagyobb E-Sport versenyeire', 'ESPORTPLAY.HU', 'http://esportplay.hu/wp-content/uploads/2020/12/qc.png', 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4.png', 'VERSENYEK', 'http://esportplay.hu/tournaments/', 0, '2018-10-22 16:10:07'),
(8, 'Érd el céljaid és légy a legjobb', 'ESPORTPLAY.HU', 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-3.png', 'http://esportplay.hu/wp-content/uploads/2020/12/qw.png', 'EREDMÉNYEK', 'http://esportplay.hu/matches/', 0, '2018-10-22 16:20:57'),
(9, 'Tanulj, játssz és fejlődj a legjobbakkal', 'ESPORTPLAY.HU', 'http://esportplay.hu/wp-content/uploads/2020/12/ww.png', 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-2.png', 'FACEIT', 'https://bit.do/hrcplay', 0, '2020-12-05 12:00:50');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_sponsor`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_sponsor` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=17 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_sponsor`
--

INSERT INTO `wp_pixiefreak_sponsor` (`id`, `name`, `logo`, `url`, `about`, `social`, `type`, `order_number`, `created_at`) VALUES
(1, '1', 'http://esportplay.hu/wp-content/uploads/2020/12/hrcs2.png', 'https://bit.do/hrcplay', 'A Hungarian Rainbow6 Challengers - Faceit oldala annak érdekében készült el, hogy a Magyar közösség játékosai egy magyar légtérben játszhassanak', '{"facebook":"http://esportplay.hu/sponsor/","instagram":"http://esportplay.hu/sponsor/","twitter":"http://esportplay.hu/sponsor/","twitch":"http://esportplay.hu/sponsor/","steam":"http://esportplay.hu/sponsor/"}', 2, 0, '2018-10-22 15:06:37'),
(15, 'Esport1', 'http://esportplay.hu/wp-content/uploads/2020/12/logo-e1hu.png', '2', 'Minden Esport 1 helyen', '{"facebook":"http://esportplay.hu/","instagram":"http://esportplay.hu/","twitter":"http://esportplay.hu/","twitch":"http://esportplay.hu/","steam":"http://esportplay.hu/"}', 2, 0, '2020-12-05 19:32:01'),
(16, 'HUNESZ', 'http://esportplay.hu/wp-content/uploads/2020/12/1f382cebb409e9d5b9af36ab3c6e3dd02085d66d.png', '3', 'Magyarország legnagyobb E-Sport szövetsége', '{"facebook":"http://esportplay.hu/","instagram":"http://esportplay.hu/","twitter":"http://esportplay.hu/","twitch":"http://esportplay.hu/","steam":"http://esportplay.hu/"}', 2, 0, '2020-12-05 19:34:01');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_stream`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_stream` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=5 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_stream`
--

INSERT INTO `wp_pixiefreak_stream` (`id`, `title`, `subtitle`, `slug`, `thumbnail`, `link`, `is_online`, `view`, `order_number`, `type`, `created_at`) VALUES
(4, 'ESPORT1TV', 'Minden esport 1 helyen', 'esport1tv', 'http://esportplay.hu/wp-content/uploads/2020/12/846ab15d-f0f3-4e41-89b2-176ec0e560c3-profile_image-300x300-1.png', 'https://www.twitch.tv/esport1tv', 1, 0, 0, 2, '2020-12-05 18:24:42');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_team`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_team` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=31 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_team`
--

INSERT INTO `wp_pixiefreak_team` (`id`, `name`, `short_name`, `subtitle`, `slug`, `country`, `game_id`, `team_logo`, `cover`, `thumbnail`, `stats`, `about`, `my_team`, `year_founded`, `social`, `order_number`, `created_at`) VALUES
(8, 'WiLD Multigaming', NULL, NULL, 'wild-multigaming', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/WiLD_MultiGaminglogo_square.png', 'http://esportplay.hu/wp-content/uploads/2020/12/67061218_2651847281506495_3289316139754061824_n.jpg', 'http://esportplay.hu/wp-content/uploads/2020/12/79405682_2955950724429481_3204597050847002624_o.jpg', '{"win":"4","loses":"0","ties":"0"}', 'MultiGaming is a professional video gaming team. Our goal is to become the leading Hungarian esports organization', 1, '2020-12-05 15:21:33', '{"facebook":"https://www.facebook.com/wildclan.hu/","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 15:21:44'),
(9, 'Conqueror Grizzlys', NULL, NULL, 'conqueror-grizzlys', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1606485698267.jpg', '', '', NULL, '', 1, '2020-12-05 17:53:19', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 17:53:28'),
(10, 'All Stars', NULL, NULL, 'all-stars', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1605790863194.jpg', '', '', NULL, '', 1, '2020-12-05 17:54:19', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 17:54:22'),
(11, 'BÉKÉSCSABAI ESPORT EGYESÜLET BLACK', NULL, NULL, 'bekescsabai-esport-egyesulet-black', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1591557903247.jpg', '', '', NULL, '', 1, '2020-12-05 17:55:23', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 17:55:26'),
(12, 'CompIsRanked', NULL, NULL, 'compisranked', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1605697469945.jpg', '', '', NULL, '', 1, '2020-12-05 17:56:10', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 17:56:12'),
(13, 'Team Spiritus', NULL, NULL, 'team-spiritus', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1605650349538.png', '', '', NULL, '', 1, '2020-12-05 17:57:23', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 17:57:25'),
(14, 'EagleSports', NULL, NULL, 'eaglesports', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1605951181721.png', '', '', NULL, '', 1, '2020-12-05 17:58:28', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 17:58:30'),
(15, 'KmK Bravo', NULL, NULL, 'kmk-bravo', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1605446609632.jpg', '', '', NULL, '', 1, '2020-12-05 17:59:25', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 17:59:28'),
(16, 'Necrotic Esports', NULL, NULL, 'necrotic-esports', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1605895092964.png', '', '', NULL, '', 1, '2020-12-05 18:00:15', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:00:18'),
(17, 'LvLUp Esport', NULL, NULL, 'lvlup-esport', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1599839767029.png', '', '', NULL, '', 1, '2020-12-05 18:01:28', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:01:30'),
(18, 'S4', NULL, NULL, 's4', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1592040949034.png', '', '', NULL, '', 1, '2020-12-05 18:02:14', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:02:17'),
(19, 'Arrow Gaming', NULL, NULL, 'arrow-gaming', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1605813791071.png', '', '', NULL, '', 1, '2020-12-05 18:03:14', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:03:34'),
(23, 'Cartel', NULL, NULL, 'cartel', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1605294552471.png', '', '', NULL, '', 1, '2020-12-05 18:05:01', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:05:03'),
(24, 'Homeless', NULL, NULL, 'homeless', 'HU', 1, '', '', '', NULL, '', 1, '2020-12-05 18:05:32', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:05:34'),
(25, 'LFO', NULL, NULL, 'lfo', 'HU', 1, '', '', '', NULL, '', 1, '2020-12-05 18:05:59', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:06:01'),
(26, 'Nice Gaming', NULL, NULL, 'nice-gaming', 'HU', 1, '', '', '', NULL, '', 1, '2020-12-05 18:06:20', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:06:22'),
(27, 'Hol a refrag?', NULL, NULL, 'hol-a-refrag', 'HU', 1, '', '', '', NULL, '', 1, '2020-12-05 18:06:40', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:06:42'),
(28, 'Team Plague', NULL, NULL, 'team-plague', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1604848919602.jpg', '', '', NULL, '', 1, '2020-12-05 18:07:56', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:07:58'),
(29, 'Illes Akademia Spirit', NULL, NULL, 'illes-akademia-spirit', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1605980084802.png', 'http://esportplay.hu/wp-content/uploads/2020/12/1605980084802.png', '', '{"win":"4","loses":"2","ties":"0"}', 'Hungarian Nationals participant! The most professional team in the area with the first gamer house in HUNGARY!', 1, '2020-12-05 18:09:30', '{"facebook":"https://www.facebook.com/IlleSpirit/","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:09:32'),
(30, 'Genesis Gaming', NULL, NULL, 'genesis-gaming', 'HU', 1, 'http://esportplay.hu/wp-content/uploads/2020/12/1605982928427.jpg', '', '', NULL, '', 1, '2020-12-05 18:10:20', '{"facebook":"","instagram":"","twitch":"","steam":""}', 0, '2020-12-05 18:10:22');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_team_achievement`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_team_achievement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `achievement_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=26 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_team_achievement`
--

INSERT INTO `wp_pixiefreak_team_achievement` (`id`, `team_id`, `achievement_id`, `created_at`) VALUES
(24, 8, 2, '2020-12-05 19:13:17'),
(25, 29, 5, '2020-12-05 19:15:35');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_team_player`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_team_player` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `player_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=75 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_team_player`
--

INSERT INTO `wp_pixiefreak_team_player` (`id`, `team_id`, `player_id`, `created_at`) VALUES
(65, 29, 3, '2020-12-05 19:16:03'),
(66, 29, 4, '2020-12-05 19:16:03'),
(67, 29, 5, '2020-12-05 19:16:03'),
(68, 29, 6, '2020-12-05 19:16:03'),
(74, 8, 7, '2020-12-05 20:10:08');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_team_stream`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_team_stream` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `stream_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=21 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_team_stream`
--

INSERT INTO `wp_pixiefreak_team_stream` (`id`, `team_id`, `stream_id`, `created_at`) VALUES
(19, 8, 4, '2020-12-05 19:13:08'),
(20, 29, 4, '2020-12-05 19:15:42');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_tournament`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_tournament` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=7 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_tournament`
--

INSERT INTO `wp_pixiefreak_tournament` (`id`, `name`, `slug`, `cover`, `logo`, `thumbnail`, `banner`, `location`, `start_date`, `game_id`, `about`, `social`, `team_number`, `group_number`, `prize_pool`, `random_rule`, `status`, `brackets`, `created_at`) VALUES
(5, 'LG UltraGear R6S Warmup kupa - Nyílt selejtező', 'lg-ultragear-r6s-warmup-kupa-nyilt-selejtezo', 'http://esportplay.hu/wp-content/uploads/2020/12/thumb-1920-676369.jpg', 'http://esportplay.hu/wp-content/uploads/2020/12/asd.png', 'http://esportplay.hu/wp-content/uploads/2020/12/1604843695326.jpg', 'http://esportplay.hu/wp-content/uploads/2020/12/1604843695326.jpg', 'Hungary', '2021-01-22 14:00:00', 1, 'Üdvözlünk az LG UltraGear R6S Warmup kupa nyílt selejtezőjének regisztrációs oldalán! Itt az év vége, azonban nem szabad megállni, a bemelegítés még csak most kezdődik! A következő sorokban minden fontos információt megtalálsz ami a versennyel kapcsolatos, legyen szó a verseny lebonyolításáról, kiemelt szabályzattal kapcsolatos pontokról, vagy a kupa pontos időpontjaira vonatkozó információkról. A nyílt selejtező célja, hogy meghatározza, kik azok a csapatok, akik továbbjutnak a November 22-én megrendezésre kerülő rájátszásba. Ezúton is sok sikert és jó játékot kívánunk minden résztvevőnek!\n\n\nA versenyre a következő alapszabályzatok vonatkoznak:\n\nMagyar E-sport Szövetség Versenyszabályzata\nMagyar E-sport Szövetség Etikai és Gyermekvédelmi szabályzata\nMagyar E-sport Szövetség Fegyelmi szabályzat\nMagyar E-sport Szövetség: https://bit.ly/37xIJHi\n\n\nKiemelt általános szabályzat:\n\nÉletkori szabályozások: A versenyen csak 16. életévüket betöltött játékosok indulhatnak. A 16 és 18 év közötti játékosoknak kötelező szülői hozzájárulást kitölteni és azt még a selejtező kezdete előtt elküldeni erre a címre: info@hunesz.hu\nNemzetiségi szabályok: A versenyen magyar és külföldi játékosok is indulhatnak, amennyiben a csapatkompozíció megfelel a versenyszabályoknak.\nCsapatlétszám: A maximálisan megengedett csapatlétszám 7 fő, ami 5 kezdő és 2 csere játékosból adódik össze. Egy csapatnak legalább 5 játékossal kell rendelkeznie, hogy elindulhasson a versenyen.\nCserejátékosok: A játékoskereten egészen a kupa kezdetéig lehet módosítani. Ha egy csapat továbbjut a verseny következő szakaszába többet már nem cserélhet.\nEltiltások: A Warmup kupa állomásain nem vehet részt olyan játékos kinek a Uplay fiókja eltiltás alatt van.\nAzonosítás: Amennyiben a versenybírók úgy döntenek, a játékosoknak hivatalos dokumentumokkal (személyi igazolvány, lakcímkártya.) szükséges magukat igazolni\nSaját játék közvetítése: Csak szervezők által biztosított overlay használatával lehetséges.\n\n\nSelejtező lebonyolítására vonatkozó szabályok:\n- Kezdés: 2020. November 21. - 14:00 ( Check-In 13:00-tól )\n- Formátum: Single-Elimination Bo1/Bo3 fordulók\n- Továbbjutás: A selejtező TOP4 csapata jut tovább a November 22-én megrendezésre kerülő döntőbe. A selejtezőt csak a TOP4-ig kell lejátszani!\n- Pontos időtábla a "Schedule fül alatt"', '{"twitter":"https://twitter.com/HungarianEsport","instagram":"https://www.instagram.com/magyaresportbajnoksag/","facebook":"https://www.facebook.com/mneb.hu","discord":"https://discord.gg/u6H8fGeXRr","steam":""}', 16, 0, 0, '{"":""}', 3, '{"teams":[["KmK Bravo","Conqueror Grizzlys"],["LFO","LvLUp Esport"],["Cartel","Arrow Gaming"],["Necrotic Esports","Homeless"],["Hol a refrag?","S4"],["Nice Gaming","All Stars"],["CompIsRanked","B\\u00c9K\\u00c9SCSABAI ESPORT EGYES\\u00dcLET BLACK"],["Team Spiritus","EagleSports"]],"results":[[[[1,0],[0,1],[0,1],[0,1],[1,0],[1,0],[1,0],[0,1]],[[2,0],[0,2],[0,2],[2,0]],[[null,null],[null,null]],[[null,null]]]]}', '2020-11-28 22:43:51'),
(6, 'LG UltraGear R6S Warmup kupa - Döntő', 'lg-ultragear-r6s-warmup-kupa-donto', 'http://esportplay.hu/wp-content/uploads/2020/12/thumb-1920-676369.jpg', 'http://esportplay.hu/wp-content/uploads/2020/12/asd.png', 'http://esportplay.hu/wp-content/uploads/2020/12/1604843695326.jpg', 'http://esportplay.hu/wp-content/uploads/2020/12/1604843695326.jpg', 'Hungary', '2020-12-05 18:45:06', 1, '', '{"twitter":"https://twitter.com/HungarianEsport","instagram":"https://www.instagram.com/magyaresportbajnoksag/","facebook":"https://www.facebook.com/mneb.hu","discord":"https://discord.gg/u6H8fGeXRr","steam":""}', 8, 0, 500, '{"":""}', 2, '{"teams":[["Illes Akademia Spirit","Nice Gaming"],["WiLD Multigaming","KmK Bravo"],["Team Plague","CompIsRanked"],["Genesis Gaming","Homeless"]],"results":[[[[0,1],[1,0],[1,0],[0,1]],[[0,1],[1,0]],[[2,1]]],[[[1,0],[0,1]],[[1,0],[1,0]],[[1,0]],[[2,0]]],[[[2,1]]]]}', '2020-12-05 18:43:42');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_tournament_group`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_tournament_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tournament_id` int(11) DEFAULT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_tournament_group_team`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_tournament_group_team` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=49 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_pixiefreak_tournament_team`
--

CREATE TABLE IF NOT EXISTS `wp_pixiefreak_tournament_team` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tournament_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=67 ;

--
-- A tábla adatainak kiíratása `wp_pixiefreak_tournament_team`
--

INSERT INTO `wp_pixiefreak_tournament_team` (`id`, `tournament_id`, `team_id`, `created_at`) VALUES
(7, 1, 1, '2018-10-23 13:20:12'),
(8, 1, 2, '2018-10-23 13:20:12'),
(9, 1, 3, '2018-10-23 13:20:12'),
(10, 1, 4, '2018-10-23 13:20:12'),
(11, 1, 5, '2018-10-23 13:20:12'),
(12, 1, 6, '2018-10-23 13:20:12'),
(19, 3, 1, '2018-10-23 13:20:12'),
(20, 3, 2, '2018-10-23 13:20:12'),
(21, 3, 3, '2018-10-23 13:20:12'),
(22, 3, 4, '2018-10-23 13:20:12'),
(23, 3, 5, '2018-10-23 13:20:12'),
(24, 3, 6, '2018-10-23 13:20:12'),
(25, 4, 1, '2018-10-23 13:20:12'),
(26, 4, 2, '2018-10-23 13:20:12'),
(27, 4, 3, '2018-10-23 13:20:12'),
(28, 4, 4, '2018-10-23 13:20:12'),
(29, 4, 5, '2018-10-23 13:20:12'),
(30, 4, 6, '2018-10-23 13:20:12'),
(31, 2, 1, '2020-11-28 21:18:46'),
(32, 2, 2, '2020-11-28 21:18:46'),
(33, 2, 3, '2020-11-28 21:18:46'),
(34, 2, 4, '2020-11-28 21:18:46'),
(35, 2, 5, '2020-11-28 21:18:46'),
(36, 2, 6, '2020-11-28 21:18:46'),
(44, 5, 9, '2020-12-05 18:19:05'),
(45, 5, 10, '2020-12-05 18:19:05'),
(46, 5, 11, '2020-12-05 18:19:05'),
(47, 5, 12, '2020-12-05 18:19:05'),
(48, 5, 13, '2020-12-05 18:19:05'),
(49, 5, 14, '2020-12-05 18:19:05'),
(50, 5, 15, '2020-12-05 18:19:05'),
(51, 5, 16, '2020-12-05 18:19:05'),
(52, 5, 18, '2020-12-05 18:19:05'),
(53, 5, 19, '2020-12-05 18:19:05'),
(54, 5, 23, '2020-12-05 18:19:05'),
(55, 5, 24, '2020-12-05 18:19:05'),
(56, 5, 25, '2020-12-05 18:19:05'),
(57, 5, 26, '2020-12-05 18:19:05'),
(58, 5, 27, '2020-12-05 18:19:05'),
(59, 6, 8, '2020-12-05 18:51:28'),
(60, 6, 12, '2020-12-05 18:51:28'),
(61, 6, 15, '2020-12-05 18:51:28'),
(62, 6, 24, '2020-12-05 18:51:28'),
(63, 6, 26, '2020-12-05 18:51:28'),
(64, 6, 28, '2020-12-05 18:51:28'),
(65, 6, 29, '2020-12-05 18:51:28'),
(66, 6, 30, '2020-12-05 18:51:28');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_postmeta`
--

CREATE TABLE IF NOT EXISTS `wp_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=1130 ;

--
-- A tábla adatainak kiíratása `wp_postmeta`
--

INSERT INTO `wp_postmeta` (`meta_id`, `post_id`, `meta_key`, `meta_value`) VALUES
(1, 2, '_wp_page_template', 'default'),
(2, 3, '_wp_page_template', 'default'),
(6, 6, '_wp_trash_meta_time', '1607165220'),
(5, 6, '_wp_trash_meta_status', 'publish'),
(795, 258, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:981;s:6:"height";i:980;s:4:"file";s:16:"2020/12/logo.png";s:5:"sizes";a:5:{s:6:"medium";a:4:{s:4:"file";s:16:"logo-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:16:"logo-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:16:"logo-768x767.png";s:5:"width";i:768;s:6:"height";i:767;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:16:"logo-721x720.png";s:5:"width";i:721;s:6:"height";i:720;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:16:"logo-280x280.png";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(794, 258, '_wp_attached_file', '2020/12/logo.png'),
(496, 187, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:14:"2020/11/qw.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:14:"qw-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:15:"qw-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:14:"qw-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:14:"qw-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:15:"qw-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:15:"qw-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:14:"qw-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(497, 188, '_wp_attached_file', '2020/11/qc.png'),
(498, 188, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:14:"2020/11/qc.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:14:"qc-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:15:"qc-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:14:"qc-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:14:"qc-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:15:"qc-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:15:"qc-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:14:"qc-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(499, 189, '_wp_attached_file', '2020/11/77398019_1050496535281850_3009940701971480576_o-4.png'),
(500, 189, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:61:"2020/11/77398019_1050496535281850_3009940701971480576_o-4.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-4-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-4-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-4-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-4-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-4-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-4-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-4-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(501, 190, '_edit_lock', '1606661652:1'),
(502, 191, '_edit_lock', '1606661514:1'),
(503, 194, '_edit_lock', '1606662023:1'),
(504, 194, '_wp_page_template', 'page-match.php'),
(513, 213, '_wp_trash_meta_status', 'publish'),
(514, 213, '_wp_trash_meta_time', '1606662233'),
(515, 215, '_wp_trash_meta_status', 'publish'),
(516, 215, '_wp_trash_meta_time', '1606662255'),
(517, 216, '_wp_trash_meta_status', 'publish'),
(518, 216, '_wp_trash_meta_time', '1606662274'),
(521, 172, '_wp_attachment_context', 'custom-logo'),
(522, 175, '_wp_attachment_context', 'custom-logo'),
(523, 177, '_wp_attachment_context', 'custom-logo'),
(524, 179, '_wp_attachment_context', 'site-icon'),
(525, 181, '_wp_attachment_context', 'custom-logo'),
(526, 218, '_menu_item_type', 'custom'),
(527, 218, '_menu_item_menu_item_parent', '0'),
(528, 218, '_menu_item_object_id', '218'),
(529, 218, '_menu_item_object', 'custom'),
(530, 218, '_menu_item_target', ''),
(531, 218, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(532, 218, '_menu_item_xfn', ''),
(533, 218, '_menu_item_url', '/'),
(534, 219, '_wp_page_template', 'default'),
(535, 17, '_wp_page_template', 'page-sponsor.php'),
(536, 17, '_edit_last', '1'),
(537, 59, '_wp_page_template', 'default'),
(538, 59, '_edit_last', '1'),
(539, 60, '_wp_page_template', 'default'),
(540, 60, '_edit_last', '1'),
(541, 63, '_wp_page_template', 'default'),
(542, 63, '_edit_last', '1'),
(543, 64, '_wp_page_template', 'blank-page.php'),
(544, 64, '_edit_last', '1'),
(545, 65, '_wp_page_template', 'page-about.php'),
(546, 65, '_edit_last', '1'),
(547, 66, '_wp_page_template', 'page-bracket.php'),
(548, 66, '_edit_last', '1'),
(549, 67, '_wp_page_template', 'page-gallery.php'),
(550, 67, '_edit_last', '1'),
(551, 68, '_wp_page_template', 'page-match.php'),
(552, 68, '_edit_last', '1'),
(553, 69, '_wp_page_template', 'page-matches.php'),
(554, 69, '_edit_last', '1'),
(555, 70, '_wp_page_template', 'page-news.php'),
(556, 70, '_edit_last', '1'),
(557, 220, '_menu_item_type', 'post_type'),
(558, 220, '_menu_item_menu_item_parent', '0'),
(559, 220, '_menu_item_object_id', '70'),
(560, 220, '_menu_item_object', 'page'),
(561, 220, '_menu_item_target', ''),
(562, 220, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(563, 220, '_menu_item_xfn', ''),
(564, 220, '_menu_item_url', ''),
(565, 221, '_menu_item_type', 'post_type'),
(566, 221, '_menu_item_menu_item_parent', '0'),
(567, 221, '_menu_item_object_id', '70'),
(568, 221, '_menu_item_object', 'page'),
(569, 221, '_menu_item_target', ''),
(570, 221, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(571, 221, '_menu_item_xfn', ''),
(572, 221, '_menu_item_url', ''),
(573, 222, '_menu_item_type', 'post_type'),
(574, 222, '_menu_item_menu_item_parent', '0'),
(575, 222, '_menu_item_object_id', '69'),
(576, 222, '_menu_item_object', 'page'),
(577, 222, '_menu_item_target', ''),
(578, 222, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(579, 222, '_menu_item_xfn', ''),
(580, 222, '_menu_item_url', ''),
(581, 223, '_menu_item_type', 'post_type'),
(582, 223, '_menu_item_menu_item_parent', '0'),
(583, 223, '_menu_item_object_id', '67'),
(584, 223, '_menu_item_object', 'page'),
(585, 223, '_menu_item_target', ''),
(586, 223, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(587, 223, '_menu_item_xfn', ''),
(588, 223, '_menu_item_url', ''),
(589, 224, '_menu_item_type', 'post_type'),
(590, 224, '_menu_item_menu_item_parent', '0'),
(591, 224, '_menu_item_object_id', '65'),
(592, 224, '_menu_item_object', 'page'),
(593, 224, '_menu_item_target', ''),
(594, 224, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(595, 224, '_menu_item_xfn', ''),
(596, 224, '_menu_item_url', ''),
(597, 225, '_menu_item_type', 'post_type'),
(598, 225, '_menu_item_menu_item_parent', '0'),
(599, 225, '_menu_item_object_id', '70'),
(600, 225, '_menu_item_object', 'page'),
(601, 225, '_menu_item_target', ''),
(602, 225, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(603, 225, '_menu_item_xfn', ''),
(604, 225, '_menu_item_url', ''),
(605, 226, '_menu_item_type', 'post_type'),
(606, 226, '_menu_item_menu_item_parent', '0'),
(607, 226, '_menu_item_object_id', '65'),
(608, 226, '_menu_item_object', 'page'),
(609, 226, '_menu_item_target', ''),
(610, 226, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(611, 226, '_menu_item_xfn', ''),
(612, 226, '_menu_item_url', ''),
(613, 227, '_wp_page_template', 'default'),
(614, 36, '_customize_changeset_uuid', 'a0aab18e-4b52-4150-9660-399cdce087c8'),
(615, 37, '_customize_changeset_uuid', 'a0aab18e-4b52-4150-9660-399cdce087c8'),
(616, 37, '_wp_page_template', 'page-tournaments.php'),
(617, 38, '_customize_changeset_uuid', 'a0aab18e-4b52-4150-9660-399cdce087c8'),
(618, 39, '_customize_changeset_uuid', 'a0aab18e-4b52-4150-9660-399cdce087c8'),
(619, 40, '_customize_changeset_uuid', 'a0aab18e-4b52-4150-9660-399cdce087c8'),
(620, 71, '_wp_page_template', 'page-player.php'),
(621, 71, '_edit_last', '1'),
(622, 72, '_wp_page_template', 'page-shop.php'),
(623, 72, '_edit_last', '1'),
(624, 73, '_wp_page_template', 'page-stream.php'),
(625, 73, '_edit_last', '1'),
(626, 74, '_wp_page_template', 'page-streams.php'),
(627, 74, '_edit_last', '1'),
(628, 75, '_wp_page_template', 'page-team.php'),
(629, 75, '_edit_last', '1'),
(630, 76, '_wp_page_template', 'page-teams.php'),
(631, 76, '_edit_last', '1'),
(632, 77, '_wp_page_template', 'page-tournament.php'),
(633, 77, '_edit_last', '1'),
(634, 78, '_wp_page_template', 'page-tournaments.php'),
(635, 78, '_edit_last', '1'),
(636, 116, '_edit_last', '1'),
(637, 116, '_thumbnail_id', '119'),
(638, 194, '_wp_page_template', 'page-match.php'),
(639, 122, '_edit_last', '1'),
(640, 122, '_thumbnail_id', '117'),
(641, 125, '_edit_last', '1'),
(642, 125, '_thumbnail_id', '126'),
(643, 131, '_edit_last', '1'),
(868, 287, '_wp_attached_file', '2020/12/asd.png'),
(645, 133, '_edit_last', '1'),
(647, 135, '_edit_last', '1'),
(648, 135, '_thumbnail_id', '128'),
(649, 229, '_menu_item_type', 'post_type'),
(650, 229, '_menu_item_menu_item_parent', '0'),
(651, 229, '_menu_item_object_id', '78'),
(652, 229, '_menu_item_object', 'page'),
(653, 229, '_menu_item_target', ''),
(654, 229, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(655, 229, '_menu_item_xfn', ''),
(656, 229, '_menu_item_url', ''),
(657, 230, '_menu_item_type', 'post_type'),
(658, 230, '_menu_item_menu_item_parent', '0'),
(659, 230, '_menu_item_object_id', '76'),
(660, 230, '_menu_item_object', 'page'),
(661, 230, '_menu_item_target', ''),
(662, 230, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(663, 230, '_menu_item_xfn', ''),
(664, 230, '_menu_item_url', ''),
(665, 231, '_menu_item_type', 'post_type'),
(666, 231, '_menu_item_menu_item_parent', '218'),
(667, 231, '_menu_item_object_id', '74'),
(668, 231, '_menu_item_object', 'page'),
(669, 231, '_menu_item_target', ''),
(670, 231, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(671, 231, '_menu_item_xfn', ''),
(672, 231, '_menu_item_url', ''),
(673, 232, '_menu_item_type', 'post_type'),
(674, 232, '_menu_item_menu_item_parent', '218'),
(675, 232, '_menu_item_object_id', '17'),
(676, 232, '_menu_item_object', 'page'),
(677, 232, '_menu_item_target', ''),
(678, 232, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(679, 232, '_menu_item_xfn', ''),
(680, 232, '_menu_item_url', ''),
(681, 233, '_menu_item_type', 'post_type'),
(682, 233, '_menu_item_menu_item_parent', '0'),
(683, 233, '_menu_item_object_id', '70'),
(684, 233, '_menu_item_object', 'page'),
(685, 233, '_menu_item_target', ''),
(686, 233, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(687, 233, '_menu_item_xfn', ''),
(688, 233, '_menu_item_url', ''),
(689, 234, '_menu_item_type', 'post_type'),
(690, 234, '_menu_item_menu_item_parent', '229'),
(691, 234, '_menu_item_object_id', '69'),
(692, 234, '_menu_item_object', 'page'),
(693, 234, '_menu_item_target', ''),
(694, 234, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(695, 234, '_menu_item_xfn', ''),
(696, 234, '_menu_item_url', ''),
(697, 235, '_menu_item_type', 'post_type'),
(698, 235, '_menu_item_menu_item_parent', '218'),
(699, 235, '_menu_item_object_id', '67'),
(700, 235, '_menu_item_object', 'page'),
(701, 235, '_menu_item_target', ''),
(702, 235, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(703, 235, '_menu_item_xfn', ''),
(704, 235, '_menu_item_url', ''),
(705, 236, '_menu_item_type', 'post_type'),
(706, 236, '_menu_item_menu_item_parent', '218'),
(707, 236, '_menu_item_object_id', '65'),
(708, 236, '_menu_item_object', 'page'),
(709, 236, '_menu_item_target', ''),
(710, 236, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(711, 236, '_menu_item_xfn', ''),
(712, 236, '_menu_item_url', ''),
(713, 237, '_menu_item_type', 'post_type'),
(714, 237, '_menu_item_menu_item_parent', '0'),
(715, 237, '_menu_item_object_id', '78'),
(716, 237, '_menu_item_object', 'page'),
(717, 237, '_menu_item_target', ''),
(718, 237, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(719, 237, '_menu_item_xfn', ''),
(720, 237, '_menu_item_url', ''),
(721, 238, '_menu_item_type', 'post_type'),
(722, 238, '_menu_item_menu_item_parent', '0'),
(723, 238, '_menu_item_object_id', '76'),
(724, 238, '_menu_item_object', 'page'),
(725, 238, '_menu_item_target', ''),
(726, 238, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(727, 238, '_menu_item_xfn', ''),
(728, 238, '_menu_item_url', ''),
(729, 239, '_menu_item_type', 'post_type'),
(730, 239, '_menu_item_menu_item_parent', '0'),
(731, 239, '_menu_item_object_id', '74'),
(732, 239, '_menu_item_object', 'page'),
(733, 239, '_menu_item_target', ''),
(734, 239, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(735, 239, '_menu_item_xfn', ''),
(736, 239, '_menu_item_url', ''),
(737, 240, '_menu_item_type', 'post_type'),
(738, 240, '_menu_item_menu_item_parent', '0'),
(739, 240, '_menu_item_object_id', '17'),
(740, 240, '_menu_item_object', 'page'),
(741, 240, '_menu_item_target', ''),
(742, 240, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(743, 240, '_menu_item_xfn', ''),
(744, 240, '_menu_item_url', ''),
(745, 241, '_menu_item_type', 'post_type'),
(746, 241, '_menu_item_menu_item_parent', '0'),
(747, 241, '_menu_item_object_id', '74'),
(748, 241, '_menu_item_object', 'page'),
(749, 241, '_menu_item_target', ''),
(750, 241, '_menu_item_classes', 'a:1:{i:0;s:0:"";}'),
(751, 241, '_menu_item_xfn', ''),
(752, 241, '_menu_item_url', ''),
(753, 242, '_wp_attached_file', '2020/12/77398019_1050496535281850_3009940701971480576_o.png'),
(754, 242, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:59:"2020/12/77398019_1050496535281850_3009940701971480576_o.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:59:"77398019_1050496535281850_3009940701971480576_o-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:60:"77398019_1050496535281850_3009940701971480576_o-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:59:"77398019_1050496535281850_3009940701971480576_o-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:59:"77398019_1050496535281850_3009940701971480576_o-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:60:"77398019_1050496535281850_3009940701971480576_o-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:60:"77398019_1050496535281850_3009940701971480576_o-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:59:"77398019_1050496535281850_3009940701971480576_o-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(755, 243, '_wp_attached_file', '2020/12/77398019_1050496535281850_3009940701971480576_o-1.png'),
(756, 243, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:61:"2020/12/77398019_1050496535281850_3009940701971480576_o-1.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-1-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-1-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-1-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-1-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-1-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-1-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(757, 244, '_wp_attached_file', '2020/12/77398019_1050496535281850_3009940701971480576_o-2.png'),
(758, 244, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:61:"2020/12/77398019_1050496535281850_3009940701971480576_o-2.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-2-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-2-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-2-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-2-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-2-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-2-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-2-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(759, 245, '_wp_attached_file', '2020/12/77398019_1050496535281850_3009940701971480576_o-3.png'),
(760, 245, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:61:"2020/12/77398019_1050496535281850_3009940701971480576_o-3.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-3-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-3-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-3-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-3-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-3-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-3-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-3-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(761, 246, '_wp_attached_file', '2020/12/77398019_1050496535281850_3009940701971480576_o-4.png'),
(762, 246, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:61:"2020/12/77398019_1050496535281850_3009940701971480576_o-4.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-4-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-4-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-4-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-4-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-4-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:62:"77398019_1050496535281850_3009940701971480576_o-4-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:61:"77398019_1050496535281850_3009940701971480576_o-4-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(763, 247, '_wp_attached_file', '2020/12/qc.png'),
(764, 247, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:14:"2020/12/qc.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:14:"qc-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:15:"qc-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:14:"qc-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:14:"qc-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:15:"qc-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:15:"qc-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:14:"qc-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(765, 248, '_wp_attached_file', '2020/12/qw.png'),
(766, 248, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:14:"2020/12/qw.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:14:"qw-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:15:"qw-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:14:"qw-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:14:"qw-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:15:"qw-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:15:"qw-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:14:"qw-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(767, 249, '_wp_attached_file', '2020/12/qwcqwcqc.png'),
(768, 249, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:96;s:6:"height";i:44;s:4:"file";s:20:"2020/12/qwcqwcqc.png";s:5:"sizes";a:0:{}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(769, 250, '_wp_attached_file', '2020/12/wcwcw.png'),
(770, 250, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:96;s:6:"height";i:44;s:4:"file";s:17:"2020/12/wcwcw.png";s:5:"sizes";a:0:{}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(771, 251, '_wp_attached_file', '2020/12/ww.png'),
(772, 251, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:14:"2020/12/ww.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:14:"ww-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:15:"ww-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:14:"ww-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:14:"ww-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:15:"ww-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:15:"ww-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:14:"ww-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(773, 26, '_customize_restore_dismissed', '1'),
(774, 252, '_wp_trash_meta_status', 'publish'),
(775, 252, '_wp_trash_meta_time', '1607166092'),
(776, 253, '_wp_trash_meta_status', 'publish'),
(777, 253, '_wp_trash_meta_time', '1607166105'),
(778, 254, '_wp_attached_file', '2020/12/Nevtelen-2.png'),
(779, 254, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:96;s:6:"height";i:44;s:4:"file";s:22:"2020/12/Nevtelen-2.png";s:5:"sizes";a:0:{}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(793, 74, '_edit_lock', '1607167167:1'),
(792, 17, '_edit_lock', '1607167147:1'),
(791, 257, '_wp_trash_meta_time', '1607166411'),
(790, 257, '_wp_trash_meta_status', 'publish'),
(788, 255, '_wp_trash_meta_status', 'publish'),
(789, 255, '_wp_trash_meta_time', '1607166361'),
(796, 259, '_wp_attached_file', '2020/12/cropped-logo.png'),
(797, 259, '_wp_attachment_context', 'custom-logo'),
(798, 259, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:955;s:6:"height";i:957;s:4:"file";s:24:"2020/12/cropped-logo.png";s:5:"sizes";a:5:{s:6:"medium";a:4:{s:4:"file";s:24:"cropped-logo-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:24:"cropped-logo-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:24:"cropped-logo-768x770.png";s:5:"width";i:768;s:6:"height";i:770;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:24:"cropped-logo-718x720.png";s:5:"width";i:718;s:6:"height";i:720;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:24:"cropped-logo-280x281.png";s:5:"width";i:280;s:6:"height";i:281;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(799, 260, '_wp_attached_file', '2020/12/cropped-logo-1.png'),
(800, 260, '_wp_attachment_context', 'site-icon'),
(801, 260, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:512;s:6:"height";i:512;s:4:"file";s:26:"2020/12/cropped-logo-1.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:26:"cropped-logo-1-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:26:"cropped-logo-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:26:"cropped-logo-1-280x280.png";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-270";a:4:{s:4:"file";s:26:"cropped-logo-1-270x270.png";s:5:"width";i:270;s:6:"height";i:270;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-192";a:4:{s:4:"file";s:26:"cropped-logo-1-192x192.png";s:5:"width";i:192;s:6:"height";i:192;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-180";a:4:{s:4:"file";s:26:"cropped-logo-1-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"site_icon-32";a:4:{s:4:"file";s:24:"cropped-logo-1-32x32.png";s:5:"width";i:32;s:6:"height";i:32;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(802, 261, '_edit_lock', '1607176015:1'),
(803, 262, '_wp_attached_file', '2020/12/remote-device-control-game-playstation-joypad-play-2-4102.png'),
(804, 262, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:256;s:6:"height";i:256;s:4:"file";s:69:"2020/12/remote-device-control-game-playstation-joypad-play-2-4102.png";s:5:"sizes";a:1:{s:9:"thumbnail";a:4:{s:4:"file";s:69:"remote-device-control-game-playstation-joypad-play-2-4102-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(805, 263, '_wp_attached_file', '2020/12/cropped-remote-device-control-game-playstation-joypad-play-2-4102.png'),
(806, 263, '_wp_attachment_context', 'site-icon'),
(807, 263, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:512;s:6:"height";i:512;s:4:"file";s:77:"2020/12/cropped-remote-device-control-game-playstation-joypad-play-2-4102.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:77:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:77:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:77:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-280x280.png";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-270";a:4:{s:4:"file";s:77:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-270x270.png";s:5:"width";i:270;s:6:"height";i:270;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-192";a:4:{s:4:"file";s:77:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-192x192.png";s:5:"width";i:192;s:6:"height";i:192;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-180";a:4:{s:4:"file";s:77:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"site_icon-32";a:4:{s:4:"file";s:75:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-32x32.png";s:5:"width";i:32;s:6:"height";i:32;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(808, 264, '_wp_attached_file', '2020/12/remote-device-control-game-playstation-joypad-play-2-4102-1.png'),
(809, 264, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:256;s:6:"height";i:256;s:4:"file";s:71:"2020/12/remote-device-control-game-playstation-joypad-play-2-4102-1.png";s:5:"sizes";a:1:{s:9:"thumbnail";a:4:{s:4:"file";s:71:"remote-device-control-game-playstation-joypad-play-2-4102-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(810, 265, '_wp_attached_file', '2020/12/cropped-remote-device-control-game-playstation-joypad-play-2-4102-1.png'),
(811, 265, '_wp_attachment_context', 'site-icon'),
(812, 265, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:512;s:6:"height";i:512;s:4:"file";s:79:"2020/12/cropped-remote-device-control-game-playstation-joypad-play-2-4102-1.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:79:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-1-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:79:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:79:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-1-280x280.png";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-270";a:4:{s:4:"file";s:79:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-1-270x270.png";s:5:"width";i:270;s:6:"height";i:270;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-192";a:4:{s:4:"file";s:79:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-1-192x192.png";s:5:"width";i:192;s:6:"height";i:192;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-180";a:4:{s:4:"file";s:79:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-1-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"site_icon-32";a:4:{s:4:"file";s:77:"cropped-remote-device-control-game-playstation-joypad-play-2-4102-1-32x32.png";s:5:"width";i:32;s:6:"height";i:32;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(813, 266, '_wp_attached_file', '2020/12/wcsa.png'),
(814, 266, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1008;s:6:"height";i:256;s:4:"file";s:16:"2020/12/wcsa.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:15:"wcsa-300x76.png";s:5:"width";i:300;s:6:"height";i:76;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:16:"wcsa-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:16:"wcsa-768x195.png";s:5:"width";i:768;s:6:"height";i:195;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:15:"wcsa-280x71.png";s:5:"width";i:280;s:6:"height";i:71;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(815, 267, '_wp_attached_file', '2020/12/cropped-wcsa.png'),
(816, 267, '_wp_attachment_context', 'custom-logo'),
(817, 267, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:728;s:6:"height";i:256;s:4:"file";s:24:"2020/12/cropped-wcsa.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:24:"cropped-wcsa-300x105.png";s:5:"width";i:300;s:6:"height";i:105;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:24:"cropped-wcsa-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:23:"cropped-wcsa-280x98.png";s:5:"width";i:280;s:6:"height";i:98;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(818, 268, '_wp_attached_file', '2020/12/cropped-wcsa-1.png'),
(819, 268, '_wp_attachment_context', 'custom-logo'),
(820, 268, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:982;s:6:"height";i:256;s:4:"file";s:26:"2020/12/cropped-wcsa-1.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:25:"cropped-wcsa-1-300x78.png";s:5:"width";i:300;s:6:"height";i:78;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:26:"cropped-wcsa-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:26:"cropped-wcsa-1-768x200.png";s:5:"width";i:768;s:6:"height";i:200;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:25:"cropped-wcsa-1-280x73.png";s:5:"width";i:280;s:6:"height";i:73;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(821, 261, '_wp_trash_meta_status', 'publish'),
(822, 261, '_wp_trash_meta_time', '1607176023'),
(846, 277, '_wp_trash_meta_time', '1607176423'),
(847, 279, '_wp_attached_file', '2020/12/cropped-wcsa-2-1.png'),
(848, 279, '_wp_attachment_context', 'custom-logo'),
(849, 279, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:735;s:6:"height";i:256;s:4:"file";s:28:"2020/12/cropped-wcsa-2-1.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:28:"cropped-wcsa-2-1-300x104.png";s:5:"width";i:300;s:6:"height";i:104;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:28:"cropped-wcsa-2-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:27:"cropped-wcsa-2-1-280x98.png";s:5:"width";i:280;s:6:"height";i:98;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(825, 270, '_wp_attached_file', '2020/12/cropped-wcsa-1-1.png'),
(826, 270, '_wp_attachment_context', 'custom-logo'),
(827, 270, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1008;s:6:"height";i:256;s:4:"file";s:28:"2020/12/cropped-wcsa-1-1.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:27:"cropped-wcsa-1-1-300x76.png";s:5:"width";i:300;s:6:"height";i:76;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:28:"cropped-wcsa-1-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:28:"cropped-wcsa-1-1-768x195.png";s:5:"width";i:768;s:6:"height";i:195;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:27:"cropped-wcsa-1-1-280x71.png";s:5:"width";i:280;s:6:"height";i:71;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(828, 271, '_edit_lock', '1607176276:1'),
(836, 274, '_wp_attached_file', '2020/12/wcsa-2.png'),
(837, 274, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1008;s:6:"height";i:256;s:4:"file";s:18:"2020/12/wcsa-2.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:17:"wcsa-2-300x76.png";s:5:"width";i:300;s:6:"height";i:76;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:18:"wcsa-2-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:18:"wcsa-2-768x195.png";s:5:"width";i:768;s:6:"height";i:195;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:17:"wcsa-2-280x71.png";s:5:"width";i:280;s:6:"height";i:71;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(831, 273, '_wp_attached_file', '2020/12/cropped-wcsa-2.png'),
(832, 273, '_wp_attachment_context', 'custom-logo'),
(833, 273, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1008;s:6:"height";i:256;s:4:"file";s:26:"2020/12/cropped-wcsa-2.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:25:"cropped-wcsa-2-300x76.png";s:5:"width";i:300;s:6:"height";i:76;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:26:"cropped-wcsa-2-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:26:"cropped-wcsa-2-768x195.png";s:5:"width";i:768;s:6:"height";i:195;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:25:"cropped-wcsa-2-280x71.png";s:5:"width";i:280;s:6:"height";i:71;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(834, 271, '_wp_trash_meta_status', 'publish'),
(835, 271, '_wp_trash_meta_time', '1607176301'),
(845, 277, '_wp_trash_meta_status', 'publish'),
(842, 277, '_edit_lock', '1607176400:1'),
(850, 280, '_edit_lock', '1607176520:1'),
(861, 284, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1008;s:6:"height";i:256;s:4:"file";s:18:"2020/12/wcsa-1.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:17:"wcsa-1-300x76.png";s:5:"width";i:300;s:6:"height";i:76;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:18:"wcsa-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:18:"wcsa-1-768x195.png";s:5:"width";i:768;s:6:"height";i:195;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:17:"wcsa-1-280x71.png";s:5:"width";i:280;s:6:"height";i:71;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(860, 284, '_wp_attached_file', '2020/12/wcsa-1.png'),
(855, 283, '_wp_attached_file', '2020/12/cropped-wcsa-1-2.png'),
(856, 283, '_wp_attachment_context', 'custom-logo'),
(857, 283, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1008;s:6:"height";i:256;s:4:"file";s:28:"2020/12/cropped-wcsa-1-2.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:27:"cropped-wcsa-1-2-300x76.png";s:5:"width";i:300;s:6:"height";i:76;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:28:"cropped-wcsa-1-2-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:28:"cropped-wcsa-1-2-768x195.png";s:5:"width";i:768;s:6:"height";i:195;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:27:"cropped-wcsa-1-2-280x71.png";s:5:"width";i:280;s:6:"height";i:71;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(858, 280, '_wp_trash_meta_status', 'publish'),
(859, 280, '_wp_trash_meta_time', '1607176525'),
(862, 285, '_wp_attached_file', '2020/12/cropped-wcsa-1-3.png'),
(863, 285, '_wp_attachment_context', 'custom-logo');
INSERT INTO `wp_postmeta` (`meta_id`, `post_id`, `meta_key`, `meta_value`) VALUES
(864, 285, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1008;s:6:"height";i:256;s:4:"file";s:28:"2020/12/cropped-wcsa-1-3.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:27:"cropped-wcsa-1-3-300x76.png";s:5:"width";i:300;s:6:"height";i:76;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:28:"cropped-wcsa-1-3-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:28:"cropped-wcsa-1-3-768x195.png";s:5:"width";i:768;s:6:"height";i:195;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:27:"cropped-wcsa-1-3-280x71.png";s:5:"width";i:280;s:6:"height";i:71;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(865, 286, '_edit_lock', '1607176580:1'),
(866, 286, '_wp_trash_meta_status', 'publish'),
(867, 286, '_wp_trash_meta_time', '1607176582'),
(869, 287, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:804;s:6:"height";i:884;s:4:"file";s:15:"2020/12/asd.png";s:5:"sizes";a:5:{s:6:"medium";a:4:{s:4:"file";s:15:"asd-273x300.png";s:5:"width";i:273;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:15:"asd-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:15:"asd-768x844.png";s:5:"width";i:768;s:6:"height";i:844;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:15:"asd-655x720.png";s:5:"width";i:655;s:6:"height";i:720;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:15:"asd-280x308.png";s:5:"width";i:280;s:6:"height";i:308;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(870, 288, '_wp_attached_file', '2020/12/1604843695326.jpg'),
(871, 288, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1161;s:6:"height";i:540;s:4:"file";s:25:"2020/12/1604843695326.jpg";s:5:"sizes";a:5:{s:6:"medium";a:4:{s:4:"file";s:25:"1604843695326-300x140.jpg";s:5:"width";i:300;s:6:"height";i:140;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:26:"1604843695326-1024x476.jpg";s:5:"width";i:1024;s:6:"height";i:476;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"1604843695326-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:25:"1604843695326-768x357.jpg";s:5:"width";i:768;s:6:"height";i:357;s:9:"mime-type";s:10:"image/jpeg";}s:10:"news-small";a:4:{s:4:"file";s:25:"1604843695326-280x130.jpg";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(872, 289, '_wp_attached_file', '2020/12/thumb-1920-676369.jpg'),
(873, 289, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1920;s:6:"height";i:1080;s:4:"file";s:29:"2020/12/thumb-1920-676369.jpg";s:5:"sizes";a:8:{s:6:"medium";a:4:{s:4:"file";s:29:"thumb-1920-676369-300x169.jpg";s:5:"width";i:300;s:6:"height";i:169;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:30:"thumb-1920-676369-1024x576.jpg";s:5:"width";i:1024;s:6:"height";i:576;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:29:"thumb-1920-676369-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:29:"thumb-1920-676369-768x432.jpg";s:5:"width";i:768;s:6:"height";i:432;s:9:"mime-type";s:10:"image/jpeg";}s:9:"1536x1536";a:4:{s:4:"file";s:30:"thumb-1920-676369-1536x864.jpg";s:5:"width";i:1536;s:6:"height";i:864;s:9:"mime-type";s:10:"image/jpeg";}s:8:"news-big";a:4:{s:4:"file";s:31:"thumb-1920-676369-1920x1080.jpg";s:5:"width";i:1920;s:6:"height";i:1080;s:9:"mime-type";s:10:"image/jpeg";}s:11:"news-medium";a:4:{s:4:"file";s:30:"thumb-1920-676369-1280x720.jpg";s:5:"width";i:1280;s:6:"height";i:720;s:9:"mime-type";s:10:"image/jpeg";}s:10:"news-small";a:4:{s:4:"file";s:29:"thumb-1920-676369-280x158.jpg";s:5:"width";i:280;s:6:"height";i:158;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(874, 290, '_wp_attached_file', '2020/12/osszeallt-a-mezony-ma-eldol-hogy-ki-nyeri-az-lg-ultragear-r6s-warmup-kupat-hirek-0058a06e2dcd4dbf39f0-mid.jpg'),
(875, 290, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:171;s:6:"height";i:167;s:4:"file";s:117:"2020/12/osszeallt-a-mezony-ma-eldol-hogy-ki-nyeri-az-lg-ultragear-r6s-warmup-kupat-hirek-0058a06e2dcd4dbf39f0-mid.jpg";s:5:"sizes";a:1:{s:9:"thumbnail";a:4:{s:4:"file";s:117:"osszeallt-a-mezony-ma-eldol-hogy-ki-nyeri-az-lg-ultragear-r6s-warmup-kupat-hirek-0058a06e2dcd4dbf39f0-mid-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(876, 291, '_wp_attached_file', '2020/12/WiLD_MultiGaminglogo_square.png'),
(877, 291, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:500;s:6:"height";i:500;s:4:"file";s:39:"2020/12/WiLD_MultiGaminglogo_square.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:39:"WiLD_MultiGaminglogo_square-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:39:"WiLD_MultiGaminglogo_square-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:39:"WiLD_MultiGaminglogo_square-280x280.png";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(878, 292, '_wp_attached_file', '2020/12/qwfqwfcqwqwx.png'),
(879, 292, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1008;s:6:"height";i:256;s:4:"file";s:24:"2020/12/qwfqwfcqwqwx.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:23:"qwfqwfcqwqwx-300x76.png";s:5:"width";i:300;s:6:"height";i:76;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:24:"qwfqwfcqwqwx-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:24:"qwfqwfcqwqwx-768x195.png";s:5:"width";i:768;s:6:"height";i:195;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:23:"qwfqwfcqwqwx-280x71.png";s:5:"width";i:280;s:6:"height";i:71;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(880, 293, '_wp_attached_file', '2020/12/cropped-qwfqwfcqwqwx.png'),
(881, 293, '_wp_attachment_context', 'custom-logo'),
(882, 293, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1008;s:6:"height";i:256;s:4:"file";s:32:"2020/12/cropped-qwfqwfcqwqwx.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:31:"cropped-qwfqwfcqwqwx-300x76.png";s:5:"width";i:300;s:6:"height";i:76;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:32:"cropped-qwfqwfcqwqwx-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:32:"cropped-qwfqwfcqwqwx-768x195.png";s:5:"width";i:768;s:6:"height";i:195;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:31:"cropped-qwfqwfcqwqwx-280x71.png";s:5:"width";i:280;s:6:"height";i:71;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(883, 294, '_wp_trash_meta_status', 'publish'),
(884, 294, '_wp_trash_meta_time', '1607178573'),
(1048, 303, '_wp_page_template', 'blank-page.php'),
(991, 320, '_customize_changeset_uuid', 'bef38478-2e51-41c7-bb34-a69b814e9407'),
(1047, 303, '_edit_last', '1'),
(907, 299, '_wp_trash_meta_time', '1607179131'),
(893, 295, '_wp_trash_meta_status', 'publish'),
(894, 295, '_wp_trash_meta_time', '1607179074'),
(906, 299, '_wp_trash_meta_status', 'publish'),
(903, 297, '_wp_trash_meta_status', 'publish'),
(904, 297, '_wp_trash_meta_time', '1607179105'),
(905, 299, '_edit_lock', '1607179131:1'),
(989, 319, '_customize_changeset_uuid', 'bef38478-2e51-41c7-bb34-a69b814e9407'),
(981, 314, '_wp_trash_meta_time', '1607183238'),
(916, 300, '_wp_trash_meta_status', 'publish'),
(917, 300, '_wp_trash_meta_time', '1607179161'),
(918, 302, '_edit_lock', '1607179211:1'),
(961, 302, '_wp_trash_meta_status', 'publish'),
(920, 303, '_customize_changeset_uuid', 'cdb72871-6e3f-424c-b6d2-62c4742e7761'),
(987, 318, '_wp_trash_meta_time', '1607183854'),
(1046, 333, '_wp_trash_meta_time', '1607185157'),
(986, 318, '_wp_trash_meta_status', 'publish'),
(985, 317, '_customize_restore_dismissed', '1'),
(967, 312, '_wp_trash_meta_status', 'publish'),
(966, 311, '_wp_trash_meta_time', '1607183087'),
(965, 311, '_wp_trash_meta_status', 'publish'),
(964, 310, '_wp_trash_meta_time', '1607182966'),
(963, 310, '_wp_trash_meta_status', 'publish'),
(980, 314, '_wp_trash_meta_status', 'publish'),
(984, 317, '_edit_lock', '1607183787:1'),
(983, 316, '_wp_trash_meta_time', '1607183247'),
(982, 316, '_wp_trash_meta_status', 'publish'),
(971, 313, '_wp_trash_meta_time', '1607183118'),
(970, 313, '_wp_trash_meta_status', 'publish'),
(969, 313, '_edit_lock', '1607183113:1'),
(968, 312, '_wp_trash_meta_time', '1607183092'),
(962, 302, '_wp_trash_meta_time', '1607179250'),
(993, 321, '_customize_changeset_uuid', 'bef38478-2e51-41c7-bb34-a69b814e9407'),
(1045, 333, '_wp_trash_meta_status', 'publish'),
(1044, 331, '_wp_trash_meta_time', '1607185105'),
(1043, 331, '_wp_trash_meta_status', 'publish'),
(1057, 344, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1080;s:6:"height";i:1080;s:4:"file";s:25:"2020/12/1606485698267.jpg";s:5:"sizes";a:6:{s:6:"medium";a:4:{s:4:"file";s:25:"1606485698267-300x300.jpg";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:27:"1606485698267-1024x1024.jpg";s:5:"width";i:1024;s:6:"height";i:1024;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"1606485698267-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:25:"1606485698267-768x768.jpg";s:5:"width";i:768;s:6:"height";i:768;s:9:"mime-type";s:10:"image/jpeg";}s:11:"news-medium";a:4:{s:4:"file";s:25:"1606485698267-720x720.jpg";s:5:"width";i:720;s:6:"height";i:720;s:9:"mime-type";s:10:"image/jpeg";}s:10:"news-small";a:4:{s:4:"file";s:25:"1606485698267-280x280.jpg";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1055, 343, '_wp_trash_meta_time', '1607185922'),
(1056, 344, '_wp_attached_file', '2020/12/1606485698267.jpg'),
(1054, 343, '_wp_trash_meta_status', 'publish'),
(1034, 330, '_wp_trash_meta_time', '1607185089'),
(1033, 330, '_wp_trash_meta_status', 'publish'),
(1018, 322, '_wp_trash_meta_status', 'publish'),
(1019, 322, '_wp_trash_meta_time', '1607184201'),
(1021, 320, '_edit_lock', '1607184301:1'),
(1022, 320, '_wp_trash_meta_status', 'publish'),
(1023, 320, '_wp_trash_meta_time', '1607184552'),
(1024, 320, '_wp_desired_post_slug', 'login'),
(1025, 319, '_wp_trash_meta_status', 'publish'),
(1026, 319, '_wp_trash_meta_time', '1607184565'),
(1027, 319, '_wp_desired_post_slug', 'fiok-2'),
(1028, 321, '_wp_trash_meta_status', 'publish'),
(1029, 321, '_wp_trash_meta_time', '1607184571'),
(1030, 321, '_wp_desired_post_slug', 'regisztracio'),
(1031, 329, '_customize_restore_dismissed', '1'),
(1032, 303, '_edit_lock', '1607185552:1'),
(1049, 335, '_wp_attached_file', '2020/12/qc-1.png'),
(1050, 335, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:16:"2020/12/qc-1.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:16:"qc-1-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:17:"qc-1-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:16:"qc-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:16:"qc-1-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:17:"qc-1-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:17:"qc-1-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:16:"qc-1-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1051, 339, '_wp_attached_file', '2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png'),
(1052, 339, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1875;s:6:"height";i:870;s:4:"file";s:63:"2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png";s:5:"sizes";a:7:{s:6:"medium";a:4:{s:4:"file";s:63:"77398019_1050496535281850_3009940701971480576_o-4-1-300x139.png";s:5:"width";i:300;s:6:"height";i:139;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:64:"77398019_1050496535281850_3009940701971480576_o-4-1-1024x475.png";s:5:"width";i:1024;s:6:"height";i:475;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:63:"77398019_1050496535281850_3009940701971480576_o-4-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:63:"77398019_1050496535281850_3009940701971480576_o-4-1-768x356.png";s:5:"width";i:768;s:6:"height";i:356;s:9:"mime-type";s:9:"image/png";}s:9:"1536x1536";a:4:{s:4:"file";s:64:"77398019_1050496535281850_3009940701971480576_o-4-1-1536x713.png";s:5:"width";i:1536;s:6:"height";i:713;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:64:"77398019_1050496535281850_3009940701971480576_o-4-1-1280x594.png";s:5:"width";i:1280;s:6:"height";i:594;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:63:"77398019_1050496535281850_3009940701971480576_o-4-1-280x130.png";s:5:"width";i:280;s:6:"height";i:130;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1053, 195, '_edit_lock', '1607185560:1'),
(1058, 345, '_wp_attached_file', '2020/12/1605790863194.jpg'),
(1059, 345, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1162;s:6:"height";i:848;s:4:"file";s:25:"2020/12/1605790863194.jpg";s:5:"sizes";a:6:{s:6:"medium";a:4:{s:4:"file";s:25:"1605790863194-300x219.jpg";s:5:"width";i:300;s:6:"height";i:219;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:26:"1605790863194-1024x747.jpg";s:5:"width";i:1024;s:6:"height";i:747;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"1605790863194-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:25:"1605790863194-768x560.jpg";s:5:"width";i:768;s:6:"height";i:560;s:9:"mime-type";s:10:"image/jpeg";}s:11:"news-medium";a:4:{s:4:"file";s:25:"1605790863194-987x720.jpg";s:5:"width";i:987;s:6:"height";i:720;s:9:"mime-type";s:10:"image/jpeg";}s:10:"news-small";a:4:{s:4:"file";s:25:"1605790863194-280x204.jpg";s:5:"width";i:280;s:6:"height";i:204;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1060, 346, '_wp_attached_file', '2020/12/1591557903247.jpg'),
(1061, 346, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:180;s:6:"height";i:180;s:4:"file";s:25:"2020/12/1591557903247.jpg";s:5:"sizes";a:1:{s:9:"thumbnail";a:4:{s:4:"file";s:25:"1591557903247-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1062, 347, '_wp_attached_file', '2020/12/1605697469945.jpg'),
(1063, 347, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:680;s:6:"height";i:512;s:4:"file";s:25:"2020/12/1605697469945.jpg";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:25:"1605697469945-300x226.jpg";s:5:"width";i:300;s:6:"height";i:226;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"1605697469945-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:10:"news-small";a:4:{s:4:"file";s:25:"1605697469945-280x211.jpg";s:5:"width";i:280;s:6:"height";i:211;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1064, 348, '_wp_attached_file', '2020/12/1605650349538.png'),
(1065, 348, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1000;s:6:"height";i:1000;s:4:"file";s:25:"2020/12/1605650349538.png";s:5:"sizes";a:5:{s:6:"medium";a:4:{s:4:"file";s:25:"1605650349538-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"1605650349538-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:25:"1605650349538-768x768.png";s:5:"width";i:768;s:6:"height";i:768;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:25:"1605650349538-720x720.png";s:5:"width";i:720;s:6:"height";i:720;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:25:"1605650349538-280x280.png";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1066, 349, '_wp_attached_file', '2020/12/1605951181721.png'),
(1067, 349, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:100;s:6:"height";i:100;s:4:"file";s:25:"2020/12/1605951181721.png";s:5:"sizes";a:0:{}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1068, 350, '_wp_attached_file', '2020/12/1605446609632.jpg'),
(1069, 350, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:225;s:6:"height";i:225;s:4:"file";s:25:"2020/12/1605446609632.jpg";s:5:"sizes";a:1:{s:9:"thumbnail";a:4:{s:4:"file";s:25:"1605446609632-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1070, 351, '_wp_attached_file', '2020/12/1605895092964.png'),
(1071, 351, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:500;s:6:"height";i:500;s:4:"file";s:25:"2020/12/1605895092964.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:25:"1605895092964-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"1605895092964-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:25:"1605895092964-280x280.png";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1072, 352, '_wp_attached_file', '2020/12/1599839767029.png'),
(1073, 352, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:500;s:6:"height";i:426;s:4:"file";s:25:"2020/12/1599839767029.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:25:"1599839767029-300x256.png";s:5:"width";i:300;s:6:"height";i:256;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"1599839767029-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:25:"1599839767029-280x239.png";s:5:"width";i:280;s:6:"height";i:239;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1074, 353, '_wp_attached_file', '2020/12/1592040949034.png'),
(1075, 353, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:500;s:6:"height";i:500;s:4:"file";s:25:"2020/12/1592040949034.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:25:"1592040949034-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"1592040949034-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:25:"1592040949034-280x280.png";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1076, 354, '_wp_attached_file', '2020/12/1605813791071.png'),
(1077, 354, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:299;s:6:"height";i:168;s:4:"file";s:25:"2020/12/1605813791071.png";s:5:"sizes";a:2:{s:9:"thumbnail";a:4:{s:4:"file";s:25:"1605813791071-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:25:"1605813791071-280x157.png";s:5:"width";i:280;s:6:"height";i:157;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1078, 355, '_wp_attached_file', '2020/12/1605294552471.png'),
(1079, 355, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:200;s:6:"height";i:200;s:4:"file";s:25:"2020/12/1605294552471.png";s:5:"sizes";a:1:{s:9:"thumbnail";a:4:{s:4:"file";s:25:"1605294552471-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1080, 356, '_wp_attached_file', '2020/12/1604848919602.jpg'),
(1081, 356, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:280;s:6:"height";i:280;s:4:"file";s:25:"2020/12/1604848919602.jpg";s:5:"sizes";a:1:{s:9:"thumbnail";a:4:{s:4:"file";s:25:"1604848919602-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1082, 357, '_wp_attached_file', '2020/12/1605980084802.png'),
(1083, 357, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1500;s:6:"height";i:576;s:4:"file";s:25:"2020/12/1605980084802.png";s:5:"sizes";a:6:{s:6:"medium";a:4:{s:4:"file";s:25:"1605980084802-300x115.png";s:5:"width";i:300;s:6:"height";i:115;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:26:"1605980084802-1024x393.png";s:5:"width";i:1024;s:6:"height";i:393;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"1605980084802-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:25:"1605980084802-768x295.png";s:5:"width";i:768;s:6:"height";i:295;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:26:"1605980084802-1280x492.png";s:5:"width";i:1280;s:6:"height";i:492;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:25:"1605980084802-280x108.png";s:5:"width";i:280;s:6:"height";i:108;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1084, 358, '_wp_attached_file', '2020/12/1605982928427.jpg'),
(1085, 358, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1999;s:6:"height";i:1999;s:4:"file";s:25:"2020/12/1605982928427.jpg";s:5:"sizes";a:8:{s:6:"medium";a:4:{s:4:"file";s:25:"1605982928427-300x300.jpg";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:27:"1605982928427-1024x1024.jpg";s:5:"width";i:1024;s:6:"height";i:1024;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"1605982928427-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:25:"1605982928427-768x768.jpg";s:5:"width";i:768;s:6:"height";i:768;s:9:"mime-type";s:10:"image/jpeg";}s:9:"1536x1536";a:4:{s:4:"file";s:27:"1605982928427-1536x1536.jpg";s:5:"width";i:1536;s:6:"height";i:1536;s:9:"mime-type";s:10:"image/jpeg";}s:8:"news-big";a:4:{s:4:"file";s:27:"1605982928427-1080x1080.jpg";s:5:"width";i:1080;s:6:"height";i:1080;s:9:"mime-type";s:10:"image/jpeg";}s:11:"news-medium";a:4:{s:4:"file";s:25:"1605982928427-720x720.jpg";s:5:"width";i:720;s:6:"height";i:720;s:9:"mime-type";s:10:"image/jpeg";}s:10:"news-small";a:4:{s:4:"file";s:25:"1605982928427-280x280.jpg";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1086, 359, '_wp_attached_file', '2020/12/67061218_2651847281506495_3289316139754061824_n.jpg'),
(1087, 359, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:850;s:6:"height";i:314;s:4:"file";s:59:"2020/12/67061218_2651847281506495_3289316139754061824_n.jpg";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:59:"67061218_2651847281506495_3289316139754061824_n-300x111.jpg";s:5:"width";i:300;s:6:"height";i:111;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:59:"67061218_2651847281506495_3289316139754061824_n-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:59:"67061218_2651847281506495_3289316139754061824_n-768x284.jpg";s:5:"width";i:768;s:6:"height";i:284;s:9:"mime-type";s:10:"image/jpeg";}s:10:"news-small";a:4:{s:4:"file";s:59:"67061218_2651847281506495_3289316139754061824_n-280x103.jpg";s:5:"width";i:280;s:6:"height";i:103;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1088, 360, '_wp_attached_file', '2020/12/79405682_2955950724429481_3204597050847002624_o.jpg'),
(1089, 360, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:2048;s:6:"height";i:1152;s:4:"file";s:59:"2020/12/79405682_2955950724429481_3204597050847002624_o.jpg";s:5:"sizes";a:8:{s:6:"medium";a:4:{s:4:"file";s:59:"79405682_2955950724429481_3204597050847002624_o-300x169.jpg";s:5:"width";i:300;s:6:"height";i:169;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:60:"79405682_2955950724429481_3204597050847002624_o-1024x576.jpg";s:5:"width";i:1024;s:6:"height";i:576;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:59:"79405682_2955950724429481_3204597050847002624_o-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:59:"79405682_2955950724429481_3204597050847002624_o-768x432.jpg";s:5:"width";i:768;s:6:"height";i:432;s:9:"mime-type";s:10:"image/jpeg";}s:9:"1536x1536";a:4:{s:4:"file";s:60:"79405682_2955950724429481_3204597050847002624_o-1536x864.jpg";s:5:"width";i:1536;s:6:"height";i:864;s:9:"mime-type";s:10:"image/jpeg";}s:8:"news-big";a:4:{s:4:"file";s:61:"79405682_2955950724429481_3204597050847002624_o-1920x1080.jpg";s:5:"width";i:1920;s:6:"height";i:1080;s:9:"mime-type";s:10:"image/jpeg";}s:11:"news-medium";a:4:{s:4:"file";s:60:"79405682_2955950724429481_3204597050847002624_o-1280x720.jpg";s:5:"width";i:1280;s:6:"height";i:720;s:9:"mime-type";s:10:"image/jpeg";}s:10:"news-small";a:4:{s:4:"file";s:59:"79405682_2955950724429481_3204597050847002624_o-280x158.jpg";s:5:"width";i:280;s:6:"height";i:158;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1090, 361, '_wp_attached_file', '2020/12/djuza.png'),
(1091, 361, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:348;s:6:"height";i:519;s:4:"file";s:17:"2020/12/djuza.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:17:"djuza-201x300.png";s:5:"width";i:201;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:17:"djuza-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:17:"djuza-235x350.png";s:5:"width";i:235;s:6:"height";i:350;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1092, 287, '_wp_attachment_image_alt', 'LG Ultragear Warmup Kupa 2020 - 1st'),
(1093, 362, '_wp_attached_file', '2020/12/asd-1.png'),
(1094, 362, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:804;s:6:"height";i:884;s:4:"file";s:17:"2020/12/asd-1.png";s:5:"sizes";a:5:{s:6:"medium";a:4:{s:4:"file";s:17:"asd-1-273x300.png";s:5:"width";i:273;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:17:"asd-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:17:"asd-1-768x844.png";s:5:"width";i:768;s:6:"height";i:844;s:9:"mime-type";s:9:"image/png";}s:11:"news-medium";a:4:{s:4:"file";s:17:"asd-1-655x720.png";s:5:"width";i:655;s:6:"height";i:720;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:17:"asd-1-280x308.png";s:5:"width";i:280;s:6:"height";i:308;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1095, 362, '_wp_attachment_image_alt', 'LG Ultragear Warmup Kupa 2020 - 2nd'),
(1104, 367, '_wp_attached_file', '2020/12/hrcs2.png'),
(1105, 367, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:416;s:6:"height";i:448;s:4:"file";s:17:"2020/12/hrcs2.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:17:"hrcs2-279x300.png";s:5:"width";i:279;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:17:"hrcs2-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:17:"hrcs2-280x302.png";s:5:"width";i:280;s:6:"height";i:302;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1112, 371, '_wp_attached_file', '2020/12/0moGWusn_400x400.jpg'),
(1108, 369, '_wp_attached_file', '2020/12/logo-e1hu.png'),
(1109, 369, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:228;s:6:"height";i:55;s:4:"file";s:21:"2020/12/logo-e1hu.png";s:5:"sizes";a:1:{s:9:"thumbnail";a:4:{s:4:"file";s:20:"logo-e1hu-150x55.png";s:5:"width";i:150;s:6:"height";i:55;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1110, 370, '_wp_attached_file', '2020/12/1f382cebb409e9d5b9af36ab3c6e3dd02085d66d.png'),
(1111, 370, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:906;s:6:"height";i:303;s:4:"file";s:52:"2020/12/1f382cebb409e9d5b9af36ab3c6e3dd02085d66d.png";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:52:"1f382cebb409e9d5b9af36ab3c6e3dd02085d66d-300x100.png";s:5:"width";i:300;s:6:"height";i:100;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:52:"1f382cebb409e9d5b9af36ab3c6e3dd02085d66d-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:52:"1f382cebb409e9d5b9af36ab3c6e3dd02085d66d-768x257.png";s:5:"width";i:768;s:6:"height";i:257;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:51:"1f382cebb409e9d5b9af36ab3c6e3dd02085d66d-280x94.png";s:5:"width";i:280;s:6:"height";i:94;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1113, 371, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:400;s:6:"height";i:400;s:4:"file";s:28:"2020/12/0moGWusn_400x400.jpg";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:28:"0moGWusn_400x400-300x300.jpg";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:28:"0moGWusn_400x400-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:10:"news-small";a:4:{s:4:"file";s:28:"0moGWusn_400x400-280x280.jpg";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1114, 372, '_wp_attached_file', '2020/12/Y1xbB3zPGFWArTjRZPRGb.png'),
(1115, 372, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:400;s:6:"height";i:417;s:4:"file";s:33:"2020/12/Y1xbB3zPGFWArTjRZPRGb.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:33:"Y1xbB3zPGFWArTjRZPRGb-288x300.png";s:5:"width";i:288;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:33:"Y1xbB3zPGFWArTjRZPRGb-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:33:"Y1xbB3zPGFWArTjRZPRGb-280x292.png";s:5:"width";i:280;s:6:"height";i:292;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1121, 375, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:300;s:6:"height";i:300;s:4:"file";s:72:"2020/12/846ab15d-f0f3-4e41-89b2-176ec0e560c3-profile_image-300x300-1.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:72:"846ab15d-f0f3-4e41-89b2-176ec0e560c3-profile_image-300x300-1-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:72:"846ab15d-f0f3-4e41-89b2-176ec0e560c3-profile_image-300x300-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:72:"846ab15d-f0f3-4e41-89b2-176ec0e560c3-profile_image-300x300-1-280x280.png";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1120, 375, '_wp_attached_file', '2020/12/846ab15d-f0f3-4e41-89b2-176ec0e560c3-profile_image-300x300-1.png'),
(1122, 376, '_wp_attached_file', '2020/12/DdbZTQYVQAAMPMP.jpg'),
(1123, 376, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1200;s:6:"height";i:900;s:4:"file";s:27:"2020/12/DdbZTQYVQAAMPMP.jpg";s:5:"sizes";a:6:{s:6:"medium";a:4:{s:4:"file";s:27:"DdbZTQYVQAAMPMP-300x225.jpg";s:5:"width";i:300;s:6:"height";i:225;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:28:"DdbZTQYVQAAMPMP-1024x768.jpg";s:5:"width";i:1024;s:6:"height";i:768;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:27:"DdbZTQYVQAAMPMP-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:27:"DdbZTQYVQAAMPMP-768x576.jpg";s:5:"width";i:768;s:6:"height";i:576;s:9:"mime-type";s:10:"image/jpeg";}s:11:"news-medium";a:4:{s:4:"file";s:27:"DdbZTQYVQAAMPMP-960x720.jpg";s:5:"width";i:960;s:6:"height";i:720;s:9:"mime-type";s:10:"image/jpeg";}s:10:"news-small";a:4:{s:4:"file";s:27:"DdbZTQYVQAAMPMP-280x210.jpg";s:5:"width";i:280;s:6:"height";i:210;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1124, 377, '_wp_attached_file', '2020/12/VrLzVW10_400x400.png'),
(1125, 377, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:400;s:6:"height";i:400;s:4:"file";s:28:"2020/12/VrLzVW10_400x400.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:28:"VrLzVW10_400x400-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:28:"VrLzVW10_400x400-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:28:"VrLzVW10_400x400-280x280.png";s:5:"width";i:280;s:6:"height";i:280;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(1128, 379, '_wp_attached_file', '2020/12/asdasd.png'),
(1129, 379, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:700;s:6:"height";i:350;s:4:"file";s:18:"2020/12/asdasd.png";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:18:"asdasd-300x150.png";s:5:"width";i:300;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:18:"asdasd-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:10:"news-small";a:4:{s:4:"file";s:18:"asdasd-280x140.png";s:5:"width";i:280;s:6:"height";i:140;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_posts`
--

CREATE TABLE IF NOT EXISTS `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=380 ;

--
-- A tábla adatainak kiíratása `wp_posts`
--

INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(1, 1, '2020-12-05 10:40:40', '2020-12-05 10:40:40', '<!-- wp:paragraph -->\n<p>Üdvözlet a WordPress-ben! Ez az első bejegyzés, amelyet lehet akár módosítani, akár törölni, aztán kezdődhet az írás, a tartalommal történő feltöltés.</p>\n<!-- /wp:paragraph -->', 'Helló Világ!', '', 'publish', 'open', 'open', '', 'hello-vilag', '', '', '2020-12-05 10:40:40', '2020-12-05 10:40:40', '', 0, 'http://esportplay.hu/?p=1', 0, 'post', '', 1),
(2, 1, '2020-12-05 10:40:40', '2020-12-05 10:40:40', '<!-- wp:paragraph -->\n<p>Ez egy mintaoldal. Az oldal különbözik a bejegyzéstől annyiban, hogy az oldal egy állandó tartalmú bejegyzés, ami - a legtöbb sablonnál - a weboldal navigációs részében állandó helyen van.\nA legtöbb ember olyan Bemutatkozó oldallal kezd, amelyik bemutatja őt, vagy a tevékenységét a weboldal látogatóinak. A Bemutatkozás oldal valami ilyesmi lehet:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class="wp-block-quote"><p>Üdvözlet az Olvasóknak! Nappal biciklis pizzafutár vagyok, éjszaka pedig egy törekvő színész-tanonc, ez pedig az én weboldalam.<br>Budapesten élek és van egy csodálatos német juhász kutyám, aki Velorex névre hallgat. Kedvenc koktélom a Piña Colada, de a Mojitot is nagyon kedvelem. (De, azért az igazi nedű: egy bársonyos vörösbor.)</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>...vagy valami egészen más:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class="wp-block-quote"><p>Az XYZ Bigyó Vállalatot 1971-ben alapították, azóta gyártja a legjobb minőségű bigyókat. A cég központja Budapesten található, ahol több mint 2000 embert foglalkoztatnak, valamint számos közösségi és jótékonysági programban is aktívan résztvesznek.</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>Új WordPress felhasználóként a <a href="http://esportplay.hu/wp-admin/">Vezérlőpult</a> részre ugorva lehet törölni ezt az oldalt, és létrehozni egy úja oldalt a saját tartalmunk részére. Jó szórakozást!</p>\n<!-- /wp:paragraph -->', 'Ez egy minta oldal', '', 'publish', 'closed', 'open', '', 'ez-egy-minta-oldal', '', '', '2020-12-05 10:40:40', '2020-12-05 10:40:40', '', 0, 'http://esportplay.hu/?page_id=2', 0, 'page', '', 0),
(3, 1, '2020-12-05 10:40:40', '2020-12-05 10:40:40', '<!-- wp:heading --><h2>Kik vagyunk</h2><!-- /wp:heading --><!-- wp:paragraph --><p>A weboldalunk címe: http://esportplay.hu.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Melyek azok a személyes adatok, amiket gyűjtünk és milyen céllal gyűjtjük ezeket</h2><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Hozzászólások</h3><!-- /wp:heading --><!-- wp:paragraph --><p>Hozzászólás beküldésekor a hozzászólási űrlapban megadottakon kívül begyűjtésre kerül a hozzászóló IP címe és a böngészőazonosító karakterlánc a kéretlen tartalmak kiszűrése céljából.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>Egy személytelenített, az e-mail címből előállított karakterlánc (hashnek szokás nevezni) kerül továbbításra a Gravatar szolgáltatás felé, ha ez az oldalon használatban van. A Gravatar szolgáltatás feltételei az alábbi címen tekinthetőek meg: https://automattic.com/privacy/. A hozzászólás elfogadása után, a hozzászólásunk tartalma és a profil képünk is megjelenik nyilvánosan.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Média</h3><!-- /wp:heading --><!-- wp:paragraph --><p>Amennyiben regisztrált felhasználó által kerül kép feltöltésre a honlapra, kerülni kell az az olyan EXIF-eket, amelyekben GPS pozíció adatok is szerepelnek. A honlap látogatói ezeket letölthetik és kinyerhetik a helyadatokat a honlapon található képekből.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Kapcsolatfelvételi űrlapok</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Sütik</h3><!-- /wp:heading --><!-- wp:paragraph --><p>Ha hozzászólást írunk a honlapon, a megadott nevet, e-mail és honlap címet sütikben eltároljuk. A tárolás a kényelmi célokat szolgál azért, így a következő hozzászóláskor ezeket a mező adatokat nem kell kitölteni. A sütik lejárati ideje egy év.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>Ha ellátogatunk a bejelentkezési oldalra, akkor átmeneti sütiket állítunk be annak érdekében, hogy megállapítsuk, hogy a böngésző elfogadja-e a sütiket. Ezek a sütik nem tartalmaznak személyes információt, és törlődnek, ahogy bezárjuk a böngészőt.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>A honlapra történő bejelentkezéskor több sütit hozunk létre, amely elmenti a bejelentkezési információt és a szerkesztőfelület megjelenítési opcióit. A bejelentkezési sütik két napig érvényesek, a szerkesztőfelület megjelenítési opcióit tároló süti egy évig. Amennyiben az  &quot;Emlékezz rám&quot; opciót bejelöljük, a bejelentkezés két hétig folytatódik. Kijelentkezéskor a bejelentkezési sütik eltávolításra kerülnek.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>Amennyiben bejegyzést vagy oldalt szerkesztünk, egy újabb sütit tárol el a böngészőnk. Ez a süti nem tartalmaz személyes adatot, egyszerűen csak a bejegyzés azonosító számát tárolja, amelyet szerkesztettünk. Egy nap múlva jár le az érvényessége.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Más honlapokról származó beágyazott tartalmak</h3><!-- /wp:heading --><!-- wp:paragraph --><p>A honlapon elérhető bejegyzések külső forrásból származó beágyazott tartalmakat (pl. videók, képek, cikkek stb.) használhatnak. A külső forrásból származó beágyazott tartalmak pontosan úgy viselkednek, mintha meglátogattunk volna egy másik honlapot.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>Ezek a webhelyek lehetséges, hogy adatot gyűjtenek a látogatókról, sütiket vagy harmadik féltől származó követőkódot használnak, figyelik a beágyazott tartalommal kapcsolatos felhasználói viselkedést, ha rendelkezünk felhasználói fiókkal és be vagyunk jelentkezve az oldalra.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Analitika</h3><!-- /wp:heading --><!-- wp:heading --><h2>Kivel osztjuk meg a felhasználói adatokat</h2><!-- /wp:heading --><!-- wp:heading --><h2>Mennyi ideig őrizzük a személyes adatot</h2><!-- /wp:heading --><!-- wp:paragraph --><p>Ha hozzászólunk, a hozzászólás és annak metaadatai nem meghatározható ideig a rendszerben maradnak. Ennek célja, hogy az összes ezt követő bármely hozzászólás általunk megismertté és jóváhagyottá váljon, azaz ne kerüljön fel a moderálandó hozzászólások listájára.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>A honlapon regisztrált felhasználók (ha vannak ilyenek) személyes adatai a saját felhasználói profiljukban is tárolásra kerülnek. Minden felhasználó megtekintheti, szerkesztheti vagy törölheti a személyes adatait bármikor (kivéve, hogy nem változtathatja meg a saját felhasználói nevét). A honlap rendszergazdái ezen információkat szintén megtekinthetik és szerkeszthetik.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Milyen jogokkal rendelkezik a felhasználó a saját adatai kapcsán</h2><!-- /wp:heading --><!-- wp:paragraph --><p>A weboldalon regisztrált fiók vagy hozzászólás írása esetén kérhető a személyes adatok export fájlban történő megküldése, amely bármilyen adatot tartalmaz, amit korábban a felhasználó rendelkezésünkre bocsátott. Kérhető továbbá, hogy bármilyen korábban megadott személyes adatot töröljük. Ez nem vonatkozik azokra az adatokra, amelyeket adminisztrációs, jogi vagy biztonsági okokból kötelező megőriznünk.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Hová továbbítjuk az adatokat</h2><!-- /wp:heading --><!-- wp:paragraph --><p>A látogatók által beküldött hozzászólásokat automatikus spamszűrő szolgáltatás ellenőrizheti.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Kapcsolati adatok</h2><!-- /wp:heading --><!-- wp:heading --><h2>További információk</h2><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Hogyan védjük a felhasználói személyes adatokat</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Érvényben lévő eljárások adatkezelési sérelmek esetén</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Milyen harmadik féltől származó adatokat kapunk</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Milyen automatizált döntéshozatalt és/vagy profilalkotást végzünk a felhasználói adatokkal</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Szabályozott iparág közzétételi követelményei</h3><!-- /wp:heading -->', 'Adatvédelmi irányelvek', '', 'draft', 'closed', 'open', '', 'adatkezelesi-tajekoztato', '', '', '2020-12-05 10:40:40', '2020-12-05 10:40:40', '', 0, 'http://esportplay.hu/?page_id=3', 0, 'page', '', 0),
(4, 1, '2020-12-05 10:40:53', '0000-00-00 00:00:00', '', 'Automatikus vázlat', '', 'auto-draft', 'open', 'open', '', '', '', '', '2020-12-05 10:40:53', '0000-00-00 00:00:00', '', 0, 'http://esportplay.hu/?p=4', 0, 'post', '', 0),
(6, 1, '2020-12-05 11:47:00', '2020-12-05 10:47:00', '{\n    "old_sidebars_widgets_data": {\n        "value": {\n            "wp_inactive_widgets": [],\n            "sidebar-1": [\n                "search-2",\n                "recent-posts-2",\n                "recent-comments-2"\n            ],\n            "sidebar-2": [\n                "archives-2",\n                "categories-2",\n                "meta-2"\n            ]\n        },\n        "type": "global_variable",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 10:47:00"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '769641d7-2225-436f-b786-6d32137b8ff8', '', '', '2020-12-05 11:47:00', '2020-12-05 10:47:00', '', 0, 'http://esportplay.hu/2020/12/05/769641d7-2225-436f-b786-6d32137b8ff8/', 0, 'customize_changeset', '', 0),
(258, 1, '2020-12-05 14:39:45', '2020-12-05 13:39:45', '', 'logo', '', 'inherit', 'open', 'closed', '', 'logo', '', '', '2020-12-05 14:39:45', '2020-12-05 13:39:45', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/logo.png', 0, 'attachment', 'image/png', 0),
(259, 1, '2020-12-05 14:40:02', '2020-12-05 13:40:02', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-logo.png', 'cropped-logo.png', '', 'inherit', 'open', 'closed', '', 'cropped-logo-png', '', '', '2020-12-05 14:40:02', '2020-12-05 13:40:02', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-logo.png', 0, 'attachment', 'image/png', 0),
(22, 1, '2020-11-28 19:56:39', '0000-00-00 00:00:00', '<!-- wp:paragraph -->\n<p>Egy művészember itt is bemutathatja magát, a munkáit, vagy egy üzletember a a vállalkozását, küldetését írhatja ide.</p>\n<!-- /wp:paragraph -->', 'Rólunk', '', 'auto-draft', 'closed', 'closed', '', '', '', '', '2020-11-28 19:56:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?page_id=22', 0, 'page', '', 0),
(23, 1, '2020-11-28 19:56:39', '0000-00-00 00:00:00', '<!-- wp:paragraph -->\n<p>Ez egy néhány kapcsolati adatot, mint pl. cím, telefonszám, tartalmazó oldal. Lehet bővítményt is használni egy kapcsolati űrlap beillesztéséhez.</p>\n<!-- /wp:paragraph -->', 'Elérhetőség', '', 'auto-draft', 'closed', 'closed', '', '', '', '', '2020-11-28 19:56:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?page_id=23', 0, 'page', '', 0),
(24, 1, '2020-11-28 19:56:39', '0000-00-00 00:00:00', '', 'Blog', '', 'auto-draft', 'closed', 'closed', '', '', '', '', '2020-11-28 19:56:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?page_id=24', 0, 'page', '', 0),
(25, 1, '2020-11-28 19:56:39', '0000-00-00 00:00:00', '<!-- wp:paragraph -->\n<p>Ez egy kezdőlap szekció minta. A kezdőlap szekciói bármelyik oldal lehet a kezdőoldalt leszámítva, beleértve a legutóbbi bejegyzések oldalát is.</p>\n<!-- /wp:paragraph -->', 'Kezdőoldal szekció', '', 'auto-draft', 'closed', 'closed', '', '', '', '', '2020-11-28 19:56:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?page_id=25', 0, 'page', '', 0),
(26, 1, '2020-11-28 19:56:39', '0000-00-00 00:00:00', '{\n    "widget_text[4]": {\n        "starter_content": true,\n        "value": {\n            "encoded_serialized_instance": "YTo0OntzOjU6InRpdGxlIjtzOjI0OiJJdHQgdmFneXVuayBlbMOpcmhldMWRZWsiO3M6NDoidGV4dCI7czoxNTU6IjxzdHJvbmc+Q8OtbTwvc3Ryb25nPgpGxZEgw7p0IDEyMy4KMTAwMSBCdWRhcGVzdAoKPHN0cm9uZz7Dk3JhPC9zdHJvbmc+CkjDqXRmxZEmbmRhc2g7UMOpbnRlazogMDk6MDAmbmRhc2g7MTc6MDAKU3pvbWJhdCAmYW1wOyBWYXPDoXJuYXA6IDExOjAwJm5kYXNoOzE1OjAwIjtzOjY6ImZpbHRlciI7YjoxO3M6NjoidmlzdWFsIjtiOjE7fQ==",\n            "title": "Itt vagyunk el\\u00e9rhet\\u0151ek",\n            "is_widget_customizer_js_value": true,\n            "instance_hash_key": "07303e90cc05fd60411b5230d3f9dfac"\n        },\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "widget_search[3]": {\n        "starter_content": true,\n        "value": {\n            "encoded_serialized_instance": "YToxOntzOjU6InRpdGxlIjtzOjg6IktlcmVzw6lzIjt9",\n            "title": "Keres\\u00e9s",\n            "is_widget_customizer_js_value": true,\n            "instance_hash_key": "fae7ec12e8af63ee59d95c8c2303ddb0"\n        },\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "widget_text[5]": {\n        "starter_content": true,\n        "value": {\n            "encoded_serialized_instance": "YTo0OntzOjU6InRpdGxlIjtzOjEzOiJCZW11dGF0a296w6FzIjtzOjQ6InRleHQiO3M6MTA2OiJFeiBha8OhciBqw7MgaGVseSBhaGhveiwgaG9neSBiZW11dGFzc3VrIG1hZ3Vua2F0IMOpcyBhIGhvbmxhcHVua2F0IHZhZ3kga8O2c3rDtm5ldGV0IG1vbmRqdW5rIHZhbGFtacOpcnQuIjtzOjY6ImZpbHRlciI7YjoxO3M6NjoidmlzdWFsIjtiOjE7fQ==",\n            "title": "Bemutatkoz\\u00e1s",\n            "is_widget_customizer_js_value": true,\n            "instance_hash_key": "7e516a51b070a994b5ce3fe705ea2a43"\n        },\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "sidebars_widgets[sidebar-1]": {\n        "starter_content": true,\n        "value": [\n            "text-4",\n            "search-3",\n            "text-5"\n        ],\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "widget_text[6]": {\n        "starter_content": true,\n        "value": {\n            "encoded_serialized_instance": "YTo0OntzOjU6InRpdGxlIjtzOjI0OiJJdHQgdmFneXVuayBlbMOpcmhldMWRZWsiO3M6NDoidGV4dCI7czoxNTU6IjxzdHJvbmc+Q8OtbTwvc3Ryb25nPgpGxZEgw7p0IDEyMy4KMTAwMSBCdWRhcGVzdAoKPHN0cm9uZz7Dk3JhPC9zdHJvbmc+CkjDqXRmxZEmbmRhc2g7UMOpbnRlazogMDk6MDAmbmRhc2g7MTc6MDAKU3pvbWJhdCAmYW1wOyBWYXPDoXJuYXA6IDExOjAwJm5kYXNoOzE1OjAwIjtzOjY6ImZpbHRlciI7YjoxO3M6NjoidmlzdWFsIjtiOjE7fQ==",\n            "title": "Itt vagyunk el\\u00e9rhet\\u0151ek",\n            "is_widget_customizer_js_value": true,\n            "instance_hash_key": "07303e90cc05fd60411b5230d3f9dfac"\n        },\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "sidebars_widgets[sidebar-2]": {\n        "starter_content": true,\n        "value": [\n            "text-6"\n        ],\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "widget_text[7]": {\n        "starter_content": true,\n        "value": {\n            "encoded_serialized_instance": "YTo0OntzOjU6InRpdGxlIjtzOjEzOiJCZW11dGF0a296w6FzIjtzOjQ6InRleHQiO3M6MTA2OiJFeiBha8OhciBqw7MgaGVseSBhaGhveiwgaG9neSBiZW11dGFzc3VrIG1hZ3Vua2F0IMOpcyBhIGhvbmxhcHVua2F0IHZhZ3kga8O2c3rDtm5ldGV0IG1vbmRqdW5rIHZhbGFtacOpcnQuIjtzOjY6ImZpbHRlciI7YjoxO3M6NjoidmlzdWFsIjtiOjE7fQ==",\n            "title": "Bemutatkoz\\u00e1s",\n            "is_widget_customizer_js_value": true,\n            "instance_hash_key": "7e516a51b070a994b5ce3fe705ea2a43"\n        },\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "widget_search[4]": {\n        "starter_content": true,\n        "value": {\n            "encoded_serialized_instance": "YToxOntzOjU6InRpdGxlIjtzOjg6IktlcmVzw6lzIjt9",\n            "title": "Keres\\u00e9s",\n            "is_widget_customizer_js_value": true,\n            "instance_hash_key": "fae7ec12e8af63ee59d95c8c2303ddb0"\n        },\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "sidebars_widgets[sidebar-3]": {\n        "starter_content": true,\n        "value": [\n            "text-7",\n            "search-4"\n        ],\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menus_created_posts": {\n        "starter_content": true,\n        "value": [\n            18,\n            19,\n            20,\n            21,\n            22,\n            23,\n            24,\n            25\n        ],\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu[-1]": {\n        "starter_content": true,\n        "value": {\n            "name": "Fels\\u0151 men\\u00fc"\n        },\n        "type": "nav_menu",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu_item[-1]": {\n        "starter_content": true,\n        "value": {\n            "type": "custom",\n            "title": "Kezd\\u0151lap",\n            "url": "http://localhost/",\n            "position": 0,\n            "nav_menu_term_id": -1,\n            "object_id": 0\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu_item[-2]": {\n        "starter_content": true,\n        "value": {\n            "type": "post_type",\n            "object": "page",\n            "object_id": 22,\n            "position": 1,\n            "nav_menu_term_id": -1,\n            "title": "R\\u00f3lunk"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu_item[-3]": {\n        "starter_content": true,\n        "value": {\n            "type": "post_type",\n            "object": "page",\n            "object_id": 24,\n            "position": 2,\n            "nav_menu_term_id": -1,\n            "title": "Blog"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu_item[-4]": {\n        "starter_content": true,\n        "value": {\n            "type": "post_type",\n            "object": "page",\n            "object_id": 23,\n            "position": 3,\n            "nav_menu_term_id": -1,\n            "title": "El\\u00e9rhet\\u0151s\\u00e9g"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nld-theme-index::nav_menu_locations[top]": {\n        "starter_content": true,\n        "value": -1,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu[-5]": {\n        "starter_content": true,\n        "value": {\n            "name": "K\\u00f6z\\u00f6ss\\u00e9gi hivatkoz\\u00e1sok men\\u00fc"\n        },\n        "type": "nav_menu",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu_item[-5]": {\n        "starter_content": true,\n        "value": {\n            "title": "Yelp",\n            "url": "https://www.yelp.com",\n            "position": 0,\n            "nav_menu_term_id": -5,\n            "object_id": 0\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu_item[-6]": {\n        "starter_content": true,\n        "value": {\n            "title": "Facebook",\n            "url": "https://www.facebook.com/wordpress",\n            "position": 1,\n            "nav_menu_term_id": -5,\n            "object_id": 0\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu_item[-7]": {\n        "starter_content": true,\n        "value": {\n            "title": "Twitter",\n            "url": "https://twitter.com/wordpress",\n            "position": 2,\n            "nav_menu_term_id": -5,\n            "object_id": 0\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu_item[-8]": {\n        "starter_content": true,\n        "value": {\n            "title": "Instagram",\n            "url": "https://www.instagram.com/explore/tags/wordcamp/",\n            "position": 3,\n            "nav_menu_term_id": -5,\n            "object_id": 0\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nav_menu_item[-9]": {\n        "starter_content": true,\n        "value": {\n            "title": "Email",\n            "url": "mailto:wordpress@example.com",\n            "position": 4,\n            "nav_menu_term_id": -5,\n            "object_id": 0\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nld-theme-index::nav_menu_locations[social]": {\n        "starter_content": true,\n        "value": -5,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "show_on_front": {\n        "starter_content": true,\n        "value": "page",\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "page_on_front": {\n        "starter_content": true,\n        "value": 21,\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "page_for_posts": {\n        "starter_content": true,\n        "value": 24,\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nld-theme-index::panel_1": {\n        "starter_content": true,\n        "value": 25,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nld-theme-index::panel_2": {\n        "starter_content": true,\n        "value": 22,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nld-theme-index::panel_3": {\n        "starter_content": true,\n        "value": 24,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    },\n    "nld-theme-index::panel_4": {\n        "starter_content": true,\n        "value": 23,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 19:56:39"\n    }\n}', '', '', 'auto-draft', 'closed', 'closed', '', '86d9be58-7aa6-4dfd-98e7-91a222321851', '', '', '2020-11-28 19:56:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?p=26', 0, 'customize_changeset', '', 0),
(31, 1, '2020-11-28 21:08:59', '2020-11-28 20:08:59', '{\n    "pixiefreak::pixiefreak_primary_color": {\n        "value": "#ff6b6b",\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:08:59"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '0db9bbc4-7e2f-49d8-b877-3c7eec47b1d3', '', '', '2020-11-28 21:08:59', '2020-11-28 20:08:59', '', 0, 'http://localhost/2020/11/28/0db9bbc4-7e2f-49d8-b877-3c7eec47b1d3/', 0, 'customize_changeset', '', 0),
(32, 1, '2020-11-28 21:11:32', '0000-00-00 00:00:00', '', 'Automatikus vázlat', '', 'auto-draft', 'closed', 'closed', '', '', '', '', '2020-11-28 21:11:32', '0000-00-00 00:00:00', '', 0, 'http://localhost/?page_id=32', 0, 'page', '', 0),
(33, 1, '2020-11-28 21:12:28', '0000-00-00 00:00:00', '', 'Automatikus vázlat', '', 'auto-draft', 'closed', 'closed', '', '', '', '', '2020-11-28 21:12:28', '0000-00-00 00:00:00', '', 0, 'http://localhost/?page_id=33', 0, 'page', '', 0),
(34, 1, '2020-11-28 21:36:39', '2020-11-28 20:36:39', '{\n    "pixiefreak::nav_menu_locations[header_menu]": {\n        "value": -4724601509843702000,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:36:39"\n    },\n    "nav_menu[-4724601509843702000]": {\n        "value": {\n            "name": "Cikkek",\n            "description": "",\n            "parent": 0,\n            "auto_add": false\n        },\n        "type": "nav_menu",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:36:39"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'bab68a1e-2407-4643-9370-36f44c5a26d9', '', '', '2020-11-28 21:36:39', '2020-11-28 20:36:39', '', 0, 'http://localhost/2020/11/28/bab68a1e-2407-4643-9370-36f44c5a26d9/', 0, 'customize_changeset', '', 0),
(35, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '{\n    "nav_menu[2]": {\n        "value": {\n            "name": "menu",\n            "description": "",\n            "parent": 0,\n            "auto_add": false\n        },\n        "type": "nav_menu",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:37:45"\n    },\n    "nav_menu_item[-2050825570808926200]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:37:45"\n    },\n    "nav_menu_item[-555745361292847100]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:37:45"\n    },\n    "nav_menu_item[-1345441673397203000]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:37:45"\n    },\n    "nav_menus_created_posts": {\n        "value": [\n            36,\n            37,\n            38,\n            39,\n            40\n        ],\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:38:41"\n    },\n    "nav_menu_item[-8732397350053683000]": {\n        "value": {\n            "object_id": 36,\n            "object": "page",\n            "menu_item_parent": 0,\n            "position": 4,\n            "type": "post_type",\n            "title": "Cikkek",\n            "url": "http://localhost/?page_id=36",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Cikkek",\n            "nav_menu_term_id": 2,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:38:41"\n    },\n    "nav_menu_item[-2321168116099924000]": {\n        "value": {\n            "object_id": 37,\n            "object": "page",\n            "menu_item_parent": 0,\n            "position": 1,\n            "type": "post_type",\n            "title": "Versenyek",\n            "url": "http://localhost/?page_id=37",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Versenyek",\n            "nav_menu_term_id": 2,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:38:41"\n    },\n    "nav_menu_item[-1875477142478129200]": {\n        "value": {\n            "object_id": 38,\n            "object": "page",\n            "menu_item_parent": 0,\n            "position": 5,\n            "type": "post_type",\n            "title": "M\\u00e9dia",\n            "url": "http://localhost/?page_id=38",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "M\\u00e9dia",\n            "nav_menu_term_id": 2,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:38:41"\n    },\n    "nav_menu_item[-8183508465014811000]": {\n        "value": {\n            "object_id": 39,\n            "object": "page",\n            "menu_item_parent": 0,\n            "position": 2,\n            "type": "post_type",\n            "title": "Csapatok",\n            "url": "http://localhost/?page_id=39",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Csapatok",\n            "nav_menu_term_id": 2,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:38:41"\n    },\n    "nav_menu_item[-5951504098708908000]": {\n        "value": {\n            "object_id": 40,\n            "object": "page",\n            "menu_item_parent": -8183508465014811000,\n            "position": 3,\n            "type": "post_type",\n            "title": "J\\u00e1t\\u00e9kosok",\n            "url": "http://localhost/?page_id=40",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "J\\u00e1t\\u00e9kosok",\n            "nav_menu_term_id": 2,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:38:41"\n    },\n    "nav_menu_item[-4974825898857036000]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:38:41"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'a0aab18e-4b52-4150-9660-399cdce087c8', '', '', '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 0, 'http://localhost/?p=35', 0, 'customize_changeset', '', 0),
(36, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 'Cikkek', '', 'publish', 'closed', 'closed', '', 'cikkek', '', '', '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 0, 'http://localhost/?page_id=36', 0, 'page', '', 0),
(37, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 'Versenyek', '', 'publish', 'closed', 'closed', '', 'versenyek', '', '', '2020-11-28 21:42:00', '2020-11-28 20:42:00', '', 0, 'http://localhost/?page_id=37', 0, 'page', '', 0),
(38, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 'Média', '', 'publish', 'closed', 'closed', '', 'media', '', '', '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 0, 'http://localhost/?page_id=38', 0, 'page', '', 0),
(39, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 'Csapatok', '', 'publish', 'closed', 'closed', '', 'csapatok', '', '', '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 0, 'http://localhost/?page_id=39', 0, 'page', '', 0),
(40, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 'Játékosok', '', 'publish', 'closed', 'closed', '', 'jatekosok', '', '', '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 0, 'http://localhost/?page_id=40', 0, 'page', '', 0),
(41, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 'Cikkek', '', 'inherit', 'closed', 'closed', '', '36-revision-v1', '', '', '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 36, 'http://localhost/2020/11/28/36-revision-v1/', 0, 'revision', '', 0),
(42, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 'Versenyek', '', 'inherit', 'closed', 'closed', '', '37-revision-v1', '', '', '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 37, 'http://localhost/2020/11/28/37-revision-v1/', 0, 'revision', '', 0),
(43, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 'Média', '', 'inherit', 'closed', 'closed', '', '38-revision-v1', '', '', '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 38, 'http://localhost/2020/11/28/38-revision-v1/', 0, 'revision', '', 0),
(44, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 'Csapatok', '', 'inherit', 'closed', 'closed', '', '39-revision-v1', '', '', '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 39, 'http://localhost/2020/11/28/39-revision-v1/', 0, 'revision', '', 0),
(45, 1, '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 'Játékosok', '', 'inherit', 'closed', 'closed', '', '40-revision-v1', '', '', '2020-11-28 21:38:41', '2020-11-28 20:38:41', '', 40, 'http://localhost/2020/11/28/40-revision-v1/', 0, 'revision', '', 0),
(51, 1, '2020-11-28 21:40:44', '2020-11-28 20:40:44', '{\n    "nav_menu_item[47]": {\n        "value": {\n            "object_id": 37,\n            "object": "page",\n            "menu_item_parent": 0,\n            "position": 1,\n            "type": "post_type",\n            "title": "Versenyek",\n            "url": "http://localhost/?page_id=37",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Versenyek",\n            "nav_menu_term_id": 2,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:40:44"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '78265ebe-b135-4839-bc41-f73a6a97c74b', '', '', '2020-11-28 21:40:44', '2020-11-28 20:40:44', '', 0, 'http://localhost/2020/11/28/78265ebe-b135-4839-bc41-f73a6a97c74b/', 0, 'customize_changeset', '', 0),
(52, 1, '2020-11-28 21:43:39', '0000-00-00 00:00:00', ' ', '', '', 'draft', 'closed', 'closed', '', '', '', '', '2020-11-28 21:43:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?p=52', 1, 'nav_menu_item', '', 0),
(53, 1, '2020-11-28 21:43:39', '0000-00-00 00:00:00', ' ', '', '', 'draft', 'closed', 'closed', '', '', '', '', '2020-11-28 21:43:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?p=53', 1, 'nav_menu_item', '', 0),
(54, 1, '2020-11-28 21:43:39', '0000-00-00 00:00:00', ' ', '', '', 'draft', 'closed', 'closed', '', '', '', '', '2020-11-28 21:43:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?p=54', 1, 'nav_menu_item', '', 0),
(55, 1, '2020-11-28 21:43:39', '0000-00-00 00:00:00', ' ', '', '', 'draft', 'closed', 'closed', '', '', '', '', '2020-11-28 21:43:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?p=55', 1, 'nav_menu_item', '', 0),
(56, 1, '2020-11-28 21:43:39', '0000-00-00 00:00:00', ' ', '', '', 'draft', 'closed', 'closed', '', '', '', '', '2020-11-28 21:43:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?p=56', 1, 'nav_menu_item', '', 0),
(57, 1, '2020-11-28 21:43:39', '0000-00-00 00:00:00', ' ', '', '', 'draft', 'closed', 'closed', '', '', '', '', '2020-11-28 21:43:39', '0000-00-00 00:00:00', '', 0, 'http://localhost/?p=57', 1, 'nav_menu_item', '', 0),
(59, 1, '2018-10-22 08:42:32', '2018-10-22 08:42:32', 'This is an example page. It''s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:\n<blockquote>Hi there! I''m a bike messenger by day, aspiring actor by night, and this is my website. I live in Los Angeles, have a great dog named Jack, and I like piña coladas. (And gettin'' caught in the rain.)</blockquote>\n...or something like this:\n<blockquote>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</blockquote>\nAs a new WordPress user, you should go to <a href="http://themes.pixiesquad.com/pixiefreak/twisting-nether/wp-admin/">your dashboard</a> to delete this page and create new pages for your content. Have fun!', 'Sample', '', 'publish', 'closed', 'open', '', 'sample-page', '', '', '2018-10-22 08:42:32', '2018-10-22 08:42:32', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/?page_id=2', 0, 'page', '', 0),
(60, 1, '2018-10-22 08:42:32', '2018-10-22 08:42:32', '<h2>Who we are</h2>\nOur website address is: http://themes.pixiesquad.com/pixiefreak/twisting-nether.\n<h2>What personal data we collect and why we collect it</h2>\n<h3>Comments</h3>\nWhen visitors leave comments on the site we collect the data shown in the comments form, and also the visitor’s IP address and browser user agent string to help spam detection.\n\nAn anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.\n<h3>Media</h3>\nIf you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.\n<h3>Contact forms</h3>\n<h3>Cookies</h3>\nIf you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.\n\nIf you have an account and you log in to this site, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.\n\nWhen you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select "Remember Me", your login will persist for two weeks. If you log out of your account, the login cookies will be removed.\n\nIf you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.\n<h3>Embedded content from other websites</h3>\nArticles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.\n\nThese websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.\n<h3>Analytics</h3>\n<h2>Who we share your data with</h2>\n<h2>How long we retain your data</h2>\nIf you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.\n\nFor users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.\n<h2>What rights you have over your data</h2>\nIf you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.\n<h2>Where we send your data</h2>\nVisitor comments may be checked through an automated spam detection service.\n<h2>Your contact information</h2>\n<h2>Additional information</h2>\n<h3>How we protect your data</h3>\n<h3>What data breach procedures we have in place</h3>\n<h3>What third parties we receive data from</h3>\n<h3>What automated decision making and/or profiling we do with user data</h3>\n<h3>Industry regulatory disclosure requirements</h3>', 'Privacy', '', 'publish', 'closed', 'open', '', 'privacy-policy', '', '', '2018-10-22 08:42:32', '2018-10-22 08:42:32', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/?page_id=3', 0, 'page', '', 0),
(61, 1, '2020-11-28 21:47:57', '2020-11-28 20:47:57', '', '•••', '', 'publish', 'closed', 'closed', '', '61', '', '', '2020-11-28 21:55:35', '2020-11-28 20:55:35', '', 0, 'http://localhost/2020/11/28/', 6, 'nav_menu_item', '', 0),
(63, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', '404', '', 'publish', 'closed', 'closed', '', '404-2', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/404-2/', 0, 'page', '', 0),
(64, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Blank', '', 'publish', 'closed', 'closed', '', 'blank', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/blank/', 0, 'page', '', 0),
(65, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'About', '', 'publish', 'closed', 'closed', '', 'about', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/about/', 0, 'page', '', 0),
(66, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Bracket', '', 'publish', 'closed', 'closed', '', 'bracket', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/bracket/', 0, 'page', '', 0),
(67, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Gallery', '', 'publish', 'closed', 'closed', '', 'gallery', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/gallery/', 0, 'page', '', 0),
(68, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Match', '', 'publish', 'closed', 'closed', '', 'match', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/match/', 0, 'page', '', 0),
(69, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Matches', '', 'publish', 'closed', 'closed', '', 'matches', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/matches/', 0, 'page', '', 0),
(70, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'News', '', 'publish', 'closed', 'closed', '', 'news', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/news/', 0, 'page', '', 0),
(71, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Player', '', 'publish', 'closed', 'closed', '', 'player', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/player/', 0, 'page', '', 0),
(72, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Shop', '', 'publish', 'closed', 'closed', '', 'shop', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/shop/', 0, 'page', '', 0),
(73, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Stream', '', 'publish', 'closed', 'closed', '', 'stream', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/stream/', 0, 'page', '', 0),
(74, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Streams', '', 'publish', 'closed', 'closed', '', 'streams', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/streams/', 0, 'page', '', 0),
(75, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Team', '', 'publish', 'closed', 'closed', '', 'team', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/team/', 0, 'page', '', 0),
(76, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Teams', '', 'publish', 'closed', 'closed', '', 'teams', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/teams/', 0, 'page', '', 0),
(77, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Tournament', '', 'publish', 'closed', 'closed', '', 'tournament', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/tournament/', 0, 'page', '', 0),
(78, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Tournaments', '', 'publish', 'closed', 'closed', '', 'tournaments', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/tournaments/', 0, 'page', '', 0);
INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(116, 1, '2018-10-23 12:01:31', '2018-10-23 12:01:31', 'It was a hazy day in Guangzhou, China during the 2017 League of Legends World Championship quarterfinals. On the slate that day was hometown favorite Team WE -- hoping to make its country proud by making it to the semifinals -- and its opponent Cloud9, the lone North American representative left in the tournament, a team that barely made it out of the group stage.\n\nStanding out like a 6''5" sore thumb, I was asked by a group of Chinese teenagers seated in front of me where I was from. When I replied "Los Angeles," they asked what I did and who I was rooting for. After telling them I was a journalist and had an affinity for C9, a team I''ve covered weekly for two years at that point, their faces shifted into smirks, with even a few laughing.\n\nThey weren''t malicious, just matter-of-factly. To them, North American League of Legends was a joke. I later learned some of them were fans of European squads like Fnatic and G2 Esports, Korean teams like SK Telecom T1 -- even Flash Wolves, Taiwan''s lone hope, was given some credence. North America, though? They were the region of funny players and memes that never amounted to anything at international events.\n\nWhen the games started, a mocking "T-S-M!" chant broke out in pockets across the sold-out arena. Although C9 would show up on the day and push the Chinese favorites to their absolute limit, going the full five games in the set, it was the same result, per usual.\n\nThey were eliminated in the first round of the knockout stage; and though amusing, they were no threat to the better teams in the competition.\n\nA year later, this time in South Korea, C9 once again stood as the last team for North America at the world championships. Once again, they were fighting against a hometown favorite, this time in the form of Afreeca Freecs, the last team standing from South Korea, the region with winners from the last five worlds. In fact, even in its worst year at worlds in season two, South Korea still sent a team to the final, and the victory (Taipei Assassins over South Korea''s Azubu Frost) to this day is seen as one of the greatest upsets in the game''s history.\n\nUnlike the last year, though, C9 would not be denied this time. It only took three games for it to dispatch of the final South Korean from the tournament, and there was no question which team was better on the international stage. In its fifth quarterfinal in six years, finally, C9 and North America by proxy, made it to the semifinals. It marks the first time North America has made it to the top-four of a League of Legends World Championship since the very first iteration of the competition back in 2011 when there were only eight teams invited, three from North America and squads from China and South Korea not invited.\n\nFor the first time, maybe ever, I''m proud to cover North American League of Legends.\n\nDoes this mean NA is a better region than South Korea? Of course not. C9 has always been the outlier for the region at worlds, and that didn''t change this year, albeit with the team going further than it ever has.\n\nWhat it does do is show a blueprint in which other North American teams can hopefully work off of in the coming months as the 2019 season begins. In an offseason where the newly christened North American franchises opened up the bank accounts to pour money on prized free agents, C9, by many accounts, "lost" the offseason, its biggest moves being the signings of Eric "Licorice" Ritchie, a minor league top laner, and Dennis "Svenskeren" Johnsen, the maligned former jungler of Team SoloMid who was the scapegoat for the top North American seed failing at the 2017 world championship.\n\nCompared to other teams, it felt like a joke. Why Svenskeren? What could Licorice do that Jung "Impact" Eon-yeong couldn''t? Why didn''t owner Jack Jack Etienne care about the team? Where the hell was the signing of South Korean jungler Han "Peanut" Wang-ho to bolster the starting lineup?\n\nFor years, North America has been the region where if the infrastructure, coaching and team chemistry weren''t working, the quickest fix was a blank check to a high-profile player. It has become the region for splashy signings and even splashier drama.\n\nThe reason why the region became a joke was because it''s impossible to ignore North America if you''re from another region. The headquarters to Riot Games, the game creator, was nestled right across the street from the North American League Championship Series. A lot of the production international fans see come from the NA broadcast. The promo videos played in Busan for the quarterfinal had English subtitles for Korean players (and we were in South Korea). Team SoloMid, win or lose, were the most talked about franchise in all of League of Legends right there next to SK Telecom T1, who has been to four world finals and has three Summoner''s Cups to their names. TSM hasn''t even made it out of the group stage during that same time period while SKT T1 has been winning trophies.\n\nWho wouldn''t make fun of a region that gets more attention than its more successful and talented brother in Europe or other regions across the world? If anything, from the outside, NA should be mocked. They spend a lot of money. They take players from better regions. And for the most part, they fail to capitalize with all their advantages, routinely losing to minnow regions and getting outperformed by teams with a fraction of the payroll.', 'Thank you Cloud9 for bringing back hope to North America', '', 'publish', 'open', 'open', '', 'thank-you-cloud9-for-bringing-back-hope-to-north-america', '', '', '2018-10-23 12:01:31', '2018-10-23 12:01:31', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/?p=116', 0, 'post', '', 1),
(122, 1, '2018-10-23 12:05:13', '2018-10-23 12:05:13', 'The 2018 League of Legends World Championship is upon us. Beginning on Oct. 1, 24 of the best teams in the world will gather together in South Korea to duke it out for the coveted Summoner''s Cup. What''s on the line? Bragging rights, money and the most prestigious title in the game.\n\nYou can catch all the action on ESPN+ and Riot''s Twitch channel.\n\nMIBR earned a regulation win and an overtime win Sunday to maintain its first-place standing as the second week of ESL Pro League''s North American division concluded.\n\nSecond-place Ghost Gaming won three of four Sunday matches to boost their point total to 43, six behind MIBR in the Counter-Strike: Global Offensive tournament. Renegades sit in third place at 38 points following a win and an overtime loss.\n\nThe 2018 League of Legends World Championship is upon us. Beginning on Oct. 1, 24 of the best teams in the world will gather together in South Korea to duke it out for the coveted Summoner''s Cup. What''s on the line? Bragging rights, money and the most prestigious title in the game.\n\nYou can catch all the action on ESPN+ and Riot''s Twitch channel.\n\nMIBR earned a regulation win and an overtime win Sunday to maintain its first-place standing as the second week of ESL Pro League''s North American division concluded.\n\nSecond-place Ghost Gaming won three of four Sunday matches to boost their point total to 43, six behind MIBR in the Counter-Strike: Global Offensive tournament. Renegades sit in third place at 38 points following a win and an overtime loss.', 'League of Legends World Championship landing page', '', 'publish', 'open', 'open', '', 'league-of-legends-world-championship-landing-page', '', '', '2018-10-23 12:05:13', '2018-10-23 12:05:13', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/?p=122', 0, 'post', '', 0),
(125, 1, '2018-10-23 12:10:22', '2018-10-23 12:10:22', 'Jack "CouRage" Dunlop was unstoppable for most of <em>Code Red</em>, Guy "Dr Disrespect" Beahm''s inaugural Call of Duty: Black Ops 4 tournament held on Thursday. The CoD caster turned Fortnite aficionado returned to his first love in style, fragging out for the better part of seven hours in the game''s new battle royale mode "Blackout" on the way to the grand finals.\n\nThe championship was within reach. But that was before a legend had his say.\n\n"We just got Shrouded on, bro," CouRage said in shocked tones to his duos partner Tyler "TeePee" Polchow. Michael "Shroud" Grzesiek''s 14-kill masterclass in Game 1 of the grand finals was filled with outplays and shots that left CouRage and TeePee screaming in disbelief.\n\nIt was a performance that not only won Code Red, but announced to all newcomers that Blackout might be just another realm for Shroud to conquer.\n\nCode Red marked the first competitive event for Call of Duty: Black Ops 4, released less than a week ago amid rabid anticipation. The venerable series'' newest iteration completely eschewed a campaign mode; developer Treyarch preferred to go all-in on the battle royale phenomenon that has swept through the shooter scene. Blackout has all the markings of the genre popularized by PlayerUnknown''s Battlegrounds and launched into orbit by Fortnite: circles, random loot, points of interest and a battle to the death. Code Red put its differences -- both good and bad -- on display in a tournament that acted as a positive first step for Blackout''s esports future.\n\nHosted in partnership with Esports Arena and Boom.tv, Code Red offered a $20,000 prize pool to 32 of the scene''s biggest names ($12,000 of which was allocated to the winning duo). Shroud and Dr Disrespect were the marquee pairing, but the field also featured CoD statesmen Hector "H3CZ" Rodriguez and Matt "Nadeshot" Haag, as well as a bevy of popular streamers like Jaryd "summit1g" Lazar, Tim "Trick2g" Foley and Jesse "RealKraftyy" Kraft. Each of the 16 duos were required to complete a four-game preliminary round to determine who would advance to the bracket stage.\n\nKills, of course, were the determining factor.\n\nThe prelims best showcased Esports Arena and Boom.tv''s contribution to the event, the latter acting as a hub page where player streams and kill scores were readily accessible. The ease of switching from stream to stream was a stylistic alternative to Esports Arena''s broadcasted stream from Santa Ana, California.\n\nCasters Bil "Jump" Carter, Nathan "Nathanias" Fabrikant and Jacob "MvPR" Arce did their best to buttress the proceedings with engaging commentary as they hopped between player perspectives, but most viewers flocked to the player streams, with Shroud and Dr Disrespect easily outpacing the others by tens of thousands.\n\nCode Red was played entirely on live servers, and was therefore subject to the foibles of such a setup. Some players suffered connectivity issues that in one instance necessitated a full replay. Then, there was the question of lobby fairness. As Shroud correctly pointed out on his stream, the format had no equalizer for some teams getting easier lobbies versus others being drawn into high skill games, which unfairly impacted their kill scores. For their part, Shroud and Dr Disrespect easily qualified for the bracket stage with 35 kills, second only to CouRage and TeePee.\n\nBrackets were standard double-elimination fare, with matches completed in two games sets. Competing duos played squad games with all four players in the same party, each trying to record the most kills they could. Strict sabotage rules prohibited friendly fire with vehicles or grenades, but often opposing teams kept their distance from each other (better to maximize kills) as part of an unspoken honor system. Players also refused to use a well-known Exo Suit movement glitch that could quickly close the gap. Map markers were used sparingly to keep the other team uninformed of potential kills, or creatively dropped as a mind-game to mislead. Having both teams in the same lobby ensured a level of fairness the prelims lacked, yet the results stayed the same, calling into question how large of a competitive balance issue it actually was.', 'Black Ops 4 tourney, Code Red, reviewed: ''We just got Shrouded on, bro''', '', 'publish', 'open', 'open', '', 'black-ops-4-tourney-code-red-reviewed-we-just-got-shrouded-on-bro', '', '', '2018-10-23 12:10:22', '2018-10-23 12:10:22', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/?p=125', 0, 'post', '', 0),
(131, 1, '2018-10-23 12:11:28', '2018-10-23 12:11:28', 'After eight straight days of group stage games at the 2018 League of Legends World Championship in South Korea, the field has been cut down in half.\n\nGoodbye, Vietnam and Taiwan, who saw all their teams eliminated from the knockout rounds.\n\nNorth America, who was primed to join them with zero teams in the quarterfinals, found solace in an org who has made the top-eight its home over the years -- Cloud9 -- making their fifth quarterfinal appearance in six years.\n\nEurope feels confident sending its two dynastic organizations, G2 Esports and Fnatic, to the knockout stage, the latter having the best chance for a western team to make the finals since 2011, where it won the inaugural title.\n\nSouth Korea expected to send its trio of teams straight to the quarterfinals but, following a flubbed run by defending champion Gen.G and a near-disaster by the Afreeca Freecs, will only send a pair of teams to the next round. Still, KT Rolster, the country''s champion, stands nearly spotless following the group stages, only losing a single game to its Chinese rivals.\n\nAnd finally, the only region to keep its numbers intact through play-ins and groups, we have China. The most dominant region over the course of 2018, the only thing left for China to do is win the Summoner''s Cup for the first time in the region''s history. At the forefront, Royal Never Give Up, the winners of the Mid-Season Invitational and both Chinese domestic seasons this year, will have its sights only on the final at the beginning of November in Incheon.\n\nBefore the action resumes in Busan, let''s take a look at the matches that will determine the quartet who will be advancing to the semifinal stage in Gwangju.', 'Worlds 2018 quarterfinal predictions', '', 'publish', 'open', 'open', '', 'worlds-2018-quarterfinal-predictions', '', '', '2018-10-23 12:11:28', '2018-10-23 12:11:28', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/?p=131', 0, 'post', '', 0),
(133, 1, '2018-10-23 12:12:29', '2018-10-23 12:12:29', 'Like a loving relationship, chemistry is essential in Counter-Strike: Global Offensive. At least that''s what MIBR leader and twice-elected best player in the world from 2016 to 2017, Marcelo "coldzera" David, thinks.\n\nColdzera sat down with ESPN Esports Brazil during the Brazil Game Show to discuss his team and reflect on his career.\n\n"I think having a strong team depends on a lot of people," he said. "Like it or not, Stewie and tarik are less warm than Brazilians. Stewie has improved a lot in this matter. Tarik is still a little cold. We are not living together to meet, have lunch and dinner together and create this chemistry."\n\n"We are in the process of learning. We have to adapt to them as they also have to adapt to us. It''s difficult -- it''s something that comes with time. It will take about three to four months to improve this chemistry inside and outside the game," he added.\n\nHowever, chemistry is not the only determining factor for a team''s success. The language barrier and differences in mentality have also been mentioned as elements that are part of this process of change.\n\nIt is bad for us when we extend the holidays too much during the year. When we get back, we are unprepared and behind everyone else," coldzera said. "A player from Europe and the United States can go out, have dinner, go to a party and the next day he plays with rain, NiKo. The skill level is kept because he is playing with the best. Here in Brazil we do not feel like playing. We know it''s not going to be such a good deal. We prefer to take a detox and not play, but I think we extend that a lot."\n\nAfter a rough start, the team also decided to dismiss Epitácio "Taco" Filho and Ricardo "boltz" Prass. And, after speculating about national and international players, Stewie2k and Tarik "tarik" Celik were chosen.\n\n"This year in August we have cut our holidays in half. We had 10 days off and two weeks of boot camp. We realized that we need only seven or 10 days, then we have to go back and prepare ourselves more than everyone," he added.\n\n"We wanted s1mple and flamie at the time, but it did not work out. They wanted to come, but there were some problems. Before we called the Europeans, we tried some Brazilians. We made offers, but some organizations asked for ridiculous prices, which unfortunately were not worth it", he revealed.', 'Coldzera: ''If you ask me the best team I''ve played in my life, I''ll say it''s LG', '', 'publish', 'open', 'open', '', 'coldzera-if-you-ask-me-the-best-team-ive-played-in-my-life-ill-say-its-lg', '', '', '2018-10-23 12:12:29', '2018-10-23 12:12:29', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/?p=133', 0, 'post', '', 0),
(135, 1, '2018-10-23 12:13:46', '2018-10-23 12:13:46', 'Natus Vincere made a big move Sunday in ESL Pro League''s European division, sweeping four matches as the second of four weeks of group play in the Counter-Strike: Global Offensive tournament concluded.\n\nNa''Vi climbed into second place with 47 points, two points back of leaders Astralis, who were idle Sunday.\n\nBIG, which split its two Sunday matches, sits third at 44 points. No other teams have more than 33 points.\n\nFourteen teams are taking part in round-robin online group play in the CS:GO league that began Oct. 2 and runs through Nov. 14. Teams in the top seven places advance to the $750,000 offline finals, which will take place Dec. 4-9 at Odense, Denmark.\n\nThe top 11 teams are guaranteed spots in the league next season. The 12th and 13th teams are sent to a relegation tournament, while the last-place team is directly relegated to ESEA Premier.\n\nAll teams play each other in consecutive one-game matches. Regulation wins provide three points, overtime wins two and overtime losses one. Regulation losses result in no points.\n\nNa''Vi rolled past Heroic 16-9 on Dust2 and 16-6 on Train, then posted two wins over Windigo Gaming, 16-8 on Overpass and 16-11 on Mirage.\n\nOne other team, mousesports, posted multiple victories Sunday. Mouse bounced back from a 16-13 loss to FaZe Clan on Inferno to top FaZe by the same score on Mirage, then swept Heroic 16-13 on Train and 16-3 on Nuke.', 'Na''Vi moves to second in European ESL Pro League', '', 'publish', 'open', 'open', '', 'navi-moves-to-second-in-european-esl-pro-league', '', '', '2018-10-23 12:13:46', '2018-10-23 12:13:46', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/?p=135', 0, 'post', '', 0),
(136, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 'VERSENYEK', '', 'publish', 'closed', 'closed', '', '136', '', '', '2020-11-28 21:55:35', '2020-11-28 20:55:35', '', 0, 'http://localhost/2020/11/28/136/', 4, 'nav_menu_item', '', 0),
(137, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 'CSAPATOK', '', 'publish', 'closed', 'closed', '', '137', '', '', '2020-11-28 21:53:21', '2020-11-28 20:53:21', '', 0, 'http://localhost/2020/11/28/137/', 2, 'nav_menu_item', '', 0),
(138, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 'STREAMEK', '', 'publish', 'closed', 'closed', '', '138', '', '', '2020-11-28 21:55:35', '2020-11-28 20:55:35', '', 0, 'http://localhost/2020/11/28/138/', 8, 'nav_menu_item', '', 0),
(139, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 'PARTNEREINK', '', 'publish', 'closed', 'closed', '', 'sponsors', '', '', '2020-11-28 21:55:35', '2020-11-28 20:55:35', '', 0, 'http://localhost/2020/11/28/sponsors/', 7, 'nav_menu_item', '', 0),
(140, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 'HÍREK', '', 'publish', 'closed', 'closed', '', '140', '', '', '2020-11-28 21:53:21', '2020-11-28 20:53:21', '', 0, 'http://localhost/2020/11/28/140/', 1, 'nav_menu_item', '', 0),
(141, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 'MÉRKŐZÉSEK', '', 'publish', 'closed', 'closed', '', '141', '', '', '2020-11-28 21:55:35', '2020-11-28 20:55:35', '', 0, 'http://localhost/2020/11/28/141/', 5, 'nav_menu_item', '', 0),
(142, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 'GALLÉRIA', '', 'publish', 'closed', 'closed', '', '142', '', '', '2020-11-28 21:55:35', '2020-11-28 20:55:35', '', 0, 'http://localhost/2020/11/28/142/', 9, 'nav_menu_item', '', 0),
(143, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 'RÓLUNK', '', 'publish', 'closed', 'closed', '', '143', '', '', '2020-11-28 21:55:35', '2020-11-28 20:55:35', '', 0, 'http://localhost/2020/11/28/143/', 10, 'nav_menu_item', '', 0),
(144, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', ' ', '', '', 'publish', 'closed', 'closed', '', '144', '', '', '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 0, 'http://localhost/2020/11/28/144/', 1, 'nav_menu_item', '', 0),
(145, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', ' ', '', '', 'publish', 'closed', 'closed', '', '145', '', '', '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 0, 'http://localhost/2020/11/28/145/', 2, 'nav_menu_item', '', 0),
(146, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', ' ', '', '', 'publish', 'closed', 'closed', '', '146', '', '', '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 0, 'http://localhost/2020/11/28/146/', 3, 'nav_menu_item', '', 0),
(147, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', ' ', '', '', 'publish', 'closed', 'closed', '', '147', '', '', '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 0, 'http://localhost/2020/11/28/147/', 4, 'nav_menu_item', '', 0),
(148, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', ' ', '', '', 'publish', 'closed', 'closed', '', '148', '', '', '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 0, 'http://localhost/2020/11/28/148/', 5, 'nav_menu_item', '', 0),
(149, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', ' ', '', '', 'publish', 'closed', 'closed', '', '149', '', '', '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 0, 'http://localhost/2020/11/28/149/', 1, 'nav_menu_item', '', 0),
(150, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', ' ', '', '', 'publish', 'closed', 'closed', '', '150', '', '', '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 0, 'http://localhost/2020/11/28/150/', 2, 'nav_menu_item', '', 0),
(151, 1, '2020-11-28 21:47:58', '2020-11-28 20:47:58', ' ', '', '', 'publish', 'closed', 'closed', '', '151', '', '', '2020-11-28 21:47:58', '2020-11-28 20:47:58', '', 0, 'http://localhost/2020/11/28/151/', 3, 'nav_menu_item', '', 0),
(152, 1, '2020-11-28 21:47:59', '2020-11-28 20:47:59', ' ', '', '', 'publish', 'closed', 'closed', '', '152', '', '', '2020-11-28 21:47:59', '2020-11-28 20:47:59', '', 0, 'http://localhost/2020/11/28/152/', 4, 'nav_menu_item', '', 0),
(153, 1, '2020-11-28 21:47:59', '2020-11-28 20:47:59', ' ', '', '', 'publish', 'closed', 'closed', '', '153', '', '', '2020-11-28 21:47:59', '2020-11-28 20:47:59', '', 0, 'http://localhost/2020/11/28/153/', 1, 'nav_menu_item', '', 0),
(154, 1, '2020-11-28 21:47:59', '2020-11-28 20:47:59', ' ', '', '', 'publish', 'closed', 'closed', '', '154', '', '', '2020-11-28 21:47:59', '2020-11-28 20:47:59', '', 0, 'http://localhost/2020/11/28/154/', 2, 'nav_menu_item', '', 0),
(155, 1, '2020-11-28 21:47:59', '2020-11-28 20:47:59', ' ', '', '', 'publish', 'closed', 'closed', '', '155', '', '', '2020-11-28 21:47:59', '2020-11-28 20:47:59', '', 0, 'http://localhost/2020/11/28/155/', 3, 'nav_menu_item', '', 0),
(156, 1, '2020-11-28 21:50:46', '2020-11-28 20:50:46', '{\n    "pixiefreak::nav_menu_locations[header_menu]": {\n        "value": 0,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:50:46"\n    },\n    "nav_menu[2]": {\n        "value": false,\n        "type": "nav_menu",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:50:46"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'ccebd2be-622f-49fc-82b4-0c31691af34b', '', '', '2020-11-28 21:50:46', '2020-11-28 20:50:46', '', 0, 'http://localhost/2020/11/28/ccebd2be-622f-49fc-82b4-0c31691af34b/', 0, 'customize_changeset', '', 0),
(157, 1, '2020-11-28 21:50:54', '2020-11-28 20:50:54', '{\n    "pixiefreak::nav_menu_locations[header_menu]": {\n        "value": 18,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:50:54"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'd0644775-f1f2-48bf-9c6d-a9167ebfceb6', '', '', '2020-11-28 21:50:54', '2020-11-28 20:50:54', '', 0, 'http://localhost/2020/11/28/d0644775-f1f2-48bf-9c6d-a9167ebfceb6/', 0, 'customize_changeset', '', 0),
(158, 1, '2020-11-28 21:53:21', '2020-11-28 20:53:21', '{\n    "nav_menu_item[62]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:51:41"\n    },\n    "nav_menu_item[140]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 70,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/news/",\n            "title": "H\\u00cdREK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 1,\n            "status": "publish",\n            "original_title": "News",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:51:41"\n    },\n    "nav_menu_item[137]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 76,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/teams/",\n            "title": "CSAPATOK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 2,\n            "status": "publish",\n            "original_title": "Teams",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:51:41"\n    },\n    "nav_menu_item[139]": {\n        "value": {\n            "menu_item_parent": 61,\n            "object_id": 17,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/sponsor/",\n            "title": "PARTNEREINK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 6,\n            "status": "publish",\n            "original_title": "Sponsor",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:52:41"\n    },\n    "nav_menu_item[143]": {\n        "value": {\n            "menu_item_parent": 61,\n            "object_id": 65,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/about/",\n            "title": "R\\u00d3LUNK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 9,\n            "status": "publish",\n            "original_title": "About",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:53:21"\n    },\n    "nav_menu_item[136]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 78,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/tournaments/",\n            "title": "VERSENYEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 3,\n            "status": "publish",\n            "original_title": "Tournaments",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:52:41"\n    },\n    "nav_menu_item[141]": {\n        "value": {\n            "menu_item_parent": 136,\n            "object_id": 69,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/matches/",\n            "title": "M\\u00c9RK\\u0150Z\\u00c9SEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 4,\n            "status": "publish",\n            "original_title": "Matches",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:52:41"\n    },\n    "nav_menu_item[142]": {\n        "value": {\n            "menu_item_parent": 61,\n            "object_id": 67,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/gallery/",\n            "title": "GALL\\u00c9RIA",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 8,\n            "status": "publish",\n            "original_title": "Gallery",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:53:21"\n    },\n    "nav_menu_item[138]": {\n        "value": {\n            "menu_item_parent": 61,\n            "object_id": 74,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/streams/",\n            "title": "STREAMEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 7,\n            "status": "publish",\n            "original_title": "Streams",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:52:41"\n    },\n    "nav_menu_item[61]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 61,\n            "object": "custom",\n            "type": "custom",\n            "type_label": "Egy\\u00e9ni hivatkoz\\u00e1s",\n            "title": "\\u2022\\u2022\\u2022",\n            "url": "/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 5,\n            "status": "publish",\n            "original_title": "",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:52:41"\n    },\n    "pixiefreak::nav_menu_locations[footer_menu]": {\n        "value": 0,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:53:21"\n    },\n    "pixiefreak::nav_menu_locations[footer_left]": {\n        "value": 0,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:53:21"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '829c7db3-c318-4bcd-97ab-4bf7d904ff56', '', '', '2020-11-28 21:53:21', '2020-11-28 20:53:21', '', 0, 'http://localhost/?p=158', 0, 'customize_changeset', '', 0),
(159, 1, '2020-11-28 21:55:35', '2020-11-28 20:55:35', '{\n    "nav_menu_item[139]": {\n        "value": {\n            "menu_item_parent": 61,\n            "object_id": 17,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/sponsor/",\n            "title": "PARTNEREINK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 7,\n            "status": "publish",\n            "original_title": "Sponsor",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:55:35"\n    },\n    "nav_menu_item[143]": {\n        "value": {\n            "menu_item_parent": 61,\n            "object_id": 65,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/about/",\n            "title": "R\\u00d3LUNK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 10,\n            "status": "publish",\n            "original_title": "About",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:55:35"\n    },\n    "nav_menu_item[136]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 78,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/tournaments/",\n            "title": "VERSENYEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 4,\n            "status": "publish",\n            "original_title": "Tournaments",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:55:35"\n    },\n    "nav_menu_item[138]": {\n        "value": {\n            "menu_item_parent": 61,\n            "object_id": 74,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/streams/",\n            "title": "STREAMEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 8,\n            "status": "publish",\n            "original_title": "Streams",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:55:35"\n    },\n    "nav_menu_item[61]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 61,\n            "object": "custom",\n            "type": "custom",\n            "type_label": "Egy\\u00e9ni hivatkoz\\u00e1s",\n            "title": "\\u2022\\u2022\\u2022",\n            "url": "/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 6,\n            "status": "publish",\n            "original_title": "",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:55:35"\n    },\n    "nav_menu_item[141]": {\n        "value": {\n            "menu_item_parent": 136,\n            "object_id": 69,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/matches/",\n            "title": "M\\u00c9RK\\u0150Z\\u00c9SEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 5,\n            "status": "publish",\n            "original_title": "Matches",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:55:35"\n    },\n    "nav_menu_item[142]": {\n        "value": {\n            "menu_item_parent": 61,\n            "object_id": 67,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://localhost/gallery/",\n            "title": "GALL\\u00c9RIA",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 18,\n            "position": 9,\n            "status": "publish",\n            "original_title": "Gallery",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:55:35"\n    },\n    "nav_menu_item[-1194945654833035300]": {\n        "value": {\n            "object_id": 71,\n            "object": "page",\n            "menu_item_parent": 137,\n            "position": 3,\n            "type": "post_type",\n            "title": "J\\u00c1T\\u00c9KOSOK",\n            "url": "http://localhost/player/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Player",\n            "nav_menu_term_id": 18,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:55:35"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '24084037-0c06-45f1-ad8c-6e811217814e', '', '', '2020-11-28 21:55:35', '2020-11-28 20:55:35', '', 0, 'http://localhost/2020/11/28/24084037-0c06-45f1-ad8c-6e811217814e/', 0, 'customize_changeset', '', 0),
(161, 1, '2020-11-28 21:56:28', '2020-11-28 20:56:28', '{\n    "nav_menu_item[160]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-28 20:56:28"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '033ff002-bfb5-4b7c-84e1-1089601ecf9b', '', '', '2020-11-28 21:56:28', '2020-11-28 20:56:28', '', 0, 'http://localhost/2020/11/28/033ff002-bfb5-4b7c-84e1-1089601ecf9b/', 0, 'customize_changeset', '', 0),
(287, 1, '2020-12-05 15:12:31', '2020-12-05 14:12:31', 'LG Ultragear Warmup Kupa 2020 - 1st', 'asd', 'LG Ultragear Warmup Kupa 2020 - 1st', 'inherit', 'open', 'closed', '', 'asd', '', '', '2020-12-05 19:14:08', '2020-12-05 18:14:08', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/asd.png', 0, 'attachment', 'image/png', 0),
(288, 1, '2020-12-05 15:12:42', '2020-12-05 14:12:42', '', '1604843695326', '', 'inherit', 'open', 'closed', '', '1604843695326', '', '', '2020-12-05 15:12:42', '2020-12-05 14:12:42', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1604843695326.jpg', 0, 'attachment', 'image/jpeg', 0),
(289, 1, '2020-12-05 15:17:31', '2020-12-05 14:17:31', '', 'thumb-1920-676369', '', 'inherit', 'open', 'closed', '', 'thumb-1920-676369', '', '', '2020-12-05 15:17:31', '2020-12-05 14:17:31', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/thumb-1920-676369.jpg', 0, 'attachment', 'image/jpeg', 0),
(290, 1, '2020-12-05 15:19:32', '2020-12-05 14:19:32', '', 'osszeallt-a-mezony-ma-eldol-hogy-ki-nyeri-az-lg-ultragear-r6s-warmup-kupat-hirek-0058a06e2dcd4dbf39f0-mid', '', 'inherit', 'open', 'closed', '', 'osszeallt-a-mezony-ma-eldol-hogy-ki-nyeri-az-lg-ultragear-r6s-warmup-kupat-hirek-0058a06e2dcd4dbf39f0-mid', '', '', '2020-12-05 15:19:32', '2020-12-05 14:19:32', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/osszeallt-a-mezony-ma-eldol-hogy-ki-nyeri-az-lg-ultragear-r6s-warmup-kupat-hirek-0058a06e2dcd4dbf39f0-mid.jpg', 0, 'attachment', 'image/jpeg', 0),
(172, 1, '2020-11-29 15:06:13', '2020-11-29 14:06:13', 'http://localhost/wp-content/uploads/2020/11/cropped-ascasc.png', 'cropped-ascasc.png', '', 'inherit', 'open', 'closed', '', 'cropped-ascasc-png', '', '', '2020-11-29 15:06:13', '2020-11-29 14:06:13', '', 0, 'http://localhost/wp-content/uploads/2020/11/cropped-ascasc.png', 0, 'attachment', 'image/png', 0),
(173, 1, '2020-11-29 15:12:06', '2020-11-29 14:12:06', '{\n    "pixiefreak::custom_logo": {\n        "value": 181,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-29 14:12:05"\n    },\n    "site_icon": {\n        "value": 179,\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-29 14:11:05"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'b5ad906a-5ec2-4815-bbb3-f2d80fbf7995', '', '', '2020-11-29 15:12:06', '2020-11-29 14:12:06', '', 0, 'http://localhost/?p=173', 0, 'customize_changeset', '', 0),
(175, 1, '2020-11-29 15:09:05', '2020-11-29 14:09:05', 'http://localhost/wp-content/uploads/2020/11/cropped-ascasc-1.png', 'cropped-ascasc-1.png', '', 'inherit', 'open', 'closed', '', 'cropped-ascasc-1-png', '', '', '2020-11-29 15:09:05', '2020-11-29 14:09:05', '', 0, 'http://localhost/wp-content/uploads/2020/11/cropped-ascasc-1.png', 0, 'attachment', 'image/png', 0),
(177, 1, '2020-11-29 15:10:02', '2020-11-29 14:10:02', 'http://localhost/wp-content/uploads/2020/11/cropped-huPlaylogoGold.png', 'cropped-huPlaylogoGold.png', '', 'inherit', 'open', 'closed', '', 'cropped-huplaylogogold-png', '', '', '2020-11-29 15:10:02', '2020-11-29 14:10:02', '', 0, 'http://localhost/wp-content/uploads/2020/11/cropped-huPlaylogoGold.png', 0, 'attachment', 'image/png', 0),
(291, 1, '2020-12-05 15:20:56', '2020-12-05 14:20:56', '', 'WiLD_MultiGaminglogo_square', '', 'inherit', 'open', 'closed', '', 'wild_multigaminglogo_square', '', '', '2020-12-05 15:20:56', '2020-12-05 14:20:56', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/WiLD_MultiGaminglogo_square.png', 0, 'attachment', 'image/png', 0),
(179, 1, '2020-11-29 15:10:47', '2020-11-29 14:10:47', 'http://localhost/wp-content/uploads/2020/11/cropped-huPlaylogoGold-1.png', 'cropped-huPlaylogoGold-1.png', '', 'inherit', 'open', 'closed', '', 'cropped-huplaylogogold-1-png', '', '', '2020-11-29 15:10:47', '2020-11-29 14:10:47', '', 0, 'http://localhost/wp-content/uploads/2020/11/cropped-huPlaylogoGold-1.png', 0, 'attachment', 'image/png', 0),
(181, 1, '2020-11-29 15:11:59', '2020-11-29 14:11:59', 'http://localhost/wp-content/uploads/2020/11/cropped-ascasc-2.png', 'cropped-ascasc-2.png', '', 'inherit', 'open', 'closed', '', 'cropped-ascasc-2-png', '', '', '2020-11-29 15:11:59', '2020-11-29 14:11:59', '', 0, 'http://localhost/wp-content/uploads/2020/11/cropped-ascasc-2.png', 0, 'attachment', 'image/png', 0),
(292, 1, '2020-12-05 15:29:23', '2020-12-05 14:29:23', '', 'qwfqwfcqwqwx', '', 'inherit', 'open', 'closed', '', 'qwfqwfcqwqwx', '', '', '2020-12-05 15:29:23', '2020-12-05 14:29:23', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/qwfqwfcqwqwx.png', 0, 'attachment', 'image/png', 0),
(293, 1, '2020-12-05 15:29:30', '2020-12-05 14:29:30', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-qwfqwfcqwqwx.png', 'cropped-qwfqwfcqwqwx.png', '', 'inherit', 'open', 'closed', '', 'cropped-qwfqwfcqwqwx-png', '', '', '2020-12-05 15:29:30', '2020-12-05 14:29:30', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-qwfqwfcqwqwx.png', 0, 'attachment', 'image/png', 0),
(294, 1, '2020-12-05 15:29:33', '2020-12-05 14:29:33', '{\n    "pixiefreak::custom_logo": {\n        "value": 293,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:29:33"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'faf60555-82cb-40b4-a0a4-cd4ffce0f5d5', '', '', '2020-12-05 15:29:33', '2020-12-05 14:29:33', '', 0, 'http://esportplay.hu/2020/12/05/faf60555-82cb-40b4-a0a4-cd4ffce0f5d5/', 0, 'customize_changeset', '', 0),
(295, 1, '2020-12-05 15:37:54', '2020-12-05 14:37:54', '{\n    "nav_menu_item[-5523461235790017000]": {\n        "value": {\n            "object_id": 194,\n            "object": "page",\n            "menu_item_parent": 0,\n            "position": 6,\n            "type": "post_type",\n            "title": "Regisztr\\u00e1l",\n            "url": "http://esportplay.hu/regisztral/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Regisztr\\u00e1l",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:37:54"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'e76721d3-aac3-4a6f-8188-720cb7faa134', '', '', '2020-12-05 15:37:54', '2020-12-05 14:37:54', '', 0, 'http://esportplay.hu/2020/12/05/e76721d3-aac3-4a6f-8188-720cb7faa134/', 0, 'customize_changeset', '', 0),
(187, 1, '2020-11-29 15:39:38', '2020-11-29 14:39:38', '', 'qw', '', 'inherit', 'open', 'closed', '', 'qw', '', '', '2020-11-29 15:39:38', '2020-11-29 14:39:38', '', 0, 'http://localhost/wp-content/uploads/2020/11/qw.png', 0, 'attachment', 'image/png', 0),
(188, 1, '2020-11-29 15:46:37', '2020-11-29 14:46:37', '', 'qc', '', 'inherit', 'open', 'closed', '', 'qc', '', '', '2020-11-29 15:46:37', '2020-11-29 14:46:37', '', 0, 'http://localhost/wp-content/uploads/2020/11/qc.png', 0, 'attachment', 'image/png', 0),
(189, 1, '2020-11-29 15:46:48', '2020-11-29 14:46:48', '', '77398019_1050496535281850_3009940701971480576_o', '', 'inherit', 'open', 'closed', '', '77398019_1050496535281850_3009940701971480576_o-5', '', '', '2020-11-29 15:46:48', '2020-11-29 14:46:48', '', 0, 'http://localhost/wp-content/uploads/2020/11/77398019_1050496535281850_3009940701971480576_o-4.png', 0, 'attachment', 'image/png', 0),
(190, 1, '2020-11-29 15:54:11', '0000-00-00 00:00:00', '', 'Automatikus vázlat', '', 'auto-draft', 'open', 'open', '', '', '', '', '2020-11-29 15:54:11', '0000-00-00 00:00:00', '', 0, 'http://localhost/?p=190', 0, 'post', '', 0),
(191, 1, '2020-11-29 15:54:12', '0000-00-00 00:00:00', '', 'Automatikus vázlat', '', 'auto-draft', 'open', 'open', '', '', '', '', '2020-11-29 15:54:12', '0000-00-00 00:00:00', '', 0, 'http://localhost/?p=191', 0, 'post', '', 0),
(192, 1, '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 'Tevékenység', '', 'publish', 'closed', 'closed', '', 'tevekenyseg', '', '', '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 0, 'http://localhost/tevekenyseg/', 0, 'page', '', 0),
(193, 1, '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 'Tagok', '', 'publish', 'closed', 'closed', '', 'tagok', '', '', '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 0, 'http://localhost/tagok/', 0, 'page', '', 0),
(194, 1, '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 'Regisztrál', '', 'publish', 'closed', 'closed', '', 'regisztral', '', '', '2020-11-29 16:02:16', '2020-11-29 15:02:16', '', 0, 'http://localhost/regisztral/', 0, 'page', '', 0),
(195, 1, '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 'Aktiválás', '', 'publish', 'closed', 'closed', '', 'aktivalas', '', '', '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 0, 'http://localhost/aktivalas/', 0, 'page', '', 0),
(196, 1, '2020-11-29 15:56:43', '2020-11-29 14:56:43', '{{poster.name}} replied to one of your updates:\n\n<blockquote>&quot;{{usermessage}}&quot;</blockquote>\n\n<a href="{{{thread.url}}}">Go to the discussion</a> to reply or catch up on the conversation.', '[{{{site.name}}}] {{poster.name}} replied to one of your updates', '{{poster.name}} replied to one of your updates:\n\n"{{usermessage}}"\n\nGo to the discussion to reply or catch up on the conversation: {{{thread.url}}}', 'publish', 'closed', 'closed', '', 'site-name-poster-name-replied-to-one-of-your-updates', '', '', '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 0, 'http://localhost/?post_type=bp-email&p=196', 0, 'bp-email', '', 0),
(197, 1, '2020-11-29 15:56:43', '2020-11-29 14:56:43', '{{poster.name}} válaszolt az egyik hozzászólásunkra:\n\n<blockquote>&quot;{{usermessage}}&quot;</blockquote>\n\n<a href="{{{thread.url}}}">Beszélgetés megtekintése</a>, ha válaszolni szeretnénk, vagy bekapcsolódni a beszélgetésbe.', '[{{{site.name}}}] {{poster.name}} replied to one of your comments', '{{poster.name}} válaszolt az egyik hozzászólásunkra:\n\n"{{usermessage}}"\n\nBeszélgetés megtekintése, ha szeretnénk reagálni rá, vagy szeretnénk bekapcsolódni a beszélgetésbe: {{{thread.url}}}', 'publish', 'closed', 'closed', '', 'site-name-poster-name-replied-to-one-of-your-comments', '', '', '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 0, 'http://localhost/?post_type=bp-email&p=197', 0, 'bp-email', '', 0);
INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(198, 1, '2020-11-29 15:56:43', '2020-11-29 14:56:43', '{{poster.name}} mentioned you in a status update:\n\n<blockquote>&quot;{{usermessage}}&quot;</blockquote>\n\n<a href="{{{mentioned.url}}}">Go to the discussion</a> to reply or catch up on the conversation.', '[{{{site.name}}}] {{poster.name}} mentioned you in a status update', '{{poster.name}} mentioned you in a status update:\n\n"{{usermessage}}"\n\nGo to the discussion to reply or catch up on the conversation: {{{mentioned.url}}}', 'publish', 'closed', 'closed', '', 'site-name-poster-name-mentioned-you-in-a-status-update', '', '', '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 0, 'http://localhost/?post_type=bp-email&p=198', 0, 'bp-email', '', 0),
(199, 1, '2020-11-29 15:56:43', '2020-11-29 14:56:43', '{{poster.name}} mentioned you in the group "{{group.name}}":\n\n<blockquote>&quot;{{usermessage}}&quot;</blockquote>\n\n<a href="{{{mentioned.url}}}">Go to the discussion</a> to reply or catch up on the conversation.', '[{{{site.name}}}] {{poster.name}} mentioned you in an update', '{{poster.name}} mentioned you in the group "{{group.name}}":\n\n"{{usermessage}}"\n\nGo to the discussion to reply or catch up on the conversation: {{{mentioned.url}}}', 'publish', 'closed', 'closed', '', 'site-name-poster-name-mentioned-you-in-an-update', '', '', '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 0, 'http://localhost/?post_type=bp-email&p=199', 0, 'bp-email', '', 0),
(200, 1, '2020-11-29 15:56:43', '2020-11-29 14:56:43', 'Thanks for registering!\n\nTo complete the activation of your account, go to the following link and click on the <strong>Activate</strong> button:\n<a href="{{{activate.url}}}">{{{activate.url}}}</a>\n\nIf the ''Activation Key'' field is empty, copy and paste the following into the field - {{key}}', '[{{{site.name}}}] Felhasználói fiók aktiválás', 'Thanks for registering!\n\nTo complete the activation of your account, go to the following link and click on the ''Activate'' button: {{{activate.url}}}\n\nIf the ''Activation Key'' field is empty, copy and paste the following into the field - {{key}}', 'publish', 'closed', 'closed', '', 'site-name-felhasznaloi-fiok-aktivalas', '', '', '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 0, 'http://localhost/?post_type=bp-email&p=200', 0, 'bp-email', '', 0),
(201, 1, '2020-11-29 15:56:43', '2020-11-29 14:56:43', '<a href="{{{initiator.url}}}">{{initiator.name}}</a> wants to add you as a friend.\n\nTo accept this request and manage all of your pending requests, visit: <a href="{{{friend-requests.url}}}">{{{friend-requests.url}}}</a>', '[{{{site.name}}}] New friendship request from {{initiator.name}}', '{{initiator.name}} szeretne bennünket az ismerősei között tudni.\n\n\nA felkérés elfogadásához, illetőleg az összes függőben levő kérés kezeléséhez kövessük a következő hivatkozást: {{{friend-requests.url}}}\n\n{{initiator.name}} adatlapjának megtekintése: {{{initiator.url}}}', 'publish', 'closed', 'closed', '', 'site-name-new-friendship-request-from-initiator-name', '', '', '2020-11-29 15:56:43', '2020-11-29 14:56:43', '', 0, 'http://localhost/?post_type=bp-email&p=201', 0, 'bp-email', '', 0),
(202, 1, '2020-11-29 15:56:44', '2020-11-29 14:56:44', '<a href="{{{friendship.url}}}">{{friend.name}}</a> elfogadta az ismerősnek jelölést.', '[{{{site.name}}}] {{friend.name}} elfogadta az ismerősnek jelölést', '{{friend.name}} elfogadta ismerősnek jelölést.\n\n\nItt megtekinthető az adatlapja: {{{friendship.url}}}', 'publish', 'closed', 'closed', '', 'site-name-friend-name-elfogadta-az-ismerosnek-jelolest', '', '', '2020-11-29 15:56:44', '2020-11-29 14:56:44', '', 0, 'http://localhost/?post_type=bp-email&p=202', 0, 'bp-email', '', 0),
(203, 1, '2020-11-29 15:56:44', '2020-11-29 14:56:44', 'Group details for the group &quot;<a href="{{{group.url}}}">{{group.name}}</a>&quot; were updated:\n<blockquote>{{changed_text}}</blockquote>', '[{{{site.name}}}] Csoport adatai frissítve', 'Group details for the group "{{group.name}}" were updated:\n\n{{changed_text}}\n\nTo view the group, visit: {{{group.url}}}', 'publish', 'closed', 'closed', '', 'site-name-csoport-adatai-frissitve', '', '', '2020-11-29 15:56:44', '2020-11-29 14:56:44', '', 0, 'http://localhost/?post_type=bp-email&p=203', 0, 'bp-email', '', 0),
(204, 1, '2020-11-29 15:56:44', '2020-11-29 14:56:44', '<a href="{{{inviter.url}}}">{{inviter.name}}</a> küldött egy meghívást a(z) &quot;{{group.name}}&quot; csoportba történő csatlakozás érdekében.\n\n<a href="{{{invites.url}}}">Meghívás elfogadása</a>, vagy <a href="{{{group.url}}}">a csoport megtekintése</a>.', '[{{{site.name}}}] You have an invitation to the group: "{{group.name}}"', '{{inviter.name}} has invited you to join the group: "{{group.name}}".\n\nTo accept your invitation, visit: {{{invites.url}}}\n\nTo learn more about the group, visit: {{{group.url}}}.\nTo view {{inviter.name}}''s profile, visit: {{{inviter.url}}}', 'publish', 'closed', 'closed', '', 'site-name-you-have-an-invitation-to-the-group-group-name', '', '', '2020-11-29 15:56:44', '2020-11-29 14:56:44', '', 0, 'http://localhost/?post_type=bp-email&p=204', 0, 'bp-email', '', 0),
(205, 1, '2020-11-29 15:56:44', '2020-11-29 14:56:44', 'You have been promoted to <b>{{promoted_to}}</b> in the group &quot;<a href="{{{group.url}}}">{{group.name}}</a>&quot;.', '[{{{site.name}}}] You have been promoted in the group: "{{group.name}}"', 'You have been promoted to {{promoted_to}} in the group: "{{group.name}}".\n\nTo visit the group, go to: {{{group.url}}}', 'publish', 'closed', 'closed', '', 'site-name-you-have-been-promoted-in-the-group-group-name', '', '', '2020-11-29 15:56:44', '2020-11-29 14:56:44', '', 0, 'http://localhost/?post_type=bp-email&p=205', 0, 'bp-email', '', 0),
(206, 1, '2020-11-29 15:56:44', '2020-11-29 14:56:44', '<a href="{{{profile.url}}}">{{requesting-user.name}}</a> wants to join the group &quot;{{group.name}}&quot;.\n {{request.message}}\n As you are an administrator of this group, you must either accept or reject the membership request.\n\n<a href="{{{group-requests.url}}}">Go here to manage this</a> and all other pending requests.', '[{{{site.name}}}] Új tagsági kérelem a(z) {{group.name}} csoportba', '{{requesting-user.name}} wants to join the group "{{group.name}}". As you are the administrator of this group, you must either accept or reject the membership request.\n\nTo manage this and all other pending requests, visit: {{{group-requests.url}}}\n\nTo view {{requesting-user.name}}''s profile, visit: {{{profile.url}}}', 'publish', 'closed', 'closed', '', 'site-name-uj-tagsagi-kerelem-az-group-name-csoportba', '', '', '2020-11-29 15:56:44', '2020-11-29 14:56:44', '', 0, 'http://localhost/?post_type=bp-email&p=206', 0, 'bp-email', '', 0),
(207, 1, '2020-11-29 15:56:44', '2020-11-29 14:56:44', '{{sender.name}} sent you a new message: &quot;{{usersubject}}&quot;\n\n<blockquote>&quot;{{usermessage}}&quot;</blockquote>\n\n<a href="{{{message.url}}}">Go to the discussion</a> to reply or catch up on the conversation.', '[{{{site.name}}}] Új üzenet {{sender.name}} felhasználótól', '{{sender.name}} sent you a new message: "{{usersubject}}"\n\n"{{usermessage}}"\n\nGo to the discussion to reply or catch up on the conversation: {{{message.url}}}', 'publish', 'closed', 'closed', '', 'site-name-uj-uzenet-sender-name-felhasznalotol', '', '', '2020-11-29 15:56:44', '2020-11-29 14:56:44', '', 0, 'http://localhost/?post_type=bp-email&p=207', 0, 'bp-email', '', 0),
(208, 1, '2020-11-29 15:56:44', '2020-11-29 14:56:44', 'You recently changed the email address associated with your account on {{site.name}} to {{user.email}}. If this is correct, <a href="{{{verify.url}}}">go here to confirm the change</a>.\n\nOtherwise, you can safely ignore and delete this email if you have changed your mind, or if you think you have received this email in error.', '[{{{site.name}}}] Új e-mail cím ellenőrzése javasolt', 'You recently changed the email address associated with your account on {{site.name}} to {{user.email}}. If this is correct, go to the following link to confirm the change: {{{verify.url}}}\n\nOtherwise, you can safely ignore and delete this email if you have changed your mind, or if you think you have received this email in error.', 'publish', 'closed', 'closed', '', 'site-name-uj-e-mail-cim-ellenorzese-javasolt', '', '', '2020-11-29 15:56:44', '2020-11-29 14:56:44', '', 0, 'http://localhost/?post_type=bp-email&p=208', 0, 'bp-email', '', 0),
(209, 1, '2020-11-29 15:56:44', '2020-11-29 14:56:44', 'A(z) &quot;<a href="{{{group.url}}}">{{group.name}}</a>&quot; csoportba való felvételed megtörtént.', '[{{{site.name}}}] A(z) "{{group.name}}" csoportba való felvétel megtörtént', 'A(z) "{{group.name}}" csoportba történő csatlakozási kérelem elfogadásra került.\n\nA csoport megtekintése: {{{group.url}}}', 'publish', 'closed', 'closed', '', 'site-name-az-group-name-csoportba-valo-felvetel-megtortent', '', '', '2020-11-29 15:56:44', '2020-11-29 14:56:44', '', 0, 'http://localhost/?post_type=bp-email&p=209', 0, 'bp-email', '', 0),
(210, 1, '2020-11-29 15:56:44', '2020-11-29 14:56:44', 'A(z) &quot;<a href="{{{group.url}}}">{{group.name}}</a>&quot; csoportba való felvételi kérelmet nem fogadtuk el.', '[{{{site.name}}}] A(z) "{{group.name}}" csoportba való felvételi kérelmet nem fogadtuk el', 'A(z) "{{group.name}}" csoportba történő csatlakozási kérelem elutasításra került.\n\nIsmételt csatlakozási kérelem: {{{group.url}}}', 'publish', 'closed', 'closed', '', 'site-name-az-group-name-csoportba-valo-felveteli-kerelmet-nem-fogadtuk-el', '', '', '2020-11-29 15:56:44', '2020-11-29 14:56:44', '', 0, 'http://localhost/?post_type=bp-email&p=210', 0, 'bp-email', '', 0),
(211, 1, '2020-11-29 15:57:31', '2020-11-29 14:57:31', '', 'Csoportok', '', 'publish', 'closed', 'closed', '', 'csoportok', '', '', '2020-11-29 15:57:31', '2020-11-29 14:57:31', '', 0, 'http://localhost/csoportok/', 0, 'page', '', 0),
(212, 1, '2020-11-29 16:02:16', '2020-11-29 15:02:16', '', 'Regisztrál', '', 'inherit', 'closed', 'closed', '', '194-revision-v1', '', '', '2020-11-29 16:02:16', '2020-11-29 15:02:16', '', 194, 'http://localhost/2020/11/29/194-revision-v1/', 0, 'revision', '', 0),
(213, 1, '2020-11-29 16:03:53', '2020-11-29 15:03:53', '{\n    "pixiefreak::nav_menu_locations[header_menu]": {\n        "value": -5263456114406617000,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-29 15:03:53"\n    },\n    "nav_menu[-5263456114406617000]": {\n        "value": {\n            "name": "ASD",\n            "description": "",\n            "parent": 0,\n            "auto_add": false\n        },\n        "type": "nav_menu",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-29 15:03:53"\n    },\n    "nav_menu_item[-8218052171875844000]": {\n        "value": {\n            "object_id": 194,\n            "object": "page",\n            "menu_item_parent": 0,\n            "position": 1,\n            "type": "post_type",\n            "title": "Regisztr\\u00e1l",\n            "url": "http://localhost/regisztral/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Regisztr\\u00e1l",\n            "nav_menu_term_id": -5263456114406617000,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-29 15:03:53"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '250951d4-727b-46f6-bbfc-08d6bde498aa', '', '', '2020-11-29 16:03:53', '2020-11-29 15:03:53', '', 0, 'http://localhost/2020/11/29/250951d4-727b-46f6-bbfc-08d6bde498aa/', 0, 'customize_changeset', '', 0),
(215, 1, '2020-11-29 16:04:14', '2020-11-29 15:04:14', '{\n    "pixiefreak::nav_menu_locations[header_menu]": {\n        "value": 0,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-29 15:04:14"\n    },\n    "nav_menu[35]": {\n        "value": false,\n        "type": "nav_menu",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-29 15:04:14"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '21b22897-78c4-4c22-80e7-61628a044801', '', '', '2020-11-29 16:04:14', '2020-11-29 15:04:14', '', 0, 'http://localhost/2020/11/29/21b22897-78c4-4c22-80e7-61628a044801/', 0, 'customize_changeset', '', 0),
(216, 1, '2020-11-29 16:04:34', '2020-11-29 15:04:34', '{\n    "pixiefreak::nav_menu_locations[header_menu]": {\n        "value": 18,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-11-29 15:04:34"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'faaaf929-7f4d-47c9-8811-1658fc3426c9', '', '', '2020-11-29 16:04:34', '2020-11-29 15:04:34', '', 0, 'http://localhost/2020/11/29/faaaf929-7f4d-47c9-8811-1658fc3426c9/', 0, 'customize_changeset', '', 0),
(218, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', '•••', '', 'publish', 'closed', 'closed', '', '218', '', '', '2020-12-05 15:40:49', '2020-12-05 14:40:49', '', 0, 'http://esportplay.hu/2020/12/05/', 5, 'nav_menu_item', '', 0),
(219, 1, '2020-11-28 19:54:36', '2020-11-28 19:54:36', '<!-- wp:heading --><h2>Kik vagyunk</h2><!-- /wp:heading --><!-- wp:paragraph --><p>A weboldalunk címe: http://localhost.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Melyek azok a személyes adatok, amiket gyűjtünk és milyen céllal gyűjtjük ezeket</h2><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Hozzászólások</h3><!-- /wp:heading --><!-- wp:paragraph --><p>Hozzászólás beküldésekor a hozzászólási űrlapban megadottakon kívül begyűjtésre kerül a hozzászóló IP címe és a böngészőazonosító karakterlánc a kéretlen tartalmak kiszűrése céljából.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>Egy személytelenített, az e-mail címből előállított karakterlánc (hashnek szokás nevezni) kerül továbbításra a Gravatar szolgáltatás felé, ha ez az oldalon használatban van. A Gravatar szolgáltatás feltételei az alábbi címen tekinthetőek meg: https://automattic.com/privacy/. A hozzászólás elfogadása után, a hozzászólásunk tartalma és a profil képünk is megjelenik nyilvánosan.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Média</h3><!-- /wp:heading --><!-- wp:paragraph --><p>Amennyiben regisztrált felhasználó által kerül kép feltöltésre a honlapra, kerülni kell az az olyan EXIF-eket, amelyekben GPS pozíció adatok is szerepelnek. A honlap látogatói ezeket letölthetik és kinyerhetik a helyadatokat a honlapon található képekből.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Kapcsolatfelvételi űrlapok</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Sütik</h3><!-- /wp:heading --><!-- wp:paragraph --><p>Ha hozzászólást írunk a honlapon, a megadott nevet, e-mail és honlap címet sütikben eltároljuk. A tárolás a kényelmi célokat szolgál azért, így a következő hozzászóláskor ezeket a mező adatokat nem kell kitölteni. A sütik lejárati ideje egy év.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>Ha ellátogatunk a bejelentkezési oldalra, akkor átmeneti sütiket állítunk be annak érdekében, hogy megállapítsuk, hogy a böngésző elfogadja-e a sütiket. Ezek a sütik nem tartalmaznak személyes információt, és törlődnek, ahogy bezárjuk a böngészőt.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>A honlapra történő bejelentkezéskor több sütit hozunk létre, amely elmenti a bejelentkezési információt és a szerkesztőfelület megjelenítési opcióit. A bejelentkezési sütik két napig érvényesek, a szerkesztőfelület megjelenítési opcióit tároló süti egy évig. Amennyiben az  &quot;Emlékezz rám&quot; opciót bejelöljük, a bejelentkezés két hétig folytatódik. Kijelentkezéskor a bejelentkezési sütik eltávolításra kerülnek.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>Amennyiben bejegyzést vagy oldalt szerkesztünk, egy újabb sütit tárol el a böngészőnk. Ez a süti nem tartalmaz személyes adatot, egyszerűen csak a bejegyzés azonosító számát tárolja, amelyet szerkesztettünk. Egy nap múlva jár le az érvényessége.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Más honlapokról származó beágyazott tartalmak</h3><!-- /wp:heading --><!-- wp:paragraph --><p>A honlapon elérhető bejegyzések külső forrásból származó beágyazott tartalmakat (pl. videók, képek, cikkek stb.) használhatnak. A külső forrásból származó beágyazott tartalmak pontosan úgy viselkednek, mintha meglátogattunk volna egy másik honlapot.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>Ezek a webhelyek lehetséges, hogy adatot gyűjtenek a látogatókról, sütiket vagy harmadik féltől származó követőkódot használnak, figyelik a beágyazott tartalommal kapcsolatos felhasználói viselkedést, ha rendelkezünk felhasználói fiókkal és be vagyunk jelentkezve az oldalra.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Analitika</h3><!-- /wp:heading --><!-- wp:heading --><h2>Kivel osztjuk meg a felhasználói adatokat</h2><!-- /wp:heading --><!-- wp:heading --><h2>Mennyi ideig őrizzük a személyes adatot</h2><!-- /wp:heading --><!-- wp:paragraph --><p>Ha hozzászólunk, a hozzászólás és annak metaadatai nem meghatározható ideig a rendszerben maradnak. Ennek célja, hogy az összes ezt követő bármely hozzászólás általunk megismertté és jóváhagyottá váljon, azaz ne kerüljön fel a moderálandó hozzászólások listájára.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>A honlapon regisztrált felhasználók (ha vannak ilyenek) személyes adatai a saját felhasználói profiljukban is tárolásra kerülnek. Minden felhasználó megtekintheti, szerkesztheti vagy törölheti a személyes adatait bármikor (kivéve, hogy nem változtathatja meg a saját felhasználói nevét). A honlap rendszergazdái ezen információkat szintén megtekinthetik és szerkeszthetik.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Milyen jogokkal rendelkezik a felhasználó a saját adatai kapcsán</h2><!-- /wp:heading --><!-- wp:paragraph --><p>A weboldalon regisztrált fiók vagy hozzászólás írása esetén kérhető a személyes adatok export fájlban történő megküldése, amely bármilyen adatot tartalmaz, amit korábban a felhasználó rendelkezésünkre bocsátott. Kérhető továbbá, hogy bármilyen korábban megadott személyes adatot töröljük. Ez nem vonatkozik azokra az adatokra, amelyeket adminisztrációs, jogi vagy biztonsági okokból kötelező megőriznünk.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Hová továbbítjuk az adatokat</h2><!-- /wp:heading --><!-- wp:paragraph --><p>A látogatók által beküldött hozzászólásokat automatikus spamszűrő szolgáltatás ellenőrizheti.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Kapcsolati adatok</h2><!-- /wp:heading --><!-- wp:heading --><h2>További információk</h2><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Hogyan védjük a felhasználói személyes adatokat</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Érvényben lévő eljárások adatkezelési sérelmek esetén</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Milyen harmadik féltől származó adatokat kapunk</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Milyen automatizált döntéshozatalt és/vagy profilalkotást végzünk a felhasználói adatokkal</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Szabályozott iparág közzétételi követelményei</h3><!-- /wp:heading -->', 'Adatvédelmi irányelvek', '', 'draft', 'closed', 'open', '', 'adatkezelesi-tajekoztato', '', '', '2020-11-28 19:54:36', '2020-11-28 19:54:36', '', 0, 'http://localhost/?page_id=3', 0, 'page', '', 0),
(17, 1, '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 'Sponsor', '', 'publish', 'closed', 'closed', '', 'sponsor', '', '', '2018-10-22 11:54:38', '2018-10-22 11:54:38', '', 0, 'http://themes.pixiesquad.com/pixiefreak/twisting-nether/sponsor/', 0, 'page', '', 0),
(220, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '220', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/', 5, 'nav_menu_item', '', 0),
(221, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '221', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/', 1, 'nav_menu_item', '', 0),
(222, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '222', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/', 2, 'nav_menu_item', '', 0),
(223, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '223', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/', 3, 'nav_menu_item', '', 0),
(224, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '224', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/', 4, 'nav_menu_item', '', 0),
(225, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '225', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/', 2, 'nav_menu_item', '', 0),
(226, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '226', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/', 3, 'nav_menu_item', '', 0),
(227, 1, '2020-11-28 19:54:36', '2020-11-28 19:54:36', '<!-- wp:paragraph -->\n<p>Ez egy mintaoldal. Az oldal különbözik a bejegyzéstől annyiban, hogy az oldal egy állandó tartalmú bejegyzés, ami - a legtöbb sablonnál - a weboldal navigációs részében állandó helyen van.\nA legtöbb ember olyan Bemutatkozó oldallal kezd, amelyik bemutatja őt, vagy a tevékenységét a weboldal látogatóinak. A Bemutatkozás oldal valami ilyesmi lehet:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class="wp-block-quote"><p>Üdvözlet az Olvasóknak! Nappal biciklis pizzafutár vagyok, éjszaka pedig egy törekvő színész-tanonc, ez pedig az én weboldalam.<br>Budapesten élek és van egy csodálatos német juhász kutyám, aki Velorex névre hallgat. Kedvenc koktélom a Piña Colada, de a Mojitot is nagyon kedvelem. (De, azért az igazi nedű: egy bársonyos vörösbor.)</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>...vagy valami egészen más:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class="wp-block-quote"><p>Az XYZ Bigyó Vállalatot 1971-ben alapították, azóta gyártja a legjobb minőségű bigyókat. A cég központja Budapesten található, ahol több mint 2000 embert foglalkoztatnak, valamint számos közösségi és jótékonysági programban is aktívan résztvesznek.</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>Új WordPress felhasználóként a <a href="http://localhost/wp-admin/">Vezérlőpult</a> részre ugorva lehet törölni ezt az oldalt, és létrehozni egy úja oldalt a saját tartalmunk részére. Jó szórakozást!</p>\n<!-- /wp:paragraph -->', 'Ez egy minta oldal', '', 'publish', 'closed', 'open', '', 'ez-egy-minta-oldal-2', '', '', '2020-11-28 19:54:36', '2020-11-28 19:54:36', '', 0, 'http://localhost/?page_id=2', 0, 'page', '', 0),
(228, 1, '2020-11-28 19:54:36', '2020-11-28 19:54:36', '<!-- wp:paragraph -->\n<p>Üdvözlet a WordPress-ben! Ez az első bejegyzés, amelyet lehet akár módosítani, akár törölni, aztán kezdődhet az írás, a tartalommal történő feltöltés.</p>\n<!-- /wp:paragraph -->', 'Helló Világ!', '', 'publish', 'open', 'open', '', 'hello-vilag-2', '', '', '2020-11-28 19:54:36', '2020-11-28 19:54:36', '', 0, 'http://localhost/?p=1', 0, 'post', '', 1),
(229, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 'VERSENYEK', '', 'publish', 'closed', 'closed', '', 'versenyek', '', '', '2020-12-05 15:40:49', '2020-12-05 14:40:49', '', 0, 'http://esportplay.hu/2020/12/05/versenyek/', 3, 'nav_menu_item', '', 0),
(230, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 'CSAPATOK', '', 'publish', 'closed', 'closed', '', 'csapatok', '', '', '2020-12-05 15:40:49', '2020-12-05 14:40:49', '', 0, 'http://esportplay.hu/2020/12/05/csapatok/', 2, 'nav_menu_item', '', 0),
(231, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 'STREAMEK', '', 'publish', 'closed', 'closed', '', 'streamek', '', '', '2020-12-05 17:19:17', '2020-12-05 16:19:17', '', 0, 'http://esportplay.hu/2020/12/05/streamek/', 7, 'nav_menu_item', '', 0),
(232, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 'PARTNEREINK', '', 'publish', 'closed', 'closed', '', 'partnereink', '', '', '2020-12-05 17:19:17', '2020-12-05 16:19:17', '', 0, 'http://esportplay.hu/2020/12/05/partnereink/', 6, 'nav_menu_item', '', 0),
(233, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 'HÍREK', '', 'publish', 'closed', 'closed', '', 'hirek', '', '', '2020-12-05 15:40:49', '2020-12-05 14:40:49', '', 0, 'http://esportplay.hu/2020/12/05/hirek/', 1, 'nav_menu_item', '', 0),
(234, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 'MÉRKŐZÉSEK', '', 'publish', 'closed', 'closed', '', 'merkozesek', '', '', '2020-12-05 15:40:49', '2020-12-05 14:40:49', '', 0, 'http://esportplay.hu/2020/12/05/merkozesek/', 4, 'nav_menu_item', '', 0),
(235, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 'GALLÉRIA', '', 'publish', 'closed', 'closed', '', 'galleria', '', '', '2020-12-05 17:19:17', '2020-12-05 16:19:17', '', 0, 'http://esportplay.hu/2020/12/05/galleria/', 8, 'nav_menu_item', '', 0),
(236, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 'RÓLUNK', '', 'publish', 'closed', 'closed', '', 'rolunk', '', '', '2020-12-05 17:19:17', '2020-12-05 16:19:17', '', 0, 'http://esportplay.hu/2020/12/05/rolunk/', 9, 'nav_menu_item', '', 0),
(237, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '237', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/237/', 1, 'nav_menu_item', '', 0),
(238, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '238', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/238/', 2, 'nav_menu_item', '', 0),
(239, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '239', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/239/', 3, 'nav_menu_item', '', 0),
(240, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '240', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/240/', 4, 'nav_menu_item', '', 0),
(241, 1, '2020-12-05 11:50:22', '2020-12-05 10:50:22', ' ', '', '', 'publish', 'closed', 'closed', '', '241', '', '', '2020-12-05 11:50:22', '2020-12-05 10:50:22', '', 0, 'http://esportplay.hu/2020/12/05/241/', 1, 'nav_menu_item', '', 0),
(242, 1, '2020-12-05 11:55:34', '2020-12-05 10:55:34', '', '77398019_1050496535281850_3009940701971480576_o', '', 'inherit', 'open', 'closed', '', '77398019_1050496535281850_3009940701971480576_o-6', '', '', '2020-12-05 11:55:34', '2020-12-05 10:55:34', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o.png', 0, 'attachment', 'image/png', 0),
(243, 1, '2020-12-05 11:55:48', '2020-12-05 10:55:48', '', '77398019_1050496535281850_3009940701971480576_o-1', '', 'inherit', 'open', 'closed', '', '77398019_1050496535281850_3009940701971480576_o-1', '', '', '2020-12-05 11:55:48', '2020-12-05 10:55:48', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-1.png', 0, 'attachment', 'image/png', 0),
(244, 1, '2020-12-05 11:56:00', '2020-12-05 10:56:00', '', '77398019_1050496535281850_3009940701971480576_o-2', '', 'inherit', 'open', 'closed', '', '77398019_1050496535281850_3009940701971480576_o-2-2', '', '', '2020-12-05 11:56:00', '2020-12-05 10:56:00', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-2.png', 0, 'attachment', 'image/png', 0),
(245, 1, '2020-12-05 11:56:09', '2020-12-05 10:56:09', '', '77398019_1050496535281850_3009940701971480576_o-3', '', 'inherit', 'open', 'closed', '', '77398019_1050496535281850_3009940701971480576_o-3-2', '', '', '2020-12-05 11:56:09', '2020-12-05 10:56:09', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-3.png', 0, 'attachment', 'image/png', 0),
(246, 1, '2020-12-05 11:56:26', '2020-12-05 10:56:26', '', '77398019_1050496535281850_3009940701971480576_o-4', '', 'inherit', 'open', 'closed', '', '77398019_1050496535281850_3009940701971480576_o-4-2', '', '', '2020-12-05 11:56:26', '2020-12-05 10:56:26', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4.png', 0, 'attachment', 'image/png', 0),
(247, 1, '2020-12-05 11:56:39', '2020-12-05 10:56:39', '', 'qc', '', 'inherit', 'open', 'closed', '', 'qc-2', '', '', '2020-12-05 11:56:39', '2020-12-05 10:56:39', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/qc.png', 0, 'attachment', 'image/png', 0),
(248, 1, '2020-12-05 11:56:53', '2020-12-05 10:56:53', '', 'qw', '', 'inherit', 'open', 'closed', '', 'qw-2', '', '', '2020-12-05 11:56:53', '2020-12-05 10:56:53', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/qw.png', 0, 'attachment', 'image/png', 0),
(249, 1, '2020-12-05 11:56:59', '2020-12-05 10:56:59', '', 'qwcqwcqc', '', 'inherit', 'open', 'closed', '', 'qwcqwcqc-2', '', '', '2020-12-05 11:56:59', '2020-12-05 10:56:59', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/qwcqwcqc.png', 0, 'attachment', 'image/png', 0),
(250, 1, '2020-12-05 11:56:59', '2020-12-05 10:56:59', '', 'wcwcw', '', 'inherit', 'open', 'closed', '', 'wcwcw-2', '', '', '2020-12-05 11:56:59', '2020-12-05 10:56:59', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/wcwcw.png', 0, 'attachment', 'image/png', 0),
(251, 1, '2020-12-05 11:57:00', '2020-12-05 10:57:00', '', 'ww', '', 'inherit', 'open', 'closed', '', 'ww-2', '', '', '2020-12-05 11:57:00', '2020-12-05 10:57:00', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/ww.png', 0, 'attachment', 'image/png', 0),
(252, 1, '2020-12-05 12:01:32', '2020-12-05 11:01:32', '{\n    "pixiefreak::pixiefreak_primary_color": {\n        "value": "#ed2f2f",\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:01:32"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '2440f7c5-5973-4d48-8e8c-7afaba7d346b', '', '', '2020-12-05 12:01:32', '2020-12-05 11:01:32', '', 0, 'http://esportplay.hu/2020/12/05/2440f7c5-5973-4d48-8e8c-7afaba7d346b/', 0, 'customize_changeset', '', 0),
(253, 1, '2020-12-05 12:01:45', '2020-12-05 11:01:45', '{\n    "pixiefreak::nav_menu_locations[header_menu]": {\n        "value": 51,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:01:45"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'f8b11a4e-5ce7-4786-860c-472e20fc7150', '', '', '2020-12-05 12:01:45', '2020-12-05 11:01:45', '', 0, 'http://esportplay.hu/2020/12/05/f8b11a4e-5ce7-4786-860c-472e20fc7150/', 0, 'customize_changeset', '', 0),
(254, 1, '2020-12-05 12:04:33', '2020-12-05 11:04:33', '', 'Nevtelen-2', '', 'inherit', 'open', 'closed', '', 'nevtelen-2-2', '', '', '2020-12-05 12:04:33', '2020-12-05 11:04:33', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/Nevtelen-2.png', 0, 'attachment', 'image/png', 0),
(255, 1, '2020-12-05 12:06:00', '2020-12-05 11:06:00', '{\n    "nav_menu_item[229]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 78,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/tournaments/",\n            "title": "VERSENYEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 4,\n            "status": "publish",\n            "original_title": "Tournaments",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:06:00"\n    },\n    "nav_menu_item[234]": {\n        "value": {\n            "menu_item_parent": 229,\n            "object_id": 69,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/matches/",\n            "title": "M\\u00c9RK\\u0150Z\\u00c9SEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 5,\n            "status": "publish",\n            "original_title": "Matches",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:06:00"\n    },\n    "nav_menu_item[218]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 218,\n            "object": "custom",\n            "type": "custom",\n            "type_label": "Egy\\u00e9ni hivatkoz\\u00e1s",\n            "title": "\\u2022\\u2022\\u2022",\n            "url": "/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 6,\n            "status": "publish",\n            "original_title": "",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:06:00"\n    },\n    "nav_menu_item[232]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 17,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/sponsor/",\n            "title": "PARTNEREINK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 7,\n            "status": "publish",\n            "original_title": "Sponsor",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:06:00"\n    },\n    "nav_menu_item[231]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 74,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/streams/",\n            "title": "STREAMEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 8,\n            "status": "publish",\n            "original_title": "Streams",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:06:00"\n    },\n    "nav_menu_item[235]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 67,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/gallery/",\n            "title": "GALL\\u00c9RIA",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 9,\n            "status": "publish",\n            "original_title": "Gallery",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:06:00"\n    },\n    "nav_menu_item[236]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 65,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/about/",\n            "title": "R\\u00d3LUNK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 10,\n            "status": "publish",\n            "original_title": "About",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:06:00"\n    },\n    "nav_menu_item[-422459339504842750]": {\n        "value": {\n            "object_id": 71,\n            "object": "page",\n            "menu_item_parent": 230,\n            "position": 3,\n            "type": "post_type",\n            "title": "J\\u00c1T\\u00c9KOSOK",\n            "url": "http://esportplay.hu/player/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Player",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:06:00"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '2a028ee8-ddc9-4e5a-9fda-2c4d67e78c7f', '', '', '2020-12-05 12:06:00', '2020-12-05 11:06:00', '', 0, 'http://esportplay.hu/2020/12/05/2a028ee8-ddc9-4e5a-9fda-2c4d67e78c7f/', 0, 'customize_changeset', '', 0),
(257, 1, '2020-12-05 12:06:51', '2020-12-05 11:06:51', '{\n    "nav_menu_item[256]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 11:06:51"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'a0d586b5-9e49-4dfd-b6f5-33d6723ae7a4', '', '', '2020-12-05 12:06:51', '2020-12-05 11:06:51', '', 0, 'http://esportplay.hu/2020/12/05/a0d586b5-9e49-4dfd-b6f5-33d6723ae7a4/', 0, 'customize_changeset', '', 0),
(260, 1, '2020-12-05 14:40:13', '2020-12-05 13:40:13', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-logo-1.png', 'cropped-logo-1.png', '', 'inherit', 'open', 'closed', '', 'cropped-logo-1-png', '', '', '2020-12-05 14:40:13', '2020-12-05 13:40:13', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-logo-1.png', 0, 'attachment', 'image/png', 0),
(261, 1, '2020-12-05 14:47:03', '2020-12-05 13:47:03', '{\n    "site_icon": {\n        "value": 265,\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 13:43:55"\n    },\n    "pixiefreak::custom_logo": {\n        "value": 268,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 13:46:55"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'c5b9efbb-1d37-4ec7-9059-e3ec4e56c7ea', '', '', '2020-12-05 14:47:03', '2020-12-05 13:47:03', '', 0, 'http://esportplay.hu/?p=261', 0, 'customize_changeset', '', 0),
(262, 1, '2020-12-05 14:41:28', '2020-12-05 13:41:28', '', 'remote-device-control-game-playstation-joypad-play-2-4102', '', 'inherit', 'open', 'closed', '', 'remote-device-control-game-playstation-joypad-play-2-4102', '', '', '2020-12-05 14:41:28', '2020-12-05 13:41:28', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/remote-device-control-game-playstation-joypad-play-2-4102.png', 0, 'attachment', 'image/png', 0),
(263, 1, '2020-12-05 14:41:36', '2020-12-05 13:41:36', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-remote-device-control-game-playstation-joypad-play-2-4102.png', 'cropped-remote-device-control-game-playstation-joypad-play-2-4102.png', '', 'inherit', 'open', 'closed', '', 'cropped-remote-device-control-game-playstation-joypad-play-2-4102-png', '', '', '2020-12-05 14:41:36', '2020-12-05 13:41:36', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-remote-device-control-game-playstation-joypad-play-2-4102.png', 0, 'attachment', 'image/png', 0),
(264, 1, '2020-12-05 14:43:05', '2020-12-05 13:43:05', '', 'remote-device-control-game-playstation-joypad-play-2-4102', '', 'inherit', 'open', 'closed', '', 'remote-device-control-game-playstation-joypad-play-2-4102-2', '', '', '2020-12-05 14:43:05', '2020-12-05 13:43:05', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/remote-device-control-game-playstation-joypad-play-2-4102-1.png', 0, 'attachment', 'image/png', 0),
(265, 1, '2020-12-05 14:43:08', '2020-12-05 13:43:08', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-remote-device-control-game-playstation-joypad-play-2-4102-1.png', 'cropped-remote-device-control-game-playstation-joypad-play-2-4102-1.png', '', 'inherit', 'open', 'closed', '', 'cropped-remote-device-control-game-playstation-joypad-play-2-4102-1-png', '', '', '2020-12-05 14:43:08', '2020-12-05 13:43:08', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-remote-device-control-game-playstation-joypad-play-2-4102-1.png', 0, 'attachment', 'image/png', 0),
(266, 1, '2020-12-05 14:46:22', '2020-12-05 13:46:22', '', 'wcsa', '', 'inherit', 'open', 'closed', '', 'wcsa', '', '', '2020-12-05 14:46:22', '2020-12-05 13:46:22', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/wcsa.png', 0, 'attachment', 'image/png', 0),
(267, 1, '2020-12-05 14:46:31', '2020-12-05 13:46:31', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa.png', 'cropped-wcsa.png', '', 'inherit', 'open', 'closed', '', 'cropped-wcsa-png', '', '', '2020-12-05 14:46:31', '2020-12-05 13:46:31', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa.png', 0, 'attachment', 'image/png', 0),
(268, 1, '2020-12-05 14:46:41', '2020-12-05 13:46:41', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-1.png', 'cropped-wcsa-1.png', '', 'inherit', 'open', 'closed', '', 'cropped-wcsa-1-png', '', '', '2020-12-05 14:46:41', '2020-12-05 13:46:41', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-1.png', 0, 'attachment', 'image/png', 0),
(279, 1, '2020-12-05 14:54:16', '2020-12-05 13:54:16', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-2-1.png', 'cropped-wcsa-2-1.png', '', 'inherit', 'open', 'closed', '', 'cropped-wcsa-2-1-png', '', '', '2020-12-05 14:54:16', '2020-12-05 13:54:16', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-2-1.png', 0, 'attachment', 'image/png', 0),
(270, 1, '2020-12-05 14:48:54', '2020-12-05 13:48:54', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-1-1.png', 'cropped-wcsa-1-1.png', '', 'inherit', 'open', 'closed', '', 'cropped-wcsa-1-1-png', '', '', '2020-12-05 14:48:54', '2020-12-05 13:48:54', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-1-1.png', 0, 'attachment', 'image/png', 0),
(271, 1, '2020-12-05 14:51:41', '2020-12-05 13:51:41', '{\n    "pixiefreak::custom_logo": {\n        "value": 273,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 13:51:41"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '5a446f17-e80f-42fe-8f0a-329cc27119bd', '', '', '2020-12-05 14:51:41', '2020-12-05 13:51:41', '', 0, 'http://esportplay.hu/?p=271', 0, 'customize_changeset', '', 0),
(274, 1, '2020-12-05 14:52:23', '2020-12-05 13:52:23', '', 'wcsa', '', 'inherit', 'open', 'closed', '', 'wcsa-3', '', '', '2020-12-05 14:52:23', '2020-12-05 13:52:23', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/wcsa-2.png', 0, 'attachment', 'image/png', 0),
(273, 1, '2020-12-05 14:51:28', '2020-12-05 13:51:28', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-2.png', 'cropped-wcsa-2.png', '', 'inherit', 'open', 'closed', '', 'cropped-wcsa-2-png', '', '', '2020-12-05 14:51:28', '2020-12-05 13:51:28', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-2.png', 0, 'attachment', 'image/png', 0),
(277, 1, '2020-12-05 14:53:43', '2020-12-05 13:53:43', '{\n    "pixiefreak::custom_logo": {\n        "value": 274,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 13:53:20"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'deeb3587-b73d-451b-b9e9-12c21c30b208', '', '', '2020-12-05 14:53:43', '2020-12-05 13:53:43', '', 0, 'http://esportplay.hu/?p=277', 0, 'customize_changeset', '', 0),
(280, 1, '2020-12-05 14:55:25', '2020-12-05 13:55:25', '{\n    "pixiefreak::custom_logo": {\n        "value": 283,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 13:55:25"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'bae6552f-2522-4cb3-85fa-ff72ce4665c9', '', '', '2020-12-05 14:55:25', '2020-12-05 13:55:25', '', 0, 'http://esportplay.hu/?p=280', 0, 'customize_changeset', '', 0),
(284, 1, '2020-12-05 14:56:13', '2020-12-05 13:56:13', '', 'wcsa', '', 'inherit', 'open', 'closed', '', 'wcsa-2', '', '', '2020-12-05 14:56:13', '2020-12-05 13:56:13', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/wcsa-1.png', 0, 'attachment', 'image/png', 0),
(283, 1, '2020-12-05 14:55:21', '2020-12-05 13:55:21', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-1-2.png', 'cropped-wcsa-1-2.png', '', 'inherit', 'open', 'closed', '', 'cropped-wcsa-1-2-png', '', '', '2020-12-05 14:55:21', '2020-12-05 13:55:21', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-1-2.png', 0, 'attachment', 'image/png', 0),
(285, 1, '2020-12-05 14:56:18', '2020-12-05 13:56:18', 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-1-3.png', 'cropped-wcsa-1-3.png', '', 'inherit', 'open', 'closed', '', 'cropped-wcsa-1-3-png', '', '', '2020-12-05 14:56:18', '2020-12-05 13:56:18', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/cropped-wcsa-1-3.png', 0, 'attachment', 'image/png', 0),
(286, 1, '2020-12-05 14:56:22', '2020-12-05 13:56:22', '{\n    "pixiefreak::custom_logo": {\n        "value": 285,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 13:56:20"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '028f7e60-00d9-45ed-b131-8c5a4e918d69', '', '', '2020-12-05 14:56:22', '2020-12-05 13:56:22', '', 0, 'http://esportplay.hu/?p=286', 0, 'customize_changeset', '', 0),
(297, 1, '2020-12-05 15:38:25', '2020-12-05 14:38:25', '{\n    "nav_menu_item[296]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:38:25"\n    },\n    "nav_menu_item[-3989935055856449500]": {\n        "value": {\n            "object_id": "register",\n            "object": "register",\n            "menu_item_parent": 0,\n            "position": 6,\n            "type": "tml_action",\n            "title": "Regisztr\\u00e1ci\\u00f3",\n            "url": "http://esportplay.hu/register/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Regisztr\\u00e1ci\\u00f3",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "TML m\\u0171velet"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:38:25"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '04387aca-30f3-4022-8543-d17ab832c674', '', '', '2020-12-05 15:38:25', '2020-12-05 14:38:25', '', 0, 'http://esportplay.hu/2020/12/05/04387aca-30f3-4022-8543-d17ab832c674/', 0, 'customize_changeset', '', 0),
(300, 1, '2020-12-05 15:39:21', '2020-12-05 14:39:21', '{\n    "nav_menu_item[-8509184319575448000]": {\n        "value": {\n            "object_id": "register",\n            "object": "register",\n            "menu_item_parent": 0,\n            "position": 6,\n            "type": "tml_action",\n            "title": "Regisztr\\u00e1ci\\u00f3",\n            "url": "http://esportplay.hu/register/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Regisztr\\u00e1ci\\u00f3",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "TML m\\u0171velet"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:39:21"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '6fbb505a-5a45-45ae-8ed2-09ed36d4f08c', '', '', '2020-12-05 15:39:21', '2020-12-05 14:39:21', '', 0, 'http://esportplay.hu/2020/12/05/6fbb505a-5a45-45ae-8ed2-09ed36d4f08c/', 0, 'customize_changeset', '', 0);
INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(299, 1, '2020-12-05 15:38:51', '2020-12-05 14:38:51', '{\n    "nav_menu_item[298]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:38:51"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'd087434b-729f-4acd-8136-bfc9920eb20e', '', '', '2020-12-05 15:38:51', '2020-12-05 14:38:51', '', 0, 'http://esportplay.hu/?p=299', 0, 'customize_changeset', '', 0),
(312, 1, '2020-12-05 16:44:52', '2020-12-05 15:44:52', '{\n    "clpt_potd": {\n        "value": "on",\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:44:52"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'bf1c09f8-90a0-45b3-b822-cd3193da688e', '', '', '2020-12-05 16:44:52', '2020-12-05 15:44:52', '', 0, 'http://esportplay.hu/2020/12/05/bf1c09f8-90a0-45b3-b822-cd3193da688e/', 0, 'customize_changeset', '', 0),
(302, 1, '2020-12-05 15:40:49', '2020-12-05 14:40:49', '{\n    "pixiefreak::nav_menu_locations[footer_menu]": {\n        "value": 0,\n        "type": "theme_mod",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:11"\n    },\n    "nav_menu_item[233]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 70,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/news/",\n            "title": "H\\u00cdREK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 1,\n            "status": "publish",\n            "original_title": "News",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[230]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 76,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/teams/",\n            "title": "CSAPATOK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 2,\n            "status": "publish",\n            "original_title": "Teams",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[229]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 78,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/tournaments/",\n            "title": "VERSENYEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 3,\n            "status": "publish",\n            "original_title": "Tournaments",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[234]": {\n        "value": {\n            "menu_item_parent": 229,\n            "object_id": 69,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/matches/",\n            "title": "M\\u00c9RK\\u0150Z\\u00c9SEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 4,\n            "status": "publish",\n            "original_title": "Matches",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[218]": {\n        "value": {\n            "menu_item_parent": 0,\n            "object_id": 218,\n            "object": "custom",\n            "type": "custom",\n            "type_label": "Egy\\u00e9ni hivatkoz\\u00e1s",\n            "title": "\\u2022\\u2022\\u2022",\n            "url": "/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 5,\n            "status": "publish",\n            "original_title": "",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[232]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 17,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/sponsor/",\n            "title": "PARTNEREINK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 6,\n            "status": "publish",\n            "original_title": "Sponsor",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[231]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 74,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/streams/",\n            "title": "STREAMEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 7,\n            "status": "publish",\n            "original_title": "Streams",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[235]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 67,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/gallery/",\n            "title": "GALL\\u00c9RIA",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 8,\n            "status": "publish",\n            "original_title": "Gallery",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[236]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 65,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/about/",\n            "title": "R\\u00d3LUNK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 9,\n            "status": "publish",\n            "original_title": "About",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[301]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:11"\n    },\n    "nav_menu_item[-5959450245976689000]": {\n        "value": {\n            "object_id": "register",\n            "object": "register",\n            "menu_item_parent": -6262287667853670000,\n            "position": 12,\n            "type": "tml_action",\n            "title": "Regisztr\\u00e1ci\\u00f3",\n            "url": "http://esportplay.hu/register/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Regisztr\\u00e1ci\\u00f3",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "TML m\\u0171velet"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[-6829821096389878000]": {\n        "value": {\n            "object_id": "logout",\n            "object": "logout",\n            "menu_item_parent": -6262287667853670000,\n            "position": 14,\n            "type": "tml_action",\n            "title": "Kijelentkez\\u00e9s",\n            "url": "http://esportplay.hu/logout/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Kijelentkez\\u00e9s",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "TML m\\u0171velet"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[-3885516257359845400]": {\n        "value": {\n            "object_id": "login",\n            "object": "login",\n            "menu_item_parent": -6262287667853670000,\n            "position": 11,\n            "type": "tml_action",\n            "title": "Bejelentkez\\u00e9s",\n            "url": "http://esportplay.hu/login/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Bejelentkez\\u00e9s",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "TML m\\u0171velet"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[-6430531568800571000]": {\n        "value": {\n            "object_id": "dashboard",\n            "object": "dashboard",\n            "menu_item_parent": -6262287667853670000,\n            "position": 13,\n            "type": "tml_action",\n            "title": "Vez\\u00e9rl\\u0151pult",\n            "url": "http://esportplay.hu/dashboard/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Vez\\u00e9rl\\u0151pult",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "TML m\\u0171velet"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menus_created_posts": {\n        "value": [\n            303\n        ],\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    },\n    "nav_menu_item[-6262287667853670000]": {\n        "value": {\n            "object_id": 303,\n            "object": "page",\n            "menu_item_parent": 0,\n            "position": 10,\n            "type": "post_type",\n            "title": "Fi\\u00f3k",\n            "url": "http://esportplay.hu/?page_id=303",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Fi\\u00f3k",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 14:40:49"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'cdb72871-6e3f-424c-b6d2-62c4742e7761', '', '', '2020-12-05 15:40:49', '2020-12-05 14:40:49', '', 0, 'http://esportplay.hu/?p=302', 0, 'customize_changeset', '', 0),
(303, 1, '2020-12-05 15:40:50', '2020-12-05 14:40:50', '<!-- wp:group -->\n<div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:cover {"url":"http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png","id":339,"hasParallax":true,"align":"center"} -->\n<div class="wp-block-cover aligncenter has-background-dim has-parallax" style="background-image:url(http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png)"><div class="wp-block-cover__inner-container"><!-- wp:paragraph {"align":"center","placeholder":"Írjunk címet…","fontSize":"large"} -->\n<p class="has-text-align-center has-large-font-size"></p>\n<!-- /wp:paragraph --></div></div>\n<!-- /wp:cover --></div></div>\n<!-- /wp:group -->\n\n<!-- wp:paragraph -->\n<p></p>\n<!-- /wp:paragraph -->', 'Fiók', '', 'publish', 'closed', 'closed', '', 'fiok', '', '', '2020-12-05 17:27:12', '2020-12-05 16:27:12', '', 194, 'http://esportplay.hu/?page_id=303', 0, 'page', '', 0),
(311, 1, '2020-12-05 16:44:47', '2020-12-05 15:44:47', '{\n    "clpt_template": {\n        "value": "businesscard",\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:44:47"\n    },\n    "clpt_logo": {\n        "value": "http://esportplay.hu/wp-content/uploads/2020/12/qwfqwfcqwqwx.png",\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:44:47"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '54031fe7-d413-4ae9-b464-ad6138e3ca5d', '', '', '2020-12-05 16:44:47', '2020-12-05 15:44:47', '', 0, 'http://esportplay.hu/2020/12/05/54031fe7-d413-4ae9-b464-ad6138e3ca5d/', 0, 'customize_changeset', '', 0),
(309, 1, '2020-12-05 15:40:50', '2020-12-05 14:40:50', '', 'Fiók', '', 'inherit', 'closed', 'closed', '', '303-revision-v1', '', '', '2020-12-05 15:40:50', '2020-12-05 14:40:50', '', 303, 'http://esportplay.hu/2020/12/05/303-revision-v1/', 0, 'revision', '', 0),
(310, 1, '2020-12-05 16:42:46', '2020-12-05 15:42:46', '{\n    "nav_menu_item[304]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:42:46"\n    },\n    "nav_menu_item[307]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:42:46"\n    },\n    "nav_menu_item[305]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:42:46"\n    },\n    "nav_menu_item[308]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:42:46"\n    },\n    "nav_menu_item[306]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:42:46"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'd5a43fe2-8512-4f26-bbfa-3044964c46e6', '', '', '2020-12-05 16:42:46', '2020-12-05 15:42:46', '', 0, 'http://esportplay.hu/2020/12/05/d5a43fe2-8512-4f26-bbfa-3044964c46e6/', 0, 'customize_changeset', '', 0),
(313, 1, '2020-12-05 16:45:18', '2020-12-05 15:45:18', '{\n    "clpt_bg_image": {\n        "value": "http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-1.png",\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:45:13"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'd6853ee0-0ee2-4e7f-ac10-a999293e30a4', '', '', '2020-12-05 16:45:18', '2020-12-05 15:45:18', '', 0, 'http://esportplay.hu/?p=313', 0, 'customize_changeset', '', 0),
(314, 1, '2020-12-05 16:47:18', '2020-12-05 15:47:18', '{\n    "nav_menu_item[-1911156666381072400]": {\n        "value": {\n            "object_id": 194,\n            "object": "page",\n            "menu_item_parent": 0,\n            "position": 6,\n            "type": "post_type",\n            "title": "Regisztr\\u00e1l",\n            "url": "http://esportplay.hu/regisztral/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Regisztr\\u00e1l",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:47:18"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'b243ef2b-05ca-442e-b134-75794177d4ff', '', '', '2020-12-05 16:47:18', '2020-12-05 15:47:18', '', 0, 'http://esportplay.hu/2020/12/05/b243ef2b-05ca-442e-b134-75794177d4ff/', 0, 'customize_changeset', '', 0),
(317, 1, '2020-12-05 16:56:27', '0000-00-00 00:00:00', '{\n    "clpt_template": {\n        "value": "",\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:56:27"\n    },\n    "clpt_potd": {\n        "value": "off",\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:56:27"\n    }\n}', '', '', 'auto-draft', 'closed', 'closed', '', 'b4117d32-3d9d-4a5b-b1b1-863f9d3ad135', '', '', '2020-12-05 16:56:27', '0000-00-00 00:00:00', '', 0, 'http://esportplay.hu/?p=317', 0, 'customize_changeset', '', 0),
(316, 1, '2020-12-05 16:47:27', '2020-12-05 15:47:27', '{\n    "nav_menu_item[315]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:47:27"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'e70d05b8-0e85-45e8-9902-435c1c3aa212', '', '', '2020-12-05 16:47:27', '2020-12-05 15:47:27', '', 0, 'http://esportplay.hu/2020/12/05/e70d05b8-0e85-45e8-9902-435c1c3aa212/', 0, 'customize_changeset', '', 0),
(318, 1, '2020-12-05 16:57:34', '2020-12-05 15:57:34', '{\n    "clpt_template": {\n        "value": "businesscard",\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 15:57:34"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '2eb193ba-f2b3-4a09-9971-94bb208c8e2f', '', '', '2020-12-05 16:57:34', '2020-12-05 15:57:34', '', 0, 'http://esportplay.hu/2020/12/05/2eb193ba-f2b3-4a09-9971-94bb208c8e2f/', 0, 'customize_changeset', '', 0),
(319, 1, '2020-12-05 17:03:21', '2020-12-05 16:03:21', '', 'FIÓK', '', 'trash', 'closed', 'closed', '', 'fiok-2__trashed', '', '', '2020-12-05 17:09:25', '2020-12-05 16:09:25', '', 0, 'http://esportplay.hu/?page_id=319', 0, 'page', '', 0),
(320, 1, '2020-12-05 17:03:21', '2020-12-05 16:03:21', '', 'BEJELENTKEZÉS', '', 'trash', 'closed', 'closed', '', 'login__trashed', '', '', '2020-12-05 17:09:12', '2020-12-05 16:09:12', '', 0, 'http://esportplay.hu/?page_id=320', 0, 'page', '', 0),
(321, 1, '2020-12-05 17:03:21', '2020-12-05 16:03:21', '', 'REGISZTRÁCIÓ', '', 'trash', 'closed', 'closed', '', 'regisztracio__trashed', '', '', '2020-12-05 17:09:31', '2020-12-05 16:09:31', '', 0, 'http://esportplay.hu/?page_id=321', 0, 'page', '', 0),
(322, 1, '2020-12-05 17:03:21', '2020-12-05 16:03:21', '{\n    "nav_menus_created_posts": {\n        "value": [\n            319,\n            320,\n            321\n        ],\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:03:21"\n    },\n    "nav_menu_item[-310411749784365060]": {\n        "value": {\n            "object_id": 319,\n            "object": "page",\n            "menu_item_parent": 0,\n            "position": 10,\n            "type": "post_type",\n            "title": "FI\\u00d3K",\n            "url": "http://esportplay.hu/?page_id=319",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "FI\\u00d3K",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:03:21"\n    },\n    "nav_menu_item[-1697264228368074800]": {\n        "value": {\n            "object_id": 320,\n            "object": "page",\n            "menu_item_parent": -310411749784365060,\n            "position": 11,\n            "type": "post_type",\n            "title": "BEJELENTKEZ\\u00c9S",\n            "url": "http://esportplay.hu/?page_id=320",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "BEJELENTKEZ\\u00c9S",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:03:21"\n    },\n    "nav_menu_item[-5783882576983824000]": {\n        "value": {\n            "object_id": 321,\n            "object": "page",\n            "menu_item_parent": -310411749784365060,\n            "position": 12,\n            "type": "post_type",\n            "title": "REGISZTR\\u00c1CI\\u00d3",\n            "url": "http://esportplay.hu/?page_id=321",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "REGISZTR\\u00c1CI\\u00d3",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:03:21"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'bef38478-2e51-41c7-bb34-a69b814e9407', '', '', '2020-12-05 17:03:21', '2020-12-05 16:03:21', '', 0, 'http://esportplay.hu/2020/12/05/bef38478-2e51-41c7-bb34-a69b814e9407/', 0, 'customize_changeset', '', 0),
(323, 1, '2020-12-05 17:03:21', '2020-12-05 16:03:21', '', 'FIÓK', '', 'inherit', 'closed', 'closed', '', '319-revision-v1', '', '', '2020-12-05 17:03:21', '2020-12-05 16:03:21', '', 319, 'http://esportplay.hu/2020/12/05/319-revision-v1/', 0, 'revision', '', 0),
(324, 1, '2020-12-05 17:03:21', '2020-12-05 16:03:21', '', 'BEJELENTKEZÉS', '', 'inherit', 'closed', 'closed', '', '320-revision-v1', '', '', '2020-12-05 17:03:21', '2020-12-05 16:03:21', '', 320, 'http://esportplay.hu/2020/12/05/320-revision-v1/', 0, 'revision', '', 0),
(325, 1, '2020-12-05 17:03:21', '2020-12-05 16:03:21', '', 'REGISZTRÁCIÓ', '', 'inherit', 'closed', 'closed', '', '321-revision-v1', '', '', '2020-12-05 17:03:21', '2020-12-05 16:03:21', '', 321, 'http://esportplay.hu/2020/12/05/321-revision-v1/', 0, 'revision', '', 0),
(331, 1, '2020-12-05 17:18:25', '2020-12-05 16:18:25', '{\n    "nav_menu_item[-3243162409080183000]": {\n        "value": {\n            "object_id": 303,\n            "object": "page",\n            "menu_item_parent": 328,\n            "position": 10,\n            "type": "post_type",\n            "title": "ADMIN",\n            "url": "http://esportplay.hu/fiok/",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "status": "publish",\n            "original_title": "Fi\\u00f3k",\n            "nav_menu_term_id": 51,\n            "_invalid": false,\n            "type_label": "Oldal"\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:18:25"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'e6d6d550-31a6-4c10-be42-e819422a530f', '', '', '2020-12-05 17:18:25', '2020-12-05 16:18:25', '', 0, 'http://esportplay.hu/2020/12/05/e6d6d550-31a6-4c10-be42-e819422a530f/', 0, 'customize_changeset', '', 0),
(329, 1, '2020-12-05 17:05:52', '0000-00-00 00:00:00', '{\n    "nav_menu_item[326]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:03:51"\n    },\n    "nav_menu_item[327]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:03:51"\n    },\n    "nav_menu_item[328]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:03:51"\n    },\n    "nav_menu_item[-2163005347017482200]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:04:51"\n    },\n    "nav_menu_item[-3243403597861439500]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:04:51"\n    },\n    "show_on_front": {\n        "value": "posts",\n        "type": "option",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:05:52"\n    }\n}', '', '', 'auto-draft', 'closed', 'closed', '', '38bd2d59-b339-4995-ad00-e471f0980204', '', '', '2020-12-05 17:05:52', '2020-12-05 16:05:52', '', 0, 'http://esportplay.hu/?p=329', 0, 'customize_changeset', '', 0),
(330, 1, '2020-12-05 17:18:09', '2020-12-05 16:18:09', '{\n    "nav_menu_item[326]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:18:09"\n    },\n    "nav_menu_item[327]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:18:09"\n    },\n    "nav_menu_item[328]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:18:09"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'ec0bbe62-0fb1-40f4-9d0b-1d1198deccfb', '', '', '2020-12-05 17:18:09', '2020-12-05 16:18:09', '', 0, 'http://esportplay.hu/2020/12/05/ec0bbe62-0fb1-40f4-9d0b-1d1198deccfb/', 0, 'customize_changeset', '', 0),
(344, 1, '2020-12-05 17:52:57', '2020-12-05 16:52:57', '', '1606485698267', '', 'inherit', 'open', 'closed', '', '1606485698267', '', '', '2020-12-05 17:52:57', '2020-12-05 16:52:57', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1606485698267.jpg', 0, 'attachment', 'image/jpeg', 0),
(333, 1, '2020-12-05 17:19:17', '2020-12-05 16:19:17', '{\n    "nav_menu_item[232]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 17,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/sponsor/",\n            "title": "PARTNEREINK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 6,\n            "status": "publish",\n            "original_title": "Sponsor",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:19:17"\n    },\n    "nav_menu_item[231]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 74,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/streams/",\n            "title": "STREAMEK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 7,\n            "status": "publish",\n            "original_title": "Streams",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:19:17"\n    },\n    "nav_menu_item[235]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 67,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/gallery/",\n            "title": "GALL\\u00c9RIA",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 8,\n            "status": "publish",\n            "original_title": "Gallery",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:19:17"\n    },\n    "nav_menu_item[236]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 65,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/about/",\n            "title": "R\\u00d3LUNK",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 9,\n            "status": "publish",\n            "original_title": "About",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:19:17"\n    },\n    "nav_menu_item[332]": {\n        "value": {\n            "menu_item_parent": 218,\n            "object_id": 303,\n            "object": "page",\n            "type": "post_type",\n            "type_label": "Oldal",\n            "url": "http://esportplay.hu/fiok/",\n            "title": "ADMIN",\n            "target": "",\n            "attr_title": "",\n            "description": "",\n            "classes": "",\n            "xfn": "",\n            "nav_menu_term_id": 51,\n            "position": 10,\n            "status": "publish",\n            "original_title": "Fi\\u00f3k",\n            "_invalid": false\n        },\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:19:17"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '3f7602b3-eb45-4293-87c7-f4c2e6d305a7', '', '', '2020-12-05 17:19:17', '2020-12-05 16:19:17', '', 0, 'http://esportplay.hu/2020/12/05/3f7602b3-eb45-4293-87c7-f4c2e6d305a7/', 0, 'customize_changeset', '', 0),
(335, 1, '2020-12-05 17:23:14', '2020-12-05 16:23:14', '', 'qc-1', '', 'inherit', 'open', 'closed', '', 'qc-1', '', '', '2020-12-05 17:23:14', '2020-12-05 16:23:14', '', 303, 'http://esportplay.hu/wp-content/uploads/2020/12/qc-1.png', 0, 'attachment', 'image/png', 0),
(336, 1, '2020-12-05 17:23:44', '2020-12-05 16:23:44', '<!-- wp:image {"id":335,"sizeSlug":"large"} -->\n<figure class="wp-block-image size-large"><img src="http://esportplay.hu/wp-content/uploads/2020/12/qc-1-1024x475.png" alt="" class="wp-image-335"/></figure>\n<!-- /wp:image -->', 'Fiók', '', 'inherit', 'closed', 'closed', '', '303-revision-v1', '', '', '2020-12-05 17:23:44', '2020-12-05 16:23:44', '', 303, 'http://esportplay.hu/2020/12/05/303-revision-v1/', 0, 'revision', '', 0),
(337, 1, '2020-12-05 17:23:56', '2020-12-05 16:23:56', '<!-- wp:cover {"url":"http://esportplay.hu/wp-content/uploads/2020/12/qc-1-1024x475.png","id":335} -->\n<div class="wp-block-cover has-background-dim" style="background-image:url(http://esportplay.hu/wp-content/uploads/2020/12/qc-1-1024x475.png)"><div class="wp-block-cover__inner-container"><!-- wp:paragraph {"align":"center","placeholder":"Írjunk címet…","fontSize":"large"} -->\n<p class="has-text-align-center has-large-font-size"></p>\n<!-- /wp:paragraph --></div></div>\n<!-- /wp:cover -->', 'Fiók', '', 'inherit', 'closed', 'closed', '', '303-revision-v1', '', '', '2020-12-05 17:23:56', '2020-12-05 16:23:56', '', 303, 'http://esportplay.hu/2020/12/05/303-revision-v1/', 0, 'revision', '', 0),
(338, 1, '2020-12-05 17:24:13', '2020-12-05 16:24:13', '<!-- wp:cover {"url":"http://esportplay.hu/wp-content/uploads/2020/12/qc-1-1024x475.png","id":335,"hasParallax":true,"align":"center"} -->\n<div class="wp-block-cover aligncenter has-background-dim has-parallax" style="background-image:url(http://esportplay.hu/wp-content/uploads/2020/12/qc-1-1024x475.png)"><div class="wp-block-cover__inner-container"><!-- wp:paragraph {"align":"center","placeholder":"Írjunk címet…","fontSize":"large"} -->\n<p class="has-text-align-center has-large-font-size"></p>\n<!-- /wp:paragraph --></div></div>\n<!-- /wp:cover -->', 'Fiók', '', 'inherit', 'closed', 'closed', '', '303-revision-v1', '', '', '2020-12-05 17:24:13', '2020-12-05 16:24:13', '', 303, 'http://esportplay.hu/2020/12/05/303-revision-v1/', 0, 'revision', '', 0),
(339, 1, '2020-12-05 17:24:25', '2020-12-05 16:24:25', '', '77398019_1050496535281850_3009940701971480576_o-4-1', '', 'inherit', 'open', 'closed', '', '77398019_1050496535281850_3009940701971480576_o-4-1', '', '', '2020-12-05 17:24:25', '2020-12-05 16:24:25', '', 303, 'http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png', 0, 'attachment', 'image/png', 0),
(341, 1, '2020-12-05 17:27:12', '2020-12-05 16:27:12', '<!-- wp:group -->\n<div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:cover {"url":"http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png","id":339,"hasParallax":true,"align":"center"} -->\n<div class="wp-block-cover aligncenter has-background-dim has-parallax" style="background-image:url(http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png)"><div class="wp-block-cover__inner-container"><!-- wp:paragraph {"align":"center","placeholder":"Írjunk címet…","fontSize":"large"} -->\n<p class="has-text-align-center has-large-font-size"></p>\n<!-- /wp:paragraph --></div></div>\n<!-- /wp:cover --></div></div>\n<!-- /wp:group -->\n\n<!-- wp:paragraph -->\n<p></p>\n<!-- /wp:paragraph -->', 'Fiók', '', 'inherit', 'closed', 'closed', '', '303-revision-v1', '', '', '2020-12-05 17:27:12', '2020-12-05 16:27:12', '', 303, 'http://esportplay.hu/2020/12/05/303-revision-v1/', 0, 'revision', '', 0),
(340, 1, '2020-12-05 17:26:10', '2020-12-05 16:26:10', '<!-- wp:group -->\n<div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:cover {"url":"http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png","id":339,"align":"center"} -->\n<div class="wp-block-cover aligncenter has-background-dim" style="background-image:url(http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png)"><div class="wp-block-cover__inner-container"><!-- wp:paragraph {"align":"center","placeholder":"Írjunk címet…","fontSize":"large"} -->\n<p class="has-text-align-center has-large-font-size"></p>\n<!-- /wp:paragraph --></div></div>\n<!-- /wp:cover --></div></div>\n<!-- /wp:group -->\n\n<!-- wp:paragraph -->\n<p></p>\n<!-- /wp:paragraph -->', 'Fiók', '', 'inherit', 'closed', 'closed', '', '303-revision-v1', '', '', '2020-12-05 17:26:10', '2020-12-05 16:26:10', '', 303, 'http://esportplay.hu/2020/12/05/303-revision-v1/', 0, 'revision', '', 0),
(342, 1, '2020-12-05 17:27:14', '2020-12-05 16:27:14', '<!-- wp:group -->\n<div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:cover {"url":"http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png","id":339,"hasParallax":true,"align":"center"} -->\n<div class="wp-block-cover aligncenter has-background-dim has-parallax" style="background-image:url(http://esportplay.hu/wp-content/uploads/2020/12/77398019_1050496535281850_3009940701971480576_o-4-1.png)"><div class="wp-block-cover__inner-container"><!-- wp:paragraph {"align":"center","placeholder":"Írjunk címet…","fontSize":"large"} -->\n<p class="has-text-align-center has-large-font-size"></p>\n<!-- /wp:paragraph --></div></div>\n<!-- /wp:cover --></div></div>\n<!-- /wp:group -->\n\n<!-- wp:paragraph -->\n<p></p>\n<!-- /wp:paragraph -->', 'Fiók', '', 'inherit', 'closed', 'closed', '', '303-autosave-v1', '', '', '2020-12-05 17:27:14', '2020-12-05 16:27:14', '', 303, 'http://esportplay.hu/2020/12/05/303-autosave-v1/', 0, 'revision', '', 0),
(343, 1, '2020-12-05 17:32:02', '2020-12-05 16:32:02', '{\n    "nav_menu_item[332]": {\n        "value": false,\n        "type": "nav_menu_item",\n        "user_id": 1,\n        "date_modified_gmt": "2020-12-05 16:32:02"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '5a2d5a4a-46e6-4c21-b82f-0d0d2b0957a3', '', '', '2020-12-05 17:32:02', '2020-12-05 16:32:02', '', 0, 'http://esportplay.hu/2020/12/05/5a2d5a4a-46e6-4c21-b82f-0d0d2b0957a3/', 0, 'customize_changeset', '', 0),
(345, 1, '2020-12-05 17:54:06', '2020-12-05 16:54:06', '', '1605790863194', '', 'inherit', 'open', 'closed', '', '1605790863194', '', '', '2020-12-05 17:54:06', '2020-12-05 16:54:06', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1605790863194.jpg', 0, 'attachment', 'image/jpeg', 0),
(346, 1, '2020-12-05 17:54:55', '2020-12-05 16:54:55', '', '1591557903247', '', 'inherit', 'open', 'closed', '', '1591557903247', '', '', '2020-12-05 17:54:55', '2020-12-05 16:54:55', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1591557903247.jpg', 0, 'attachment', 'image/jpeg', 0),
(347, 1, '2020-12-05 17:55:56', '2020-12-05 16:55:56', '', '1605697469945', '', 'inherit', 'open', 'closed', '', '1605697469945', '', '', '2020-12-05 17:55:56', '2020-12-05 16:55:56', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1605697469945.jpg', 0, 'attachment', 'image/jpeg', 0),
(348, 1, '2020-12-05 17:56:53', '2020-12-05 16:56:53', '', '1605650349538', '', 'inherit', 'open', 'closed', '', '1605650349538', '', '', '2020-12-05 17:56:53', '2020-12-05 16:56:53', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1605650349538.png', 0, 'attachment', 'image/png', 0),
(349, 1, '2020-12-05 17:58:07', '2020-12-05 16:58:07', '', '1605951181721', '', 'inherit', 'open', 'closed', '', '1605951181721', '', '', '2020-12-05 17:58:07', '2020-12-05 16:58:07', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1605951181721.png', 0, 'attachment', 'image/png', 0),
(350, 1, '2020-12-05 17:59:08', '2020-12-05 16:59:08', '', '1605446609632', '', 'inherit', 'open', 'closed', '', '1605446609632', '', '', '2020-12-05 17:59:08', '2020-12-05 16:59:08', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1605446609632.jpg', 0, 'attachment', 'image/jpeg', 0),
(351, 1, '2020-12-05 18:00:00', '2020-12-05 17:00:00', '', '1605895092964', '', 'inherit', 'open', 'closed', '', '1605895092964', '', '', '2020-12-05 18:00:00', '2020-12-05 17:00:00', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1605895092964.png', 0, 'attachment', 'image/png', 0),
(352, 1, '2020-12-05 18:01:15', '2020-12-05 17:01:15', '', '1599839767029', '', 'inherit', 'open', 'closed', '', '1599839767029', '', '', '2020-12-05 18:01:15', '2020-12-05 17:01:15', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1599839767029.png', 0, 'attachment', 'image/png', 0),
(353, 1, '2020-12-05 18:02:05', '2020-12-05 17:02:05', '', '1592040949034', '', 'inherit', 'open', 'closed', '', '1592040949034', '', '', '2020-12-05 18:02:05', '2020-12-05 17:02:05', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1592040949034.png', 0, 'attachment', 'image/png', 0),
(354, 1, '2020-12-05 18:02:58', '2020-12-05 17:02:58', '', '1605813791071', '', 'inherit', 'open', 'closed', '', '1605813791071', '', '', '2020-12-05 18:02:58', '2020-12-05 17:02:58', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1605813791071.png', 0, 'attachment', 'image/png', 0),
(355, 1, '2020-12-05 18:04:47', '2020-12-05 17:04:47', '', '1605294552471', '', 'inherit', 'open', 'closed', '', '1605294552471', '', '', '2020-12-05 18:04:47', '2020-12-05 17:04:47', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1605294552471.png', 0, 'attachment', 'image/png', 0),
(356, 1, '2020-12-05 18:07:44', '2020-12-05 17:07:44', '', '1604848919602', '', 'inherit', 'open', 'closed', '', '1604848919602', '', '', '2020-12-05 18:07:44', '2020-12-05 17:07:44', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1604848919602.jpg', 0, 'attachment', 'image/jpeg', 0),
(357, 1, '2020-12-05 18:08:56', '2020-12-05 17:08:56', '', '1605980084802', '', 'inherit', 'open', 'closed', '', '1605980084802', '', '', '2020-12-05 18:08:56', '2020-12-05 17:08:56', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1605980084802.png', 0, 'attachment', 'image/png', 0),
(358, 1, '2020-12-05 18:10:05', '2020-12-05 17:10:05', '', '1605982928427', '', 'inherit', 'open', 'closed', '', '1605982928427', '', '', '2020-12-05 18:10:05', '2020-12-05 17:10:05', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1605982928427.jpg', 0, 'attachment', 'image/jpeg', 0),
(359, 1, '2020-12-05 18:14:02', '2020-12-05 17:14:02', '', '67061218_2651847281506495_3289316139754061824_n', '', 'inherit', 'open', 'closed', '', '67061218_2651847281506495_3289316139754061824_n', '', '', '2020-12-05 18:14:02', '2020-12-05 17:14:02', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/67061218_2651847281506495_3289316139754061824_n.jpg', 0, 'attachment', 'image/jpeg', 0),
(360, 1, '2020-12-05 18:16:13', '2020-12-05 17:16:13', '', '79405682_2955950724429481_3204597050847002624_o', '', 'inherit', 'open', 'closed', '', '79405682_2955950724429481_3204597050847002624_o', '', '', '2020-12-05 18:16:13', '2020-12-05 17:16:13', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/79405682_2955950724429481_3204597050847002624_o.jpg', 0, 'attachment', 'image/jpeg', 0),
(361, 1, '2020-12-05 18:47:20', '2020-12-05 17:47:20', '', 'djuza', '', 'inherit', 'open', 'closed', '', 'djuza', '', '', '2020-12-05 18:47:20', '2020-12-05 17:47:20', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/djuza.png', 0, 'attachment', 'image/png', 0),
(362, 1, '2020-12-05 19:14:34', '2020-12-05 18:14:34', 'LG Ultragear Warmup Kupa 2020 - 2nd', 'LG Ultragear Warmup Kupa 2020 - 2nd', 'LG Ultragear Warmup Kupa 2020 - 2nd', 'inherit', 'open', 'closed', '', 'asd-2', '', '', '2020-12-05 19:14:51', '2020-12-05 18:14:51', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/asd-1.png', 0, 'attachment', 'image/png', 0),
(367, 1, '2020-12-05 19:34:59', '2020-12-05 18:34:59', '', 'hrcs2', '', 'inherit', 'open', 'closed', '', 'hrcs2', '', '', '2020-12-05 19:34:59', '2020-12-05 18:34:59', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/hrcs2.png', 0, 'attachment', 'image/png', 0),
(369, 1, '2020-12-05 19:36:42', '2020-12-05 18:36:42', '', 'logo-e1hu', '', 'inherit', 'open', 'closed', '', 'logo-e1hu', '', '', '2020-12-05 19:36:42', '2020-12-05 18:36:42', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/logo-e1hu.png', 0, 'attachment', 'image/png', 0),
(370, 1, '2020-12-05 19:37:23', '2020-12-05 18:37:23', '', '1f382cebb409e9d5b9af36ab3c6e3dd02085d66d', '', 'inherit', 'open', 'closed', '', '1f382cebb409e9d5b9af36ab3c6e3dd02085d66d', '', '', '2020-12-05 19:37:23', '2020-12-05 18:37:23', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/1f382cebb409e9d5b9af36ab3c6e3dd02085d66d.png', 0, 'attachment', 'image/png', 0),
(371, 1, '2020-12-05 19:46:22', '2020-12-05 18:46:22', '', '0moGWusn_400x400', '', 'inherit', 'open', 'closed', '', '0mogwusn_400x400', '', '', '2020-12-05 19:46:22', '2020-12-05 18:46:22', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/0moGWusn_400x400.jpg', 0, 'attachment', 'image/jpeg', 0),
(372, 1, '2020-12-05 19:48:30', '2020-12-05 18:48:30', '', '-Y1xbB3zPGFWArTjRZPRGb', '', 'inherit', 'open', 'closed', '', 'y1xbb3zpgfwartjrzprgb', '', '', '2020-12-05 19:48:30', '2020-12-05 18:48:30', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/Y1xbB3zPGFWArTjRZPRGb.png', 0, 'attachment', 'image/png', 0),
(375, 1, '2020-12-05 19:54:12', '2020-12-05 18:54:12', '', '846ab15d-f0f3-4e41-89b2-176ec0e560c3-profile_image-300x300', '', 'inherit', 'open', 'closed', '', '846ab15d-f0f3-4e41-89b2-176ec0e560c3-profile_image-300x300', '', '', '2020-12-05 19:54:12', '2020-12-05 18:54:12', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/846ab15d-f0f3-4e41-89b2-176ec0e560c3-profile_image-300x300-1.png', 0, 'attachment', 'image/png', 0),
(376, 1, '2020-12-05 20:01:13', '2020-12-05 19:01:13', '', 'DdbZTQYVQAAMPMP', '', 'inherit', 'open', 'closed', '', 'ddbztqyvqaampmp', '', '', '2020-12-05 20:01:13', '2020-12-05 19:01:13', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/DdbZTQYVQAAMPMP.jpg', 0, 'attachment', 'image/jpeg', 0),
(377, 1, '2020-12-05 20:04:32', '2020-12-05 19:04:32', '', 'VrLzVW10_400x400', '', 'inherit', 'open', 'closed', '', 'vrlzvw10_400x400', '', '', '2020-12-05 20:04:32', '2020-12-05 19:04:32', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/VrLzVW10_400x400.png', 0, 'attachment', 'image/png', 0),
(379, 1, '2020-12-05 20:07:51', '2020-12-05 19:07:51', '', 'asdasd', '', 'inherit', 'open', 'closed', '', 'asdasd', '', '', '2020-12-05 20:07:51', '2020-12-05 19:07:51', '', 0, 'http://esportplay.hu/wp-content/uploads/2020/12/asdasd.png', 0, 'attachment', 'image/png', 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_signups`
--

CREATE TABLE IF NOT EXISTS `wp_signups` (
  `signup_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `domain` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `path` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `title` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `activation_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `meta` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`signup_id`),
  KEY `activation_key` (`activation_key`),
  KEY `user_email` (`user_email`),
  KEY `user_login_email` (`user_login`,`user_email`),
  KEY `domain_path` (`domain`(140),`path`(51))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_term_relationships`
--

CREATE TABLE IF NOT EXISTS `wp_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- A tábla adatainak kiíratása `wp_term_relationships`
--

INSERT INTO `wp_term_relationships` (`object_id`, `term_taxonomy_id`, `term_order`) VALUES
(1, 1, 0),
(218, 51, 0),
(220, 50, 0),
(221, 49, 0),
(222, 49, 0),
(223, 49, 0),
(224, 49, 0),
(225, 52, 0),
(226, 52, 0),
(116, 36, 0),
(116, 37, 0),
(116, 38, 0),
(116, 40, 0),
(116, 41, 0),
(116, 43, 0),
(116, 44, 0),
(116, 45, 0),
(116, 47, 0),
(116, 48, 0),
(228, 1, 0),
(122, 40, 0),
(122, 41, 0),
(122, 44, 0),
(122, 37, 0),
(125, 36, 0),
(125, 37, 0),
(125, 38, 0),
(125, 40, 0),
(125, 41, 0),
(125, 43, 0),
(131, 40, 0),
(131, 41, 0),
(131, 42, 0),
(131, 43, 0),
(131, 38, 0),
(133, 40, 0),
(133, 41, 0),
(133, 38, 0),
(135, 40, 0),
(135, 43, 0),
(135, 44, 0),
(135, 37, 0),
(229, 51, 0),
(230, 51, 0),
(231, 51, 0),
(232, 51, 0),
(233, 51, 0),
(234, 51, 0),
(235, 51, 0),
(236, 51, 0),
(237, 50, 0),
(238, 50, 0),
(239, 50, 0),
(240, 50, 0),
(241, 52, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_term_taxonomy`
--

CREATE TABLE IF NOT EXISTS `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=53 ;

--
-- A tábla adatainak kiíratása `wp_term_taxonomy`
--

INSERT INTO `wp_term_taxonomy` (`term_taxonomy_id`, `term_id`, `taxonomy`, `description`, `parent`, `count`) VALUES
(1, 1, 'category', '', 0, 2),
(36, 36, 'category', '', 0, 2),
(37, 37, 'category', '', 0, 4),
(38, 38, 'category', '', 0, 4),
(39, 39, 'category', '', 0, 0),
(40, 40, 'post_tag', '', 0, 6),
(41, 41, 'post_tag', '', 0, 5),
(42, 42, 'post_tag', '', 0, 1),
(43, 43, 'post_tag', '', 0, 4),
(44, 44, 'post_tag', '', 0, 3),
(45, 45, 'post_tag', '', 0, 1),
(46, 46, 'post_tag', '', 0, 0),
(47, 47, 'post_tag', '', 0, 1),
(48, 48, 'post_tag', '', 0, 1),
(49, 49, 'nav_menu', '', 0, 4),
(50, 50, 'nav_menu', '', 0, 5),
(51, 51, 'nav_menu', '', 0, 9),
(52, 52, 'nav_menu', '', 0, 3);

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_termmeta`
--

CREATE TABLE IF NOT EXISTS `wp_termmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_terms`
--

CREATE TABLE IF NOT EXISTS `wp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=53 ;

--
-- A tábla adatainak kiíratása `wp_terms`
--

INSERT INTO `wp_terms` (`term_id`, `name`, `slug`, `term_group`) VALUES
(1, 'Egyéb kategória', 'egyeb', 0),
(36, 'ESPORTS', 'esports', 0),
(37, 'GAMING', 'gaming', 0),
(38, 'NEWS', 'news', 0),
(39, 'Uncategorized', 'uncategorized', 0),
(40, 'esports', 'esports', 0),
(41, 'gaming', 'gaming', 0),
(42, 'player', 'player', 0),
(43, 'player-1', 'player-1', 0),
(44, 'player-2', 'player-2', 0),
(45, 'ragebite', 'ragebite', 0),
(46, 'team-flawed-bot', 'team-flawed-bot', 0),
(47, 'theme', 'theme', 0),
(48, 'wordpress', 'wordpress', 0),
(49, 'FOOTER DESNI', 'footer-desni', 0),
(50, 'Footer LEVI', 'footer-levi', 0),
(51, 'Header', 'header', 0),
(52, 'Links', 'links', 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_usermeta`
--

CREATE TABLE IF NOT EXISTS `wp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=68 ;

--
-- A tábla adatainak kiíratása `wp_usermeta`
--

INSERT INTO `wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES
(1, 1, 'nickname', 'admin'),
(2, 1, 'first_name', ''),
(3, 1, 'last_name', ''),
(4, 1, 'description', ''),
(5, 1, 'rich_editing', 'true'),
(6, 1, 'syntax_highlighting', 'true'),
(7, 1, 'comment_shortcuts', 'false'),
(8, 1, 'admin_color', 'fresh'),
(9, 1, 'use_ssl', '0'),
(10, 1, 'show_admin_bar_front', 'true'),
(11, 1, 'locale', ''),
(12, 1, 'wp_capabilities', 'a:1:{s:13:"administrator";b:1;}'),
(13, 1, 'wp_user_level', '10'),
(14, 1, 'dismissed_wp_pointers', 'theme_editor_notice'),
(15, 1, 'show_welcome_panel', '1'),
(47, 3, 'nickname', 'itzatesz'),
(48, 3, 'first_name', ''),
(49, 3, 'last_name', ''),
(50, 3, 'description', ''),
(51, 3, 'rich_editing', 'true'),
(52, 3, 'syntax_highlighting', 'true'),
(17, 1, 'wp_dashboard_quick_press_last_post_id', '4'),
(18, 1, 'community-events-location', 'a:1:{s:2:"ip";s:12:"84.236.111.0";}'),
(41, 1, 'wp_user-settings', 'libraryContent=browse'),
(42, 1, 'wp_user-settings-time', '1607187832'),
(43, 1, 'nav_menu_recently_edited', '49'),
(44, 1, 'managenav-menuscolumnshidden', 'a:5:{i:0;s:11:"link-target";i:1;s:11:"css-classes";i:2;s:3:"xfn";i:3;s:11:"description";i:4;s:15:"title-attribute";}'),
(45, 1, 'metaboxhidden_nav-menus', 'a:1:{i:0;s:12:"add-post_tag";}'),
(53, 3, 'comment_shortcuts', 'false'),
(54, 3, 'admin_color', 'sunrise'),
(55, 3, 'use_ssl', '0'),
(56, 3, 'show_admin_bar_front', 'true'),
(57, 3, 'locale', ''),
(58, 3, 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'),
(59, 3, 'wp_user_level', '0'),
(60, 3, 'dismissed_wp_pointers', ''),
(61, 3, 'default_password_nag', ''),
(63, 1, 'session_tokens', 'a:3:{s:64:"78d6c4b5fdf2b38017db5ac3a133278eac036c28013da23bf04f45052670be41";a:4:{s:10:"expiration";i:1608392487;s:2:"ip";s:14:"84.236.111.159";s:2:"ua";s:114:"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.66 Safari/537.36";s:5:"login";i:1607182887;}s:64:"332655089b537c94e835a908dda459813abca8f7a010d305933ae06cd9671c9b";a:4:{s:10:"expiration";i:1608392545;s:2:"ip";s:14:"84.236.111.159";s:2:"ua";s:114:"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.66 Safari/537.36";s:5:"login";i:1607182945;}s:64:"c803480f4dfe99fcb3b67ac6a93ee49d2ac9619c705157bd7b727d3dc656342e";a:4:{s:10:"expiration";i:1608394113;s:2:"ip";s:14:"84.236.111.159";s:2:"ua";s:114:"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.66 Safari/537.36";s:5:"login";i:1607184513;}}'),
(64, 1, 'meta-box-order_dashboard', 'a:4:{s:6:"normal";s:60:"dashboard_site_health,dashboard_right_now,dashboard_activity";s:4:"side";s:39:"dashboard_quick_press,dashboard_primary";s:7:"column3";s:0:"";s:7:"column4";s:0:"";}'),
(66, 3, 'wp_user-settings', 'mfold=o'),
(67, 3, 'wp_user-settings-time', '1607184808');

-- --------------------------------------------------------

--
-- Tábla szerkezet: `wp_users`
--

CREATE TABLE IF NOT EXISTS `wp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci AUTO_INCREMENT=4 ;

--
-- A tábla adatainak kiíratása `wp_users`
--

INSERT INTO `wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES
(1, 'admin', '$P$Bz5CQm8mPXFls1LozQ19A.yZ9SgHS81', 'admin', 'kissattilak@gmail.com', 'http://esportplay.hu', '2020-12-05 10:40:40', '', 0, 'admin'),
(3, 'itzatesz', '$P$BV0VRwZjD9akFV6zdrapZ2nNnA942e/', 'itzatesz', 'ateszkvideo@gmail.com', '', '2020-12-05 14:41:39', '', 0, 'itzatesz');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

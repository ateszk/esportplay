<?php

require_once(ABSPATH . '/wp-admin/includes/upgrade.php');

{
	global $wpdb;

	$prefix = $wpdb->prefix . 'pixiefreak_';
	$tables = [
		[
			'tablename' => 'global_settings',
			'sql' => "CREATE TABLE `{$prefix}global_settings` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `module_name` VARCHAR(255) NOT NULL,
        `key` VARCHAR(255),
        `value` TEXT,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)"
		],
		[
			'tablename' => 'about',
			'sql'   => "CREATE TABLE `{$prefix}about` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `cover` VARCHAR(500) NULL,
        `banner` VARCHAR(500) NULL,
        `description` TEXT,
        `stats` TEXT,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)"
		],
		[
			'tablename' => 'about_staff',
			'sql'  => "CREATE TABLE `{$prefix}about_staff` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `label` VARCHAR(500) NULL,
        `name` VARCHAR(500) NULL,
        `role` VARCHAR(500),
        `socials` TEXT,
        `avatar` VARCHAR(1000),
        `staff_category_id` int(11),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)"
		],
		[
			'tablename' => 'about_staff_category',
			'sql'       => "CREATE TABLE `{$prefix}about_staff_category` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(500) NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)"
		],
		[
			'tablename' => 'sponsor',
			'sql'       => "CREATE TABLE `{$prefix}sponsor` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(500) NULL,
        `logo` VARCHAR(500) NULL,
        `url` VARCHAR(500),
        `about` TEXT,
        `social` TEXT,
        `type` int(11),
        `order_number` int(11) DEFAULT 0,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename'     => 'gear',
			'sql'           => "CREATE TABLE `{$prefix}gear` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(500) NULL,
        `type` INT(11),
        `image` VARCHAR(500),
        `link` VARCHAR(500),
        `recommended` INT(11),
        `order_number` INT(11) DEFAULT 0,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename'     => 'player_gear',
			'sql'           => "CREATE TABLE `{$prefix}player_gear` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `player_id` INT(11),
        `gear_id` INT(11),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename'     => 'stream',
			'sql'           => "CREATE TABLE `{$prefix}stream` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `title` VARCHAR(1000) NULL,
        `subtitle` VARCHAR(1000) NULL,
        `slug` VARCHAR(1000) NULL,
        `thumbnail` VARCHAR(1000),
        `link` VARCHAR(1000),
        `is_online` INT(11),
        `view` int(11) DEFAULT 0,
        `order_number` int(11) DEFAULT 0,
        `type` int(2) DEFAULT  1,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename'     => 'gallery',
			'sql'           => "CREATE TABLE `{$prefix}gallery` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `gallery_category_id` INT(11) DEFAULT 1,
        `image` VARCHAR(1000) NULL,
        `slug` VARCHAR(1000),
        `order_number` int(11) DEFAULT 0,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename'     => 'gallery_category',
			'sql'           => "CREATE TABLE `{$prefix}gallery_category` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(500) NULL,
        `slug` VARCHAR(1000),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],

		[
			'tablename' => 'team',
			'sql'       => "CREATE TABLE `{$prefix}team` (
            `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
            `name` VARCHAR(500) NULL,
            `slug` VARCHAR(1000),
            `game_id` INT(11) NOT NULL,
            `team_logo` VARCHAR(1000),
            `cover` VARCHAR(1000),
            `thumbnail` VARCHAR (1000),
            `stats` TEXT,
            `about` TEXT,
            `my_team` INT(1),
            `year_founded` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
            `country` VARCHAR(12),
            `social` TEXT,
            `order_number` INT(11) DEFAULT 0,
            `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'team_player',
			'sql'       => "CREATE TABLE `{$prefix}team_player` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `team_id` INT(11),
        `player_id` INT(11),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'team_stream',
			'sql'       => "CREATE TABLE `{$prefix}team_stream` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `team_id` INT(11),
        `stream_id` INT(11),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'player',
			'sql'       => "CREATE TABLE `{$prefix}player` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `first_name` VARCHAR(500) NULL,
        `last_name` VARCHAR(500),
        `nickname` VARCHAR(500),
        `role` VARCHAR(255),
        `team_id` INT(11) NOT NULL,
        `avatar` VARCHAR(1000),
        `avatar_transparent` VARCHAR(1000),
        `banner` VARCHAR(1000) NULL,
        `slug` VARCHAR(1000),
        `thumbnail` VARCHAR (1000),
        `cover` VARCHAR (1000) DEFAULT NULL,
        `stats` TEXT,
        `biography` TEXT,
        `country` VARCHAR(15),
        `birth_date` VARCHAR(255) DEFAULT '0',
        `social` TEXT,
        `order_number` INT(11) DEFAULT 0,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'player_stream',
			'sql'       => "CREATE TABLE `{$prefix}player_stream` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `player_id` INT(11),
        `stream_id` INT(11),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'game',
			'sql'       => "CREATE TABLE `{$prefix}game` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(500) NULL,
        `slug` VARCHAR(1000),
        `thumbnail` VARCHAR(1000),
        `cover` VARCHAR(1000),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'achievement',
			'sql'       => "CREATE TABLE `{$prefix}achievement` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(500) NULL,
        `title` VARCHAR(1000),
        `slug` VARCHAR(1000),
        `thumbnail` VARCHAR(1000),
        `order_number` INT(11) DEFAULT 0,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'team_achievement',
			'sql'       => "CREATE TABLE `{$prefix}team_achievement` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `team_id` INT(11),
        `achievement_id` INT(11),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'tournament',
			'sql'       => "CREATE TABLE `{$prefix}tournament` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(500) NULL,
        `slug` VARCHAR(1000),
        `cover` VARCHAR(1000),
        `banner` VARCHAR(500) NULL,
        `logo` VARCHAR(1000),
        `thumbnail` VARCHAR(500),
        `location` VARCHAR (1000),
        `start_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `game_id` INT(11) NOT NULL,
        `about` TEXT,
        `social` TEXT,
        `group_number` INT(11) DEFAULT NULL,
        `team_number` INT(11) DEFAULT NULL,
        `prize_pool` INT(11) DEFAULT NULL,
        `random_rule` TEXT,
        `status` INT(2),
        `brackets` TEXT,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'tournament_group',
			'sql'       => "CREATE TABLE `{$prefix}tournament_group` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `tournament_id` INT(11),
        `name` VARCHAR(500) NULL,
        `order_number` INT(11) DEFAULT 0,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'tournament_team',
			'sql'       => "CREATE TABLE `{$prefix}tournament_team` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `tournament_id` INT(11),
        `team_id` INT(11),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'tournament_group_team',
			'sql'       => "CREATE TABLE `{$prefix}tournament_group_team` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `tournament_id` INT(11),
        `tournament_group_id` INT(11),
        `tournament_group_team_id` INT(11),
        `win` INT(11),
        `loss` INT(11),
        `draw` INT(11),
        `point` INT(11),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'match',
			'sql'       => "CREATE TABLE `{$prefix}match` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `game_id` INT(11) NOT NULL,
        `slug` VARCHAR(1000),
        `start_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `tournament_id` INT(11) DEFAULT 0,
        `team_a_id` INT(11),
        `team_a_name` VARCHAR(1000) NULL,
        `team_a_logo` VARCHAR(1000) NULL,
        `team_a_result` INT(11) NULL DEFAULT NULL,
        `team_b_id` INT(11),
        `team_b_name` VARCHAR(1000) NULL,
        `team_b_logo` VARCHAR(1000) NULL,
        `team_b_result` INT(11) NULL DEFAULT NULL,
        `status` INT(2),
        `cta_match_text` VARCHAR(1000),
        `cta_match_link` VARCHAR(500),
        `stream_id` INT(11) DEFAULT  NULL,
        `type` INT(2),
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		],
		[
			'tablename' => 'slider',
			'sql'       => "CREATE TABLE `{$prefix}slider` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `heading_text` VARCHAR(500) NULL,
        `tag` VARCHAR(500) NULL,
        `image` VARCHAR(500),
        `thumbnail` VARCHAR(500),
        `cta_text` VARCHAR(500),
        `cta_link` VARCHAR(500),
        `order_number` INT(11) DEFAULT 0,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP)",
		]
	];


	foreach ($tables as $table) {

		$tableName = $prefix . $table['tablename'];
		if (empty($table['tablename']) || $wpdb->get_var("SHOW TABLES LIKE '{$tableName}'") === $tableName) {
			continue;
		}

		dbDelta($table['sql'] . $wpdb->get_charset_collate() . " ;");
	}
}
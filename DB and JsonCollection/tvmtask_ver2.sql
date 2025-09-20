-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 20, 2025 at 09:47 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tvmtask_ver2`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `post_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_user_id_foreign` (`user_id`),
  KEY `comments_post_id_foreign` (`post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `content`, `user_id`, `post_id`, `created_at`, `updated_at`) VALUES
(1, 'The post was okay, but I\'ve seen better explanations of Getting Started with Laravel elsewhere.', 3, 1, '2025-09-10 11:14:45', '2025-09-10 11:14:45'),
(2, 'This is exactly what I needed for understanding Getting Started with Laravel. Well written!', 9, 1, '2025-09-10 13:14:45', '2025-09-10 13:14:45'),
(3, 'I appreciate the tips and best practices you included. Very comprehensive!', 5, 1, '2025-09-09 04:14:45', '2025-09-09 04:14:45'),
(4, 'The code examples are very practical. I was able to adapt them to my use case easily.', 3, 1, '2025-09-13 06:14:45', '2025-09-13 06:14:45'),
(5, 'I particularly liked how you explained the concept behind Getting Started with Laravel. Very insightful.', 5, 1, '2025-09-10 08:14:45', '2025-09-10 08:14:45'),
(6, 'This helped me solve a problem I\'ve been having for days. Thank you!', 9, 1, '2025-09-15 07:14:45', '2025-09-15 07:14:45'),
(7, 'This post answered all my questions about Getting Started with Laravel. Perfect timing!', 5, 1, '2025-09-15 05:14:45', '2025-09-15 05:14:45'),
(8, 'This helped me solve a problem I\'ve been having for days. Thank you!', 1, 2, '2025-09-22 07:14:45', '2025-09-22 07:14:45'),
(9, 'I\'ve shared this with my team. We\'re all learning Vue.js Components Tutorial together now!', 7, 2, '2025-09-22 06:14:45', '2025-09-22 06:14:45'),
(10, 'I\'ve shared this with my team. We\'re all learning Vue.js Components Tutorial together now!', 10, 2, '2025-09-24 06:14:45', '2025-09-24 06:14:45'),
(11, 'I followed the tutorial but got stuck at the part about Vue.js Components Tutorial. Any suggestions?', 3, 2, '2025-09-24 13:14:45', '2025-09-24 13:14:45'),
(12, 'I implemented this in my project and it worked perfectly. Great job!', 7, 2, '2025-09-21 15:14:45', '2025-09-21 15:14:45'),
(13, 'The code works, but I\'m concerned about performance implications with Vue.js Components Tutorial.', 9, 2, '2025-09-19 10:14:45', '2025-09-19 10:14:45'),
(14, 'The real-world examples really helped me understand how to apply Vue.js Components Tutorial in practice.', 4, 2, '2025-09-19 14:14:45', '2025-09-19 14:14:45'),
(15, 'The explanation of Building RESTful APIs with PHP was good, but I wish there were more examples.', 7, 3, '2025-09-23 14:14:45', '2025-09-23 14:14:45'),
(16, 'This is exactly what I needed for understanding Building RESTful APIs with PHP. Well written!', 6, 3, '2025-09-22 15:14:45', '2025-09-22 15:14:45'),
(17, 'I implemented this in my project and it worked perfectly. Great job!', 11, 3, '2025-09-19 09:14:45', '2025-09-19 09:14:45'),
(18, 'I\'ve been looking for a good resource on Building RESTful APIs with PHP. This exceeded my expectations!', 2, 3, '2025-09-19 11:14:45', '2025-09-19 11:14:45'),
(19, 'The post was helpful, but I think the section about React Hooks Explained could be expanded.', 10, 4, '2025-09-12 13:14:45', '2025-09-12 13:14:45'),
(20, 'The real-world examples really helped me understand how to apply React Hooks Explained in practice.', 9, 4, '2025-09-13 15:14:45', '2025-09-13 15:14:45'),
(21, 'I particularly liked how you explained the concept behind React Hooks Explained. Very insightful.', 4, 4, '2025-09-14 07:14:45', '2025-09-14 07:14:45'),
(22, 'I think there might be an error in the code example for React Hooks Explained. Could you double-check?', 7, 4, '2025-09-11 10:14:45', '2025-09-11 10:14:45'),
(23, 'This is one of the best explanations of Database Optimization Techniques I\'ve come across. Well done!', 10, 5, '2025-09-09 05:14:45', '2025-09-09 05:14:45'),
(24, 'The visuals and code snippets made complex concepts easy to understand. Great work!', 9, 5, '2025-09-05 13:14:45', '2025-09-05 13:14:45'),
(25, 'I\'m having trouble implementing this. Are there any common pitfalls with Database Optimization Techniques?', 3, 5, '2025-09-04 10:14:45', '2025-09-04 10:14:45'),
(26, 'I\'ve been looking for a good resource on Database Optimization Techniques. This exceeded my expectations!', 12, 5, '2025-09-06 10:14:45', '2025-09-06 10:14:45'),
(27, 'I\'ve been looking for a good resource on CSS Grid vs Flexbox. This exceeded my expectations!', 4, 6, '2025-09-22 04:14:45', '2025-09-22 04:14:45'),
(28, 'The code works, but I\'m concerned about performance implications with CSS Grid vs Flexbox.', 1, 6, '2025-09-22 15:14:45', '2025-09-22 15:14:45'),
(29, 'I\'ve been struggling with JavaScript ES6 Features for a while. Thanks for the clear explanation!', 11, 7, '2025-09-21 06:14:45', '2025-09-21 06:14:45'),
(30, 'The real-world examples really helped me understand how to apply JavaScript ES6 Features in practice.', 5, 7, '2025-09-20 12:14:45', '2025-09-20 12:14:45'),
(31, 'Great post about JavaScript ES6 Features! This was really helpful for my project.', 8, 7, '2025-09-20 05:14:45', '2025-09-20 05:14:45'),
(32, 'I appreciate the tips and best practices you included. Very comprehensive!', 4, 7, '2025-09-25 09:14:45', '2025-09-25 09:14:45'),
(33, 'This is exactly what I needed for understanding JavaScript ES6 Features. Well written!', 1, 7, '2025-09-19 14:14:45', '2025-09-19 14:14:45'),
(34, 'The real-world examples really helped me understand how to apply Docker for Development in practice.', 3, 8, '2025-09-05 06:14:45', '2025-09-05 06:14:45'),
(35, 'Clear and concise explanation of Docker for Development. Bookmarked for future reference.', 11, 8, '2025-09-09 09:14:45', '2025-09-09 09:14:45'),
(36, 'Great post about Docker for Development! This was really helpful for my project.', 3, 8, '2025-09-11 07:14:45', '2025-09-11 07:14:45'),
(37, 'Thanks for the detailed walkthrough. The step-by-step approach made it easy to follow.', 7, 8, '2025-09-05 05:14:45', '2025-09-05 05:14:45'),
(38, 'I\'m having trouble implementing this. Are there any common pitfalls with Docker for Development?', 12, 8, '2025-09-05 04:14:45', '2025-09-05 04:14:45'),
(39, 'Good overview, but I think some parts of Docker for Development were oversimplified.', 6, 8, '2025-09-10 15:14:45', '2025-09-10 15:14:45'),
(40, 'The visuals and code snippets made complex concepts easy to understand. Great work!', 9, 9, '2025-09-19 15:14:45', '2025-09-19 15:14:45'),
(41, 'I\'ve been looking for a good resource on Advanced Laravel Techniques. This exceeded my expectations!', 11, 9, '2025-09-18 05:14:45', '2025-09-18 05:14:45'),
(42, 'I appreciate the depth you went into with Advanced Laravel Techniques. Many tutorials skip important details.', 11, 9, '2025-09-24 05:14:45', '2025-09-24 05:14:45'),
(43, 'I particularly liked how you explained the concept behind Advanced Laravel Techniques. Very insightful.', 7, 9, '2025-09-23 10:14:45', '2025-09-23 10:14:45'),
(44, 'I\'ve been looking for a good resource on Advanced Laravel Techniques. This exceeded my expectations!', 10, 9, '2025-09-19 12:14:45', '2025-09-19 12:14:45'),
(45, 'I never understood Advanced Laravel Techniques until I read this post. Thank you for breaking it down!', 3, 9, '2025-09-25 15:14:45', '2025-09-25 15:14:45'),
(46, 'I think there might be an error in the code example for Advanced Laravel Techniques. Could you double-check?', 9, 9, '2025-09-25 04:14:45', '2025-09-25 04:14:45'),
(47, 'I\'ve been looking for a good resource on Advanced Laravel Techniques. This exceeded my expectations!', 7, 9, '2025-09-25 13:14:45', '2025-09-25 13:14:45'),
(48, 'I particularly liked how you explained the concept behind Upcoming Web Technologies. Very insightful.', 9, 10, '2025-09-19 08:14:45', '2025-09-19 08:14:45'),
(49, 'I\'m having trouble implementing this. Are there any common pitfalls with Upcoming Web Technologies?', 12, 10, '2025-09-14 10:14:45', '2025-09-14 10:14:45');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_09_19_143845_create_users_table', 1),
(2, '2025_09_19_144126_create_posts_table', 2),
(3, '2025_09_19_144238_create_comments_table', 3),
(4, '2025_09_19_144352_create_tags_table', 4),
(5, '2025_09_19_144528_create_post_tag_table', 5),
(6, '2025_09_19_160613_create_cache_table', 6),
(7, '2025_09_19_170454_create_personal_access_tokens_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 2, 'auth_token', 'ca802369863312ebab959ddc188827393e52c8407835eca346037e61677f29eb', '[\"*\"]', NULL, NULL, '2025-09-19 11:37:00', '2025-09-19 11:37:00'),
(2, 'App\\Models\\User', 3, 'auth_token', 'c425f1aae5e253a57b6a19d5a10ee1d46708f131d8f117f894b88617bdce641c', '[\"*\"]', NULL, NULL, '2025-09-19 11:41:18', '2025-09-19 11:41:18'),
(7, 'App\\Models\\User', 4, 'auth_token', '3be3927ca3347dc5efb0acd1c40636d82acb9797b7e302a07edf3d18ba62efde', '[\"*\"]', '2025-09-19 11:59:05', NULL, '2025-09-19 11:51:09', '2025-09-19 11:59:05'),
(4, 'App\\Models\\User', 4, 'auth_token', '7e04cbd00b079e6c5c435e5d7e3c82a3c2e28194a7fffb422eabd8b241e99970', '[\"*\"]', NULL, NULL, '2025-09-19 11:47:32', '2025-09-19 11:47:32'),
(5, 'App\\Models\\User', 4, 'auth_token', '17f57eee606e8018475345f406ff99a032254024050057dd1a1fe920df9ed6a4', '[\"*\"]', NULL, NULL, '2025-09-19 11:47:38', '2025-09-19 11:47:38'),
(6, 'App\\Models\\User', 4, 'auth_token', '16bfe733e4e1b3e99f00e5ba8a215ad912c4e8568a5cc92e4ed13187f9fbaa28', '[\"*\"]', NULL, NULL, '2025-09-19 11:48:08', '2025-09-19 11:48:08'),
(8, 'App\\Models\\User', 4, 'auth_token', '20202b6e0ab51f242496b49a61f5e10a15b17fc6a43adc18dc246ecb7872752c', '[\"*\"]', '2025-09-19 12:02:42', NULL, '2025-09-19 12:00:03', '2025-09-19 12:02:42'),
(9, 'App\\Models\\User', 4, 'auth_token', 'a48d734289b06b0f74f53fc44075b97c7f8fe2fa59c080f923debbbeb5685c41', '[\"*\"]', '2025-09-19 12:06:00', NULL, '2025-09-19 12:05:23', '2025-09-19 12:06:00'),
(10, 'App\\Models\\User', 4, 'auth_token', '9b9cc8b88a5eef444c329c49d39bfb3bea3f4c4ddcc23b3545faff6939922554', '[\"*\"]', '2025-09-19 12:16:38', NULL, '2025-09-19 12:08:21', '2025-09-19 12:16:38'),
(11, 'App\\Models\\User', 4, 'auth_token', '52f298feaef87b5ea95d3a3ebd1228d284d62d6b9393ce3225a226d69490e4b4', '[\"*\"]', '2025-09-19 12:32:02', NULL, '2025-09-19 12:17:05', '2025-09-19 12:32:02'),
(12, 'App\\Models\\User', 4, 'auth_token', '5f888012d286a7404820a857d18df61d420a1790235f4829a1f196a0ca3efdce', '[\"*\"]', '2025-09-19 12:33:57', NULL, '2025-09-19 12:32:14', '2025-09-19 12:33:57'),
(13, 'App\\Models\\User', 4, 'auth_token', 'e52d6997bb631c9c96d143095294505dc8dedcd56a2a53127d3cb79bdd0a4cd8', '[\"*\"]', NULL, NULL, '2025-09-19 12:44:11', '2025-09-19 12:44:11'),
(14, 'App\\Models\\User', 4, 'auth_token', '0f7c9de3585e4d02ccbb9bd82d8a658a76ca9e03ec8fd9d589572098a5db2d6e', '[\"*\"]', '2025-09-19 12:51:59', NULL, '2025-09-19 12:50:48', '2025-09-19 12:51:59'),
(15, 'App\\Models\\User', 4, 'auth_token', '63f7fbd61aadfdd9fce9e8df9a04ae115ce063989c21fc46020ce285ddd6d391', '[\"*\"]', '2025-09-19 13:11:16', NULL, '2025-09-19 12:52:33', '2025-09-19 13:11:16'),
(16, 'App\\Models\\User', 4, 'auth_token', '6bb694a272fcfac2ea685d55cad626eda4b341e37354eac2a816857880699df8', '[\"*\"]', '2025-09-19 13:22:05', NULL, '2025-09-19 13:18:08', '2025-09-19 13:22:05'),
(17, 'App\\Models\\User', 4, 'auth_token', '35b0c92be5d4425be059d43fa88a199ced01f550abae057b8f7033c50048e99e', '[\"*\"]', '2025-09-19 13:27:13', NULL, '2025-09-19 13:26:20', '2025-09-19 13:27:13'),
(18, 'App\\Models\\User', 4, 'auth_token', '7afca286e34ece105ccd81b99e2aa08145a92ef5a38b9e67d6e6aee5a3bf8cfd', '[\"*\"]', '2025-09-19 14:12:31', NULL, '2025-09-19 14:12:03', '2025-09-19 14:12:31'),
(19, 'App\\Models\\User', 4, 'auth_token', '2773062c6a2a529eac41fb47b1853727e5560c22bd9e7ddfd211c54717c2feca', '[\"*\"]', '2025-09-19 14:14:09', NULL, '2025-09-19 14:13:43', '2025-09-19 14:14:09'),
(20, 'App\\Models\\User', 4, 'auth_token', '94eaa9c5ed08648f4534d8bf94ae1d0d33ef8c13c554d5421b1cb7dd1d7d671f', '[\"*\"]', '2025-09-19 14:21:40', NULL, '2025-09-19 14:21:12', '2025-09-19 14:21:40'),
(21, 'App\\Models\\User', 4, 'auth_token', '4dd36533f6251a0245bb162eae35bb72aaa630139065905987974fa632abe0f7', '[\"*\"]', '2025-09-19 14:25:55', NULL, '2025-09-19 14:25:26', '2025-09-19 14:25:55'),
(22, 'App\\Models\\User', 4, 'auth_token', 'fc8acdf2f6f6e30c3f591c14e274fc982dfb3790234e9cb94c21e7d81597bcb1', '[\"*\"]', '2025-09-19 14:27:48', NULL, '2025-09-19 14:27:23', '2025-09-19 14:27:48'),
(23, 'App\\Models\\User', 4, 'auth_token', 'c8a00df2d7668592d2bc7488cb74f5c30d09c3281ea60a74c5ffc88469bf6e3c', '[\"*\"]', '2025-09-19 14:29:28', NULL, '2025-09-19 14:28:06', '2025-09-19 14:29:28'),
(24, 'App\\Models\\User', 4, 'auth_token', '39e987a6cddfb6b3aabda5506e7853fa3053a342e9657b5f38f594ad2cd38419', '[\"*\"]', NULL, NULL, '2025-09-19 14:38:24', '2025-09-19 14:38:24'),
(25, 'App\\Models\\User', 4, 'auth_token', '5a07415bc1ba7fb5926c92a8875f5b6ebeae8dc082250b05e441e3731e186964', '[\"*\"]', NULL, NULL, '2025-09-19 14:41:25', '2025-09-19 14:41:25'),
(26, 'App\\Models\\User', 4, 'auth_token', '176a8d5413b847561a7cc8bb7f42d03e7b70b3572e93347f99f74a997dd7ed7e', '[\"*\"]', NULL, NULL, '2025-09-19 14:41:29', '2025-09-19 14:41:29'),
(27, 'App\\Models\\User', 4, 'auth_token', 'f58ed2c33b16df42770022f4b67a70df44a6df1b721221e62ce5c307f968ffb6', '[\"*\"]', NULL, NULL, '2025-09-19 14:57:02', '2025-09-19 14:57:02'),
(28, 'App\\Models\\User', 4, 'auth_token', '7f7beee3145dc7b7197e9aba1d85d1fce075bf01a2dc6cb239eb914fd0c47cae', '[\"*\"]', NULL, NULL, '2025-09-19 14:57:07', '2025-09-19 14:57:07'),
(29, 'App\\Models\\User', 4, 'auth_token', '422273a5754899b325615cb2afb5b03032633d48dfd8fc70645f6f4b520b4aec', '[\"*\"]', NULL, NULL, '2025-09-19 15:25:08', '2025-09-19 15:25:08'),
(30, 'App\\Models\\User', 4, 'auth_token', '71bf371e4b5e6e9eeb2e7efc7a2c10bd284655fac91bb759158d409c14569155', '[\"*\"]', NULL, NULL, '2025-09-19 15:39:38', '2025-09-19 15:39:38'),
(31, 'App\\Models\\User', 13, 'auth_token', 'ec4a9c44f458b7d9e852a2c66d8799c06cbc96be048e95f328a51ab63d56670b', '[\"*\"]', NULL, NULL, '2025-09-20 03:21:38', '2025-09-20 03:21:38'),
(32, 'App\\Models\\User', 1, 'auth_token', '11d07ff7e43f6ad19be97c44cd9f05d8debe2ca34e284791f33e4d025751a45f', '[\"*\"]', '2025-09-20 04:03:25', NULL, '2025-09-20 03:22:45', '2025-09-20 04:03:25'),
(33, 'App\\Models\\User', 1, 'auth_token', '58c0c92d5a76ce61d0dea2b400e5c07b1b84b9c904f5e26b82f0a34936231288', '[\"*\"]', '2025-09-20 04:06:59', NULL, '2025-09-20 04:06:33', '2025-09-20 04:06:59');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`),
  KEY `posts_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `content`, `user_id`, `slug`, `published`, `created_at`, `updated_at`) VALUES
(1, 'Getting Started with Laravel', 'Are you struggling with Laravel? This tutorial will walk you through everything you need to know, from basic concepts to advanced techniques.\n\n## Introduction\n\nEst ut et dignissimos perferendis in expedita optio. Voluptatem dolor ut voluptas. Atque ratione ea qui dignissimos non.\n\nSapiente iure in maxime expedita laudantium inventore corrupti. Quam est dolorum amet tempora tempore sed cumque. Eligendi nesciunt id blanditiis tempore et eum.\n\nIllo fugit voluptatem quam rem vel odit. Est ea autem eos. Suscipit non iusto perferendis architecto et dolorem a temporibus. Voluptatem iure enim ut optio.\n\n## Main Content\n\nDicta tempora error dolor itaque pariatur amet. Id aut ipsam cupiditate ipsa voluptatem consequatur quis. Sed eligendi sint minima et consectetur rem nulla repellendus.\n\nAtque et hic provident repellat quia. Quis dolores asperiores dolor perspiciatis temporibus. Nostrum voluptates molestiae ab.\n\nCumque soluta fuga cumque. Aut magnam facere aperiam illum. Distinctio aspernatur dignissimos distinctio aperiam laudantium ut ut quia. Tempore sint sit reiciendis est.\n\nBlanditiis ipsam nobis dolor accusantium atque temporibus. Dolores quos aut eum adipisci ducimus dolor ducimus. Illum tempora ut quia commodi sed quidem eligendi deserunt. Fugiat in quia vel illum vel dolorem est.\n\nPerferendis est voluptas repellendus iure. Eos ducimus debitis et impedit et. Ut fugiat est voluptas ea.\n\n## Conclusion\n\nProvident nulla nostrum et ipsum. Totam quae non rerum. Quis magni dolores ipsum maiores vero eos id. Consectetur commodi molestiae et saepe voluptates.\n\nVoluptas ducimus rerum corporis qui minima accusantium libero. Recusandae harum quos pariatur error nesciunt quia. Et consequatur dolore eum et neque voluptates et voluptatem. Fugiat quis nisi a libero.\n\n## Code Example\n\n```php\n<?php\n// Example code for Laravel\nclass Example {\n    public function demo() {\n        return \'Hello World!\';\n    }\n}\n```', 7, 'getting-started-with-laravel-r5YFHA', 1, '2025-09-09 03:14:45', '2025-09-20 03:14:45'),
(2, 'Vue.js Components Tutorial', 'Are you struggling with Vue.js? This tutorial will walk you through everything you need to know, from basic concepts to advanced techniques.\n\n## Introduction\n\nOmnis qui hic non quia et modi dolorum. Qui et dolorem laborum molestiae est qui molestiae. Error in eius asperiores doloremque rerum itaque.\n\nEt id exercitationem in adipisci cum rerum voluptas. Dolores rem quo et vitae pariatur enim aspernatur aperiam.\n\nUt exercitationem error sunt dolor pariatur eum. Ut aspernatur expedita magnam officiis est tempore occaecati. Esse est aut earum qui pariatur.\n\n## Main Content\n\nMagnam enim ea molestias vitae. Non odit id tempora omnis sint. Rerum quia aut omnis aut doloremque repellendus consequatur. Et quis recusandae sint et quidem.\n\nUllam deserunt sit consequuntur laborum aliquam id accusamus. Nobis sit non et ea iusto. Veniam nisi iste enim et sit amet nihil est. Provident ut provident sunt quae harum non laboriosam eum.\n\nProvident voluptatem quia fugiat iure. Veritatis mollitia voluptatum minima vel accusamus sed consectetur consequatur. Illo excepturi ut alias ut non harum et.\n\nOmnis asperiores quis odit quos expedita. Quos quasi voluptatibus minima quia dignissimos sapiente. Ut quia itaque est reprehenderit et molestiae. Eos nesciunt quibusdam sit nobis cumque non.\n\nAtque labore ut omnis. Autem sed tenetur quos nulla. Minima tempore nesciunt enim natus.\n\n## Conclusion\n\nDeleniti aspernatur qui nisi ad ut molestiae dolor. Omnis quis asperiores voluptas. Ut harum occaecati et sed. Inventore amet eos culpa nam blanditiis rem dolorum.\n\nDelectus impedit veritatis sit autem et asperiores dolorem. Deleniti officia ut et officiis quis quam quam et. Mollitia eos architecto necessitatibus blanditiis corporis in quis.\n\n## Code Example\n\n```php\n<?php\n// Example code for Vue.js\nclass Example {\n    public function demo() {\n        return \'Hello World!\';\n    }\n}\n```', 9, 'vuejs-components-tutorial-AEOR8F', 1, '2025-09-18 03:14:45', '2025-09-20 03:14:45'),
(3, 'Building RESTful APIs with PHP', 'In this comprehensive guide, we\'ll explore REST API and how it can transform your development workflow. Whether you\'re a beginner or an experienced developer, this post will provide valuable insights.\n\n## Introduction\n\nPossimus exercitationem est voluptatibus magni eos. Quo quam quisquam quas voluptas voluptas qui. Consequatur occaecati quis illum iure dolor.\n\nSit nisi optio itaque delectus. Voluptates qui sed qui quo voluptatem in qui. Dolore omnis non autem consequuntur repellat.\n\nEt a consectetur et tempore quae. Et eveniet dolorem officia natus. Beatae eum quisquam voluptatem pariatur reiciendis.\n\n## Main Content\n\nIpsam fugit eos similique sequi est animi itaque maiores. Ducimus omnis qui consequuntur architecto eaque est suscipit.\n\nLaborum molestiae officiis rerum tenetur voluptatum. Vel accusantium optio delectus. Tenetur ullam laboriosam iure qui corrupti qui suscipit.\n\nQui fugiat omnis at quas suscipit perspiciatis ut. Commodi ullam est et totam. Accusamus ad accusamus quia eligendi.\n\nSapiente iste soluta laborum veritatis et ut sapiente. Sit fugiat dolorem qui. Et doloremque quaerat animi voluptatem numquam molestiae. Architecto delectus officiis ab facilis minus ex deserunt.\n\nVoluptates assumenda temporibus aspernatur sunt. Facere sed fuga aliquid dolores voluptas laboriosam illo. Nam aut tempora eum impedit soluta est sed. Aut esse aut delectus minima assumenda. Eius voluptatem voluptas sint commodi dicta blanditiis at.\n\n## Conclusion\n\nAssumenda ut eum molestias aliquam ullam. Id nam reprehenderit accusamus excepturi ipsum quo ipsum. Quis veritatis nostrum dolores quos et est omnis.\n\nItaque vero sint voluptas eaque fuga voluptatem. Voluptates id sed impedit est veritatis illo minima. Repellendus hic inventore quia non autem.', 9, 'building-restful-apis-with-php-RJnHeV', 1, '2025-09-18 03:14:45', '2025-09-20 03:14:45'),
(4, 'React Hooks Explained', 'In the world of modern development, React Hooks plays a crucial role. Let\'s explore its features, benefits, and how to implement it effectively.\n\n## Introduction\n\nEx perspiciatis neque a eveniet animi. Blanditiis omnis aliquam corporis in consequatur soluta beatae laboriosam. Alias sed aspernatur delectus commodi.\n\nAtque ut cumque quam velit architecto maiores. Assumenda laboriosam facere commodi optio sunt eos voluptatem. Et voluptas velit est aut sequi. Sed quibusdam tempore dicta minus molestiae perspiciatis quos. Id quibusdam nostrum sunt.\n\nAut cumque eius delectus iste architecto est. Praesentium animi pariatur explicabo tempora cumque. Impedit voluptatibus sapiente architecto quaerat consequuntur. Sequi pariatur et ex cum eveniet.\n\n## Main Content\n\nQuis rerum nulla veniam pariatur ad deleniti. Cupiditate quia nihil commodi. Sapiente explicabo harum est dignissimos. Repellat consequatur voluptatem aut et et ratione. Voluptatem iusto consequuntur et voluptatibus.\n\nLibero voluptatum laborum voluptates consectetur et dolores velit id. Accusamus quidem voluptates vel. Laudantium sint doloremque hic ut. Minima et porro exercitationem in suscipit atque veniam reprehenderit.\n\nOfficiis sit nisi quibusdam minima blanditiis odio. Voluptatum voluptas totam perspiciatis est molestiae et quibusdam consequatur. Qui distinctio sit numquam fugiat eius saepe.\n\nDucimus culpa reprehenderit esse reprehenderit ipsa et recusandae. Aliquid quod quia dicta et magni. Quos earum facere deleniti saepe. Eligendi dolorum qui harum cumque nisi assumenda est.\n\nConsequuntur est molestiae omnis deserunt nulla. Aperiam officia voluptate praesentium at eos dolores at. Est nihil nostrum eligendi exercitationem repudiandae. Eveniet nemo cumque recusandae modi aut autem.\n\n## Conclusion\n\nInventore alias quibusdam consequatur. Reiciendis facere eum commodi est autem. Laborum est vel omnis doloremque iusto. Sed molestiae non et quis.\n\nVelit quia minus officiis quasi qui sint. Ut sequi delectus impedit numquam explicabo ab doloribus et. Consequatur voluptatum ex sit iste. Excepturi sed dolores animi et nulla officiis doloremque error.', 7, 'react-hooks-explained-RDiwy0', 1, '2025-09-11 03:14:45', '2025-09-20 03:14:45'),
(5, 'Database Optimization Techniques', 'In this comprehensive guide, we\'ll explore Database Optimization and how it can transform your development workflow. Whether you\'re a beginner or an experienced developer, this post will provide valuable insights.\n\n## Introduction\n\nQui fugiat vel harum ipsa soluta nihil consequatur et. Eius autem quo beatae sit voluptates nihil. Laudantium maxime saepe non dicta rerum. Ipsam quod nulla placeat incidunt non totam sed.\n\nVoluptates et beatae commodi quasi. Odio culpa ipsum id consequatur. Consequatur in odit distinctio nam et rerum.\n\nModi dolores a dolor error ut qui. Sunt quo cumque officiis excepturi sed ullam. Doloremque qui ut dolore nihil.\n\n## Main Content\n\nNatus voluptas pariatur hic sunt ipsa velit. Hic nostrum exercitationem sed. Cumque fugit pariatur non quia magnam sint. Veniam et tempore rerum. Placeat doloremque et eaque soluta.\n\nQui deserunt in dolor architecto fuga delectus voluptates. Quo nihil doloremque deleniti odit sunt eius natus. Iure distinctio saepe numquam tempora.\n\nAutem eligendi minima accusantium optio. Ratione aut corporis laudantium fugiat similique labore. Labore repellat veniam commodi suscipit non qui aut.\n\nDolor corrupti hic saepe facilis. Quae facere facere aut atque. Ea sequi ut aut sint. Blanditiis molestias ad ex et.\n\nSed qui qui veniam aliquid explicabo. Id harum numquam corporis sint. Voluptas ut distinctio accusantium amet.\n\n## Conclusion\n\nAccusantium commodi qui vel aperiam. Temporibus impedit ipsam suscipit quasi veritatis eos. Odit natus enim consectetur aspernatur qui placeat. Ut ut unde non sed ea aut sit ut.\n\nQuos sed et facilis eaque. Velit similique fugiat modi fugiat ea veniam saepe. Alias dolor quis temporibus voluptatem officia. Rerum labore sunt consequuntur odio.', 5, 'database-optimization-techniques-K9BKYW', 1, '2025-09-04 03:14:45', '2025-09-20 03:14:45'),
(6, 'CSS Grid vs Flexbox', 'In this comprehensive guide, we\'ll explore CSS Layout and how it can transform your development workflow. Whether you\'re a beginner or an experienced developer, this post will provide valuable insights.\n\n## Introduction\n\nDolores quia est minima quae. Autem qui sunt aperiam sit labore. Culpa totam consequatur magnam voluptatum est. Quia totam optio animi nemo quis aut.\n\nQuasi laborum laudantium a optio aperiam natus qui quae. Eligendi debitis magnam ut quia rerum voluptas. Temporibus non libero ut ad nisi consectetur quam. Accusantium expedita ut et quam.\n\nModi vero non qui nemo voluptatibus. Velit voluptates doloribus qui error excepturi placeat vel. Soluta quis sed id natus enim delectus.\n\n## Main Content\n\nProvident consequatur dolor quae fuga. Et error minima maxime fuga. Et quia deleniti voluptatum a aut totam quam eos. Et laudantium praesentium est praesentium molestias dignissimos.\n\nEt est qui doloribus aut tenetur perferendis qui. Voluptates voluptatem maiores excepturi quis qui recusandae ex. Maiores quidem natus veniam magni modi vel et explicabo. Ipsa quos dolores fuga a voluptatem nulla.\n\nEt cumque dolorem dolorem dolore qui aut dolore temporibus. Adipisci dolorum sint magnam reprehenderit rem officia. Odio autem ea aperiam quo sunt hic. Eum ut laborum reiciendis rerum aspernatur.\n\nAlias molestiae molestias voluptate perferendis. Expedita voluptate libero qui eum quo rem sunt. Molestiae voluptatem velit consectetur voluptatem.\n\nVitae sint vel quis suscipit. Ullam explicabo quia provident sint voluptate. Dolores optio enim ex inventore omnis nihil eum aut. Error est architecto quo perferendis expedita est doloremque.\n\n## Conclusion\n\nTenetur voluptatem illo ad voluptatibus eos. Hic nostrum dolor facere quam quia. Natus assumenda adipisci animi est qui porro in. Cumque eum delectus recusandae ducimus saepe autem praesentium qui.\n\nArchitecto incidunt harum aliquam et officia accusantium et. Dolore vitae omnis est voluptatem enim accusantium reiciendis. Vel beatae et voluptatem similique explicabo qui. Voluptatem pariatur possimus molestiae.', 11, 'css-grid-vs-flexbox-0BaUp3', 1, '2025-09-18 03:14:45', '2025-09-20 03:14:45'),
(7, 'JavaScript ES6 Features', 'In this comprehensive guide, we\'ll explore JavaScript ES6 and how it can transform your development workflow. Whether you\'re a beginner or an experienced developer, this post will provide valuable insights.\n\n## Introduction\n\nLaboriosam ducimus earum et sunt. Et soluta hic corrupti sit aut. Est esse voluptatibus minima et pariatur qui maiores voluptas. Autem beatae laboriosam eos voluptatem saepe.\n\nNostrum est eos tempore nobis. Quia enim laborum voluptatum maxime.\n\nQuia ut quo dolorum officiis voluptatum ab accusantium. Vel modi quidem sunt blanditiis eius. Sint sit in sunt nam quod aut. Molestiae ea vel est rerum.\n\n## Main Content\n\nNon quia quaerat vel sit sunt est. Ab veritatis natus nam ullam. Consectetur recusandae suscipit vel vero quia quam fugit. Tenetur suscipit nobis fugiat.\n\nProvident illum dolorum est culpa. Vel nihil repellendus necessitatibus veritatis non qui. Velit ut libero sint nihil. Officia sunt ab odit natus.\n\nQuas commodi iure omnis tenetur facilis. Velit voluptatum debitis vero aut sint. Qui vitae animi incidunt est.\n\nCumque deleniti et aspernatur rem sunt dignissimos quasi. Nihil eaque id et inventore quia laboriosam mollitia. Non est sed facere tempora nisi. Quia voluptate expedita odio vel unde et.\n\nLabore ut omnis dolorum. Ipsa velit atque distinctio qui. Labore nostrum et illo placeat alias. Consequatur delectus nobis officiis quia quia.\n\n## Conclusion\n\nFuga illum atque omnis omnis. Iusto ut tempora consequatur aut. Deleniti voluptas sapiente quas. Facilis quidem rerum tempore autem qui.\n\nDolorem nihil saepe amet dicta aliquam sint non. Consequatur laudantium quia libero enim vel quo sint. Sed fugit odit ea aut architecto minus impedit. Libero non non est eum a sunt.', 12, 'javascript-es6-features-Y5SODp', 1, '2025-09-19 03:14:45', '2025-09-20 03:14:45'),
(8, 'Docker for Development', 'In the world of modern development, Docker plays a crucial role. Let\'s explore its features, benefits, and how to implement it effectively.\n\n## Introduction\n\nNihil facere ratione aut natus aliquam aliquam. Est ut quo quia voluptas natus aliquam pariatur vero.\n\nEum praesentium sint ut voluptatum sapiente incidunt. Nihil accusantium earum reiciendis dolor deleniti quia nam. Possimus omnis molestiae est aliquid.\n\nOmnis dolorem autem laboriosam dolores tempore quia mollitia. Velit quia et suscipit ipsa omnis voluptates voluptatem. Et ut voluptas et hic qui necessitatibus omnis.\n\n## Main Content\n\nEst fugit dolorum molestias debitis placeat cupiditate quia. Unde cumque corrupti itaque ullam. Optio voluptatem quidem repudiandae nam quia.\n\nEsse odio consequatur qui id cum. Nisi consectetur exercitationem aliquid atque ut similique. Qui neque quasi consequatur ut voluptates omnis. Et sint magni quia maiores accusamus consequatur et eligendi.\n\nSuscipit id dolorem dolores recusandae velit dolore dolores. Repellendus quibusdam perspiciatis sit autem voluptatem. Et est dolorum accusantium aut eum maxime quasi commodi. Nam laudantium qui beatae nemo.\n\nEt voluptatum fugit placeat totam numquam laborum quis explicabo. Fuga quidem iure rem magni. Asperiores natus nemo consequuntur quia.\n\nAdipisci accusamus optio quisquam voluptate mollitia. Et consequatur nesciunt eum dolorem magnam. Quia quis consectetur sunt quia.\n\n## Conclusion\n\nEt aspernatur occaecati aut quod. Aut aliquam libero architecto enim vel ea dolorum. Laboriosam magnam modi vero voluptatem.\n\nQuia nobis inventore et temporibus qui. Veritatis sapiente ut dolorum voluptas laborum odit consequatur. Sunt perferendis modi et consequuntur itaque nemo consequatur natus. Rem quia at non maiores. Dolorem optio molestiae facilis assumenda veritatis.', 6, 'docker-for-development-rrLRi2', 1, '2025-09-05 03:14:45', '2025-09-20 03:14:45'),
(9, 'Advanced Laravel Techniques', 'In the world of modern development, Advanced Laravel plays a crucial role. Let\'s explore its features, benefits, and how to implement it effectively.\n\n## Introduction\n\nDeserunt quisquam culpa alias soluta unde. Ut porro sit magnam provident est reiciendis. Quis in placeat ut id consequuntur eum illum. Qui sapiente sed non est quos quia.\n\nFacilis ipsum animi error aut quo labore laudantium. Molestiae in eum officia nam. Vitae impedit omnis aut nihil.\n\nNemo qui aliquam harum expedita. Recusandae quo earum aut dolor repudiandae. Veniam cupiditate aut maiores aut vel. Mollitia itaque magnam aliquid cupiditate fuga enim. Quibusdam non ipsum quidem quis labore quos a recusandae.\n\n## Main Content\n\nConsequatur nihil adipisci pariatur illo blanditiis perspiciatis eligendi distinctio. Suscipit eaque rem necessitatibus dolorum ut quo. Magnam sit blanditiis ab voluptatem quas omnis ut.\n\nDolorem et dolorem et. Ut voluptates magni omnis nemo cum. Dolores tenetur fugiat consequatur omnis corporis error. Aut incidunt provident consequatur voluptas qui placeat accusantium.\n\nCommodi sit id consectetur inventore animi. Quia est aut et. Unde architecto veritatis ea exercitationem quos. Et molestias sint inventore harum ad perferendis porro. Velit sed ducimus qui quis tempore impedit consequatur.\n\nLaudantium quia voluptatem impedit sed ut. Qui consequatur laudantium illum tempora.\n\nDelectus deleniti et est est vel. Et ab omnis dolorem voluptatem laboriosam. Nulla nobis accusamus in enim ea. Sit placeat voluptate blanditiis ratione et.\n\n## Conclusion\n\nPossimus assumenda iure omnis vero. Quos qui voluptas nulla incidunt consequatur. Pariatur voluptatem et neque ut. Qui quis tenetur fugiat ut deserunt.\n\nEt qui libero adipisci explicabo quasi inventore. Ut consequatur et placeat cupiditate. Accusantium quo sunt sint qui deserunt ad fugit.', 12, 'advanced-laravel-techniques-HbmbkM', 0, '2025-09-18 03:14:45', '2025-09-20 03:14:45'),
(10, 'Upcoming Web Technologies', 'This post covers everything about Future Web - from installation and setup to real-world applications and troubleshooting common issues.\n\n## Introduction\n\nVoluptas eos dolores necessitatibus totam esse amet. Consectetur iste ratione tempora laborum nihil eos. Error explicabo facilis aut sunt sapiente non.\n\nId excepturi eos autem est. Ab nam enim facere. Praesentium voluptate veritatis adipisci possimus et sit nihil. Harum cupiditate temporibus delectus adipisci debitis.\n\nLabore hic voluptas aut vel numquam. Qui non consequatur consequuntur consequuntur. Dicta voluptas similique deserunt rerum omnis.\n\n## Main Content\n\nOdit in est quas et. Nostrum laboriosam esse consequatur delectus. Eos dolorem recusandae velit adipisci ut error.\n\nRerum nisi impedit itaque dolor ducimus quia. Ut eaque temporibus accusantium aliquid beatae qui quis. Sequi et tempora id voluptatem dolorem harum possimus.\n\nNam atque nemo esse aut ut saepe optio. Aut omnis aperiam facilis et eaque veniam. Deserunt odit voluptas excepturi sit pariatur qui ut.\n\nRepellat nemo quas a est qui omnis quo. Error ullam velit unde aliquam. Provident officia esse dolorem odio id ad. Quam voluptatem sit aperiam ut similique itaque.\n\nDicta consequatur qui sit minus. In facilis aut consequatur quia cumque. Ratione magni asperiores qui voluptas sint rerum eum dolores. Quisquam iusto voluptatem quaerat exercitationem veritatis rerum.\n\n## Conclusion\n\nDelectus odit unde veritatis ea occaecati qui. Maiores ad iusto sed non delectus necessitatibus sit blanditiis. Repudiandae unde sunt et autem veritatis perspiciatis quis. Harum ea sunt omnis voluptas corporis ullam.\n\nMinima ipsa ut et eum. Voluptatem officia id nihil deleniti blanditiis amet odio. Dolores harum harum vel blanditiis necessitatibus rerum. Veniam saepe dolor non qui.', 9, 'upcoming-web-technologies-cLAyCC', 0, '2025-09-12 03:14:45', '2025-09-20 03:14:45'),
(11, 'Java Course', 'Java Complete Coaching.', 1, 'custom-slug-java-sanctum', 1, '2025-09-20 04:06:59', '2025-09-20 04:06:59');

-- --------------------------------------------------------

--
-- Table structure for table `post_tag`
--

DROP TABLE IF EXISTS `post_tag`;
CREATE TABLE IF NOT EXISTS `post_tag` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` bigint UNSIGNED NOT NULL,
  `tag_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_tag_post_id_tag_id_unique` (`post_id`,`tag_id`),
  KEY `post_tag_tag_id_foreign` (`tag_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_tag`
--

INSERT INTO `post_tag` (`id`, `post_id`, `tag_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, NULL, NULL),
(2, 1, 1, NULL, NULL),
(3, 1, 13, NULL, NULL),
(4, 2, 4, NULL, NULL),
(5, 2, 3, NULL, NULL),
(6, 2, 14, NULL, NULL),
(7, 3, 1, NULL, NULL),
(8, 3, 15, NULL, NULL),
(9, 4, 5, NULL, NULL),
(10, 4, 3, NULL, NULL),
(11, 4, 14, NULL, NULL),
(12, 5, 20, NULL, NULL),
(13, 6, 14, NULL, NULL),
(14, 6, 13, NULL, NULL),
(15, 7, 3, NULL, NULL),
(16, 8, 25, NULL, NULL),
(17, 9, 2, NULL, NULL),
(18, 9, 1, NULL, NULL),
(19, 10, 13, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_name_unique` (`name`),
  UNIQUE KEY `tags_slug_unique` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'PHP', 'php', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(2, 'Laravel', 'laravel', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(3, 'JavaScript', 'javascript', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(4, 'Vue.js', 'vuejs', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(5, 'React', 'react', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(6, 'Python', 'python', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(7, 'Java', 'java', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(8, 'C#', 'c', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(9, 'Ruby', 'ruby', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(10, 'Go', 'go', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(11, 'Rust', 'rust', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(12, 'TypeScript', 'typescript', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(13, 'Web Development', 'web-development', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(14, 'Frontend', 'frontend', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(15, 'Backend', 'backend', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(16, 'Full Stack', 'full-stack', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(17, 'API Development', 'api-development', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(18, 'REST API', 'rest-api', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(19, 'GraphQL', 'graphql', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(20, 'MySQL', 'mysql', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(21, 'PostgreSQL', 'postgresql', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(22, 'MongoDB', 'mongodb', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(23, 'SQLite', 'sqlite', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(24, 'Redis', 'redis', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(25, 'Docker', 'docker', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(26, 'Kubernetes', 'kubernetes', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(27, 'AWS', 'aws', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(28, 'Azure', 'azure', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(29, 'Git', 'git', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(30, 'CI/CD', 'cicd', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(31, 'Linux', 'linux', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(32, 'Nginx', 'nginx', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(33, 'Apache', 'apache', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(34, 'Express.js', 'expressjs', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(35, 'Django', 'django', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(36, 'Flask', 'flask', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(37, 'Spring Boot', 'spring-boot', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(38, 'ASP.NET', 'aspnet', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(39, 'React Native', 'react-native', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(40, 'Flutter', 'flutter', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(41, 'IOS', 'ios', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(42, 'Android', 'android', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(43, 'Swift', 'swift', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(44, 'Kotlin', 'kotlin', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(45, 'Machine Learning', 'machine-learning', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(46, 'AI', 'ai', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(47, 'Blockchain', 'blockchain', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(48, 'Cybersecurity', 'cybersecurity', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(49, 'Cloud Computing', 'cloud-computing', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(50, 'Microservices', 'microservices', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(51, 'Serverless', 'serverless', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(52, 'Object-Oriented Programming', 'object-oriented-programming', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(53, 'Functional Programming', 'functional-programming', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(54, 'Test-Driven Development', 'test-driven-development', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(55, 'Agile', 'agile', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(56, 'Scrum', 'scrum', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(57, 'Design Patterns', 'design-patterns', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(58, 'Clean Code', 'clean-code', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(59, 'Refactoring', 'refactoring', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(60, 'Career Advice', 'career-advice', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(61, 'Programming Tips', 'programming-tips', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(62, 'Learning', 'learning', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(63, 'Productivity', 'productivity', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(64, 'Remote Work', 'remote-work', '2025-09-20 03:12:59', '2025-09-20 03:12:59'),
(65, 'Freelancing', 'freelancing', '2025-09-20 03:12:59', '2025-09-20 03:12:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('user','admin') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin User', 'admin@blog.com', '2025-09-20 03:09:41', '$2y$12$KNlCArKMGKpHIaa5k1xg/OjSH2Wh/z.0H1vDesj.nt5A3rEx/P2fC', 'admin', 'eoifnGBhKz', '2025-07-20 03:09:41', '2025-09-20 03:09:41'),
(2, 'Super Admin', 'superadmin@blog.com', '2025-09-20 03:09:41', '$2y$12$z.aAZ3lWUiQqIKvx9RTjcu8LNgJleLoFJS0AdMgn7sjc6PihUGgcu', 'admin', '8G4FzgLGt4', '2025-06-20 03:09:41', '2025-09-20 03:09:41'),
(3, 'John Doe', 'john.doe@example.com', '2025-09-20 03:09:41', '$2y$12$eIicKbpYC1Boo7MSqiPaueOU7XBu2IFHXVDiCeLih0PflPsBBFPp.', 'user', 'BZzfckifNP', '2025-08-06 03:09:41', '2025-09-20 03:09:41'),
(4, 'Jane Smith', 'jane.smith@example.com', '2025-09-20 03:09:41', '$2y$12$IWA0NZ2a/XiPPJW.V31cKOfRQMz5BbkXVEVLpQFtRgAR7PKfSMGAS', 'user', 'TzslB11OA5', '2025-08-21 03:09:41', '2025-09-20 03:09:41'),
(5, 'Mike Johnson', 'mike.johnson@example.com', '2025-09-20 03:09:41', '$2y$12$9qzKdd2cWaFetN9Xv0xosO8irubyY3VO47oWY52Ts.WfuA6DXkSYG', 'user', '6tWLOuXBb9', '2025-07-22 03:09:41', '2025-09-20 03:09:41'),
(6, 'Sarah Wilson', 'sarah.wilson@example.com', '2025-09-20 03:09:42', '$2y$12$sf4801NGu9eFrk7iunRVJ.a5sfo0u1KHjAj0ezhN1CzweCBFJ5C7K', 'user', '7MEdZn0g5v', '2025-08-26 03:09:42', '2025-09-20 03:09:42'),
(7, 'David Brown', 'david.brown@example.com', '2025-09-20 03:09:42', '$2y$12$MLMB5fmEdRSrMK8xnTpUU.gb1m88rlNQecNrTgau1dotDdmSrjjHG', 'user', 'gXtfwOpabp', '2025-09-05 03:09:42', '2025-09-20 03:09:42'),
(8, 'Emily Davis', 'emily.davis@example.com', '2025-09-20 03:09:42', '$2y$12$kv9aRaEXWqrs5XTTVyghGueILqkmfb07fO.62UVV/womxxAbYD02m', 'user', 'orTN01tYzc', '2025-09-10 03:09:42', '2025-09-20 03:09:42'),
(9, 'Robert Miller', 'robert.miller@example.com', '2025-09-20 03:09:42', '$2y$12$esUW0J1MJKaDH8NTDBSpgO4Cp1BxWQIj1T.bHO6v.veDDRoM0I4NG', 'user', 'EdOD0YULDc', '2025-08-01 03:09:42', '2025-09-20 03:09:42'),
(10, 'Lisa Taylor', 'lisa.taylor@example.com', '2025-09-20 03:09:42', '$2y$12$wJ3INq5HL893LcbODry5VOlV.4lIwsLm1dmbTq5LEF6lwuebIpp4G', 'user', '7iKzMnsG4N', '2025-08-31 03:09:42', '2025-09-20 03:09:42'),
(11, 'Alex Chen', 'alex.chen@example.com', '2025-09-20 03:09:43', '$2y$12$CTsJVZh9MYCqtGhWoSKGNOzBgh6YquadgZyokOna7Uzan/9RKkCZi', 'user', 'V6QqUcCJ5y', '2025-08-16 03:09:43', '2025-09-20 03:09:43'),
(12, 'Maria Garcia', 'maria.garcia@example.com', '2025-09-20 03:09:43', '$2y$12$9.WbMsY3BpCMB5aUwl.TMe19mcPTUp0zN71BWCjHfs/TO4v/8oagS', 'user', 'PRCWau2tiN', '2025-08-11 03:09:43', '2025-09-20 03:09:43'),
(13, 'dhivya', 'dhivyag@example.com', NULL, '$2y$12$BzDWcS9zOkS6UQdO0B6nvubrJ5HmTSXEO8c699nEC7kHsLTtl62eO', 'user', NULL, '2025-09-20 03:21:37', '2025-09-20 03:21:37');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

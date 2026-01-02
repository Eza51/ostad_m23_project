-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 02, 2026 at 10:14 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ostad_blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`) VALUES
(2, 4, 1, '2025-12-25 12:44:59', '2025-12-25 12:44:59'),
(7, 4, 12, '2025-12-25 23:04:16', '2025-12-25 23:04:16'),
(9, 4, 18, '2025-12-25 23:04:19', '2025-12-25 23:04:19'),
(12, 8, 24, '2025-12-27 07:22:16', '2025-12-27 07:22:16'),
(13, 7, 24, '2025-12-31 23:31:29', '2025-12-31 23:31:29'),
(14, 7, 20, '2025-12-31 23:31:35', '2025-12-31 23:31:35'),
(15, 7, 25, '2026-01-01 01:06:25', '2026-01-01 01:06:25');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `post_id`, `user_id`, `parent_id`, `comment`, `created_at`, `updated_at`) VALUES
(1, 1, 4, NULL, 'This is a comment', '2025-12-25 11:51:12', '2025-12-25 11:51:12'),
(2, 1, 4, 1, 'This is a reply', '2025-12-25 12:37:53', '2025-12-25 12:37:53'),
(3, 17, 4, NULL, 'hello', '2025-12-25 23:03:41', '2025-12-25 23:03:41'),
(8, 24, 8, NULL, 'nice post', '2025-12-27 07:21:42', '2025-12-27 07:21:42'),
(9, 24, 8, 8, 'thanks', '2025-12-27 07:21:55', '2025-12-27 07:21:55');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`) VALUES
(2, 4, 1, '2025-12-25 12:43:36', '2025-12-25 12:43:36'),
(6, 7, 7, '2025-12-25 22:55:23', '2025-12-25 22:55:23'),
(10, 7, 12, '2025-12-25 22:57:23', '2025-12-25 22:57:23'),
(23, 4, 12, '2025-12-25 23:04:11', '2025-12-25 23:04:11'),
(28, 7, 24, '2025-12-31 23:31:27', '2025-12-31 23:31:27'),
(29, 7, 20, '2025-12-31 23:31:35', '2025-12-31 23:31:35'),
(31, 7, 10, '2025-12-31 23:45:57', '2025-12-31 23:45:57'),
(32, 7, 25, '2026-01-01 00:52:00', '2026-01-01 00:52:00');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_12_25_061118_create_personal_access_tokens_table', 1),
(5, '2025_12_25_061407_add_username_image_to_users', 2),
(6, '2025_12_25_061537_create_posts_table', 3),
(7, '2025_12_25_061646_create_tags_table', 3),
(8, '2025_12_25_061700_create_post_tag_table', 3),
(9, '2025_12_25_062036_create_comments_table', 3),
(10, '2025_12_25_062117_create_likes_table', 3),
(11, '2025_12_25_062125_create_bookmarks_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('eza@gmail.com', '$2y$12$0zouEVIgWxHmSI.61iep4.jGEp42xlEykG1L5O0HLdz2gQAdg.1x6', '2025-12-27 06:34:02');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(4, 'App\\Models\\User', 2, 'auth_token', 'd2f8644d472eca0f742c88feff4db91096df6b9c587f5fc1f21110e2c06b52ac', '[\"*\"]', '2025-12-25 08:57:29', NULL, '2025-12-25 01:49:35', '2025-12-25 08:57:29'),
(7, 'App\\Models\\User', 3, 'auth_token', '3c3611e613d5c0a21ed97e931915690f35ddecd8e8c399743e1f7d3a89b3638a', '[\"*\"]', '2025-12-25 08:13:29', NULL, '2025-12-25 08:05:27', '2025-12-25 08:13:29'),
(8, 'App\\Models\\User', 3, 'auth_token', 'a10fa814cc73c7ed42ac74f2814628bc983bbeddd6e82b7899c60511a43733d4', '[\"*\"]', NULL, NULL, '2025-12-25 08:55:59', '2025-12-25 08:55:59'),
(11, 'App\\Models\\User', 4, 'auth_token', '9406fc6030bace695a780d7e3ed02d722225d4bc1332d45e10aec202a4426af2', '[\"*\"]', NULL, NULL, '2025-12-25 08:57:18', '2025-12-25 08:57:18'),
(12, 'App\\Models\\User', 4, 'auth_token', '19cd877595cb1676b2f5dd392814109904f79263c85196cd2b0ee2c1db785848', '[\"*\"]', '2025-12-25 08:58:59', NULL, '2025-12-25 08:58:08', '2025-12-25 08:58:59'),
(13, 'App\\Models\\User', 4, 'auth_token', '228b571abd0ead2f041420399b0e7098dbeb6c5f24e730b7b19a18b915f68103', '[\"*\"]', NULL, NULL, '2025-12-25 09:00:27', '2025-12-25 09:00:27'),
(14, 'App\\Models\\User', 4, 'auth_token', '63a8967e906deb80a75197e28abb22478d9b4ea5fa3f686fa3cccaf02f80825e', '[\"*\"]', '2025-12-25 09:41:53', NULL, '2025-12-25 09:40:23', '2025-12-25 09:41:53'),
(15, 'App\\Models\\User', 4, 'auth_token', 'a26ed4367f83e640b78f87f5dafa0e1752566f8ecc478ecbc4391b3e0aadb709', '[\"*\"]', '2025-12-25 12:44:59', NULL, '2025-12-25 10:34:10', '2025-12-25 12:44:59'),
(16, 'App\\Models\\User', 5, 'auth_token', '88e78a5ef0b59e64633e98d84a28ed529dd91c46a74470fbfde432bd96379003', '[\"*\"]', NULL, NULL, '2025-12-25 13:28:33', '2025-12-25 13:28:33'),
(17, 'App\\Models\\User', 6, 'auth_token', 'e1eb4e506bb9e33caabac5a26b14c8f90af39b243383fcde201afb7d17310d3e', '[\"*\"]', NULL, NULL, '2025-12-25 13:29:05', '2025-12-25 13:29:05'),
(18, 'App\\Models\\User', 6, 'auth_token', 'f5ae05b64b15a6e20ed675b160e0cab32ff13bf8bfbb42b5844effe2548926ef', '[\"*\"]', '2025-12-25 13:45:31', NULL, '2025-12-25 13:29:19', '2025-12-25 13:45:31'),
(19, 'App\\Models\\User', 7, 'auth_token', 'b23c3b60e9a0b99d2cb9eae455c2c48d536109761d3cf49d26b42ea747d82bd3', '[\"*\"]', NULL, NULL, '2025-12-25 14:04:35', '2025-12-25 14:04:35'),
(20, 'App\\Models\\User', 7, 'auth_token', '8c5e098098e317594ff3cb392402987e66c9490f82d6a5980e5453216a254bb5', '[\"*\"]', '2025-12-25 14:05:20', NULL, '2025-12-25 14:05:01', '2025-12-25 14:05:20'),
(21, 'App\\Models\\User', 7, 'auth_token', 'fd4f319e72ed51ad6b51f38b73418bb13667c57abd636600135ac195b1aba84a', '[\"*\"]', NULL, NULL, '2025-12-25 14:05:56', '2025-12-25 14:05:56'),
(22, 'App\\Models\\User', 7, 'auth_token', 'e833d72803fee365426c3830e204b4a93e9ee34dd30960328b916135827ea5a2', '[\"*\"]', '2025-12-25 14:15:53', NULL, '2025-12-25 14:15:36', '2025-12-25 14:15:53'),
(23, 'App\\Models\\User', 7, 'auth_token', '2fcd55a57e2abb47492a62e69fa286ef61b306c7611a03f4e21e59feb69196ac', '[\"*\"]', NULL, NULL, '2025-12-25 14:22:57', '2025-12-25 14:22:57'),
(24, 'App\\Models\\User', 7, 'auth_token', '9441c2a9234056a55cf9670e8aa697a27370c7707c60d154ed98f04512645291', '[\"*\"]', '2025-12-25 14:29:58', NULL, '2025-12-25 14:29:01', '2025-12-25 14:29:58'),
(25, 'App\\Models\\User', 7, 'auth_token', 'd7d780d113d1914f94f75f5ebe088a29ddac01d5d81cb911777f7e7eae2c10a3', '[\"*\"]', NULL, NULL, '2025-12-25 14:37:39', '2025-12-25 14:37:39'),
(26, 'App\\Models\\User', 7, 'auth_token', '92245491b873e90d4a2bd8f6a14153c2d1cf50d7599bbcb2f9c185e24a328192', '[\"*\"]', '2025-12-25 22:50:30', NULL, '2025-12-25 22:34:33', '2025-12-25 22:50:30'),
(27, 'App\\Models\\User', 7, 'auth_token', '2db96f1ccce01f9e2a2aa1cd77a2295476ef02d136ccf35cb59e752b50953f3d', '[\"*\"]', '2025-12-25 22:55:23', NULL, '2025-12-25 22:53:17', '2025-12-25 22:55:23'),
(28, 'App\\Models\\User', 4, 'auth_token', '6de70fbee4526c67aab2254bcd75305bcb84c5729df4c67c538c4eb9fedb06e6', '[\"*\"]', '2025-12-25 22:55:47', NULL, '2025-12-25 22:55:46', '2025-12-25 22:55:47'),
(29, 'App\\Models\\User', 7, 'auth_token', 'a68a20563e1cb993030cd7b0379b28a99036150d9ffebfcb685f0dd0cd855011', '[\"*\"]', '2025-12-25 22:57:29', NULL, '2025-12-25 22:56:43', '2025-12-25 22:57:29'),
(30, 'App\\Models\\User', 4, 'auth_token', 'ff2cdbdea6d3ba35511925bce20b67c73ea56e2ca37a5671e6cb46d7b2c2123d', '[\"*\"]', '2025-12-25 23:05:32', NULL, '2025-12-25 22:57:46', '2025-12-25 23:05:32'),
(31, 'App\\Models\\User', 7, 'auth_token', 'b211bae44f8e12be037268a0616049036bcf3114ffc4480ae7ce1b5b13743084', '[\"*\"]', '2025-12-25 23:14:28', NULL, '2025-12-25 23:11:28', '2025-12-25 23:14:28'),
(32, 'App\\Models\\User', 7, 'auth_token', '3e26e4f1e60ef754c467d1076a4867df6603cf538f8d94de0124e2119203e38c', '[\"*\"]', '2025-12-25 23:22:44', NULL, '2025-12-25 23:22:32', '2025-12-25 23:22:44'),
(33, 'App\\Models\\User', 7, 'auth_token', '1900d1500d8d95e01aeb62458a8402645770e30151ed45fa25896033209d1743', '[\"*\"]', '2025-12-25 23:29:27', NULL, '2025-12-25 23:27:47', '2025-12-25 23:29:27'),
(34, 'App\\Models\\User', 7, 'auth_token', '81d7ddb3dcdfd9fe762a75c319feba2df334e4be1d2ba3816ee479207eb93d03', '[\"*\"]', '2025-12-26 00:04:01', NULL, '2025-12-25 23:33:59', '2025-12-26 00:04:01'),
(35, 'App\\Models\\User', 4, 'auth_token', '7917f4f046bf7f271f213bd6671f65d9d3bef35731a16ad3d745d4ee78ad45e5', '[\"*\"]', '2025-12-26 00:04:50', NULL, '2025-12-26 00:04:44', '2025-12-26 00:04:50'),
(36, 'App\\Models\\User', 7, 'auth_token', 'e77c30a0f53b0f5ffe76cf017a0dddb550ff3af13f92bf9d3344b4c156028583', '[\"*\"]', '2025-12-27 07:24:19', NULL, '2025-12-27 03:29:11', '2025-12-27 07:24:19'),
(37, 'App\\Models\\User', 7, 'auth_token', '60d24ebe4afe69560a26b15d673cae79ea3a4f26e6c2b4e3e61eddfe87cf1341', '[\"*\"]', '2025-12-27 06:37:45', NULL, '2025-12-27 06:37:20', '2025-12-27 06:37:45'),
(38, 'App\\Models\\User', 7, 'auth_token', '65677d84db67b7874ee531bb052b3acb5ca4946a730c797cb672ec500588ed7c', '[\"*\"]', '2025-12-27 07:12:16', NULL, '2025-12-27 07:09:50', '2025-12-27 07:12:16'),
(39, 'App\\Models\\User', 7, 'auth_token', '92799ce6613f2fb4b6937ee8c395b4ac52b9e620cbf73a218a74ab6f761fa85c', '[\"*\"]', '2025-12-27 07:14:37', NULL, '2025-12-27 07:14:36', '2025-12-27 07:14:37'),
(40, 'App\\Models\\User', 8, 'auth_token', 'df8b5f90d8325563de73a63e83008270c6d3bd5c2bffa027c888ee2528efca2a', '[\"*\"]', NULL, NULL, '2025-12-27 07:21:00', '2025-12-27 07:21:00'),
(41, 'App\\Models\\User', 8, 'auth_token', '432f890ac155f02d079493c442c62c4785bb9f303eb41a8f5065f943913385b6', '[\"*\"]', '2025-12-27 07:22:44', NULL, '2025-12-27 07:21:29', '2025-12-27 07:22:44'),
(42, 'App\\Models\\User', 8, 'auth_token', '745fed9cab0718dbce93eed07d2f0f0a4d93e32d8aced69d6b7c8ab0d0f23160', '[\"*\"]', '2025-12-27 07:23:11', NULL, '2025-12-27 07:23:10', '2025-12-27 07:23:11'),
(43, 'App\\Models\\User', 8, 'auth_token', 'd7f587149672eaa348011c130e78ff94d9710efa03b27dec52ab8b5f938a3860', '[\"*\"]', '2025-12-27 07:25:01', NULL, '2025-12-27 07:25:01', '2025-12-27 07:25:01'),
(44, 'App\\Models\\User', 7, 'auth_token', '796ba2db1308a8b666e379393c1baa909632bc5956ba073c98747aa588903730', '[\"*\"]', '2026-01-01 01:06:29', NULL, '2025-12-31 23:30:42', '2026-01-01 01:06:29'),
(45, 'App\\Models\\User', 7, 'auth_token', '0d575106f6226e6ffe9b2797ebc90ed98977a2c134028cad117a0fa43fb83517', '[\"*\"]', '2026-01-01 01:08:10', NULL, '2026-01-01 01:07:08', '2026-01-01 01:08:10');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `visibility` enum('public','private') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `content`, `image`, `visibility`, `created_at`, `updated_at`) VALUES
(1, 2, 'My First Post', 'This is the content of my first post', NULL, 'public', '2025-12-25 01:51:05', '2025-12-25 01:51:05'),
(2, 2, 'My First Post', 'This is the content of my first post', NULL, 'public', '2025-12-25 08:57:29', '2025-12-25 08:57:29'),
(4, 4, 'Updated Title', 'Updated content', NULL, 'private', '2025-12-25 10:34:30', '2025-12-25 10:34:46'),
(5, 4, 'My 2nd Post', '2nd post', NULL, 'public', '2025-12-25 11:14:15', '2025-12-25 11:14:15'),
(6, 4, 'hellop post', 'new content post', '1766683071_—Pngtree—concept online shopping with smartphone_5345090.png', 'public', '2025-12-25 11:17:51', '2025-12-25 11:17:51'),
(7, 4, 'hellop post', 'new content post', '1766683105_—Pngtree—concept online shopping with smartphone_5345090.png', 'public', '2025-12-25 11:18:25', '2025-12-25 11:18:25'),
(8, 4, 'hellop post', 'new content post', '1766683229_—Pngtree—concept online shopping with smartphone_5345090.png', 'public', '2025-12-25 11:20:29', '2025-12-25 11:20:29'),
(9, 4, 'hellop post', 'new content post', '1766683248_—Pngtree—concept online shopping with smartphone_5345090.png', 'public', '2025-12-25 11:20:48', '2025-12-25 11:20:48'),
(10, 4, 'hellop post', 'new content post', '1766683293_—Pngtree—concept online shopping with smartphone_5345090.png', 'public', '2025-12-25 11:21:33', '2025-12-25 11:21:33'),
(11, 4, 'hellop post', 'new content post', '1766683637_—Pngtree—concept online shopping with smartphone_5345090.png', 'public', '2025-12-25 11:27:17', '2025-12-25 11:27:17'),
(12, 6, 'hello', 'hi', NULL, 'public', '2025-12-25 13:45:31', '2025-12-25 13:45:31'),
(17, 7, 'my 1st post edited', '1st post edited', '1766723735_1761488284037.png', 'public', '2025-12-25 22:35:35', '2025-12-25 22:35:50'),
(18, 7, 'private post', 'this is private', NULL, 'private', '2025-12-25 22:40:43', '2025-12-25 22:40:43'),
(20, 7, 'private', 'privtae', NULL, 'private', '2025-12-25 22:44:54', '2025-12-25 22:44:54'),
(23, 7, 'Getting Started with Web Development in 2025', 'Web development is one of the most in-demand skills today, and the good news is that anyone can start learning it. Web development is the process of building websites and web applications that run in a browser.\r\n\r\nIt is usually divided into three main parts:\r\n\r\nHTML – structures the content of a webpage\r\n\r\nCSS – styles the page and controls layout, colors, and fonts\r\n\r\nJavaScript – adds interactivity like buttons, forms, and animations\r\n\r\nAs a beginner, focus on mastering HTML and CSS first. Once you’re comfortable, move on to JavaScript. You don’t need expensive tools—just a code editor like VS Code and a web browser.\r\n\r\nConsistency is key. Practice by building small projects such as a personal portfolio, a landing page, or a simple to-do app. These projects help you understand real-world problems and improve faster.\r\n\r\nWeb development is not just about coding; it’s about problem-solving and creativity. Start small, stay curious, and keep building.', '1766841029_ChatGPT Image Nov 2, 2025, 01_16_24 PM.png', 'public', '2025-12-27 07:10:29', '2025-12-27 07:10:29'),
(24, 7, 'Frontend vs Backend Development – What’s the Difference?', 'When learning web development, many beginners hear the terms frontend and backend and feel confused. Understanding the difference helps you choose the right path.\r\n\r\nFrontend development focuses on what users see and interact with. It includes:\r\n\r\nHTML, CSS, and JavaScript\r\n\r\nFrameworks like React, Vue, or Angular\r\n\r\nResponsive design and user experience\r\n\r\nFrontend developers make websites look good and work smoothly on all devices.\r\n\r\nBackend development handles what happens behind the scenes. It includes:\r\n\r\nServers and databases\r\n\r\nLanguages like Node.js, Python, PHP, or Java\r\n\r\nUser authentication and data management\r\n\r\nBackend developers ensure that data is stored securely and that everything works correctly.\r\n\r\nSome developers choose to become full-stack developers, meaning they work on both frontend and backend.\r\n\r\nThere is no “better” choice—only what matches your interests. If you enjoy design and visuals, frontend might be for you. If you like logic and data, backend could be the right path.', '1766841125_ChatGPT Image Nov 2, 2025, 01_20_33 PM.png', 'public', '2025-12-27 07:12:05', '2025-12-27 07:12:05'),
(25, 8, 'creating a new post', 'new post', NULL, 'private', '2025-12-27 07:22:38', '2025-12-27 07:22:38'),
(26, 7, 'new post edited', 'hello', NULL, 'public', '2026-01-01 01:07:22', '2026-01-01 01:07:47');

-- --------------------------------------------------------

--
-- Table structure for table `post_tag`
--

CREATE TABLE `post_tag` (
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `tag_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_tag`
--

INSERT INTO `post_tag` (`post_id`, `tag_id`) VALUES
(11, 1),
(11, 2);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('4T0soACo6rdwoC0FIQEok2s2LmH9yXE8gkSFnQBa', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUJ6OTVJWThJdFB3WnQxVXpDM3RobllvNmJtbUd1WURyellKSFhCdCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766645941),
('gPd9WF68UrZSkUZLVOdu7mJfS1gjoNhVP45OHdOs', NULL, '127.0.0.1', 'PostmanRuntime/7.51.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYjVGWnAwbjNueDFXYURrUDFGcU5OVHRpalYxRkZvOVRPQnZVWUx2bSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766671150),
('so45VrXXzPvLLLAqfdcQqtt0j9EtFjXbRMgK5xlU', NULL, '127.0.0.1', 'PostmanRuntime/7.51.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUzR6SE5ZSWRzeWU0M05nSU05bThXSkNwQWp1VTNNemd1WExsT1hTeSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766682958),
('UITevKNFphOoAUUwwG4dAIaCpJt7hUETY10EAvHn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYmJmdmJrdjBkdVAzUnV6MlFNbXVyaDB1WjRGeG9IeEZZQkgwRm93QSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767245371);

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Laravel', NULL, NULL),
(2, 'PHP', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `username`, `image`) VALUES
(1, 'Nowshin Eza', 'nowshin@example.com', NULL, '$2y$12$uayshyertYnmL9RQ50N5VuW0tHPH6BHbsTmh8VCLnpfUDSXxYADtW', NULL, '2025-12-25 01:02:32', '2025-12-25 01:02:32', 'nowshin', 'default.png'),
(2, 'Eza', 'nowshin@exple.com', NULL, '$2y$12$rGj34tgA9g9I7iWJ1l1RPOLrRKzwGQ80EFYTBLQEP/CQ7A9lWulHK', NULL, '2025-12-25 01:07:54', '2025-12-25 01:07:54', 'nowsh', 'default.png'),
(3, 'pizza', 'nowshin@mail.com', NULL, '$2y$12$83WcjDi0VGFmw6fXnU8VPeTdFIe/IcfBPEyNUm62V10rb5RslK.IO', NULL, '2025-12-25 08:02:12', '2025-12-25 08:55:25', 'nowshin pizza', '1766672009_WhatsApp_Image_2025-12-15_at_3.53.18_PM-removebg-preview.png'),
(4, 'akija', 'akija@mail.com', NULL, '$2y$12$ZcOVbpghYkQPqGWqGWhqjukRZnWqT89YHFWDFGtIsrRoaYAp9LdZe', NULL, '2025-12-25 08:56:29', '2025-12-25 09:00:01', 'akija', '1766674740_ChatGPT Image Nov 5, 2025, 02_54_09 AM.png'),
(5, 'eza', 'aa@gmail.com', NULL, '$2y$12$6gN0VoDav2fmfc90PjWnJO2LGVnDXxhVX70DpW1UdrOR0E8ANmjY2', NULL, '2025-12-25 13:28:33', '2025-12-25 13:28:33', 'aa', 'default.png'),
(6, 'ss', 'ss@gmail.com', NULL, '$2y$12$O2Cti5u68N9GkPV6kfjNu.Ak/.XGvbuJKDathifa0sv6r1loSwv8i', NULL, '2025-12-25 13:29:05', '2025-12-25 13:29:05', 'ss', 'default.png'),
(7, 'eza', 'eza@gmail.com', NULL, '$2y$12$p1LU.AOEVcf/hqiJCy/oJugeZABZmghS11Qxxts3S/pEv4fErTaFq', NULL, '2025-12-25 14:04:35', '2025-12-27 03:28:52', 'eza', 'default.png'),
(8, 'jeza', 'eza100@gmail.com', NULL, '$2y$12$.dcSNbrkNsJNnTQrVLFG4eAdbpTe1Bhaw/o7FKLNpEARvKh9J8Rfm', NULL, '2025-12-27 07:21:00', '2025-12-27 07:24:33', 'ezaaa', 'default.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookmarks_user_id_foreign` (`user_id`),
  ADD KEY `bookmarks_post_id_foreign` (`post_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_post_id_foreign` (`post_id`),
  ADD KEY `comments_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likes_user_id_foreign` (`user_id`),
  ADD KEY `likes_post_id_foreign` (`post_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_user_id_foreign` (`user_id`);

--
-- Indexes for table `post_tag`
--
ALTER TABLE `post_tag`
  ADD PRIMARY KEY (`post_id`,`tag_id`),
  ADD KEY `post_tag_tag_id_foreign` (`tag_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tags_name_unique` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_tag`
--
ALTER TABLE `post_tag`
  ADD CONSTRAINT `post_tag_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

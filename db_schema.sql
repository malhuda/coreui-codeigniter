-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 05, 2017 at 07:58 PM
-- Server version: 5.7.19-0ubuntu0.16.04.1-log
-- PHP Version: 5.6.31

SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `admin`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_tokens`
--

CREATE TABLE `auth_tokens` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `purpose` varchar(20) NOT NULL DEFAULT 'password_reset',
  `created_on` timestamp NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `role_permissions` longtext
) ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `role_permissions`) VALUES
(1, 'Admin', NULL),
(2, 'User', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `twostep_codes`
--

CREATE TABLE `twostep_codes` (
  `id` int(10) UNSIGNED NOT NULL,
  `twostep_code` int(6) NOT NULL,
  `mobile_number` varchar(20) NOT NULL,
  `created_on` timestamp NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `mobile_number` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `bio` text NOT NULL,
  `role` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `created_on` timestamp NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `first_name`, `last_name`, `mobile_number`, `password`, `bio`, `role`, `is_active`, `email_verified`, `created_on`, `updated_on`, `updated_by`) VALUES
(1, 'admin@example.com', 'John', 'Doe', '', '$2y$10$cbZ/7GpBKMEgcIUjN4ok1uFDaZjjm/NaUUPRmguLaZ9yx7kcJWuEa', '', 1, 1, 0, '2017-06-28 17:18:46', '2017-09-05 19:49:28', 55);

-- --------------------------------------------------------

--
-- Table structure for table `user_meta`
--

CREATE TABLE `user_meta` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `meta_key` varchar(100) NOT NULL,
  `meta_value` text
) ;

-- --------------------------------------------------------

--
-- Table structure for table `website_settings`
--

CREATE TABLE `website_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `setting_name` varchar(50) NOT NULL,
  `setting_value` text NOT NULL,
  `type` varchar(10) NOT NULL DEFAULT 'input',
  `options` text,
  `linked` varchar(50) DEFAULT NULL,
  `description` text,
  `setting_group` varchar(20) NOT NULL DEFAULT 'general'
) ;

--
-- Dumping data for table `website_settings`
--

INSERT INTO `website_settings` (`id`, `setting_name`, `setting_value`, `type`, `options`, `linked`, `description`, `setting_group`) VALUES
(1, 'website_name', 'CoreUI CodeIgniter', 'input', NULL, NULL, NULL, 'general'),
(2, 'website_url', '', 'input', NULL, NULL, NULL, 'general'),
(3, 'allow_registrations', 'yes', 'select', 'yes|no', NULL, NULL, 'user_registration'),
(4, 'users_can_edit_their_profiles', 'yes', 'select', 'yes|no', NULL, NULL, 'user_registration'),
(5, 'email_verification_required', 'no', 'select', 'yes|no', 'allow_registrations', 'If set to yes, users will have to verify their email addresses to activate their accounts for new registrations. This is not applicable on old registrations or users added by the admins.', 'user_registration'),
(7, 'two_factor_auth', 'no', 'select', 'yes|no', NULL, NULL, 'security'),
(8, 'sms_api_service', 'Twilio', 'select', 'Twilio', 'two_factor_auth', NULL, 'security'),
(9, 'sid', '', 'input', NULL, 'two_factor_auth', NULL, 'security'),
(10, 'auth_token', '', 'input', NULL, 'two_factor_auth', NULL, 'security'),
(11, 'twilio_number', '', 'input', NULL, 'two_factor_auth', 'Your Twilio number. Users will receive the two step auth codes from this number. The number should be active in your Twilio account.', 'security'),
(12, 'force_two_factor_auth', 'yes', 'select', 'yes|no', 'two_factor_auth', 'Users can turn on or off this option in their profile but if you force it for all, then all users will have to pass the 2-step auth challenge even if they have turned this option off in their profile. Remember that when this option is enabled, users will not be able to sign in if they don\'t have a valid mobile number set in their profile or if your API credentials are invalid.', 'security'),
(14, 'from_email', 'email@example.com', 'input', NULL, NULL, 'This email is set as \'From\' email on emails that are sent out from the website.', 'communication'),
(16, 'email_type', 'HTML', 'select', 'HTML', NULL, NULL, 'communication');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_tokens`
--
ALTER TABLE `auth_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `twostep_codes`
--
ALTER TABLE `twostep_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_meta`
--
ALTER TABLE `user_meta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `meta_key` (`meta_key`);

--
-- Indexes for table `website_settings`
--
ALTER TABLE `website_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_name` (`setting_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_tokens`
--
ALTER TABLE `auth_tokens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `twostep_codes`
--
ALTER TABLE `twostep_codes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_meta`
--
ALTER TABLE `user_meta`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `website_settings`
--
ALTER TABLE `website_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 30, 2024 at 01:37 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `loanlink`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `interest_rate` varchar(100) NOT NULL,
  `principle` varchar(100) NOT NULL,
  `Interest_amount` varchar(100) NOT NULL,
  `remaining` varchar(100) NOT NULL,
  `years` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`id`, `customer_id`, `loan_id`, `interest_rate`, `principle`, `Interest_amount`, `remaining`, `years`, `description`, `status`, `created_at`, `updated_at`) VALUES
(10, 1, 3, '7', '750000', '833688', '810530', '3', 'To my First Loan', 2, '2024-03-29 11:57:51', '2024-03-29 11:57:51'),
(11, 2, 3, '7', '200000', '229920', '229920', '4', 'ok', 3, '2024-03-30 06:16:06', '2024-03-30 06:16:06'),
(12, 2, 4, '9', '549632', '629244', '629244', '3', 'ok', 2, '2024-03-30 12:06:28', '2024-03-30 12:06:28');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `mobile`, `message`, `created_at`) VALUES
(1, 'Testing', 'test@gmail.com', '8485868589', 'Test Message', '2024-03-28 08:54:09'),
(2, 'Shikha', 'khush@gmail.com', '8684858282', 'My Message', '2024-03-28 08:56:19'),
(3, 'Reeta', '7653245467687@gmail.com', '8963256325', 'hiij', '2024-03-30 09:09:48');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(100) NOT NULL,
  `gender` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `mobile`, `gender`, `password`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Ram', 'ram@gmail.com', '8584868589', 'Male', 'eyJhbGciOiJIUzI1NiJ9.MTIzNDU2Nzg.xMxtPA6XjzU6xznsKELtQRrmiCttCEI6ic92xmZSsKs', 1, '2024-03-29 11:06:11', '2024-03-29 11:06:11'),
(2, 'Reha', 'reha@gmail.com', '9685665896', 'Female', 'eyJhbGciOiJIUzI1NiJ9.MTIzNDU2Nzg5.rACTLCVUgOP19Qfq0BaNDPpY9u-9gI1ILw1FLkNx7DM', 1, '2024-03-29 12:57:59', '2024-03-30 09:06:11'),
(3, 'Shikha', 'admin@gmail.com', '1514654651', 'Female', 'eyJhbGciOiJIUzI1NiJ9.MTIzNDU2Nzg5.rACTLCVUgOP19Qfq0BaNDPpY9u-9gI1ILw1FLkNx7DM', 1, '2024-03-29 12:59:15', '2024-03-29 12:59:15'),
(4, 'rehaa', 'rehaa@gmail.com', '5124127837', 'Female', 'eyJhbGciOiJIUzI1NiJ9.MTIzNDU2Nzg5.rACTLCVUgOP19Qfq0BaNDPpY9u-9gI1ILw1FLkNx7DM', 1, '2024-03-29 13:10:39', '2024-03-29 13:21:19'),
(5, 'teste', 'test@gmail.com', '8282828286', 'Prefer not to say', 'eyJhbGciOiJIUzI1NiJ9.MTIzNDU2Nzg5.rACTLCVUgOP19Qfq0BaNDPpY9u-9gI1ILw1FLkNx7DM', 1, '2024-03-30 10:14:30', '2024-03-30 10:14:30');

-- --------------------------------------------------------

--
-- Table structure for table `customer_info`
--

CREATE TABLE `customer_info` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `present_address` text NOT NULL,
  `permanent_address` text NOT NULL,
  `birthday` date NOT NULL,
  `income_id` int(11) NOT NULL,
  `aadhar_no` varchar(100) NOT NULL,
  `pan_no` varchar(100) NOT NULL,
  `occupation_id` int(11) NOT NULL,
  `income` varchar(100) NOT NULL,
  `aadhar_doc` varchar(100) NOT NULL,
  `pan_doc` varchar(100) NOT NULL,
  `emi_amount` varchar(100) NOT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `income_statement` varchar(255) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_info`
--

INSERT INTO `customer_info` (`id`, `customer_id`, `present_address`, `permanent_address`, `birthday`, `income_id`, `aadhar_no`, `pan_no`, `occupation_id`, `income`, `aadhar_doc`, `pan_doc`, `emi_amount`, `occupation`, `income_statement`, `photo`, `created_at`, `updated_at`) VALUES
(5, 1, 'Capace Software', 'Capace Software pvt Ltd', '2004-01-29', 1, '123456789012', '7586958446', 1, '450000', '1711713355109-circle.png', '1711713355109-circle.png', '30000', 'Private Employee', '1711713355109-circle.png', '1711713355103-circle.png', '2024-03-29 11:55:55', '2024-03-29 11:55:55'),
(6, 2, '2nd Floor, Nanjudeshwara plaza, 249, 24th Main Rd, opposite Nandini hotel, 5th Phase, J. P. Nagar, Bengaluru, Karnataka 560078', '2nd Floor, Nanjudeshwara plaza, 249, 24th Main Rd, opposite Nandini hotel, 5th Phase, J. P. Nagar, Bengaluru, Karnataka 560078', '1995-06-29', 3, '987653278987', 'jdhcfdhvjk', 3, '600000', '1711717706117-orange1.jpeg', '1711717706118-orange1.jpeg', '70000', 'self earning', '1711717706115-orange1.jpeg', '1711717706113-orange1.jpeg', '2024-03-29 13:08:26', '2024-03-30 09:06:10'),
(7, 4, '2nd Floor, Nanjudeshwara plaza, 249, 24th Main Rd, opposite Nandini hotel, 5th Phase, J. P. Nagar, Bengaluru, Karnataka 560078', '2nd Floor, Nanjudeshwara plaza, 249, 24th Main Rd, opposite Nandini hotel, 5th Phase, J. P. Nagar, Bengaluru, Karnataka 560078', '2004-06-29', 1, '456278937656', '2534362878', 3, '450000', '1711718005543-orange1.jpeg', '1711718005547-orange1.jpeg', '3000', NULL, '1711718005538-orange1.jpeg', '1711718005538-orange1.jpeg', '2024-03-29 13:13:25', '2024-03-29 13:21:19');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(11) NOT NULL,
  `document_name` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `document_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Aadhar card', 0, '2024-03-20 09:09:13', '2024-03-20 09:09:13');

-- --------------------------------------------------------

--
-- Table structure for table `emi`
--

CREATE TABLE `emi` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `amount` varchar(100) NOT NULL,
  `due_date` text NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_id` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emi`
--

INSERT INTO `emi` (`id`, `customer_id`, `loan_id`, `application_id`, `amount`, `due_date`, `status`, `created_at`, `updated_id`) VALUES
(298, 1, 3, 10, '23158', '1-3-2024', 1, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(299, 1, 3, 10, '23158', '1-5-2024', 2, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(300, 1, 3, 10, '23158', '1-7-2024', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(301, 1, 3, 10, '23158', '1-6-2024', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(302, 1, 3, 10, '23158', '1-8-2024', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(303, 1, 3, 10, '23158', '1-9-2024', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(304, 1, 3, 10, '23158', '1-10-2024', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(305, 1, 3, 10, '23158', '1-11-2024', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(306, 1, 3, 10, '23158', '1-12-2024', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(307, 1, 3, 10, '23158', '1-1-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(308, 1, 3, 10, '23158', '1-2-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(309, 1, 3, 10, '23158', '1-3-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(310, 1, 3, 10, '23158', '1-4-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(311, 1, 3, 10, '23158', '1-5-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(312, 1, 3, 10, '23158', '1-6-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(313, 1, 3, 10, '23158', '1-7-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(314, 1, 3, 10, '23158', '1-8-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(315, 1, 3, 10, '23158', '1-9-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(316, 1, 3, 10, '23158', '1-10-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(317, 1, 3, 10, '23158', '1-11-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(318, 1, 3, 10, '23158', '1-12-2025', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(319, 1, 3, 10, '23158', '1-1-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(320, 1, 3, 10, '23158', '1-2-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(321, 1, 3, 10, '23158', '1-3-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(322, 1, 3, 10, '23158', '1-4-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(323, 1, 3, 10, '23158', '1-5-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(324, 1, 3, 10, '23158', '1-6-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(325, 1, 3, 10, '23158', '1-7-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(326, 1, 3, 10, '23158', '1-8-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(327, 1, 3, 10, '23158', '1-9-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(328, 1, 3, 10, '23158', '1-10-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(329, 1, 3, 10, '23158', '1-11-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(330, 1, 3, 10, '23158', '1-12-2026', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(331, 1, 3, 10, '23158', '1-1-2027', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(332, 1, 3, 10, '23158', '1-2-2027', 0, '2024-03-29 11:58:34', '2024-03-29 11:58:34'),
(333, 2, 3, 11, '4790', '1-4-2024', 2, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(334, 2, 3, 11, '4790', '1-5-2024', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(335, 2, 3, 11, '4790', '1-6-2024', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(336, 2, 3, 11, '4790', '1-7-2024', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(337, 2, 3, 11, '4790', '1-8-2024', 2, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(338, 2, 3, 11, '4790', '1-9-2024', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(339, 2, 3, 11, '4790', '1-10-2024', 2, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(340, 2, 3, 11, '4790', '1-11-2024', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(341, 2, 3, 11, '4790', '1-12-2024', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(342, 2, 3, 11, '4790', '1-1-2025', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(343, 2, 3, 11, '4790', '1-2-2025', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(344, 2, 3, 11, '4790', '1-3-2025', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(345, 2, 3, 11, '4790', '1-4-2025', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(346, 2, 3, 11, '4790', '1-5-2025', 2, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(347, 2, 3, 11, '4790', '1-6-2025', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(348, 2, 3, 11, '4790', '1-7-2025', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(349, 2, 3, 11, '4790', '1-8-2025', 2, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(350, 2, 3, 11, '4790', '1-9-2025', 2, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(351, 2, 3, 11, '4790', '1-10-2025', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(352, 2, 3, 11, '4790', '1-11-2025', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(353, 2, 3, 11, '4790', '1-12-2025', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(354, 2, 3, 11, '4790', '1-1-2026', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(355, 2, 3, 11, '4790', '1-2-2026', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(356, 2, 3, 11, '4790', '1-3-2026', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(357, 2, 3, 11, '4790', '1-4-2026', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(358, 2, 3, 11, '4790', '1-5-2026', 1, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(359, 2, 3, 11, '4790', '1-6-2026', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(360, 2, 3, 11, '4790', '1-7-2026', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(361, 2, 3, 11, '4790', '1-8-2026', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(362, 2, 3, 11, '4790', '1-9-2026', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(363, 2, 3, 11, '4790', '1-10-2026', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(364, 2, 3, 11, '4790', '1-11-2026', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(365, 2, 3, 11, '4790', '1-12-2026', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(366, 2, 3, 11, '4790', '1-1-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(367, 2, 3, 11, '4790', '1-2-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(368, 2, 3, 11, '4790', '1-3-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(369, 2, 3, 11, '4790', '1-4-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(370, 2, 3, 11, '4790', '1-5-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(371, 2, 3, 11, '4790', '1-6-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(372, 2, 3, 11, '4790', '1-7-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(373, 2, 3, 11, '4790', '1-8-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(374, 2, 3, 11, '4790', '1-9-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(375, 2, 3, 11, '4790', '1-10-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(376, 2, 3, 11, '4790', '1-11-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(377, 2, 3, 11, '4790', '1-12-2027', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(378, 2, 3, 11, '4790', '1-1-2028', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(379, 2, 3, 11, '4790', '1-2-2028', 0, '2024-03-30 08:26:34', '2024-03-30 08:26:34'),
(380, 2, 4, 12, '17479', '1-4-2024', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(381, 2, 4, 12, '17479', '1-9-2026', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(382, 2, 4, 12, '17479', '1-10-2026', 2, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(383, 2, 4, 12, '17479', '1-11-2026', 2, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(384, 2, 4, 12, '17479', '1-5-2024', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(385, 2, 4, 12, '17479', '1-12-2026', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(386, 2, 4, 12, '17479', '1-1-2027', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(387, 2, 4, 12, '17479', '1-2-2027', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(388, 2, 4, 12, '17479', '1-9-2024', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(389, 2, 4, 12, '17479', '1-8-2024', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(390, 2, 4, 12, '17479', '1-7-2024', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(391, 2, 4, 12, '17479', '1-6-2024', 2, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(392, 2, 4, 12, '17479', '1-10-2024', 2, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(393, 2, 4, 12, '17479', '1-11-2024', 2, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(394, 2, 4, 12, '17479', '1-1-2025', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(395, 2, 4, 12, '17479', '1-12-2024', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(396, 2, 4, 12, '17479', '1-5-2025', 1, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(397, 2, 4, 12, '17479', '1-4-2025', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(398, 2, 4, 12, '17479', '1-3-2025', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(399, 2, 4, 12, '17479', '1-2-2025', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(400, 2, 4, 12, '17479', '1-7-2025', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(401, 2, 4, 12, '17479', '1-6-2025', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(402, 2, 4, 12, '17479', '1-8-2025', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(403, 2, 4, 12, '17479', '1-9-2025', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(404, 2, 4, 12, '17479', '1-11-2025', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(405, 2, 4, 12, '17479', '1-10-2025', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(406, 2, 4, 12, '17479', '1-12-2025', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(407, 2, 4, 12, '17479', '1-1-2026', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(408, 2, 4, 12, '17479', '1-2-2026', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(409, 2, 4, 12, '17479', '1-3-2026', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(410, 2, 4, 12, '17479', '1-5-2026', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(411, 2, 4, 12, '17479', '1-4-2026', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(412, 2, 4, 12, '17479', '1-7-2026', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(413, 2, 4, 12, '17479', '1-6-2026', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24'),
(414, 2, 4, 12, '17479', '1-8-2026', 0, '2024-03-30 12:07:24', '2024-03-30 12:07:24');

-- --------------------------------------------------------

--
-- Table structure for table `income_category`
--

CREATE TABLE `income_category` (
  `id` int(11) NOT NULL,
  `max_income` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `income_category`
--

INSERT INTO `income_category` (`id`, `max_income`, `status`, `created_at`, `updated_at`) VALUES
(1, '500000', 1, '2024-03-21 05:30:01', '2024-03-21 05:30:01'),
(2, '300000', 1, '2024-03-21 05:41:34', '2024-03-21 05:41:34'),
(3, '700000', 1, '2024-03-21 05:41:44', '2024-03-21 05:41:44'),
(4, '900000', 1, '2024-03-21 05:41:47', '2024-03-21 05:41:47'),
(5, '1200000', 1, '2024-03-21 05:42:09', '2024-03-21 05:42:09'),
(6, '1200001', 1, '2024-03-21 05:42:13', '2024-03-21 05:42:13');

-- --------------------------------------------------------

--
-- Table structure for table `loan_types`
--

CREATE TABLE `loan_types` (
  `id` int(11) NOT NULL,
  `loan_name` varchar(100) NOT NULL,
  `gist` varchar(100) NOT NULL,
  `summary` text NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `interest_rate` varchar(100) NOT NULL,
  `tc_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_types`
--

INSERT INTO `loan_types` (`id`, `loan_name`, `gist`, `summary`, `description`, `image`, `interest_rate`, `tc_id`, `status`, `created_at`, `updated_at`) VALUES
(3, 'Student Loan', 'Testing', '<ul><li><span style=\"color: var(--tw-prose-bold);\">Tailored Financing</span>: Personalized loan options to suit your educational needs and financial circumstances.</li><li><span style=\"color: var(--tw-prose-bold);\">Competitive Rates</span>: Enjoy competitive interest rates that make borrowing more affordable.</li><li><span style=\"color: var(--tw-prose-bold);\">Streamlined Application Process</span>: Quick and easy application process, so you can focus on your studies, not paperwork.</li><li><span style=\"color: var(--tw-prose-bold);\">Grace Period</span>: Benefit from a grace period after graduation before starting repayment, giving you time to secure employment.</li></ul>', '<h2><span style=\"color: inherit;\">Unlock Your Educational Dreams with Our Student Loans!</span></h2><p><span style=\"color: var(--tw-prose-bold);\">Embarking on your academic journey?</span> Let our <span style=\"color: var(--tw-prose-bold);\">Student Loans</span> be your compass! At [Company Name], we understand the value of education and the financial hurdles students face. Our <span style=\"color: var(--tw-prose-bold);\">Student Loans</span> offer a pathway to higher learning, providing <span style=\"color: var(--tw-prose-bold);\">flexible financing</span> tailored to your needs. With competitive <span style=\"color: var(--tw-prose-bold);\">interest rates</span> and <span style=\"color: var(--tw-prose-bold);\">easy repayment options</span>, we make pursuing your dreams affordable. Whether you\'re a first-year undergraduate or a graduate student aiming for the stars, our <span style=\"color: var(--tw-prose-bold);\">comprehensive financial solutions</span> ensure that tuition fees, books, accommodation, and other essentials are within reach. <span style=\"color: var(--tw-prose-bold);\">Federal or private</span>, we\'ve got you covered, ensuring access to the funds you need to succeed. Our dedicated team is here to guide you through the process, offering <span style=\"color: var(--tw-prose-bold);\">expert advice</span> and personalized assistance every step of the way. Don\'t let financial worries hold you back—<span style=\"color: var(--tw-prose-bold);\">invest in your future</span> with our Student Loans today!</p><p><span style=\"color: var(--tw-prose-bold);\">Benefits of Our Student Loans:</span></p><ul><li><span style=\"color: var(--tw-prose-bold);\">Tailored Financing</span>: Personalized loan options to suit your educational needs and financial circumstances.</li><li><span style=\"color: var(--tw-prose-bold);\">Competitive Rates</span>: Enjoy competitive interest rates that make borrowing more affordable.</li><li><span style=\"color: var(--tw-prose-bold);\">Streamlined Application Process</span>: Quick and easy application process, so you can focus on your studies, not paperwork.</li><li><span style=\"color: var(--tw-prose-bold);\">Grace Period</span>: Benefit from a grace period after graduation before starting repayment, giving you time to secure employment.</li><li><span style=\"color: var(--tw-prose-bold);\">Flexible Repayment Options</span>: Choose from a variety of repayment plans to fit your budget and income level.</li><li><span style=\"color: var(--tw-prose-bold);\">Expert Guidance</span>: Access to knowledgeable advisors who can assist you with loan inquiries and financial planning.</li><li><span style=\"color: var(--tw-prose-bold);\">Transparent Terms</span>: Clear and transparent terms, so you know exactly what you\'re getting into before borrowing.</li><li><span style=\"color: var(--tw-prose-bold);\">Building Credit</span>: Opportunity to build a positive credit history through responsible borrowing and timely repayments.</li><li><span style=\"color: var(--tw-prose-bold);\">Supportive Customer Service</span>: Friendly and supportive customer service team available to address any concerns or questions you may have.</li><li><span style=\"color: var(--tw-prose-bold);\">Investing in Your Future</span>: Invest in your education and future success with confidence, knowing that financial support is readily available.</li></ul>', '2205.jpg', '7.2', 1, 1, '2024-03-22 10:10:02', '2024-03-22 10:10:02'),
(4, 'Home Loan', 'This is a Home Loan', '<ol><li>Small Summary</li><li>Second Summary</li><li>Third</li></ol>', '<p>Big Description</p><p><strong style=\"color: rgb(232, 234, 237);\">What is Lorem Ipsum in English?</strong></p><p><strong>Lorem ipsum,&nbsp;</strong><strong style=\"color: rgb(226, 238, 255); background-color: rgb(58, 63, 80);\">placeholder or dummy text used in typesetting and graphic design for previewing layouts</strong><strong>. It features scrambled Latin text, which emphasizes the design over content of the layout. It is the standard placeholder text of the printing and publishing industries.</strong></p>', 'test.png', '9', 1, 1, '2024-03-28 07:29:05', '2024-03-28 07:29:05'),
(5, 'Home Loan', 'This is a Home Loan', '<ol><li>Dummary 1</li><li>Summary 2</li><li>Sumary 3</li></ol>', '<p><strong style=\"color: rgb(232, 234, 237);\">What is Lorem Ipsum in English?</strong></p><p><strong>Lorem ipsum,&nbsp;</strong><strong style=\"color: rgb(226, 238, 255); background-color: rgb(58, 63, 80);\">placeholder or dummy text used in typesetting and graphic design for previewing layouts</strong><strong>. It features scrambled Latin text, which emphasizes the design over content of the layout. It is the standard placeholder text of the printing and publishing industries.</strong></p>', '1711616884487-Screenshot 2023-11-25 110225.png', '9', 1, 1, '2024-03-28 09:08:04', '2024-03-28 09:08:04');

-- --------------------------------------------------------

--
-- Table structure for table `occupation`
--

CREATE TABLE `occupation` (
  `id` int(11) NOT NULL,
  `occupation_name` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `occupation`
--

INSERT INTO `occupation` (`id`, `occupation_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Others', 1, '2024-03-21 12:40:15', '2024-03-21 12:40:15'),
(2, 'Student', 1, '2024-03-22 09:46:33', '2024-03-22 09:46:33'),
(3, 'Unemployed', 1, '2024-03-22 09:46:33', '2024-03-22 09:46:33');

-- --------------------------------------------------------

--
-- Table structure for table `principle`
--

CREATE TABLE `principle` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `amount` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `ratings` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`id`, `customer_id`, `loan_id`, `description`, `ratings`, `created_at`, `updated_at`) VALUES
(12, 1, 3, 'Nivee', 1, '2024-03-30 06:43:23', '2024-03-30 06:43:23');

-- --------------------------------------------------------

--
-- Table structure for table `tc`
--

CREATE TABLE `tc` (
  `id` int(11) NOT NULL,
  `tc_name` varchar(100) NOT NULL,
  `conditions` text NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tc`
--

INSERT INTO `tc` (`id`, `tc_name`, `conditions`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Lorem ipsum', '<h2>What is Lorem Ipsum?</h2><p class=\"ql-align-justify\"><strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p><p><br></p>', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Accured', '<ul><li class=\"ql-align-justify\">The accrued interest during the moratorium period and course period is added to the principle and repayment is fixed in Equated Monthly Installments (EMI).</li><li class=\"ql-align-justify\">If full interest is serviced before the commencement of repayment; EMI is fixed based on principle amount only.</li></ul>', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`,`mobile`);

--
-- Indexes for table `customer_info`
--
ALTER TABLE `customer_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_id` (`customer_id`),
  ADD UNIQUE KEY `aadhar_no` (`aadhar_no`,`pan_no`),
  ADD KEY `income_id` (`income_id`),
  ADD KEY `occupation_id` (`occupation_id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emi`
--
ALTER TABLE `emi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `loan_id` (`loan_id`),
  ADD KEY `application_id` (`application_id`);

--
-- Indexes for table `income_category`
--
ALTER TABLE `income_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_types`
--
ALTER TABLE `loan_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tc_id` (`tc_id`);

--
-- Indexes for table `occupation`
--
ALTER TABLE `occupation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `principle`
--
ALTER TABLE `principle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `loan_id` (`loan_id`),
  ADD KEY `application_id` (`application_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_id` (`customer_id`,`loan_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `tc`
--
ALTER TABLE `tc`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customer_info`
--
ALTER TABLE `customer_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `emi`
--
ALTER TABLE `emi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=415;

--
-- AUTO_INCREMENT for table `income_category`
--
ALTER TABLE `income_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `loan_types`
--
ALTER TABLE `loan_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `occupation`
--
ALTER TABLE `occupation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `principle`
--
ALTER TABLE `principle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tc`
--
ALTER TABLE `tc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loan_types` (`id`);

--
-- Constraints for table `customer_info`
--
ALTER TABLE `customer_info`
  ADD CONSTRAINT `customer_info_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `customer_info_ibfk_2` FOREIGN KEY (`income_id`) REFERENCES `income_category` (`id`),
  ADD CONSTRAINT `customer_info_ibfk_3` FOREIGN KEY (`occupation_id`) REFERENCES `occupation` (`id`);

--
-- Constraints for table `emi`
--
ALTER TABLE `emi`
  ADD CONSTRAINT `emi_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `emi_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loan_types` (`id`),
  ADD CONSTRAINT `emi_ibfk_3` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`);

--
-- Constraints for table `loan_types`
--
ALTER TABLE `loan_types`
  ADD CONSTRAINT `fk_tc_id` FOREIGN KEY (`tc_id`) REFERENCES `tc` (`id`);

--
-- Constraints for table `principle`
--
ALTER TABLE `principle`
  ADD CONSTRAINT `principle_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `principle_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loan_types` (`id`),
  ADD CONSTRAINT `principle_ibfk_3` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loan_types` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

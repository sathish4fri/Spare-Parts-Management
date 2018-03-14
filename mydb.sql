-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 13, 2018 at 11:02 AM
-- Server version: 5.5.44-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `area`
--

CREATE TABLE IF NOT EXISTS `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_name` varchar(45) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` enum('0','1') DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `area`
--

INSERT INTO `area` (`id`, `area_name`, `status`, `created_at`, `updated_at`, `is_delete`) VALUES
(1, 'vellore', '1', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE IF NOT EXISTS `employee` (
  `eid` int(11) NOT NULL AUTO_INCREMENT,
  `emp_firstname` varchar(45) DEFAULT NULL,
  `emp_lastname` varchar(45) DEFAULT NULL,
  `designation` varchar(45) DEFAULT NULL,
  `emp_id` varchar(45) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` enum('0','1') DEFAULT '0',
  PRIMARY KEY (`eid`),
  UNIQUE KEY `emp_id_UNIQUE` (`emp_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`eid`, `emp_firstname`, `emp_lastname`, `designation`, `emp_id`, `status`, `created_at`, `updated_at`, `is_delete`) VALUES
(1, 'Deepan', 'K', 'Analyst', '588840', '1', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `issue_list`
--

CREATE TABLE IF NOT EXISTS `issue_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `ticket_no` varchar(45) DEFAULT NULL,
  `emp_id` varchar(45) DEFAULT NULL,
  `is_delete` enum('0','1') DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `issue_list`
--

INSERT INTO `issue_list` (`id`, `item_id`, `quantity`, `ticket_no`, `emp_id`, `is_delete`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 5, '544450', '1', '0', 1, 1, NULL, NULL),
(2, 1, 2, '588840', '1', '0', 1, 1, '2018-03-13 06:30:00', '2018-03-13 05:29:58');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(45) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` enum('0','1') DEFAULT '0',
  `remarks` text,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `item_name`, `status`, `created_at`, `updated_at`, `is_delete`, `remarks`) VALUES
(1, 'RAM', '1', NULL, NULL, '0', 'fuck'),
(2, 'Intel Processor', '1', '2018-03-12 18:30:00', '2018-03-13 04:45:48', '0', 'yes its good');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE IF NOT EXISTS `purchase` (
  `pur_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `vendor` text,
  `specification` text,
  `quantity` double DEFAULT NULL,
  `warranty_period` varchar(45) DEFAULT NULL,
  `invoice_no` varchar(45) DEFAULT NULL,
  `serial_no` varchar(45) DEFAULT NULL,
  `is_delete` enum('0','1') DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pur_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`pur_id`, `item_id`, `vendor`, `specification`, `quantity`, `warranty_period`, `invoice_no`, `serial_no`, `is_delete`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'm/s venus electronics', 'i3', 2, '4', '12345', '24234234234', '0', 1, 1, '2018-03-12 18:30:00', '2018-03-13 04:36:42'),
(2, 1, 'venus electronics', 'i3', 2, '4', '12345', '24234234234', '0', 1, 1, '2018-03-12 18:30:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reorder`
--

CREATE TABLE IF NOT EXISTS `reorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `level_count` int(11) DEFAULT NULL,
  `is_delete` enum('0','1') DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_login`
--

CREATE TABLE IF NOT EXISTS `user_login` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `type` enum('a','b','c') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` enum('0','1') DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

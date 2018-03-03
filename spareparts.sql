-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 03, 2018 at 09:00 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 5.6.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spareparts`
--

-- --------------------------------------------------------

--
-- Table structure for table `itemlist`
--

CREATE TABLE `itemlist` (
  `id` int(50) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `itemlist`
--

INSERT INTO `itemlist` (`id`, `name`) VALUES
(1, 'PowerCard'),
(2, 'Mouse');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `currentdate` datetime(5) NOT NULL DEFAULT CURRENT_TIMESTAMP(5),
  `name` varchar(50) NOT NULL,
  `specification` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `serialno` int(50) NOT NULL,
  `invoiceno` int(50) NOT NULL,
  `warrantyperiod` varchar(50) NOT NULL,
  `updatedby` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `currentdate`, `name`, `specification`, `quantity`, `serialno`, `invoiceno`, `warrantyperiod`, `updatedby`) VALUES
(1, '2018-02-24 21:57:27.92517', 'Power Cord', 'cable', 3, 1234567, 2147483647, '2 years', 'Srini'),
(3, '2018-02-24 22:01:32.72455', 'Power Cord', 'asd', 3, 1234567, 2147483647, '2 years', 'Srini'),
(4, '2018-02-25 08:52:55.55768', 'asdas', 'asd', 12, 12, 12, '12', 'asdasdas'),
(5, '2018-02-25 09:00:08.38634', 'sri', 'asda', 12, 2147483647, 2147483647, '2 y', 'sathish');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `itemlist`
--
ALTER TABLE `itemlist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `itemlist`
--
ALTER TABLE `itemlist`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

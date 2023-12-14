-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 13, 2023 at 04:14 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webbanlaptop`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_category`
--

CREATE TABLE `tbl_category` (
  `id` int(11) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(45) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `seo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Bảng dữ liệu chứa danh mục sản phẩm';

--
-- Dumping data for table `tbl_category`
--

INSERT INTO `tbl_category` (`id`, `name`, `description`, `created_date`, `updated_date`, `created_by`, `updated_by`, `parent_id`, `status`, `seo`) VALUES
(12, 'Acer', 'Acer category', NULL, NULL, NULL, NULL, NULL, 1, 'acer'),
(13, 'Asus', 'Asus category', NULL, NULL, NULL, NULL, NULL, 1, 'asus'),
(14, 'Dell', 'Dell category', NULL, NULL, NULL, NULL, NULL, 1, 'dell'),
(15, 'Apple', 'Apple category', NULL, NULL, NULL, NULL, NULL, 1, 'apple'),
(16, 'Lenovo', 'Description for Lenovo category', NULL, NULL, NULL, NULL, NULL, 1, 'lenovo');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_contact`
--

CREATE TABLE `tbl_contact` (
  `id` int(11) NOT NULL,
  `first_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `request_type` varchar(45) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Bảng dữ liệu chứa thông tin liên hệ';

-- --------------------------------------------------------

--
-- Table structure for table `tbl_passwordresettokens`
--

CREATE TABLE `tbl_passwordresettokens` (
  `id` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  `expirydate` datetime DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_passwordresettokens`
--

INSERT INTO `tbl_passwordresettokens` (`id`, `created_by`, `created_date`, `updated_by`, `status`, `updated_date`, `expirydate`, `token`, `user_id`) VALUES
(5, NULL, NULL, NULL, 0, NULL, '2023-11-14 19:08:24', '09b3ffaa-f850-45f0-a96c-b76380e7d4c1', 6),
(6, NULL, NULL, NULL, 0, NULL, '2023-11-14 19:10:22', '55df65e1-5d3b-4b0c-8d83-8d80be2f960c', 6),
(7, NULL, NULL, NULL, 0, NULL, '2023-11-14 19:43:17', 'b25eb50f-b602-4ea7-99ca-ad73ccabc2ec', 6),
(8, NULL, NULL, NULL, 0, NULL, '2023-11-14 19:50:43', '7f6dffc3-72f0-4adc-ae13-aadab6de046b', 6),
(9, NULL, NULL, NULL, 0, NULL, '2023-11-14 19:53:54', '5ea2171e-fae1-4564-b93c-01816e3b37c3', 6),
(10, NULL, NULL, NULL, 0, NULL, '2023-11-14 20:28:02', '1ca9c080-a9f1-41a2-bd66-d7b56d3b6b9b', 6),
(11, NULL, NULL, NULL, 0, NULL, '2023-11-14 20:28:30', 'd8613c78-2c8d-47fc-b2fd-b6fe9e42def0', 6),
(12, NULL, NULL, NULL, 0, NULL, '2023-11-14 20:29:22', 'e2dbfae2-0845-4295-bff6-12147d2c6170', 6),
(13, NULL, NULL, NULL, 0, NULL, '2023-11-14 20:30:02', '717224b3-1b15-4058-bd5c-ba3e715749b0', 6),
(14, NULL, NULL, NULL, 0, NULL, '2023-11-14 20:31:16', '7eecbef1-09d5-4275-8702-45bed7f82db0', 6),
(15, NULL, NULL, NULL, 0, NULL, '2023-11-15 20:29:21', '5d71670f-6c77-4479-9a53-d10d2a485220', 6),
(16, NULL, NULL, NULL, 0, NULL, '2023-11-15 20:35:31', 'c19f42ad-628e-49cc-9e23-02a62fb8204a', 6);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

CREATE TABLE `tbl_products` (
  `id` int(11) NOT NULL,
  `title` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(13,2) DEFAULT NULL,
  `short_description` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail_description` text NOT NULL,
  `avatar` varchar(200) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `seo` varchar(1000) DEFAULT NULL,
  `CPU` varchar(255) DEFAULT NULL,
  `Display` varchar(255) DEFAULT NULL,
  `Ram` varchar(255) DEFAULT NULL,
  `Storage` varchar(255) DEFAULT NULL,
  `Vga` varchar(255) DEFAULT NULL,
  `discount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Bảng dữ liệu chứa danh mục sản phẩm';

--
-- Dumping data for table `tbl_products`
--

INSERT INTO `tbl_products` (`id`, `title`, `price`, `short_description`, `detail_description`, `avatar`, `category_id`, `created_date`, `updated_date`, `created_by`, `updated_by`, `status`, `seo`, `CPU`, `Display`, `Ram`, `Storage`, `Vga`, `discount`) VALUES
(37, 'Asus 01', 10000000.00, 'none', '<p>none1<br></p>', NULL, 13, NULL, '2023-11-12 22:01:54', NULL, NULL, 0, 'asus-01-1684368422389', NULL, NULL, NULL, NULL, NULL, 0),
(38, 'Acer 01', 5000000.00, 'this is description', '<p>detail description<br></p>', NULL, 12, NULL, NULL, NULL, NULL, 1, 'acer-01-1702390217636', 'Intel core I3 6100', '144HZ', '8GB', '500GB SSD', 'RTX 3090', 25),
(39, 'Dell 01', 7500000.00, 'des03', '<p>detail des03<br></p>', NULL, 14, NULL, NULL, NULL, NULL, 1, 'dell-01-1702104694747', 'I9 7900XE', '15.6 inch 144Hz', '16GB 3200MHz', '500GB SSD', 'RTX 4080', 0),
(40, 'Acer 05', 8000000.00, 'Mo ta cua Acer 05', '<p>Mo ta chi tiet Asus 05<br></p>', NULL, 12, NULL, NULL, NULL, NULL, 1, 'acer-05-1702261206481', 'I9 7900XE', '15.6 inch 144Hz', '32GB 3200MHz', '500GB SSD', 'RTX 3070ti', 15),
(41, 'Apple 01', 9000000.00, 'Description of Apple 01', '<p>Detail des of Apple 01<br></p>', NULL, 15, NULL, NULL, NULL, NULL, 1, 'apple-01-1684368952443', NULL, NULL, NULL, NULL, NULL, 0),
(42, 'Dell 04', 12000000.00, 'Description of Dell 04', '<p>Detail des of Dell 04<br></p>', NULL, 14, NULL, NULL, NULL, NULL, 1, 'dell-04-1701481285221', NULL, NULL, NULL, NULL, NULL, 0),
(43, 'Mac 10', 15000000.00, 'description for apple mac 10', '', NULL, 15, NULL, NULL, NULL, NULL, 1, 'mac-10-1702119864661', 'M10', 'Retina', '8GB', '256Gb', 'Apple iris', 20),
(44, 'Dell XPS 13', 29899770.00, 'Ultra-thin and lightweight laptop', 'The Dell XPS 13 is a premium ultrabook with a stunning InfinityEdge display.', NULL, 12, NULL, NULL, NULL, NULL, 1, 'dell-xps-13-ultrabook', 'Intel Core i7', '13.4 inch FHD+', '16GB', '512GB SSD', 'Intel Iris Xe Graphics', 5),
(45, 'MacBook Air', 22999770.00, 'Thin and powerful, perfect for everyday use', 'The MacBook Air is designed for portability and performance, featuring Apples M1 chip.', NULL, 13, NULL, NULL, NULL, NULL, 1, 'macbook-air', 'Apple M1', '13.3 inch Retina', '8GB', '256GB SSD', 'Apple M1 GPU', 10),
(46, 'HP Spectre x360', 34499770.00, 'Convertible laptop with 4K OLED display', 'The HP Spectre x360 is a versatile 2-in-1 laptop with a stunning 4K OLED display.', NULL, 14, NULL, NULL, NULL, NULL, 1, 'hp-spectre-x360', 'Intel Core i7', '15.6 inch 4K OLED', '16GB', '1TB SSD', 'NVIDIA GeForce GTX 1650 Ti', 15),
(47, 'Asus ROG Zephyrus G14', 29899770.00, 'Powerful gaming laptop with Ryzen 9', 'The Asus ROG Zephyrus G14 is a compact gaming laptop featuring AMD Ryzen 9 and NVIDIA RTX 3060.', NULL, 15, NULL, NULL, NULL, NULL, 1, 'asus-rog-zephyrus-g14', 'AMD Ryzen 9', '14 inch QHD', '16GB', '1TB SSD', 'NVIDIA GeForce RTX 3060', 8),
(48, 'Lenovo ThinkPad X1 Carbon', 32199770.00, 'Business laptop with a durable design', 'The Lenovo ThinkPad X1 Carbon is a reliable business laptop with a durable chassis and impressive performance.', NULL, 16, NULL, NULL, NULL, NULL, 1, 'lenovo-thinkpad-x1-carbon', 'Intel Core i7', '14 inch FHD', '16GB', '512GB SSD', 'Intel UHD Graphics', 12),
(49, 'Acer Predator Helios 300', 27599770.00, 'Affordable gaming laptop with high refresh rate', 'The Acer Predator Helios 300 offers great gaming performance with a high refresh rate display.', NULL, 12, NULL, NULL, NULL, NULL, 1, 'acer-predator-helios-300-1702388359435', 'Intel Core i7', '15.6 inch 144Hz', '16GB', '512GB SSD', 'NVIDIA GeForce RTX 3060', 5),
(50, 'Microsoft Surface Laptop 4', 25299770.00, 'Sleek and elegant design with a touchscreen', 'The Microsoft Surface Laptop 4 combines style and functionality with a responsive touchscreen.', NULL, 13, NULL, NULL, NULL, NULL, 1, 'microsoft-surface-laptop-4', 'Intel Core i5', '13.5 inch PixelSense', '8GB', '256GB SSD', 'Intel Iris Xe Graphics', 8),
(51, 'Razer Blade 15', 36799770.00, 'Premium gaming laptop with customizable RGB', 'The Razer Blade 15 is a high-end gaming laptop with a sleek design and customizable RGB lighting.', NULL, 14, NULL, NULL, NULL, NULL, 1, 'razer-blade-15', 'Intel Core i7', '15.6 inch 240Hz', '16GB', '1TB SSD', 'NVIDIA GeForce RTX 3070', 15),
(52, 'LG Gram 17', 32199770.00, 'Ultra-lightweight laptop with a large display', 'The LG Gram 17 is an ultra-lightweight laptop with a 17-inch display, perfect for productivity.', NULL, 15, NULL, NULL, NULL, NULL, 1, 'lg-gram-17', 'Intel Core i7', '17 inch WQXGA', '16GB', '1TB SSD', 'Intel Iris Xe Graphics', 12),
(53, 'Alienware m15 R6', 43699770.00, 'Extreme gaming performance with Alienware design', 'The Alienware m15 R6 is a powerful gaming laptop with cutting-edge hardware and futuristic design.', NULL, 16, NULL, NULL, NULL, NULL, 1, 'alienware-m15-r6-1702261965957', 'Intel Core i9', '15.6 inch 360Hz', '32GB', '2TB SSD', 'NVIDIA GeForce RTX 3080', 20),
(54, 'Lenovo Legion 5', 25299770.00, 'Powerful gaming laptop with Ryzen 7', 'The Lenovo Legion 5 offers a great gaming experience with AMD Ryzen 7 and NVIDIA GTX 1660 Ti.', NULL, 15, NULL, NULL, NULL, NULL, 1, 'lenovo-legion-5', 'AMD Ryzen 7', '15.6 inch 120Hz', '16GB', '512GB SSD', 'NVIDIA GeForce GTX 1660 Ti', 10),
(55, 'Dell Inspiron 14', 16099770.00, 'Budget-friendly laptop for everyday use', 'The Dell Inspiron 14 is a reliable laptop for everyday tasks with an affordable price tag.', NULL, 14, NULL, NULL, NULL, NULL, 1, 'dell-inspiron-14', 'Intel Core i5', '14 inch HD', '8GB', '256GB SSD', 'Intel UHD Graphics', 5);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products_images`
--

CREATE TABLE `tbl_products_images` (
  `id` int(11) NOT NULL,
  `title` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` varchar(200) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Bảng dữ liệu danh sách ảnh sản phẩm';

--
-- Dumping data for table `tbl_products_images`
--

INSERT INTO `tbl_products_images` (`id`, `title`, `path`, `product_id`, `created_date`, `updated_date`, `created_by`, `updated_by`, `status`) VALUES
(18, 'sanpham-5.jpg', 'sanpham-5.jpg', 37, NULL, NULL, NULL, NULL, 0),
(20, 'sanpham-3.jpg', 'sanpham-3.jpg', 41, NULL, NULL, NULL, NULL, 0),
(25, 'mathang-5.jpg', 'mathang-5.jpg', 39, NULL, NULL, NULL, NULL, 0),
(38, 'laptop-hp-envy-2.jpg', 'laptop-hp-envy-2.jpg', 42, NULL, NULL, NULL, NULL, 0),
(45, 'hill-climbing-algorithm-in-ai.png', 'hill-climbing-algorithm-in-ai.png', 40, NULL, NULL, NULL, NULL, 0),
(49, 'util_fuction.png', 'util_fuction.png', 53, NULL, NULL, NULL, NULL, 0),
(77, 'getneighbor.png', 'getneighbor.png', 49, NULL, NULL, NULL, NULL, 0),
(78, 'hill-climbing-algorithm-in-ai.png', 'hill-climbing-algorithm-in-ai.png', 49, NULL, NULL, NULL, NULL, 0),
(118, 'c1c2c3.png', 'c1c2c3.png', 38, NULL, NULL, NULL, NULL, 0),
(120, 'getneighbor.png', 'getneighbor.png', 38, NULL, NULL, NULL, NULL, 0),
(121, 'hill-climbing-algorithm-in-ai.png', 'hill-climbing-algorithm-in-ai.png', 38, NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Bảng dữ liệu chứa thông tin roles';

--
-- Dumping data for table `tbl_roles`
--

INSERT INTO `tbl_roles` (`id`, `name`, `description`, `created_date`, `updated_date`, `created_by`, `updated_by`, `status`) VALUES
(1, 'ADMIN', 'Admin', '2020-11-10 00:00:00', '2020-11-10 00:00:00', 2020, 2020, 1),
(2, 'Client', 'Client', '2023-04-27 04:05:20', NULL, NULL, NULL, 1),
(3, 'Nhan Vien', 'Staff', '2023-05-17 15:35:23', NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_saleorder`
--

CREATE TABLE `tbl_saleorder` (
  `id` int(11) NOT NULL,
  `code` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(11) DEFAULT NULL,
  `total` decimal(13,2) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `customer_name` varchar(500) DEFAULT NULL,
  `customer_address` varchar(500) DEFAULT NULL,
  `seo` varchar(45) DEFAULT NULL,
  `customer_email` varchar(500) DEFAULT NULL,
  `customer_phone` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Bảng dữ liệu chứa phiếu mua hàng';

--
-- Dumping data for table `tbl_saleorder`
--

INSERT INTO `tbl_saleorder` (`id`, `code`, `user_id`, `total`, `created_date`, `updated_date`, `created_by`, `updated_by`, `status`, `customer_name`, `customer_address`, `seo`, `customer_email`, `customer_phone`) VALUES
(7, 'ORDER-1683469563204', '6', 300.00, '2023-05-07 21:26:03', NULL, NULL, NULL, 0, 'Lastname', '1234 somewhere', 'ORDER-1683469563204', '12345@gmail.com', '123456'),
(8, 'ORDER-1683773264570', '6', 800.00, '2023-05-11 09:47:44', NULL, NULL, NULL, 1, 'Lastname', '1234 somewhere', 'ORDER-1683773264570', '12345@gmail.com', '123456'),
(9, 'ORDER-1683774734920', '6', 800.00, '2023-05-11 10:12:14', NULL, NULL, NULL, 1, 'Lastname', '1234 somewhere', 'ORDER-1683774734920', '12345@gmail.com', '123456'),
(10, 'ORDER-1683775194473', '8', 200.00, '2023-05-11 10:19:54', NULL, NULL, NULL, 1, 'sdadas', 'ewe', 'ORDER-1683775194473', 'dadsad34@gmail.com', '123214214'),
(11, 'ORDER-1683777703875', '6', 500.00, '2023-05-11 11:01:43', NULL, NULL, NULL, 1, 'Lastname', '1234 somewhere', 'ORDER-1683777703875', '12345@gmail.com', '123456'),
(12, 'ORDER-1684368246609', NULL, 300.00, '2023-05-18 07:04:06', NULL, NULL, NULL, 1, 'khanh', '', 'ORDER-1684368246609', '1234', '8888'),
(13, 'ORDER-1684370353939', '6', 20000000.00, '2023-05-18 07:39:13', NULL, NULL, NULL, 1, 'Lastname', '1234 somewhere', 'ORDER-1684370353939', '12345@gmail.com', '123456'),
(14, 'ORDER-1695916354780', '9', 15000000.00, '2023-09-28 22:52:34', NULL, NULL, NULL, 1, 'Hung', 'adas', 'ORDER-1695916354780', 'kozaxlh@gmail.com', '0795156908'),
(15, 'ORDER-1695916417552', '9', 15000000.00, '2023-09-28 22:53:37', NULL, NULL, NULL, 1, 'Hung', 'adas', 'ORDER-1695916417552', 'kozaxlh@gmail.com', '0795156908'),
(20, 'ORDER-1695920757453', NULL, 18000000.00, '2023-09-29 00:05:57', NULL, NULL, NULL, 1, 'Do', '', 'ORDER-1695920757453', 'dolienhung1@yahoo.com.vn', '123'),
(21, 'ORDER-1695920821367', NULL, 15000000.00, '2023-09-29 00:07:01', NULL, NULL, NULL, 1, 'Do', '', 'ORDER-1695920821367', 'dolienhung1@yahoo.com.vn', '123'),
(24, 'ORDER-1699847766463', NULL, 5200000.00, '2023-11-13 10:56:06', NULL, NULL, NULL, 1, 'Lastname', '1234 somewhere', 'ORDER-1699847766463', 'dantedmc1134@gmail.com', '123456'),
(25, 'ORDER-1699847799159', NULL, 30200000.00, '2023-11-13 10:56:39', NULL, NULL, NULL, 1, 'Lastname', '1234 somewhere', 'ORDER-1699847799159', 'dantedmc1134@gmail.com', '123456'),
(27, 'ORDER-1699847855113', NULL, 5200000.00, '2023-11-13 10:57:35', NULL, NULL, NULL, 1, 'Lastname', '1234 somewhere', 'ORDER-1699847855113', 'Ouija1134@gmail.com', '123456'),
(29, 'ORDER-1702125978617', NULL, 51000000.00, '2023-12-09 19:46:18', NULL, NULL, NULL, 1, 'Khanh Nguyen', '1234 somewhere', 'ORDER-1702125978617', 'Ouija1134@gmail.com', '123456'),
(30, 'ORDER-1702126415380', NULL, 20200000.00, '2023-12-09 19:53:35', NULL, NULL, NULL, 1, 'Khanh Nguyen', '1234 somewhere', 'ORDER-1702126415380', 'Ouija1134@gmail.com', '123456');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_saleorder_products`
--

CREATE TABLE `tbl_saleorder_products` (
  `id` int(11) NOT NULL,
  `saleorder_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Bảng dữ liệu chứa phiếu mua hàng';

--
-- Dumping data for table `tbl_saleorder_products`
--

INSERT INTO `tbl_saleorder_products` (`id`, `saleorder_id`, `product_id`, `quantity`, `created_date`, `updated_date`, `created_by`, `updated_by`, `status`) VALUES
(11, 7, 38, 1, NULL, NULL, NULL, NULL, 1),
(12, 8, 38, 1, NULL, NULL, NULL, NULL, 1),
(13, 8, 39, 1, NULL, NULL, NULL, NULL, 1),
(14, 9, 38, 1, NULL, NULL, NULL, NULL, 1),
(15, 9, 39, 1, NULL, NULL, NULL, NULL, 1),
(16, 10, 37, 1, NULL, NULL, NULL, NULL, 1),
(17, 11, 39, 1, NULL, NULL, NULL, NULL, 1),
(18, 12, 38, 1, NULL, NULL, NULL, NULL, 1),
(19, 13, 37, 1, NULL, NULL, NULL, NULL, 1),
(20, 14, 39, 1, NULL, NULL, NULL, NULL, 1),
(21, 15, 39, 1, NULL, NULL, NULL, NULL, 1),
(26, 20, 38, 1, NULL, NULL, NULL, NULL, 1),
(27, 21, 39, 1, NULL, NULL, NULL, NULL, 1),
(30, 24, 40, 1, NULL, NULL, NULL, NULL, 1),
(31, 25, 40, 1, NULL, NULL, NULL, NULL, 1),
(32, 25, 41, 1, NULL, NULL, NULL, NULL, 1),
(34, 27, 40, 1, NULL, NULL, NULL, NULL, 1),
(36, 29, 38, 2, NULL, NULL, NULL, NULL, 1),
(37, 29, 39, 1, NULL, NULL, NULL, NULL, 1),
(38, 30, 39, 1, NULL, NULL, NULL, NULL, 1),
(39, 30, 40, 1, NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(45) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `address` varchar(500) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `first_name` varchar(45) NOT NULL,
  `gender` tinyint(1) NOT NULL DEFAULT 1,
  `name` varchar(100) NOT NULL,
  `phone` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Bảng dữ liệu chứa thông tin người dùng';

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `username`, `password`, `email`, `created_date`, `updated_date`, `created_by`, `updated_by`, `status`, `address`, `avatar`, `first_name`, `gender`, `name`, `phone`) VALUES
(1, 'test144', '123123', 'test@gmail.com', '2023-11-13 07:16:07', NULL, NULL, NULL, 0, '[value-10]', '[value-11]', 'testname1', 1, '[value-14]', '[value-15]'),
(6, 'user1', '$2a$08$K4lOb5F9R8cR4EOTq5qbpe79Qv9EOOX/OE3LPhwEpRpetKL2D4beq', 'Ouija1134@gmail.com', '2023-11-14 20:39:17', NULL, NULL, NULL, 1, '1234 somewhere', 'avt-3.jpg', 'firstname', 1, 'Khanh Nguyen', '123456'),
(7, 'user2', '123', 'dadsad34@gmail.com', '2023-11-13 09:30:48', NULL, NULL, NULL, 1, 'sssss', NULL, 'Lastname', 0, 'name', '123456'),
(8, 'user3', '$2a$08$dtDIXZlPZQzW9x/FLcUJ1uhhUFmXAnMIIOU5RQVEzaJWJYZ/WDWkS', 'dadsad34@gmail.com', '2023-09-28 22:46:24', NULL, NULL, NULL, 1, 'addd1', NULL, 'firstname', 0, 'sdadas', '123214214'),
(9, 'kozaxlh', '$2a$08$dJwqr9PsdUxinZ4e986uiu39zvWIGLuPRgktdwmg4ao0c.r5xEZWK', 'kozaxlh@gmail.com', '2023-09-28 22:34:34', '2023-09-28 22:34:34', NULL, NULL, 1, 'adas', NULL, 'Do', 1, 'Hung', '0795156908'),
(10, 'kozax5', '$2a$08$tnllSVvV./ygGFIuYzaxKu0AVczvYT4UN6XyvzBD67C9N9UfA8Pi6', 'dolienhung1@yahoo.com.vn', '2023-09-28 22:43:57', '2023-09-28 22:43:57', NULL, NULL, 1, '', NULL, 'Liên Hưng', 1, 'Do', '123'),
(11, 'testu1', '$2a$08$n.YN/0Le2k6nCdJUlBbGOO/vhnm2QDNFHg6xBzflLam2W2RcKxKlq', '12345@gmail.com', '2023-10-26 14:45:09', '2023-10-26 14:45:09', NULL, NULL, 1, '1234 main St', NULL, 'realnam1', 1, 'name1', '1111111'),
(21, 'utest', '$2a$08$PJkA2QiCxl7nWJEyQZM7quPkUQSyxoRYyFO3RUclUXTt0aga4B.pu', 'utestname2@gmail.com', '2023-11-13 09:59:15', NULL, NULL, NULL, 1, '1234 main St', NULL, 'utestname', 1, 'utestname2', '888888');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users_roles`
--

CREATE TABLE `tbl_users_roles` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='bảng trung gian thể hiện quan hệ n-n của users và roles';

--
-- Dumping data for table `tbl_users_roles`
--

INSERT INTO `tbl_users_roles` (`user_id`, `role_id`) VALUES
(6, 1),
(6, 3),
(7, 2),
(8, 3),
(9, 1),
(9, 2),
(9, 3),
(10, 2),
(10, 3),
(11, 2),
(21, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_category`
--
ALTER TABLE `tbl_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_internal_idx` (`parent_id`);

--
-- Indexes for table `tbl_contact`
--
ALTER TABLE `tbl_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_passwordresettokens`
--
ALTER TABLE `tbl_passwordresettokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `C1` (`user_id`);

--
-- Indexes for table `tbl_products`
--
ALTER TABLE `tbl_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_category_products_idx` (`category_id`);

--
-- Indexes for table `tbl_products_images`
--
ALTER TABLE `tbl_products_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_product_images_idx` (`product_id`);

--
-- Indexes for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_saleorder`
--
ALTER TABLE `tbl_saleorder`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_saleorder_products`
--
ALTER TABLE `tbl_saleorder_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_saleorder_product_idx` (`saleorder_id`),
  ADD KEY `FKnyfdau9vc46jkiwvrgj1ns85v` (`product_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_users_roles`
--
ALTER TABLE `tbl_users_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `fk_roles_idx` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_category`
--
ALTER TABLE `tbl_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tbl_contact`
--
ALTER TABLE `tbl_contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_passwordresettokens`
--
ALTER TABLE `tbl_passwordresettokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tbl_products`
--
ALTER TABLE `tbl_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `tbl_products_images`
--
ALTER TABLE `tbl_products_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_saleorder`
--
ALTER TABLE `tbl_saleorder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tbl_saleorder_products`
--
ALTER TABLE `tbl_saleorder_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_category`
--
ALTER TABLE `tbl_category`
  ADD CONSTRAINT `fk_internal` FOREIGN KEY (`parent_id`) REFERENCES `tbl_category` (`id`);

--
-- Constraints for table `tbl_passwordresettokens`
--
ALTER TABLE `tbl_passwordresettokens`
  ADD CONSTRAINT `C1` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`);

--
-- Constraints for table `tbl_products`
--
ALTER TABLE `tbl_products`
  ADD CONSTRAINT `fk_category_products` FOREIGN KEY (`category_id`) REFERENCES `tbl_category` (`id`);

--
-- Constraints for table `tbl_products_images`
--
ALTER TABLE `tbl_products_images`
  ADD CONSTRAINT `fk_product_images` FOREIGN KEY (`product_id`) REFERENCES `tbl_products` (`id`);

--
-- Constraints for table `tbl_saleorder_products`
--
ALTER TABLE `tbl_saleorder_products`
  ADD CONSTRAINT `FKnyfdau9vc46jkiwvrgj1ns85v` FOREIGN KEY (`product_id`) REFERENCES `tbl_products` (`id`),
  ADD CONSTRAINT `fk_saleorder_product` FOREIGN KEY (`saleorder_id`) REFERENCES `tbl_saleorder` (`id`);

--
-- Constraints for table `tbl_users_roles`
--
ALTER TABLE `tbl_users_roles`
  ADD CONSTRAINT `fk_roles` FOREIGN KEY (`role_id`) REFERENCES `tbl_roles` (`id`),
  ADD CONSTRAINT `fk_users` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

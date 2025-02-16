-- MySQL dump 10.13  Distrib 5.7.24, for osx11.1 (x86_64)
--
-- Host: localhost    Database: SSRESINS
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bracelets`
--

DROP TABLE IF EXISTS `bracelets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bracelets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` text,
  `quantity` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bracelets`
--

LOCK TABLES `bracelets` WRITE;
/*!40000 ALTER TABLE `bracelets` DISABLE KEYS */;
INSERT INTO `bracelets` VALUES (1,'Baby and Plum Flower Bracelet',450.00,'SSRDBC1.webp',NULL,8),(2,'Blue Plum Flower Bracelet',499.00,'SSRDBC2.webp',NULL,12),(3,'Plum and Baby Flower Combo Bracelet',850.00,'SSRDBC3.JPG',NULL,15),(4,'Butterfly Bliss Bracelet',499.00,'SSRDBC4.webp',NULL,20),(5,'Handmade Pressed Flower Bracelet',559.00,'SSRDBC5.avif',NULL,25),(6,'White Plum Pressed Bracelet',559.00,'SSRDBC6.jpg',NULL,10),(7,'Queen Anne\'s Flower Bracelet',600.00,'SSRDBC7.webp',NULL,18),(8,'lack Classy Bracelet',499.00,'SSRDBC8.webp',NULL,22);
/*!40000 ALTER TABLE `bracelets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `product_type` enum('pendants','earrings','bracelets') NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,2,'bracelets','Blue Plum Flower Bracelet',499.00,18,'SSRDBC2.webp'),(2,3,'earrings','Plum Flower Earrings',250.00,8,'SSRDED4.webp'),(3,3,'bracelets','Plum and Baby Flower Combo Bracelet',850.00,18,'SSRDBC3.JPG'),(4,2,'pendants','Rain Drop Pendant',250.00,9,'SSRDPD2.jpg'),(5,3,'pendants','Black Daisy Pendant',250.00,8,'SSRDPD3.jpg'),(6,4,'pendants','Blue Daisy Pendant',250.00,3,'SSRDPD4.jpg'),(7,4,'bracelets','Butterfly Bliss Bracelet',499.00,7,'SSRDBC4.webp'),(8,7,'pendants','Black Moon Pendant',270.00,3,'SSRDPD8.jpg'),(9,8,'bracelets','lack Classy Bracelet',499.00,3,'SSRDBC8.webp'),(10,5,'bracelets','Handmade Pressed Flower Bracelet',559.00,1,'SSRDBC5.avif'),(11,7,'earrings','Plum Flower  Earrings',290.00,3,'SSRDED8.avif'),(12,6,'bracelets','White Plum Pressed Bracelet',559.00,4,'SSRDBC6.jpg'),(13,1,'earrings','Baby Flower Earrings',390.00,4,'SSRDED2.webp'),(14,6,'earrings','Ixora Flower  Earrings',290.00,2,'SSRDED7.webp'),(15,2,'earrings','Yellow Buds Hangings',450.00,7,'SSRDED3.webp'),(16,6,'pendants','Flower Bud Pendant',299.00,4,'SSRDPD6.jpg'),(17,11,'pendants','Plum Blossom Pendant',250.00,3,'SSRDPD12.jpg'),(18,4,'earrings','Pink Daisy Earrings',150.00,5,'SSRDED5.webp'),(19,8,'earrings','Queen Anne\'s Flower Earrings',399.00,1,'SSRDED9.avif'),(20,1,'pendants','Baby Flower Pendant',250.00,2,'SSRDPD1.jpg'),(21,10,'pendants','Rose Bud Pendant',250.00,1,'SSRDPD11.jpg'),(22,7,'bracelets','Queen Anne\'s Flower Bracelet',600.00,1,'SSRDBC7.webp');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `earrings`
--

DROP TABLE IF EXISTS `earrings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `earrings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` text,
  `quantity` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `earrings`
--

LOCK TABLES `earrings` WRITE;
/*!40000 ALTER TABLE `earrings` DISABLE KEYS */;
INSERT INTO `earrings` VALUES (1,'Baby Flower Earrings',390.00,'SSRDED2.webp',NULL,10),(2,'Yellow Buds Hangings',450.00,'SSRDED3.webp',NULL,12),(3,'Plum Flower Earrings',250.00,'SSRDED4.webp',NULL,15),(4,'Pink Daisy Earrings',150.00,'SSRDED5.webp',NULL,18),(5,'Pink Leafy  Earrings',270.00,'SSRDED6.webp',NULL,20),(6,'Ixora Flower  Earrings',290.00,'SSRDED7.webp',NULL,14),(7,'Plum Flower  Earrings',290.00,'SSRDED8.avif',NULL,16),(8,'Queen Anne\'s Flower Earrings',399.00,'SSRDED9.avif',NULL,25);
/*!40000 ALTER TABLE `earrings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_codes`
--

DROP TABLE IF EXISTS `login_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_codes` (
  `email` varchar(255) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `login_codes_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_codes`
--

LOCK TABLES `login_codes` WRITE;
/*!40000 ALTER TABLE `login_codes` DISABLE KEYS */;
INSERT INTO `login_codes` VALUES ('swarnasriv05@gmail.com','SG9047','2025-02-09 06:39:20','2025-02-09 06:49:20');
/*!40000 ALTER TABLE `login_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_type` enum('pendants','earrings','bracelets') NOT NULL,
  `product_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (12,15,'pendants',7,'Black Moon Pendant',270.00,2,'SSRDPD8.jpg'),(13,15,'bracelets',8,'lack Classy Bracelet',499.00,1,'SSRDBC8.webp'),(14,15,'bracelets',5,'Handmade Pressed Flower Bracelet',559.00,1,'SSRDBC5.avif'),(15,16,'pendants',3,'Black Daisy Pendant',250.00,1,'SSRDPD3.jpg'),(16,16,'earrings',7,'Plum Flower  Earrings',290.00,3,'SSRDED8.avif'),(17,16,'bracelets',6,'White Plum Pressed Bracelet',559.00,2,'SSRDBC6.jpg'),(18,17,'pendants',2,'Rain Drop Pendant',250.00,1,'SSRDPD2.jpg'),(19,17,'pendants',4,'Blue Daisy Pendant',250.00,1,'SSRDPD4.jpg'),(20,17,'earrings',1,'Baby Flower Earrings',390.00,1,'SSRDED2.webp'),(21,17,'bracelets',3,'Plum and Baby Flower Combo Bracelet',850.00,2,'SSRDBC3.JPG'),(22,18,'pendants',2,'Rain Drop Pendant',250.00,2,'SSRDPD2.jpg'),(23,19,'earrings',3,'Plum Flower Earrings',250.00,1,'SSRDED4.webp'),(24,20,'pendants',3,'Black Daisy Pendant',250.00,1,'SSRDPD3.jpg'),(25,21,'bracelets',3,'Plum and Baby Flower Combo Bracelet',850.00,1,'SSRDBC3.JPG'),(26,21,'earrings',3,'Plum Flower Earrings',250.00,1,'SSRDED4.webp'),(27,22,'bracelets',2,'Blue Plum Flower Bracelet',499.00,1,'SSRDBC2.webp'),(28,22,'earrings',6,'Ixora Flower  Earrings',290.00,1,'SSRDED7.webp'),(29,23,'pendants',2,'Rain Drop Pendant',250.00,1,'SSRDPD2.jpg'),(30,23,'earrings',1,'Baby Flower Earrings',390.00,1,'SSRDED2.webp'),(31,24,'earrings',2,'Yellow Buds Hangings',450.00,1,'SSRDED3.webp'),(32,24,'pendants',6,'Flower Bud Pendant',299.00,2,'SSRDPD6.jpg'),(33,25,'bracelets',3,'Plum and Baby Flower Combo Bracelet',850.00,2,'SSRDBC3.JPG'),(34,26,'bracelets',3,'Plum and Baby Flower Combo Bracelet',850.00,2,'SSRDBC3.JPG'),(35,27,'earrings',2,'Yellow Buds Hangings',450.00,1,'SSRDED3.webp'),(36,27,'bracelets',2,'Blue Plum Flower Bracelet',499.00,1,'SSRDBC2.webp'),(37,27,'pendants',6,'Flower Bud Pendant',299.00,1,'SSRDPD6.jpg'),(38,27,'pendants',7,'Black Moon Pendant',270.00,1,'SSRDPD8.jpg'),(39,27,'pendants',11,'Plum Blossom Pendant',250.00,1,'SSRDPD12.jpg'),(40,28,'pendants',6,'Flower Bud Pendant',299.00,3,'SSRDPD6.jpg'),(41,28,'earrings',4,'Pink Daisy Earrings',150.00,5,'SSRDED5.webp'),(42,28,'pendants',11,'Plum Blossom Pendant',250.00,3,'SSRDPD12.jpg'),(43,29,'earrings',8,'Queen Anne\'s Flower Earrings',399.00,7,'SSRDED9.avif'),(44,29,'earrings',6,'Ixora Flower  Earrings',290.00,6,'SSRDED7.webp'),(45,29,'bracelets',6,'White Plum Pressed Bracelet',559.00,5,'SSRDBC6.jpg'),(46,30,'bracelets',2,'Blue Plum Flower Bracelet',499.00,3,'SSRDBC2.webp'),(47,30,'earrings',3,'Plum Flower Earrings',250.00,1,'SSRDED4.webp'),(48,31,'earrings',2,'Yellow Buds Hangings',450.00,2,'SSRDED3.webp'),(49,31,'earrings',4,'Pink Daisy Earrings',150.00,1,'SSRDED5.webp'),(50,31,'pendants',1,'Baby Flower Pendant',250.00,2,'SSRDPD1.jpg'),(51,32,'earrings',1,'Baby Flower Earrings',390.00,1,'SSRDED2.webp'),(52,32,'pendants',10,'Rose Bud Pendant',250.00,1,'SSRDPD11.jpg'),(53,32,'bracelets',7,'Queen Anne\'s Flower Bracelet',600.00,1,'SSRDBC7.webp'),(54,33,'pendants',2,'Rain Drop Pendant',250.00,2,'SSRDPD2.jpg'),(55,33,'earrings',4,'Pink Daisy Earrings',150.00,3,'SSRDED5.webp'),(56,33,'bracelets',8,'lack Classy Bracelet',499.00,2,'SSRDBC8.webp'),(57,34,'bracelets',3,'Plum and Baby Flower Combo Bracelet',850.00,3,'SSRDBC3.JPG'),(58,34,'earrings',2,'Yellow Buds Hangings',450.00,2,'SSRDED3.webp'),(59,35,'earrings',1,'Baby Flower Earrings',390.00,1,'SSRDED2.webp'),(60,35,'bracelets',4,'Butterfly Bliss Bracelet',499.00,1,'SSRDBC4.webp');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `country` varchar(50) NOT NULL DEFAULT 'India',
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `apartment` varchar(255) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `pincode` int NOT NULL,
  `phone` varchar(15) NOT NULL,
  `payment_method` enum('credit_card','paypal','cod') NOT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (15,'swarnasri20870@gmail.com','India','Swarna','V','2c 404, mahindra bloomdale, near mihan sez',NULL,'Nagpur','Maharastra',441109,'08925715440','cod','2025-02-08 12:48:40'),(16,'simlayuvaraj@gmail.com','India','Simla','Y','2c 404, mahindra bloomdale, near mihan sez',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-08 14:25:27'),(17,'simlayuvaraj@gmail.com','India','SIMLA','Y','NO 7',NULL,'CHENNAI','Tamil Nadu',600119,'08925715440','cod','2025-02-08 14:44:47'),(18,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-08 17:13:14'),(19,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-08 17:16:08'),(20,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-08 17:17:09'),(21,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-08 17:47:08'),(22,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-08 17:52:12'),(23,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-08 17:58:58'),(24,'simlayuvaraj@gmail.com','India','Swarna','Sri','No:09,2nd Cross Street,Village High Road',NULL,'Shollinganallur','Tamil Nadu',600119,'08925715440','cod','2025-02-08 18:02:40'),(25,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-09 06:02:35'),(26,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-09 06:10:47'),(27,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-09 06:16:04'),(28,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-09 06:21:12'),(29,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-09 06:24:00'),(30,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-09 06:26:56'),(31,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-09 06:29:25'),(32,'swarnavinay007@gmail.com','India','Swarna','Sri','No:23, Samy Street, Kosapalayam, Arni',NULL,'Thiruvannamalai','Tamil Nadu',632301,'08925715440','cod','2025-02-09 06:31:06'),(33,'swarnasri20870@gmail.com','India','Swarna','V','2C, 404, Mahindra Bloomdale, near mihan sez',NULL,'Nagpur','Maharastra',441109,'8925715440','cod','2025-02-09 14:08:36'),(34,'swarnavinay007@gmail.com','India','Swarna','V','2C, 404, Mahindra Bloomdale, near mihan sez',NULL,'Nagpur','Maharastra',441109,'8925715440','cod','2025-02-09 14:14:53'),(35,'kurakulaharshavardhini@gmail.com','India','Kurakula','Harshavardhini','Rajupet',NULL,'Tiruvuru','Andhrapradesh',521235,'9391112991','cod','2025-02-11 11:59:40');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pendants`
--

DROP TABLE IF EXISTS `pendants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pendants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` text,
  `quantity` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pendants`
--

LOCK TABLES `pendants` WRITE;
/*!40000 ALTER TABLE `pendants` DISABLE KEYS */;
INSERT INTO `pendants` VALUES (1,'Baby Flower Pendant',250.00,'SSRDPD1.jpg',NULL,10),(2,'Rain Drop Pendant',250.00,'SSRDPD2.jpg',NULL,15),(3,'Black Daisy Pendant',250.00,'SSRDPD3.jpg',NULL,20),(4,'Blue Daisy Pendant',250.00,'SSRDPD4.jpg',NULL,12),(5,'Rose Petal Pendant',150.00,'SSRDPD5.jpg',NULL,18),(6,'Flower Bud Pendant',299.00,'SSRDPD6.jpg',NULL,25),(7,'Black Moon Pendant',270.00,'SSRDPD8.jpg',NULL,30),(8,'Deep Rain Drop(white) Pendant',350.00,'SSRDPD9.jpg',NULL,8),(9,'Deep Rain Drop(purple) Pendant',350.00,'SSRDPD10.jpg',NULL,16),(10,'Rose Bud Pendant',250.00,'SSRDPD11.jpg',NULL,22),(11,'Plum Blossom Pendant',250.00,'SSRDPD12.jpg',NULL,14),(12,'Red Daisy Pendant',279.00,'SSRDPD13.jpg',NULL,19);
/*!40000 ALTER TABLE `pendants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (126,'swarnavinay007@gmail.com','2025-02-07 14:39:06'),(127,'swarnasriv05@gmail.com','2025-02-07 20:21:43'),(128,'swarnasri20870@gmail.com','2025-02-08 12:08:59'),(129,'simlayuvaraj@gmail.com','2025-02-08 14:25:42'),(130,'kurakulaharshavardhini@gmail.com','2025-02-11 12:00:02');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-16 13:42:36

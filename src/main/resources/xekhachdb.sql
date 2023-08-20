-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: xekhachdb
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bus`
--

DROP TABLE IF EXISTS `bus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `license_plate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus`
--

LOCK TABLES `bus` WRITE;
/*!40000 ALTER TABLE `bus` DISABLE KEYS */;
INSERT INTO `bus` VALUES (1,'51B-00172','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647248652/dkeolz3ghc0eino87iec.jpg'),(2,'51H-35864','https://images.pexels.com/photos/5896476/pexels-photo-5896476.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),(3,'27B-00419','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692358440/fkukcph4lxpq7tx757oa.jpg'),(4,'99G-42300','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692358477/j6hb41maqokxwrun5w3g.jpg'),(5,'15K-16752','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692358524/azejp2p781adtmeyrmcx.jpg'),(6,'51H-44521','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692358786/smmrwdluy6earbkouejw.jpg');
/*!40000 ALTER TABLE `bus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bus_seat_template`
--

DROP TABLE IF EXISTS `bus_seat_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bus_seat_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bus_id` int NOT NULL,
  `bus_seat_x` int NOT NULL,
  `bus_seat_y` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bus_id` (`bus_id`),
  CONSTRAINT `bus_seat_template_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_seat_template`
--

LOCK TABLES `bus_seat_template` WRITE;
/*!40000 ALTER TABLE `bus_seat_template` DISABLE KEYS */;
INSERT INTO `bus_seat_template` VALUES (1,1,1,1),(2,1,1,2),(3,1,1,3),(4,1,1,4),(5,1,1,5),(6,1,1,6),(7,1,1,7),(8,1,1,8),(9,1,1,9),(10,1,1,10),(11,1,1,11),(12,1,2,1),(13,1,2,2),(14,1,2,3),(15,1,2,4),(16,1,2,5),(17,1,2,6),(18,1,2,7),(19,1,2,8),(20,1,2,9),(21,1,2,10),(22,1,2,11),(23,1,3,11),(24,1,4,1),(25,1,4,2),(26,1,4,3),(27,1,4,4),(28,1,4,5),(29,1,4,6),(30,1,4,7),(31,1,4,8),(32,1,4,9),(33,1,4,10),(34,1,4,11),(35,1,5,1),(36,1,5,2),(37,1,5,3),(38,1,5,4),(39,1,5,5),(40,1,5,6),(41,1,5,7),(42,1,5,8),(43,1,5,9),(44,1,5,10),(45,1,5,11),(46,2,1,1),(47,2,1,2),(48,2,1,3),(49,2,1,4),(50,2,1,5),(51,2,1,6),(52,2,1,7),(53,2,1,8),(54,2,1,9),(55,2,1,10),(56,2,2,1),(57,2,2,2),(58,2,2,3),(59,2,2,4),(60,2,2,5),(61,2,2,6),(62,2,2,7),(63,2,2,8),(64,2,2,9),(65,2,2,10),(66,2,3,10),(67,2,4,1),(68,2,4,2),(69,2,4,3),(70,2,4,4),(71,2,4,5),(72,2,4,6),(73,2,4,7),(74,2,4,8),(75,2,4,9),(76,2,4,10),(77,2,5,1),(78,2,5,2),(79,2,5,3),(80,2,5,4),(81,2,5,5),(82,2,5,6),(83,2,5,7),(84,2,5,8),(85,2,5,9),(86,2,5,10),(87,3,1,1),(88,3,2,1),(89,3,4,1),(90,3,5,1),(91,3,1,2),(92,3,2,2),(93,3,4,2),(94,3,5,2),(95,3,1,3),(96,3,2,3),(97,3,4,3),(98,3,5,3),(99,3,1,4),(100,3,2,4),(101,3,4,4),(102,3,5,4),(103,3,1,5),(104,3,2,5),(105,3,4,5),(106,3,5,5),(107,3,1,6),(108,3,2,6),(109,3,4,6),(110,3,5,6),(111,3,1,7),(112,3,2,7),(113,3,4,7),(114,3,5,7),(115,3,1,8),(116,3,2,8),(117,3,4,8),(118,3,5,8),(119,3,1,9),(120,3,2,9),(121,3,4,9),(122,3,5,9),(123,3,1,10),(124,3,2,10),(125,3,4,10),(126,3,5,10),(127,4,1,1),(128,4,2,1),(129,4,4,1),(130,4,5,1),(131,4,1,2),(132,4,2,2),(133,4,4,2),(134,4,5,2),(135,4,1,3),(136,4,2,3),(137,4,4,3),(138,4,5,3),(139,4,1,4),(140,4,2,4),(141,4,4,4),(142,4,5,4),(143,4,1,5),(144,4,2,5),(145,4,4,5),(146,4,5,5),(147,4,1,6),(148,4,2,6),(149,4,4,6),(150,4,5,6),(151,4,1,7),(152,4,2,7),(153,4,4,7),(154,4,5,7),(155,4,1,8),(156,4,2,8),(157,4,4,8),(158,4,5,8),(159,4,1,9),(160,4,2,9),(161,4,4,9),(162,4,5,9),(163,4,1,10),(164,4,2,10),(165,4,3,10),(166,4,4,10),(167,4,5,10),(168,5,1,1),(169,5,2,1),(170,5,4,1),(171,5,5,1),(172,5,1,2),(173,5,2,2),(174,5,4,2),(175,5,5,2),(176,5,1,3),(177,5,2,3),(178,5,4,3),(179,5,5,3),(180,5,1,4),(181,5,2,4),(182,5,4,4),(183,5,5,4),(184,5,1,5),(185,5,2,5),(186,5,4,5),(187,5,5,5),(188,5,1,6),(189,5,2,6),(190,5,4,6),(191,5,5,6),(192,5,1,7),(193,5,2,7),(194,5,4,7),(195,5,5,7),(196,5,1,8),(197,5,2,8),(198,5,4,8),(199,5,5,8),(200,5,1,9),(201,5,2,9),(202,5,3,9),(203,5,4,9),(204,5,5,9),(205,5,1,10),(206,5,2,10),(207,5,3,10),(208,5,4,10),(209,5,5,10),(210,6,1,1),(211,6,2,1),(212,6,4,1),(213,6,5,1),(214,6,1,2),(215,6,2,2),(216,6,4,2),(217,6,5,2),(218,6,1,3),(219,6,2,3),(220,6,4,3),(221,6,5,3),(222,6,1,4),(223,6,2,4),(224,6,4,4),(225,6,5,4),(226,6,1,5),(227,6,2,5),(228,6,4,5),(229,6,5,5),(230,6,1,6),(231,6,2,6),(232,6,4,6),(233,6,5,6),(234,6,1,7),(235,6,2,7),(236,6,4,7),(237,6,5,7),(238,6,1,8),(239,6,2,8),(240,6,4,8),(241,6,5,8),(242,6,1,9),(243,6,2,9),(244,6,4,9),(245,6,5,9),(246,6,1,10),(247,6,2,10),(248,6,3,10),(249,6,4,10),(250,6,5,10);
/*!40000 ALTER TABLE `bus_seat_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bus_seat_trip`
--

DROP TABLE IF EXISTS `bus_seat_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bus_seat_trip` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bus_id` int NOT NULL,
  `trip_id` int NOT NULL,
  `bus_seat_x` int NOT NULL,
  `bus_seat_y` int NOT NULL,
  `available` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bus_id` (`bus_id`),
  KEY `trip_id` (`trip_id`),
  CONSTRAINT `bus_seat_trip_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`id`),
  CONSTRAINT `bus_seat_trip_ibfk_2` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_seat_trip`
--

LOCK TABLES `bus_seat_trip` WRITE;
/*!40000 ALTER TABLE `bus_seat_trip` DISABLE KEYS */;
INSERT INTO `bus_seat_trip` VALUES (1,1,1,1,1,_binary '\0'),(2,1,1,1,2,_binary '\0'),(3,1,1,1,3,_binary ''),(4,1,1,1,4,_binary '\0'),(5,1,1,1,5,_binary '\0'),(6,1,1,1,6,_binary ''),(7,1,1,1,7,_binary ''),(8,1,1,1,8,_binary ''),(9,1,1,1,9,_binary ''),(10,1,1,1,10,_binary ''),(11,1,1,1,11,_binary ''),(12,1,1,2,1,_binary '\0'),(13,1,1,2,2,_binary '\0'),(14,1,1,2,3,_binary ''),(15,1,1,2,4,_binary '\0'),(16,1,1,2,5,_binary '\0'),(17,1,1,2,6,_binary ''),(18,1,1,2,7,_binary ''),(19,1,1,2,8,_binary ''),(20,1,1,2,9,_binary ''),(21,1,1,2,10,_binary ''),(22,1,1,2,11,_binary ''),(23,1,1,3,11,_binary ''),(24,1,1,4,1,_binary '\0'),(25,1,1,4,2,_binary '\0'),(26,1,1,4,3,_binary ''),(27,1,1,4,4,_binary ''),(28,1,1,4,5,_binary '\0'),(29,1,1,4,6,_binary '\0'),(30,1,1,4,7,_binary ''),(31,1,1,4,8,_binary ''),(32,1,1,4,9,_binary ''),(33,1,1,4,10,_binary ''),(34,1,1,4,11,_binary ''),(35,1,1,5,1,_binary '\0'),(36,1,1,5,2,_binary '\0'),(37,1,1,5,3,_binary ''),(38,1,1,5,4,_binary ''),(39,1,1,5,5,_binary '\0'),(40,1,1,5,6,_binary '\0'),(41,1,1,5,7,_binary ''),(42,1,1,5,8,_binary ''),(43,1,1,5,9,_binary ''),(44,1,1,5,10,_binary ''),(45,1,1,5,11,_binary ''),(46,1,2,1,1,_binary ''),(47,1,2,1,2,_binary ''),(48,1,2,1,3,_binary ''),(49,1,2,1,4,_binary ''),(50,1,2,1,5,_binary ''),(51,1,2,1,6,_binary ''),(52,1,2,1,7,_binary ''),(53,1,2,1,8,_binary ''),(54,1,2,1,9,_binary ''),(55,1,2,1,10,_binary ''),(56,1,2,1,11,_binary ''),(57,1,2,2,1,_binary ''),(58,1,2,2,2,_binary ''),(59,1,2,2,3,_binary ''),(60,1,2,2,4,_binary ''),(61,1,2,2,5,_binary ''),(62,1,2,2,6,_binary ''),(63,1,2,2,7,_binary ''),(64,1,2,2,8,_binary ''),(65,1,2,2,9,_binary ''),(66,1,2,2,10,_binary ''),(67,1,2,2,11,_binary ''),(68,1,2,3,11,_binary ''),(69,1,2,4,1,_binary ''),(70,1,2,4,2,_binary ''),(71,1,2,4,3,_binary ''),(72,1,2,4,4,_binary ''),(73,1,2,4,5,_binary ''),(74,1,2,4,6,_binary ''),(75,1,2,4,7,_binary ''),(76,1,2,4,8,_binary ''),(77,1,2,4,9,_binary ''),(78,1,2,4,10,_binary ''),(79,1,2,4,11,_binary ''),(80,1,2,5,1,_binary ''),(81,1,2,5,2,_binary ''),(82,1,2,5,3,_binary ''),(83,1,2,5,4,_binary ''),(84,1,2,5,5,_binary ''),(85,1,2,5,6,_binary ''),(86,1,2,5,7,_binary ''),(87,1,2,5,8,_binary ''),(88,1,2,5,9,_binary ''),(89,1,2,5,10,_binary ''),(90,1,2,5,11,_binary ''),(91,1,3,1,1,_binary ''),(92,1,3,1,2,_binary ''),(93,1,3,1,3,_binary ''),(94,1,3,1,4,_binary ''),(95,1,3,1,5,_binary ''),(96,1,3,1,6,_binary ''),(97,1,3,1,7,_binary ''),(98,1,3,1,8,_binary ''),(99,1,3,1,9,_binary ''),(100,1,3,1,10,_binary ''),(101,1,3,1,11,_binary ''),(102,1,3,2,1,_binary ''),(103,1,3,2,2,_binary ''),(104,1,3,2,3,_binary ''),(105,1,3,2,4,_binary ''),(106,1,3,2,5,_binary ''),(107,1,3,2,6,_binary ''),(108,1,3,2,7,_binary ''),(109,1,3,2,8,_binary ''),(110,1,3,2,9,_binary ''),(111,1,3,2,10,_binary ''),(112,1,3,2,11,_binary ''),(113,1,3,3,11,_binary ''),(114,1,3,4,1,_binary ''),(115,1,3,4,2,_binary ''),(116,1,3,4,3,_binary ''),(117,1,3,4,4,_binary ''),(118,1,3,4,5,_binary ''),(119,1,3,4,6,_binary ''),(120,1,3,4,7,_binary ''),(121,1,3,4,8,_binary ''),(122,1,3,4,9,_binary ''),(123,1,3,4,10,_binary ''),(124,1,3,4,11,_binary ''),(125,1,3,5,1,_binary ''),(126,1,3,5,2,_binary ''),(127,1,3,5,3,_binary ''),(128,1,3,5,4,_binary ''),(129,1,3,5,5,_binary ''),(130,1,3,5,6,_binary ''),(131,1,3,5,7,_binary ''),(132,1,3,5,8,_binary ''),(133,1,3,5,9,_binary ''),(134,1,3,5,10,_binary ''),(135,1,3,5,11,_binary ''),(136,1,4,1,1,_binary ''),(137,1,4,1,2,_binary ''),(138,1,4,1,3,_binary ''),(139,1,4,1,4,_binary ''),(140,1,4,1,5,_binary ''),(141,1,4,1,6,_binary ''),(142,1,4,1,7,_binary ''),(143,1,4,1,8,_binary ''),(144,1,4,1,9,_binary ''),(145,1,4,1,10,_binary ''),(146,1,4,1,11,_binary ''),(147,1,4,2,1,_binary ''),(148,1,4,2,2,_binary ''),(149,1,4,2,3,_binary ''),(150,1,4,2,4,_binary ''),(151,1,4,2,5,_binary ''),(152,1,4,2,6,_binary ''),(153,1,4,2,7,_binary ''),(154,1,4,2,8,_binary ''),(155,1,4,2,9,_binary ''),(156,1,4,2,10,_binary ''),(157,1,4,2,11,_binary ''),(158,1,4,3,11,_binary ''),(159,1,4,4,1,_binary ''),(160,1,4,4,2,_binary ''),(161,1,4,4,3,_binary ''),(162,1,4,4,4,_binary ''),(163,1,4,4,5,_binary ''),(164,1,4,4,6,_binary ''),(165,1,4,4,7,_binary ''),(166,1,4,4,8,_binary ''),(167,1,4,4,9,_binary ''),(168,1,4,4,10,_binary ''),(169,1,4,4,11,_binary ''),(170,1,4,5,1,_binary ''),(171,1,4,5,2,_binary ''),(172,1,4,5,3,_binary ''),(173,1,4,5,4,_binary ''),(174,1,4,5,5,_binary ''),(175,1,4,5,6,_binary ''),(176,1,4,5,7,_binary ''),(177,1,4,5,8,_binary ''),(178,1,4,5,9,_binary ''),(179,1,4,5,10,_binary ''),(180,1,4,5,11,_binary ''),(181,2,5,1,1,_binary ''),(182,2,5,1,2,_binary ''),(183,2,5,1,3,_binary ''),(184,2,5,1,4,_binary ''),(185,2,5,1,5,_binary ''),(186,2,5,1,6,_binary ''),(187,2,5,1,7,_binary ''),(188,2,5,1,8,_binary ''),(189,2,5,1,9,_binary ''),(190,2,5,1,10,_binary ''),(191,2,5,2,1,_binary ''),(192,2,5,2,2,_binary ''),(193,2,5,2,3,_binary ''),(194,2,5,2,4,_binary '\0'),(195,2,5,2,5,_binary ''),(196,2,5,2,6,_binary ''),(197,2,5,2,7,_binary ''),(198,2,5,2,8,_binary ''),(199,2,5,2,9,_binary ''),(200,2,5,2,10,_binary ''),(201,2,5,3,10,_binary ''),(202,2,5,4,1,_binary ''),(203,2,5,4,2,_binary ''),(204,2,5,4,3,_binary ''),(205,2,5,4,4,_binary ''),(206,2,5,4,5,_binary ''),(207,2,5,4,6,_binary ''),(208,2,5,4,7,_binary ''),(209,2,5,4,8,_binary ''),(210,2,5,4,9,_binary ''),(211,2,5,4,10,_binary ''),(212,2,5,5,1,_binary ''),(213,2,5,5,2,_binary ''),(214,2,5,5,3,_binary ''),(215,2,5,5,4,_binary ''),(216,2,5,5,5,_binary ''),(217,2,5,5,6,_binary ''),(218,2,5,5,7,_binary ''),(219,2,5,5,8,_binary ''),(220,2,5,5,9,_binary ''),(221,2,5,5,10,_binary ''),(222,2,6,1,1,_binary ''),(223,2,6,1,2,_binary '\0'),(224,2,6,1,3,_binary '\0'),(225,2,6,1,4,_binary ''),(226,2,6,1,5,_binary ''),(227,2,6,1,6,_binary ''),(228,2,6,1,7,_binary ''),(229,2,6,1,8,_binary ''),(230,2,6,1,9,_binary ''),(231,2,6,1,10,_binary ''),(232,2,6,2,1,_binary ''),(233,2,6,2,2,_binary '\0'),(234,2,6,2,3,_binary '\0'),(235,2,6,2,4,_binary ''),(236,2,6,2,5,_binary ''),(237,2,6,2,6,_binary ''),(238,2,6,2,7,_binary ''),(239,2,6,2,8,_binary ''),(240,2,6,2,9,_binary ''),(241,2,6,2,10,_binary ''),(242,2,6,3,10,_binary ''),(243,2,6,4,1,_binary ''),(244,2,6,4,2,_binary ''),(245,2,6,4,3,_binary ''),(246,2,6,4,4,_binary ''),(247,2,6,4,5,_binary ''),(248,2,6,4,6,_binary ''),(249,2,6,4,7,_binary ''),(250,2,6,4,8,_binary ''),(251,2,6,4,9,_binary ''),(252,2,6,4,10,_binary ''),(253,2,6,5,1,_binary ''),(254,2,6,5,2,_binary ''),(255,2,6,5,3,_binary ''),(256,2,6,5,4,_binary ''),(257,2,6,5,5,_binary ''),(258,2,6,5,6,_binary ''),(259,2,6,5,7,_binary ''),(260,2,6,5,8,_binary ''),(261,2,6,5,9,_binary ''),(262,2,6,5,10,_binary ''),(263,2,7,1,1,_binary ''),(264,2,7,1,2,_binary ''),(265,2,7,1,3,_binary ''),(266,2,7,1,4,_binary ''),(267,2,7,1,5,_binary ''),(268,2,7,1,6,_binary ''),(269,2,7,1,7,_binary ''),(270,2,7,1,8,_binary ''),(271,2,7,1,9,_binary ''),(272,2,7,1,10,_binary ''),(273,2,7,2,1,_binary ''),(274,2,7,2,2,_binary ''),(275,2,7,2,3,_binary ''),(276,2,7,2,4,_binary ''),(277,2,7,2,5,_binary ''),(278,2,7,2,6,_binary ''),(279,2,7,2,7,_binary ''),(280,2,7,2,8,_binary ''),(281,2,7,2,9,_binary ''),(282,2,7,2,10,_binary ''),(283,2,7,3,10,_binary ''),(284,2,7,4,1,_binary ''),(285,2,7,4,2,_binary '\0'),(286,2,7,4,3,_binary ''),(287,2,7,4,4,_binary ''),(288,2,7,4,5,_binary ''),(289,2,7,4,6,_binary ''),(290,2,7,4,7,_binary ''),(291,2,7,4,8,_binary ''),(292,2,7,4,9,_binary ''),(293,2,7,4,10,_binary ''),(294,2,7,5,1,_binary ''),(295,2,7,5,2,_binary '\0'),(296,2,7,5,3,_binary ''),(297,2,7,5,4,_binary ''),(298,2,7,5,5,_binary ''),(299,2,7,5,6,_binary ''),(300,2,7,5,7,_binary ''),(301,2,7,5,8,_binary ''),(302,2,7,5,9,_binary ''),(303,2,7,5,10,_binary ''),(304,1,8,1,1,_binary ''),(305,1,8,1,2,_binary ''),(306,1,8,1,3,_binary ''),(307,1,8,1,4,_binary ''),(308,1,8,1,5,_binary ''),(309,1,8,1,6,_binary ''),(310,1,8,1,7,_binary ''),(311,1,8,1,8,_binary ''),(312,1,8,1,9,_binary ''),(313,1,8,1,10,_binary ''),(314,1,8,1,11,_binary ''),(315,1,8,2,1,_binary ''),(316,1,8,2,2,_binary ''),(317,1,8,2,3,_binary ''),(318,1,8,2,4,_binary ''),(319,1,8,2,5,_binary ''),(320,1,8,2,6,_binary ''),(321,1,8,2,7,_binary ''),(322,1,8,2,8,_binary ''),(323,1,8,2,9,_binary ''),(324,1,8,2,10,_binary ''),(325,1,8,2,11,_binary ''),(326,1,8,3,11,_binary ''),(327,1,8,4,1,_binary ''),(328,1,8,4,2,_binary ''),(329,1,8,4,3,_binary '\0'),(330,1,8,4,4,_binary ''),(331,1,8,4,5,_binary ''),(332,1,8,4,6,_binary '\0'),(333,1,8,4,7,_binary '\0'),(334,1,8,4,8,_binary ''),(335,1,8,4,9,_binary ''),(336,1,8,4,10,_binary ''),(337,1,8,4,11,_binary ''),(338,1,8,5,1,_binary ''),(339,1,8,5,2,_binary ''),(340,1,8,5,3,_binary '\0'),(341,1,8,5,4,_binary ''),(342,1,8,5,5,_binary ''),(343,1,8,5,6,_binary '\0'),(344,1,8,5,7,_binary '\0'),(345,1,8,5,8,_binary ''),(346,1,8,5,9,_binary ''),(347,1,8,5,10,_binary ''),(348,1,8,5,11,_binary ''),(349,1,2,1,1,_binary ''),(350,1,2,1,2,_binary ''),(351,1,2,1,3,_binary ''),(352,1,2,1,4,_binary ''),(353,1,2,1,5,_binary ''),(354,1,2,1,6,_binary ''),(355,1,2,1,7,_binary ''),(356,1,2,1,8,_binary ''),(357,1,2,1,9,_binary ''),(358,1,2,1,10,_binary ''),(359,1,2,1,11,_binary ''),(360,1,2,2,1,_binary ''),(361,1,2,2,2,_binary ''),(362,1,2,2,3,_binary ''),(363,1,2,2,4,_binary ''),(364,1,2,2,5,_binary ''),(365,1,2,2,6,_binary ''),(366,1,2,2,7,_binary ''),(367,1,2,2,8,_binary ''),(368,1,2,2,9,_binary ''),(369,1,2,2,10,_binary ''),(370,1,2,2,11,_binary ''),(371,1,2,3,11,_binary ''),(372,1,2,4,1,_binary ''),(373,1,2,4,2,_binary ''),(374,1,2,4,3,_binary '\0'),(375,1,2,4,4,_binary ''),(376,1,2,4,5,_binary ''),(377,1,2,4,6,_binary ''),(378,1,2,4,7,_binary ''),(379,1,2,4,8,_binary ''),(380,1,2,4,9,_binary ''),(381,1,2,4,10,_binary ''),(382,1,2,4,11,_binary ''),(383,1,2,5,1,_binary ''),(384,1,2,5,2,_binary ''),(385,1,2,5,3,_binary '\0'),(386,1,2,5,4,_binary '\0'),(387,1,2,5,5,_binary ''),(388,1,2,5,6,_binary ''),(389,1,2,5,7,_binary ''),(390,1,2,5,8,_binary ''),(391,1,2,5,9,_binary ''),(392,1,2,5,10,_binary ''),(393,1,2,5,11,_binary ''),(394,1,3,1,1,_binary ''),(395,1,3,1,2,_binary ''),(396,1,3,1,3,_binary ''),(397,1,3,1,4,_binary ''),(398,1,3,1,5,_binary ''),(399,1,3,1,6,_binary ''),(400,1,3,1,7,_binary ''),(401,1,3,1,8,_binary ''),(402,1,3,1,9,_binary ''),(403,1,3,1,10,_binary ''),(404,1,3,1,11,_binary ''),(405,1,3,2,1,_binary ''),(406,1,3,2,2,_binary ''),(407,1,3,2,3,_binary '\0'),(408,1,3,2,4,_binary ''),(409,1,3,2,5,_binary ''),(410,1,3,2,6,_binary ''),(411,1,3,2,7,_binary ''),(412,1,3,2,8,_binary ''),(413,1,3,2,9,_binary ''),(414,1,3,2,10,_binary ''),(415,1,3,2,11,_binary ''),(416,1,3,3,11,_binary ''),(417,1,3,4,1,_binary ''),(418,1,3,4,2,_binary ''),(419,1,3,4,3,_binary ''),(420,1,3,4,4,_binary ''),(421,1,3,4,5,_binary ''),(422,1,3,4,6,_binary ''),(423,1,3,4,7,_binary ''),(424,1,3,4,8,_binary ''),(425,1,3,4,9,_binary ''),(426,1,3,4,10,_binary ''),(427,1,3,4,11,_binary ''),(428,1,3,5,1,_binary ''),(429,1,3,5,2,_binary ''),(430,1,3,5,3,_binary ''),(431,1,3,5,4,_binary ''),(432,1,3,5,5,_binary ''),(433,1,3,5,6,_binary ''),(434,1,3,5,7,_binary ''),(435,1,3,5,8,_binary ''),(436,1,3,5,9,_binary ''),(437,1,3,5,10,_binary ''),(438,1,3,5,11,_binary ''),(439,1,4,1,1,_binary ''),(440,1,4,1,2,_binary ''),(441,1,4,1,3,_binary ''),(442,1,4,1,4,_binary ''),(443,1,4,1,5,_binary ''),(444,1,4,1,6,_binary ''),(445,1,4,1,7,_binary ''),(446,1,4,1,8,_binary ''),(447,1,4,1,9,_binary ''),(448,1,4,1,10,_binary ''),(449,1,4,1,11,_binary ''),(450,1,4,2,1,_binary ''),(451,1,4,2,2,_binary ''),(452,1,4,2,3,_binary ''),(453,1,4,2,4,_binary ''),(454,1,4,2,5,_binary '\0'),(455,1,4,2,6,_binary '\0'),(456,1,4,2,7,_binary ''),(457,1,4,2,8,_binary ''),(458,1,4,2,9,_binary ''),(459,1,4,2,10,_binary ''),(460,1,4,2,11,_binary ''),(461,1,4,3,11,_binary ''),(462,1,4,4,1,_binary ''),(463,1,4,4,2,_binary ''),(464,1,4,4,3,_binary ''),(465,1,4,4,4,_binary ''),(466,1,4,4,5,_binary '\0'),(467,1,4,4,6,_binary '\0'),(468,1,4,4,7,_binary ''),(469,1,4,4,8,_binary ''),(470,1,4,4,9,_binary ''),(471,1,4,4,10,_binary ''),(472,1,4,4,11,_binary ''),(473,1,4,5,1,_binary ''),(474,1,4,5,2,_binary ''),(475,1,4,5,3,_binary ''),(476,1,4,5,4,_binary ''),(477,1,4,5,5,_binary ''),(478,1,4,5,6,_binary ''),(479,1,4,5,7,_binary ''),(480,1,4,5,8,_binary ''),(481,1,4,5,9,_binary ''),(482,1,4,5,10,_binary ''),(483,1,4,5,11,_binary ''),(484,5,9,1,1,_binary '\0'),(485,5,9,2,1,_binary '\0'),(486,5,9,4,1,_binary ''),(487,5,9,5,1,_binary ''),(488,5,9,1,2,_binary '\0'),(489,5,9,2,2,_binary '\0'),(490,5,9,4,2,_binary ''),(491,5,9,5,2,_binary ''),(492,5,9,1,3,_binary ''),(493,5,9,2,3,_binary ''),(494,5,9,4,3,_binary ''),(495,5,9,5,3,_binary ''),(496,5,9,1,4,_binary ''),(497,5,9,2,4,_binary ''),(498,5,9,4,4,_binary ''),(499,5,9,5,4,_binary ''),(500,5,9,1,5,_binary ''),(501,5,9,2,5,_binary ''),(502,5,9,4,5,_binary ''),(503,5,9,5,5,_binary ''),(504,5,9,1,6,_binary ''),(505,5,9,2,6,_binary ''),(506,5,9,4,6,_binary ''),(507,5,9,5,6,_binary ''),(508,5,9,1,7,_binary ''),(509,5,9,2,7,_binary ''),(510,5,9,4,7,_binary ''),(511,5,9,5,7,_binary ''),(512,5,9,1,8,_binary ''),(513,5,9,2,8,_binary ''),(514,5,9,4,8,_binary ''),(515,5,9,5,8,_binary ''),(516,5,9,1,9,_binary ''),(517,5,9,2,9,_binary ''),(518,5,9,3,9,_binary ''),(519,5,9,4,9,_binary ''),(520,5,9,5,9,_binary ''),(521,5,9,1,10,_binary ''),(522,5,9,2,10,_binary ''),(523,5,9,3,10,_binary ''),(524,5,9,4,10,_binary ''),(525,5,9,5,10,_binary ''),(526,4,10,1,1,_binary ''),(527,4,10,2,1,_binary ''),(528,4,10,4,1,_binary '\0'),(529,4,10,5,1,_binary '\0'),(530,4,10,1,2,_binary ''),(531,4,10,2,2,_binary ''),(532,4,10,4,2,_binary ''),(533,4,10,5,2,_binary ''),(534,4,10,1,3,_binary ''),(535,4,10,2,3,_binary ''),(536,4,10,4,3,_binary ''),(537,4,10,5,3,_binary ''),(538,4,10,1,4,_binary ''),(539,4,10,2,4,_binary ''),(540,4,10,4,4,_binary ''),(541,4,10,5,4,_binary ''),(542,4,10,1,5,_binary ''),(543,4,10,2,5,_binary ''),(544,4,10,4,5,_binary ''),(545,4,10,5,5,_binary ''),(546,4,10,1,6,_binary ''),(547,4,10,2,6,_binary ''),(548,4,10,4,6,_binary ''),(549,4,10,5,6,_binary ''),(550,4,10,1,7,_binary ''),(551,4,10,2,7,_binary ''),(552,4,10,4,7,_binary ''),(553,4,10,5,7,_binary ''),(554,4,10,1,8,_binary ''),(555,4,10,2,8,_binary ''),(556,4,10,4,8,_binary ''),(557,4,10,5,8,_binary ''),(558,4,10,1,9,_binary ''),(559,4,10,2,9,_binary ''),(560,4,10,4,9,_binary ''),(561,4,10,5,9,_binary ''),(562,4,10,1,10,_binary ''),(563,4,10,2,10,_binary ''),(564,4,10,3,10,_binary ''),(565,4,10,4,10,_binary ''),(566,4,10,5,10,_binary ''),(567,6,11,1,1,_binary ''),(568,6,11,2,1,_binary ''),(569,6,11,4,1,_binary ''),(570,6,11,5,1,_binary ''),(571,6,11,1,2,_binary ''),(572,6,11,2,2,_binary ''),(573,6,11,4,2,_binary ''),(574,6,11,5,2,_binary ''),(575,6,11,1,3,_binary ''),(576,6,11,2,3,_binary ''),(577,6,11,4,3,_binary ''),(578,6,11,5,3,_binary ''),(579,6,11,1,4,_binary ''),(580,6,11,2,4,_binary ''),(581,6,11,4,4,_binary ''),(582,6,11,5,4,_binary ''),(583,6,11,1,5,_binary ''),(584,6,11,2,5,_binary '\0'),(585,6,11,4,5,_binary ''),(586,6,11,5,5,_binary ''),(587,6,11,1,6,_binary ''),(588,6,11,2,6,_binary ''),(589,6,11,4,6,_binary ''),(590,6,11,5,6,_binary ''),(591,6,11,1,7,_binary ''),(592,6,11,2,7,_binary ''),(593,6,11,4,7,_binary ''),(594,6,11,5,7,_binary ''),(595,6,11,1,8,_binary ''),(596,6,11,2,8,_binary ''),(597,6,11,4,8,_binary ''),(598,6,11,5,8,_binary ''),(599,6,11,1,9,_binary ''),(600,6,11,2,9,_binary ''),(601,6,11,4,9,_binary ''),(602,6,11,5,9,_binary ''),(603,6,11,1,10,_binary ''),(604,6,11,2,10,_binary ''),(605,6,11,3,10,_binary ''),(606,6,11,4,10,_binary ''),(607,6,11,5,10,_binary ''),(608,3,12,1,1,_binary ''),(609,3,12,2,1,_binary ''),(610,3,12,4,1,_binary ''),(611,3,12,5,1,_binary '\0'),(612,3,12,1,2,_binary ''),(613,3,12,2,2,_binary ''),(614,3,12,4,2,_binary '\0'),(615,3,12,5,2,_binary '\0'),(616,3,12,1,3,_binary ''),(617,3,12,2,3,_binary ''),(618,3,12,4,3,_binary ''),(619,3,12,5,3,_binary ''),(620,3,12,1,4,_binary ''),(621,3,12,2,4,_binary ''),(622,3,12,4,4,_binary ''),(623,3,12,5,4,_binary ''),(624,3,12,1,5,_binary ''),(625,3,12,2,5,_binary ''),(626,3,12,4,5,_binary ''),(627,3,12,5,5,_binary ''),(628,3,12,1,6,_binary ''),(629,3,12,2,6,_binary ''),(630,3,12,4,6,_binary ''),(631,3,12,5,6,_binary ''),(632,3,12,1,7,_binary ''),(633,3,12,2,7,_binary ''),(634,3,12,4,7,_binary ''),(635,3,12,5,7,_binary ''),(636,3,12,1,8,_binary ''),(637,3,12,2,8,_binary ''),(638,3,12,4,8,_binary ''),(639,3,12,5,8,_binary ''),(640,3,12,1,9,_binary ''),(641,3,12,2,9,_binary ''),(642,3,12,4,9,_binary ''),(643,3,12,5,9,_binary ''),(644,3,12,1,10,_binary ''),(645,3,12,2,10,_binary ''),(646,3,12,4,10,_binary ''),(647,3,12,5,10,_binary ''),(648,4,13,1,1,_binary ''),(649,4,13,2,1,_binary ''),(650,4,13,4,1,_binary ''),(651,4,13,5,1,_binary ''),(652,4,13,1,2,_binary ''),(653,4,13,2,2,_binary ''),(654,4,13,4,2,_binary ''),(655,4,13,5,2,_binary ''),(656,4,13,1,3,_binary ''),(657,4,13,2,3,_binary ''),(658,4,13,4,3,_binary ''),(659,4,13,5,3,_binary ''),(660,4,13,1,4,_binary ''),(661,4,13,2,4,_binary ''),(662,4,13,4,4,_binary ''),(663,4,13,5,4,_binary ''),(664,4,13,1,5,_binary ''),(665,4,13,2,5,_binary ''),(666,4,13,4,5,_binary ''),(667,4,13,5,5,_binary ''),(668,4,13,1,6,_binary ''),(669,4,13,2,6,_binary ''),(670,4,13,4,6,_binary ''),(671,4,13,5,6,_binary ''),(672,4,13,1,7,_binary ''),(673,4,13,2,7,_binary ''),(674,4,13,4,7,_binary ''),(675,4,13,5,7,_binary ''),(676,4,13,1,8,_binary ''),(677,4,13,2,8,_binary ''),(678,4,13,4,8,_binary ''),(679,4,13,5,8,_binary ''),(680,4,13,1,9,_binary ''),(681,4,13,2,9,_binary ''),(682,4,13,4,9,_binary ''),(683,4,13,5,9,_binary ''),(684,4,13,1,10,_binary ''),(685,4,13,2,10,_binary ''),(686,4,13,3,10,_binary ''),(687,4,13,4,10,_binary ''),(688,4,13,5,10,_binary ''),(689,5,14,1,1,_binary ''),(690,5,14,2,1,_binary ''),(691,5,14,4,1,_binary ''),(692,5,14,5,1,_binary ''),(693,5,14,1,2,_binary ''),(694,5,14,2,2,_binary ''),(695,5,14,4,2,_binary ''),(696,5,14,5,2,_binary ''),(697,5,14,1,3,_binary ''),(698,5,14,2,3,_binary ''),(699,5,14,4,3,_binary ''),(700,5,14,5,3,_binary ''),(701,5,14,1,4,_binary ''),(702,5,14,2,4,_binary ''),(703,5,14,4,4,_binary ''),(704,5,14,5,4,_binary ''),(705,5,14,1,5,_binary ''),(706,5,14,2,5,_binary ''),(707,5,14,4,5,_binary ''),(708,5,14,5,5,_binary ''),(709,5,14,1,6,_binary ''),(710,5,14,2,6,_binary ''),(711,5,14,4,6,_binary ''),(712,5,14,5,6,_binary ''),(713,5,14,1,7,_binary ''),(714,5,14,2,7,_binary ''),(715,5,14,4,7,_binary ''),(716,5,14,5,7,_binary ''),(717,5,14,1,8,_binary ''),(718,5,14,2,8,_binary ''),(719,5,14,4,8,_binary ''),(720,5,14,5,8,_binary ''),(721,5,14,1,9,_binary ''),(722,5,14,2,9,_binary ''),(723,5,14,3,9,_binary '\0'),(724,5,14,4,9,_binary ''),(725,5,14,5,9,_binary ''),(726,5,14,1,10,_binary ''),(727,5,14,2,10,_binary ''),(728,5,14,3,10,_binary '\0'),(729,5,14,4,10,_binary ''),(730,5,14,5,10,_binary ''),(731,1,15,1,1,_binary ''),(732,1,15,1,2,_binary ''),(733,1,15,1,3,_binary ''),(734,1,15,1,4,_binary ''),(735,1,15,1,5,_binary ''),(736,1,15,1,6,_binary ''),(737,1,15,1,7,_binary ''),(738,1,15,1,8,_binary ''),(739,1,15,1,9,_binary ''),(740,1,15,1,10,_binary ''),(741,1,15,1,11,_binary ''),(742,1,15,2,1,_binary ''),(743,1,15,2,2,_binary ''),(744,1,15,2,3,_binary ''),(745,1,15,2,4,_binary ''),(746,1,15,2,5,_binary ''),(747,1,15,2,6,_binary ''),(748,1,15,2,7,_binary ''),(749,1,15,2,8,_binary ''),(750,1,15,2,9,_binary ''),(751,1,15,2,10,_binary ''),(752,1,15,2,11,_binary ''),(753,1,15,3,11,_binary ''),(754,1,15,4,1,_binary ''),(755,1,15,4,2,_binary ''),(756,1,15,4,3,_binary ''),(757,1,15,4,4,_binary ''),(758,1,15,4,5,_binary ''),(759,1,15,4,6,_binary ''),(760,1,15,4,7,_binary ''),(761,1,15,4,8,_binary ''),(762,1,15,4,9,_binary ''),(763,1,15,4,10,_binary ''),(764,1,15,4,11,_binary ''),(765,1,15,5,1,_binary ''),(766,1,15,5,2,_binary ''),(767,1,15,5,3,_binary ''),(768,1,15,5,4,_binary ''),(769,1,15,5,5,_binary ''),(770,1,15,5,6,_binary ''),(771,1,15,5,7,_binary ''),(772,1,15,5,8,_binary ''),(773,1,15,5,9,_binary ''),(774,1,15,5,10,_binary ''),(775,1,15,5,11,_binary ''),(776,1,15,1,1,_binary ''),(777,1,15,1,2,_binary ''),(778,1,15,1,3,_binary ''),(779,1,15,1,4,_binary ''),(780,1,15,1,5,_binary ''),(781,1,15,1,6,_binary ''),(782,1,15,1,7,_binary ''),(783,1,15,1,8,_binary ''),(784,1,15,1,9,_binary ''),(785,1,15,1,10,_binary ''),(786,1,15,1,11,_binary ''),(787,1,15,2,1,_binary ''),(788,1,15,2,2,_binary ''),(789,1,15,2,3,_binary ''),(790,1,15,2,4,_binary ''),(791,1,15,2,5,_binary ''),(792,1,15,2,6,_binary ''),(793,1,15,2,7,_binary ''),(794,1,15,2,8,_binary ''),(795,1,15,2,9,_binary ''),(796,1,15,2,10,_binary ''),(797,1,15,2,11,_binary ''),(798,1,15,3,11,_binary ''),(799,1,15,4,1,_binary ''),(800,1,15,4,2,_binary ''),(801,1,15,4,3,_binary ''),(802,1,15,4,4,_binary ''),(803,1,15,4,5,_binary ''),(804,1,15,4,6,_binary ''),(805,1,15,4,7,_binary ''),(806,1,15,4,8,_binary ''),(807,1,15,4,9,_binary ''),(808,1,15,4,10,_binary ''),(809,1,15,4,11,_binary ''),(810,1,15,5,1,_binary ''),(811,1,15,5,2,_binary ''),(812,1,15,5,3,_binary ''),(813,1,15,5,4,_binary ''),(814,1,15,5,5,_binary ''),(815,1,15,5,6,_binary ''),(816,1,15,5,7,_binary ''),(817,1,15,5,8,_binary ''),(818,1,15,5,9,_binary ''),(819,1,15,5,10,_binary ''),(820,1,15,5,11,_binary ''),(821,1,16,1,1,_binary ''),(822,1,16,1,2,_binary ''),(823,1,16,1,3,_binary ''),(824,1,16,1,4,_binary ''),(825,1,16,1,5,_binary ''),(826,1,16,1,6,_binary ''),(827,1,16,1,7,_binary ''),(828,1,16,1,8,_binary ''),(829,1,16,1,9,_binary ''),(830,1,16,1,10,_binary ''),(831,1,16,1,11,_binary ''),(832,1,16,2,1,_binary ''),(833,1,16,2,2,_binary ''),(834,1,16,2,3,_binary ''),(835,1,16,2,4,_binary ''),(836,1,16,2,5,_binary ''),(837,1,16,2,6,_binary ''),(838,1,16,2,7,_binary ''),(839,1,16,2,8,_binary ''),(840,1,16,2,9,_binary ''),(841,1,16,2,10,_binary ''),(842,1,16,2,11,_binary ''),(843,1,16,3,11,_binary ''),(844,1,16,4,1,_binary ''),(845,1,16,4,2,_binary ''),(846,1,16,4,3,_binary ''),(847,1,16,4,4,_binary ''),(848,1,16,4,5,_binary ''),(849,1,16,4,6,_binary ''),(850,1,16,4,7,_binary ''),(851,1,16,4,8,_binary ''),(852,1,16,4,9,_binary ''),(853,1,16,4,10,_binary ''),(854,1,16,4,11,_binary ''),(855,1,16,5,1,_binary ''),(856,1,16,5,2,_binary ''),(857,1,16,5,3,_binary ''),(858,1,16,5,4,_binary ''),(859,1,16,5,5,_binary ''),(860,1,16,5,6,_binary ''),(861,1,16,5,7,_binary ''),(862,1,16,5,8,_binary ''),(863,1,16,5,9,_binary ''),(864,1,16,5,10,_binary ''),(865,1,16,5,11,_binary ''),(866,1,17,1,1,_binary ''),(867,1,17,1,2,_binary ''),(868,1,17,1,3,_binary ''),(869,1,17,1,4,_binary ''),(870,1,17,1,5,_binary ''),(871,1,17,1,6,_binary ''),(872,1,17,1,7,_binary ''),(873,1,17,1,8,_binary ''),(874,1,17,1,9,_binary ''),(875,1,17,1,10,_binary ''),(876,1,17,1,11,_binary ''),(877,1,17,2,1,_binary ''),(878,1,17,2,2,_binary ''),(879,1,17,2,3,_binary ''),(880,1,17,2,4,_binary ''),(881,1,17,2,5,_binary ''),(882,1,17,2,6,_binary ''),(883,1,17,2,7,_binary ''),(884,1,17,2,8,_binary ''),(885,1,17,2,9,_binary ''),(886,1,17,2,10,_binary ''),(887,1,17,2,11,_binary ''),(888,1,17,3,11,_binary ''),(889,1,17,4,1,_binary ''),(890,1,17,4,2,_binary ''),(891,1,17,4,3,_binary ''),(892,1,17,4,4,_binary ''),(893,1,17,4,5,_binary ''),(894,1,17,4,6,_binary ''),(895,1,17,4,7,_binary ''),(896,1,17,4,8,_binary ''),(897,1,17,4,9,_binary ''),(898,1,17,4,10,_binary ''),(899,1,17,4,11,_binary ''),(900,1,17,5,1,_binary ''),(901,1,17,5,2,_binary ''),(902,1,17,5,3,_binary ''),(903,1,17,5,4,_binary ''),(904,1,17,5,5,_binary ''),(905,1,17,5,6,_binary ''),(906,1,17,5,7,_binary ''),(907,1,17,5,8,_binary ''),(908,1,17,5,9,_binary ''),(909,1,17,5,10,_binary ''),(910,1,17,5,11,_binary ''),(911,1,16,1,1,_binary ''),(912,1,16,1,2,_binary ''),(913,1,16,1,3,_binary ''),(914,1,16,1,4,_binary ''),(915,1,16,1,5,_binary ''),(916,1,16,1,6,_binary ''),(917,1,16,1,7,_binary ''),(918,1,16,1,8,_binary ''),(919,1,16,1,9,_binary ''),(920,1,16,1,10,_binary ''),(921,1,16,1,11,_binary ''),(922,1,16,2,1,_binary ''),(923,1,16,2,2,_binary ''),(924,1,16,2,3,_binary ''),(925,1,16,2,4,_binary ''),(926,1,16,2,5,_binary ''),(927,1,16,2,6,_binary ''),(928,1,16,2,7,_binary ''),(929,1,16,2,8,_binary ''),(930,1,16,2,9,_binary ''),(931,1,16,2,10,_binary ''),(932,1,16,2,11,_binary ''),(933,1,16,3,11,_binary ''),(934,1,16,4,1,_binary ''),(935,1,16,4,2,_binary ''),(936,1,16,4,3,_binary ''),(937,1,16,4,4,_binary ''),(938,1,16,4,5,_binary ''),(939,1,16,4,6,_binary ''),(940,1,16,4,7,_binary ''),(941,1,16,4,8,_binary ''),(942,1,16,4,9,_binary ''),(943,1,16,4,10,_binary ''),(944,1,16,4,11,_binary ''),(945,1,16,5,1,_binary ''),(946,1,16,5,2,_binary ''),(947,1,16,5,3,_binary ''),(948,1,16,5,4,_binary ''),(949,1,16,5,5,_binary ''),(950,1,16,5,6,_binary ''),(951,1,16,5,7,_binary ''),(952,1,16,5,8,_binary ''),(953,1,16,5,9,_binary ''),(954,1,16,5,10,_binary ''),(955,1,16,5,11,_binary ''),(956,1,17,1,1,_binary ''),(957,1,17,1,2,_binary ''),(958,1,17,1,3,_binary ''),(959,1,17,1,4,_binary ''),(960,1,17,1,5,_binary ''),(961,1,17,1,6,_binary ''),(962,1,17,1,7,_binary ''),(963,1,17,1,8,_binary ''),(964,1,17,1,9,_binary ''),(965,1,17,1,10,_binary ''),(966,1,17,1,11,_binary ''),(967,1,17,2,1,_binary ''),(968,1,17,2,2,_binary ''),(969,1,17,2,3,_binary ''),(970,1,17,2,4,_binary ''),(971,1,17,2,5,_binary ''),(972,1,17,2,6,_binary ''),(973,1,17,2,7,_binary ''),(974,1,17,2,8,_binary ''),(975,1,17,2,9,_binary ''),(976,1,17,2,10,_binary ''),(977,1,17,2,11,_binary ''),(978,1,17,3,11,_binary ''),(979,1,17,4,1,_binary ''),(980,1,17,4,2,_binary ''),(981,1,17,4,3,_binary ''),(982,1,17,4,4,_binary ''),(983,1,17,4,5,_binary ''),(984,1,17,4,6,_binary ''),(985,1,17,4,7,_binary ''),(986,1,17,4,8,_binary ''),(987,1,17,4,9,_binary ''),(988,1,17,4,10,_binary ''),(989,1,17,4,11,_binary ''),(990,1,17,5,1,_binary ''),(991,1,17,5,2,_binary ''),(992,1,17,5,3,_binary ''),(993,1,17,5,4,_binary ''),(994,1,17,5,5,_binary ''),(995,1,17,5,6,_binary ''),(996,1,17,5,7,_binary ''),(997,1,17,5,8,_binary ''),(998,1,17,5,9,_binary ''),(999,1,17,5,10,_binary ''),(1000,1,17,5,11,_binary '');
/*!40000 ALTER TABLE `bus_seat_trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ticket_id` int NOT NULL,
  `comment` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,17,'Xe chạy ok'),(2,11,'Tốt'),(3,21,'Xuất sắc'),(4,21,'So good!'),(5,4,'Amazing good job');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin','Quản trị'),(2,'Staff','Nhân viên'),(3,'Driver','Tài xế'),(4,'User','Người dùng');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `end_location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,'Hồ Chí Minh','Gia Lai'),(2,'Gia Lai','Hồ Chí Minh'),(3,'Hồ Chí Minh','Đà Lạt'),(4,'Đà Lạt','Hồ Chí Minh'),(5,'Hồ Chí Minh','Tiền Giang'),(6,'Tiền Giang','Hồ Chí Minh'),(7,'Lâm Đồng','Hồ Chí Minh'),(8,'Hồ Chí Minh','Lâm Đồng'),(9,'Hồ Chí Minh','Long An'),(10,'Long An','Hồ Chí Minh'),(11,'Hồ Chí Minh','Vĩnh Long'),(12,'Vĩnh Long','Hồ Chí Minh'),(13,'Hồ Chí Minh','Tây Ninh'),(14,'Tây Ninh','Hồ Chí Minh'),(15,'Hồ Chí Minh','Bà Rịa - Vũng Tàu'),(16,'Bà Rịa - Vũng Tàu','Hồ Chí Minh'),(17,'Hồ Chí Minh','Cần Thơ'),(18,'Cần Thơ','Hồ Chí Minh');
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trip_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `paid_with` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `paid_price` int DEFAULT NULL,
  `is_paid` bit(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_id` (`trip_id`),
  KEY `user_id` (`user_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`),
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `ticket_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,1,4,NULL,'Tiền mặt',246010,_binary '\0','2023-08-11 11:05:41'),(2,1,4,2,'Tiền mặt',246010,_binary '','2023-06-22 12:38:00'),(3,6,4,NULL,'Tiền mặt',642010,_binary '\0','2023-08-11 12:39:46'),(4,6,4,2,'Tiền mặt',642010,_binary '','2023-08-11 12:40:22'),(5,1,4,2,'Tiền mặt',738010,_binary '','2023-08-11 12:56:00'),(6,1,4,NULL,'Tiền mặt',123010,_binary '\0','2023-08-11 13:04:33'),(7,8,4,NULL,'Tiền mặt',369010,_binary '\0','2023-02-02 13:06:00'),(8,1,4,NULL,'Tiền mặt',492010,_binary '\0','2023-06-16 13:36:00'),(9,1,4,NULL,'Tiền mặt',123010,_binary '\0','2023-08-11 13:37:11'),(10,8,4,NULL,'Tiền mặt',123010,_binary '\0','2023-08-11 13:37:17'),(11,8,4,2,'Tiền mặt',246010,_binary '','2022-02-10 13:37:00'),(12,11,4,7,'Chuyển khoản',400000,_binary '','2023-08-18 11:44:02'),(13,10,4,8,'Momo',640000,_binary '','2023-08-18 11:46:19'),(14,9,4,6,'Tiền mặt',1000000,_binary '','2023-08-18 11:46:50'),(15,2,4,7,'Momo',369000,_binary '','2023-08-18 11:49:00'),(16,5,4,8,'Tiền mặt',200000,_binary '\0','2023-08-18 11:50:50'),(17,4,4,6,'Tiền mặt',1200000,_binary '','2023-08-18 11:51:30'),(18,7,11,8,'Tiền mặt',130000,_binary '','2023-08-18 11:52:02'),(19,3,12,2,'Chuyển khoản',215000,_binary '','2023-08-18 11:53:00'),(20,12,11,6,'Momo',1500000,_binary '\0','2023-08-18 11:57:22'),(21,14,13,8,'Momo',950000,_binary '','2023-08-18 12:01:49');
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_detail`
--

DROP TABLE IF EXISTS `ticket_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ticket_id` int DEFAULT NULL,
  `bus_seat_trip_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `bus_seat_trip_id` (`bus_seat_trip_id`),
  CONSTRAINT `ticket_detail_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`),
  CONSTRAINT `ticket_detail_ibfk_2` FOREIGN KEY (`bus_seat_trip_id`) REFERENCES `bus_seat_trip` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_detail`
--

LOCK TABLES `ticket_detail` WRITE;
/*!40000 ALTER TABLE `ticket_detail` DISABLE KEYS */;
INSERT INTO `ticket_detail` VALUES (1,1,4),(2,1,15),(3,2,5),(4,2,16),(5,3,223),(6,3,224),(7,4,233),(8,4,234),(9,5,1),(10,5,12),(11,6,2),(12,7,332),(13,7,343),(14,7,344),(15,5,24),(16,5,25),(17,5,35),(18,5,36),(19,8,28),(20,8,29),(21,8,39),(22,8,40),(23,9,13),(24,10,333),(25,11,329),(26,11,340),(27,12,584),(28,13,528),(29,13,529),(30,14,484),(31,14,485),(32,14,488),(33,14,489),(34,15,374),(35,15,385),(36,15,386),(37,16,194),(38,17,454),(39,17,455),(40,17,466),(41,17,467),(42,18,285),(43,18,295),(44,19,407),(45,20,611),(46,20,614),(47,20,615),(48,21,723),(49,21,728);
/*!40000 ALTER TABLE `ticket_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `id` int NOT NULL AUTO_INCREMENT,
  `route_id` int NOT NULL,
  `driver_id` int NOT NULL,
  `bus_id` int NOT NULL,
  `start_at` timestamp NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `route_id` (`route_id`),
  KEY `driver_id` (`driver_id`),
  KEY `bus_id` (`bus_id`),
  CONSTRAINT `trip_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`),
  CONSTRAINT `trip_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `user` (`id`),
  CONSTRAINT `trip_ibfk_3` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (1,6,5,1,'2023-08-20 10:30:00',123000),(2,6,3,1,'2023-08-06 07:05:00',123000),(3,1,5,1,'2023-08-06 07:06:00',215000),(4,3,3,1,'2023-08-06 07:06:00',300000),(5,5,3,2,'2023-08-06 08:01:00',200000),(6,6,3,2,'2023-08-24 10:40:00',321000),(7,7,3,2,'2024-05-10 10:30:00',65000),(8,7,3,1,'2024-08-12 10:30:00',123000),(9,13,10,5,'2023-08-18 11:40:00',250000),(10,16,9,4,'2023-08-18 11:50:00',320000),(11,11,10,6,'2023-09-01 00:50:00',400000),(12,18,10,3,'2023-08-26 04:15:00',500000),(13,16,9,4,'2023-08-27 18:00:00',258300),(14,9,5,5,'2023-08-18 12:00:00',475000),(15,16,5,1,'2023-09-04 23:00:00',425000),(16,4,9,1,'2023-08-20 10:20:00',100000),(17,1,10,1,'2023-09-01 22:25:00',180000);
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','$2a$10$l2Rr5ZxrvnO4u8kDJt9kzuz30cubwy5qBG4OrylZNOncgYnY5BaaK','Admin','','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692329311/vzjz4x7qgo2srrrebmhv.png',1),(2,'staff','$2a$10$l2Rr5ZxrvnO4u8kDJt9kzuz30cubwy5qBG4OrylZNOncgYnY5BaaK','Staff','Anh','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692355366/dbccgtmsr7ojdemhiesh.png',2),(3,'driver','$2a$10$l2Rr5ZxrvnO4u8kDJt9kzuz30cubwy5qBG4OrylZNOncgYnY5BaaK','Tài Xế','Chú','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692356335/j6tjridq8ou4fyxetkww.png',3),(4,'user001','$2a$10$l2Rr5ZxrvnO4u8kDJt9kzuz30cubwy5qBG4OrylZNOncgYnY5BaaK','Ba','Nguyễn Văn','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692356551/on9cgchir8kuhn4wqmw7.jpg',4),(5,'driver1','$2a$10$l2Rr5ZxrvnO4u8kDJt9kzuz30cubwy5qBG4OrylZNOncgYnY5BaaK','Tài','Nguyễn Anh','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692356379/a4bbnvgr7poi0zm9ujhy.jpg',3),(6,'staff1','$2a$10$Z0QvBHel/pvAxJpS/cF1QuXbK9gFh.Q0t.BwMv3lnzRayJCB3GYGi','Viên','Nguyễn Nhân','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692356207/opcgmfu8zzxgt30ktnse.png',2),(7,'staff2','$2a$10$g1aDm195Ni7Q1y5/9VKKXeojdGgW9upzMQlrG0XxFZlaCwybGduyK','A','Nguyễn Văn','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692356263/ws1t6b8shsoaaggn5gfc.png',2),(8,'staff3','$2a$10$XEnBtNb7ihiRYwtN0aF95ulJk3bNjBU6jaSOFAZ8blY.QLM6WRT/C','B','Trần Văn','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692356306/ttisuaarbgse5qn7ixbc.png',2),(9,'driver2','$2a$10$TXgazc9D1ByNa4jcYZMmie8awg060YJbfaSXzKfXrG4A.rkE8ni4u','Lái Xe','Chú','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692356447/pf3bpnrndwtfnxhcjs8c.jpg',3),(10,'driver3','$2a$10$YF0ETBiOK4oLBLN59SoH.uDQHqpIfpDXpq6U/1IFvwdU6eH3n6F3q','Long','Nguyễn Hồ','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692356526/pg6p0bdt0ksjhnl4x8bv.jpg',3),(11,'user002','$2a$10$3i9Er4BKYziuVHpgAJ5TVe/PfO/xbk0az20oxrbIm1GvSUEIdTS8W','Hưng','Nguyễn Đức','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692358093/tjtqldfpm2izm62ke2gl.jpg',4),(12,'user003','$2a$10$X0b8801e6TpcQfSz0Ms6x.jMZJ8rFXAzU34wtspciCCpGuUL.K4Au','Nguyên','Nguyễn Trường','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692358135/evzxp1ivbbapledee8eq.jpg',4),(13,'user004','$2a$10$oBMy7Zt3kPIju2GB93Zc.OT1PX1/PhLzelud8lVrVGuecbGoaTyiy','Giang','Nguyễn Thị Cẩm','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692358183/jitq8te47faiw2sk3qyy.webp',4),(14,'user005','$2a$10$cAwnDF2eRhrL0BbNehNHT.iZCV/gsJsWBW1OIbDurSO./8zazAVDG','Kiệm','Nguyễn','https://res.cloudinary.com/dyc5pggxo/image/upload/v1692529198/rtl5hhpjt8jfnrvwruuh.jpg',4);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-20 18:09:08
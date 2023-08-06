CREATE DATABASE  IF NOT EXISTS `xekhachdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `xekhachdb`;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus`
--

LOCK TABLES `bus` WRITE;
/*!40000 ALTER TABLE `bus` DISABLE KEYS */;
INSERT INTO `bus` VALUES (1,'51B-00172','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647248652/dkeolz3ghc0eino87iec.jpg'),(2,'51H-35864','https://images.pexels.com/photos/5896476/pexels-photo-5896476.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');
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
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_seat_template`
--

LOCK TABLES `bus_seat_template` WRITE;
/*!40000 ALTER TABLE `bus_seat_template` DISABLE KEYS */;
INSERT INTO `bus_seat_template` VALUES (1,1,1,1),(2,1,1,2),(3,1,1,3),(4,1,1,4),(5,1,1,5),(6,1,1,6),(7,1,1,7),(8,1,1,8),(9,1,1,9),(10,1,1,10),(11,1,1,11),(12,1,2,1),(13,1,2,2),(14,1,2,3),(15,1,2,4),(16,1,2,5),(17,1,2,6),(18,1,2,7),(19,1,2,8),(20,1,2,9),(21,1,2,10),(22,1,2,11),(23,1,3,11),(24,1,4,1),(25,1,4,2),(26,1,4,3),(27,1,4,4),(28,1,4,5),(29,1,4,6),(30,1,4,7),(31,1,4,8),(32,1,4,9),(33,1,4,10),(34,1,4,11),(35,1,5,1),(36,1,5,2),(37,1,5,3),(38,1,5,4),(39,1,5,5),(40,1,5,6),(41,1,5,7),(42,1,5,8),(43,1,5,9),(44,1,5,10),(45,1,5,11),(46,2,1,1),(47,2,1,2),(48,2,1,3),(49,2,1,4),(50,2,1,5),(51,2,1,6),(52,2,1,7),(53,2,1,8),(54,2,1,9),(55,2,1,10),(56,2,2,1),(57,2,2,2),(58,2,2,3),(59,2,2,4),(60,2,2,5),(61,2,2,6),(62,2,2,7),(63,2,2,8),(64,2,2,9),(65,2,2,10),(66,2,3,10),(67,2,4,1),(68,2,4,2),(69,2,4,3),(70,2,4,4),(71,2,4,5),(72,2,4,6),(73,2,4,7),(74,2,4,8),(75,2,4,9),(76,2,4,10),(77,2,5,1),(78,2,5,2),(79,2,5,3),(80,2,5,4),(81,2,5,5),(82,2,5,6),(83,2,5,7),(84,2,5,8),(85,2,5,9),(86,2,5,10);
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
) ENGINE=InnoDB AUTO_INCREMENT=394 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_seat_trip`
--

LOCK TABLES `bus_seat_trip` WRITE;
/*!40000 ALTER TABLE `bus_seat_trip` DISABLE KEYS */;
INSERT INTO `bus_seat_trip` VALUES (1,1,1,1,1,_binary ''),(2,1,1,1,2,_binary ''),(3,1,1,1,3,_binary ''),(4,1,1,1,4,_binary ''),(5,1,1,1,5,_binary ''),(6,1,1,1,6,_binary ''),(7,1,1,1,7,_binary ''),(8,1,1,1,8,_binary ''),(9,1,1,1,9,_binary ''),(10,1,1,1,10,_binary ''),(11,1,1,1,11,_binary ''),(12,1,1,2,1,_binary ''),(13,1,1,2,2,_binary ''),(14,1,1,2,3,_binary ''),(15,1,1,2,4,_binary ''),(16,1,1,2,5,_binary ''),(17,1,1,2,6,_binary ''),(18,1,1,2,7,_binary ''),(19,1,1,2,8,_binary ''),(20,1,1,2,9,_binary ''),(21,1,1,2,10,_binary ''),(22,1,1,2,11,_binary ''),(23,1,1,3,11,_binary ''),(24,1,1,4,1,_binary ''),(25,1,1,4,2,_binary ''),(26,1,1,4,3,_binary ''),(27,1,1,4,4,_binary ''),(28,1,1,4,5,_binary ''),(29,1,1,4,6,_binary ''),(30,1,1,4,7,_binary ''),(31,1,1,4,8,_binary ''),(32,1,1,4,9,_binary ''),(33,1,1,4,10,_binary ''),(34,1,1,4,11,_binary ''),(35,1,1,5,1,_binary ''),(36,1,1,5,2,_binary ''),(37,1,1,5,3,_binary ''),(38,1,1,5,4,_binary ''),(39,1,1,5,5,_binary ''),(40,1,1,5,6,_binary ''),(41,1,1,5,7,_binary ''),(42,1,1,5,8,_binary ''),(43,1,1,5,9,_binary ''),(44,1,1,5,10,_binary ''),(45,1,1,5,11,_binary ''),(46,1,1,1,1,_binary ''),(47,1,1,1,2,_binary ''),(48,1,1,1,3,_binary ''),(49,1,1,1,4,_binary ''),(50,1,1,1,5,_binary ''),(51,1,1,1,6,_binary ''),(52,1,1,1,7,_binary ''),(53,1,1,1,8,_binary ''),(54,1,1,1,9,_binary ''),(55,1,1,1,10,_binary ''),(56,1,1,1,11,_binary ''),(57,1,1,2,1,_binary ''),(58,1,1,2,2,_binary ''),(59,1,1,2,3,_binary ''),(60,1,1,2,4,_binary ''),(61,1,1,2,5,_binary ''),(62,1,1,2,6,_binary ''),(63,1,1,2,7,_binary ''),(64,1,1,2,8,_binary ''),(65,1,1,2,9,_binary ''),(66,1,1,2,10,_binary ''),(67,1,1,2,11,_binary ''),(68,1,1,3,11,_binary ''),(69,1,1,4,1,_binary ''),(70,1,1,4,2,_binary ''),(71,1,1,4,3,_binary ''),(72,1,1,4,4,_binary ''),(73,1,1,4,5,_binary ''),(74,1,1,4,6,_binary ''),(75,1,1,4,7,_binary ''),(76,1,1,4,8,_binary ''),(77,1,1,4,9,_binary ''),(78,1,1,4,10,_binary ''),(79,1,1,4,11,_binary ''),(80,1,1,5,1,_binary ''),(81,1,1,5,2,_binary ''),(82,1,1,5,3,_binary ''),(83,1,1,5,4,_binary ''),(84,1,1,5,5,_binary ''),(85,1,1,5,6,_binary ''),(86,1,1,5,7,_binary ''),(87,1,1,5,8,_binary ''),(88,1,1,5,9,_binary ''),(89,1,1,5,10,_binary ''),(90,1,1,5,11,_binary ''),(91,1,2,1,1,_binary ''),(92,1,2,1,2,_binary ''),(93,1,2,1,3,_binary ''),(94,1,2,1,4,_binary ''),(95,1,2,1,5,_binary ''),(96,1,2,1,6,_binary ''),(97,1,2,1,7,_binary ''),(98,1,2,1,8,_binary ''),(99,1,2,1,9,_binary ''),(100,1,2,1,10,_binary ''),(101,1,2,1,11,_binary ''),(102,1,2,2,1,_binary ''),(103,1,2,2,2,_binary ''),(104,1,2,2,3,_binary ''),(105,1,2,2,4,_binary ''),(106,1,2,2,5,_binary ''),(107,1,2,2,6,_binary ''),(108,1,2,2,7,_binary ''),(109,1,2,2,8,_binary ''),(110,1,2,2,9,_binary ''),(111,1,2,2,10,_binary ''),(112,1,2,2,11,_binary ''),(113,1,2,3,11,_binary ''),(114,1,2,4,1,_binary ''),(115,1,2,4,2,_binary ''),(116,1,2,4,3,_binary ''),(117,1,2,4,4,_binary ''),(118,1,2,4,5,_binary ''),(119,1,2,4,6,_binary ''),(120,1,2,4,7,_binary ''),(121,1,2,4,8,_binary ''),(122,1,2,4,9,_binary ''),(123,1,2,4,10,_binary ''),(124,1,2,4,11,_binary ''),(125,1,2,5,1,_binary ''),(126,1,2,5,2,_binary ''),(127,1,2,5,3,_binary ''),(128,1,2,5,4,_binary ''),(129,1,2,5,5,_binary ''),(130,1,2,5,6,_binary ''),(131,1,2,5,7,_binary ''),(132,1,2,5,8,_binary ''),(133,1,2,5,9,_binary ''),(134,1,2,5,10,_binary ''),(135,1,2,5,11,_binary ''),(136,1,3,1,1,_binary ''),(137,1,3,1,2,_binary ''),(138,1,3,1,3,_binary ''),(139,1,3,1,4,_binary ''),(140,1,3,1,5,_binary ''),(141,1,3,1,6,_binary ''),(142,1,3,1,7,_binary ''),(143,1,3,1,8,_binary ''),(144,1,3,1,9,_binary ''),(145,1,3,1,10,_binary ''),(146,1,3,1,11,_binary ''),(147,1,3,2,1,_binary ''),(148,1,3,2,2,_binary ''),(149,1,3,2,3,_binary ''),(150,1,3,2,4,_binary ''),(151,1,3,2,5,_binary ''),(152,1,3,2,6,_binary ''),(153,1,3,2,7,_binary ''),(154,1,3,2,8,_binary ''),(155,1,3,2,9,_binary ''),(156,1,3,2,10,_binary ''),(157,1,3,2,11,_binary ''),(158,1,3,3,11,_binary ''),(159,1,3,4,1,_binary ''),(160,1,3,4,2,_binary ''),(161,1,3,4,3,_binary ''),(162,1,3,4,4,_binary ''),(163,1,3,4,5,_binary ''),(164,1,3,4,6,_binary ''),(165,1,3,4,7,_binary ''),(166,1,3,4,8,_binary ''),(167,1,3,4,9,_binary ''),(168,1,3,4,10,_binary ''),(169,1,3,4,11,_binary ''),(170,1,3,5,1,_binary ''),(171,1,3,5,2,_binary ''),(172,1,3,5,3,_binary ''),(173,1,3,5,4,_binary ''),(174,1,3,5,5,_binary ''),(175,1,3,5,6,_binary ''),(176,1,3,5,7,_binary ''),(177,1,3,5,8,_binary ''),(178,1,3,5,9,_binary ''),(179,1,3,5,10,_binary ''),(180,1,3,5,11,_binary ''),(181,1,4,1,1,_binary ''),(182,1,4,1,2,_binary ''),(183,1,4,1,3,_binary ''),(184,1,4,1,4,_binary ''),(185,1,4,1,5,_binary ''),(186,1,4,1,6,_binary ''),(187,1,4,1,7,_binary ''),(188,1,4,1,8,_binary ''),(189,1,4,1,9,_binary ''),(190,1,4,1,10,_binary ''),(191,1,4,1,11,_binary ''),(192,1,4,2,1,_binary ''),(193,1,4,2,2,_binary ''),(194,1,4,2,3,_binary ''),(195,1,4,2,4,_binary ''),(196,1,4,2,5,_binary ''),(197,1,4,2,6,_binary ''),(198,1,4,2,7,_binary ''),(199,1,4,2,8,_binary ''),(200,1,4,2,9,_binary ''),(201,1,4,2,10,_binary ''),(202,1,4,2,11,_binary ''),(203,1,4,3,11,_binary ''),(204,1,4,4,1,_binary ''),(205,1,4,4,2,_binary ''),(206,1,4,4,3,_binary ''),(207,1,4,4,4,_binary ''),(208,1,4,4,5,_binary ''),(209,1,4,4,6,_binary ''),(210,1,4,4,7,_binary ''),(211,1,4,4,8,_binary ''),(212,1,4,4,9,_binary ''),(213,1,4,4,10,_binary ''),(214,1,4,4,11,_binary ''),(215,1,4,5,1,_binary ''),(216,1,4,5,2,_binary ''),(217,1,4,5,3,_binary ''),(218,1,4,5,4,_binary ''),(219,1,4,5,5,_binary ''),(220,1,4,5,6,_binary ''),(221,1,4,5,7,_binary ''),(222,1,4,5,8,_binary ''),(223,1,4,5,9,_binary ''),(224,1,4,5,10,_binary ''),(225,1,4,5,11,_binary ''),(226,2,5,1,1,_binary ''),(227,2,5,1,2,_binary ''),(228,2,5,1,3,_binary ''),(229,2,5,1,4,_binary ''),(230,2,5,1,5,_binary ''),(231,2,5,1,6,_binary ''),(232,2,5,1,7,_binary ''),(233,2,5,1,8,_binary ''),(234,2,5,1,9,_binary ''),(235,2,5,1,10,_binary ''),(236,2,5,2,1,_binary ''),(237,2,5,2,2,_binary ''),(238,2,5,2,3,_binary ''),(239,2,5,2,4,_binary ''),(240,2,5,2,5,_binary ''),(241,2,5,2,6,_binary ''),(242,2,5,2,7,_binary ''),(243,2,5,2,8,_binary ''),(244,2,5,2,9,_binary ''),(245,2,5,2,10,_binary ''),(246,2,5,3,10,_binary ''),(247,2,5,4,1,_binary ''),(248,2,5,4,2,_binary ''),(249,2,5,4,3,_binary ''),(250,2,5,4,4,_binary ''),(251,2,5,4,5,_binary ''),(252,2,5,4,6,_binary ''),(253,2,5,4,7,_binary ''),(254,2,5,4,8,_binary ''),(255,2,5,4,9,_binary ''),(256,2,5,4,10,_binary ''),(257,2,5,5,1,_binary ''),(258,2,5,5,2,_binary ''),(259,2,5,5,3,_binary ''),(260,2,5,5,4,_binary ''),(261,2,5,5,5,_binary ''),(262,2,5,5,6,_binary ''),(263,2,5,5,7,_binary ''),(264,2,5,5,8,_binary ''),(265,2,5,5,9,_binary ''),(266,2,5,5,10,_binary ''),(267,2,6,1,1,_binary ''),(268,2,6,1,2,_binary ''),(269,2,6,1,3,_binary ''),(270,2,6,1,4,_binary ''),(271,2,6,1,5,_binary ''),(272,2,6,1,6,_binary ''),(273,2,6,1,7,_binary ''),(274,2,6,1,8,_binary ''),(275,2,6,1,9,_binary ''),(276,2,6,1,10,_binary ''),(277,2,6,2,1,_binary ''),(278,2,6,2,2,_binary ''),(279,2,6,2,3,_binary ''),(280,2,6,2,4,_binary ''),(281,2,6,2,5,_binary ''),(282,2,6,2,6,_binary ''),(283,2,6,2,7,_binary ''),(284,2,6,2,8,_binary ''),(285,2,6,2,9,_binary ''),(286,2,6,2,10,_binary ''),(287,2,6,3,10,_binary ''),(288,2,6,4,1,_binary ''),(289,2,6,4,2,_binary ''),(290,2,6,4,3,_binary ''),(291,2,6,4,4,_binary ''),(292,2,6,4,5,_binary ''),(293,2,6,4,6,_binary ''),(294,2,6,4,7,_binary ''),(295,2,6,4,8,_binary ''),(296,2,6,4,9,_binary ''),(297,2,6,4,10,_binary ''),(298,2,6,5,1,_binary ''),(299,2,6,5,2,_binary ''),(300,2,6,5,3,_binary ''),(301,2,6,5,4,_binary ''),(302,2,6,5,5,_binary ''),(303,2,6,5,6,_binary ''),(304,2,6,5,7,_binary ''),(305,2,6,5,8,_binary ''),(306,2,6,5,9,_binary ''),(307,2,6,5,10,_binary ''),(308,2,7,1,1,_binary ''),(309,2,7,1,2,_binary ''),(310,2,7,1,3,_binary ''),(311,2,7,1,4,_binary ''),(312,2,7,1,5,_binary ''),(313,2,7,1,6,_binary ''),(314,2,7,1,7,_binary ''),(315,2,7,1,8,_binary ''),(316,2,7,1,9,_binary ''),(317,2,7,1,10,_binary ''),(318,2,7,2,1,_binary ''),(319,2,7,2,2,_binary ''),(320,2,7,2,3,_binary ''),(321,2,7,2,4,_binary ''),(322,2,7,2,5,_binary ''),(323,2,7,2,6,_binary ''),(324,2,7,2,7,_binary ''),(325,2,7,2,8,_binary ''),(326,2,7,2,9,_binary ''),(327,2,7,2,10,_binary ''),(328,2,7,3,10,_binary ''),(329,2,7,4,1,_binary ''),(330,2,7,4,2,_binary ''),(331,2,7,4,3,_binary ''),(332,2,7,4,4,_binary ''),(333,2,7,4,5,_binary ''),(334,2,7,4,6,_binary ''),(335,2,7,4,7,_binary ''),(336,2,7,4,8,_binary ''),(337,2,7,4,9,_binary ''),(338,2,7,4,10,_binary ''),(339,2,7,5,1,_binary ''),(340,2,7,5,2,_binary ''),(341,2,7,5,3,_binary ''),(342,2,7,5,4,_binary ''),(343,2,7,5,5,_binary ''),(344,2,7,5,6,_binary ''),(345,2,7,5,7,_binary ''),(346,2,7,5,8,_binary ''),(347,2,7,5,9,_binary ''),(348,2,7,5,10,_binary ''),(349,1,8,1,1,_binary ''),(350,1,8,1,2,_binary ''),(351,1,8,1,3,_binary ''),(352,1,8,1,4,_binary ''),(353,1,8,1,5,_binary ''),(354,1,8,1,6,_binary ''),(355,1,8,1,7,_binary ''),(356,1,8,1,8,_binary ''),(357,1,8,1,9,_binary ''),(358,1,8,1,10,_binary ''),(359,1,8,1,11,_binary ''),(360,1,8,2,1,_binary ''),(361,1,8,2,2,_binary ''),(362,1,8,2,3,_binary ''),(363,1,8,2,4,_binary ''),(364,1,8,2,5,_binary ''),(365,1,8,2,6,_binary ''),(366,1,8,2,7,_binary ''),(367,1,8,2,8,_binary ''),(368,1,8,2,9,_binary ''),(369,1,8,2,10,_binary ''),(370,1,8,2,11,_binary ''),(371,1,8,3,11,_binary ''),(372,1,8,4,1,_binary ''),(373,1,8,4,2,_binary ''),(374,1,8,4,3,_binary ''),(375,1,8,4,4,_binary ''),(376,1,8,4,5,_binary ''),(377,1,8,4,6,_binary ''),(378,1,8,4,7,_binary ''),(379,1,8,4,8,_binary ''),(380,1,8,4,9,_binary ''),(381,1,8,4,10,_binary ''),(382,1,8,4,11,_binary ''),(383,1,8,5,1,_binary ''),(384,1,8,5,2,_binary ''),(385,1,8,5,3,_binary ''),(386,1,8,5,4,_binary ''),(387,1,8,5,5,_binary ''),(388,1,8,5,6,_binary ''),(389,1,8,5,7,_binary ''),(390,1,8,5,8,_binary ''),(391,1,8,5,9,_binary ''),(392,1,8,5,10,_binary ''),(393,1,8,5,11,_binary '');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin'),(2,'Staff'),(3,'Driver'),(4,'User');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,'Hồ Chí Minh','Gia Lai'),(2,'Gia Lai','Hồ Chí Minh'),(3,'Hồ Chí Minh','Đà Lạt'),(4,'Đà Lạt','Hồ Chí Minh'),(5,'Hồ Chí Minh','Tiền Giang'),(6,'Tiền Giang','Hồ Chí Minh'),(7,'Lâm Đồng','Hồ Chí Minh'),(8,'Hồ Chí Minh','Lâm Đồng');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_detail`
--

LOCK TABLES `ticket_detail` WRITE;
/*!40000 ALTER TABLE `ticket_detail` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (1,6,5,1,'2023-08-20 10:30:00',123000),(2,6,3,1,'2023-08-06 07:05:00',123123123),(3,1,5,1,'2023-08-06 07:06:00',321),(4,3,3,1,'2023-08-06 07:06:00',0),(5,5,3,2,'2023-08-06 08:01:00',200000),(6,6,3,2,'2023-08-24 10:40:00',321000),(7,7,3,2,'2024-05-10 10:30:00',65000),(8,7,3,1,'2024-08-12 10:30:00',123000);
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
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin','Admin',NULL,'https://res.cloudinary.com/dxxwcby8l/image/upload/v1647248652/dkeolz3ghc0eino87iec.jpg',1),(2,'staff','1','Staff','Anh','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647248652/dkeolz3ghc0eino87iec.jpg',2),(3,'driver','1','Tài Xế','Chú','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647248652/dkeolz3ghc0eino87iec.jpg',3),(4,'user001','1','Ba','Nguyễn Văn','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647248652/dkeolz3ghc0eino87iec.jpg',4),(5,'driver2','1','Tài','Nguyễn Anh','https://res.cloudinary.com/dyc5pggxo/image/upload/v1691242179/szri6y0y0xkjqg2rgm00.png',3);
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

-- Dump completed on 2023-08-06 17:23:27

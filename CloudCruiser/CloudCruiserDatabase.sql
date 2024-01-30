CREATE DATABASE  IF NOT EXISTS `cloudcruiserdatabase` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cloudcruiserdatabase`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: localhost    Database: cloudcruiserdatabase
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admin` (
  `AID` varchar(50) NOT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `FirstName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`AID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES ('asinha@cs336.com','asinha','Amogha','Sinha'),('jfernando@cs336.com','jfernando','Jasmean','Fernando'),('rkapse@cs336.com','rkapse','Rashmi','Kapse'),('sshah@cs336.com','sshah','Sanjana','Shah');
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Aircraft`
--

DROP TABLE IF EXISTS `Aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Aircraft` (
  `AircraftID` varchar(5) NOT NULL,
  `AirlineID` varchar(2) NOT NULL,
  `NumOfSeats` int DEFAULT NULL,
  PRIMARY KEY (`AircraftID`,`AirlineID`),
  KEY `AirlineID` (`AirlineID`),
  CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`AirlineID`) REFERENCES `Airline` (`AirlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Aircraft`
--

LOCK TABLES `Aircraft` WRITE;
/*!40000 ALTER TABLE `Aircraft` DISABLE KEYS */;
INSERT INTO `Aircraft` VALUES ('AA100','AA',1),('AA101','AA',1),('B6100','B6',2),('B6101','B6',2),('DL100','DL',3),('DL101','DL',3),('UA100','UA',2),('UA101','UA',2),('WN100','WN',2),('WN101','WN',2);
/*!40000 ALTER TABLE `Aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Airline`
--

DROP TABLE IF EXISTS `Airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airline` (
  `AirlineID` varchar(2) NOT NULL,
  `AirlineName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`AirlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Airline`
--

LOCK TABLES `Airline` WRITE;
/*!40000 ALTER TABLE `Airline` DISABLE KEYS */;
INSERT INTO `Airline` VALUES ('AA','American Airlines'),('B6','JetBlue Airways'),('DL','Delta'),('UA','United Airlines'),('WN','Southwest Airlines');
/*!40000 ALTER TABLE `Airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Airport`
--

DROP TABLE IF EXISTS `Airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airport` (
  `AirportID` varchar(3) NOT NULL,
  `AirportName` varchar(100) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`AirportID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Airport`
--

LOCK TABLES `Airport` WRITE;
/*!40000 ALTER TABLE `Airport` DISABLE KEYS */;
INSERT INTO `Airport` VALUES ('CDG','Charles de Gaulle Airport','Paris','Roissy-en-France','France'),('DEN','Denver International Airport','Denver','Colorado','United States'),('EDI','Edinburgh Airport','Edinburgh','Ingliston','Scotland'),('EWR','Newark Liberty International Airport','Newark','New Jersey','United States'),('GVA','Geneva Airport','Geneva','Meyrin','Switzerland'),('IAH','George Bush Intercontinental Airport','Houston','Texas','United States'),('JFK','John F. Kennedy International Airport','Queens','New York','United States'),('LAX','Los Angeles International Airport','Los Angeles','California','United States'),('LCY','London City Airport','London','Newham','England'),('LIN','Linate Airport','Milan','Lombardy','Italy'),('SFO','San Francisco International Airport','San Franciso','California','United States');
/*!40000 ALTER TABLE `Airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Answers`
--

DROP TABLE IF EXISTS `Answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answers` (
  `AnswerID` int NOT NULL,
  `CustomerID` varchar(50) DEFAULT NULL,
  `RepresentativeID` varchar(50) DEFAULT NULL,
  `AnswerText` text,
  `AnswerDateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`AnswerID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `RepresentativeID` (`RepresentativeID`),
  CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CID`),
  CONSTRAINT `answers_ibfk_2` FOREIGN KEY (`RepresentativeID`) REFERENCES `Representative` (`RID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answers`
--

LOCK TABLES `Answers` WRITE;
/*!40000 ALTER TABLE `Answers` DISABLE KEYS */;
INSERT INTO `Answers` VALUES (3,'madhatter@ru.com','kingofhearts@ru.com','Off with your heads!','2023-12-13 19:00:51'),(11,'alicewonderland@ru.com','redqueen@ru.com','Eat carrots.','2024-01-30 15:55:48');
/*!40000 ALTER TABLE `Answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `CID` varchar(50) NOT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `FirstName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES ('alicewonderland@ru.com','alice','Alice','Wonderland'),('caterpillar@ru.com','cater','Cater','Pillar'),('humptydumpty@ru.com','humpty','Humpty','Dumpty'),('madhatter@ru.com','mad','Mad','Hatter'),('tweedledee@ru.com','tweedledee','Tweedledee','Dum'),('tweedledum@ru.com','tweedledum','Tweedledum','Dee'),('whiterabbit@ru.com','white','White','Rabbit');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Flight`
--

DROP TABLE IF EXISTS `Flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Flight` (
  `FlightNumber` int NOT NULL AUTO_INCREMENT,
  `AirlineID` varchar(2) NOT NULL,
  `AircraftID` varchar(5) DEFAULT NULL,
  `DepartureAirportID` varchar(3) DEFAULT NULL,
  `ArrivalAirportID` varchar(3) DEFAULT NULL,
  `DepartureDateTime` datetime DEFAULT NULL,
  `ArrivalDateTime` datetime DEFAULT NULL,
  `FlightDuration` int DEFAULT NULL,
  `IsLayover` tinyint(1) DEFAULT NULL,
  `IsInternational` tinyint(1) DEFAULT NULL,
  `DaysOfWeek` varchar(7) DEFAULT NULL,
  `TotalPrice` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`FlightNumber`,`AirlineID`),
  KEY `AirlineID` (`AirlineID`),
  KEY `AircraftID` (`AircraftID`),
  KEY `DepartureAirportID` (`DepartureAirportID`),
  KEY `ArrivalAirportID` (`ArrivalAirportID`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`AirlineID`) REFERENCES `Airline` (`AirlineID`),
  CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`AircraftID`) REFERENCES `Aircraft` (`AircraftID`),
  CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`DepartureAirportID`) REFERENCES `Airport` (`AirportID`),
  CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`ArrivalAirportID`) REFERENCES `Airport` (`AirportID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Flight`
--

LOCK TABLES `Flight` WRITE;
/*!40000 ALTER TABLE `Flight` DISABLE KEYS */;
INSERT INTO `Flight` VALUES (13,'AA','AA100','JFK','LAX','2023-12-15 08:00:00','2023-12-15 12:00:00',240,1,0,'1234567',500.00),(14,'AA','AA101','LAX','JFK','2023-12-20 01:15:00','2023-12-20 05:15:00',255,1,0,'1234567',510.00),(15,'B6','B6100','LAX','EWR','2023-12-16 13:00:00','2023-12-16 17:00:00',240,0,0,'2345671',600.00),(16,'DL','DL100','DEN','SFO','2023-12-17 10:30:00','2023-12-17 12:30:00',120,0,0,'3456712',475.00),(17,'UA','UA100','DEN','SFO','2023-12-18 12:45:00','2023-12-18 14:50:00',120,0,0,'3456712',350.00),(18,'DL','DL101','JFK','LIN','2023-11-20 11:15:00','2023-11-21 12:30:00',370,1,1,'136',465.00),(19,'WN','WN100','LAX','EDI','2023-11-22 08:30:00','2023-11-21 11:15:00',485,1,1,'245',575.00);
/*!40000 ALTER TABLE `Flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Layover`
--

DROP TABLE IF EXISTS `Layover`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Layover` (
  `LayoverNumber` int DEFAULT NULL,
  `LayoverAirportID` varchar(3) DEFAULT NULL,
  `DepartureDateTime` datetime DEFAULT NULL,
  `ArrivalDateTime` datetime DEFAULT NULL,
  KEY `LayoverNumber` (`LayoverNumber`),
  KEY `LayoverAirportID` (`LayoverAirportID`),
  CONSTRAINT `layover_ibfk_1` FOREIGN KEY (`LayoverNumber`) REFERENCES `Flight` (`FlightNumber`),
  CONSTRAINT `layover_ibfk_2` FOREIGN KEY (`LayoverAirportID`) REFERENCES `Airport` (`AirportID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Layover`
--

LOCK TABLES `Layover` WRITE;
/*!40000 ALTER TABLE `Layover` DISABLE KEYS */;
INSERT INTO `Layover` VALUES (13,'IAH','2023-12-15 10:00:00','2023-12-15 12:00:00'),(14,'IAH','2023-12-20 02:30:00','2023-12-20 03:30:00'),(18,'GVA','2023-11-20 14:45:00','2023-12-20 17:00:00'),(19,'LCY','2023-11-22 14:45:00','2023-11-22 17:00:00');
/*!40000 ALTER TABLE `Layover` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Questions`
--

DROP TABLE IF EXISTS `Questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Questions` (
  `QuestionID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` varchar(50) DEFAULT NULL,
  `QuestionText` text,
  `QuestionDateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`QuestionID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Questions`
--

LOCK TABLES `Questions` WRITE;
/*!40000 ALTER TABLE `Questions` DISABLE KEYS */;
INSERT INTO `Questions` VALUES (2,'whiterabbit@ru.com','I\'m late, I\'m late, for a very important date!','2023-12-13 18:38:13'),(3,'madhatter@ru.com','Have I gone mad, or am I late?!','2023-12-13 18:39:25'),(10,'caterpillar@ru.com','Who are you? Who am I? Who are we...','2024-01-30 14:10:10'),(11,'alicewonderland@ru.com','How can I get taller?','2024-01-30 15:35:46');
/*!40000 ALTER TABLE `Questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Representative`
--

DROP TABLE IF EXISTS `Representative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Representative` (
  `RID` varchar(50) NOT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `FirstName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Representative`
--

LOCK TABLES `Representative` WRITE;
/*!40000 ALTER TABLE `Representative` DISABLE KEYS */;
INSERT INTO `Representative` VALUES ('cheshirecat@ru.com','cheshire','Cheshire','Cat'),('kingofhearts@ru.com','king','King','Hearts'),('redqueen@ru.com','red','Red','Queen');
/*!40000 ALTER TABLE `Representative` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservation`
--

DROP TABLE IF EXISTS `Reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservation` (
  `ReservationNumber` int NOT NULL AUTO_INCREMENT,
  `CustomerID` varchar(50) NOT NULL,
  `FlightNumber` int DEFAULT NULL,
  `Class` varchar(10) DEFAULT NULL,
  `PurchaseDateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReservationNumber`,`CustomerID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `FlightNumber` (`FlightNumber`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CID`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`FlightNumber`) REFERENCES `Flight` (`FlightNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservation`
--

LOCK TABLES `Reservation` WRITE;
/*!40000 ALTER TABLE `Reservation` DISABLE KEYS */;
INSERT INTO `Reservation` VALUES (41,'whiterabbit@ru.com',16,'First','2023-12-13 18:29:01'),(42,'humptydumpty@ru.com',18,'Economy','2023-12-13 18:32:03'),(43,'caterpillar@ru.com',19,'First','2023-12-13 18:32:35'),(44,'madhatter@ru.com',17,'Economy','2023-12-13 18:36:04'),(45,'tweedledee@ru.com',17,'Economy','2023-12-13 18:36:32'),(54,'caterpillar@ru.com',17,'First','2023-12-13 20:10:10'),(56,'madhatter@ru.com',15,'economy','2024-01-30 14:19:00'),(57,'alicewonderland@ru.com',13,'first','2024-01-30 15:32:16'),(58,'alicewonderland@ru.com',14,'first','2024-01-30 15:32:16'),(59,'alicewonderland@ru.com',15,'business','2024-01-30 15:34:24');
/*!40000 ALTER TABLE `Reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ticket`
--

DROP TABLE IF EXISTS `Ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ticket` (
  `TicketNumber` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `CustomerID` varchar(50) DEFAULT NULL,
  `DepartingFlightNumber` int DEFAULT NULL,
  `ReturningFlightNumber` int DEFAULT NULL,
  `PurchaseDateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`TicketNumber`),
  KEY `CustomerID` (`CustomerID`),
  KEY `DepartingFlightNumber` (`DepartingFlightNumber`),
  KEY `ReturningFlightNumber` (`ReturningFlightNumber`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CID`),
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`DepartingFlightNumber`) REFERENCES `Flight` (`FlightNumber`),
  CONSTRAINT `ticket_ibfk_3` FOREIGN KEY (`ReturningFlightNumber`) REFERENCES `Flight` (`FlightNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ticket`
--

LOCK TABLES `Ticket` WRITE;
/*!40000 ALTER TABLE `Ticket` DISABLE KEYS */;
INSERT INTO `Ticket` VALUES (21,'White','Rabbit','whiterabbit@ru.com',16,NULL,'2023-12-13 18:29:01'),(22,'Humpty','Dumpty','humptydumpty@ru.com',18,NULL,'2023-12-13 18:32:03'),(23,'Cater','Pillar','caterpillar@ru.com',19,NULL,'2023-12-13 18:32:35'),(24,'Mad','Hatter','madhatter@ru.com',17,NULL,'2023-12-13 18:36:04'),(25,'Tweedledee','Dum','tweedledee@ru.com',17,NULL,'2023-12-13 18:36:32'),(26,'Tweedledum','Dee','tweedledum@ru.com',17,NULL,'2023-12-13 18:36:52'),(37,'Mad','Hatter','madhatter@ru.com',15,NULL,'2024-01-30 14:19:00'),(38,'Alice','Wonderland','alicewonderland@ru.com',13,14,'2024-01-30 15:32:16'),(39,'Alice','Wonderland','alicewonderland@ru.com',15,NULL,'2024-01-30 15:33:21');
/*!40000 ALTER TABLE `Ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WaitingList`
--

DROP TABLE IF EXISTS `WaitingList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WaitingList` (
  `WaitingID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` varchar(50) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `FlightNumber` int DEFAULT NULL,
  `Class` varchar(10) DEFAULT NULL,
  `PurchaseDateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`WaitingID`,`CustomerID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `FlightNumber` (`FlightNumber`),
  CONSTRAINT `waitinglist_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CID`),
  CONSTRAINT `waitinglist_ibfk_2` FOREIGN KEY (`FlightNumber`) REFERENCES `Flight` (`FlightNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WaitingList`
--

LOCK TABLES `WaitingList` WRITE;
/*!40000 ALTER TABLE `WaitingList` DISABLE KEYS */;
INSERT INTO `WaitingList` VALUES (11,'tweedledum@ru.com','Tweedledum','Dee',17,'Economy','2024-01-30 15:34:24');
/*!40000 ALTER TABLE `WaitingList` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-30 18:06:12

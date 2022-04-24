-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bank
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `AccountNo` int NOT NULL,
  `AccountType` char(6) NOT NULL,
  `AccountBalance` decimal(5,2) NOT NULL,
  `customer_CustomerID` int NOT NULL,
  `customer_CustomerID1` int NOT NULL,
  `charges_ChargeNo` int NOT NULL,
  PRIMARY KEY (`AccountNo`,`customer_CustomerID1`,`charges_ChargeNo`),
  KEY `fk_account_customer_idx` (`customer_CustomerID1`),
  KEY `fk_account_charges1_idx` (`charges_ChargeNo`),
  CONSTRAINT `fk_account_charges1` FOREIGN KEY (`charges_ChargeNo`) REFERENCES `charges` (`ChargeNo`),
  CONSTRAINT `fk_account_customer` FOREIGN KEY (`customer_CustomerID1`) REFERENCES `customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'CHECK',500.00,1,1,1),(2,'CHECK',500.00,2,2,2);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charges`
--

DROP TABLE IF EXISTS `charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charges` (
  `ChargeNo` int NOT NULL,
  `ChargeAmount` decimal(10,2) NOT NULL,
  `BusinessName` char(20) NOT NULL,
  `BusinessLocation` char(60) NOT NULL,
  `ChargeDate` date NOT NULL,
  `CNP` tinyint(1) NOT NULL,
  `account_AccountNo` int NOT NULL,
  `account_customer_CustomerID` int NOT NULL,
  PRIMARY KEY (`ChargeNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charges`
--

LOCK TABLES `charges` WRITE;
/*!40000 ALTER TABLE `charges` DISABLE KEYS */;
INSERT INTO `charges` VALUES (1,100.00,'GroceryStore','Huntsville','2022-04-14',0,1,1),(2,50.00,'GroceryStore','Huntsville','2022-04-14',0,2,2);
/*!40000 ALTER TABLE `charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `FirstName` char(20) NOT NULL,
  `LastName` char(20) NOT NULL,
  `username` varchar(25) NOT NULL,
  `Password` varchar(20) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `userid` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Frank','Velez','frankv','frank'),(2,'Amanda','Hayden','amandah','amanda'),(3,'Louanne','Mozer','louannem','louanne'),(4,'Jonathan','Ochoa','jonathano','jonathan'),(5,'test1','user1','test1','test1'),(6,'test2','user2','test2','test2');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposits`
--

DROP TABLE IF EXISTS `deposits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deposits` (
  `DepositNo` int NOT NULL,
  `DepositAmount` decimal(5,2) NOT NULL,
  `Origin` char(20) NOT NULL,
  `DepositDate` date NOT NULL,
  `account_AccountNo` int NOT NULL,
  `account_customer_CustomerID` int NOT NULL,
  `account_AccountNo1` int NOT NULL,
  `account_customer_CustomerID1` int NOT NULL,
  `account_charges_ChargeNo` int NOT NULL,
  PRIMARY KEY (`DepositNo`,`account_AccountNo1`,`account_customer_CustomerID1`,`account_charges_ChargeNo`),
  KEY `fk_deposits_account1_idx` (`account_AccountNo1`,`account_customer_CustomerID1`,`account_charges_ChargeNo`),
  CONSTRAINT `fk_deposits_account1` FOREIGN KEY (`account_AccountNo1`, `account_customer_CustomerID1`, `account_charges_ChargeNo`) REFERENCES `account` (`AccountNo`, `customer_CustomerID1`, `charges_ChargeNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposits`
--

LOCK TABLES `deposits` WRITE;
/*!40000 ALTER TABLE `deposits` DISABLE KEYS */;
/*!40000 ALTER TABLE `deposits` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-24 14:24:25

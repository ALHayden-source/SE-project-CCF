-- Table structure for table `account`

DROP TABLE IF EXISTS `bank`.`account`;
CREATE TABLE `bank`.`account` (
  `AccountID` int NOT NULL,
  `AccountType` char(6) NOT NULL,
  `AccountBalance` decimal(6,2) NOT NULL,
  `customer_CustomerID` int NOT NULL,  
  PRIMARY KEY (`AccountID`,`customer_CustomerID`),
  KEY `fk_account_customer_idx` (`customer_CustomerID`),
  CONSTRAINT `fk_account_customer` FOREIGN KEY (`customer_CustomerID`) REFERENCES `customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `charges`
--

CREATE TABLE `bank`.`transactions` (
  `TransactionID` int NOT NULL,
  `TransactionAmount` decimal(10,2) NOT NULL,
  `BusinessName` char(20) NOT NULL,
  `BusinessLocation` char(60) NOT NULL,
  `ChargeDate` date NOT NULL,
  `TransactionType` char(15) NOT NULL,
  `CardholdNotPresent` tinyint(1) NOT NULL,
  `IsSafe` char(1) NOT NULL,
  `account_AccountID` int NOT NULL,
  --`account_customer_CustomerID` int NOT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `fk_transactions_account_idx` (`account_AccountID`),
  CONSTRAINT `fk_transactions_account` FOREIGN KEY (`account_AccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--
-- Table structure for table `customer`
--

-- DROP TABLE IF EXISTS `bank`.`customer`;
CREATE TABLE `bank`.`customer` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `FirstName` char(20) NOT NULL,
  `LastName` char(20) NOT NULL,
  `Username` varchar(25) NOT NULL,
  `Password` varchar(20) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*
INSERT INTO transactions(TransactionID, TransactionAmount, BusinessName, BusinessLocation, TransactionType, `transactions`.`CardholdNotPresent`, IsSafe)
VALUES (3001, 10.00, 'HEB', 'Huntsville, TX', 'Groceries', 0, 1);
*/



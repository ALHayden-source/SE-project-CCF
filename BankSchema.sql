-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bank
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bank
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bank` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bank` ;

-- -----------------------------------------------------
-- Table `bank`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bank`.`customer` (
  `CustID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` CHAR(20) NOT NULL,
  `LastName` CHAR(20) NOT NULL,
  `CustAddress` CHAR(60) NOT NULL UNIQUE,
  PRIMARY KEY (`CustID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bank`.`charges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bank`.`charges` (
  `ChargeNo` INT NOT NULL,
  `ChargeAmount` DECIMAL(10,2) NOT NULL,
  `BusinessName` CHAR(20) NOT NULL,
  `BusinessLoc` CHAR(60) NOT NULL,
  `ChargeDate` DATE NOT NULL,
  `CNP` TINYINT(1) NOT NULL,
  `acc_AccNo` INT NOT NULL,
  `acc_customer_CustID` INT NOT NULL,
  PRIMARY KEY (`ChargeNo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bank`.`acc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bank`.`acc` (
  `AccNo` INT NOT NULL,
  `AccType` CHAR(6) NOT NULL,
  `AccBalance` DECIMAL(5,2) NOT NULL,
  `customer_CustID` INT NOT NULL,
  `customer_CustID1` INT NOT NULL,
  `charges_ChargeNo` INT NOT NULL,
  PRIMARY KEY (`AccNo`, `customer_CustID1`, `charges_ChargeNo`),
  INDEX `fk_acc_customer_idx` (`customer_CustID1` ASC) VISIBLE,
  INDEX `fk_acc_charges1_idx` (`charges_ChargeNo` ASC) VISIBLE,
  CONSTRAINT `fk_acc_customer`
    FOREIGN KEY (`customer_CustID1`)
    REFERENCES `bank`.`customer` (`CustID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acc_charges1`
    FOREIGN KEY (`charges_ChargeNo`)
    REFERENCES `bank`.`charges` (`ChargeNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bank`.`deposits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bank`.`deposits` (
  `DepNo` INT NOT NULL,
  `DepAmount` DECIMAL(5,2) NOT NULL,
  `Origin` CHAR(20) NOT NULL,
  `DepDate` DATE NOT NULL,
  `acc_AccNo` INT NOT NULL,
  `acc_customer_CustID` INT NOT NULL,
  `acc_AccNo1` INT NOT NULL,
  `acc_customer_CustID1` INT NOT NULL,
  `acc_charges_ChargeNo` INT NOT NULL,
  PRIMARY KEY (`DepNo`, `acc_AccNo1`, `acc_customer_CustID1`, `acc_charges_ChargeNo`),
  INDEX `fk_deposits_acc1_idx` (`acc_AccNo1` ASC, `acc_customer_CustID1` ASC, `acc_charges_ChargeNo` ASC) VISIBLE,
  CONSTRAINT `fk_deposits_acc1`
    FOREIGN KEY (`acc_AccNo1` , `acc_customer_CustID1` , `acc_charges_ChargeNo`)
    REFERENCES `bank`.`acc` (`AccNo` , `customer_CustID1` , `charges_ChargeNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

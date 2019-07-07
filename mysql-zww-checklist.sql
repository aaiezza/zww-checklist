-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema zww-checklist
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `TreasureChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TreasureChart` ;

CREATE TABLE IF NOT EXISTS `TreasureChart` (
  `id` INT NOT NULL,
  `chartNumber` INT UNSIGNED NOT NULL,
  `details` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Longitude`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Longitude` ;

CREATE TABLE IF NOT EXISTS `Longitude` (
  `value` CHAR(1) NOT NULL,
  PRIMARY KEY (`value`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Latitude`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Latitude` ;

CREATE TABLE IF NOT EXISTS `Latitude` (
  `value` INT NOT NULL,
  PRIMARY KEY (`value`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Location` ;

CREATE TABLE IF NOT EXISTS `Location` (
  `id` INT NOT NULL,
  `longitude` CHAR(1) NOT NULL,
  `latitude` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `longitudeFK_idx` (`longitude` ASC),
  INDEX `latitudeFK_idx` (`latitude` ASC),
  CONSTRAINT `longitudeFK`
    FOREIGN KEY (`longitude`)
    REFERENCES `Longitude` (`value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `latitudeFK`
    FOREIGN KEY (`latitude`)
    REFERENCES `Latitude` (`value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SunkenChest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SunkenChest` ;

CREATE TABLE IF NOT EXISTS `SunkenChest` (
  `id` INT NOT NULL,
  `expectedLocationId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `sunkenChestLocationFK_idx` (`expectedLocationId` ASC),
  CONSTRAINT `sunkenChestLocationFK`
    FOREIGN KEY (`expectedLocationId`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OtherChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OtherChart` ;

CREATE TABLE IF NOT EXISTS `OtherChart` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SunkenChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SunkenChart` ;

CREATE TABLE IF NOT EXISTS `SunkenChart` (
  `id` INT NOT NULL,
  `chartId` INT NOT NULL,
  `sunkenChestId` INT NOT NULL,
  `otherChartId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sunkenOCchartFK_idx` (`chartId` ASC),
  INDEX `sunkenOCchestFK_idx` (`sunkenChestId` ASC),
  UNIQUE INDEX `sunkenOCotherChartFK_idx` (`otherChartId` ASC),
  CONSTRAINT `sunkenOCchartFK`
    FOREIGN KEY (`chartId`)
    REFERENCES `TreasureChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sunkenOCchestFK`
    FOREIGN KEY (`sunkenChestId`)
    REFERENCES `SunkenChest` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sunkenOCotherChartFK`
    FOREIGN KEY (`otherChartId`)
    REFERENCES `OtherChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TriforceShardChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TriforceShardChart` ;

CREATE TABLE IF NOT EXISTS `TriforceShardChart` (
  `id` INT NOT NULL,
  `chartNumber` INT UNSIGNED NOT NULL,
  `details` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TriforceShard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TriforceShard` ;

CREATE TABLE IF NOT EXISTS `TriforceShard` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SunkenTriforceShard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SunkenTriforceShard` ;

CREATE TABLE IF NOT EXISTS `SunkenTriforceShard` (
  `id` INT NOT NULL,
  `chartId` INT NOT NULL,
  `sunkenChestId` INT NOT NULL,
  `triforceShardId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sunkenTSchartFK_idx` (`chartId` ASC),
  UNIQUE INDEX `sunkenTSchestFK_idx` (`sunkenChestId` ASC),
  UNIQUE INDEX `sunkenTSshardFK_idx` (`triforceShardId` ASC),
  CONSTRAINT `sunkenTSchartFK`
    FOREIGN KEY (`chartId`)
    REFERENCES `TriforceShardChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sunkenTSchestFK`
    FOREIGN KEY (`sunkenChestId`)
    REFERENCES `SunkenChest` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sunkenTSshardFK`
    FOREIGN KEY (`triforceShardId`)
    REFERENCES `TriforceShard` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HeartPiece`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HeartPiece` ;

CREATE TABLE IF NOT EXISTS `HeartPiece` (
  `id` INT NOT NULL,
  `task` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SunkenHeartPiece`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SunkenHeartPiece` ;

CREATE TABLE IF NOT EXISTS `SunkenHeartPiece` (
  `id` INT NOT NULL,
  `chartId` INT NOT NULL,
  `sunkenChestId` INT NOT NULL,
  `heartPieceId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sunkenHeartPieceChartFK_idx` (`chartId` ASC),
  UNIQUE INDEX `sunkenHeartPieceChestFK_idx` (`sunkenChestId` ASC),
  UNIQUE INDEX `sunkenHeartPieceHPFK_idx` (`heartPieceId` ASC),
  CONSTRAINT `sunkenHPchartFK`
    FOREIGN KEY (`chartId`)
    REFERENCES `TreasureChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sunkenHPchestFK`
    FOREIGN KEY (`sunkenChestId`)
    REFERENCES `SunkenChest` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sunkenHPheartPieceFK`
    FOREIGN KEY (`heartPieceId`)
    REFERENCES `HeartPiece` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rupee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Rupee` ;

CREATE TABLE IF NOT EXISTS `Rupee` (
  `id` INT NOT NULL,
  `value` INT UNSIGNED NOT NULL,
  `color` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `color_UNIQUE` (`color` ASC),
  UNIQUE INDEX `value_UNIQUE` (`value` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SunkenRupee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SunkenRupee` ;

CREATE TABLE IF NOT EXISTS `SunkenRupee` (
  `id` INT NOT NULL,
  `chartId` INT NOT NULL,
  `sunkenChestId` INT NOT NULL,
  `rupeeId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sunkenRchartFK_idx` (`chartId` ASC),
  UNIQUE INDEX `sunkenRchestFK_idx` (`sunkenChestId` ASC),
  INDEX `sunkenRrupeeFK_idx` (`rupeeId` ASC),
  CONSTRAINT `sunkenRchartFK`
    FOREIGN KEY (`chartId`)
    REFERENCES `TreasureChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sunkenRchestFK`
    FOREIGN KEY (`sunkenChestId`)
    REFERENCES `SunkenChest` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sunkenRrupeeFK`
    FOREIGN KEY (`rupeeId`)
    REFERENCES `Rupee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Submarine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Submarine` ;

CREATE TABLE IF NOT EXISTS `Submarine` (
  `id` INT NOT NULL,
  `expectedLocationId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `sunkenChestLocationFK_idx` (`expectedLocationId` ASC),
  CONSTRAINT `submarineLocationFK0`
    FOREIGN KEY (`expectedLocationId`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HeartContainer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HeartContainer` ;

CREATE TABLE IF NOT EXISTS `HeartContainer` (
  `id` INT NOT NULL,
  `details` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spoil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Spoil` ;

CREATE TABLE IF NOT EXISTS `Spoil` (
  `id` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecretCave`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecretCave` ;

CREATE TABLE IF NOT EXISTS `SecretCave` (
  `id` INT NOT NULL,
  `locationId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `secretCaveLocationFK_idx` (`locationId` ASC),
  CONSTRAINT `secretCaveLocationFK`
    FOREIGN KEY (`locationId`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Island`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Island` ;

CREATE TABLE IF NOT EXISTS `Island` (
  `id` INT NOT NULL,
  `locationId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `islandLocationFK_idx` (`locationId` ASC),
  CONSTRAINT `islandLocationFK`
    FOREIGN KEY (`locationId`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BigOcto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BigOcto` ;

CREATE TABLE IF NOT EXISTS `BigOcto` (
  `id` INT NOT NULL,
  `expectedLocationId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `bigOctoLocationFK_idx` (`expectedLocationId` ASC),
  CONSTRAINT `bigOctoLocationFK`
    FOREIGN KEY (`expectedLocationId`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiniGame`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MiniGame` ;

CREATE TABLE IF NOT EXISTS `MiniGame` (
  `id` INT NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecretCaveHeartPiece`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecretCaveHeartPiece` ;

CREATE TABLE IF NOT EXISTS `SecretCaveHeartPiece` (
  `id` INT NOT NULL,
  `secretCaveId` INT NOT NULL,
  `heartPieceId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `secretCaveHPcaveFK_idx` (`secretCaveId` ASC),
  UNIQUE INDEX `secretCaveHPheartPieceFK_idx` (`heartPieceId` ASC),
  CONSTRAINT `secretCaveHPcaveFK`
    FOREIGN KEY (`secretCaveId`)
    REFERENCES `SecretCave` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `secretCaveHPheartPieceFK`
    FOREIGN KEY (`heartPieceId`)
    REFERENCES `HeartPiece` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Item` ;

CREATE TABLE IF NOT EXISTS `Item` (
  `id` INT NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `details` VARCHAR(45) NOT NULL,
  `required` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecretCaveItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecretCaveItem` ;

CREATE TABLE IF NOT EXISTS `SecretCaveItem` (
  `id` INT NOT NULL,
  `secretCaveId` INT NOT NULL,
  `itemId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `secretCaveIcaveFK_idx` (`secretCaveId` ASC),
  UNIQUE INDEX `secretCaveIitemFK_idx` (`itemId` ASC),
  CONSTRAINT `secretCaveIcaveFK`
    FOREIGN KEY (`secretCaveId`)
    REFERENCES `SecretCave` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `secretCaveIitemFK`
    FOREIGN KEY (`itemId`)
    REFERENCES `Item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecretCaveRupee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecretCaveRupee` ;

CREATE TABLE IF NOT EXISTS `SecretCaveRupee` (
  `id` INT NOT NULL,
  `secretCaveId` INT NOT NULL,
  `rupeeId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `secretCaveRcaveFK_idx` (`secretCaveId` ASC),
  INDEX `secretCaveRrupee_idx` (`rupeeId` ASC),
  CONSTRAINT `secretCaveRcaveFK`
    FOREIGN KEY (`secretCaveId`)
    REFERENCES `SecretCave` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `secretCaveRrupeeFK`
    FOREIGN KEY (`rupeeId`)
    REFERENCES `Rupee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecretCaveSpoil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecretCaveSpoil` ;

CREATE TABLE IF NOT EXISTS `SecretCaveSpoil` (
  `id` INT NOT NULL,
  `secretCaveId` INT NOT NULL,
  `spoilId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `secretCaveScaveFK_idx` (`secretCaveId` ASC),
  INDEX `secretCaveSspoilFK_idx` (`spoilId` ASC),
  CONSTRAINT `secretCaveScaveFK`
    FOREIGN KEY (`secretCaveId`)
    REFERENCES `SecretCave` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `secretCaveSspoilFK`
    FOREIGN KEY (`spoilId`)
    REFERENCES `Spoil` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecretCaveTreasureChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecretCaveTreasureChart` ;

CREATE TABLE IF NOT EXISTS `SecretCaveTreasureChart` (
  `id` INT NOT NULL,
  `secretCaveId` INT NOT NULL,
  `treasureChartId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `secretCaveTCchartFK_idx` (`treasureChartId` ASC),
  UNIQUE INDEX `secretCaveTCcaveFK_idx` (`secretCaveId` ASC),
  CONSTRAINT `secretCaveTCcaveFK`
    FOREIGN KEY (`secretCaveId`)
    REFERENCES `SecretCave` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `secretCaveTCchartFK`
    FOREIGN KEY (`treasureChartId`)
    REFERENCES `TreasureChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecretCaveTriforceChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecretCaveTriforceChart` ;

CREATE TABLE IF NOT EXISTS `SecretCaveTriforceChart` (
  `id` INT NOT NULL,
  `secretCaveId` INT NOT NULL,
  `triforceChartId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `secretCaveTRcaveFK_idx` (`secretCaveId` ASC),
  UNIQUE INDEX `secretCaveTRchartFK_idx` (`triforceChartId` ASC),
  CONSTRAINT `secretCaveTRcaveFK`
    FOREIGN KEY (`secretCaveId`)
    REFERENCES `SecretCave` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `secretCaveTRchartFK`
    FOREIGN KEY (`triforceChartId`)
    REFERENCES `TriforceShardChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecretCaveOtherChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecretCaveOtherChart` ;

CREATE TABLE IF NOT EXISTS `SecretCaveOtherChart` (
  `id` INT NOT NULL,
  `secretCaveId` INT NOT NULL,
  `otherChartId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `secretCaveOCcaveFK_idx` (`secretCaveId` ASC),
  UNIQUE INDEX `secretCaveOCchartFK_idx` (`otherChartId` ASC),
  CONSTRAINT `secretCaveOCcaveFK`
    FOREIGN KEY (`secretCaveId`)
    REFERENCES `SecretCave` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `secretCaveOCotherChartFK`
    FOREIGN KEY (`otherChartId`)
    REFERENCES `OtherChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiniGameLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MiniGameLocation` ;

CREATE TABLE IF NOT EXISTS `MiniGameLocation` (
  `id` INT NOT NULL,
  `miniGameId` INT NOT NULL,
  `locationId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `miniGameLminiGameFK_idx` (`miniGameId` ASC),
  INDEX `miniGameLlocationFK_idx` (`locationId` ASC),
  UNIQUE INDEX `miniGameLocation_UNIQUE` (`miniGameId` ASC, `locationId` ASC),
  CONSTRAINT `miniGameLminiGameFK`
    FOREIGN KEY (`miniGameId`)
    REFERENCES `MiniGame` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `miniGameLlocationFK`
    FOREIGN KEY (`locationId`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiniGameTreasureChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MiniGameTreasureChart` ;

CREATE TABLE IF NOT EXISTS `MiniGameTreasureChart` (
  `id` INT NOT NULL,
  `miniGameId` INT NOT NULL,
  `treasureChartId` INT NOT NULL,
  `attempt` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `miniGameTCminiGameFK_idx` (`miniGameId` ASC),
  UNIQUE INDEX `miniGameTCchartFK_idx` (`treasureChartId` ASC),
  UNIQUE INDEX `miniGameTCattempt_UNIQUE` (`miniGameId` ASC, `attempt` ASC),
  CONSTRAINT `miniGameTCminiGameFK`
    FOREIGN KEY (`miniGameId`)
    REFERENCES `MiniGame` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `miniGameTCchartFK`
    FOREIGN KEY (`treasureChartId`)
    REFERENCES `TreasureChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiniGameHeartPiece`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MiniGameHeartPiece` ;

CREATE TABLE IF NOT EXISTS `MiniGameHeartPiece` (
  `id` INT NOT NULL,
  `miniGameId` INT NOT NULL,
  `heartPieceId` INT NOT NULL,
  `attempt` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `miniGameHPminiGameFK_idx` (`miniGameId` ASC),
  UNIQUE INDEX `miniGameHPheartPieceFK_idx` (`heartPieceId` ASC),
  UNIQUE INDEX `miniGameHPattempt_UNIQUE` (`miniGameId` ASC, `attempt` ASC),
  CONSTRAINT `miniGameHPminiGameFK`
    FOREIGN KEY (`miniGameId`)
    REFERENCES `MiniGame` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `miniGameHPheartPieceFK`
    FOREIGN KEY (`heartPieceId`)
    REFERENCES `HeartPiece` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiniGameRupee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MiniGameRupee` ;

CREATE TABLE IF NOT EXISTS `MiniGameRupee` (
  `id` INT NOT NULL,
  `miniGameId` INT NOT NULL,
  `rupeeId` INT NOT NULL,
  `attempt` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `miniGameRminiGameFK_idx` (`miniGameId` ASC),
  INDEX `miniGameRrupeeFK_idx` (`rupeeId` ASC),
  UNIQUE INDEX `miniGameRattempt_UNIQUE` (`miniGameId` ASC, `attempt` ASC),
  CONSTRAINT `miniGameRminiGameFK`
    FOREIGN KEY (`miniGameId`)
    REFERENCES `MiniGame` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `miniGameRrupeeFK`
    FOREIGN KEY (`rupeeId`)
    REFERENCES `Rupee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiniGameSpoil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MiniGameSpoil` ;

CREATE TABLE IF NOT EXISTS `MiniGameSpoil` (
  `id` INT NOT NULL,
  `miniGameId` INT NOT NULL,
  `spoilId` INT NOT NULL,
  `attempt` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `miniGameSminiGameFK_idx` (`miniGameId` ASC),
  INDEX `miniGameSspoilFK_idx` (`spoilId` ASC),
  UNIQUE INDEX `miniGameSattempt_UNIQUE` (`miniGameId` ASC, `attempt` ASC),
  CONSTRAINT `miniGameSminiGameFK`
    FOREIGN KEY (`miniGameId`)
    REFERENCES `MiniGame` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `miniGameSspoilFK`
    FOREIGN KEY (`spoilId`)
    REFERENCES `Spoil` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SubmarineTreasureChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SubmarineTreasureChart` ;

CREATE TABLE IF NOT EXISTS `SubmarineTreasureChart` (
  `id` INT NOT NULL,
  `submarineId` INT NOT NULL,
  `treasureChartId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `submarineTCsubmarineFK_idx` (`submarineId` ASC),
  UNIQUE INDEX `submarineTCchartFK_idx` (`treasureChartId` ASC),
  CONSTRAINT `submarineTCsubmarineFK`
    FOREIGN KEY (`submarineId`)
    REFERENCES `Submarine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `submarineTCchartFK`
    FOREIGN KEY (`treasureChartId`)
    REFERENCES `TreasureChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SubmarineHeartPiece`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SubmarineHeartPiece` ;

CREATE TABLE IF NOT EXISTS `SubmarineHeartPiece` (
  `id` INT NOT NULL,
  `submarineId` INT NOT NULL,
  `heartPieceId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `submarineHPsubmarineFK_idx` (`submarineId` ASC),
  UNIQUE INDEX `submarineHPheartPieceFK_idx` (`heartPieceId` ASC),
  CONSTRAINT `submarineHPsubmarineFK`
    FOREIGN KEY (`submarineId`)
    REFERENCES `Submarine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `submarineHPheartPieceFK`
    FOREIGN KEY (`heartPieceId`)
    REFERENCES `HeartPiece` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SubmarineItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SubmarineItem` ;

CREATE TABLE IF NOT EXISTS `SubmarineItem` (
  `id` INT NOT NULL,
  `submarineId` INT NOT NULL,
  `itemId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `submarineIsubmarineFK_idx` (`submarineId` ASC),
  UNIQUE INDEX `submarineIitemFK_idx` (`itemId` ASC),
  CONSTRAINT `submarineIsubmarineFK`
    FOREIGN KEY (`submarineId`)
    REFERENCES `Submarine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `submarineIitemFK`
    FOREIGN KEY (`itemId`)
    REFERENCES `Item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SubmarineOtherChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SubmarineOtherChart` ;

CREATE TABLE IF NOT EXISTS `SubmarineOtherChart` (
  `id` INT NOT NULL,
  `submarineId` INT NOT NULL,
  `otherChartId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `submarineOCsubmarineFK_idx` (`submarineId` ASC),
  UNIQUE INDEX `submarineOCotherChartFK_idx` (`otherChartId` ASC),
  CONSTRAINT `submarineOCsubmarineFK`
    FOREIGN KEY (`submarineId`)
    REFERENCES `Submarine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `submarineOCotherChartFK`
    FOREIGN KEY (`otherChartId`)
    REFERENCES `OtherChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BigOctoHeartPiece`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BigOctoHeartPiece` ;

CREATE TABLE IF NOT EXISTS `BigOctoHeartPiece` (
  `id` INT NOT NULL,
  `bigOctoId` INT NOT NULL,
  `heartPieceId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `bigOctoHPbigOctoFK_idx` (`bigOctoId` ASC),
  UNIQUE INDEX `bigOctoHPheartPieceFK_idx` (`heartPieceId` ASC),
  CONSTRAINT `bigOctoHPbigOctoFK`
    FOREIGN KEY (`bigOctoId`)
    REFERENCES `BigOcto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bigOctoHPheartPieceFK`
    FOREIGN KEY (`heartPieceId`)
    REFERENCES `HeartPiece` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GreatFairy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GreatFairy` ;

CREATE TABLE IF NOT EXISTS `GreatFairy` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BigOctoGreatFairy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BigOctoGreatFairy` ;

CREATE TABLE IF NOT EXISTS `BigOctoGreatFairy` (
  `id` INT NOT NULL,
  `bigOctoId` INT NOT NULL,
  `greatFairyId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `bigOctoGFbigOctoFK_idx` (`bigOctoId` ASC),
  UNIQUE INDEX `bigOctoGFgreatFairyFK_idx` (`greatFairyId` ASC),
  CONSTRAINT `bigOctoGFbigOctoFK`
    FOREIGN KEY (`bigOctoId`)
    REFERENCES `BigOcto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bigOctoGFgreatFairyFK`
    FOREIGN KEY (`greatFairyId`)
    REFERENCES `GreatFairy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BigOctoRupee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BigOctoRupee` ;

CREATE TABLE IF NOT EXISTS `BigOctoRupee` (
  `id` INT NOT NULL,
  `bigOctoId` INT NOT NULL,
  `rupeeId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `bigOctoHPbigOctoFK_idx` (`bigOctoId` ASC),
  INDEX `bigOctoRrupee_idx` (`rupeeId` ASC),
  CONSTRAINT `bigOctoRbigOctoFK`
    FOREIGN KEY (`bigOctoId`)
    REFERENCES `BigOcto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bigOctoRrupee`
    FOREIGN KEY (`rupeeId`)
    REFERENCES `Rupee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GreatFairyUpgrade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GreatFairyUpgrade` ;

CREATE TABLE IF NOT EXISTS `GreatFairyUpgrade` (
  `id` INT NOT NULL,
  `name` INT NOT NULL,
  `greatFairyId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `greatFairyUpgrade_GreatFairyFK_idx` (`greatFairyId` ASC),
  CONSTRAINT `greatFairyUpgrade_GreatFairyFK`
    FOREIGN KEY (`greatFairyId`)
    REFERENCES `GreatFairy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GreatFairyAccessRequirementItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GreatFairyAccessRequirementItem` ;

CREATE TABLE IF NOT EXISTS `GreatFairyAccessRequirementItem` (
  `id` INT NOT NULL,
  `greatFairyId` INT NOT NULL,
  `itemId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `greatFariyARIgreatFairyFK_idx` (`greatFairyId` ASC),
  INDEX `greatFairyARIitemFK_idx` (`itemId` ASC),
  CONSTRAINT `greatFariyARIgreatFairyFK`
    FOREIGN KEY (`greatFairyId`)
    REFERENCES `GreatFairy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `greatFairyARIitemFK`
    FOREIGN KEY (`itemId`)
    REFERENCES `Item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WindWakerSong`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WindWakerSong` ;

CREATE TABLE IF NOT EXISTS `WindWakerSong` (
  `id` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GreatFairyAccessRequirementWindWakerSong`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GreatFairyAccessRequirementWindWakerSong` ;

CREATE TABLE IF NOT EXISTS `GreatFairyAccessRequirementWindWakerSong` (
  `id` INT NOT NULL,
  `greatFiaryId` INT NOT NULL,
  `windWakerSongId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `greatFairyARWWSgreatFairyFK_idx` (`greatFiaryId` ASC),
  INDEX `greatFairyARWWSwwsFK_idx` (`windWakerSongId` ASC),
  CONSTRAINT `greatFairyARWWSgreatFairyFK`
    FOREIGN KEY (`greatFiaryId`)
    REFERENCES `GreatFairy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `greatFairyARWWSwwsFK`
    FOREIGN KEY (`windWakerSongId`)
    REFERENCES `WindWakerSong` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Platform` ;

CREATE TABLE IF NOT EXISTS `Platform` (
  `id` INT NOT NULL,
  `locationId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `platformLocationFK_idx` (`locationId` ASC),
  CONSTRAINT `platformLocationFK`
    FOREIGN KEY (`locationId`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PlatformSpoil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PlatformSpoil` ;

CREATE TABLE IF NOT EXISTS `PlatformSpoil` (
  `id` INT NOT NULL,
  `platformId` INT NOT NULL,
  `spoilId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `platformSplatformFK_idx` (`platformId` ASC),
  INDEX `platformSspoilFK_idx` (`spoilId` ASC),
  CONSTRAINT `platformSplatformFK`
    FOREIGN KEY (`platformId`)
    REFERENCES `Platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `platformSspoilFK`
    FOREIGN KEY (`spoilId`)
    REFERENCES `Spoil` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PlatformTreasureChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PlatformTreasureChart` ;

CREATE TABLE IF NOT EXISTS `PlatformTreasureChart` (
  `id` INT NOT NULL,
  `platformId` INT NOT NULL,
  `treasureChartId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `platformTCplatformFK_idx` (`platformId` ASC),
  UNIQUE INDEX `platformTCtreasureChartFK_idx` (`treasureChartId` ASC),
  CONSTRAINT `platformTCplatformFK`
    FOREIGN KEY (`platformId`)
    REFERENCES `Platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `platformTCtreasureChartFK`
    FOREIGN KEY (`treasureChartId`)
    REFERENCES `TreasureChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PlatformHeartPiece`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PlatformHeartPiece` ;

CREATE TABLE IF NOT EXISTS `PlatformHeartPiece` (
  `id` INT NOT NULL,
  `platformId` INT NOT NULL,
  `heartPieceId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `platformHPplatformFK_idx` (`platformId` ASC),
  UNIQUE INDEX `platformHPhpFK_idx` (`heartPieceId` ASC),
  CONSTRAINT `platformHPplatformFK`
    FOREIGN KEY (`platformId`)
    REFERENCES `Platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `platformHPhpFK`
    FOREIGN KEY (`heartPieceId`)
    REFERENCES `HeartPiece` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PlatformRupee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PlatformRupee` ;

CREATE TABLE IF NOT EXISTS `PlatformRupee` (
  `id` INT NOT NULL,
  `platformId` INT NOT NULL,
  `rupeeId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `platformRplatformFK_idx` (`platformId` ASC),
  INDEX `platofrmRrupeeFK_idx` (`rupeeId` ASC),
  CONSTRAINT `platformRplatformFK`
    FOREIGN KEY (`platformId`)
    REFERENCES `Platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `platofrmRrupeeFK`
    FOREIGN KEY (`rupeeId`)
    REFERENCES `Rupee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BlueChuChu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BlueChuChu` ;

CREATE TABLE IF NOT EXISTS `BlueChuChu` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BlueChuChuIsland`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BlueChuChuIsland` ;

CREATE TABLE IF NOT EXISTS `BlueChuChuIsland` (
  `id` INT NOT NULL,
  `blueChuChuId` INT NOT NULL,
  `islandId` INT NOT NULL,
  `details` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `blueChuChuIblueChuChuFK_idx` (`blueChuChuId` ASC),
  INDEX `blueChuChuIislandFK_idx` (`islandId` ASC),
  CONSTRAINT `blueChuChuIblueChuChuFK`
    FOREIGN KEY (`blueChuChuId`)
    REFERENCES `BlueChuChu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `blueChuChuIislandFK`
    FOREIGN KEY (`islandId`)
    REFERENCES `Island` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QuestTask`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QuestTask` ;

CREATE TABLE IF NOT EXISTS `QuestTask` (
  `id` INT NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QuestTaskItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QuestTaskItem` ;

CREATE TABLE IF NOT EXISTS `QuestTaskItem` (
  `id` INT NOT NULL,
  `questTaskId` INT NOT NULL,
  `itemId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `questTaskIqtFK_idx` (`questTaskId` ASC),
  UNIQUE INDEX `questTaskIitemFK_idx` (`itemId` ASC),
  CONSTRAINT `questTaskIqtFK`
    FOREIGN KEY (`questTaskId`)
    REFERENCES `QuestTask` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `questTaskIitemFK`
    FOREIGN KEY (`itemId`)
    REFERENCES `Item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QuestTaskWindWakerSong`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QuestTaskWindWakerSong` ;

CREATE TABLE IF NOT EXISTS `QuestTaskWindWakerSong` (
  `id` INT NOT NULL,
  `questTaskId` INT NOT NULL,
  `windWakerSongId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `questTaskWWSmqtFK_idx` (`questTaskId` ASC),
  UNIQUE INDEX `questTaskWWSwwsFK_idx` (`windWakerSongId` ASC),
  CONSTRAINT `questTaskWWSmqtFK`
    FOREIGN KEY (`questTaskId`)
    REFERENCES `QuestTask` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `questTaskWWSwwsFK`
    FOREIGN KEY (`windWakerSongId`)
    REFERENCES `WindWakerSong` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QuestTaskGreatFairyUpgrade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QuestTaskGreatFairyUpgrade` ;

CREATE TABLE IF NOT EXISTS `QuestTaskGreatFairyUpgrade` (
  `id` INT NOT NULL,
  `questTaskId` INT NOT NULL,
  `greatFairyUpgradeId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `questTaskGFmqtFK_idx` (`questTaskId` ASC),
  UNIQUE INDEX `questTaskGFgfuFK_idx` (`greatFairyUpgradeId` ASC),
  CONSTRAINT `questTaskGFmqtFK`
    FOREIGN KEY (`questTaskId`)
    REFERENCES `QuestTask` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `questTaskGFgfuFK`
    FOREIGN KEY (`greatFairyUpgradeId`)
    REFERENCES `GreatFairyUpgrade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QuestTaskHeartContainer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QuestTaskHeartContainer` ;

CREATE TABLE IF NOT EXISTS `QuestTaskHeartContainer` (
  `id` INT NOT NULL,
  `questTaskId` INT NOT NULL,
  `heartContainerId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `questTaskHCmqtFK_idx` (`questTaskId` ASC),
  UNIQUE INDEX `questTaskHChcFK_idx` (`heartContainerId` ASC),
  CONSTRAINT `questTaskHCmqtFK`
    FOREIGN KEY (`questTaskId`)
    REFERENCES `QuestTask` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `questTaskHChcFK`
    FOREIGN KEY (`heartContainerId`)
    REFERENCES `HeartContainer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QuestTaskLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QuestTaskLocation` ;

CREATE TABLE IF NOT EXISTS `QuestTaskLocation` (
  `id` INT NOT NULL,
  `questTaskId` INT NOT NULL,
  `locationId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `questTaskLmqtFK_idx` (`questTaskId` ASC),
  INDEX `questTaskLlocationFK_idx` (`locationId` ASC),
  CONSTRAINT `questTaskLmqtFK`
    FOREIGN KEY (`questTaskId`)
    REFERENCES `QuestTask` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `questTaskLlocationFK`
    FOREIGN KEY (`locationId`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QuestTaskTriforceChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QuestTaskTriforceChart` ;

CREATE TABLE IF NOT EXISTS `QuestTaskTriforceChart` (
  `id` INT NOT NULL,
  `questTaskId` INT NOT NULL,
  `triforceChartId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `questTaskTRqtFK_idx` (`questTaskId` ASC),
  UNIQUE INDEX `questTaskTRtrFK_idx` (`triforceChartId` ASC),
  CONSTRAINT `questTaskTRqtFK`
    FOREIGN KEY (`questTaskId`)
    REFERENCES `QuestTask` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `questTaskTRtrFK`
    FOREIGN KEY (`triforceChartId`)
    REFERENCES `TriforceShardChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QuestTaskTreasureChart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QuestTaskTreasureChart` ;

CREATE TABLE IF NOT EXISTS `QuestTaskTreasureChart` (
  `id` INT NOT NULL,
  `questTaskId` INT NOT NULL,
  `treasureChartId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `questTaskTCqtFK_idx` (`questTaskId` ASC),
  UNIQUE INDEX `questTaskTCtcFK_idx` (`treasureChartId` ASC),
  CONSTRAINT `questTaskTCqtFK`
    FOREIGN KEY (`questTaskId`)
    REFERENCES `QuestTask` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `questTaskTCtcFK`
    FOREIGN KEY (`treasureChartId`)
    REFERENCES `TreasureChart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QuestTaskRupee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QuestTaskRupee` ;

CREATE TABLE IF NOT EXISTS `QuestTaskRupee` (
  `id` INT NOT NULL,
  `questTaskId` INT NOT NULL,
  `rupeeId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `questTaskRqtFK_idx` (`questTaskId` ASC),
  INDEX `questTaskRrupeeFK_idx` (`rupeeId` ASC),
  CONSTRAINT `questTaskRqtFK`
    FOREIGN KEY (`questTaskId`)
    REFERENCES `QuestTask` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `questTaskRrupeeFK`
    FOREIGN KEY (`rupeeId`)
    REFERENCES `Rupee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `QuestTaskHeartPiece`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `QuestTaskHeartPiece` ;

CREATE TABLE IF NOT EXISTS `QuestTaskHeartPiece` (
  `id` INT NOT NULL,
  `questTaskId` INT NOT NULL,
  `heartPieceId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `questTaskHPqtFK_idx` (`questTaskId` ASC),
  UNIQUE INDEX `questTaskHPhpFK_idx` (`heartPieceId` ASC),
  CONSTRAINT `questTaskHPqtFK`
    FOREIGN KEY (`questTaskId`)
    REFERENCES `QuestTask` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `questTaskHPhpFK`
    FOREIGN KEY (`heartPieceId`)
    REFERENCES `HeartPiece` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TingleQuest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TingleQuest` ;

CREATE TABLE IF NOT EXISTS `TingleQuest` (
  `id` INT NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `locationId` INT NOT NULL,
  `reward` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `tingleQuestLocationFK_idx` (`locationId` ASC),
  CONSTRAINT `tingleQuestLocationFK`
    FOREIGN KEY (`locationId`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NintendoGalleryTheme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NintendoGalleryTheme` ;

CREATE TABLE IF NOT EXISTS `NintendoGalleryTheme` (
  `id` INT NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NintendoGallerySubject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NintendoGallerySubject` ;

CREATE TABLE IF NOT EXISTS `NintendoGallerySubject` (
  `id` INT NOT NULL,
  `name` VARCHAR(40) NOT NULL,
  `themeId` INT NOT NULL,
  `addtionalFigures` TINYINT NOT NULL DEFAULT 0,
  `limitedOpportunity` TINYINT NOT NULL DEFAULT 0,
  `legendary` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `ninGalThemeFK_idx` (`themeId` ASC),
  CONSTRAINT `ninGalThemeFK`
    FOREIGN KEY (`themeId`)
    REFERENCES `NintendoGalleryTheme` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PictographLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PictographLocation` ;

CREATE TABLE IF NOT EXISTS `PictographLocation` (
  `id` INT NOT NULL,
  `subjectId` INT NOT NULL,
  `locationId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pictographLocationNGFK_idx` (`subjectId` ASC),
  INDEX `pictographLocationLocFK_idx` (`locationId` ASC),
  CONSTRAINT `pictographLocationNGFK`
    FOREIGN KEY (`subjectId`)
    REFERENCES `NintendoGallerySubject` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pictographLocationLocFK`
    FOREIGN KEY (`locationId`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Placeholder table for view `SunkenThings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SunkenThings` (`'No'` INT, `'X|'` INT, `'X-'` INT, `'Location'` INT, `'Treasure'` INT, `Chart` INT);

-- -----------------------------------------------------
-- Placeholder table for view `IslandTasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IslandTasks` (`id` INT, `longitude` INT, `latitude` INT);

-- -----------------------------------------------------
-- Placeholder table for view `HeartContainerLocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HeartContainerLocation` (`'No'` INT, `'X|'` INT, `'X-'` INT, `'Location'` INT, `'Details'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `HeartPieceLocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HeartPieceLocation` (`'No'` INT, `'X|'` INT, `'X-'` INT, `'Location'` INT, `'Task'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `view1` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ItemLocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ItemLocation` (`'No'` INT, `'Name'` INT, `'X|'` INT, `'X-'` INT, `'Location'` INT, `'Details'` INT, `Required` INT);

-- -----------------------------------------------------
-- Placeholder table for view `RequiredItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RequiredItem` (`'No'` INT, `'Name'` INT, `'X|'` INT, `'X-'` INT, `'Location'` INT, `'Details'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `OptionalItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OptionalItem` (`'No'` INT, `'Name'` INT, `'X|'` INT, `'X-'` INT, `'Location'` INT, `'Details'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `TreasureChartLocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TreasureChartLocation` (`'No'` INT, `'X|'` INT, `'X-'` INT, `'Location'` INT, `'Details'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `BlueChuChuLocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BlueChuChuLocation` (`'No'` INT, `'X|'` INT, `'X-'` INT, `'Location'` INT, `'Details'` INT);

-- -----------------------------------------------------
-- View `SunkenThings`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `SunkenThings` ;
DROP TABLE IF EXISTS `SunkenThings`;
CREATE  OR REPLACE VIEW `SunkenThings` AS
SELECT
    `sunk`.`sunkenChestId` AS 'No',
    `sunk`.`longitude` AS 'X|',
    `sunk`.`latitude` AS 'X-',
    `sunk`.`islandName` AS 'Location',
    `sunk`.`treasure` AS 'Treasure',
    `sunk`.`chartNumber` AS `Chart`
FROM (
SELECT
    `SunkenChest`.`id` AS 'sunkenChestId',
    `Location`.`longitude`,
    `Location`.`latitude`,
    `Island`.`name` AS 'islandName',
    CONCAT(`Rupee`.`value`, " Rupee(s)") AS 'treasure',
    `TreasureChart`.`chartNumber`
FROM `SunkenRupee`

LEFT JOIN `SunkenChest` ON
    `SunkenRupee`.`sunkenChestId` = `SunkenChest`.`id`
LEFT JOIN `Location` ON
    `SunkenChest`.`expectedLocationId` = `Location`.`id`
LEFT JOIN `Island` ON
    `Location`.`id` = `Island`.`locationId`

LEFT JOIN `TreasureChart` ON
    `SunkenRupee`.`chartId` = `TreasureChart`.`id`

LEFT JOIN `Rupee` ON
    `SunkenRupee`.`rupeeId` = `Rupee`.`id`
) AS `sunk`
ORDER BY `sunk`.`longitude`, `sunk`.`latitude`
;

-- -----------------------------------------------------
-- View `IslandTasks`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `IslandTasks` ;
DROP TABLE IF EXISTS `IslandTasks`;
CREATE  OR REPLACE VIEW `IslandTasks` AS
SELECT * FROM `Location`;

-- -----------------------------------------------------
-- View `HeartContainerLocation`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `HeartContainerLocation` ;
DROP TABLE IF EXISTS `HeartContainerLocation`;
CREATE  OR REPLACE VIEW `HeartContainerLocation` AS
SELECT
    `HeartContainer`.`id` AS 'No',
    `Location`.`longitude` AS 'X|',
    `Location`.`latitude` AS 'X-',
    `Island`.`name` AS 'Location',
    `HeartContainer`.`details` AS 'Details'
FROM
    `HeartContainer`

LEFT JOIN `QuestTaskHeartContainer` ON
    `HeartContainer`.`id` = `QuestTaskHeartContainer`.`heartContainerId`
LEFT JOIN `QuestTaskLocation` ON
    `QuestTaskHeartContainer`.`questTaskId` = `QuestTaskLocation`.`questTaskId`

LEFT JOIN `Location` ON
    `QuestTaskLocation`.`locationId` = `Location`.`id`
LEFT JOIN `Island` ON
    `Location`.`id` = `Island`.`locationId`
;

-- -----------------------------------------------------
-- View `HeartPieceLocation`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `HeartPieceLocation` ;
DROP TABLE IF EXISTS `HeartPieceLocation`;
CREATE  OR REPLACE VIEW `HeartPieceLocation` AS
SELECT
    `HeartPiece`.`id` AS 'No',
    `Location`.`longitude` AS 'X|',
    `Location`.`latitude` AS 'X-',
    `Island`.`name` AS 'Location',
    `HeartPiece`.`task` AS 'Task'
FROM
    `HeartPiece`

LEFT JOIN `QuestTaskHeartPiece` ON
    `HeartPiece`.`id` = `QuestTaskHeartPiece`.`heartPieceId`
LEFT JOIN `QuestTaskLocation` ON
    `QuestTaskHeartPiece`.`questTaskId` = `QuestTaskLocation`.`questTaskId`

LEFT JOIN `SunkenHeartPiece` ON
    `HeartPiece`.`id` = `SunkenHeartPiece`.`heartPieceId`
LEFT JOIN `SunkenChest` ON
    `SunkenHeartPiece`.`sunkenChestId` = `SunkenChest`.`id`

LEFT JOIN `SecretCaveHeartPiece` ON
    `HeartPiece`.`id` = `SecretCaveHeartPiece`.`heartPieceId`
LEFT JOIN `SecretCave` ON
    `SecretCaveHeartPiece`.`secretCaveId` = `SecretCave`.`id`

LEFT JOIN `MiniGameHeartPiece` ON
    `HeartPiece`.`id` = `MiniGameHeartPiece`.`heartPieceId`
LEFT JOIN `MiniGameLocation` ON
    `MiniGameHeartPiece`.`miniGameId` = `MiniGameLocation`.`miniGameId`

LEFT JOIN `SubmarineHeartPiece` ON
    `HeartPiece`.`id` = `SubmarineHeartPiece`.`heartPieceId`
LEFT JOIN `Submarine` ON
    `SubmarineHeartPiece`.`submarineId` = `Submarine`.`id`

LEFT JOIN `BigOctoHeartPiece` ON
    `HeartPiece`.`id` = `BigOctoHeartPiece`.`heartPieceId`
LEFT JOIN `BigOcto` ON
    `BigOctoHeartPiece`.`bigOctoId` = `BigOcto`.`id`

LEFT JOIN `PlatformHeartPiece` ON
    `HeartPiece`.`id` = `PlatformHeartPiece`.`heartPieceId`
LEFT JOIN `Platform` ON
    `PlatformHeartPiece`.`platformId` = `Platform`.`id`

LEFT JOIN `Location` ON
       `QuestTaskLocation`.`locationId` = `Location`.`id`
    OR `SunkenChest`.`expectedLocationId`
    OR `SecretCave`.`locationId`
    OR `MiniGameLocation`.`locationId`
    OR `Submarine`.`expectedLocationId`
    OR `BigOcto`.`expectedLocationId`
    OR `Platform`.`locationId`
LEFT JOIN `Island` ON
    `Location`.`id` = `Island`.`locationId`
;

-- -----------------------------------------------------
-- View `view1`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `view1` ;
DROP TABLE IF EXISTS `view1`;

-- -----------------------------------------------------
-- View `ItemLocation`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ItemLocation` ;
DROP TABLE IF EXISTS `ItemLocation`;
CREATE  OR REPLACE VIEW `ItemLocation` AS
SELECT
    `Item`.`id` AS 'No',
    `Item`.`name` AS 'Name',
    `Location`.`longitude` AS 'X|',
    `Location`.`latitude` AS 'X-',
    `Island`.`name` AS 'Location',
    `Item`.`details` AS 'Details',
    `Item`.`required` AS `Required`
FROM
    `Item`

LEFT JOIN `QuestTaskItem` ON
    `Item`.`id` = `QuestTaskItem`.`itemId`
LEFT JOIN `QuestTaskLocation` ON
    `QuestTaskItem`.`questTaskId` = `QuestTaskLocation`.`questTaskId`

LEFT JOIN `SecretCaveItem` ON
    `Item`.`id` = `SecretCaveItem`.`itemId`
LEFT JOIN `SecretCave` ON
    `SecretCaveItem`.`secretCaveId` = `SecretCave`.`id`

LEFT JOIN `SubmarineItem` ON
    `Item`.`id` = `SubmarineItem`.`itemId`
LEFT JOIN `Submarine` ON
    `SubmarineItem`.`submarineId` = `Submarine`.`id`

LEFT JOIN `Location` ON
       `QuestTaskLocation`.`locationId` = `Location`.`id`
    OR `SecretCave`.`locationId`
    OR `Submarine`.`expectedLocationId`
LEFT JOIN `Island` ON
    `Location`.`id` = `Island`.`locationId`
;

-- -----------------------------------------------------
-- View `RequiredItem`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `RequiredItem` ;
DROP TABLE IF EXISTS `RequiredItem`;
CREATE  OR REPLACE VIEW `RequiredItem` AS
SELECT
    `ItemLocation`.`No` AS 'No',
    `ItemLocation`.`Name` AS 'Name',
    `ItemLocation`.`X|` AS 'X|',
    `ItemLocation`.`X-` AS 'X-',
    `ItemLocation`.`Location` AS 'Location',
    `ItemLocation`.`Details` AS 'Details'
FROM
    `ItemLocation`
WHERE
    `ItemLocation`.`Required` = 1
;

-- -----------------------------------------------------
-- View `OptionalItem`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `OptionalItem` ;
DROP TABLE IF EXISTS `OptionalItem`;
CREATE  OR REPLACE VIEW `OptionalItem` AS
SELECT
    `ItemLocation`.`No` AS 'No',
    `ItemLocation`.`Name` AS 'Name',
    `ItemLocation`.`X|` AS 'X|',
    `ItemLocation`.`X-` AS 'X-',
    `ItemLocation`.`Location` AS 'Location',
    `ItemLocation`.`Details` AS 'Details'
FROM
    `ItemLocation`
WHERE
    `ItemLocation`.`Required` = 0
;

-- -----------------------------------------------------
-- View `TreasureChartLocation`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `TreasureChartLocation` ;
DROP TABLE IF EXISTS `TreasureChartLocation`;
CREATE  OR REPLACE VIEW `TreasureChartLocation` AS
SELECT
    `TreasureChart`.`chartNumber` AS 'No',
    `Location`.`longitude` AS 'X|',
    `Location`.`latitude` AS 'X-',
    `Island`.`name` AS 'Location',
    `TreasureChart`.`details` AS 'Details'
FROM
    `TreasureChart`

LEFT JOIN `QuestTaskTreasureChart` ON
    `TreasureChart`.`id` = `QuestTaskTreasureChart`.`treasureChartId`
LEFT JOIN `QuestTaskLocation` ON
    `QuestTaskTreasureChart`.`questTaskId` = `QuestTaskLocation`.`questTaskId`

LEFT JOIN `SecretCaveTreasureChart` ON
    `TreasureChart`.`id` = `SecretCaveTreasureChart`.`treasureChartId`
LEFT JOIN `SecretCave` ON
    `SecretCaveTreasureChart`.`secretCaveId` = `SecretCave`.`id`

LEFT JOIN `MiniGameTreasureChart` ON
    `TreasureChart`.`id` = `MiniGameTreasureChart`.`treasureChartId`
LEFT JOIN `MiniGameLocation` ON
    `MiniGameTreasureChart`.`miniGameId` = `MiniGameLocation`.`miniGameId`

LEFT JOIN `SubmarineTreasureChart` ON
    `TreasureChart`.`id` = `SubmarineTreasureChart`.`treasureChartId`
LEFT JOIN `Submarine` ON
    `SubmarineTreasureChart`.`submarineId` = `Submarine`.`id`

LEFT JOIN `PlatformTreasureChart` ON
    `TreasureChart`.`id` = `PlatformTreasureChart`.`treasureChartId`
LEFT JOIN `Platform` ON
    `PlatformTreasureChart`.`platformId` = `Platform`.`id`

LEFT JOIN `Location` ON
       `QuestTaskLocation`.`locationId` = `Location`.`id`
    OR `SecretCave`.`locationId`
    OR `MiniGameLocation`.`locationId`
    OR `Submarine`.`expectedLocationId`
    OR `Platform`.`locationId`
LEFT JOIN `Island` ON
    `Location`.`id` = `Island`.`locationId`
;

-- -----------------------------------------------------
-- View `BlueChuChuLocation`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `BlueChuChuLocation` ;
DROP TABLE IF EXISTS `BlueChuChuLocation`;
CREATE  OR REPLACE VIEW `BlueChuChuLocation` AS
SELECT
    `BlueChuChu`.`id` AS 'No',
    `Location`.`longitude` AS 'X|',
    `Location`.`latitude` AS 'X-',
    `Island`.`name` AS 'Location',
    `BlueChuChuIsland`.`details` AS 'Details'
FROM
    `BlueChuChu`

LEFT JOIN `BlueChuChuIsland` ON
    `BlueChuChu`.`id` = `BlueChuChuIsland`.`blueChuChuId`

LEFT JOIN `Island` ON
    `BlueChuChuIsland`.`islandId` = `Island`.`id`
LEFT JOIN `Location` ON
    `Location`.`id` = `Island`.`locationId`
;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `TreasureChart`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (01, 01, 'In Forbidden Woods');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (02, 02, 'Give Maggie\'s Father 20 Skull Necklaces');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (03, 03, 'Small island outside Forest Haven, Deku Leaf');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (04, 04, 'Beedle Special Shop (900 Rupees)');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (05, 05, 'In Wind Temple');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (06, 06, 'In Tower of the Gods');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (07, 07, 'Win the Zee Fleet mini-game (2nd)');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (08, 08, 'Clear the Secret Cave');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (09, 09, 'Clear the Submarine');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (10, 10, 'Sitting on the island');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (11, 11, 'In Dragon Roost Cavern');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (12, 12, 'In Earth Temple');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (13, 13, 'Clear the artillery from the reef');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (14, 14, 'Clear the Submarine');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (15, 15, 'In Forbidden Woods');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (16, 16, 'Clear the Platforms');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (17, 17, 'Win the Cannon Shoot mini-game (2nd)');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (18, 18, 'Win the Auction (2nd)');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (19, 19, 'Clear all artillery from the reef');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (20, 20, 'In Earth Temple');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (21, 21, 'Clear all artillery from the reef');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (22, 22, 'Clear the Submarine');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (23, 23, 'Win the Zee Fleet mini-game (3rd)');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (24, 24, 'Show Lenzo & friend picto to gossip ladies');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (25, 25, 'Use Secret Cave to reach it on high cliff');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (26, 26, 'Clear all artillery from the reef');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (27, 27, 'On top of the cliff');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (28, 28, 'Finish the \"Golf\" game with the Boko Nuts');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (29, 29, 'Secret room in Lenzo\'s house');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (30, 30, 'In Tower of the Gods');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (31, 31, 'Show full moon picto to man on steps');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (32, 32, 'Clear all artillery from the reef');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (33, 33, 'Show picto of old beauty queen to herself');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (34, 34, 'Given by Salvage Corp.');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (35, 35, 'In Wind Temple');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (36, 36, 'Use Fire Arrows on iced chest');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (37, 37, 'Clear the Secret Cave');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (38, 38, 'Win the Auction (1st)');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (39, 39, 'In Dragon Roost Cavern');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (40, 40, 'Clear the Platforms');
INSERT INTO `TreasureChart` (`id`, `chartNumber`, `details`) VALUES (41, 41, 'Clear the artillery from the reef');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Longitude`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Longitude` (`value`) VALUES ('A');
INSERT INTO `Longitude` (`value`) VALUES ('B');
INSERT INTO `Longitude` (`value`) VALUES ('C');
INSERT INTO `Longitude` (`value`) VALUES ('D');
INSERT INTO `Longitude` (`value`) VALUES ('E');
INSERT INTO `Longitude` (`value`) VALUES ('F');
INSERT INTO `Longitude` (`value`) VALUES ('G');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Latitude`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Latitude` (`value`) VALUES (1);
INSERT INTO `Latitude` (`value`) VALUES (2);
INSERT INTO `Latitude` (`value`) VALUES (3);
INSERT INTO `Latitude` (`value`) VALUES (4);
INSERT INTO `Latitude` (`value`) VALUES (5);
INSERT INTO `Latitude` (`value`) VALUES (6);
INSERT INTO `Latitude` (`value`) VALUES (7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Location`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (01, 'A', 1);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (02, 'A', 2);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (03, 'A', 3);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (04, 'A', 4);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (05, 'A', 5);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (06, 'A', 6);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (07, 'A', 7);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (08, 'B', 1);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (09, 'B', 2);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (10, 'B', 3);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (11, 'B', 4);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (12, 'B', 5);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (13, 'B', 6);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (14, 'B', 7);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (15, 'C', 1);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (16, 'C', 2);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (17, 'C', 3);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (18, 'C', 4);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (19, 'C', 5);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (20, 'C', 6);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (21, 'C', 7);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (22, 'D', 1);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (23, 'D', 2);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (24, 'D', 3);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (25, 'D', 4);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (26, 'D', 5);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (27, 'D', 6);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (28, 'D', 7);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (29, 'E', 1);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (30, 'E', 2);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (31, 'E', 3);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (32, 'E', 4);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (33, 'E', 5);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (34, 'E', 6);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (35, 'E', 7);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (36, 'F', 1);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (37, 'F', 2);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (38, 'F', 3);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (39, 'F', 4);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (40, 'F', 5);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (41, 'F', 6);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (42, 'F', 7);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (43, 'G', 1);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (44, 'G', 2);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (45, 'G', 3);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (46, 'G', 4);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (47, 'G', 5);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (48, 'G', 6);
INSERT INTO `Location` (`id`, `longitude`, `latitude`) VALUES (49, 'G', 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SunkenChest`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (01, 01);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (02, 02);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (03, 03);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (04, 04);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (05, 05);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (06, 06);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (07, 07);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (08, 08);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (09, 09);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (10, 10);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (11, 11);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (12, 12);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (13, 13);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (14, 14);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (15, 15);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (16, 16);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (17, 17);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (18, 18);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (19, 19);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (20, 20);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (21, 21);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (22, 22);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (23, 23);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (24, 24);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (25, 25);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (26, 26);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (27, 27);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (28, 28);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (29, 29);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (30, 30);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (31, 31);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (32, 32);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (33, 33);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (34, 34);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (35, 35);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (36, 36);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (37, 37);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (38, 38);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (39, 39);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (40, 40);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (41, 41);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (42, 42);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (43, 43);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (44, 44);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (45, 45);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (46, 46);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (47, 47);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (48, 48);
INSERT INTO `SunkenChest` (`id`, `expectedLocationId`) VALUES (49, 49);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Rupee`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Rupee` (`id`, `value`, `color`) VALUES (01, 01, 'green');
INSERT INTO `Rupee` (`id`, `value`, `color`) VALUES (05, 05, 'blue');
INSERT INTO `Rupee` (`id`, `value`, `color`) VALUES (10, 10, 'yellow');
INSERT INTO `Rupee` (`id`, `value`, `color`) VALUES (20, 20, 'red');
INSERT INTO `Rupee` (`id`, `value`, `color`) VALUES (50, 50, 'purple');
INSERT INTO `Rupee` (`id`, `value`, `color`) VALUES (100, 100, 'orange');
INSERT INTO `Rupee` (`id`, `value`, `color`) VALUES (200, 200, 'silver');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SunkenRupee`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (01, 25, 01, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (02, 08, 03, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (03, 28, 05, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (04, 09, 07, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (05, 07, 08, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (06, 29, 09, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (07, 35, 12, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (08, 12, 13, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (09, 24, 15, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (10, 22, 16, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (11, 10, 17, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (12, 16, 20, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (13, 40, 21, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (14, 18, 23, 001);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (15, 06, 25, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (16, 03, 31, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (17, 14, 32, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (18, 01, 33, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (19, 17, 34, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (20, 39, 37, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (21, 37, 38, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (22, 34, 39, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (23, 27, 45, 200);
INSERT INTO `SunkenRupee` (`id`, `chartId`, `sunkenChestId`, `rupeeId`) VALUES (24, 36, 47, 200);

COMMIT;


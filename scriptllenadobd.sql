-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema caso1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema caso1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `caso1` DEFAULT CHARACTER SET utf8 ;
USE `caso1` ;

-- -----------------------------------------------------
-- Table `caso1`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Usuarios` (
  `userid` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(50) NOT NULL,
  `password` VARBINARY(255) NOT NULL,
  `lastname` VARCHAR(60) NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`roles` (
  `rolid` INT NOT NULL,
  `rolName` VARCHAR(50) NOT NULL,
  `description` VARCHAR(255) NULL,
  `lastupdate` TIMESTAMP NOT NULL,
  PRIMARY KEY (`rolid`),
  UNIQUE INDEX `tipoderol_UNIQUE` (`rolName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`modulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`modulos` (
  `moduloid` TINYINT(8) NOT NULL AUTO_INCREMENT,
  `nombreModulo` VARCHAR(40) NULL,
  PRIMARY KEY (`moduloid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`permisos` (
  `permisoid` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` MEDIUMTEXT NULL,
  `codigoPermiso` VARCHAR(10) NULL,
  `moduloid` TINYINT(8) NOT NULL,
  PRIMARY KEY (`permisoid`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `fk_permisos_modulos1_idx` (`moduloid` ASC) VISIBLE,
  CONSTRAINT `fk_permisos_modulos1`
    FOREIGN KEY (`moduloid`)
    REFERENCES `caso1`.`modulos` (`moduloid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`roles_permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`roles_permisos` (
  `rolid` INT NOT NULL,
  `permisoid` INT NOT NULL,
  `enabled` BIT(1) NULL DEFAULT 1,
  `deleted` BIT(1) NULL DEFAULT 0,
  `lastupdate` DATETIME NULL DEFAULT  NOW(),
  `checksum` VARBINARY(250) NULL,
  INDEX `fk_roles_permisos_roles1_idx` (`rolid` ASC) VISIBLE,
  INDEX `fk_roles_permisos_permisos1_idx` (`permisoid` ASC) VISIBLE,
  CONSTRAINT `fk_roles_permisos_roles1`
    FOREIGN KEY (`rolid`)
    REFERENCES `caso1`.`roles` (`rolid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roles_permisos_permisos1`
    FOREIGN KEY (`permisoid`)
    REFERENCES `caso1`.`permisos` (`permisoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`users_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`users_roles` (
  `lastupdate` TIMESTAMP NOT NULL DEFAULT  NOW(),
  `rolid` INT NOT NULL,
  `userid` INT NOT NULL,
  INDEX `fk_users_roles_roles1_idx` (`rolid` ASC) VISIBLE,
  INDEX `fk_users_roles_users1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_users_roles_roles1`
    FOREIGN KEY (`rolid`)
    REFERENCES `caso1`.`roles` (`rolid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_roles_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `caso1`.`ContactInfoTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`ContactInfoTypes` (
  `ContactInfoTypesId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ContactInfoTypesId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`ContactInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`ContactInfo` (
  `ContactInfoId` INT NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(255) NOT NULL,
  `checksum` VARBINARY(32) NULL,
  `isPrincipal` BIT(1) NOT NULL DEFAULT 0,
  `contactInfoTypeId` INT NOT NULL,
  `lastupdate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ownerTipo` VARCHAR(50) NOT NULL,
  `ownerID` INT NOT NULL,
  PRIMARY KEY (`ContactInfoId`),
  INDEX `fk_ContactInfo_ContactInfoTypes1_idx` (`contactInfoTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_ContactInfo_ContactInfoTypes1`
    FOREIGN KEY (`contactInfoTypeId`)
    REFERENCES `caso1`.`ContactInfoTypes` (`ContactInfoTypesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`permissions` (
  `permissionid` INT NOT NULL AUTO_INCREMENT,
  `permissionName` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NULL,
  `code` VARCHAR(20) NOT NULL,
  `lastupdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`permissionid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`rolepermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`rolepermissions` (
  `lastupdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rolid` INT NOT NULL,
  `permissionid` INT NOT NULL,
  `last_update` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `active` BIT(1) NULL DEFAULT 1,
  PRIMARY KEY (`lastupdate`),
  INDEX `fk_rolepermissions_roles1_idx` (`rolid` ASC) VISIBLE,
  INDEX `fk_rolepermissions_permissions1_idx` (`permissionid` ASC) VISIBLE,
  CONSTRAINT `fk_rolepermissions_roles1`
    FOREIGN KEY (`rolid`)
    REFERENCES `caso1`.`roles` (`rolid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rolepermissions_permissions1`
    FOREIGN KEY (`permissionid`)
    REFERENCES `caso1`.`permissions` (`permissionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Suscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Suscripcion` (
  `suscriptionid` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `logoURL` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`suscriptionid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`PlanPrices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`PlanPrices` (
  `planPriceID` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) NOT NULL,
  `recurrencyType` VARCHAR(45) NULL,
  `postTime` DATETIME NOT NULL,
  `endDate` DATETIME NOT NULL,
  `current` BIT(1) NOT NULL,
  `suscriptionid` INT NOT NULL,
  PRIMARY KEY (`planPriceID`),
  INDEX `fk_PlanPrices_Suscripcion1_idx` (`suscriptionid` ASC) VISIBLE,
  CONSTRAINT `fk_PlanPrices_Suscripcion1`
    FOREIGN KEY (`suscriptionid`)
    REFERENCES `caso1`.`Suscripcion` (`suscriptionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`PlanPerPerson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`PlanPerPerson` (
  `planPerPersonID` INT NOT NULL AUTO_INCREMENT,
  `enable` BIT(1) NOT NULL,
  `adquisition` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userid` INT NOT NULL,
  `planPriceID` INT NOT NULL,
  PRIMARY KEY (`planPerPersonID`),
  INDEX `fk_PlanPerPerson_Usuarios1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_PlanPerPerson_PlanPrices1_idx` (`planPriceID` ASC) VISIBLE,
  CONSTRAINT `fk_PlanPerPerson_Usuarios1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlanPerPerson_PlanPrices1`
    FOREIGN KEY (`planPriceID`)
    REFERENCES `caso1`.`PlanPrices` (`planPriceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`FeaturePerPlan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`FeaturePerPlan` (
  `featurePerPlanID` INT NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(100) NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `suscriptionid` INT NOT NULL,
  PRIMARY KEY (`featurePerPlanID`),
  INDEX `fk_FeaturePerPlan_Suscripcion1_idx` (`suscriptionid` ASC) VISIBLE,
  CONSTRAINT `fk_FeaturePerPlan_Suscripcion1`
    FOREIGN KEY (`suscriptionid`)
    REFERENCES `caso1`.`Suscripcion` (`suscriptionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Proveedor` (
  `proveedorid` INT NOT NULL AUTO_INCREMENT,
  `proveedorname` VARCHAR(100) NOT NULL,
  `tipo` ENUM('banco', 'seguro', 'otro') NOT NULL,
  `lastupdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sitioWeb` VARCHAR(255) NULL,
  `config` JSON NULL,
  `datosFiscales` VARCHAR(100) NULL,
  PRIMARY KEY (`proveedorid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`MetodoPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`MetodoPago` (
  `metodoPagoid` INT NOT NULL AUTO_INCREMENT,
  `token` VARBINARY(400) NOT NULL,
  `expirationdate` DATE NOT NULL,
  `checksum` VARBINARY(32) NULL,
  `lastupdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `userid` INT NOT NULL,
  `tipoPagoid` INT NOT NULL,
  `proveedorid` INT NOT NULL,
  `refreshToken` VARBINARY(400) NULL,
  `detalles` JSON NULL,
  PRIMARY KEY (`metodoPagoid`),
  INDEX `fk_MetodoPago_users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_MetodoPago_proveedor1_idx` (`proveedorid` ASC) VISIBLE,
  CONSTRAINT `fk_MetodoPago_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MetodoPago_proveedor1`
    FOREIGN KEY (`proveedorid`)
    REFERENCES `caso1`.`Proveedor` (`proveedorid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Services` (
  `serviceid` INT NOT NULL AUTO_INCREMENT,
  `servicename` VARCHAR(100) NOT NULL,
  `parametrosPago` JSON NULL,
  `proveedorid` INT NOT NULL,
  PRIMARY KEY (`serviceid`),
  INDEX `fk_services_proveedor1_idx` (`proveedorid` ASC) VISIBLE,
  CONSTRAINT `fk_services_proveedor1`
    FOREIGN KEY (`proveedorid`)
    REFERENCES `caso1`.`Proveedor` (`proveedorid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Schedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Schedules` (
  `scheduleID` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `recurrence_type` ENUM('diario', 'semanal', 'mensual', 'anual', 'otro') NOT NULL,
  `recurrence_value` INT NOT NULL,
  `repetitions` TINYINT NOT NULL,
  `endDate` DATE NULL,
  PRIMARY KEY (`scheduleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Schedule` (
  `scheduleDetail_id` INT NOT NULL AUTO_INCREMENT,
  `scheduleID` INT NOT NULL,
  `baseDate` DATE NOT NULL,
  `last_exec_datetime` DATETIME NOT NULL,
  `next_exec_datetime` DATETIME NOT NULL,
  `datePart` INT NOT NULL,
  PRIMARY KEY (`scheduleDetail_id`),
  INDEX `fk_ScheduleDetails_Schedules1_idx` (`scheduleID` ASC) VISIBLE,
  CONSTRAINT `fk_ScheduleDetails_Schedules1`
    FOREIGN KEY (`scheduleID`)
    REFERENCES `caso1`.`Schedules` (`scheduleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`pagoProgramado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`pagoProgramado` (
  `pagoid` INT NOT NULL AUTO_INCREMENT,
  `monto` DECIMAL(10,2) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `checksum` VARBINARY(32) NULL,
  `userid` INT NOT NULL,
  `serviceid` INT NOT NULL,
  `metodoPagoid` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  `scheduleDetailID` INT NOT NULL,
  PRIMARY KEY (`pagoid`),
  INDEX `fk_pagoProgramado_users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_pagoProgramado_services1_idx` (`serviceid` ASC) VISIBLE,
  INDEX `fk_pagoProgramado_MetodoPago1_idx` (`metodoPagoid` ASC) VISIBLE,
  INDEX `fk_pagoProgramado_Schedule1_idx` (`scheduleDetailID` ASC) VISIBLE,
  CONSTRAINT `fk_pagoProgramado_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagoProgramado_services1`
    FOREIGN KEY (`serviceid`)
    REFERENCES `caso1`.`Services` (`serviceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagoProgramado_MetodoPago1`
    FOREIGN KEY (`metodoPagoid`)
    REFERENCES `caso1`.`MetodoPago` (`metodoPagoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagoProgramado_Schedule1`
    FOREIGN KEY (`scheduleDetailID`)
    REFERENCES `caso1`.`Schedule` (`scheduleDetail_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Moneda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Moneda` (
  `monedaid` INT NOT NULL AUTO_INCREMENT,
  `simbolo` VARCHAR(10) NOT NULL,
  `acronym` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`monedaid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`tasaCambio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`tasaCambio` (
  `tasaid` INT NOT NULL AUTO_INCREMENT,
  `tasa` DECIMAL(10,4) NOT NULL,
  `fechaActualizacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bit` BIT(1) NOT NULL DEFAULT 1,
  `monedaOrigen` INT NOT NULL,
  `monedaDestino` INT NOT NULL,
  PRIMARY KEY (`tasaid`),
  INDEX `fk_tasaCambio_moneda1_idx` (`monedaOrigen` ASC) VISIBLE,
  INDEX `fk_tasaCambio_moneda2_idx` (`monedaDestino` ASC) VISIBLE,
  CONSTRAINT `fk_tasaCambio_moneda1`
    FOREIGN KEY (`monedaOrigen`)
    REFERENCES `caso1`.`Moneda` (`monedaid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tasaCambio_moneda2`
    FOREIGN KEY (`monedaDestino`)
    REFERENCES `caso1`.`Moneda` (`monedaid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`TransSubTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`TransSubTypes` (
  `transSubTypeID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `last_update` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transSubTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`TransType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`TransType` (
  `trans_type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`trans_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Transaccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Transaccion` (
  `transaccionid` BIGINT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(12,2) NOT NULL,
  `description` VARCHAR(255) NULL,
  `trans_datetime` DATETIME NOT NULL,
  `postTime` DATETIME NULL,
  `refNumber` VARCHAR(100) NULL DEFAULT 0,
  `lastupdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pagoid` INT NULL,
  `userid` INT NOT NULL,
  `exchangeRate` DECIMAL(10,6) NULL,
  `checksum` VARBINARY(32) NULL,
  `transSubTypeID` INT NOT NULL,
  `transtype_id` INT NOT NULL,
  PRIMARY KEY (`transaccionid`),
  INDEX `fk_transaccion_pagoProgramado1_idx` (`pagoid` ASC) VISIBLE,
  INDEX `fk_transaccion_Usuarios1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_Transaccion_TransSubTypes1_idx` (`transSubTypeID` ASC) VISIBLE,
  INDEX `fk_Transaccion_TransType1_idx` (`transtype_id` ASC) VISIBLE,
  CONSTRAINT `fk_transaccion_pagoProgramado1`
    FOREIGN KEY (`pagoid`)
    REFERENCES `caso1`.`pagoProgramado` (`pagoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaccion_Usuarios1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaccion_TransSubTypes1`
    FOREIGN KEY (`transSubTypeID`)
    REFERENCES `caso1`.`TransSubTypes` (`transSubTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaccion_TransType1`
    FOREIGN KEY (`transtype_id`)
    REFERENCES `caso1`.`TransType` (`trans_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Notificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Notificacion` (
  `notificacionid` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('SMS', 'email', 'otro') NOT NULL,
  `mensaje` VARCHAR(255) NOT NULL,
  `fechaEnvio` TIMESTAMP NOT NULL,
  `estado` ENUM('enviado', 'fallido', 'pendiente') NOT NULL,
  `lastupdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `userid` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`notificacionid`),
  INDEX `fk_Notificacion_Usuarios1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_Notificacion_Usuarios1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`APIExterna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`APIExterna` (
  `apiId` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('bancaria', 'SMS', 'pago') NOT NULL,
  `endpoint` VARCHAR(255) NOT NULL,
  `tokenAcceso` VARBINARY(255) NOT NULL,
  `checksum` VARBINARY(32) NULL,
  `configuracion` JSON NULL,
  `proveedorid` INT NOT NULL,
  `config` JSON NULL,
  `key` VARBINARY(255) NULL,
  `secret` VARBINARY(255) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`apiId`),
  INDEX `fk_APIExterna_proveedor1_idx` (`proveedorid` ASC) VISIBLE,
  CONSTRAINT `fk_APIExterna_proveedor1`
    FOREIGN KEY (`proveedorid`)
    REFERENCES `caso1`.`Proveedor` (`proveedorid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`LogTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`LogTypes` (
  `logtypeID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `ref1Desc` VARCHAR(100) NOT NULL,
  `ref2Desc` VARCHAR(100) NOT NULL,
  `val1Desc` VARCHAR(100) NOT NULL,
  `val2Desc` VARCHAR(100) NOT NULL,
  `last_update` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`logtypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`LogSources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`LogSources` (
  `logsource_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `last_update` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`logsource_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`LogSeverity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`LogSeverity` (
  `logseverity_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `last_update` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`logseverity_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Logs` (
  `log_id` BIGINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `postTime` DATETIME NOT NULL,
  `computer` VARCHAR(100) NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `trace` VARCHAR(255) NOT NULL,
  `referenceID1` BIGINT NULL,
  `referenceID2` BIGINT NULL,
  `value1` VARCHAR(100) NULL,
  `value2` VARCHAR(100) NULL,
  `checksum` VARBINARY(32) NULL,
  `last_update` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `logtypeID` INT NOT NULL,
  `logsource_id` INT NOT NULL,
  `logseverity_id` INT NOT NULL,
  PRIMARY KEY (`log_id`),
  INDEX `fk_Logs_LogTypes1_idx` (`logtypeID` ASC) VISIBLE,
  INDEX `fk_Logs_LogSources1_idx` (`logsource_id` ASC) VISIBLE,
  INDEX `fk_Logs_LogSeverity1_idx` (`logseverity_id` ASC) VISIBLE,
  CONSTRAINT `fk_Logs_LogTypes1`
    FOREIGN KEY (`logtypeID`)
    REFERENCES `caso1`.`LogTypes` (`logtypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logs_LogSources1`
    FOREIGN KEY (`logsource_id`)
    REFERENCES `caso1`.`LogSources` (`logsource_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logs_LogSeverity1`
    FOREIGN KEY (`logseverity_id`)
    REFERENCES `caso1`.`LogSeverity` (`logseverity_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`TranslationLanguage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`TranslationLanguage` (
  `language_id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(10) NOT NULL,
  `culture` VARCHAR(20) NULL,
  `name` VARCHAR(50) NULL,
  `last_update` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`SesionProcesamientoIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`SesionProcesamientoIA` (
  `sessionID` INT NOT NULL AUTO_INCREMENT,
  `horaIncio` DATETIME NOT NULL,
  `horaFin` DATETIME NOT NULL,
  `status` ENUM('active', 'completed', 'failed') NOT NULL,
  `S3audio` VARCHAR(100) NOT NULL,
  `lastupdate` DATETIME NOT NULL,
  `userid` INT NOT NULL,
  PRIMARY KEY (`sessionID`),
  INDEX `fk_SesionIA_Usuarios1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_SesionIA_Usuarios1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`TranscripcionVoz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`TranscripcionVoz` (
  `transcription_id` INT NOT NULL AUTO_INCREMENT,
  `transcription_text` VARCHAR(2000) NOT NULL,
  `original_audio_reference` VARCHAR(255) NOT NULL,
  `lastupdate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sessionID` INT NOT NULL,
  `esParcial` BIT(1) NOT NULL,
  `confianzaAvg` DECIMAL(5,2) NOT NULL,
  `estable` BIT(1) NOT NULL,
  PRIMARY KEY (`transcription_id`),
  INDEX `fk_TranscripcionVoz_SesionIA1_idx` (`sessionID` ASC) VISIBLE,
  CONSTRAINT `fk_TranscripcionVoz_SesionIA1`
    FOREIGN KEY (`sessionID`)
    REFERENCES `caso1`.`SesionProcesamientoIA` (`sessionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Countries` (
  `countryCode` CHAR(2) NOT NULL,
  `countryName` VARCHAR(100) NOT NULL,
  `monedaid` INT NOT NULL,
  `languageID` INT NOT NULL,
  `language_id` INT NOT NULL,
  PRIMARY KEY (`countryCode`),
  INDEX `fk_Countries_moneda1_idx` (`monedaid` ASC) VISIBLE,
  INDEX `fk_Countries_TranslationLanguage1_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_Countries_moneda1`
    FOREIGN KEY (`monedaid`)
    REFERENCES `caso1`.`Moneda` (`monedaid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Countries_TranslationLanguage1`
    FOREIGN KEY (`language_id`)
    REFERENCES `caso1`.`TranslationLanguage` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Pagos` (
  `pagoID` BIGINT NOT NULL AUTO_INCREMENT,
  `monto` DECIMAL(12,2) NOT NULL,
  `userid` INT NOT NULL,
  `monedaid` INT NOT NULL,
  `actualMonto` DECIMAL(12,2) NOT NULL,
  `result` VARCHAR(50) NOT NULL,
  `auth` VARCHAR(100) NULL,
  `referencia` VARCHAR(100) NULL,
  `chargeToken` VARBINARY(400) NULL,
  `description` VARCHAR(255) NULL,
  `error` VARCHAR(255) NULL,
  `fecha` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `checksum` VARBINARY(32) NULL,
  `metodoPagoid` INT NOT NULL,
  PRIMARY KEY (`pagoID`),
  INDEX `fk_Pagos_Usuarios1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_Pagos_Moneda1_idx` (`monedaid` ASC) VISIBLE,
  INDEX `fk_Pagos_MetodoPago1_idx` (`metodoPagoid` ASC) VISIBLE,
  CONSTRAINT `fk_Pagos_Usuarios1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagos_Moneda1`
    FOREIGN KEY (`monedaid`)
    REFERENCES `caso1`.`Moneda` (`monedaid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagos_MetodoPago1`
    FOREIGN KEY (`metodoPagoid`)
    REFERENCES `caso1`.`MetodoPago` (`metodoPagoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Balances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Balances` (
  `balanceID` BIGINT NOT NULL,
  `userid` INT NOT NULL,
  `balance` DECIMAL(12,2) NOT NULL,
  `lastBalance` DECIMAL(12,2) NOT NULL,
  `freeze_amount` DECIMAL(12,2) NOT NULL,
  `last_update` DATETIME NULL,
  `checksum` VARBINARY(32) NULL,
  PRIMARY KEY (`balanceID`),
  INDEX `fk_Balances_Usuarios1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_Balances_Usuarios1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`PlanFeatures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`PlanFeatures` (
  `planFeaturesID` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `datatype` VARCHAR(45) NOT NULL,
  `featurePerPlanID` INT NOT NULL,
  PRIMARY KEY (`planFeaturesID`),
  INDEX `fk_PlanFeatures_FeaturePerPlan1_idx` (`featurePerPlanID` ASC) VISIBLE,
  CONSTRAINT `fk_PlanFeatures_FeaturePerPlan1`
    FOREIGN KEY (`featurePerPlanID`)
    REFERENCES `caso1`.`FeaturePerPlan` (`featurePerPlanID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`PersonPlanLimits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`PersonPlanLimits` (
  `planID` INT NOT NULL AUTO_INCREMENT,
  `limit` VARCHAR(45) NOT NULL,
  `planFeaturesID` INT NOT NULL,
  `planPerPersonID` INT NOT NULL,
  PRIMARY KEY (`planID`),
  INDEX `fk_PersonPlanLimits_PlanFeatures1_idx` (`planFeaturesID` ASC) VISIBLE,
  INDEX `fk_PersonPlanLimits_PlanPerPerson1_idx` (`planPerPersonID` ASC) VISIBLE,
  CONSTRAINT `fk_PersonPlanLimits_PlanFeatures1`
    FOREIGN KEY (`planFeaturesID`)
    REFERENCES `caso1`.`PlanFeatures` (`planFeaturesID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PersonPlanLimits_PlanPerPerson1`
    FOREIGN KEY (`planPerPersonID`)
    REFERENCES `caso1`.`PlanPerPerson` (`planPerPersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`AI_Interaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`AI_Interaction` (
  `interaction_id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `transcription_id` INT NOT NULL,
  `command_extracted` VARCHAR(255) NOT NULL,
  `model_version` VARCHAR(50) NOT NULL,
  `response_generated` VARCHAR(255) NOT NULL,
  `lastupdate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`interaction_id`),
  INDEX `fk_AI_Interaction_Usuarios1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_AI_Interaction_VoiceTranscription1_idx` (`transcription_id` ASC) VISIBLE,
  CONSTRAINT `fk_AI_Interaction_Usuarios1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AI_Interaction_VoiceTranscription1`
    FOREIGN KEY (`transcription_id`)
    REFERENCES `caso1`.`TranscripcionVoz` (`transcription_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`SettingKeys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`SettingKeys` (
  `settingKeyID` INT NOT NULL AUTO_INCREMENT,
  `settingKey` VARCHAR(50) NOT NULL,
  `settingDescription` VARCHAR(255) NULL,
  PRIMARY KEY (`settingKeyID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`UserSettings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`UserSettings` (
  `setting_id` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `setting_value` VARCHAR(255) NOT NULL,
  `last_update` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `settingKeyID` INT NOT NULL,
  PRIMARY KEY (`setting_id`),
  INDEX `fk_UserSettings_Usuarios1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_UserSettings_SettingKeys1_idx` (`settingKeyID` ASC) VISIBLE,
  CONSTRAINT `fk_UserSettings_Usuarios1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserSettings_SettingKeys1`
    FOREIGN KEY (`settingKeyID`)
    REFERENCES `caso1`.`SettingKeys` (`settingKeyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`InterpretacionIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`InterpretacionIA` (
  `interpretacionID` BIGINT NOT NULL AUTO_INCREMENT,
  `intencionInteracionNombre` VARCHAR(100) NOT NULL,
  `confianzaAvg` DECIMAL(5,2) NOT NULL,
  `datosParticulares` JSON NOT NULL,
  `transcription_id` INT NOT NULL,
  `sessionID` INT NOT NULL,
  `enable` BIT(1) NOT NULL,
  `tipoError` VARCHAR(45) NULL,
  PRIMARY KEY (`interpretacionID`),
  INDEX `fk_InterpretacionIA_TranscripcionVoz1_idx` (`transcription_id` ASC) VISIBLE,
  INDEX `fk_InterpretacionIA_SesionProcesamientoIA1_idx` (`sessionID` ASC) VISIBLE,
  CONSTRAINT `fk_InterpretacionIA_TranscripcionVoz1`
    FOREIGN KEY (`transcription_id`)
    REFERENCES `caso1`.`TranscripcionVoz` (`transcription_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InterpretacionIA_SesionProcesamientoIA1`
    FOREIGN KEY (`sessionID`)
    REFERENCES `caso1`.`SesionProcesamientoIA` (`sessionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`PagoIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`PagoIA` (
  `pagoIAConfig` INT NOT NULL AUTO_INCREMENT,
  `pagoID` BIGINT NOT NULL,
  `sessionID` INT NOT NULL,
  `configPago` JSON NOT NULL,
  `status` ENUM('active', 'pending', 'cancelled') NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `interpretacionID` BIGINT NULL,
  PRIMARY KEY (`pagoIAConfig`),
  INDEX `fk_PagoConfiguradoIA_Pagos1_idx` (`pagoID` ASC) VISIBLE,
  INDEX `fk_PagoConfiguradoIA_SesionProcesamientoIA1_idx` (`sessionID` ASC) VISIBLE,
  INDEX `fk_PagoIA_InterpretacionIA1_idx` (`interpretacionID` ASC) VISIBLE,
  CONSTRAINT `fk_PagoConfiguradoIA_Pagos1`
    FOREIGN KEY (`pagoID`)
    REFERENCES `caso1`.`Pagos` (`pagoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PagoConfiguradoIA_SesionProcesamientoIA1`
    FOREIGN KEY (`sessionID`)
    REFERENCES `caso1`.`SesionProcesamientoIA` (`sessionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PagoIA_InterpretacionIA1`
    FOREIGN KEY (`interpretacionID`)
    REFERENCES `caso1`.`InterpretacionIA` (`interpretacionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`eventoPagoTipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`eventoPagoTipo` (
  `eventoPagoID` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`eventoPagoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`InteracionLogsIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`InteracionLogsIA` (
  `iaLogID` INT NOT NULL AUTO_INCREMENT,
  `sessionID` INT NOT NULL,
  `contenido` VARCHAR(400) NOT NULL,
  `infoAdicional` JSON NULL,
  `eventoPagoID` INT NOT NULL,
  `tipo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`iaLogID`),
  INDEX `fk_InteracionLogsIA_SesionProcesamientoIA1_idx` (`sessionID` ASC) VISIBLE,
  INDEX `fk_InteracionLogsIA_eventoPagoTipo1_idx` (`eventoPagoID` ASC) VISIBLE,
  CONSTRAINT `fk_InteracionLogsIA_SesionProcesamientoIA1`
    FOREIGN KEY (`sessionID`)
    REFERENCES `caso1`.`SesionProcesamientoIA` (`sessionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InteracionLogsIA_eventoPagoTipo1`
    FOREIGN KEY (`eventoPagoID`)
    REFERENCES `caso1`.`eventoPagoTipo` (`eventoPagoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`RecordAcciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`RecordAcciones` (
  `recordAccionID` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `sessionID` INT NOT NULL,
  `pagoIAConfig` INT NOT NULL,
  `descripcion` VARCHAR(400) NOT NULL,
  `metaData` JSON NOT NULL,
  PRIMARY KEY (`recordAccionID`),
  INDEX `fk_RecordAcciones_Usuarios1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_RecordAcciones_SesionProcesamientoIA1_idx` (`sessionID` ASC) VISIBLE,
  INDEX `fk_RecordAcciones_PagoIA1_idx` (`pagoIAConfig` ASC) VISIBLE,
  CONSTRAINT `fk_RecordAcciones_Usuarios1`
    FOREIGN KEY (`userid`)
    REFERENCES `caso1`.`Usuarios` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RecordAcciones_SesionProcesamientoIA1`
    FOREIGN KEY (`sessionID`)
    REFERENCES `caso1`.`SesionProcesamientoIA` (`sessionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RecordAcciones_PagoIA1`
    FOREIGN KEY (`pagoIAConfig`)
    REFERENCES `caso1`.`PagoIA` (`pagoIAConfig`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`DetalllesInterpretacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`DetalllesInterpretacion` (
  `idDetalllesInterpretacion` INT NOT NULL AUTO_INCREMENT,
  `clave` VARCHAR(100) NOT NULL,
  `valor` VARCHAR(45) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `interpretacionID` BIGINT NOT NULL,
  PRIMARY KEY (`idDetalllesInterpretacion`),
  INDEX `fk_DetalllesInterpretacion_InterpretacionIA1_idx` (`interpretacionID` ASC) VISIBLE,
  CONSTRAINT `fk_DetalllesInterpretacion_InterpretacionIA1`
    FOREIGN KEY (`interpretacionID`)
    REFERENCES `caso1`.`InterpretacionIA` (`interpretacionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

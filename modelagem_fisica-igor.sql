-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sge
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sge` ;

-- -----------------------------------------------------
-- Schema sge
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sge` ;
USE `sge` ;

-- -----------------------------------------------------
-- Table `sge`.`turma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`turma` ;

CREATE TABLE IF NOT EXISTS `sge`.`turma` (
  `idturma` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `ano` INT NULL,
  PRIMARY KEY (`idturma`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`aluno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`aluno` ;

CREATE TABLE IF NOT EXISTS `sge`.`aluno` (
  `idaluno` INT NOT NULL,
  `endereço` VARCHAR(45) NULL,
  `idade` DATE NULL,
  `email` VARCHAR(45) NULL,
  `alunocol` VARCHAR(45) NULL,
  `turma_idturma` INT NOT NULL,
  PRIMARY KEY (`idaluno`, `turma_idturma`),
  INDEX `fk_aluno_turma_idx` (`turma_idturma` ASC) VISIBLE,
  CONSTRAINT `fk_aluno_turma`
    FOREIGN KEY (`turma_idturma`)
    REFERENCES `sge`.`turma` (`idturma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`professor` ;

CREATE TABLE IF NOT EXISTS `sge`.`professor` (
  `idprofessor` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `especialiação` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idprofessor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`disciplina` ;

CREATE TABLE IF NOT EXISTS `sge`.`disciplina` (
  `iddisciplina` INT NOT NULL,
  `cod_disciplina` VARCHAR(45) NULL,
  `carga_horaria` INT NULL,
  `ano` INT NULL,
  PRIMARY KEY (`iddisciplina`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`leciona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`leciona` ;

CREATE TABLE IF NOT EXISTS `sge`.`leciona` (
  `professor_idprofessor` INT NOT NULL,
  `turma_idturma` INT NOT NULL,
  PRIMARY KEY (`professor_idprofessor`, `turma_idturma`),
  INDEX `fk_professor_has_turma_turma1_idx` (`turma_idturma` ASC) VISIBLE,
  INDEX `fk_professor_has_turma_professor1_idx` (`professor_idprofessor` ASC) VISIBLE,
  CONSTRAINT `fk_professor_has_turma_professor1`
    FOREIGN KEY (`professor_idprofessor`)
    REFERENCES `sge`.`professor` (`idprofessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_has_turma_turma1`
    FOREIGN KEY (`turma_idturma`)
    REFERENCES `sge`.`turma` (`idturma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`associada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`associada` ;

CREATE TABLE IF NOT EXISTS `sge`.`associada` (
  `disciplina_iddisciplina` INT NOT NULL,
  `turma_idturma` INT NOT NULL,
  PRIMARY KEY (`disciplina_iddisciplina`, `turma_idturma`),
  INDEX `fk_disciplina_has_turma_turma1_idx` (`turma_idturma` ASC) VISIBLE,
  INDEX `fk_disciplina_has_turma_disciplina1_idx` (`disciplina_iddisciplina` ASC) VISIBLE,
  CONSTRAINT `fk_disciplina_has_turma_disciplina1`
    FOREIGN KEY (`disciplina_iddisciplina`)
    REFERENCES `sge`.`disciplina` (`iddisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disciplina_has_turma_turma1`
    FOREIGN KEY (`turma_idturma`)
    REFERENCES `sge`.`turma` (`idturma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`administra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`administra` ;

CREATE TABLE IF NOT EXISTS `sge`.`administra` (
  `professor_idprofessor` INT NOT NULL,
  `disciplina_iddisciplina` INT NOT NULL,
  PRIMARY KEY (`professor_idprofessor`, `disciplina_iddisciplina`),
  INDEX `fk_professor_has_disciplina_disciplina1_idx` (`disciplina_iddisciplina` ASC) VISIBLE,
  INDEX `fk_professor_has_disciplina_professor1_idx` (`professor_idprofessor` ASC) VISIBLE,
  CONSTRAINT `fk_professor_has_disciplina_professor1`
    FOREIGN KEY (`professor_idprofessor`)
    REFERENCES `sge`.`professor` (`idprofessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_has_disciplina_disciplina1`
    FOREIGN KEY (`disciplina_iddisciplina`)
    REFERENCES `sge`.`disciplina` (`iddisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

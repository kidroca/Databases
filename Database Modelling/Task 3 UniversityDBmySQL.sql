CREATE DATABASE  IF NOT EXISTS `UniversitiesDB` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `UniversitiesDB`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: localhost    Database: UniversitiesDB
-- ------------------------------------------------------
-- Server version	5.6.27-log

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
-- Table structure for table `Courses`
--

DROP TABLE IF EXISTS `Courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Courses` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `DepartmentId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Courses_Depaments_idx` (`DepartmentId`),
  CONSTRAINT `FK_Courses_Depaments` FOREIGN KEY (`DepartmentId`) REFERENCES `Departments` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Courses`
--

LOCK TABLES `Courses` WRITE;
/*!40000 ALTER TABLE `Courses` DISABLE KEYS */;
INSERT INTO `Courses` VALUES (1,'OOP',1),(2,'JavaScript UI and DOM',1);
/*!40000 ALTER TABLE `Courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Departments`
--

DROP TABLE IF EXISTS `Departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Departments` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FacultyId` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_Departments_Faculties1_idx` (`FacultyId`),
  CONSTRAINT `FK_Departments_Faculties` FOREIGN KEY (`FacultyId`) REFERENCES `faculties` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Departments`
--

LOCK TABLES `Departments` WRITE;
/*!40000 ALTER TABLE `Departments` DISABLE KEYS */;
INSERT INTO `Departments` VALUES (1,1,'C#'),(2,1,'JavaScript');
/*!40000 ALTER TABLE `Departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Faculties`
--

DROP TABLE IF EXISTS `Faculties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Faculties` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `UniversityId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Universities_UniversityId_idx` (`UniversityId`),
  CONSTRAINT `FK_Faculties_Universities` FOREIGN KEY (`UniversityId`) REFERENCES `universities` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faculties`
--

LOCK TABLES `Faculties` WRITE;
/*!40000 ALTER TABLE `Faculties` DISABLE KEYS */;
INSERT INTO `Faculties` VALUES (1,'Informatics',1),(2,'AlgoAcademy',1);
/*!40000 ALTER TABLE `Faculties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Professors`
--

DROP TABLE IF EXISTS `Professors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Professors` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `DepartmntId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Professors_Departments_idx` (`DepartmntId`),
  CONSTRAINT `FK_Professors_Departments` FOREIGN KEY (`DepartmntId`) REFERENCES `Departments` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Professors`
--

LOCK TABLES `Professors` WRITE;
/*!40000 ALTER TABLE `Professors` DISABLE KEYS */;
INSERT INTO `Professors` VALUES (1,'Doncho',2);
/*!40000 ALTER TABLE `Professors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Professors_Courses_Chain`
--

DROP TABLE IF EXISTS `Professors_Courses_Chain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Professors_Courses_Chain` (
  `ProfessorId` int(11) NOT NULL,
  `CourseId` int(11) NOT NULL,
  KEY `FK_Professors_Courses_idx` (`CourseId`),
  KEY `FK_Courses_Professors_idx` (`ProfessorId`),
  CONSTRAINT `FK_Courses_Professors` FOREIGN KEY (`ProfessorId`) REFERENCES `Professors` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Professors_Courses` FOREIGN KEY (`CourseId`) REFERENCES `Courses` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Professors_Courses_Chain`
--

LOCK TABLES `Professors_Courses_Chain` WRITE;
/*!40000 ALTER TABLE `Professors_Courses_Chain` DISABLE KEYS */;
INSERT INTO `Professors_Courses_Chain` VALUES (1,2);
/*!40000 ALTER TABLE `Professors_Courses_Chain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Professors_Titles_Chain`
--

DROP TABLE IF EXISTS `Professors_Titles_Chain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Professors_Titles_Chain` (
  `ProfessorId` int(11) NOT NULL,
  `TitleId` int(11) NOT NULL,
  KEY `FK_Titles_Professors_idx` (`ProfessorId`),
  KEY `FK_Professors_Titles_idx` (`TitleId`),
  CONSTRAINT `FK_Professors_Titles` FOREIGN KEY (`TitleId`) REFERENCES `titles` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Titles_Professors` FOREIGN KEY (`ProfessorId`) REFERENCES `Professors` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Professors_Titles_Chain`
--

LOCK TABLES `Professors_Titles_Chain` WRITE;
/*!40000 ALTER TABLE `Professors_Titles_Chain` DISABLE KEYS */;
INSERT INTO `Professors_Titles_Chain` VALUES (1,2);
/*!40000 ALTER TABLE `Professors_Titles_Chain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Students`
--

DROP TABLE IF EXISTS `Students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Students` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `FacultyId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Students_Faculties_idx` (`FacultyId`),
  CONSTRAINT `FK_Students_Faculties` FOREIGN KEY (`FacultyId`) REFERENCES `Faculties` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Students`
--

LOCK TABLES `Students` WRITE;
/*!40000 ALTER TABLE `Students` DISABLE KEYS */;
/*!40000 ALTER TABLE `Students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Students_Courses_Chain`
--

DROP TABLE IF EXISTS `Students_Courses_Chain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Students_Courses_Chain` (
  `StudentId` int(11) NOT NULL,
  `CourseId` int(11) NOT NULL,
  KEY `FK_Students_Courses_idx` (`CourseId`),
  KEY `FK_Courses_Students_idx` (`StudentId`),
  CONSTRAINT `FK_Courses_Students` FOREIGN KEY (`StudentId`) REFERENCES `Students` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Students_Courses` FOREIGN KEY (`CourseId`) REFERENCES `Courses` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Students_Courses_Chain`
--

LOCK TABLES `Students_Courses_Chain` WRITE;
/*!40000 ALTER TABLE `Students_Courses_Chain` DISABLE KEYS */;
/*!40000 ALTER TABLE `Students_Courses_Chain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Titles`
--

DROP TABLE IF EXISTS `Titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Titles` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` longtext NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Titles`
--

LOCK TABLES `Titles` WRITE;
/*!40000 ALTER TABLE `Titles` DISABLE KEYS */;
INSERT INTO `Titles` VALUES (1,'Javascript Ninja','Big Skills in JavaScript'),(2,'Javascript Black Ninja','Big Skill in JavaScript << 2');
/*!40000 ALTER TABLE `Titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Universities`
--

DROP TABLE IF EXISTS `Universities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Universities` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Universities`
--

LOCK TABLES `Universities` WRITE;
/*!40000 ALTER TABLE `Universities` DISABLE KEYS */;
INSERT INTO `Universities` VALUES (1,'Telerik');
/*!40000 ALTER TABLE `Universities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-10-09 16:22:00

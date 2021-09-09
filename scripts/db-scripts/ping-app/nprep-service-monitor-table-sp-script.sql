CREATE DATABASE  IF NOT EXISTS `nprep_services_monitor` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `nprep_services_monitor`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: 192.168.0.74    Database: nprep_services_monitor
-- ------------------------------------------------------
-- Server version	5.5.24-log

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
-- Table structure for table `event_log`
--

DROP TABLE IF EXISTS `event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) NOT NULL,
  `service_name` varchar(45) NOT NULL,
  `event_name` varchar(45) NOT NULL,
  `timestamp` datetime NOT NULL,
  `details` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nprep_ping`
--

DROP TABLE IF EXISTS `nprep_ping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nprep_ping` (
  `ping_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_name` varchar(25) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `last_ping_time` datetime NOT NULL,
  `current_ping_time` datetime DEFAULT NULL,
  `down_time_duration` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ping_id`),
  KEY `id_idx` (`service_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'nprep_services_monitor'
--
/*!50003 DROP PROCEDURE IF EXISTS `pingtransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`adhi.n`@`%` PROCEDURE `pingtransaction`(
	servicename varchar(25),
	ip varchar(15),
	pingtime int
)
BEGIN 
	set @num=2;
	set @ping_id=0;
	set @lastpingtime=null;
	set @timediff=0;


	#Fetching the latest ping id and last ping details
	select ping_id,last_ping_time into @ping_id, @lastpingtime FROM nprep_services_monitor.nprep_ping WHERE service_name=servicename and ip_address=ip order by ping_id desc limit 1;

	if @lastpingtime is null then
		#insert fresh ping details for service+ip combination
		insert into  nprep_services_monitor.nprep_ping(service_name,ip_address,last_ping_time) values (servicename, ip, now());
		else		
			#get time diff between lastping and now
		    set @timediff=(SELECT TIMESTAMPDIFF(SECOND, @lastpingtime, now()));
			#select  @lastpingtime as 'last ping',@timediff as 'timediff';
			if @timediff <= (@num*pingtime) then
				#update last ping time
				update nprep_services_monitor.nprep_ping set last_ping_time=now() where ping_id=@ping_id;
			else
				update nprep_services_monitor.nprep_ping set current_ping_time=now(), down_time_duration=@timediff where ping_id=@ping_id;
				insert into  nprep_services_monitor.nprep_ping(service_name,ip_address,last_ping_time) values (servicename, ip, now());

			end if;
	end if;

	#select service_status as service_status,@run_under_supervision as run_under_supervision;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-14 13:52:39

-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: 192.168.1.22    Database: nprep_registration_database
-- ------------------------------------------------------
-- Server version	5.6.30-0ubuntu0.14.04.1-log

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
-- Current Database: `nprep_registration_database`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `nprep_registration_database` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `nprep_registration_database`;

--
-- Table structure for table `client_database_details`
--

DROP TABLE IF EXISTS `client_database_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_database_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `db_name` varchar(100) NOT NULL,
  `db_host` varchar(100) NOT NULL,
  `db_port` varchar(20) NOT NULL,
  `db_user` varchar(100) NOT NULL,
  `db_password` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL DEFAULT 'Active' COMMENT 'Status can ''Active'' or ''Inactive''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf32;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `client_id` int(10) NOT NULL AUTO_INCREMENT,
  `client_name` varchar(50) NOT NULL,
  `status` varchar(128) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`client_id`),
  UNIQUE KEY `Unique_Client_ID` (`client_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_list`
--

DROP TABLE IF EXISTS `project_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer` varchar(150) NOT NULL,
  `project` varchar(200) NOT NULL,
  `data_source` varchar(500) NOT NULL,
  `point_of_contact` varchar(200) NOT NULL,
  `report_format` varchar(50) NOT NULL,
  `report_frequency` varchar(50) NOT NULL,
  `project_status` varchar(30) NOT NULL,
  `no_queues` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `project_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_name` varchar(50) NOT NULL,
  `contact_person_email` varchar(20) NOT NULL,
  `client_db_id` int(10) NOT NULL,
  `client_id` int(10) NOT NULL,
  `description` text,
  `status` varchar(128) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`project_id`),
  UNIQUE KEY `Unique_Project_Name` (`project_name`),
  KEY `Client_Id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registered_queues`
--

DROP TABLE IF EXISTS `registered_queues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registered_queues` (
  `specific_q_id` varchar(50) NOT NULL,
  `project_id` int(10) unsigned NOT NULL,
  `status` varchar(128) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`specific_q_id`),
  UNIQUE KEY `UKY` (`specific_q_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registered_steps`
--

DROP TABLE IF EXISTS `registered_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registered_steps` (
  `specific_step_id` varchar(50) NOT NULL,
  `specific_q_id` varchar(50) NOT NULL,
  PRIMARY KEY (`specific_step_id`),
  KEY `Uniq_Q` (`specific_q_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'nprep_registration_database'
--

--
-- Dumping routines for database 'nprep_registration_database'
--

--
-- Current Database: `nprep_breadcrumb_database`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `nprep_breadcrumb_database` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `nprep_breadcrumb_database`;

--
-- Table structure for table `bc_launchtopo`
--

DROP TABLE IF EXISTS `bc_launchtopo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bc_launchtopo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(55) NOT NULL DEFAULT 'no-file-name' COMMENT 'Queue temp json filename',
  `q_msg_id` varchar(50) NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000' COMMENT 'UUID q-msg-id from queue Json',
  `topo_entry_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Timestamp (without timezone) of when the queue started.',
  `topo_exit_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Timestamp (without timezone) of when the queue exited.',
  `topo_timezone` varchar(35) DEFAULT NULL COMMENT 'Local timezone of where the run happened.',
  `topo_status` int(11) NOT NULL COMMENT 'Execution status - Id from execution_status_master',
  `topo_ipaddress` varchar(45) NOT NULL COMMENT 'IP Address of system where queue is launched.',
  `client` varchar(200) NOT NULL DEFAULT '-',
  `project` varchar(200) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`),
  KEY `launchtopo_status_FKY` (`topo_status`),
  CONSTRAINT `launchtopo_status_FKY` FOREIGN KEY (`topo_status`) REFERENCES `execution_status_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39160 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bc_project_details`
--

DROP TABLE IF EXISTS `bc_project_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bc_project_details` (
  `date` datetime NOT NULL,
  `project_count` int(11) NOT NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bc_quartzjobs_snapshot`
--

DROP TABLE IF EXISTS `bc_quartzjobs_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bc_quartzjobs_snapshot` (
  `snapshot_date` datetime NOT NULL,
  `normal_count` int(11) DEFAULT NULL,
  `error_count` int(11) DEFAULT NULL,
  `paused_count` int(11) DEFAULT NULL,
  `running_count` int(11) DEFAULT NULL,
  `complete_count` int(11) DEFAULT NULL,
  `blocked_count` int(11) DEFAULT NULL,
  `none_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`snapshot_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bc_queue`
--

DROP TABLE IF EXISTS `bc_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bc_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `specific_wf_id` varchar(50) DEFAULT NULL COMMENT 'UUID specific-wf-id from queue Json',
  `specific_q_id` varchar(50) NOT NULL COMMENT 'UUID specific-q-id from queue Json',
  `q_msg_id` varchar(50) NOT NULL COMMENT 'UUID q-msg-id from queue Json',
  `q_entry_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Timestamp (without timezone) of when the queue started.',
  `q_exit_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Timestamp (without timezone) of when the queue exited.',
  `q_timezone` varchar(35) DEFAULT NULL COMMENT 'Local timezone of where the run happened.',
  `q_status` int(11) NOT NULL COMMENT 'Execution status - Id from execution_status_master',
  `q_json` text NOT NULL COMMENT 'Full queue json',
  `q_ipaddress` varchar(49) NOT NULL,
  `q_lock_id` varchar(125) NOT NULL DEFAULT 'no-lock-id' COMMENT 'Queue ZK lock id',
  `client` varchar(200) NOT NULL DEFAULT '-',
  `project` varchar(200) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`),
  KEY `queue_status_FKY` (`q_status`),
  CONSTRAINT `queue_status_FKY` FOREIGN KEY (`q_status`) REFERENCES `execution_status_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33772 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `trg_idempotent` AFTER UPDATE ON `bc_queue` 
    FOR EACH ROW 
    
    BEGIN
	IF (NEW.q_status = 66 OR NEW.q_status = 98 OR NEW.q_status = 99) THEN
		INSERT INTO `nprep_breadcrumb_database`.`idempotent` (q_msg_id) VALUES (NEW.q_msg_id) ON DUPLICATE KEY UPDATE q_msg_id=NEW.q_msg_id;	
	END IF;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bc_sent_messages`
--

DROP TABLE IF EXISTS `bc_sent_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bc_sent_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `q_msg_id` varchar(50) NOT NULL,
  `topic` varchar(30) NOT NULL,
  `sent_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sent_timezone` varchar(35) DEFAULT NULL,
  `sent_ipaddress` varchar(49) NOT NULL DEFAULT '0.0.0.0',
  `send_status` int(11) NOT NULL,
  `client` varchar(200) NOT NULL DEFAULT '-',
  `project` varchar(200) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`),
  KEY `send_status_FKY_idx` (`send_status`),
  CONSTRAINT `send_status_FKY` FOREIGN KEY (`send_status`) REFERENCES `execution_status_master` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=35734 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bc_step`
--

DROP TABLE IF EXISTS `bc_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bc_step` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bc_queue_ref_id` int(11) NOT NULL COMMENT 'This is the primary key from bc_queue table. This associates a given running step instance to the right queue instance.',
  `specific_step_id` varchar(50) NOT NULL COMMENT 'UUID specific-step-id from queue Json',
  `step_entry_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `step_exit_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `step_timezone` varchar(35) DEFAULT NULL COMMENT 'Local timezone of where the run happened.',
  `step_status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bc_queue_ref_id_FKY` (`bc_queue_ref_id`),
  KEY `step_status_FKY_idx` (`step_status`),
  CONSTRAINT `bc_queue_ref_id_FKY` FOREIGN KEY (`bc_queue_ref_id`) REFERENCES `bc_queue` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `step_status_FKY` FOREIGN KEY (`step_status`) REFERENCES `execution_status_master` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=78775 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bc_stepsusage_snapshot`
--

DROP TABLE IF EXISTS `bc_stepsusage_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bc_stepsusage_snapshot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `step_template_id` varchar(50) NOT NULL,
  `step_template_name` text,
  `category` varchar(50) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4142 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `bd_vw_project_duration`
--

DROP TABLE IF EXISTS `bd_vw_project_duration`;
/*!50001 DROP VIEW IF EXISTS `bd_vw_project_duration`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `bd_vw_project_duration` AS SELECT 
 1 AS `client`,
 1 AS `project`,
 1 AS `start_date`,
 1 AS `end_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `bd_vw_projectinfo`
--

DROP TABLE IF EXISTS `bd_vw_projectinfo`;
/*!50001 DROP VIEW IF EXISTS `bd_vw_projectinfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `bd_vw_projectinfo` AS SELECT 
 1 AS `q_date`,
 1 AS `project`,
 1 AS `client`,
 1 AS `count`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `bd_vw_quartzjobs`
--

DROP TABLE IF EXISTS `bd_vw_quartzjobs`;
/*!50001 DROP VIEW IF EXISTS `bd_vw_quartzjobs`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `bd_vw_quartzjobs` AS SELECT 
 1 AS `snapshot_date`,
 1 AS `total_jobs`,
 1 AS `paused_jobs`,
 1 AS `error_jobs`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `bd_vw_queuecount`
--

DROP TABLE IF EXISTS `bd_vw_queuecount`;
/*!50001 DROP VIEW IF EXISTS `bd_vw_queuecount`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `bd_vw_queuecount` AS SELECT 
 1 AS `q_till_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `bd_vw_queueinfo`
--

DROP TABLE IF EXISTS `bd_vw_queueinfo`;
/*!50001 DROP VIEW IF EXISTS `bd_vw_queueinfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `bd_vw_queueinfo` AS SELECT 
 1 AS `DATE(q_entry_timestamp)`,
 1 AS `HOUR(q_entry_timestamp)`,
 1 AS `epoch_ms`,
 1 AS `q_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `execution_status_master`
--

DROP TABLE IF EXISTS `execution_status_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `execution_status_master` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idempotent`
--

DROP TABLE IF EXISTS `idempotent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idempotent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `q_msg_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `q_msg_UKY` (`q_msg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27138 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `step_detail`
--

DROP TABLE IF EXISTS `step_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `step_detail` (
  `name` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'nprep_breadcrumb_database'
--

--
-- Dumping routines for database 'nprep_breadcrumb_database'
--
/*!50003 DROP FUNCTION IF EXISTS `backlog_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `backlog_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
set t1 =  (
SELECT COUNT(*) AS `backlog_in_hours` FROM (
    SELECT project,topo_status,topo_exit_timestamp FROM bc_launchtopo a INNER JOIN  
     (SELECT MAX(id) id,q_msg_id FROM  `bc_launchtopo` GROUP BY q_msg_id)b
        ON a.id=b.id
      ) AS z  WHERE
    z.project <> 'Nabler-LBQ' AND((z.`topo_status` = 3 OR z.`topo_status` = 9) AND z.`topo_exit_timestamp`  >= (NOW() - INTERVAL hours HOUR))
);
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `backlog_mon_service_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `backlog_mon_service_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
set t1 =  (SELECT COUNT(*) AS backlog_mon_service_in_hours
FROM
bc_launchtopo a
INNER JOIN bc_sent_messages b
WHERE a.q_msg_id = b.q_msg_id
AND (a.topo_status = 3 or a.topo_status = 9) AND b.send_status = 2 AND (topo_entry_timestamp >= (NOW() - INTERVAL  hours hour)));
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `completed_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `completed_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
	
	 SET t1 =  (
		 SELECT COUNT(*) AS completed_in_hours
		 FROM nprep_breadcrumb_database.bc_queue
		 WHERE (q_status = 98 or q_status = 99) and (project != 'Nabler-LBQ') AND (q_exit_timestamp >= (NOW() - INTERVAL  hours HOUR))
	 );
 
 RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `completed_in_hours_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `completed_in_hours_temp`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
	
	 SET t1 =  (
		 SELECT COUNT(*) AS completed_in_hours
		 FROM nprep_breadcrumb_database.bc_queue
		 WHERE (q_status = 98 or q_status = 99) and (project != 'Nabler-LBQ') AND (q_exit_timestamp >= (CONCAT(CURDATE(),' 9:30:00') - INTERVAL  hours HOUR))
	 );
 
 RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `errors_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `errors_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
	
	 set t1 =  (
		 SELECT COUNT(*) as errors_in_hours
		 FROM nprep_breadcrumb_database.bc_queue
		 WHERE (q_status = 66) AND (project != 'Nabler-LBQ') AND (q_exit_timestamp >= (NOW() - INTERVAL  hours hour))
	 );
 
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `errors_in_hours_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `errors_in_hours_temp`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
	
	 set t1 =  (
		 SELECT COUNT(*) as errors_in_hours
		 FROM nprep_breadcrumb_database.bc_queue
		 WHERE (q_status = 66) AND (project != 'Nabler-LBQ') AND (q_exit_timestamp >= (CONCAT(CURDATE(),' 9:30:00') - INTERVAL  hours hour))
	 );
 
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `idempotent_exit_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `idempotent_exit_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
	
	set t1 =  (
		SELECT COUNT(*) as idempotent_exit_in_hour
		FROM nprep_breadcrumb_database.bc_queue
		WHERE (q_status = 33) AND (project != 'Nabler-LBQ') AND (q_exit_timestamp >= (NOW() - INTERVAL hours hour))
	);
 
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `launched_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `launched_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE t1 INT;
	
	SET t1 =  (
		SELECT COUNT(*) AS launched_in_hours
		FROM
			bc_launchtopo a
		WHERE 
			(a.topo_status = 7) AND 
			(a.project != 'Nabler-LBQ') AND 
			(a.topo_exit_timestamp >= (NOW() - INTERVAL hours HOUR))
	);
	
	RETURN t1;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lbq_completed_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `lbq_completed_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
	
	SET t1 =  (
		SELECT COUNT(*) AS `count` 
		FROM `bc_queue` 
		WHERE `project` = 'Nabler-LBQ' AND (`q_status` = 98 or `q_status` = 99)  AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR)
	);
	 
	RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lbq_errors_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `lbq_errors_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
	
	SET t1 =  (
		SELECT COUNT(*) AS `count` 
		FROM `bc_queue` 
		WHERE `project` = 'Nabler-LBQ' AND `q_status` = 66  AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR)
	);
	 
	RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lbq_launched_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `lbq_launched_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
	
	set t1 =  (
		SELECT COUNT(*) as lbq_launched_in_hours
		FROM nprep_breadcrumb_database.bc_launchtopo
		WHERE (topo_status = 7) and (project = 'Nabler-LBQ') AND (topo_entry_timestamp >= (NOW() - INTERVAL hours hour))
	);
	 
	return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lbq_no_action_exits_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `lbq_no_action_exits_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
	
	SET t1 =  (
		SELECT COUNT(*) AS `count` 
		FROM `bc_queue` 
		WHERE `project` = 'Nabler-LBQ' AND `q_status` = 44  AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR)
	);
	 
	RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lbq_no_slot_exit_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `lbq_no_slot_exit_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
	SET t1 =  (
SELECT count(*) as 'LBQ-No-Slot-Exit-7d' FROM nprep_breadcrumb_database.bc_launchtopo  where (topo_status = 4) AND `topo_entry_timestamp`>= (NOW() - INTERVAL hours HOUR));
	RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lbq_processed_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `lbq_processed_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
	
	SET t1 =  (
		SELECT COUNT(*) AS `lbq_processed_in_hours` 
		FROM `bc_queue` 
		WHERE `project` = 'Nabler-LBQ' AND (`q_status` = 10 or `q_status` = 66 or `q_status` = 98 or `q_status` = 99 or `q_status` = 44) AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR)
	);
	 
	RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lbq_received_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `lbq_received_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
	
	set t1 =  (
		SELECT COUNT(*) as lbq_received_in_hours
		FROM nprep_breadcrumb_database.bc_launchtopo
		WHERE (topo_status = 7 or topo_status = 4) and (project = 'Nabler-LBQ') AND (topo_entry_timestamp >= (NOW() - INTERVAL hours hour))
	);
	 
	return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lbq_running_idempotent_exits_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `lbq_running_idempotent_exits_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
	
	SET t1 =  (
		SELECT COUNT(*) AS `count` 
		FROM `bc_queue` 
		WHERE `project` = 'Nabler-LBQ' AND `q_status` = 34  AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR)
	);
	 
	RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lbq_running_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `lbq_running_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
	
	SET t1 =  (
		SELECT COUNT(*) AS `lbq_running_in_hours` 
		FROM `bc_queue` 
		WHERE `project` = 'Nabler-LBQ' AND `q_status` = 10  AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR)
	);
	 
	RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lbq_sent_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `lbq_sent_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
	
	SET t1 =  (
		SELECT COUNT(*) AS `count` 
		FROM `bc_sent_messages` 
		WHERE `project` = 'Nabler-LBQ' AND `send_status` = 1  AND `sent_timestamp`>= (NOW() - INTERVAL hours HOUR)
	);
	 
	RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `processed_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `processed_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
 set t1 =  (SELECT COUNT(*) AS processed_in_hours
FROM nprep_breadcrumb_database.bc_queue
WHERE (q_status = 98 or q_status = 99 or q_status = 66 or q_status = 10) and (project != 'Nabler-LBQ') AND (q_entry_timestamp >= (NOW() - INTERVAL  hours HOUR))
);
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `processed_in_hours_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `processed_in_hours_temp`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
 set t1 =  (SELECT COUNT(*) AS processed_in_hours
FROM nprep_breadcrumb_database.bc_queue
WHERE (q_status = 98 or q_status = 99 or q_status = 66 or q_status = 10) and (project != 'Nabler-LBQ') AND (q_entry_timestamp >= (CONCAT(CURDATE(),' 9:30:00') - INTERVAL  hours HOUR))
);
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `running_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `running_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
	
	set t1 =  (
		SELECT COUNT(*) as running_in_hours
		FROM nprep_breadcrumb_database.bc_queue
		WHERE (q_status = 10) AND (project != 'Nabler-LBQ') AND (q_entry_timestamp >= (NOW() - INTERVAL  hours hour))
	);
	return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `running_in_hours_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `running_in_hours_temp`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
	
	set t1 =  (
		SELECT COUNT(*) as running_in_hours
		FROM nprep_breadcrumb_database.bc_queue
		WHERE (q_status = 10) AND (project != 'Nabler-LBQ') AND (q_entry_timestamp >= (CONCAT(CURDATE(),' 9:30:00') - INTERVAL  hours hour))
	);
	return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sent_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `sent_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
 set t1 =  (SELECT COUNT(*) as sent_in_hours
 FROM nprep_breadcrumb_database.bc_sent_messages
 WHERE (project!='Nabler-LBQ') AND (sent_timestamp >= (NOW() - INTERVAL  hours hour)));
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sent_in_hours_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `sent_in_hours_temp`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
 set t1 =  (SELECT COUNT(*) as sent_in_hours
 FROM nprep_breadcrumb_database.bc_sent_messages
 WHERE (project!='Nabler-LBQ') AND (sent_timestamp >= (CONCAT(CURDATE(),' 9:30:00') - INTERVAL  hours hour)));
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sent_mon_service_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `sent_mon_service_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
 set t1 =  (SELECT COUNT(*) as sent_mon_service_in_hours
 FROM nprep_breadcrumb_database.bc_sent_messages
 WHERE (send_status = 2) AND (sent_timestamp >= (NOW() - INTERVAL  hours hour)));
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sent_scheduled_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `sent_scheduled_in_hours`(hours int) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	declare t1 int;
 set t1 =  (SELECT COUNT(*) as sent_in_hours
 FROM nprep_breadcrumb_database.bc_sent_messages
 WHERE (send_status = 1 and project!='Nabler-LBQ') AND (sent_timestamp >= (NOW() - INTERVAL  hours hour)));
 return t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `total_received_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `total_received_in_hours`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
    
    DECLARE t1 INT;
    
    SET t1 =  (
		SELECT COUNT(*) AS `count` FROM `bc_launchtopo` WHERE 
		project <> 'Nabler-LBQ' AND((`topo_status` = 3 OR `topo_status` = 7)
		AND `topo_exit_timestamp`  >= (NOW() - INTERVAL hours HOUR))
	);
    
    
    
RETURN t1;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `total_received_in_hours_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `total_received_in_hours_temp`(hours INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
    
    DECLARE t1 INT;
    
    SET t1 =  (
		SELECT COUNT(*) AS `count` FROM `bc_launchtopo` WHERE 
		project <> 'Nabler-LBQ' AND((`topo_status` = 3 OR `topo_status` = 7)
		AND `topo_exit_timestamp`  >= (CONCAT(CURDATE(),' 9:30:00') - INTERVAL hours HOUR))
	);
    
RETURN t1;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_all_received_in_days` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_all_received_in_days`(IN days int)
BEGIN
    SELECT COUNT(*) FROM `bc_launchtopo` WHERE 
    project <> 'Nabler-LBQ' AND((`topo_status` = 3 OR `topo_status` = 7) 
    AND `topo_exit_timestamp`  >= (NOW() - INTERVAL days day));
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_all_received_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_all_received_in_hours`(IN hours int)
BEGIN
    SELECT COUNT(*) as `count` FROM `bc_launchtopo` WHERE 
     project <> 'Nabler-LBQ' AND((`topo_status` = 3 OR `topo_status` = 7)
    AND `topo_exit_timestamp`  >= (NOW() - INTERVAL hours HOUR));
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_all_sent_in_days` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_all_sent_in_days`(IN days INT)
BEGIN
    SELECT `send_status`,COUNT(*) FROM `bc_sent_messages`
WHERE project <> 'Nabler-LBQ'  AND `sent_timestamp` >= NOW() - INTERVAL days day
GROUP BY `send_status`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_all_sent_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_all_sent_in_hours`(IN hours int)
BEGIN
    SELECT `send_status` as `status_code`,COUNT(*) as `count` FROM `bc_sent_messages`
WHERE project <> 'Nabler-LBQ'  AND `sent_timestamp` >= NOW() - INTERVAL hours HOUR
GROUP BY `send_status`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_backlogs_in_days` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_backlogs_in_days`(in days int)
BEGIN
     SELECT COUNT(*) FROM (
     SELECT project,topo_status,topo_exit_timestamp FROM bc_launchtopo a INNER JOIN  
     (SELECT MAX(id) id,q_msg_id FROM  `bc_launchtopo` GROUP BY q_msg_id)b
      ON a.id=b.id
     ) AS z  WHERE
     z.project <> 'Nabler-LBQ' AND((z.`topo_status` = 3 OR z.`topo_status` = 9) AND
      z.`topo_exit_timestamp`  >= (NOW() - INTERVAL days day));
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_backlogs_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_backlogs_in_hours`(in hours int  )
BEGIN
    SELECT COUNT(*) as `count` FROM (
    SELECT project,topo_status,topo_exit_timestamp FROM bc_launchtopo a INNER JOIN  
     (SELECT MAX(id) id,q_msg_id FROM  `bc_launchtopo` GROUP BY q_msg_id)b
        ON a.id=b.id
      ) AS z  WHERE
    z.project <> 'Nabler-LBQ' AND((z.`topo_status` = 3 OR z.`topo_status` = 9) AND z.`topo_exit_timestamp`  >= (NOW() - INTERVAL hours HOUR));
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_idempotent_exits_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_idempotent_exits_in_hours`(IN hours INT)
BEGIN
	SELECT COUNT(*) AS `count` 
	FROM `bc_queue` 
	WHERE `project` <> 'Nabler-LBQ' AND `q_status` = 33 AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_launched_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_launched_in_hours`(IN hours INT)
BEGIN
	SELECT COUNT(*) AS `count` 
	FROM `bc_launchtopo` WHERE topo_status = 7 AND project <> 'Nabler-LBQ' AND  topo_exit_timestamp >= NOW() - INTERVAL hours HOUR;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_lbq_completed_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_lbq_completed_in_hours`(IN hours INT)
BEGIN
	SELECT COUNT(*) AS `count` 
	FROM `bc_queue` 
	WHERE `project` = 'Nabler-LBQ' AND `q_status` = 98 or `q_status` = 99  AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_lbq_errors_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_lbq_errors_in_hours`(IN hours INT)
BEGIN
	SELECT COUNT(*) AS `count` 
	FROM `bc_queue` 
	WHERE `project` = 'Nabler-LBQ' AND `q_status` = 66  AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_lbq_launched_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_lbq_launched_in_hours`(IN hours INT)
BEGIN
	SELECT COUNT(*) AS `count` 
	FROM `bc_launchtopo` WHERE topo_status = 7 and project = 'Nabler-LBQ' AND topo_exit_timestamp >= NOW() - INTERVAL hours HOUR;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_lbq_no_action_exits_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_lbq_no_action_exits_in_hours`(IN hours INT)
BEGIN
	SELECT COUNT(*) AS `count` 
	FROM `bc_queue` 
	WHERE `project` = 'Nabler-LBQ' and `q_status` = 44  AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_lbq_running_idempotent_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_lbq_running_idempotent_in_hours`(IN hours INT)
BEGIN
	SELECT COUNT(*) AS `count` 
	FROM `bc_queue` 
	WHERE `project` = 'Nabler-LBQ' AND `q_status` = 34  AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_lbq_running_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_lbq_running_in_hours`(IN hours INT)
BEGIN
	SELECT COUNT(*) AS `count` 
	FROM `bc_queue` 
	WHERE `project` = 'Nabler-LBQ' AND `q_status` = 10  AND `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nprep_processed_in_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `nprep_processed_in_hours`(in hours int)
BEGIN
     SELECT `q_status` as `status_code`, COUNT(*) as `count` FROM `bc_queue` WHERE 
     `project` <> 'Nabler-LBQ' AND  `q_exit_timestamp`>= (NOW() - INTERVAL hours HOUR)
     
     GROUP BY `q_status`;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `nprep_ndrive`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `nprep_ndrive` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `nprep_ndrive`;

--
-- Table structure for table `ndrive_acks`
--

DROP TABLE IF EXISTS `ndrive_acks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ndrive_acks` (
  `ack_id` int(11) NOT NULL AUTO_INCREMENT,
  `trigger_parent` varchar(1500) NOT NULL,
  `trigger_file_name` varchar(1500) NOT NULL,
  `action` varchar(60) NOT NULL,
  `sub_action` varchar(50) NOT NULL,
  `ack_json` longtext NOT NULL,
  `timestamp` datetime NOT NULL,
  `status` varchar(30) NOT NULL,
  `status_message` text NOT NULL,
  PRIMARY KEY (`ack_id`)
) ENGINE=InnoDB AUTO_INCREMENT=639 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'nprep_ndrive'
--

--
-- Dumping routines for database 'nprep_ndrive'
--

--
-- Current Database: `nprep_replay_database`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `nprep_replay_database` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `nprep_replay_database`;

--
-- Table structure for table `failedmessages`
--

DROP TABLE IF EXISTS `failedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic` varchar(50) NOT NULL,
  `message` mediumtext NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `q_msg_id` varchar(50) NOT NULL DEFAULT 'non-queue-message',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'nprep_replay_database'
--

--
-- Dumping routines for database 'nprep_replay_database'
--

--
-- Current Database: `nprep_services_monitor`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `nprep_services_monitor` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `nprep_services_monitor`;

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
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nprep_ping_old`
--

DROP TABLE IF EXISTS `nprep_ping_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nprep_ping_old` (
  `ping_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `last_ping_time` datetime NOT NULL,
  `current_ping_time` datetime DEFAULT NULL,
  `down_time_duration` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ping_id`),
  KEY `id_idx` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3845 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'nprep_services_monitor'
--

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
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `pingtransaction`(
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

--
-- Current Database: `nprep_registration_database`
--

USE `nprep_registration_database`;

--
-- Current Database: `nprep_breadcrumb_database`
--

USE `nprep_breadcrumb_database`;

--
-- Final view structure for view `bd_vw_project_duration`
--

/*!50001 DROP VIEW IF EXISTS `bd_vw_project_duration`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `bd_vw_project_duration` AS select `bc_queue`.`client` AS `client`,`bc_queue`.`project` AS `project`,min(`bc_queue`.`q_entry_timestamp`) AS `start_date`,max(`bc_queue`.`q_entry_timestamp`) AS `end_date` from `bc_queue` group by `bc_queue`.`client`,`bc_queue`.`project` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `bd_vw_projectinfo`
--

/*!50001 DROP VIEW IF EXISTS `bd_vw_projectinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `bd_vw_projectinfo` AS select cast(`bc_queue`.`q_entry_timestamp` as date) AS `q_date`,`bc_queue`.`project` AS `project`,`bc_queue`.`client` AS `client`,count(0) AS `count` from `bc_queue` where ((`bc_queue`.`project` <> '-') and (`bc_queue`.`client` <> '-')) group by `bc_queue`.`project`,cast(`bc_queue`.`q_entry_timestamp` as date) order by cast(`bc_queue`.`q_entry_timestamp` as date) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `bd_vw_quartzjobs`
--

/*!50001 DROP VIEW IF EXISTS `bd_vw_quartzjobs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `bd_vw_quartzjobs` AS (select `bc_quartzjobs_snapshot`.`snapshot_date` AS `snapshot_date`,((((((`bc_quartzjobs_snapshot`.`normal_count` + `bc_quartzjobs_snapshot`.`error_count`) + `bc_quartzjobs_snapshot`.`paused_count`) + `bc_quartzjobs_snapshot`.`running_count`) + `bc_quartzjobs_snapshot`.`complete_count`) + `bc_quartzjobs_snapshot`.`blocked_count`) + `bc_quartzjobs_snapshot`.`none_count`) AS `total_jobs`,`bc_quartzjobs_snapshot`.`paused_count` AS `paused_jobs`,`bc_quartzjobs_snapshot`.`error_count` AS `error_jobs` from `bc_quartzjobs_snapshot` where (cast(`bc_quartzjobs_snapshot`.`snapshot_date` as date) = curdate())) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `bd_vw_queuecount`
--

/*!50001 DROP VIEW IF EXISTS `bd_vw_queuecount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `bd_vw_queuecount` AS select count(0) AS `q_till_date` from `bc_queue` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `bd_vw_queueinfo`
--

/*!50001 DROP VIEW IF EXISTS `bd_vw_queueinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `bd_vw_queueinfo` AS select cast(`bc_queue`.`q_entry_timestamp` as date) AS `DATE(q_entry_timestamp)`,hour(`bc_queue`.`q_entry_timestamp`) AS `HOUR(q_entry_timestamp)`,(unix_timestamp(`bc_queue`.`q_entry_timestamp`) * 1000) AS `epoch_ms`,count(0) AS `q_count` from `bc_queue` group by cast(`bc_queue`.`q_entry_timestamp` as date),hour(`bc_queue`.`q_entry_timestamp`) order by cast(`bc_queue`.`q_entry_timestamp` as date),hour(`bc_queue`.`q_entry_timestamp`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Current Database: `nprep_ndrive`
--

USE `nprep_ndrive`;

--
-- Current Database: `nprep_replay_database`
--

USE `nprep_replay_database`;

--
-- Current Database: `nprep_services_monitor`
--

USE `nprep_services_monitor`;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-30 10:32:34

-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 192.168.1.26    Database: tenx_breadcrumb_database
-- ------------------------------------------------------
-- Server version	5.7.19

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
-- Current Database: `tenx_breadcrumb_database`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenx_breadcrumb_database` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `tenx_breadcrumb_database`;

--
-- Table structure for table `bc_jobs`
--

DROP TABLE IF EXISTS `bc_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bc_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(50) DEFAULT NULL COMMENT 'UUID group-id from Job Json',
  `job_id` varchar(50) NOT NULL COMMENT 'UUID job-id from Job Json',
  `job_uid` varchar(50) NOT NULL COMMENT 'UUID uid from Job Json',
  `job_entry_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp (without timezone) of when the job started.',
  `job_exit_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp (without timezone) of when the job exited.',
  `timezone` varchar(35) DEFAULT NULL COMMENT 'Local timezone of where the run happened.',
  `job_status` int(11) NOT NULL COMMENT 'Execution status - Id from execution_status_master',
  `job_json` text NOT NULL COMMENT 'Full Job JSON',
  `host` varchar(49) NOT NULL,
  `client` varchar(200) NOT NULL DEFAULT '-',
  `project` varchar(200) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`),
  KEY `job_status_FKY` (`job_status`),
  CONSTRAINT `job_status_FKY` FOREIGN KEY (`job_status`) REFERENCES `execution_status_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18102 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=123678 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `instance_id` varchar(50) NOT NULL,
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `last_24_hours_executed_jobs_v`
--

DROP TABLE IF EXISTS `last_24_hours_executed_jobs_v`;
/*!50001 DROP VIEW IF EXISTS `last_24_hours_executed_jobs_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `last_24_hours_executed_jobs_v` AS SELECT 
 1 AS `instance_id`,
 1 AS `job_type`,
 1 AS `state`,
 1 AS `sub_state`,
 1 AS `state_updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `last_24_hours_submitted_jobs_v`
--

DROP TABLE IF EXISTS `last_24_hours_submitted_jobs_v`;
/*!50001 DROP VIEW IF EXISTS `last_24_hours_submitted_jobs_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `last_24_hours_submitted_jobs_v` AS SELECT 
 1 AS `id`,
 1 AS `instance_id`,
 1 AS `job_type`,
 1 AS `job_id`,
 1 AS `group_id`,
 1 AS `job_json`,
 1 AS `client`,
 1 AS `project`,
 1 AS `timestamp`,
 1 AS `host`,
 1 AS `component`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `last_hour_executed_jobs_v`
--

DROP TABLE IF EXISTS `last_hour_executed_jobs_v`;
/*!50001 DROP VIEW IF EXISTS `last_hour_executed_jobs_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `last_hour_executed_jobs_v` AS SELECT 
 1 AS `instance_id`,
 1 AS `job_type`,
 1 AS `state`,
 1 AS `sub_state`,
 1 AS `state_updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `last_hour_submitted_jobs_v`
--

DROP TABLE IF EXISTS `last_hour_submitted_jobs_v`;
/*!50001 DROP VIEW IF EXISTS `last_hour_submitted_jobs_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `last_hour_submitted_jobs_v` AS SELECT 
 1 AS `id`,
 1 AS `instance_id`,
 1 AS `job_type`,
 1 AS `job_id`,
 1 AS `group_id`,
 1 AS `job_json`,
 1 AS `client`,
 1 AS `project`,
 1 AS `timestamp`,
 1 AS `host`,
 1 AS `component`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `last_week_executed_jobs_v`
--

DROP TABLE IF EXISTS `last_week_executed_jobs_v`;
/*!50001 DROP VIEW IF EXISTS `last_week_executed_jobs_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `last_week_executed_jobs_v` AS SELECT 
 1 AS `instance_id`,
 1 AS `job_type`,
 1 AS `state`,
 1 AS `sub_state`,
 1 AS `state_updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `last_week_submitted_jobs_v`
--

DROP TABLE IF EXISTS `last_week_submitted_jobs_v`;
/*!50001 DROP VIEW IF EXISTS `last_week_submitted_jobs_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `last_week_submitted_jobs_v` AS SELECT 
 1 AS `id`,
 1 AS `instance_id`,
 1 AS `job_type`,
 1 AS `job_id`,
 1 AS `group_id`,
 1 AS `job_json`,
 1 AS `client`,
 1 AS `project`,
 1 AS `timestamp`,
 1 AS `host`,
 1 AS `component`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `latest_executed_jobs`
--

DROP TABLE IF EXISTS `latest_executed_jobs`;
/*!50001 DROP VIEW IF EXISTS `latest_executed_jobs`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `latest_executed_jobs` AS SELECT 
 1 AS `instance_id`,
 1 AS `job_type`,
 1 AS `job_id`,
 1 AS `group_id`,
 1 AS `state`,
 1 AS `sub_state`,
 1 AS `job_json`,
 1 AS `client`,
 1 AS `project`,
 1 AS `worker`,
 1 AS `start_timestamp`,
 1 AS `attempts`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `component` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `level` varchar(25) NOT NULL,
  `data` text,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=210091 DEFAULT CHARSET=utf8;
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
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `bc-jobs-trigger` AFTER INSERT ON `tenx_breadcrumb_database`.`logs` FOR EACH ROW BEGIN

    

	DECLARE QID VARCHAR(50);

	SET QID = (SELECT JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobId')));

	

	IF NEW.TYPE = 'queue-enter'

	THEN

	INSERT INTO bc_jobs (

		group_id,

		job_id, 

		job_entry_timestamp, 

		job_exit_timestamp, 

		timezone,

		job_uid, 

		job_status, 

		job_json, 

		host,

		client,

		project

	) VALUES (

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.groupId')), 

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobId')), 

		NEW.TIMESTAMP, 

		NEW.TIMESTAMP, 

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.timezone')),

		NEW.UID, 

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.status')), 

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobData')), 

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.host')),

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.client')),

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.project'))

	);

	

	ELSEIF NEW.TYPE IN ('queue-idempotent', 'queue-premature-exit-with-no-error', 'queue-premature-exit-with-error', 'queue-exit')

	THEN



		UPDATE `bc_jobs` SET `job_exit_timestamp`=NEW.TIMESTAMP , `job_status` = JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.status'))

		WHERE `job_id` = QID AND `job_uid` = NEW.UID;



	END IF;



    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `bc-queue-trigger` AFTER INSERT ON `tenx_breadcrumb_database`.`logs` FOR EACH ROW BEGIN

    

	

	DECLARE QID VARCHAR(50);

	SET QID = (SELECT JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobId')));

    

	IF NEW.TYPE = 'queue-enter'

	THEN

	INSERT INTO bc_queue (

		specific_wf_id,

		specific_q_id, 

		q_entry_timestamp, 

		q_exit_timestamp, 

		q_msg_id, 

		q_status, 

		q_json, 

		q_ipaddress,

		client,

		project

	) VALUES (

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.groupId')), 

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobId')), 

		NEW.TIMESTAMP, 

		NEW.TIMESTAMP, 

		NEW.UID, 

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.status')), 

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobData')), 

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.host')),

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.client')),

		JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.project'))

	);

	

	ELSEIF NEW.TYPE IN ('queue-idempotent', 'queue-premature-exit-with-no-error', 'queue-premature-exit-with-error', 'queue-exit')

	THEN



		UPDATE `bc_queue` SET `q_exit_timestamp`=NEW.TIMESTAMP , `q_status` = JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.status'))

		WHERE `specific_q_id` = QID AND `q_msg_id` = NEW.UID;



	END IF;

	

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `trg_tenx_on_backlog_added` AFTER INSERT ON `logs` 
    FOR EACH ROW BEGIN
    
    IF NEW.TYPE = 'backlog_added'
    THEN
	INSERT INTO tenx_job_submission_detals (`instance_id`,`job_type`,`job_id`,`group_id`,`job_json`,`client`,`project`,
	`timestamp`,`host`,`component`)
	VALUES(
	NEW.UID, 
	JSON_UNQUOTE(JSON_EXTRACT(JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobData')), '$.type')),
	JSON_UNQUOTE(JSON_EXTRACT(JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobData')), '$."job-id"')),
	JSON_UNQUOTE(JSON_EXTRACT(JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobData')), '$."group-id"')),
	JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobData')),
	JSON_UNQUOTE(JSON_EXTRACT(JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobData')), '$.client')),
	JSON_UNQUOTE(JSON_EXTRACT(JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.jobData')), '$.project')),
	NEW.TIMESTAMP,
	JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.host')),
	NEW.COMPONENT
	);
    
    END IF;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `trg_tenx_job_journey` AFTER INSERT ON `logs` 
    FOR EACH ROW BEGIN
    
    IF NEW.TYPE like 'backlog_%'
    THEN
	INSERT INTO tenx_job_journey (`instance_id`,`state`,`host`)
	VALUES(
	NEW.UID, 
	(SELECT id from execution_status_master where name = NEW.TYPE),
	JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.host'))
	);
    
    END IF;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `trg_tenx_job_sub_state_update` AFTER INSERT ON `logs` 
    FOR EACH ROW BEGIN
	DECLARE sub_id varchar(100);
	
	
	IF NEW.TYPE IN('queue-enter','queue-idempotent', 'queue-premature-exit-with-no-error', 'queue-premature-exit-with-error', 'queue-exit')
	THEN
	SET sub_id = (SELECT id FROM `tenx_job_submission_detals` WHERE instance_id = NEW.UID LIMIT 1);
	UPDATE tenx_jobs SET sub_state = JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.status'))
	WHERE `submit_id`=sub_id;
	END IF;
    
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `trg_tenx_system_errors` AFTER INSERT ON `logs` 
    FOR EACH ROW BEGIN
	
	DECLARE execution_row_id INT;
	IF NEW.LEVEL = 'ERROR'
	THEN
		INSERT INTO`tenx_system_errors`(`uid`,`component`,`bc_type`,`timestamp`,`host`,`exception`)
		VALUES(
		 NEW.UID,
		  NEW.COMPONENT,
		   NEW.TYPE,
		   NEW.TIMESTAMP,
		 JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.host')),
		 JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.exception'))
		);
	
	END IF;
    
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `trg_tenx_job_attempts` AFTER INSERT ON `logs` 
    FOR EACH ROW BEGIN
	
	DECLARE execution_row_id int;
	IF NEW.TYPE = 'backlog_acquired'
	THEN
		INSERT INTO `tenx_job_execution_details` (`instance_id`,`worker`,`timezone`,`start_timestamp`,`exception`)
		VALUES(
		 NEW.UID,
		 JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.worker')),
		 JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.timezone')),
		 NEW.TIMESTAMP,
		 '-'
		);
		
	ELSEIF NEW.TYPE = 'backlog_completed' or (NEW.TYPE = 'backlog_failed' OR NEW.TYPE ='step-premature-exit-with-error')
	THEN
		SET execution_row_id = (SELECT id from tenx_job_execution_details WHERE instance_id = NEW.UID ORDER BY id DESC LIMIT 1);
	
		UPDATE tenx_job_execution_details SET end_timestamp = NEW.TIMESTAMP, exception = JSON_UNQUOTE(JSON_EXTRACT(NEW.DATA, '$.exception')) 
		WHERE `instance_id` = NEW.UID AND (`id`= execution_row_id AND exception = '-');
	END IF;
    
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `trg_tenx_job_state_update` AFTER INSERT ON `logs` 
    FOR EACH ROW BEGIN
    
	DECLARE sub_id varchar(100);
	SET sub_id = (SELECT id FROM `tenx_job_submission_detals` WHERE instance_id = NEW.UID LIMIT 1);
	
    IF NEW.TYPE = 'backlog_assigned'
    THEN
		UPDATE tenx_jobs SET `state` = 105,`state_updated_at`=NEW.TIMESTAMP WHERE `submit_id` = sub_id;
		
	ELSEIF NEW.TYPE = 'backlog_reassign'
	THEN
		UPDATE tenx_jobs SET `state` = 107,`state_updated_at`=NEW.TIMESTAMP WHERE `submit_id` = sub_id;
	
	ELSEIF NEW.TYPE = 'backlog_recovered'
	THEN
		UPDATE tenx_jobs SET `state` = 102,`state_updated_at`=NEW.TIMESTAMP WHERE `submit_id` = sub_id;	
	
	ELSEIF NEW.TYPE = 'backlog_acquired'
	THEN
		UPDATE tenx_jobs SET `state` = 110,`state_updated_at`=NEW.TIMESTAMP WHERE `submit_id` = sub_id;
		
	ELSEIF NEW.TYPE = 'backlog_can_not_run'
	THEN
		UPDATE tenx_jobs SET `state` = 113,`state_updated_at`=NEW.TIMESTAMP WHERE `submit_id` = sub_id;
		
	ELSEIF NEW.TYPE = 'backlog_running'
	THEN
		UPDATE tenx_jobs SET `state` = 115,`state_updated_at`=NEW.TIMESTAMP WHERE `submit_id` = sub_id;
		
	ELSEIF NEW.TYPE = 'backlog_failed'
	THEN
		UPDATE tenx_jobs SET `state` = 120,`state_updated_at`=NEW.TIMESTAMP WHERE `submit_id` = sub_id;
		
	ELSEIF NEW.TYPE = 'backlog_completed'
	THEN
		UPDATE tenx_jobs SET `state` = 125,`state_updated_at`=NEW.TIMESTAMP WHERE `submit_id` = sub_id;
	END IF;
    
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `long_running_jobs_v`
--

DROP TABLE IF EXISTS `long_running_jobs_v`;
/*!50001 DROP VIEW IF EXISTS `long_running_jobs_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `long_running_jobs_v` AS SELECT 
 1 AS `instance_id`,
 1 AS `job_type`,
 1 AS `state`,
 1 AS `sub_state`,
 1 AS `job_id`,
 1 AS `group_id`,
 1 AS `client`,
 1 AS `project`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tenx_error_ack_master`
--

DROP TABLE IF EXISTS `tenx_error_ack_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenx_error_ack_master` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tenx_job_execution_details`
--

DROP TABLE IF EXISTS `tenx_job_execution_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenx_job_execution_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` varchar(50) NOT NULL,
  `worker` varchar(100) NOT NULL,
  `timezone` varchar(20) DEFAULT NULL,
  `start_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `exception` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18021 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tenx_job_journey`
--

DROP TABLE IF EXISTS `tenx_job_journey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenx_job_journey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` varchar(50) NOT NULL,
  `state` varchar(20) NOT NULL,
  `host` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90369 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tenx_job_submission_detals`
--

DROP TABLE IF EXISTS `tenx_job_submission_detals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenx_job_submission_detals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` varchar(50) NOT NULL,
  `job_type` varchar(50) DEFAULT NULL,
  `job_id` varchar(50) DEFAULT NULL,
  `group_id` varchar(50) DEFAULT NULL,
  `job_json` text,
  `client` varchar(500) DEFAULT NULL,
  `project` varchar(500) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `host` varchar(50) DEFAULT NULL,
  `component` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18860 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `trg_tenx_after_backlog_added` AFTER INSERT ON `tenx_job_submission_detals` 
    FOR EACH ROW BEGIN
    
    INSERT INTO `tenx_jobs` (`submit_id`,`state`,`sub_state`) VALUES (
	NEW.ID,
	101,
	NULL
	);
    
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tenx_jobs`
--

DROP TABLE IF EXISTS `tenx_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenx_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submit_id` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `sub_state` int(11) DEFAULT NULL,
  `state_updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `id` (`id`),
  KEY `fk_job_submit_and_job_state` (`submit_id`),
  KEY `fk_state` (`state`),
  CONSTRAINT `fk_job_submit_and_job_state` FOREIGN KEY (`submit_id`) REFERENCES `tenx_job_submission_detals` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_state` FOREIGN KEY (`state`) REFERENCES `execution_status_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18084 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tenx_system_errors`
--

DROP TABLE IF EXISTS `tenx_system_errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenx_system_errors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `component` varchar(50) DEFAULT NULL,
  `bc_type` varchar(50) DEFAULT NULL,
  `host` varchar(20) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  `exception` text,
  `ack` int(11) NOT NULL DEFAULT '0',
  `ack_comment` text,
  PRIMARY KEY (`id`),
  KEY `fk_err_ack_and_err` (`ack`),
  CONSTRAINT `fk_err_ack_and_err` FOREIGN KEY (`ack`) REFERENCES `tenx_error_ack_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28897 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'tenx_breadcrumb_database'
--

--
-- Dumping routines for database 'tenx_breadcrumb_database'
--
/*!50003 DROP FUNCTION IF EXISTS `last_24_hours_jobs_by_state` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  FUNCTION `last_24_hours_jobs_by_state`(st INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  

DECLARE t1 INT;

SELECT COUNT(*) into t1 FROM `last_24_hours_executed_jobs_v` WHERE `state` = st;

 RETURN t1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `last_hour_jobs_by_state` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  FUNCTION `last_hour_jobs_by_state`(st INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
SET t1 =  (SELECT COUNT(*) as completed FROM `last_hour_executed_jobs_v`  WHERE `state` =st
);
 RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `last_week_jobs_by_state` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  FUNCTION `last_week_jobs_by_state`(st INT) RETURNS int(11)
    DETERMINISTIC
BEGIN  
	DECLARE t1 INT;
SET t1 =  (SELECT COUNT(*) as completed FROM `last_week_executed_jobs_v`  WHERE `state` =st
);
 RETURN t1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `tenx_services_monitor`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenx_services_monitor` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `tenx_services_monitor`;

--
-- Table structure for table `es_host_server_details`
--

DROP TABLE IF EXISTS `es_host_server_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `es_host_server_details` (
  `server_name` varchar(100) DEFAULT NULL,
  `capacity` varchar(100) DEFAULT NULL,
  `provisioned_space` varchar(100) DEFAULT NULL,
  `free_space` varchar(100) DEFAULT NULL,
  `free_space_percentage` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_vms_memory_usage`
--

DROP TABLE IF EXISTS `es_vms_memory_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `es_vms_memory_usage` (
  `host_id` varchar(100) DEFAULT NULL,
  `Filesystem` varchar(100) DEFAULT NULL,
  `Size` varchar(100) DEFAULT NULL,
  `Used` varchar(100) DEFAULT NULL,
  `Avail` varchar(100) DEFAULT NULL,
  `Used_percent` varchar(100) DEFAULT NULL,
  `Mounted_on` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=1432 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=1227 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_difference_on_vm`
--

DROP TABLE IF EXISTS `time_difference_on_vm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_difference_on_vm` (
  `virtual_machine` varchar(50) DEFAULT NULL,
  `time_on_vm` varchar(50) DEFAULT NULL,
  `time_on_ntp_server` varchar(50) DEFAULT NULL,
  `time_difference` int(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vms`
--

DROP TABLE IF EXISTS `vms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vms` (
  `ip` varchar(50) NOT NULL,
  `vm_name` varchar(50) NOT NULL,
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'tenx_services_monitor'
--

--
-- Dumping routines for database 'tenx_services_monitor'
--
/*!50003 DROP PROCEDURE IF EXISTS `pingtransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `pingtransaction`(
	servicename VARCHAR(25),
	ip VARCHAR(15),
	pingtime INT
)
BEGIN 
	SET @num=2;
	SET @ping_id=0;
	SET @lastpingtime=NULL;
	SET @timediff=0;
	#Fetching the latest ping id and last ping details
	SELECT ping_id,last_ping_time INTO @ping_id, @lastpingtime FROM tenx_services_monitor.nprep_ping WHERE service_name=servicename AND ip_address=ip ORDER BY ping_id DESC LIMIT 1;
	IF @lastpingtime IS NULL THEN
		#insert fresh ping details for service+ip combination
		INSERT INTO  tenx_services_monitor.nprep_ping(service_name,ip_address,last_ping_time) VALUES (servicename, ip, NOW());
		ELSE		
			#get time diff between lastping and now
		    SET @timediff=(SELECT TIMESTAMPDIFF(SECOND, @lastpingtime, NOW()));
			#select  @lastpingtime as 'last ping',@timediff as 'timediff';
			IF @timediff <= (@num*pingtime) THEN
				#update last ping time
				UPDATE tenx_services_monitor.nprep_ping SET last_ping_time=NOW() WHERE ping_id=@ping_id;
			ELSE
				UPDATE tenx_services_monitor.nprep_ping SET current_ping_time=NOW(), down_time_duration=@timediff WHERE ping_id=@ping_id;
				INSERT INTO  tenx_services_monitor.nprep_ping(service_name,ip_address,last_ping_time) VALUES (servicename, ip, NOW());
			END IF;
	END IF;
	#select service_status as service_status,@run_under_supervision as run_under_supervision;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `tenx_quartz`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenx_quartz` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `tenx_quartz`;

--
-- Table structure for table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_CALENDARS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_LOCKS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_SIMPROP_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'tenx_quartz'
--

--
-- Dumping routines for database 'tenx_quartz'
--

--
-- Current Database: `tenx_breadcrumb_database`
--

USE `tenx_breadcrumb_database`;

--
-- Final view structure for view `last_24_hours_executed_jobs_v`
--

/*!50001 DROP VIEW IF EXISTS `last_24_hours_executed_jobs_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `last_24_hours_executed_jobs_v` AS (select `a`.`instance_id` AS `instance_id`,`a`.`job_type` AS `job_type`,`b`.`state` AS `state`,`b`.`sub_state` AS `sub_state`,`b`.`state_updated_at` AS `state_updated_at` from (`tenx_job_submission_detals` `a` join `tenx_jobs` `b`) where ((`a`.`id` = `b`.`submit_id`) and (`b`.`state_updated_at` > (now() - interval 24 hour)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `last_24_hours_submitted_jobs_v`
--

/*!50001 DROP VIEW IF EXISTS `last_24_hours_submitted_jobs_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `last_24_hours_submitted_jobs_v` AS (select `tenx_job_submission_detals`.`id` AS `id`,`tenx_job_submission_detals`.`instance_id` AS `instance_id`,`tenx_job_submission_detals`.`job_type` AS `job_type`,`tenx_job_submission_detals`.`job_id` AS `job_id`,`tenx_job_submission_detals`.`group_id` AS `group_id`,`tenx_job_submission_detals`.`job_json` AS `job_json`,`tenx_job_submission_detals`.`client` AS `client`,`tenx_job_submission_detals`.`project` AS `project`,`tenx_job_submission_detals`.`timestamp` AS `timestamp`,`tenx_job_submission_detals`.`host` AS `host`,`tenx_job_submission_detals`.`component` AS `component` from `tenx_job_submission_detals` where (`tenx_job_submission_detals`.`timestamp` > (now() - interval 24 hour))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `last_hour_executed_jobs_v`
--

/*!50001 DROP VIEW IF EXISTS `last_hour_executed_jobs_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `last_hour_executed_jobs_v` AS (select `a`.`instance_id` AS `instance_id`,`a`.`job_type` AS `job_type`,`b`.`state` AS `state`,`b`.`sub_state` AS `sub_state`,`b`.`state_updated_at` AS `state_updated_at` from (`tenx_job_submission_detals` `a` join `tenx_jobs` `b`) where ((`a`.`id` = `b`.`submit_id`) and (`b`.`state_updated_at` > (now() - interval 1 hour)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `last_hour_submitted_jobs_v`
--

/*!50001 DROP VIEW IF EXISTS `last_hour_submitted_jobs_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `last_hour_submitted_jobs_v` AS (select `tenx_job_submission_detals`.`id` AS `id`,`tenx_job_submission_detals`.`instance_id` AS `instance_id`,`tenx_job_submission_detals`.`job_type` AS `job_type`,`tenx_job_submission_detals`.`job_id` AS `job_id`,`tenx_job_submission_detals`.`group_id` AS `group_id`,`tenx_job_submission_detals`.`job_json` AS `job_json`,`tenx_job_submission_detals`.`client` AS `client`,`tenx_job_submission_detals`.`project` AS `project`,`tenx_job_submission_detals`.`timestamp` AS `timestamp`,`tenx_job_submission_detals`.`host` AS `host`,`tenx_job_submission_detals`.`component` AS `component` from `tenx_job_submission_detals` where (`tenx_job_submission_detals`.`timestamp` > (now() - interval 1 hour))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `last_week_executed_jobs_v`
--

/*!50001 DROP VIEW IF EXISTS `last_week_executed_jobs_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `last_week_executed_jobs_v` AS (select `a`.`instance_id` AS `instance_id`,`a`.`job_type` AS `job_type`,`b`.`state` AS `state`,`b`.`sub_state` AS `sub_state`,`b`.`state_updated_at` AS `state_updated_at` from (`tenx_job_submission_detals` `a` join `tenx_jobs` `b`) where ((`a`.`id` = `b`.`submit_id`) and (`b`.`state_updated_at` > (now() - interval 7 day)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `last_week_submitted_jobs_v`
--

/*!50001 DROP VIEW IF EXISTS `last_week_submitted_jobs_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `last_week_submitted_jobs_v` AS (select `tenx_job_submission_detals`.`id` AS `id`,`tenx_job_submission_detals`.`instance_id` AS `instance_id`,`tenx_job_submission_detals`.`job_type` AS `job_type`,`tenx_job_submission_detals`.`job_id` AS `job_id`,`tenx_job_submission_detals`.`group_id` AS `group_id`,`tenx_job_submission_detals`.`job_json` AS `job_json`,`tenx_job_submission_detals`.`client` AS `client`,`tenx_job_submission_detals`.`project` AS `project`,`tenx_job_submission_detals`.`timestamp` AS `timestamp`,`tenx_job_submission_detals`.`host` AS `host`,`tenx_job_submission_detals`.`component` AS `component` from `tenx_job_submission_detals` where (`tenx_job_submission_detals`.`timestamp` > (now() - interval 7 day))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `latest_executed_jobs`
--

/*!50001 DROP VIEW IF EXISTS `latest_executed_jobs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `latest_executed_jobs` AS (select `a`.`instance_id` AS `instance_id`,`a`.`job_type` AS `job_type`,`a`.`job_id` AS `job_id`,`a`.`group_id` AS `group_id`,`a`.`state` AS `state`,`a`.`sub_state` AS `sub_state`,`a`.`job_json` AS `job_json`,`a`.`client` AS `client`,`a`.`project` AS `project`,`b`.`worker` AS `worker`,`b`.`start_timestamp` AS `start_timestamp`,`b`.`COUNT(*)` AS `attempts` from (((select `p`.`instance_id` AS `instance_id`,`p`.`job_type` AS `job_type`,`p`.`job_id` AS `job_id`,`p`.`group_id` AS `group_id`,`q`.`state` AS `state`,`q`.`sub_state` AS `sub_state`,`p`.`job_json` AS `job_json`,`p`.`client` AS `client`,`p`.`project` AS `project` from (`tenx_breadcrumb_database`.`tenx_job_submission_detals` `p` join `tenx_breadcrumb_database`.`tenx_jobs` `q`) where (`p`.`id` = `q`.`submit_id`))) `a` join (select `tenx_breadcrumb_database`.`tenx_job_execution_details`.`instance_id` AS `instance_id`,`tenx_breadcrumb_database`.`tenx_job_execution_details`.`worker` AS `worker`,max(`tenx_breadcrumb_database`.`tenx_job_execution_details`.`start_timestamp`) AS `start_timestamp`,count(0) AS `COUNT(*)` from `tenx_breadcrumb_database`.`tenx_job_execution_details` group by `tenx_breadcrumb_database`.`tenx_job_execution_details`.`instance_id`,`tenx_breadcrumb_database`.`tenx_job_execution_details`.`worker`) `b` on((`a`.`instance_id` = `b`.`instance_id`))) order by `b`.`start_timestamp` desc) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `long_running_jobs_v`
--

/*!50001 DROP VIEW IF EXISTS `long_running_jobs_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `long_running_jobs_v` AS (select `a`.`instance_id` AS `instance_id`,`a`.`job_type` AS `job_type`,`b`.`state` AS `state`,`b`.`sub_state` AS `sub_state`,`a`.`job_id` AS `job_id`,`a`.`group_id` AS `group_id`,`a`.`client` AS `client`,`a`.`project` AS `project` from (`tenx_job_submission_detals` `a` join `tenx_jobs` `b`) where ((`a`.`id` = `b`.`submit_id`) and (`a`.`job_type` like 'channel%'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Current Database: `tenx_services_monitor`
--

USE `tenx_services_monitor`;

--
-- Current Database: `tenx_quartz`
--

USE `tenx_quartz`;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-15 11:51:25

USE `tenx_breadcrumb_database`;

INSERT INTO `tenx_error_ack_master` VALUES (0,'pending'),(1,'ignore'),(2,'addressed');

INSERT INTO `execution_status_master` VALUES (10,'Running'),(33,'Idempotent_Exit'),(66,'Premature_Exit_Errors'),(98,'Premature_Exit_No_Errors'),(99,'Successful'),(101,'backlog_added'),(102,'backlog_recovered'),(105,'backlog_assigned'),(107,'backlog_reassign'),(110,'backlog_acquired'),(113,'backlog_can_not_run'),(115,'backlog_running'),(120,'backlog_failed'),(125,'backlog_completed');

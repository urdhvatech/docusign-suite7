-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: docusign-suite7
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `industry` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `annual_revenue` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_fax` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rating` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_office` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_alternate` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ownership` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `employees` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ticker_symbol` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sic_code` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `campaign_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_accnt_id_del` (`id`,`deleted`),
  KEY `idx_accnt_name_del` (`name`,`deleted`),
  KEY `idx_accnt_assigned_del` (`deleted`,`assigned_user_id`),
  KEY `idx_accnt_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_audit`
--

DROP TABLE IF EXISTS `accounts_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_accounts_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_audit`
--

LOCK TABLES `accounts_audit` WRITE;
/*!40000 ALTER TABLE `accounts_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_bugs`
--

DROP TABLE IF EXISTS `accounts_bugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_bugs` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `account_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bug_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_acc_bug_acc` (`account_id`),
  KEY `idx_acc_bug_bug` (`bug_id`),
  KEY `idx_account_bug` (`account_id`,`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_bugs`
--

LOCK TABLES `accounts_bugs` WRITE;
/*!40000 ALTER TABLE `accounts_bugs` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_bugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_cases`
--

DROP TABLE IF EXISTS `accounts_cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_cases` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `account_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `case_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_acc_case_acc` (`account_id`),
  KEY `idx_acc_acc_case` (`case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_cases`
--

LOCK TABLES `accounts_cases` WRITE;
/*!40000 ALTER TABLE `accounts_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_contacts`
--

DROP TABLE IF EXISTS `accounts_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_contacts` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `contact_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_account_contact` (`account_id`,`contact_id`),
  KEY `idx_contid_del_accid` (`contact_id`,`deleted`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_contacts`
--

LOCK TABLES `accounts_contacts` WRITE;
/*!40000 ALTER TABLE `accounts_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_cstm`
--

DROP TABLE IF EXISTS `accounts_cstm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_cstm` (
  `id_c` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `jjwg_maps_lng_c` float(11,8) DEFAULT '0.00000000',
  `jjwg_maps_lat_c` float(10,8) DEFAULT '0.00000000',
  `jjwg_maps_geocode_status_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_address_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_cstm`
--

LOCK TABLES `accounts_cstm` WRITE;
/*!40000 ALTER TABLE `accounts_cstm` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_cstm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_opportunities`
--

DROP TABLE IF EXISTS `accounts_opportunities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_opportunities` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `opportunity_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_account_opportunity` (`account_id`,`opportunity_id`),
  KEY `idx_oppid_del_accid` (`opportunity_id`,`deleted`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_opportunities`
--

LOCK TABLES `accounts_opportunities` WRITE;
/*!40000 ALTER TABLE `accounts_opportunities` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_opportunities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_actions`
--

DROP TABLE IF EXISTS `acl_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acl_actions` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `acltype` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aclaccess` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aclaction_id_del` (`id`,`deleted`),
  KEY `idx_category_name` (`category`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_actions`
--

LOCK TABLES `acl_actions` WRITE;
/*!40000 ALTER TABLE `acl_actions` DISABLE KEYS */;
INSERT INTO `acl_actions` VALUES ('02c67a1d-e140-4e2f-aa6d-875d18560807','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Tasks','module',90,0),('02d096ef-245f-4876-8287-be5859e53b9e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Emails','module',90,0),('03e52f57-0289-4b17-987c-ee2b5791af1b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Calls','module',90,0),('051d523e-d968-4296-b933-bddbcd21e639','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Calls_Reschedule','module',90,0),('056f474b-0a08-4313-9f16-af1201e1c596','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Notes','module',90,0),('061a52f6-7fe6-44df-b529-91924d941bb4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','SurveyResponses','module',89,0),('066322cc-1f2a-4e4f-bccb-bd9f5cc113a8','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','jjwg_Markers','module',90,0),('069094f1-54b3-4570-85e8-13215a889eaf','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Opportunities','module',90,0),('06dd9349-2773-4603-8b0c-d05b3bfbce6f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','jjwg_Markers','module',90,0),('072b7711-ee40-47f1-aeb9-41bd88b38c65','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Contacts','module',90,0),('086f4683-d376-492d-a92e-96ecdd3ad390','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','ProspectLists','module',90,0),('08727f39-0771-466b-875b-27ffcef5fc3c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','jjwg_Markers','module',89,0),('08b62b57-6d0d-4b93-8c09-56c89814fba9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AM_ProjectTemplates','module',89,0),('08c16a49-85b7-479b-ab1b-307858ce6b60','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','jjwg_Maps','module',90,0),('08c212b6-53fd-46fc-bd9e-8ecfb3ac93d4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Project','module',90,0),('08e8152f-ff8b-4d1a-bfa2-c1302fdce275','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Campaigns','module',90,0),('08fa7e90-c0f0-4934-91fd-f288500e2d51','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','jjwg_Maps','module',89,0),('0a8759c3-a811-4aac-bc67-542f99b3e5d8','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','ProjectTask','module',89,0),('0abe06d4-d731-44cf-818f-ac1c4fe3e8a1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Project','module',90,0),('0ac45e4e-c203-4b9c-a3b9-975955084bcc','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Spots','module',89,0),('0b08278a-28e6-46fb-87a6-2e8aed9baecd','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Contacts','module',90,0),('0c3fef1b-61bf-453f-85fc-1c3a4295c69b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','SecurityGroups','module',90,0),('0cc64ef9-52bd-4d7c-9097-0bf00780a0bb','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','jjwg_Address_Cache','module',90,0),('0d182c4c-8e76-433f-9754-ebedca12f695','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Project','module',90,0),('0d42865b-3663-4740-a5bd-18320b32230e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOR_Reports','module',90,0),('0d7073c2-11ee-45ab-b5ad-eb26bab9ef8f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','SurveyQuestionOptions','module',89,0),('0ec5a6b3-0927-44ac-9e36-36b98812dd01','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','jjwg_Areas','module',90,0),('0eeed66c-5b6e-40e9-860a-c823b6088573','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Accounts','module',90,0),('1243e336-464d-4390-a062-46c76271db2b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOD_Index','module',90,0),('125a0e41-7a4f-48ab-8bbb-2111a2d89bc6','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','EmailMarketing','module',90,0),('1262dd8c-83a2-4ef4-bc7d-df1d863be7ce','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Cases','module',90,0),('12ebdd66-330f-4346-b8e5-0fa8cf977744','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOK_Knowledge_Base_Categories','module',90,0),('15161f86-d708-40fd-931a-236271bd89a0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','SurveyQuestions','module',90,0),('15c0ab09-167d-4efe-bff1-6d7c57ef2b7d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOR_Scheduled_Reports','module',90,0),('15d07ba5-7827-454a-b8c7-b47e55d50c99','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOK_Knowledge_Base_Categories','module',89,0),('169e2578-ee8b-48d9-9705-af33089ed79a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AM_TaskTemplates','module',90,0),('175575bf-3b76-48d5-8df6-ae277daeb079','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Cases','module',90,0),('17718fb9-06fb-4953-b046-7473a69760d5','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','SurveyResponses','module',90,0),('18b24b02-7321-4412-bb73-ab236ce726c4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Accounts','module',90,0),('1b94f398-ba29-4370-8ad8-75a9be7e3e9e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','CalendarAccount','module',90,0),('1bd60913-64f9-4831-a6a5-2d5f5d6983d4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOK_Knowledge_Base_Categories','module',90,0),('1cadf950-bd5e-4da3-9456-80e5661cf805','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','OutboundEmailAccounts','module',90,0),('1d2398ae-fe3f-41cb-a1ce-3d9dd43416ae','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOS_PDF_Templates','module',90,0),('1d33a293-bdc9-4ea8-aa13-edf1c7b96b24','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','SurveyQuestionOptions','module',90,0),('1d3acafe-eb87-4e36-9713-c5fe9ae8fc4f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','jjwg_Markers','module',90,0),('1d87028e-41bb-42ab-882f-ebfce6d3082b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','ProjectTask','module',90,0),('1da2b39c-a752-485e-894d-f204b2e81152','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOW_Processed','module',89,0),('1ed6b160-7855-40a9-a283-cc9f3d7da745','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOS_Contracts','module',89,0),('1edea374-fcd5-4a0c-a415-88d6d53dc438','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','TemplateSectionLine','module',90,0),('1f296310-7666-4455-bb68-d7de7173a4ff','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','ProspectLists','module',90,0),('1fd3aecc-bc73-4a38-b13f-280d0e41b6cb','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Surveys','module',89,0),('20075702-f487-4881-8c6c-c55febfcbddd','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','EAPM','module',90,0),('2090f66b-d857-4ee2-a3f6-d199961641f1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','EAPM','module',90,0),('2095683a-7900-4a88-a9df-1a26af4167db','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Cases','module',90,0),('22a93788-fbee-4e24-9ecc-77dea7f59d8c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','jjwg_Areas','module',90,0),('22a9f259-9952-46c4-a76d-245da4080bad','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','TemplateSectionLine','module',90,0),('253ea161-91b3-4935-8fb7-2cf5ec91ce43','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOW_WorkFlow','module',90,0),('25958503-6696-4f41-9823-ece97d48e2f1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Documents','module',90,0),('25bf7441-086c-46ae-a01f-124d8bd5229b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','jjwg_Areas','module',90,0),('263ec89e-8f67-4494-b280-a13afca5197e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOK_KnowledgeBase','module',90,0),('269f6574-589b-4631-93e7-72e70bd89a57','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Notes','module',89,0),('26b229f2-1801-497e-a0be-ca3728771292','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOR_Scheduled_Reports','module',90,0),('27223e4b-9d3d-4ad3-b714-6e17ae4b65d5','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Leads','module',90,0),('272f72ba-ebb7-4ab1-9463-f50d0f18295a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Leads','module',90,0),('27aaa1c5-2875-474c-91b2-8756977bc9e3','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOP_Case_Events','module',90,0),('27d74bf4-32ac-4368-9923-95da558a722f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','ProspectLists','module',90,0),('27d85e4c-3d5f-46d7-b356-bd26f64adac0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Users','module',90,0),('2869d8b2-a562-43e5-9ba2-f4fd52fea026','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOR_Reports','module',89,0),('286a2b40-9caa-408c-bc3e-45f15e3cb0af','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOK_Knowledge_Base_Categories','module',90,0),('29868933-efa7-4163-8b3a-14dbe78f41d1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','ExternalOAuthConnection','module',90,0),('2a78bcbd-3f4f-4e7d-a83c-77c6f480feec','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','ExternalOAuthConnection','module',90,0),('2b40d7b5-cbd2-4f5e-84f5-f69d463d903b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Campaigns','module',90,0),('2b4be04a-c2a4-427f-943e-813f551e52b5','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','EmailTemplates','module',90,0),('2bbeae95-8aeb-45c1-8051-963a2f823a44','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','OutboundEmailAccounts','module',90,0),('2c4fff8d-4b1d-4052-b195-9d82b4d56c35','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','CalendarAccount','module',90,0),('2d816163-219c-4d3f-bc90-a98fcfb181b1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','InboundEmail','module',90,0),('2db91c84-3d09-4652-8ef5-d0f0597d9535','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Calls','module',90,0),('2dead14b-777c-4da8-b9ea-3b0dd9edf6dc','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','jjwg_Areas','module',90,0),('2f0456f3-781a-4d63-82ea-8b0a38806ab5','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOW_WorkFlow','module',90,0),('2faa83c4-eebc-4f94-8aa3-52eaecfaeb65','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOP_Case_Updates','module',90,0),('2fc4369e-47fa-4fa4-bf76-f8fe07f9d338','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','jjwg_Address_Cache','module',90,0),('2fd35c1f-4f92-4d2e-a62a-624bb90b782e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Leads','module',90,0),('2fd6abf9-8247-475b-b976-e0cfa96058ff','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Calls','module',90,0),('302d3104-0c71-43ce-91e1-dbe8a310bd54','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','ProjectTask','module',90,0),('30360eb1-34ea-4fec-88d2-74ee52846ee9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Accounts','module',90,0),('31f9cc44-c8d6-460a-a159-f5f71ff2a250','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOW_WorkFlow','module',90,0),('323ed5d3-cfff-4c44-892d-30ab59309a1c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','FP_events','module',90,0),('32886f6e-8674-49e3-a602-e4c1cd48aa4a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','jjwg_Address_Cache','module',90,0),('32ab0197-c1e2-47b2-b50c-de24fe571cd5','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Prospects','module',90,0),('32acde73-fd9f-4882-ab81-12c53df77e8d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','ExternalOAuthProvider','module',90,0),('3390c399-7a60-44ca-8b76-e5e7f9cf9c24','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','jjwg_Areas','module',89,0),('34fdd17c-42b8-42c8-84ef-2b13d9996cfb','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Spots','module',90,0),('359d1048-4b63-49a3-9830-b851eede5ead','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Leads','module',90,0),('35a7a61e-0b9b-4295-ba6e-90a1cfe5c641','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Emails','module',90,0),('35c0171d-7734-46a4-ba9e-c1625c785c25','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Alerts','module',89,0),('37ba7876-d821-48ab-9e51-d30055d71c44','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','SurveyQuestionOptions','module',90,0),('37dc3235-75d4-4d8b-8938-ac6727fd0211','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOS_Product_Categories','module',89,0),('3a6d7aec-0aeb-4fb7-aa5e-4c03f1844dbe','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','CalendarAccount','module',89,0),('3b381897-3b54-4b5a-83b5-87891c5e5057','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Accounts','module',90,0),('3c0fa83c-1d4e-4e04-9d1c-5865091f679d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOK_KnowledgeBase','module',90,0),('3c758fdf-054a-4a4c-840e-47406d3abd31','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Notes','module',90,0),('3c7eea44-13de-4957-a4a2-d6b6e888f832','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOW_WorkFlow','module',90,0),('3d2ca720-4b3b-4bb0-9b33-4a0b50404549','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','EAPM','module',90,0),('3d3b6e04-864d-4b88-8199-062f2ca1cd4f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOS_Quotes','module',90,0),('3e20bf4c-19de-44f0-986f-b56da3332738','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Calls','module',90,0),('3f9dbdc9-56de-4cb8-9d0b-caf91bf5bec6','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Bugs','module',90,0),('3ff053c9-9feb-4cee-b95c-ea1b2e89c77a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOK_KnowledgeBase','module',90,0),('4277aff2-dfff-4619-adf8-577bcbe729f5','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOS_Products','module',90,0),('431a8e81-b756-4fa9-bdfb-285beeaa7ae0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOR_Scheduled_Reports','module',90,0),('43404f86-a540-44cd-b1be-21b0f0fdeff6','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AM_TaskTemplates','module',90,0),('436d1b90-4c35-401a-ac78-a99392793376','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Emails','module',90,0),('4376f857-ee63-483c-a7ec-6ee5a214e1f9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','EmailTemplates','module',90,0),('4425e064-a0bc-4ac3-81c9-f24ab275825e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','EAPM','module',89,0),('44322eb8-1ac4-4e23-a45d-9b34f89c3785','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOS_Invoices','module',90,0),('45754da8-e7db-43da-9e8f-a45023dde23a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','EmailMarketing','module',90,0),('46865646-6665-47c0-9624-7bc6a89d52fc','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Prospects','module',90,0),('46e1db85-267a-4a5a-bdc3-8ce8eaf6610b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOS_Invoices','module',90,0),('4853e5db-c6f2-48c2-93a5-d556af11d201','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOS_Quotes','module',89,0),('485de7c5-182a-4fca-ace5-e3d5eb5948ba','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','CalendarAccount','module',90,0),('48dd7280-34ec-49ff-bb29-24eb4c8cdda5','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','ProspectLists','module',89,0),('490d118c-5091-48e2-b93e-f2279bd92279','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOR_Reports','module',90,0),('4940f02a-6747-4043-8552-ec1eb81633e9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOW_Processed','module',90,0),('49873943-e780-4ad2-8f57-2ab6ef908bac','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Cases','module',90,0),('4987918b-176c-4920-beeb-a71a632c79ba','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','jjwg_Maps','module',90,0),('49fb3ca5-2c22-4fc8-9ccd-da15f7374f95','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','SurveyQuestions','module',90,0),('4a0ca51f-9d4d-419e-a7b2-a999c1b31a84','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Calls_Reschedule','module',90,0),('4a71b0e9-d88a-44bc-8bb2-1b1d498b157b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','TemplateSectionLine','module',90,0),('4abe4e84-5783-4cca-aea3-962219f5fc40','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','SurveyQuestions','module',90,0),('4b65e26b-1ee4-42cd-bab3-63607ffdfde9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Alerts','module',90,0),('4d502d64-3aa5-436d-9f63-844adb683f04','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Bugs','module',90,0),('4d8a990d-a76f-466b-9841-55d19d149faf','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','SurveyResponses','module',90,0),('4d979680-55f9-4cc5-8c21-b0b413f4d745','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Prospects','module',90,0),('4e28b02e-d0fc-4823-8e61-6789a9555916','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOS_Quotes','module',90,0),('4e609d71-32ef-4c9c-a657-f4124ba6d2f6','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Users','module',90,0),('4ee5c8bf-f237-4435-b19c-26e6dac77050','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Emails','module',90,0),('4ff31eb8-94da-443b-972b-40b36f82708b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOP_Case_Events','module',90,0),('504e38d9-6034-4a0c-b3d6-04faa5570770','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','SurveyQuestionOptions','module',90,0),('50535cc5-735d-4c99-a9d1-5d6f03d4e63e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','ExternalOAuthProvider','module',90,0),('50664415-99f8-4109-b251-3dc7a5c85a6b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOS_Contracts','module',90,0),('506db6f0-e2d8-4fb9-b190-d85c504c6048','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Documents','module',89,0),('510a5a4c-dc16-4405-bfec-50b12630e187','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','EmailMarketing','module',90,0),('5140312d-fc85-4f3b-b0e7-0af84d68854e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOW_Processed','module',90,0),('51ca57a2-0542-4886-a4e2-bf365f83fc21','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Tasks','module',90,0),('51f2f8a7-09d3-40fd-a106-90be635a440b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOS_Products','module',90,0),('52093825-e631-42a5-a8df-1c1ea22540be','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','FP_Event_Locations','module',90,0),('5286ba86-db47-4c8d-a69a-08e8d5672af0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Leads','module',90,0),('52d365f5-205b-4ce5-b75a-34ea06cb148f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Spots','module',90,0),('52e02128-85f2-4bd9-9ae6-759e38eaccfa','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOP_Case_Events','module',90,0),('531a97b4-0289-471f-8901-b1d862ef58a1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','ProjectTask','module',90,0),('549c42bb-078f-45e4-8b21-91aad832948e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOR_Reports','module',90,0),('54d0c534-05fc-4a26-be36-27ddf315ecb1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','EmailMarketing','module',90,0),('555ac75b-171e-4b77-a6d8-d5974f72d175','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOW_Processed','module',90,0),('56bc7ba0-96e7-4d67-a115-b97805013f3b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Project','module',90,0),('57aa46cd-0ddc-4de8-b2e6-03a4493c4523','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','ExternalOAuthProvider','module',90,0),('57e81327-7180-418c-8319-f887a97f50fb','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Calls_Reschedule','module',90,0),('58048c97-8a23-4deb-9ac6-7a137c009fe8','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','ExternalOAuthConnection','module',90,0),('59421f5c-0da6-4d0b-8fc0-9339fd05be97','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','CalendarAccount','module',90,0),('59e19817-3850-47ff-bb65-d6f6a3588a53','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Accounts','module',89,0),('59f55237-5c7a-4991-b8a6-eb0469f53285','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Opportunities','module',89,0),('5a4a9302-5d32-4b76-a03a-ad06243c1b69','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Calls_Reschedule','module',90,0),('5ad2d690-bf33-4760-a277-c2be2c19ec47','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','SecurityGroups','module',90,0),('5afe9c7c-d0dd-46f7-8ec9-07bb4314a60c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','ExternalOAuthProvider','module',89,0),('5b16831d-6e95-4996-9048-e3ad5daac54b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOD_IndexEvent','module',89,0),('5b8e2e8c-7ae0-4956-9d6e-bc195aa9ed3f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Users','module',90,0),('5bf32ea1-256d-4a33-a862-c8175f4b56d1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','jjwg_Markers','module',90,0),('5c00756b-9845-4cc2-b25f-9533a4bb8223','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Emails','module',89,0),('5c153e74-712e-46fb-84b7-5e2f84625ef4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOW_Processed','module',90,0),('5cec775f-dae1-4d60-b4a4-4faaa3cec132','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','jjwg_Areas','module',90,0),('5d310bba-f8e5-4944-beb2-c80e291f22bf','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','FP_Event_Locations','module',90,0),('5d3f7152-216e-4d32-92fe-f909b8470880','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Campaigns','module',89,0),('5d7d963e-5caf-4666-953d-fcd9332b4c70','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOS_Invoices','module',90,0),('5d9ce525-7cdf-48ef-8fef-cc6be4c64b81','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Prospects','module',90,0),('5df93ed3-8114-45ef-9244-f9b5a4912eb0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOS_PDF_Templates','module',90,0),('5ee161da-8032-48d2-b8b2-c805792d959c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','jjwg_Markers','module',90,0),('6154f2c1-3d2b-4959-b40f-7c57535d92ab','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOP_Case_Updates','module',90,0),('62083cde-a0fe-4957-89ba-30f62ea6633e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOS_Product_Categories','module',90,0),('62352ee4-1051-4449-85e6-f6e81ef3520d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','jjwg_Address_Cache','module',90,0),('624ad833-85bc-4a41-a64e-115e6c1bf58f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOS_PDF_Templates','module',90,0),('62e25f7d-9bc6-4a3c-b582-fa58c02a5598','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','OutboundEmailAccounts','module',90,0),('6334435f-a669-4f41-a8da-117e91a6d68f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Notes','module',90,0),('633d1779-f019-4e6d-8535-be7842c4dfa9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Cases','module',90,0),('63607e26-5151-4dc9-8d40-66dbcb599f90','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Notes','module',90,0),('6380fc6b-4511-4572-8187-c043ee7f6fae','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOS_Products','module',90,0),('64ef86ce-7fd8-4b82-8c29-753c50f47abf','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','FP_Event_Locations','module',89,0),('666bcf1f-d24b-4c98-a580-cbe2b44d7f5f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Documents','module',90,0),('667c6595-c1f9-4f37-a41d-c169640ad706','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Tasks','module',90,0),('66c3d235-d121-481f-a1d4-aa1b11bd3fe9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','EmailTemplates','module',90,0),('6714dabf-ba64-4b78-ab34-8c80a5b379b1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOS_PDF_Templates','module',90,0),('6719b7bb-4334-4363-b193-a87d1015f816','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Meetings','module',90,0),('677d44f1-edca-4405-87d1-61d24395ea4c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','SecurityGroups','module',90,0),('67cc645e-b71a-462b-9014-db356dff16cb','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','TemplateSectionLine','module',89,0),('680d6045-ef46-4a64-b3fc-ec3a222e2e85','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','ProjectTask','module',90,0),('6840a49f-fbae-4536-88c2-7a54e5f019b8','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Meetings','module',90,0),('69238691-1e50-48cc-85d2-a556f11aaee6','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOS_Contracts','module',90,0),('69372907-06f5-4b83-9b46-b141646cb4b9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','TemplateSectionLine','module',90,0),('697883c3-09aa-4eeb-9620-83272f23b521','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','SecurityGroups','module',90,0),('697bf772-1c13-4865-9155-b16585c719ac','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Calls_Reschedule','module',90,0),('6aa24b88-f9b2-431f-b6f4-514e35796dac','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','OutboundEmailAccounts','module',89,0),('6b016f19-eac1-49e5-a0e7-4adf5911ccd0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Meetings','module',89,0),('6b09ea94-2c6f-4eb9-bac3-7ee011040342','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Surveys','module',90,0),('6b1cd380-c129-46b6-8a41-f8aae3975193','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AM_ProjectTemplates','module',90,0),('6b5f30dc-2900-492a-98b5-7be3dd2b66f8','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','TemplateSectionLine','module',90,0),('6b679ce1-f807-4709-83c0-76a2b6b8f2da','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Campaigns','module',90,0),('6d71675e-4753-4f67-87da-3eadf5f93e85','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AM_ProjectTemplates','module',90,0),('6dcacec8-adbe-4613-9aff-a472f0c10877','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','jjwg_Maps','module',90,0),('6df11478-c812-497a-9446-2ff6c0cb35f3','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','jjwg_Address_Cache','module',90,0),('6e25ae95-c2cb-4b1f-a0d4-772de2e507dd','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOR_Reports','module',90,0),('6ea11742-02c2-43cf-bd6c-2b933c91bb43','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Contacts','module',90,0),('6eced59d-7371-40d0-b192-4336fb5a46b3','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Documents','module',90,0),('6f69b228-ae1f-4917-81a5-673e454eefc0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','OutboundEmailAccounts','module',90,0),('6f6b3998-d976-4ec5-8d81-b57d00f5d0a1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Tasks','module',90,0),('70b3d167-d5dd-446b-8e46-33e4f1b7c499','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','CalendarAccount','module',90,0),('70fd0bc8-799e-4254-9749-17eb29812e79','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOW_Processed','module',90,0),('716e92fe-e880-4960-b702-1a414cf2f09a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Documents','module',90,0),('719a94bf-abf7-4cfe-8ca0-fdc3ae23c316','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Prospects','module',89,0),('7248d90d-ed19-4927-88f7-e2f2fb217b29','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','TemplateSectionLine','module',90,0),('74583962-5365-4545-ab50-3727fe59f4fd','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Leads','module',90,0),('74955af5-37e6-428a-83a6-074d93e2926c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Campaigns','module',90,0),('7524947d-96ef-404b-8593-2121dd44ff73','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOS_Products','module',89,0),('7614067d-7481-4c69-b4ba-e2d928c5dc8e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOP_Case_Events','module',90,0),('76a1c240-7641-48f3-8194-bffb561120d2','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOD_Index','module',90,0),('770e040f-5608-454c-a56c-6368c6e858e9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','InboundEmail','module',90,0),('77d822c6-8b2f-4b75-a1b3-f055d0b22a4a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','CalendarAccount','module',90,0),('78d55601-7eee-4d96-a533-bbfbb266aab0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','EmailMarketing','module',90,0),('7a60e9a7-9d5a-4402-8863-42ea9dcf9ab9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AM_TaskTemplates','module',90,0),('7b3bc6ed-7f5b-483d-b793-711b5d7593fe','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','ProspectLists','module',90,0),('7c139345-f389-4298-923a-6f2950aa0ac9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Meetings','module',90,0),('7c899a05-dec0-429f-ae89-6e10ce5ea796','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOK_Knowledge_Base_Categories','module',90,0),('7e0f51a7-7158-464c-a792-d68bb03ed6d1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Cases','module',90,0),('7eb53ad4-1d16-4616-a603-2f2d62382c9d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','SurveyQuestionResponses','module',90,0),('7fbd2100-f6f9-40bd-a58e-c2129d93659b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOS_Contracts','module',90,0),('80449a0b-eeac-42f6-b271-69171504d413','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOS_Products','module',90,0),('8094ff92-8623-4c16-ad27-bd06bd3fb373','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOS_Product_Categories','module',90,0),('81081720-688a-4ec9-a0b1-5ce2af9cd74c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOS_Invoices','module',90,0),('81db9ca7-1359-4393-874f-85e9631e78ca','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','SurveyQuestionOptions','module',90,0),('81eccf72-53f2-44f4-8fee-c92e416c78ad','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOS_Products','module',90,0),('841251ae-c139-4385-b20f-acf8b4c89527','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','SurveyQuestions','module',90,0),('8516c59f-0cdc-4e02-b2c9-c820a84da86b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOR_Reports','module',90,0),('8608e49a-1f91-4861-98c3-4acb2c3d04f3','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOS_PDF_Templates','module',90,0),('8651000d-d119-4a69-b088-be25d2f759d8','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Bugs','module',90,0),('86d004a9-5732-49a1-beca-b8c16621fb5f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Tasks','module',90,0),('86fb5404-de36-4885-ba6d-24adca93d179','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Meetings','module',90,0),('8737a282-d39e-4a21-88bd-9da7d5a40c7f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Calls','module',90,0),('87607c72-a96e-4e38-904f-ca63c92089cc','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','SurveyResponses','module',90,0),('87f63031-d227-40d4-9700-75f6d7971e87','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AM_TaskTemplates','module',90,0),('88b7257d-49df-4ead-9596-aa7ab795300d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Tasks','module',89,0),('8a3057a3-4894-40b6-b33c-93a5e99ee386','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','FP_events','module',90,0),('8a53aa40-f778-4ed4-a5ea-9d51b4ab8774','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Alerts','module',90,0),('8ac32134-a15b-442d-ad5d-694ed675581c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOK_Knowledge_Base_Categories','module',90,0),('8b7dc167-669e-4b3e-990c-74f9b575613f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOS_Invoices','module',90,0),('8b9de3ef-65b2-4f03-94ed-6f05671ce2e4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOS_Contracts','module',90,0),('8c69100b-0861-417d-b874-132e637777aa','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','EAPM','module',90,0),('8d5e61bd-8ba6-4ee9-9873-2a78dddcfd0b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Meetings','module',90,0),('8d613544-646d-4c46-9355-b4582f98757b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOR_Reports','module',90,0),('8d7b62e6-76fe-4b9e-9388-78fc67d905e9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AM_TaskTemplates','module',89,0),('8e3fb0de-926e-49dd-b075-453547deb21b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Campaigns','module',90,0),('8e86cb36-1924-4f4b-8a08-82e31637e43c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOW_WorkFlow','module',89,0),('8fb97371-ba98-46b1-8adb-f2d41f27fe9b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','SurveyQuestions','module',90,0),('904dca3e-df4c-46e9-9322-34b3250e8161','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Users','module',90,0),('908cd8bc-c568-45d7-92ef-d26196206f24','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Alerts','module',90,0),('9132a933-821e-4b83-b33e-2db6fe337104','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOW_WorkFlow','module',90,0),('9256d0ac-c1d2-48d8-9692-8761ae0d46b5','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Campaigns','module',90,0),('943446dd-e96c-4e89-a443-174a74f2986a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Users','module',90,0),('94c91461-143b-4aa2-ae04-a8183450fda9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Meetings','module',90,0),('9519851a-f675-40cf-a8d5-b3f5c0712202','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','jjwg_Markers','module',90,0),('95296d93-91a7-4b59-8d39-6d3acb98c363','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','SurveyQuestions','module',90,0),('95b32e16-7db2-458d-a71d-ddb0245883ef','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Contacts','module',90,0),('95c3bb34-7087-48b7-81b2-f75df6fc079f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOP_Case_Events','module',90,0),('96379aaa-7b64-4b62-9383-f6d8587b9aaf','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','FP_events','module',90,0),('97163278-a74e-432a-bd75-36550d03abaf','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','ProspectLists','module',90,0),('97519769-7236-4314-b17c-858c8cdc36ac','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','SurveyQuestionResponses','module',90,0),('98920e50-fc3b-4051-a471-38e49ae9e51a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOP_Case_Events','module',89,0),('98affd34-ef6e-45bc-aa75-a39c8ee3937c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Contacts','module',90,0),('9901fdf3-d8fb-4518-b69b-e6c2379b5917','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Surveys','module',90,0),('99e17011-9b3b-4579-ba70-a1670af52994','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Tasks','module',90,0),('9a42f681-5c76-4556-a6ff-7b7ab37ca429','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','jjwg_Markers','module',90,0),('9c93e2e6-317c-4c02-8f3d-b915a2222872','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','SurveyResponses','module',90,0),('9db54905-70c2-4bdd-8fcf-273ed4edc66f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOW_Processed','module',90,0),('9de48756-9117-45e4-aa31-139b21626e01','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Tasks','module',90,0),('9df58aee-1b0e-4366-b80e-bdf2ce9b8bc4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOS_Contracts','module',90,0),('9e2ed314-96a9-46a2-882b-3083be3a4c83','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOP_Case_Updates','module',90,0),('9e696eec-1a08-4b19-b986-e21cf256e24f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Prospects','module',90,0),('9f21e79f-adbf-4c4b-84a7-a01d58b672a3','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','EmailTemplates','module',89,0),('a0308e62-f5af-4c7c-b7d3-e1d7ab399364','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Alerts','module',90,0),('a049aafa-fc84-4f04-9e9c-123f16a2619c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','EmailTemplates','module',90,0),('a06a29ea-12c0-4d97-960c-4c13aeabf7aa','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','SecurityGroups','module',90,0),('a0809eb6-26fe-4db9-a781-fc00b766104a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOP_Case_Updates','module',90,0),('a08d3dea-58be-4dfb-8a48-b2e35c1c1aa2','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','OutboundEmailAccounts','module',90,0),('a0ba6822-aad9-4b84-b287-7cd5fd75615d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOD_IndexEvent','module',90,0),('a16b89c7-b0d1-4627-8610-322c4aa2ed61','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','jjwg_Maps','module',90,0),('a1dae972-2a57-42d0-a0e1-7bb92fb1bfef','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOR_Scheduled_Reports','module',90,0),('a21f12f8-b08c-4dcc-bd00-f155bf192b03','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOW_Processed','module',90,0),('a245cdee-872f-4b90-a877-f173dbaa7db4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AM_ProjectTemplates','module',90,0),('a297e9ab-247d-4aea-ad8f-796e96b89f43','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOR_Scheduled_Reports','module',90,0),('a30e101d-e859-4f50-bbef-1f3bef354ddf','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Accounts','module',90,0),('a432407c-38ff-49c5-b67d-473ebe8c7d82','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','TemplateSectionLine','module',90,0),('a52fcb10-553e-4e0e-9c2c-2f57ff1a8e51','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOS_PDF_Templates','module',90,0),('a5555b71-f6ae-4b48-974e-d9db6233ca92','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOP_Case_Updates','module',90,0),('a591e17e-5c73-4b7e-b957-c9ed098ca9a4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','EmailTemplates','module',90,0),('a73385e8-0e8c-4289-91ed-7cdb52d08f89','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOD_Index','module',90,0),('a7a7e0b1-91ed-455a-a66e-b19e0bcadaff','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','ExternalOAuthProvider','module',90,0),('a7c85d02-9235-4d36-a3bc-3c44aa30f0b7','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Bugs','module',90,0),('a7cbf5e4-f90e-4a71-b255-1da6fdf11a2e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','EmailTemplates','module',90,0),('a8500777-d079-47f1-b937-83cf22329e96','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Cases','module',90,0),('a9584233-ffdb-45f3-a5e0-43abf4696767','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Cases','module',89,0),('a9be10e2-0ce4-4943-8c8d-7553072b7638','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','ProjectTask','module',90,0),('a9c2cc4a-9e82-4f7a-8a01-2e42694288d6','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Spots','module',90,0),('a9fd20e2-081c-469e-b879-1089765d5fa8','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOS_Invoices','module',90,0),('aa1a69a9-a45b-4269-8ce1-bf4eb008afb4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','SurveyQuestions','module',90,0),('aab18fd1-a619-4cde-972f-22bb7cd4740f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOW_WorkFlow','module',90,0),('aacbcbf8-e089-49ce-949e-fa2db1e7edbd','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOP_Case_Events','module',90,0),('aafc3464-67ea-43f9-8b56-9d4e667b01d7','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Accounts','module',90,0),('ab451963-2e5e-410e-b8ec-406b1aef3076','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','ProspectLists','module',90,0),('ab7ac860-f085-41bf-a925-493047e20122','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Bugs','module',89,0),('aba2342d-05d2-448e-87f1-c3285ed8d216','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOS_Product_Categories','module',90,0),('abb76406-ab22-4e4d-a507-3e2324cf6255','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','ExternalOAuthProvider','module',90,0),('ac4ac487-c803-4e6d-85f7-a7b0ef48ec94','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Documents','module',90,0),('ae42452a-46af-44ae-b9da-36ca6a7c4b84','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Bugs','module',90,0),('ae6ea5dd-c3d5-4e13-96e9-e424effc0200','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','SurveyQuestionOptions','module',90,0),('ae8fc2d2-c8e0-4922-8e50-aa492eb15764','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','EAPM','module',90,0),('ae95820b-df02-4828-a538-520a3b268a1e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','ProjectTask','module',90,0),('af367a00-d749-4947-9648-e7c92ab6ccb7','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','ExternalOAuthConnection','module',90,0),('afdb9e99-c012-4421-a26b-79e5d0d361b7','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','SurveyQuestionResponses','module',90,0),('afe878b3-2daa-47a8-8d51-f68cbb7a6fad','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Calls_Reschedule','module',90,0),('b007e9b2-00a0-4d87-b72d-0797a1f6830c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','ExternalOAuthConnection','module',90,0),('b0598704-179c-4e54-97e3-21fa4eb39f29','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOP_Case_Updates','module',89,0),('b0a10128-fc3f-47c3-ba39-d8aaa936bff6','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Users','module',90,0),('b0b93b27-112c-42a5-9a63-a99f2491359d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','InboundEmail','module',90,0),('b1785389-072e-47e2-9205-aa32f4f8c92b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Surveys','module',90,0),('b1b9f7dd-604e-4f93-bdbd-8969b564c169','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','SurveyQuestionResponses','module',90,0),('b217dd97-ba17-495b-a3d8-af5e6a8ca4f1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Calls','module',90,0),('b226b9ca-eb64-479e-9b39-62a016a3f383','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOD_IndexEvent','module',90,0),('b242d149-ce5a-4f79-99f7-cbf3d9a485cb','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOP_Case_Updates','module',90,0),('b29a91d7-6fc7-4a9b-8319-4c0e279676e4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOK_Knowledge_Base_Categories','module',90,0),('b310d57a-9a35-4956-9483-500a69d950b6','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','ProjectTask','module',90,0),('b3ae8f40-a37c-4520-8c22-2e349ed50aa2','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Alerts','module',90,0),('b4937754-b263-4a0b-a79a-736921dd6c8a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOK_KnowledgeBase','module',90,0),('b5141505-5f8f-40a8-83ba-2b2550116876','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOS_Product_Categories','module',90,0),('b676a20d-b0ab-4a30-8bf6-7d78cb09712c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOP_Case_Events','module',90,0),('b68d8b10-9cff-450e-a08e-14006823d052','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Project','module',89,0),('b70d1812-a4eb-4369-a5ec-a216e8414276','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Surveys','module',90,0),('b7604aef-a941-4699-93a9-ca7c55d6045d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','InboundEmail','module',90,0),('b8217ccc-aaba-4386-9c9a-7b90bc047fe4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOS_Products','module',90,0),('b9602838-7a7f-456c-8d2c-ec68c292106f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Documents','module',90,0),('b9604df1-407c-4e43-9170-36716522ba07','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Opportunities','module',90,0),('bb00a647-85e2-4377-bf91-a20dc425df7b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOS_Quotes','module',90,0),('bbe01636-715d-4962-8524-5a4fe2a964e0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOD_IndexEvent','module',90,0),('bc83ebeb-e2de-4a5a-8766-fddee02f6718','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Opportunities','module',90,0),('bd24f06c-2573-4c93-8f3e-859d4fe3debd','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','SurveyQuestionResponses','module',90,0),('bf3e1bad-eaaa-4cee-9326-2afca0859b7d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOD_Index','module',89,0),('bfdd28d4-4b07-4975-a93c-b242795847f3','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','jjwg_Address_Cache','module',90,0),('bfea03cd-596e-4d66-9c76-11e2a4a43e5d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Contacts','module',89,0),('c07d8d43-0a02-4769-b59d-f12675b4c705','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOR_Scheduled_Reports','module',90,0),('c08b5a3b-8b0e-4294-a44e-a3b9a4190f5e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOS_Product_Categories','module',90,0),('c0b0c6db-9944-436c-bb45-b9e2f7c7e745','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','EmailMarketing','module',89,0),('c0b79430-678a-4e2e-bf6d-5817dbb9e685','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Opportunities','module',90,0),('c0e22c55-5aed-4c43-b231-797ca66b5c2a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOD_IndexEvent','module',90,0),('c0f1ab13-8c30-4b84-a65c-5fb845b0f68d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Spots','module',90,0),('c1547141-c77c-416c-9144-13f65fd414f7','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOD_IndexEvent','module',90,0),('c22de6f8-c1f8-4378-809e-113bef87883c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOS_PDF_Templates','module',90,0),('c2ddf022-9d8c-4cea-9127-6c2c0229bec1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','jjwg_Address_Cache','module',89,0),('c3a0b8c1-726a-44c7-b924-c5a7bb76d66f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','SurveyQuestionResponses','module',89,0),('c4faefb8-7893-42ba-b55d-eb77deac3a04','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Opportunities','module',90,0),('c5225276-61dd-4007-bd05-eb6bb032a506','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Notes','module',90,0),('c66148bf-a46a-4136-beb5-72aeab194773','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOS_Invoices','module',90,0),('c69ee2ca-bbb5-4020-8b39-329a27039cdd','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOR_Reports','module',90,0),('c7541845-25d2-4c27-b091-c0a81b4f43e3','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Alerts','module',90,0),('c773d7e0-e07b-44fa-ac25-9f03be12e8e4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Calls','module',89,0),('ca163c9a-2857-41e9-b7de-b742fe2938dd','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOS_Contracts','module',90,0),('cb2b69f5-a091-4b11-b655-8c1d9045f3b2','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Contacts','module',90,0),('cb39439f-4876-4e9b-a2f9-ff01b380338b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','jjwg_Areas','module',90,0),('cbe04a7b-38fe-4529-a754-8da8362e457e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOW_WorkFlow','module',90,0),('cc5c8715-6b8a-4c9e-a337-bac823f3a464','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Alerts','module',90,0),('cceadb87-fb3f-4fb2-8af2-343e09e68633','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','OutboundEmailAccounts','module',90,0),('cd200a73-7bff-4090-826b-501276902217','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Prospects','module',90,0),('cdb0ef8a-4508-4c10-a8e8-168a61a9fecf','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Spots','module',90,0),('cdf78b1d-fbb6-48cf-82a2-1596722860dc','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Spots','module',90,0),('ce99c949-faa6-4935-b040-0340e9bf0c45','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','ExternalOAuthConnection','module',90,0),('cf3b4482-ce6a-4fe5-a445-362f382d6b56','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','FP_Event_Locations','module',90,0),('cf40441d-2ec7-4d42-a5bc-4eb54b09ff2e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Opportunities','module',90,0),('cfcdc67c-ebf0-455a-a6a9-c530303223d2','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','jjwg_Areas','module',90,0),('cff1e9b9-2b82-4d7f-b637-7ca264175d14','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AM_TaskTemplates','module',90,0),('d00fc78a-66e9-45db-9159-47b75a269afc','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','SecurityGroups','module',90,0),('d0559c48-f0c7-4e4d-9644-904240f15549','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','ExternalOAuthProvider','module',90,0),('d194477d-53e0-4b4f-a837-545238720c59','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOD_Index','module',90,0),('d23355be-7384-47db-aa56-873c373f6468','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','SurveyResponses','module',90,0),('d23b956e-ad0f-442a-82de-0788f29eb187','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Project','module',90,0),('d293a84b-e75c-4aea-8f39-7ec177008e3c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Contacts','module',90,0),('d4a7cbb1-f5cc-4805-9183-7a91f659453a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOS_Quotes','module',90,0),('d6220bee-47c6-4db2-b1df-79179d51e829','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOD_IndexEvent','module',90,0),('d62ca376-4d6c-4e56-ae50-884d7e887e8c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','FP_Event_Locations','module',90,0),('d6a31014-339b-4b2c-b17b-2cbdf205c5fd','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOS_Invoices','module',89,0),('d7771615-206b-4de7-a673-a79549837206','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOD_Index','module',90,0),('d78b988f-3350-4e9e-bbd3-db2d4cc45387','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOS_Quotes','module',90,0),('d8749788-daae-47ac-9cb6-4dad0812e4f2','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','InboundEmail','module',90,0),('d874a078-6e90-4c94-9dde-525520effd84','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Surveys','module',90,0),('d9318345-0594-40a8-93c1-cf094259674b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Spots','module',90,0),('d98dbc4b-97c2-47b1-a6e4-b485d329720d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Emails','module',90,0),('da3dd122-f14b-4251-83c1-a8c1c0a1c76b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','FP_Event_Locations','module',90,0),('da5132f5-553b-4793-a720-4e5f7aaae3d2','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','AOD_IndexEvent','module',90,0),('da67a0f3-da21-4400-88f0-14f0efaaec95','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOS_PDF_Templates','module',89,0),('dabf15f6-d4ef-4d18-b624-ffe52d14ab00','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','SurveyQuestionOptions','module',90,0),('dae51830-11a5-44e6-84d4-f2d50fca60b6','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','EAPM','module',90,0),('db043f66-77f1-45d6-a7ca-62b9a65615a3','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','jjwg_Maps','module',90,0),('db43704e-e938-43e8-bab3-f8c32105bfb0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Emails','module',90,0),('db4d739a-8f55-4320-b0d7-0435b1771cea','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AM_ProjectTemplates','module',90,0),('db5eebaf-d924-43b5-828a-f91f2d31ea38','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','EAPM','module',90,0),('dbb16b21-59ba-4132-bd1a-83e203782a5a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','InboundEmail','module',90,0),('dbf9d78a-f82e-46da-9809-0a2acd583941','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','InboundEmail','module',89,0),('dcb35f8d-dd85-4e7b-9ca4-84feb2654e7b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','FP_Event_Locations','module',90,0),('dcbfb671-ef26-4c2b-922b-b865dad26fc1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','SurveyQuestionResponses','module',90,0),('dd766e16-fc73-40da-b76f-0b7f2fc89671','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AM_ProjectTemplates','module',90,0),('ddfd1295-3360-4401-812e-f01a7b7b5694','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOR_Scheduled_Reports','module',89,0),('de80ee4c-c90d-4c3a-b85d-16504b6b4948','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','SecurityGroups','module',90,0),('e072b831-1991-431f-a915-a81dc5c1f4b4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','FP_events','module',90,0),('e3b52b30-f674-46f8-9e67-f98c8bda5784','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','ExternalOAuthConnection','module',90,0),('e4165ef0-c9b0-4a59-8823-6ca020f97fdf','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','jjwg_Maps','module',90,0),('e4546f24-d734-43aa-9b28-01a50cfa4fa9','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Surveys','module',90,0),('e4fce3bf-7b99-4c2c-a30c-272d2a62b281','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Users','module',89,0),('e597ed21-1a6b-4cb9-8c91-23399213d869','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Leads','module',89,0),('e5ded45d-4fab-4f66-ade7-6633c5163f55','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOK_Knowledge_Base_Categories','module',90,0),('e620a7e0-6a36-4320-b079-16cf62504767','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','EmailMarketing','module',90,0),('e62f7075-29b9-4e8a-8bf0-ce93ec9e6f5e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOS_Quotes','module',90,0),('e636b25a-208b-4ca0-a90e-cd49d9cea840','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','Calls_Reschedule','module',89,0),('e63b7a2b-dd9a-4005-923f-bc765c34e8ad','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','SurveyQuestionResponses','module',90,0),('e6d85db0-3521-4a74-abc3-0a1381941b84','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Notes','module',90,0),('e722b886-4827-4807-a75d-d83c0214e5c4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AM_ProjectTemplates','module',90,0),('e8316c6e-0210-4608-b81f-f918dfe59c0a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','ExternalOAuthConnection','module',89,0),('e8df275a-2ed8-431f-907a-3e737757e193','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','SurveyResponses','module',90,0),('e8e76f63-c374-43fc-8c59-b2e2c58b3e56','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','Project','module',90,0),('ea1d062c-3436-4273-88c0-77895d14f395','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','Users','module',90,0),('eabfd62a-f95c-47b2-b7e9-27cdf01a205f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','OutboundEmailAccounts','module',90,0),('eac526f5-34c6-4fd6-98e4-444270820345','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','AOK_KnowledgeBase','module',90,0),('eae6bd92-5a26-43d4-bc34-c6d99e53fa86','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','FP_events','module',90,0),('eb5e0921-c97a-44f9-9f66-23211087fa46','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOK_KnowledgeBase','module',90,0),('ec07c52f-8bc6-43bd-b029-605409b6efe0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Prospects','module',90,0),('ec4abc15-8685-4c20-9c21-14ce3107982d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Emails','module',90,0),('ec87008d-7f69-431e-bcf4-92bec0452479','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Calls','module',90,0),('ecb5b001-5e67-43c1-9a3d-ee7a9a534a2b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','FP_events','module',89,0),('ee221c6b-3411-4f13-adc4-fb2bba866303','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Surveys','module',90,0),('ee3a63da-a0b2-4d7d-951e-c87dcd04c772','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','SecurityGroups','module',89,0),('eeb53641-d89a-4dab-ab30-448dbf799d38','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Documents','module',90,0),('eed15fdb-aa73-4196-bc52-3dd7fcef75a4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','FP_events','module',90,0),('ef6deda9-b4bd-4f8a-8e7f-96200e2f7398','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','EmailMarketing','module',90,0),('ef84ba53-d8ad-4e5c-a0e3-ef6f8399fb0d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOD_Index','module',90,0),('ef922bbc-9716-4ef3-805d-8a592b98562b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','ExternalOAuthProvider','module',90,0),('efa41515-96da-429c-abe1-d2c1c34fc240','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Bugs','module',90,0),('f03c32e1-25bf-40d0-be43-158d1a806e25','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AM_ProjectTemplates','module',90,0),('f06c3ae1-6d56-4e24-80c3-44cd1790d29b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','InboundEmail','module',90,0),('f08616cd-3345-4a9b-94b8-1227f4a596b1','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Meetings','module',90,0),('f0f212b4-0777-430b-aa0e-bf58d8059226','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOR_Scheduled_Reports','module',90,0),('f26678d5-a05c-41cd-84ee-20cec030b02b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','AOK_KnowledgeBase','module',89,0),('f2d86825-4ddf-4cc5-83d5-4e5e34d21978','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','AOS_Contracts','module',90,0),('f2dc5a52-4178-4b9e-a451-197a2e3dd30d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','jjwg_Maps','module',90,0),('f2fbd7be-a37b-43ad-a97a-254ab784e21e','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOK_KnowledgeBase','module',90,0),('f302d810-4ce7-4cd7-88f3-5371b9f16b0a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AOD_Index','module',90,0),('f3ab48f9-2cbf-44cb-b089-35cc3f03a724','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','SurveyResponses','module',90,0),('f4164a82-2c2d-4ee9-acc0-c04ff0e63b5b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Notes','module',90,0),('f43e98be-c154-44ab-80ca-2ce01064c341','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','AOS_Products','module',90,0),('f5b32aed-dd7d-4404-830e-de04586a5648','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Project','module',90,0),('f63f9250-3db2-49b1-8bd9-40f0b1624cce','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','Leads','module',90,0),('f64f5631-0735-4750-8975-94a9d2c68973','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOP_Case_Updates','module',90,0),('f6881a05-f651-4e74-bd32-d5ddbdf1628f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','jjwg_Address_Cache','module',90,0),('f7c9e067-cdac-46a6-95ac-beef15a37c82','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','FP_Event_Locations','module',90,0),('f8b5c078-31d9-4c6b-8c57-002c20061473','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AM_TaskTemplates','module',90,0),('f9113201-bfb4-4966-8606-8e2818d95fc4','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','EmailTemplates','module',90,0),('f9ba2039-ec63-4d95-af88-4b0f123fc819','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Accounts','module',90,0),('f9ca388b-eba8-43d9-8bea-d957cf768793','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','edit','Calls_Reschedule','module',90,0),('f9df122c-0710-4fc2-bad7-f244616dad37','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','export','AM_TaskTemplates','module',90,0),('fa0c86b7-a163-4d14-86ea-d10f7cf65c4f','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','delete','Campaigns','module',90,0),('fb1da29d-0339-45bc-9a7b-fdb3a7f99235','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','import','Bugs','module',90,0),('fb94618c-78e7-41a4-a28f-ffb9ec3e202c','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','access','SurveyQuestions','module',89,0),('fcc847ea-6ea7-4e75-ad9a-809703265a57','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','ProspectLists','module',90,0),('fcfded3e-ea5f-463c-aba5-45dd42b579f5','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','AOS_Product_Categories','module',90,0),('fd2ec78e-a95c-4f3b-9335-990406625b72','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','Opportunities','module',90,0),('fdc09423-b7c7-40cd-bb89-1753aded54b0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','massupdate','SurveyQuestionOptions','module',90,0),('fdd6361e-35d9-47d2-9aaf-93232aeb4bcd','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','FP_events','module',90,0),('fe06fc0b-4fc4-40ef-aa14-6d3e955b286a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOS_Quotes','module',90,0),('fea87409-e97d-432e-be93-cdaf4bf576ae','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','list','CalendarAccount','module',90,0),('fecc757b-44ec-4ec1-b75a-4a4910a5896b','2026-05-12 09:18:36','2026-05-12 09:18:36','1','','view','AOS_Product_Categories','module',90,0);
/*!40000 ALTER TABLE `acl_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_roles`
--

DROP TABLE IF EXISTS `acl_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acl_roles` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aclrole_id_del` (`id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_roles`
--

LOCK TABLES `acl_roles` WRITE;
/*!40000 ALTER TABLE `acl_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_roles_actions`
--

DROP TABLE IF EXISTS `acl_roles_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acl_roles_actions` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `role_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `action_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `access_override` int DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_acl_role_id` (`role_id`),
  KEY `idx_acl_action_id` (`action_id`),
  KEY `idx_aclrole_action` (`role_id`,`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_roles_actions`
--

LOCK TABLES `acl_roles_actions` WRITE;
/*!40000 ALTER TABLE `acl_roles_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_roles_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_roles_users`
--

DROP TABLE IF EXISTS `acl_roles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acl_roles_users` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `role_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_aclrole_id` (`role_id`),
  KEY `idx_acluser_id` (`user_id`),
  KEY `idx_aclrole_user` (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_roles_users`
--

LOCK TABLES `acl_roles_users` WRITE;
/*!40000 ALTER TABLE `acl_roles_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_book`
--

DROP TABLE IF EXISTS `address_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address_book` (
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `bean` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bean_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  KEY `ab_user_bean_idx` (`assigned_user_id`,`bean`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_book`
--

LOCK TABLES `address_book` WRITE;
/*!40000 ALTER TABLE `address_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `target_module` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `url_redirect` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reminder_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `am_projecttemplates`
--

DROP TABLE IF EXISTS `am_projecttemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `am_projecttemplates` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Draft',
  `priority` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'High',
  `override_business_hours` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `am_projecttemplates`
--

LOCK TABLES `am_projecttemplates` WRITE;
/*!40000 ALTER TABLE `am_projecttemplates` DISABLE KEYS */;
/*!40000 ALTER TABLE `am_projecttemplates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `am_projecttemplates_audit`
--

DROP TABLE IF EXISTS `am_projecttemplates_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `am_projecttemplates_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_am_projecttemplates_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `am_projecttemplates_audit`
--

LOCK TABLES `am_projecttemplates_audit` WRITE;
/*!40000 ALTER TABLE `am_projecttemplates_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `am_projecttemplates_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `am_projecttemplates_contacts_1_c`
--

DROP TABLE IF EXISTS `am_projecttemplates_contacts_1_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `am_projecttemplates_contacts_1_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `am_projecttemplates_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contacts_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `am_projecttemplates_contacts_1_alt` (`am_projecttemplates_ida`,`contacts_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `am_projecttemplates_contacts_1_c`
--

LOCK TABLES `am_projecttemplates_contacts_1_c` WRITE;
/*!40000 ALTER TABLE `am_projecttemplates_contacts_1_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `am_projecttemplates_contacts_1_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `am_projecttemplates_project_1_c`
--

DROP TABLE IF EXISTS `am_projecttemplates_project_1_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `am_projecttemplates_project_1_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `am_projecttemplates_project_1am_projecttemplates_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `am_projecttemplates_project_1project_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `am_projecttemplates_project_1_ida1` (`am_projecttemplates_project_1am_projecttemplates_ida`),
  KEY `am_projecttemplates_project_1_alt` (`am_projecttemplates_project_1project_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `am_projecttemplates_project_1_c`
--

LOCK TABLES `am_projecttemplates_project_1_c` WRITE;
/*!40000 ALTER TABLE `am_projecttemplates_project_1_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `am_projecttemplates_project_1_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `am_projecttemplates_users_1_c`
--

DROP TABLE IF EXISTS `am_projecttemplates_users_1_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `am_projecttemplates_users_1_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `am_projecttemplates_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `users_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `am_projecttemplates_users_1_alt` (`am_projecttemplates_ida`,`users_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `am_projecttemplates_users_1_c`
--

LOCK TABLES `am_projecttemplates_users_1_c` WRITE;
/*!40000 ALTER TABLE `am_projecttemplates_users_1_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `am_projecttemplates_users_1_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `am_tasktemplates`
--

DROP TABLE IF EXISTS `am_tasktemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `am_tasktemplates` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Not Started',
  `priority` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'High',
  `percent_complete` int DEFAULT '0',
  `predecessors` int DEFAULT NULL,
  `milestone_flag` tinyint(1) DEFAULT '0',
  `relationship_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'FS',
  `task_number` int DEFAULT NULL,
  `order_number` int DEFAULT NULL,
  `estimated_effort` int DEFAULT NULL,
  `utilization` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '0',
  `duration` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `am_tasktemplates`
--

LOCK TABLES `am_tasktemplates` WRITE;
/*!40000 ALTER TABLE `am_tasktemplates` DISABLE KEYS */;
/*!40000 ALTER TABLE `am_tasktemplates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `am_tasktemplates_am_projecttemplates_c`
--

DROP TABLE IF EXISTS `am_tasktemplates_am_projecttemplates_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `am_tasktemplates_am_projecttemplates_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `am_tasktemplates_am_projecttemplatesam_projecttemplates_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `am_tasktemplates_am_projecttemplatesam_tasktemplates_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `am_tasktemplates_am_projecttemplates_ida1` (`am_tasktemplates_am_projecttemplatesam_projecttemplates_ida`),
  KEY `am_tasktemplates_am_projecttemplates_alt` (`am_tasktemplates_am_projecttemplatesam_tasktemplates_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `am_tasktemplates_am_projecttemplates_c`
--

LOCK TABLES `am_tasktemplates_am_projecttemplates_c` WRITE;
/*!40000 ALTER TABLE `am_tasktemplates_am_projecttemplates_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `am_tasktemplates_am_projecttemplates_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `am_tasktemplates_audit`
--

DROP TABLE IF EXISTS `am_tasktemplates_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `am_tasktemplates_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_am_tasktemplates_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `am_tasktemplates_audit`
--

LOCK TABLES `am_tasktemplates_audit` WRITE;
/*!40000 ALTER TABLE `am_tasktemplates_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `am_tasktemplates_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aobh_businesshours`
--

DROP TABLE IF EXISTS `aobh_businesshours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aobh_businesshours` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `opening_hours` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '1',
  `closing_hours` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '1',
  `open_status` tinyint(1) DEFAULT NULL,
  `day` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'monday',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aobh_businesshours`
--

LOCK TABLES `aobh_businesshours` WRITE;
/*!40000 ALTER TABLE `aobh_businesshours` DISABLE KEYS */;
/*!40000 ALTER TABLE `aobh_businesshours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aod_index`
--

DROP TABLE IF EXISTS `aod_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aod_index` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_optimised` datetime DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aod_index`
--

LOCK TABLES `aod_index` WRITE;
/*!40000 ALTER TABLE `aod_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `aod_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aod_index_audit`
--

DROP TABLE IF EXISTS `aod_index_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aod_index_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aod_index_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aod_index_audit`
--

LOCK TABLES `aod_index_audit` WRITE;
/*!40000 ALTER TABLE `aod_index_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aod_index_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aod_indexevent`
--

DROP TABLE IF EXISTS `aod_indexevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aod_indexevent` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `error` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `success` tinyint(1) DEFAULT '0',
  `record_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `record_module` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_record_module` (`record_module`),
  KEY `idx_record_id` (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aod_indexevent`
--

LOCK TABLES `aod_indexevent` WRITE;
/*!40000 ALTER TABLE `aod_indexevent` DISABLE KEYS */;
/*!40000 ALTER TABLE `aod_indexevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aod_indexevent_audit`
--

DROP TABLE IF EXISTS `aod_indexevent_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aod_indexevent_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aod_indexevent_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aod_indexevent_audit`
--

LOCK TABLES `aod_indexevent_audit` WRITE;
/*!40000 ALTER TABLE `aod_indexevent_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aod_indexevent_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aok_knowledge_base_categories`
--

DROP TABLE IF EXISTS `aok_knowledge_base_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aok_knowledge_base_categories` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aok_knowledge_base_categories`
--

LOCK TABLES `aok_knowledge_base_categories` WRITE;
/*!40000 ALTER TABLE `aok_knowledge_base_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `aok_knowledge_base_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aok_knowledge_base_categories_audit`
--

DROP TABLE IF EXISTS `aok_knowledge_base_categories_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aok_knowledge_base_categories_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aok_knowledge_base_categories_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aok_knowledge_base_categories_audit`
--

LOCK TABLES `aok_knowledge_base_categories_audit` WRITE;
/*!40000 ALTER TABLE `aok_knowledge_base_categories_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aok_knowledge_base_categories_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aok_knowledgebase`
--

DROP TABLE IF EXISTS `aok_knowledgebase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aok_knowledgebase` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Draft',
  `revision` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `additional_info` text COLLATE utf8mb4_general_ci,
  `user_id_c` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id1_c` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aok_knowledgebase`
--

LOCK TABLES `aok_knowledgebase` WRITE;
/*!40000 ALTER TABLE `aok_knowledgebase` DISABLE KEYS */;
/*!40000 ALTER TABLE `aok_knowledgebase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aok_knowledgebase_audit`
--

DROP TABLE IF EXISTS `aok_knowledgebase_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aok_knowledgebase_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aok_knowledgebase_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aok_knowledgebase_audit`
--

LOCK TABLES `aok_knowledgebase_audit` WRITE;
/*!40000 ALTER TABLE `aok_knowledgebase_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aok_knowledgebase_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aok_knowledgebase_categories`
--

DROP TABLE IF EXISTS `aok_knowledgebase_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aok_knowledgebase_categories` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `aok_knowledgebase_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aok_knowledge_base_categories_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aok_knowledgebase_categories_alt` (`aok_knowledgebase_id`,`aok_knowledge_base_categories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aok_knowledgebase_categories`
--

LOCK TABLES `aok_knowledgebase_categories` WRITE;
/*!40000 ALTER TABLE `aok_knowledgebase_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `aok_knowledgebase_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aop_case_events`
--

DROP TABLE IF EXISTS `aop_case_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aop_case_events` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `case_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aop_case_events`
--

LOCK TABLES `aop_case_events` WRITE;
/*!40000 ALTER TABLE `aop_case_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `aop_case_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aop_case_events_audit`
--

DROP TABLE IF EXISTS `aop_case_events_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aop_case_events_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aop_case_events_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aop_case_events_audit`
--

LOCK TABLES `aop_case_events_audit` WRITE;
/*!40000 ALTER TABLE `aop_case_events_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aop_case_events_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aop_case_updates`
--

DROP TABLE IF EXISTS `aop_case_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aop_case_updates` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `case_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `internal` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aop_case_updates`
--

LOCK TABLES `aop_case_updates` WRITE;
/*!40000 ALTER TABLE `aop_case_updates` DISABLE KEYS */;
/*!40000 ALTER TABLE `aop_case_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aop_case_updates_audit`
--

DROP TABLE IF EXISTS `aop_case_updates_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aop_case_updates_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aop_case_updates_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aop_case_updates_audit`
--

LOCK TABLES `aop_case_updates_audit` WRITE;
/*!40000 ALTER TABLE `aop_case_updates_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aop_case_updates_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aor_charts`
--

DROP TABLE IF EXISTS `aor_charts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aor_charts` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `aor_report_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `x_field` int DEFAULT NULL,
  `y_field` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aor_charts`
--

LOCK TABLES `aor_charts` WRITE;
/*!40000 ALTER TABLE `aor_charts` DISABLE KEYS */;
/*!40000 ALTER TABLE `aor_charts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aor_conditions`
--

DROP TABLE IF EXISTS `aor_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aor_conditions` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `aor_report_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `condition_order` int DEFAULT NULL,
  `logic_op` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parenthesis` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `module_path` longtext COLLATE utf8mb4_general_ci,
  `field` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `operator` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parameter` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aor_conditions_index_report_id` (`aor_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aor_conditions`
--

LOCK TABLES `aor_conditions` WRITE;
/*!40000 ALTER TABLE `aor_conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `aor_conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aor_fields`
--

DROP TABLE IF EXISTS `aor_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aor_fields` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `aor_report_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_order` int DEFAULT NULL,
  `module_path` longtext COLLATE utf8mb4_general_ci,
  `field` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `display` tinyint(1) DEFAULT NULL,
  `link` tinyint(1) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_function` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `format` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort_order` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `group_by` tinyint(1) DEFAULT NULL,
  `group_order` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `group_display` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aor_fields_index_report_id` (`aor_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aor_fields`
--

LOCK TABLES `aor_fields` WRITE;
/*!40000 ALTER TABLE `aor_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `aor_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aor_reports`
--

DROP TABLE IF EXISTS `aor_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aor_reports` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `report_module` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `graphs_per_row` int DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aor_reports`
--

LOCK TABLES `aor_reports` WRITE;
/*!40000 ALTER TABLE `aor_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `aor_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aor_reports_audit`
--

DROP TABLE IF EXISTS `aor_reports_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aor_reports_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aor_reports_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aor_reports_audit`
--

LOCK TABLES `aor_reports_audit` WRITE;
/*!40000 ALTER TABLE `aor_reports_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aor_reports_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aor_scheduled_reports`
--

DROP TABLE IF EXISTS `aor_scheduled_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aor_scheduled_reports` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `schedule` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_recipients` longtext COLLATE utf8mb4_general_ci,
  `aor_report_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aor_scheduled_reports`
--

LOCK TABLES `aor_scheduled_reports` WRITE;
/*!40000 ALTER TABLE `aor_scheduled_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `aor_scheduled_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_contracts`
--

DROP TABLE IF EXISTS `aos_contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_contracts` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reference_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `total_contract_value` decimal(26,6) DEFAULT NULL,
  `total_contract_value_usdollar` decimal(26,6) DEFAULT NULL,
  `currency_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Not Started',
  `customer_signed_date` date DEFAULT NULL,
  `company_signed_date` date DEFAULT NULL,
  `renewal_reminder_date` datetime DEFAULT NULL,
  `contract_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Type',
  `contract_account_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `opportunity_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `call_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total_amt` decimal(26,6) DEFAULT NULL,
  `total_amt_usdollar` decimal(26,6) DEFAULT NULL,
  `subtotal_amount` decimal(26,6) DEFAULT NULL,
  `subtotal_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `discount_amount` decimal(26,6) DEFAULT NULL,
  `discount_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `tax_amount` decimal(26,6) DEFAULT NULL,
  `tax_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `shipping_amount` decimal(26,6) DEFAULT NULL,
  `shipping_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `shipping_tax` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_tax_amt` decimal(26,6) DEFAULT NULL,
  `shipping_tax_amt_usdollar` decimal(26,6) DEFAULT NULL,
  `total_amount` decimal(26,6) DEFAULT NULL,
  `total_amount_usdollar` decimal(26,6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_contracts`
--

LOCK TABLES `aos_contracts` WRITE;
/*!40000 ALTER TABLE `aos_contracts` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_contracts_audit`
--

DROP TABLE IF EXISTS `aos_contracts_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_contracts_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aos_contracts_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_contracts_audit`
--

LOCK TABLES `aos_contracts_audit` WRITE;
/*!40000 ALTER TABLE `aos_contracts_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_contracts_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_contracts_documents`
--

DROP TABLE IF EXISTS `aos_contracts_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_contracts_documents` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `aos_contracts_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `documents_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_revision_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aos_contracts_documents_alt` (`aos_contracts_id`,`documents_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_contracts_documents`
--

LOCK TABLES `aos_contracts_documents` WRITE;
/*!40000 ALTER TABLE `aos_contracts_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_contracts_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_invoices`
--

DROP TABLE IF EXISTS `aos_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_invoices` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_account_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_contact_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `number` int NOT NULL,
  `total_amt` decimal(26,6) DEFAULT NULL,
  `total_amt_usdollar` decimal(26,6) DEFAULT NULL,
  `subtotal_amount` decimal(26,6) DEFAULT NULL,
  `subtotal_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `discount_amount` decimal(26,6) DEFAULT NULL,
  `discount_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `tax_amount` decimal(26,6) DEFAULT NULL,
  `tax_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `shipping_amount` decimal(26,6) DEFAULT NULL,
  `shipping_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `shipping_tax` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_tax_amt` decimal(26,6) DEFAULT NULL,
  `shipping_tax_amt_usdollar` decimal(26,6) DEFAULT NULL,
  `total_amount` decimal(26,6) DEFAULT NULL,
  `total_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `currency_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quote_number` int DEFAULT NULL,
  `quote_date` date DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `template_ddown_c` text COLLATE utf8mb4_general_ci,
  `subtotal_tax_amount` decimal(26,6) DEFAULT NULL,
  `subtotal_tax_amount_usdollar` decimal(26,6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_invoices`
--

LOCK TABLES `aos_invoices` WRITE;
/*!40000 ALTER TABLE `aos_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_invoices_audit`
--

DROP TABLE IF EXISTS `aos_invoices_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_invoices_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aos_invoices_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_invoices_audit`
--

LOCK TABLES `aos_invoices_audit` WRITE;
/*!40000 ALTER TABLE `aos_invoices_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_invoices_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_line_item_groups`
--

DROP TABLE IF EXISTS `aos_line_item_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_line_item_groups` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total_amt` decimal(26,6) DEFAULT NULL,
  `total_amt_usdollar` decimal(26,6) DEFAULT NULL,
  `discount_amount` decimal(26,6) DEFAULT NULL,
  `discount_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `subtotal_amount` decimal(26,6) DEFAULT NULL,
  `subtotal_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `tax_amount` decimal(26,6) DEFAULT NULL,
  `tax_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `subtotal_tax_amount` decimal(26,6) DEFAULT NULL,
  `subtotal_tax_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `total_amount` decimal(26,6) DEFAULT NULL,
  `total_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `number` int DEFAULT NULL,
  `currency_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_line_item_groups`
--

LOCK TABLES `aos_line_item_groups` WRITE;
/*!40000 ALTER TABLE `aos_line_item_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_line_item_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_line_item_groups_audit`
--

DROP TABLE IF EXISTS `aos_line_item_groups_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_line_item_groups_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aos_line_item_groups_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_line_item_groups_audit`
--

LOCK TABLES `aos_line_item_groups_audit` WRITE;
/*!40000 ALTER TABLE `aos_line_item_groups_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_line_item_groups_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_pdf_templates`
--

DROP TABLE IF EXISTS `aos_pdf_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_pdf_templates` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pdfheader` longtext COLLATE utf8mb4_general_ci,
  `pdffooter` longtext COLLATE utf8mb4_general_ci,
  `margin_left` int DEFAULT '15',
  `margin_right` int DEFAULT '15',
  `margin_top` int DEFAULT '16',
  `margin_bottom` int DEFAULT '16',
  `margin_header` int DEFAULT '9',
  `margin_footer` int DEFAULT '9',
  `page_size` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `orientation` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_pdf_templates`
--

LOCK TABLES `aos_pdf_templates` WRITE;
/*!40000 ALTER TABLE `aos_pdf_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_pdf_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_pdf_templates_audit`
--

DROP TABLE IF EXISTS `aos_pdf_templates_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_pdf_templates_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aos_pdf_templates_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_pdf_templates_audit`
--

LOCK TABLES `aos_pdf_templates_audit` WRITE;
/*!40000 ALTER TABLE `aos_pdf_templates_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_pdf_templates_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_product_categories`
--

DROP TABLE IF EXISTS `aos_product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_product_categories` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_parent` tinyint(1) DEFAULT '0',
  `parent_category_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_product_categories`
--

LOCK TABLES `aos_product_categories` WRITE;
/*!40000 ALTER TABLE `aos_product_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_product_categories_audit`
--

DROP TABLE IF EXISTS `aos_product_categories_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_product_categories_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aos_product_categories_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_product_categories_audit`
--

LOCK TABLES `aos_product_categories_audit` WRITE;
/*!40000 ALTER TABLE `aos_product_categories_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_product_categories_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_products`
--

DROP TABLE IF EXISTS `aos_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_products` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `maincode` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'XXXX',
  `part_number` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Good',
  `cost` decimal(26,6) DEFAULT NULL,
  `cost_usdollar` decimal(26,6) DEFAULT NULL,
  `currency_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` decimal(26,6) DEFAULT NULL,
  `price_usdollar` decimal(26,6) DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aos_product_category_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_products`
--

LOCK TABLES `aos_products` WRITE;
/*!40000 ALTER TABLE `aos_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_products_audit`
--

DROP TABLE IF EXISTS `aos_products_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_products_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aos_products_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_products_audit`
--

LOCK TABLES `aos_products_audit` WRITE;
/*!40000 ALTER TABLE `aos_products_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_products_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_products_quotes`
--

DROP TABLE IF EXISTS `aos_products_quotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_products_quotes` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` text COLLATE utf8mb4_general_ci,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `currency_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `part_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `item_description` text COLLATE utf8mb4_general_ci,
  `number` int DEFAULT NULL,
  `product_qty` decimal(18,4) DEFAULT NULL,
  `product_cost_price` decimal(26,6) DEFAULT NULL,
  `product_cost_price_usdollar` decimal(26,6) DEFAULT NULL,
  `product_list_price` decimal(26,6) DEFAULT NULL,
  `product_list_price_usdollar` decimal(26,6) DEFAULT NULL,
  `product_discount` decimal(26,6) DEFAULT NULL,
  `product_discount_usdollar` decimal(26,6) DEFAULT NULL,
  `product_discount_amount` decimal(26,6) DEFAULT NULL,
  `product_discount_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `discount` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'Percentage',
  `product_unit_price` decimal(26,6) DEFAULT NULL,
  `product_unit_price_usdollar` decimal(26,6) DEFAULT NULL,
  `vat_amt` decimal(26,6) DEFAULT NULL,
  `vat_amt_usdollar` decimal(26,6) DEFAULT NULL,
  `product_total_price` decimal(26,6) DEFAULT NULL,
  `product_total_price_usdollar` decimal(26,6) DEFAULT NULL,
  `vat` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '5.0',
  `parent_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `group_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aospq_par_del` (`parent_id`,`parent_type`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_products_quotes`
--

LOCK TABLES `aos_products_quotes` WRITE;
/*!40000 ALTER TABLE `aos_products_quotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_products_quotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_products_quotes_audit`
--

DROP TABLE IF EXISTS `aos_products_quotes_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_products_quotes_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aos_products_quotes_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_products_quotes_audit`
--

LOCK TABLES `aos_products_quotes_audit` WRITE;
/*!40000 ALTER TABLE `aos_products_quotes_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_products_quotes_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_quotes`
--

DROP TABLE IF EXISTS `aos_quotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_quotes` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `approval_issue` text COLLATE utf8mb4_general_ci,
  `billing_account_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_contact_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billing_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `expiration` date DEFAULT NULL,
  `number` int DEFAULT NULL,
  `opportunity_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `template_ddown_c` text COLLATE utf8mb4_general_ci,
  `total_amt` decimal(26,6) DEFAULT NULL,
  `total_amt_usdollar` decimal(26,6) DEFAULT NULL,
  `subtotal_amount` decimal(26,6) DEFAULT NULL,
  `subtotal_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `discount_amount` decimal(26,6) DEFAULT NULL,
  `discount_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `tax_amount` decimal(26,6) DEFAULT NULL,
  `tax_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `shipping_amount` decimal(26,6) DEFAULT NULL,
  `shipping_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `shipping_tax` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_tax_amt` decimal(26,6) DEFAULT NULL,
  `shipping_tax_amt_usdollar` decimal(26,6) DEFAULT NULL,
  `total_amount` decimal(26,6) DEFAULT NULL,
  `total_amount_usdollar` decimal(26,6) DEFAULT NULL,
  `currency_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `stage` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Draft',
  `term` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `terms_c` text COLLATE utf8mb4_general_ci,
  `approval_status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `invoice_status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Not Invoiced',
  `subtotal_tax_amount` decimal(26,6) DEFAULT NULL,
  `subtotal_tax_amount_usdollar` decimal(26,6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_quotes`
--

LOCK TABLES `aos_quotes` WRITE;
/*!40000 ALTER TABLE `aos_quotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_quotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_quotes_aos_invoices_c`
--

DROP TABLE IF EXISTS `aos_quotes_aos_invoices_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_quotes_aos_invoices_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `aos_quotes77d9_quotes_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aos_quotes6b83nvoices_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aos_quotes_aos_invoices_alt` (`aos_quotes77d9_quotes_ida`,`aos_quotes6b83nvoices_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_quotes_aos_invoices_c`
--

LOCK TABLES `aos_quotes_aos_invoices_c` WRITE;
/*!40000 ALTER TABLE `aos_quotes_aos_invoices_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_quotes_aos_invoices_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_quotes_audit`
--

DROP TABLE IF EXISTS `aos_quotes_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_quotes_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aos_quotes_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_quotes_audit`
--

LOCK TABLES `aos_quotes_audit` WRITE;
/*!40000 ALTER TABLE `aos_quotes_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_quotes_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_quotes_os_contracts_c`
--

DROP TABLE IF EXISTS `aos_quotes_os_contracts_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_quotes_os_contracts_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `aos_quotese81e_quotes_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aos_quotes4dc0ntracts_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aos_quotes_aos_contracts_alt` (`aos_quotese81e_quotes_ida`,`aos_quotes4dc0ntracts_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_quotes_os_contracts_c`
--

LOCK TABLES `aos_quotes_os_contracts_c` WRITE;
/*!40000 ALTER TABLE `aos_quotes_os_contracts_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_quotes_os_contracts_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aos_quotes_project_c`
--

DROP TABLE IF EXISTS `aos_quotes_project_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aos_quotes_project_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `aos_quotes1112_quotes_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aos_quotes7207project_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aos_quotes_project_alt` (`aos_quotes1112_quotes_ida`,`aos_quotes7207project_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aos_quotes_project_c`
--

LOCK TABLES `aos_quotes_project_c` WRITE;
/*!40000 ALTER TABLE `aos_quotes_project_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `aos_quotes_project_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aow_actions`
--

DROP TABLE IF EXISTS `aow_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aow_actions` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `aow_workflow_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `action_order` int DEFAULT NULL,
  `action` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parameters` longtext COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `aow_action_index_workflow_id` (`aow_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aow_actions`
--

LOCK TABLES `aow_actions` WRITE;
/*!40000 ALTER TABLE `aow_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `aow_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aow_conditions`
--

DROP TABLE IF EXISTS `aow_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aow_conditions` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `aow_workflow_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `condition_order` int DEFAULT NULL,
  `module_path` longtext COLLATE utf8mb4_general_ci,
  `field` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `operator` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aow_conditions_index_workflow_id` (`aow_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aow_conditions`
--

LOCK TABLES `aow_conditions` WRITE;
/*!40000 ALTER TABLE `aow_conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `aow_conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aow_processed`
--

DROP TABLE IF EXISTS `aow_processed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aow_processed` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `aow_workflow_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Pending',
  PRIMARY KEY (`id`),
  KEY `aow_processed_index_workflow` (`aow_workflow_id`,`status`,`parent_id`,`deleted`),
  KEY `aow_processed_index_status` (`status`),
  KEY `aow_processed_index_workflow_id` (`aow_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aow_processed`
--

LOCK TABLES `aow_processed` WRITE;
/*!40000 ALTER TABLE `aow_processed` DISABLE KEYS */;
/*!40000 ALTER TABLE `aow_processed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aow_processed_aow_actions`
--

DROP TABLE IF EXISTS `aow_processed_aow_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aow_processed_aow_actions` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `aow_processed_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aow_action_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(36) COLLATE utf8mb4_general_ci DEFAULT 'Pending',
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_aow_processed_aow_actions` (`aow_processed_id`,`aow_action_id`),
  KEY `idx_actid_del_freid` (`aow_action_id`,`deleted`,`aow_processed_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aow_processed_aow_actions`
--

LOCK TABLES `aow_processed_aow_actions` WRITE;
/*!40000 ALTER TABLE `aow_processed_aow_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `aow_processed_aow_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aow_workflow`
--

DROP TABLE IF EXISTS `aow_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aow_workflow` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `flow_module` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `flow_run_on` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '0',
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Active',
  `run_when` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Always',
  `multiple_runs` tinyint(1) DEFAULT '0',
  `run_on_import` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `aow_workflow_index_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aow_workflow`
--

LOCK TABLES `aow_workflow` WRITE;
/*!40000 ALTER TABLE `aow_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `aow_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aow_workflow_audit`
--

DROP TABLE IF EXISTS `aow_workflow_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aow_workflow_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_aow_workflow_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aow_workflow_audit`
--

LOCK TABLES `aow_workflow_audit` WRITE;
/*!40000 ALTER TABLE `aow_workflow_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `aow_workflow_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bugs`
--

DROP TABLE IF EXISTS `bugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bugs` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bug_number` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `priority` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `resolution` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `work_log` text COLLATE utf8mb4_general_ci,
  `found_in_release` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fixed_in_release` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_category` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bugsnumk` (`bug_number`),
  KEY `bug_number` (`bug_number`),
  KEY `idx_bug_name` (`name`),
  KEY `idx_bugs_assigned_user` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bugs`
--

LOCK TABLES `bugs` WRITE;
/*!40000 ALTER TABLE `bugs` DISABLE KEYS */;
/*!40000 ALTER TABLE `bugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bugs_audit`
--

DROP TABLE IF EXISTS `bugs_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bugs_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_bugs_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bugs_audit`
--

LOCK TABLES `bugs_audit` WRITE;
/*!40000 ALTER TABLE `bugs_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `bugs_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_account_meetings`
--

DROP TABLE IF EXISTS `calendar_account_meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_account_meetings` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `calendar_account_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `meeting_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `calendar_account_source` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `external_event_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_sync` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_calendar_account_meeting` (`calendar_account_id`,`meeting_id`),
  KEY `idx_cal_acc_mtg_cal` (`calendar_account_id`),
  KEY `idx_cal_acc_mtg_mtg` (`meeting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_account_meetings`
--

LOCK TABLES `calendar_account_meetings` WRITE;
/*!40000 ALTER TABLE `calendar_account_meetings` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_account_meetings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_accounts`
--

DROP TABLE IF EXISTS `calendar_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_accounts` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'personal',
  `oauth_connection_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `server_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `api_key` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `api_endpoint` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `calendar_user_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `last_connection_status` tinyint(1) DEFAULT '0',
  `last_connection_test` datetime DEFAULT NULL,
  `last_sync_attempt_date` datetime DEFAULT NULL,
  `last_sync_attempt_status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_sync_attempt_message` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_sync_date` datetime DEFAULT NULL,
  `external_calendar_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cal_acct_user_type_status` (`calendar_user_id`,`type`,`last_connection_status`,`deleted`),
  KEY `idx_cal_acct_external_cal_id` (`external_calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_accounts`
--

LOCK TABLES `calendar_accounts` WRITE;
/*!40000 ALTER TABLE `calendar_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_accounts_audit`
--

DROP TABLE IF EXISTS `calendar_accounts_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_accounts_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_calendar_accounts_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_accounts_audit`
--

LOCK TABLES `calendar_accounts_audit` WRITE;
/*!40000 ALTER TABLE `calendar_accounts_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_accounts_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calls`
--

DROP TABLE IF EXISTS `calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calls` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `duration_hours` int DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `parent_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Planned',
  `direction` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reminder_time` int DEFAULT '-1',
  `email_reminder_time` int DEFAULT '-1',
  `email_reminder_sent` tinyint(1) DEFAULT '0',
  `outlook_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `repeat_type` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `repeat_interval` int DEFAULT '1',
  `repeat_dow` varchar(7) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `repeat_until` date DEFAULT NULL,
  `repeat_count` int DEFAULT NULL,
  `repeat_parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `recurring_source` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_call_name` (`name`),
  KEY `idx_status` (`status`),
  KEY `idx_calls_date_start` (`date_start`),
  KEY `idx_calls_par_del` (`parent_id`,`parent_type`,`deleted`),
  KEY `idx_calls_assigned_del` (`deleted`,`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calls`
--

LOCK TABLES `calls` WRITE;
/*!40000 ALTER TABLE `calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `calls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calls_contacts`
--

DROP TABLE IF EXISTS `calls_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calls_contacts` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `call_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `required` varchar(1) COLLATE utf8mb4_general_ci DEFAULT '1',
  `accept_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'none',
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_con_call_call` (`call_id`),
  KEY `idx_con_call_con` (`contact_id`),
  KEY `idx_call_contact` (`call_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calls_contacts`
--

LOCK TABLES `calls_contacts` WRITE;
/*!40000 ALTER TABLE `calls_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `calls_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calls_leads`
--

DROP TABLE IF EXISTS `calls_leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calls_leads` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `call_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lead_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `required` varchar(1) COLLATE utf8mb4_general_ci DEFAULT '1',
  `accept_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'none',
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lead_call_call` (`call_id`),
  KEY `idx_lead_call_lead` (`lead_id`),
  KEY `idx_call_lead` (`call_id`,`lead_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calls_leads`
--

LOCK TABLES `calls_leads` WRITE;
/*!40000 ALTER TABLE `calls_leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `calls_leads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calls_reschedule`
--

DROP TABLE IF EXISTS `calls_reschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calls_reschedule` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reason` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `call_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calls_reschedule`
--

LOCK TABLES `calls_reschedule` WRITE;
/*!40000 ALTER TABLE `calls_reschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `calls_reschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calls_reschedule_audit`
--

DROP TABLE IF EXISTS `calls_reschedule_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calls_reschedule_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_calls_reschedule_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calls_reschedule_audit`
--

LOCK TABLES `calls_reschedule_audit` WRITE;
/*!40000 ALTER TABLE `calls_reschedule_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `calls_reschedule_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calls_users`
--

DROP TABLE IF EXISTS `calls_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calls_users` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `call_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `required` varchar(1) COLLATE utf8mb4_general_ci DEFAULT '1',
  `accept_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'none',
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_usr_call_call` (`call_id`),
  KEY `idx_usr_call_usr` (`user_id`),
  KEY `idx_call_users` (`call_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calls_users`
--

LOCK TABLES `calls_users` WRITE;
/*!40000 ALTER TABLE `calls_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `calls_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_log`
--

DROP TABLE IF EXISTS `campaign_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_log` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `campaign_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `target_tracker_key` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `target_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `target_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `activity_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `activity_date` datetime DEFAULT NULL,
  `related_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `archived` tinyint(1) DEFAULT '0',
  `hits` int DEFAULT '0',
  `list_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `more_information` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `marketing_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_camp_tracker` (`target_tracker_key`),
  KEY `idx_camp_campaign_id` (`campaign_id`),
  KEY `idx_camp_more_info` (`more_information`),
  KEY `idx_target_id` (`target_id`),
  KEY `idx_target_id_deleted` (`target_id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_log`
--

LOCK TABLES `campaign_log` WRITE;
/*!40000 ALTER TABLE `campaign_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_trkrs`
--

DROP TABLE IF EXISTS `campaign_trkrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_trkrs` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `tracker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tracker_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'http://',
  `tracker_key` int NOT NULL AUTO_INCREMENT,
  `campaign_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_optout` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `campaign_tracker_key_idx` (`tracker_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_trkrs`
--

LOCK TABLES `campaign_trkrs` WRITE;
/*!40000 ALTER TABLE `campaign_trkrs` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_trkrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tracker_key` int NOT NULL AUTO_INCREMENT,
  `tracker_count` int DEFAULT '0',
  `refer_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'http://',
  `tracker_text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `impressions` int DEFAULT '0',
  `currency_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `budget` double DEFAULT NULL,
  `expected_cost` double DEFAULT NULL,
  `actual_cost` double DEFAULT NULL,
  `expected_revenue` double DEFAULT NULL,
  `campaign_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `objective` text COLLATE utf8mb4_general_ci,
  `content` text COLLATE utf8mb4_general_ci,
  `frequency` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `survey_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `camp_auto_tracker_key` (`tracker_key`),
  KEY `idx_campaign_name` (`name`),
  KEY `idx_survey_id` (`survey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns_audit`
--

DROP TABLE IF EXISTS `campaigns_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_campaigns_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns_audit`
--

LOCK TABLES `campaigns_audit` WRITE;
/*!40000 ALTER TABLE `campaigns_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaigns_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases`
--

DROP TABLE IF EXISTS `cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cases` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `case_number` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `priority` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `resolution` text COLLATE utf8mb4_general_ci,
  `work_log` text COLLATE utf8mb4_general_ci,
  `account_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Open',
  `contact_created_by_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `casesnumk` (`case_number`),
  KEY `case_number` (`case_number`),
  KEY `idx_case_name` (`name`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_cases_stat_del` (`assigned_user_id`,`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases`
--

LOCK TABLES `cases` WRITE;
/*!40000 ALTER TABLE `cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases_audit`
--

DROP TABLE IF EXISTS `cases_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cases_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_cases_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases_audit`
--

LOCK TABLES `cases_audit` WRITE;
/*!40000 ALTER TABLE `cases_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `cases_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases_bugs`
--

DROP TABLE IF EXISTS `cases_bugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cases_bugs` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `case_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bug_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_cas_bug_cas` (`case_id`),
  KEY `idx_cas_bug_bug` (`bug_id`),
  KEY `idx_case_bug` (`case_id`,`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases_bugs`
--

LOCK TABLES `cases_bugs` WRITE;
/*!40000 ALTER TABLE `cases_bugs` DISABLE KEYS */;
/*!40000 ALTER TABLE `cases_bugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases_cstm`
--

DROP TABLE IF EXISTS `cases_cstm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cases_cstm` (
  `id_c` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `jjwg_maps_lng_c` float(11,8) DEFAULT '0.00000000',
  `jjwg_maps_lat_c` float(10,8) DEFAULT '0.00000000',
  `jjwg_maps_geocode_status_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_address_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases_cstm`
--

LOCK TABLES `cases_cstm` WRITE;
/*!40000 ALTER TABLE `cases_cstm` DISABLE KEYS */;
/*!40000 ALTER TABLE `cases_cstm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `category` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_general_ci,
  KEY `idx_config_cat` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES ('notify','fromaddress','do_not_reply@example.com'),('notify','fromname','SuiteCRM'),('notify','send_by_default','1'),('notify','on','1'),('notify','send_from_assigning_user','0'),('info','sugar_version','6.5.25'),('MySettings','tab','YTozMzp7aTowO3M6NDoiSG9tZSI7aToxO3M6ODoiQWNjb3VudHMiO2k6MjtzOjg6IkNvbnRhY3RzIjtpOjM7czoxMzoiT3Bwb3J0dW5pdGllcyI7aTo0O3M6NToiTGVhZHMiO2k6NTtzOjEwOiJBT1NfUXVvdGVzIjtpOjY7czo4OiJDYWxlbmRhciI7aTo3O3M6OToiRG9jdW1lbnRzIjtpOjg7czo2OiJFbWFpbHMiO2k6OTtzOjU6IlNwb3RzIjtpOjEwO3M6OToiQ2FtcGFpZ25zIjtpOjExO3M6NToiQ2FsbHMiO2k6MTI7czo4OiJNZWV0aW5ncyI7aToxMztzOjU6IlRhc2tzIjtpOjE0O3M6NToiTm90ZXMiO2k6MTU7czoxMjoiQU9TX0ludm9pY2VzIjtpOjE2O3M6MTM6IkFPU19Db250cmFjdHMiO2k6MTc7czo1OiJDYXNlcyI7aToxODtzOjk6IlByb3NwZWN0cyI7aToxOTtzOjEzOiJQcm9zcGVjdExpc3RzIjtpOjIwO3M6NzoiUHJvamVjdCI7aToyMTtzOjE5OiJBTV9Qcm9qZWN0VGVtcGxhdGVzIjtpOjIyO3M6MTY6IkFNX1Rhc2tUZW1wbGF0ZXMiO2k6MjM7czo5OiJGUF9ldmVudHMiO2k6MjQ7czoxODoiRlBfRXZlbnRfTG9jYXRpb25zIjtpOjI1O3M6MTI6IkFPU19Qcm9kdWN0cyI7aToyNjtzOjIyOiJBT1NfUHJvZHVjdF9DYXRlZ29yaWVzIjtpOjI3O3M6MTc6IkFPU19QREZfVGVtcGxhdGVzIjtpOjI4O3M6MTE6IkFPUl9SZXBvcnRzIjtpOjI5O3M6MTc6IkFPS19Lbm93bGVkZ2VCYXNlIjtpOjMwO3M6Mjk6IkFPS19Lbm93bGVkZ2VfQmFzZV9DYXRlZ29yaWVzIjtpOjMxO3M6MTQ6IkVtYWlsVGVtcGxhdGVzIjtpOjMyO3M6NzoiU3VydmV5cyI7fQ=='),('portal','on','0'),('tracker','Tracker','1'),('sugarfeed','enabled','1'),('sugarfeed','module_UserFeed','1'),('sugarfeed','module_Leads','1'),('sugarfeed','module_Opportunities','1'),('sugarfeed','module_Cases','1'),('sugarfeed','module_Contacts','1'),('Update','CheckUpdates','manual'),('system','name','SuiteCRM'),('system','adminwizard','1');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `salutation` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `department` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `do_not_call` tinyint(1) DEFAULT '0',
  `phone_home` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_mobile` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_work` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_other` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_fax` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lawful_basis` text COLLATE utf8mb4_general_ci,
  `date_reviewed` date DEFAULT NULL,
  `lawful_basis_source` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assistant` varchar(75) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assistant_phone` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lead_source` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reports_to_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `campaign_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `joomla_account_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `portal_account_disabled` tinyint(1) DEFAULT NULL,
  `portal_user_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Single',
  PRIMARY KEY (`id`),
  KEY `idx_cont_last_first` (`last_name`,`first_name`,`deleted`),
  KEY `idx_contacts_del_last` (`deleted`,`last_name`),
  KEY `idx_cont_del_reports` (`deleted`,`reports_to_id`,`last_name`),
  KEY `idx_reports_to_id` (`reports_to_id`),
  KEY `idx_del_id_user` (`deleted`,`id`,`assigned_user_id`),
  KEY `idx_cont_assigned` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts_audit`
--

DROP TABLE IF EXISTS `contacts_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_contacts_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts_audit`
--

LOCK TABLES `contacts_audit` WRITE;
/*!40000 ALTER TABLE `contacts_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts_bugs`
--

DROP TABLE IF EXISTS `contacts_bugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts_bugs` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `contact_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bug_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_role` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_con_bug_con` (`contact_id`),
  KEY `idx_con_bug_bug` (`bug_id`),
  KEY `idx_contact_bug` (`contact_id`,`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts_bugs`
--

LOCK TABLES `contacts_bugs` WRITE;
/*!40000 ALTER TABLE `contacts_bugs` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts_bugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts_cases`
--

DROP TABLE IF EXISTS `contacts_cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts_cases` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `contact_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `case_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_role` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_con_case_con` (`contact_id`),
  KEY `idx_con_case_case` (`case_id`),
  KEY `idx_contacts_cases` (`contact_id`,`case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts_cases`
--

LOCK TABLES `contacts_cases` WRITE;
/*!40000 ALTER TABLE `contacts_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts_cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts_cstm`
--

DROP TABLE IF EXISTS `contacts_cstm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts_cstm` (
  `id_c` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `jjwg_maps_lng_c` float(11,8) DEFAULT '0.00000000',
  `jjwg_maps_lat_c` float(10,8) DEFAULT '0.00000000',
  `jjwg_maps_geocode_status_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_address_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts_cstm`
--

LOCK TABLES `contacts_cstm` WRITE;
/*!40000 ALTER TABLE `contacts_cstm` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts_cstm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts_users`
--

DROP TABLE IF EXISTS `contacts_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts_users` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `contact_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_con_users_con` (`contact_id`),
  KEY `idx_con_users_user` (`user_id`),
  KEY `idx_contacts_users` (`contact_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts_users`
--

LOCK TABLES `contacts_users` WRITE;
/*!40000 ALTER TABLE `contacts_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cron_remove_documents`
--

DROP TABLE IF EXISTS `cron_remove_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cron_remove_documents` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `bean_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `module` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cron_remove_document_bean_id` (`bean_id`),
  KEY `idx_cron_remove_document_stamp` (`date_modified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cron_remove_documents`
--

LOCK TABLES `cron_remove_documents` WRITE;
/*!40000 ALTER TABLE `cron_remove_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `cron_remove_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `symbol` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `iso4217` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `conversion_rate` double DEFAULT '0',
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_currency_name` (`name`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_fields`
--

DROP TABLE IF EXISTS `custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_fields` (
  `bean_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `set_num` int DEFAULT '0',
  `field0` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field1` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field2` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field3` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field4` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field5` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field6` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field7` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field8` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field9` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  KEY `idx_beanid_set_num` (`bean_id`,`set_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_fields`
--

LOCK TABLES `custom_fields` WRITE;
/*!40000 ALTER TABLE `custom_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_revisions`
--

DROP TABLE IF EXISTS `document_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_revisions` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `change_log` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `doc_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `doc_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `doc_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `file_ext` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `file_mime_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `revision` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `date_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentrevision_mimetype` (`file_mime_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_revisions`
--

LOCK TABLES `document_revisions` WRITE;
/*!40000 ALTER TABLE `document_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `doc_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `doc_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Sugar',
  `doc_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `active_date` date DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `category_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subcategory_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_revision_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_doc_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_doc_rev_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_template` tinyint(1) DEFAULT '0',
  `template_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_doc_cat` (`category_id`,`subcategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_accounts`
--

DROP TABLE IF EXISTS `documents_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_accounts` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `document_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_accounts_account_id` (`account_id`,`document_id`),
  KEY `documents_accounts_document_id` (`document_id`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_accounts`
--

LOCK TABLES `documents_accounts` WRITE;
/*!40000 ALTER TABLE `documents_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_bugs`
--

DROP TABLE IF EXISTS `documents_bugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_bugs` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `document_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bug_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_bugs_bug_id` (`bug_id`,`document_id`),
  KEY `documents_bugs_document_id` (`document_id`,`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_bugs`
--

LOCK TABLES `documents_bugs` WRITE;
/*!40000 ALTER TABLE `documents_bugs` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents_bugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_cases`
--

DROP TABLE IF EXISTS `documents_cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_cases` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `document_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `case_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_cases_case_id` (`case_id`,`document_id`),
  KEY `documents_cases_document_id` (`document_id`,`case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_cases`
--

LOCK TABLES `documents_cases` WRITE;
/*!40000 ALTER TABLE `documents_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents_cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_contacts`
--

DROP TABLE IF EXISTS `documents_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_contacts` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `document_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_contacts_contact_id` (`contact_id`,`document_id`),
  KEY `documents_contacts_document_id` (`document_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_contacts`
--

LOCK TABLES `documents_contacts` WRITE;
/*!40000 ALTER TABLE `documents_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_opportunities`
--

DROP TABLE IF EXISTS `documents_opportunities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_opportunities` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `document_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `opportunity_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_docu_opps_oppo_id` (`opportunity_id`,`document_id`),
  KEY `idx_docu_oppo_docu_id` (`document_id`,`opportunity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_opportunities`
--

LOCK TABLES `documents_opportunities` WRITE;
/*!40000 ALTER TABLE `documents_opportunities` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents_opportunities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eapm`
--

DROP TABLE IF EXISTS `eapm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eapm` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `application` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'webex',
  `api_data` text COLLATE utf8mb4_general_ci,
  `consumer_key` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `consumer_secret` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `oauth_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `oauth_secret` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `validated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_app_active` (`assigned_user_id`,`application`,`validated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eapm`
--

LOCK TABLES `eapm` WRITE;
/*!40000 ALTER TABLE `eapm` DISABLE KEYS */;
/*!40000 ALTER TABLE `eapm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_addr_bean_rel`
--

DROP TABLE IF EXISTS `email_addr_bean_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_addr_bean_rel` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `email_address_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `bean_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `bean_module` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address` tinyint(1) DEFAULT '0',
  `reply_to_address` tinyint(1) DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_email_address_id` (`email_address_id`),
  KEY `idx_bean_id` (`bean_id`,`bean_module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_addr_bean_rel`
--

LOCK TABLES `email_addr_bean_rel` WRITE;
/*!40000 ALTER TABLE `email_addr_bean_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_addr_bean_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_addresses`
--

DROP TABLE IF EXISTS `email_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_addresses` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `email_address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_address_caps` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `invalid_email` tinyint(1) DEFAULT '0',
  `opt_out` tinyint(1) DEFAULT '0',
  `confirm_opt_in` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'not-opt-in',
  `confirm_opt_in_date` datetime DEFAULT NULL,
  `confirm_opt_in_sent_date` datetime DEFAULT NULL,
  `confirm_opt_in_fail_date` datetime DEFAULT NULL,
  `confirm_opt_in_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ea_caps_opt_out_invalid` (`email_address_caps`,`opt_out`,`invalid_email`),
  KEY `idx_ea_opt_out_invalid` (`email_address`,`opt_out`,`invalid_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_addresses`
--

LOCK TABLES `email_addresses` WRITE;
/*!40000 ALTER TABLE `email_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_addresses_audit`
--

DROP TABLE IF EXISTS `email_addresses_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_addresses_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_email_addresses_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_addresses_audit`
--

LOCK TABLES `email_addresses_audit` WRITE;
/*!40000 ALTER TABLE `email_addresses_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_addresses_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_cache`
--

DROP TABLE IF EXISTS `email_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_cache` (
  `ie_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mbox` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fromaddr` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `toaddr` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `message_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mailsize` int unsigned DEFAULT NULL,
  `imap_uid` int unsigned DEFAULT NULL,
  `msgno` int unsigned DEFAULT NULL,
  `recent` tinyint DEFAULT NULL,
  `flagged` tinyint DEFAULT NULL,
  `answered` tinyint DEFAULT NULL,
  `deleted` tinyint DEFAULT NULL,
  `seen` tinyint DEFAULT NULL,
  `draft` tinyint DEFAULT NULL,
  KEY `idx_ie_id` (`ie_id`),
  KEY `idx_mail_date` (`ie_id`,`mbox`,`senddate`),
  KEY `idx_mail_from` (`ie_id`,`mbox`,`fromaddr`),
  KEY `idx_mail_subj` (`subject`),
  KEY `idx_mail_to` (`toaddr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_cache`
--

LOCK TABLES `email_cache` WRITE;
/*!40000 ALTER TABLE `email_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_marketing`
--

DROP TABLE IF EXISTS `email_marketing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_marketing` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `from_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `from_addr` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reply_to_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reply_to_addr` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `inbound_email_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_start` datetime DEFAULT NULL,
  `template_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `campaign_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `outbound_email_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `all_prospect_lists` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_emmkt_name` (`name`),
  KEY `idx_emmkit_del` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_marketing`
--

LOCK TABLES `email_marketing` WRITE;
/*!40000 ALTER TABLE `email_marketing` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_marketing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_marketing_prospect_lists`
--

DROP TABLE IF EXISTS `email_marketing_prospect_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_marketing_prospect_lists` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `prospect_list_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_marketing_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `email_mp_prospects` (`email_marketing_id`,`prospect_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_marketing_prospect_lists`
--

LOCK TABLES `email_marketing_prospect_lists` WRITE;
/*!40000 ALTER TABLE `email_marketing_prospect_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_marketing_prospect_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates`
--

DROP TABLE IF EXISTS `email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_templates` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `published` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `subject` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `body` longtext COLLATE utf8mb4_general_ci,
  `body_html` longtext COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `text_only` tinyint(1) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_email_template_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates`
--

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
INSERT INTO `email_templates` VALUES ('0592ce03-d35a-4914-9636-6799de4dae92','2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','off','Case Creation','Template to send to a contact when a case is received from them.','$acase_name [CASE:$acase_case_number]','Hi $contact_first_name $contact_last_name,\n\n					   We\'ve received your case $acase_name (# $acase_case_number) on $acase_date_entered\n					   Status:		$acase_status\n					   Reference:	$acase_case_number\n					   Description:	$acase_description','<p> Hi $contact_first_name $contact_last_name,</p>\n					    <p>We\'ve received your case $acase_name (# $acase_case_number) on $acase_date_entered</p>\n					    <table border=\"0\"><tbody>\n					    <tr><td>Status</td><td>$acase_status</td></tr>\n					    <tr><td>Reference</td><td>$acase_case_number</td></tr>\n					    <tr><td>Description</td><td>$acase_description</td></tr>\n					    </tbody></table>',0,NULL,NULL,'system'),('2a884426-a376-4efa-9b42-f2cdff5b190a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','off','Contact Case Update','Template to send to a contact when their case is updated.','$acase_name update [CASE:$acase_case_number]','Hi $user_first_name $user_last_name,\n\n					   You\'ve had an update to your case $acase_name (# $acase_case_number) on $aop_case_updates_date_entered:\n					       $contact_first_name $contact_last_name, said:\n					               $aop_case_updates_description','<p>Hi $contact_first_name $contact_last_name,</p>\n					    <p> </p>\n					    <p>You\'ve had an update to your case $acase_name (# $acase_case_number) on $aop_case_updates_date_entered:</p>\n					    <p><strong>$user_first_name $user_last_name said:</strong></p>\n					    <p style=\"padding-left:30px;\">$aop_case_updates_description</p>',0,NULL,NULL,'system'),('4a361af4-7ce0-4de0-a361-10421c23957d','2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','off','Joomla Account Creation','Template used when informing a contact that they\'ve been given an account on the joomla portal.','Support Portal Account Created','Hi $contact_name,\n					   An account has been created for you at $portal_address.\n					   You may login using this email address and the password $joomla_pass','<p>Hi $contact_name,</p>\n					    <p>An account has been created for you at <a href=\"$portal_address\">$portal_address</a>.</p>\n					    <p>You may login using this email address and the password $joomla_pass</p>',0,NULL,NULL,'system'),('4ee569f4-a380-4e2d-8e97-e5f37ce65376','2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','off','System-generated password email','This template is used when the System Administrator sends a new password to a user.','New account information','\nHere is your account username and temporary password:\nUsername : $contact_user_user_name\nPassword : $contact_user_user_hash\n\n$config_site_url\n\nAfter you log in using the above password, you may be required to reset the password to one of your own choice.','<div><table width=\"550\"><tbody><tr><td><p>Here is your account username and temporary password:</p><p>Username : $contact_user_user_name </p><p>Password : $contact_user_user_hash </p><br /><p>$config_site_url</p><br /><p>After you log in using the above password, you may be required to reset the password to one of your own choice.</p>   </td>         </tr><tr><td></td>         </tr> </tbody></table> </div>',0,NULL,0,'system'),('54239178-4e33-4b42-824a-239cc4c731ab','2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','off','User Case Update','Email template to send to a SuiteCRM user when their case is updated.','$acase_name (# $acase_case_number) update','Hi $user_first_name $user_last_name,\n\n					   You\'ve had an update to your case $acase_name (# $acase_case_number) on $aop_case_updates_date_entered:\n					       $contact_first_name $contact_last_name, said:\n					               $aop_case_updates_description\n                        You may review this Case at:\n                            $sugarurl/index.php?module=Cases&action=DetailView&record=$acase_id;','<p>Hi $user_first_name $user_last_name,</p>\n					     <p> </p>\n					     <p>You\'ve had an update to your case $acase_name (# $acase_case_number) on $aop_case_updates_date_entered:</p>\n					     <p><strong>$contact_first_name $contact_last_name, said:</strong></p>\n					     <p style=\"padding-left:30px;\">$aop_case_updates_description</p>\n					     <p>You may review this Case at: $sugarurl/index.php?module=Cases&action=DetailView&record=$acase_id;</p>',0,NULL,NULL,'system'),('93085d2f-730e-4052-bf0d-6174c8ff9d44','2013-05-24 14:31:45','2026-05-12 09:18:36','1','1','off','Event Invite Template','Default event invite template.','You have been invited to $fp_events_name','Dear $contact_name,\nYou have been invited to $fp_events_name on $fp_events_date_start to $fp_events_date_end\n$fp_events_description\nYours Sincerely,\n','\n<p>Dear $contact_name,</p>\n<p>You have been invited to $fp_events_name on $fp_events_date_start to $fp_events_date_end</p>\n<p>$fp_events_description</p>\n<p>If you would like to accept this invititation please click accept.</p>\n<p> $fp_events_link or $fp_events_link_declined</p>\n<p>Yours Sincerely,</p>\n',0,NULL,NULL,'system'),('c4fbe18b-7fde-4a28-b1ce-2af476d61118','2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','off','Two Factor Authentication email','This template is used to send a user a code for Two Factor Authentication.','Two Factor Authentication Code','Two Factor Authentication code is $code.','<div><table width=\"550\"><tbody><tr><td><p>Two Factor Authentication code is <b>$code</b>.</p>  </td>         </tr><tr><td></td>         </tr> </tbody></table> </div>',0,NULL,0,'system'),('d442523c-80be-418b-9981-a8ab0f752acf','2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','off','Forgot Password email','This template is used to send a user a link to click to reset the user\'s account password.','Reset your account password','\nYou recently requested on $contact_user_pwd_last_changed to be able to reset your account password.\n\nClick on the link below to reset your password:\n\n$contact_user_link_guid','<div><table width=\"550\"><tbody><tr><td><p>You recently requested on $contact_user_pwd_last_changed to be able to reset your account password. </p><p>Click on the link below to reset your password:</p><p> $contact_user_link_guid </p>  </td>         </tr><tr><td></td>         </tr> </tbody></table> </div>',0,NULL,0,'system'),('d7b4245a-e78a-4c01-b22c-3e7e430922b0','2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','off','Case Closure','Template for informing a contact that their case has been closed.','$acase_name [CASE:$acase_case_number] closed','Hi $contact_first_name $contact_last_name,\n\n					   Your case $acase_name (# $acase_case_number) has been closed on $acase_date_entered\n					   Status:				$acase_status\n					   Reference:			$acase_case_number\n					   Resolution:			$acase_resolution','<p> Hi $contact_first_name $contact_last_name,</p>\n					    <p>Your case $acase_name (# $acase_case_number) has been closed on $acase_date_entered</p>\n					    <table border=\"0\"><tbody>\n					    <tr><td>Status</td><td>$acase_status</td></tr>\n					    <tr><td>Reference</td><td>$acase_case_number</td></tr>\n					    <tr><td>Resolution</td><td>$acase_resolution</td></tr>\n					    </tbody></table>',0,NULL,NULL,'system'),('e62bb54f-2f0d-49e3-978c-b153ab1ae71a','2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','off','Confirmed Opt In','Email template to send to a contact to confirm they have opted in.','Confirm Opt In','Hi $contact_first_name $contact_last_name, \\n Please confirm that you have opted in by selecting the following link: $sugarurl/index.php?entryPoint=ConfirmOptIn&from=$emailaddress_email_address','<p>Hi $contact_first_name $contact_last_name,</p>\n             <p>\n                Please confirm that you have opted in by selecting the following link:\n                <a href=\"$sugarurl/index.php?entryPoint=ConfirmOptIn&from=$emailaddress_confirm_opt_in_token\">Opt In</a>\n             </p>',0,NULL,NULL,'system');
/*!40000 ALTER TABLE `email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emailman`
--

DROP TABLE IF EXISTS `emailman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emailman` (
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `campaign_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `marketing_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `list_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `send_date_time` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `in_queue` tinyint(1) DEFAULT '0',
  `in_queue_date` datetime DEFAULT NULL,
  `send_attempts` int DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `related_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_confirm_opt_in` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_eman_list` (`list_id`,`user_id`,`deleted`),
  KEY `idx_eman_campaign_id` (`campaign_id`),
  KEY `idx_eman_relid_reltype_id` (`related_id`,`related_type`,`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emailman`
--

LOCK TABLES `emailman` WRITE;
/*!40000 ALTER TABLE `emailman` DISABLE KEYS */;
/*!40000 ALTER TABLE `emailman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emails` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `orphaned` tinyint(1) DEFAULT NULL,
  `last_synced` datetime DEFAULT NULL,
  `date_sent_received` datetime DEFAULT NULL,
  `message_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `flagged` tinyint(1) DEFAULT NULL,
  `reply_to_status` tinyint(1) DEFAULT NULL,
  `intent` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'pick',
  `mailbox_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_email_name` (`name`),
  KEY `idx_message_id` (`message_id`),
  KEY `idx_email_parent_id` (`parent_id`),
  KEY `idx_email_assigned` (`assigned_user_id`,`type`,`status`),
  KEY `idx_email_cat` (`category_id`),
  KEY `idx_email_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails_beans`
--

DROP TABLE IF EXISTS `emails_beans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emails_beans` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `email_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bean_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bean_module` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `campaign_data` text COLLATE utf8mb4_general_ci,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_emails_beans_bean_id` (`bean_id`),
  KEY `idx_emails_beans_email_bean` (`email_id`,`bean_id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails_beans`
--

LOCK TABLES `emails_beans` WRITE;
/*!40000 ALTER TABLE `emails_beans` DISABLE KEYS */;
/*!40000 ALTER TABLE `emails_beans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails_email_addr_rel`
--

DROP TABLE IF EXISTS `emails_email_addr_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emails_email_addr_rel` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `email_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `address_type` varchar(4) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_address_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_eearl_email_id` (`email_id`,`address_type`),
  KEY `idx_eearl_address_id` (`email_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails_email_addr_rel`
--

LOCK TABLES `emails_email_addr_rel` WRITE;
/*!40000 ALTER TABLE `emails_email_addr_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `emails_email_addr_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails_text`
--

DROP TABLE IF EXISTS `emails_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emails_text` (
  `email_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `from_addr` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reply_to_addr` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `to_addrs` text COLLATE utf8mb4_general_ci,
  `cc_addrs` text COLLATE utf8mb4_general_ci,
  `bcc_addrs` text COLLATE utf8mb4_general_ci,
  `description` longtext COLLATE utf8mb4_general_ci,
  `description_html` longtext COLLATE utf8mb4_general_ci,
  `raw_source` longtext COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`email_id`),
  KEY `emails_textfromaddr` (`from_addr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails_text`
--

LOCK TABLES `emails_text` WRITE;
/*!40000 ALTER TABLE `emails_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `emails_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_oauth_connections`
--

DROP TABLE IF EXISTS `external_oauth_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_oauth_connections` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client_secret` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `token_type` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `expires_in` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `access_token` text COLLATE utf8mb4_general_ci,
  `refresh_token` text COLLATE utf8mb4_general_ci,
  `external_oauth_provider_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_oauth_connections`
--

LOCK TABLES `external_oauth_connections` WRITE;
/*!40000 ALTER TABLE `external_oauth_connections` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_oauth_connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_oauth_providers`
--

DROP TABLE IF EXISTS `external_oauth_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_oauth_providers` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `connector` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `redirect_uri_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'pretty_url',
  `client_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client_secret` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `scope` text COLLATE utf8mb4_general_ci,
  `url_authorize` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `authorize_url_options` text COLLATE utf8mb4_general_ci,
  `url_access_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `extra_provider_params` text COLLATE utf8mb4_general_ci,
  `get_token_request_grant` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'authorization_code',
  `get_token_request_options` text COLLATE utf8mb4_general_ci,
  `refresh_token_request_grant` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'refresh_token',
  `refresh_token_request_options` text COLLATE utf8mb4_general_ci,
  `access_token_mapping` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'access_token',
  `expires_in_mapping` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'expires_in',
  `refresh_token_mapping` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'refresh_token',
  `token_type_mapping` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_oauth_providers`
--

LOCK TABLES `external_oauth_providers` WRITE;
/*!40000 ALTER TABLE `external_oauth_providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_oauth_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields_meta_data`
--

DROP TABLE IF EXISTS `fields_meta_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fields_meta_data` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vname` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `help` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `custom_module` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `len` int DEFAULT NULL,
  `required` tinyint(1) DEFAULT '0',
  `default_value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `audited` tinyint(1) DEFAULT '0',
  `massupdate` tinyint(1) DEFAULT '0',
  `duplicate_merge` smallint DEFAULT '0',
  `reportable` tinyint(1) DEFAULT '1',
  `importable` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ext1` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ext2` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ext3` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ext4` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_meta_id_del` (`id`,`deleted`),
  KEY `idx_meta_cm_del` (`custom_module`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields_meta_data`
--

LOCK TABLES `fields_meta_data` WRITE;
/*!40000 ALTER TABLE `fields_meta_data` DISABLE KEYS */;
INSERT INTO `fields_meta_data` VALUES ('Accountsjjwg_maps_address_c','jjwg_maps_address_c','LBL_JJWG_MAPS_ADDRESS','Address','Address','Accounts','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Accountsjjwg_maps_geocode_status_c','jjwg_maps_geocode_status_c','LBL_JJWG_MAPS_GEOCODE_STATUS','Geocode Status','Geocode Status','Accounts','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Accountsjjwg_maps_lat_c','jjwg_maps_lat_c','LBL_JJWG_MAPS_LAT','','Latitude','Accounts','float',10,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Accountsjjwg_maps_lng_c','jjwg_maps_lng_c','LBL_JJWG_MAPS_LNG','','Longitude','Accounts','float',11,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Casesjjwg_maps_address_c','jjwg_maps_address_c','LBL_JJWG_MAPS_ADDRESS','Address','Address','Cases','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Casesjjwg_maps_geocode_status_c','jjwg_maps_geocode_status_c','LBL_JJWG_MAPS_GEOCODE_STATUS','Geocode Status','Geocode Status','Cases','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Casesjjwg_maps_lat_c','jjwg_maps_lat_c','LBL_JJWG_MAPS_LAT','','Latitude','Cases','float',10,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Casesjjwg_maps_lng_c','jjwg_maps_lng_c','LBL_JJWG_MAPS_LNG','','Longitude','Cases','float',11,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Contactsjjwg_maps_address_c','jjwg_maps_address_c','LBL_JJWG_MAPS_ADDRESS','Address','Address','Contacts','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Contactsjjwg_maps_geocode_status_c','jjwg_maps_geocode_status_c','LBL_JJWG_MAPS_GEOCODE_STATUS','Geocode Status','Geocode Status','Contacts','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Contactsjjwg_maps_lat_c','jjwg_maps_lat_c','LBL_JJWG_MAPS_LAT','','Latitude','Contacts','float',10,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Contactsjjwg_maps_lng_c','jjwg_maps_lng_c','LBL_JJWG_MAPS_LNG','','Longitude','Contacts','float',11,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Leadsjjwg_maps_address_c','jjwg_maps_address_c','LBL_JJWG_MAPS_ADDRESS','Address','Address','Leads','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Leadsjjwg_maps_geocode_status_c','jjwg_maps_geocode_status_c','LBL_JJWG_MAPS_GEOCODE_STATUS','Geocode Status','Geocode Status','Leads','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Leadsjjwg_maps_lat_c','jjwg_maps_lat_c','LBL_JJWG_MAPS_LAT','','Latitude','Leads','float',10,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Leadsjjwg_maps_lng_c','jjwg_maps_lng_c','LBL_JJWG_MAPS_LNG','','Longitude','Leads','float',11,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Meetingsjjwg_maps_address_c','jjwg_maps_address_c','LBL_JJWG_MAPS_ADDRESS','Address','Address','Meetings','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Meetingsjjwg_maps_geocode_status_c','jjwg_maps_geocode_status_c','LBL_JJWG_MAPS_GEOCODE_STATUS','Geocode Status','Geocode Status','Meetings','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Meetingsjjwg_maps_lat_c','jjwg_maps_lat_c','LBL_JJWG_MAPS_LAT','','Latitude','Meetings','float',10,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Meetingsjjwg_maps_lng_c','jjwg_maps_lng_c','LBL_JJWG_MAPS_LNG','','Longitude','Meetings','float',11,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Opportunitiesjjwg_maps_address_c','jjwg_maps_address_c','LBL_JJWG_MAPS_ADDRESS','Address','Address','Opportunities','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Opportunitiesjjwg_maps_geocode_status_c','jjwg_maps_geocode_status_c','LBL_JJWG_MAPS_GEOCODE_STATUS','Geocode Status','Geocode Status','Opportunities','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Opportunitiesjjwg_maps_lat_c','jjwg_maps_lat_c','LBL_JJWG_MAPS_LAT','','Latitude','Opportunities','float',10,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Opportunitiesjjwg_maps_lng_c','jjwg_maps_lng_c','LBL_JJWG_MAPS_LNG','','Longitude','Opportunities','float',11,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Projectjjwg_maps_address_c','jjwg_maps_address_c','LBL_JJWG_MAPS_ADDRESS','Address','Address','Project','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Projectjjwg_maps_geocode_status_c','jjwg_maps_geocode_status_c','LBL_JJWG_MAPS_GEOCODE_STATUS','Geocode Status','Geocode Status','Project','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Projectjjwg_maps_lat_c','jjwg_maps_lat_c','LBL_JJWG_MAPS_LAT','','Latitude','Project','float',10,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Projectjjwg_maps_lng_c','jjwg_maps_lng_c','LBL_JJWG_MAPS_LNG','','Longitude','Project','float',11,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Prospectsjjwg_maps_address_c','jjwg_maps_address_c','LBL_JJWG_MAPS_ADDRESS','Address','Address','Prospects','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Prospectsjjwg_maps_geocode_status_c','jjwg_maps_geocode_status_c','LBL_JJWG_MAPS_GEOCODE_STATUS','Geocode Status','Geocode Status','Prospects','varchar',255,0,NULL,'2026-05-12 09:18:36',0,0,0,0,1,'true',NULL,'','',''),('Prospectsjjwg_maps_lat_c','jjwg_maps_lat_c','LBL_JJWG_MAPS_LAT','','Latitude','Prospects','float',10,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','',''),('Prospectsjjwg_maps_lng_c','jjwg_maps_lng_c','LBL_JJWG_MAPS_LNG','','Longitude','Prospects','float',11,0,'0.00000000','2026-05-12 09:18:36',0,0,0,0,1,'true','8','','','');
/*!40000 ALTER TABLE `fields_meta_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folders`
--

DROP TABLE IF EXISTS `folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `folders` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `folder_type` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_folder` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `has_child` tinyint(1) DEFAULT '0',
  `is_group` tinyint(1) DEFAULT '0',
  `is_dynamic` tinyint(1) DEFAULT '0',
  `dynamic_query` text COLLATE utf8mb4_general_ci,
  `assign_to_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `modified_by` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_parent_folder` (`parent_folder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folders`
--

LOCK TABLES `folders` WRITE;
/*!40000 ALTER TABLE `folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folders_rel`
--

DROP TABLE IF EXISTS `folders_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `folders_rel` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `folder_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `polymorphic_module` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `polymorphic_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_poly_module_poly_id` (`polymorphic_module`,`polymorphic_id`),
  KEY `idx_fr_id_deleted_poly` (`folder_id`,`deleted`,`polymorphic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folders_rel`
--

LOCK TABLES `folders_rel` WRITE;
/*!40000 ALTER TABLE `folders_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `folders_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folders_subscriptions`
--

DROP TABLE IF EXISTS `folders_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `folders_subscriptions` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `folder_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_folder_id_assigned_user_id` (`folder_id`,`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folders_subscriptions`
--

LOCK TABLES `folders_subscriptions` WRITE;
/*!40000 ALTER TABLE `folders_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `folders_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_event_locations`
--

DROP TABLE IF EXISTS `fp_event_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fp_event_locations` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_country` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `capacity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_event_locations`
--

LOCK TABLES `fp_event_locations` WRITE;
/*!40000 ALTER TABLE `fp_event_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_event_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_event_locations_audit`
--

DROP TABLE IF EXISTS `fp_event_locations_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fp_event_locations_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_fp_event_locations_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_event_locations_audit`
--

LOCK TABLES `fp_event_locations_audit` WRITE;
/*!40000 ALTER TABLE `fp_event_locations_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_event_locations_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_event_locations_fp_events_1_c`
--

DROP TABLE IF EXISTS `fp_event_locations_fp_events_1_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fp_event_locations_fp_events_1_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `fp_event_locations_fp_events_1fp_event_locations_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fp_event_locations_fp_events_1fp_events_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fp_event_locations_fp_events_1_ida1` (`fp_event_locations_fp_events_1fp_event_locations_ida`),
  KEY `fp_event_locations_fp_events_1_alt` (`fp_event_locations_fp_events_1fp_events_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_event_locations_fp_events_1_c`
--

LOCK TABLES `fp_event_locations_fp_events_1_c` WRITE;
/*!40000 ALTER TABLE `fp_event_locations_fp_events_1_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_event_locations_fp_events_1_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_events`
--

DROP TABLE IF EXISTS `fp_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fp_events` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `duration_hours` int DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `budget` decimal(26,6) DEFAULT NULL,
  `currency_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `invite_templates` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `accept_redirect` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decline_redirect` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `activity_status_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_events`
--

LOCK TABLES `fp_events` WRITE;
/*!40000 ALTER TABLE `fp_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_events_audit`
--

DROP TABLE IF EXISTS `fp_events_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fp_events_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_fp_events_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_events_audit`
--

LOCK TABLES `fp_events_audit` WRITE;
/*!40000 ALTER TABLE `fp_events_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_events_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_events_contacts_c`
--

DROP TABLE IF EXISTS `fp_events_contacts_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fp_events_contacts_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `fp_events_contactsfp_events_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fp_events_contactscontacts_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `invite_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'Not Invited',
  `accept_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'No Response',
  `email_responded` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fp_events_contacts_alt` (`fp_events_contactsfp_events_ida`,`fp_events_contactscontacts_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_events_contacts_c`
--

LOCK TABLES `fp_events_contacts_c` WRITE;
/*!40000 ALTER TABLE `fp_events_contacts_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_events_contacts_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_events_fp_event_delegates_1_c`
--

DROP TABLE IF EXISTS `fp_events_fp_event_delegates_1_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fp_events_fp_event_delegates_1_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `fp_events_fp_event_delegates_1fp_events_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fp_events_fp_event_delegates_1fp_event_delegates_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fp_events_fp_event_delegates_1_ida1` (`fp_events_fp_event_delegates_1fp_events_ida`),
  KEY `fp_events_fp_event_delegates_1_alt` (`fp_events_fp_event_delegates_1fp_event_delegates_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_events_fp_event_delegates_1_c`
--

LOCK TABLES `fp_events_fp_event_delegates_1_c` WRITE;
/*!40000 ALTER TABLE `fp_events_fp_event_delegates_1_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_events_fp_event_delegates_1_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_events_fp_event_locations_1_c`
--

DROP TABLE IF EXISTS `fp_events_fp_event_locations_1_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fp_events_fp_event_locations_1_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `fp_events_fp_event_locations_1fp_events_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fp_events_fp_event_locations_1fp_event_locations_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fp_events_fp_event_locations_1_alt` (`fp_events_fp_event_locations_1fp_events_ida`,`fp_events_fp_event_locations_1fp_event_locations_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_events_fp_event_locations_1_c`
--

LOCK TABLES `fp_events_fp_event_locations_1_c` WRITE;
/*!40000 ALTER TABLE `fp_events_fp_event_locations_1_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_events_fp_event_locations_1_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_events_leads_1_c`
--

DROP TABLE IF EXISTS `fp_events_leads_1_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fp_events_leads_1_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `fp_events_leads_1fp_events_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fp_events_leads_1leads_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `invite_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'Not Invited',
  `accept_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'No Response',
  `email_responded` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fp_events_leads_1_alt` (`fp_events_leads_1fp_events_ida`,`fp_events_leads_1leads_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_events_leads_1_c`
--

LOCK TABLES `fp_events_leads_1_c` WRITE;
/*!40000 ALTER TABLE `fp_events_leads_1_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_events_leads_1_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_events_prospects_1_c`
--

DROP TABLE IF EXISTS `fp_events_prospects_1_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fp_events_prospects_1_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `fp_events_prospects_1fp_events_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fp_events_prospects_1prospects_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `invite_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'Not Invited',
  `accept_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'No Response',
  `email_responded` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fp_events_prospects_1_alt` (`fp_events_prospects_1fp_events_ida`,`fp_events_prospects_1prospects_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_events_prospects_1_c`
--

LOCK TABLES `fp_events_prospects_1_c` WRITE;
/*!40000 ALTER TABLE `fp_events_prospects_1_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_events_prospects_1_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_maps`
--

DROP TABLE IF EXISTS `import_maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import_maps` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(254) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `enclosure` varchar(1) COLLATE utf8mb4_general_ci DEFAULT ' ',
  `delimiter` varchar(1) COLLATE utf8mb4_general_ci DEFAULT ',',
  `module` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_general_ci,
  `default_values` text COLLATE utf8mb4_general_ci,
  `has_header` tinyint(1) DEFAULT '1',
  `deleted` tinyint(1) DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_published` varchar(3) COLLATE utf8mb4_general_ci DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `idx_owner_module_name` (`assigned_user_id`,`module`,`name`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_maps`
--

LOCK TABLES `import_maps` WRITE;
/*!40000 ALTER TABLE `import_maps` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbound_email`
--

DROP TABLE IF EXISTS `inbound_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inbound_email` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `last_import_run_datetime` datetime DEFAULT NULL,
  `mailbox_last_imported_days` text COLLATE utf8mb4_general_ci,
  `email_import_per_run_threshold` int DEFAULT NULL,
  `email_import_timeframe_start` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_import_unread_only` tinyint(1) DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Active',
  `email_body_filtering` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'multi',
  `server_url` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `connection_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_user` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_password` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `port` int DEFAULT '143',
  `service` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mailbox` text COLLATE utf8mb4_general_ci,
  `sentFolder` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `trashFolder` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `delete_seen` tinyint(1) DEFAULT '0',
  `move_messages_to_trash_after_import` tinyint(1) DEFAULT '0',
  `mailbox_type` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `template_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `stored_options` text COLLATE utf8mb4_general_ci,
  `group_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_personal` tinyint(1) DEFAULT '0',
  `groupfolder_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `auth_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'basic',
  `protocol` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'imap',
  `is_ssl` tinyint(1) DEFAULT '0',
  `distribution_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `outbound_email_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_case_template_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `external_oauth_connection_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbound_email`
--

LOCK TABLES `inbound_email` WRITE;
/*!40000 ALTER TABLE `inbound_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbound_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbound_email_autoreply`
--

DROP TABLE IF EXISTS `inbound_email_autoreply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inbound_email_autoreply` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `autoreplied_to` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ie_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ie_autoreplied_to` (`autoreplied_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbound_email_autoreply`
--

LOCK TABLES `inbound_email_autoreply` WRITE;
/*!40000 ALTER TABLE `inbound_email_autoreply` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbound_email_autoreply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbound_email_cache_ts`
--

DROP TABLE IF EXISTS `inbound_email_cache_ts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inbound_email_cache_ts` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `ie_timestamp` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbound_email_cache_ts`
--

LOCK TABLES `inbound_email_cache_ts` WRITE;
/*!40000 ALTER TABLE `inbound_email_cache_ts` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbound_email_cache_ts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjwg_address_cache`
--

DROP TABLE IF EXISTS `jjwg_address_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jjwg_address_cache` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lat` float(10,8) DEFAULT NULL,
  `lng` float(11,8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjwg_address_cache`
--

LOCK TABLES `jjwg_address_cache` WRITE;
/*!40000 ALTER TABLE `jjwg_address_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjwg_address_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjwg_address_cache_audit`
--

DROP TABLE IF EXISTS `jjwg_address_cache_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jjwg_address_cache_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_jjwg_address_cache_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjwg_address_cache_audit`
--

LOCK TABLES `jjwg_address_cache_audit` WRITE;
/*!40000 ALTER TABLE `jjwg_address_cache_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjwg_address_cache_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjwg_areas`
--

DROP TABLE IF EXISTS `jjwg_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jjwg_areas` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `coordinates` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjwg_areas`
--

LOCK TABLES `jjwg_areas` WRITE;
/*!40000 ALTER TABLE `jjwg_areas` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjwg_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjwg_areas_audit`
--

DROP TABLE IF EXISTS `jjwg_areas_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jjwg_areas_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_jjwg_areas_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjwg_areas_audit`
--

LOCK TABLES `jjwg_areas_audit` WRITE;
/*!40000 ALTER TABLE `jjwg_areas_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjwg_areas_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjwg_maps`
--

DROP TABLE IF EXISTS `jjwg_maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jjwg_maps` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `distance` float(9,4) DEFAULT NULL,
  `unit_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'mi',
  `module_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Accounts',
  `parent_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjwg_maps`
--

LOCK TABLES `jjwg_maps` WRITE;
/*!40000 ALTER TABLE `jjwg_maps` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjwg_maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjwg_maps_audit`
--

DROP TABLE IF EXISTS `jjwg_maps_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jjwg_maps_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_jjwg_maps_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjwg_maps_audit`
--

LOCK TABLES `jjwg_maps_audit` WRITE;
/*!40000 ALTER TABLE `jjwg_maps_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjwg_maps_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjwg_maps_jjwg_areas_c`
--

DROP TABLE IF EXISTS `jjwg_maps_jjwg_areas_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jjwg_maps_jjwg_areas_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `jjwg_maps_5304wg_maps_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_41f2g_areas_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jjwg_maps_jjwg_areas_alt` (`jjwg_maps_5304wg_maps_ida`,`jjwg_maps_41f2g_areas_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjwg_maps_jjwg_areas_c`
--

LOCK TABLES `jjwg_maps_jjwg_areas_c` WRITE;
/*!40000 ALTER TABLE `jjwg_maps_jjwg_areas_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjwg_maps_jjwg_areas_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjwg_maps_jjwg_markers_c`
--

DROP TABLE IF EXISTS `jjwg_maps_jjwg_markers_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jjwg_maps_jjwg_markers_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `jjwg_maps_b229wg_maps_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_2e31markers_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jjwg_maps_jjwg_markers_alt` (`jjwg_maps_b229wg_maps_ida`,`jjwg_maps_2e31markers_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjwg_maps_jjwg_markers_c`
--

LOCK TABLES `jjwg_maps_jjwg_markers_c` WRITE;
/*!40000 ALTER TABLE `jjwg_maps_jjwg_markers_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjwg_maps_jjwg_markers_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjwg_markers`
--

DROP TABLE IF EXISTS `jjwg_markers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jjwg_markers` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_lat` float(10,8) DEFAULT '0.00000000',
  `jjwg_maps_lng` float(11,8) DEFAULT '0.00000000',
  `marker_image` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'company',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjwg_markers`
--

LOCK TABLES `jjwg_markers` WRITE;
/*!40000 ALTER TABLE `jjwg_markers` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjwg_markers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjwg_markers_audit`
--

DROP TABLE IF EXISTS `jjwg_markers_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jjwg_markers_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_jjwg_markers_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjwg_markers_audit`
--

LOCK TABLES `jjwg_markers_audit` WRITE;
/*!40000 ALTER TABLE `jjwg_markers_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjwg_markers_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_queue`
--

DROP TABLE IF EXISTS `job_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_queue` (
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `scheduler_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `execute_time` datetime DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `resolution` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci,
  `target` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data` text COLLATE utf8mb4_general_ci,
  `requeue` tinyint(1) DEFAULT '0',
  `retry_count` tinyint DEFAULT NULL,
  `failure_count` tinyint DEFAULT NULL,
  `job_delay` int DEFAULT NULL,
  `client` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `percent_complete` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_status_scheduler` (`status`,`scheduler_id`),
  KEY `idx_status_time` (`status`,`execute_time`,`date_entered`),
  KEY `idx_status_entered` (`status`,`date_entered`),
  KEY `idx_status_modified` (`status`,`date_modified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_queue`
--

LOCK TABLES `job_queue` WRITE;
/*!40000 ALTER TABLE `job_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leads`
--

DROP TABLE IF EXISTS `leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leads` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `salutation` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `department` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `do_not_call` tinyint(1) DEFAULT '0',
  `phone_home` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_mobile` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_work` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_other` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_fax` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lawful_basis` text COLLATE utf8mb4_general_ci,
  `date_reviewed` date DEFAULT NULL,
  `lawful_basis_source` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assistant` varchar(75) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assistant_phone` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `converted` tinyint(1) DEFAULT '0',
  `refered_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lead_source` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lead_source_description` text COLLATE utf8mb4_general_ci,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_description` text COLLATE utf8mb4_general_ci,
  `reports_to_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_description` text COLLATE utf8mb4_general_ci,
  `contact_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `opportunity_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `opportunity_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `opportunity_amount` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `campaign_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `portal_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `portal_app` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_lead_acct_name_first` (`account_name`,`deleted`),
  KEY `idx_lead_last_first` (`last_name`,`first_name`,`deleted`),
  KEY `idx_lead_del_stat` (`last_name`,`status`,`deleted`,`first_name`),
  KEY `idx_lead_opp_del` (`opportunity_id`,`deleted`),
  KEY `idx_leads_acct_del` (`account_id`,`deleted`),
  KEY `idx_del_user` (`deleted`,`assigned_user_id`),
  KEY `idx_lead_assigned` (`assigned_user_id`),
  KEY `idx_lead_contact` (`contact_id`),
  KEY `idx_reports_to` (`reports_to_id`),
  KEY `idx_lead_phone_work` (`phone_work`),
  KEY `idx_leads_id_del` (`id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leads`
--

LOCK TABLES `leads` WRITE;
/*!40000 ALTER TABLE `leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `leads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leads_audit`
--

DROP TABLE IF EXISTS `leads_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leads_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_leads_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leads_audit`
--

LOCK TABLES `leads_audit` WRITE;
/*!40000 ALTER TABLE `leads_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `leads_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leads_cstm`
--

DROP TABLE IF EXISTS `leads_cstm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leads_cstm` (
  `id_c` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `jjwg_maps_lng_c` float(11,8) DEFAULT '0.00000000',
  `jjwg_maps_lat_c` float(10,8) DEFAULT '0.00000000',
  `jjwg_maps_geocode_status_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_address_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leads_cstm`
--

LOCK TABLES `leads_cstm` WRITE;
/*!40000 ALTER TABLE `leads_cstm` DISABLE KEYS */;
/*!40000 ALTER TABLE `leads_cstm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `linked_documents`
--

DROP TABLE IF EXISTS `linked_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linked_documents` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_type` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_revision_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_parent_document` (`parent_type`,`parent_id`,`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linked_documents`
--

LOCK TABLES `linked_documents` WRITE;
/*!40000 ALTER TABLE `linked_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `linked_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetings`
--

DROP TABLE IF EXISTS `meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meetings` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `location` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `join_url` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `host_url` varchar(400) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `displayed_url` varchar(400) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `creator` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `external_id` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `duration_hours` int DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Planned',
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'Sugar',
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reminder_time` int DEFAULT '-1',
  `email_reminder_time` int DEFAULT '-1',
  `email_reminder_sent` tinyint(1) DEFAULT '0',
  `outlook_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sequence` int DEFAULT '0',
  `repeat_type` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `repeat_interval` int DEFAULT '1',
  `repeat_dow` varchar(7) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `repeat_until` date DEFAULT NULL,
  `repeat_count` int DEFAULT NULL,
  `repeat_parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `recurring_source` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gsync_id` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gsync_lastsync` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_mtg_name` (`name`),
  KEY `idx_meet_par_del` (`parent_id`,`parent_type`,`deleted`),
  KEY `idx_meet_stat_del` (`assigned_user_id`,`status`,`deleted`),
  KEY `idx_meet_date_start` (`date_start`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings`
--

LOCK TABLES `meetings` WRITE;
/*!40000 ALTER TABLE `meetings` DISABLE KEYS */;
/*!40000 ALTER TABLE `meetings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetings_contacts`
--

DROP TABLE IF EXISTS `meetings_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meetings_contacts` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `meeting_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `required` varchar(1) COLLATE utf8mb4_general_ci DEFAULT '1',
  `accept_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'none',
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_con_mtg_mtg` (`meeting_id`),
  KEY `idx_con_mtg_con` (`contact_id`),
  KEY `idx_meeting_contact` (`meeting_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings_contacts`
--

LOCK TABLES `meetings_contacts` WRITE;
/*!40000 ALTER TABLE `meetings_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `meetings_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetings_cstm`
--

DROP TABLE IF EXISTS `meetings_cstm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meetings_cstm` (
  `id_c` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `jjwg_maps_lng_c` float(11,8) DEFAULT '0.00000000',
  `jjwg_maps_lat_c` float(10,8) DEFAULT '0.00000000',
  `jjwg_maps_geocode_status_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_address_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings_cstm`
--

LOCK TABLES `meetings_cstm` WRITE;
/*!40000 ALTER TABLE `meetings_cstm` DISABLE KEYS */;
/*!40000 ALTER TABLE `meetings_cstm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetings_leads`
--

DROP TABLE IF EXISTS `meetings_leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meetings_leads` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `meeting_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lead_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `required` varchar(1) COLLATE utf8mb4_general_ci DEFAULT '1',
  `accept_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'none',
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lead_meeting_meeting` (`meeting_id`),
  KEY `idx_lead_meeting_lead` (`lead_id`),
  KEY `idx_meeting_lead` (`meeting_id`,`lead_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings_leads`
--

LOCK TABLES `meetings_leads` WRITE;
/*!40000 ALTER TABLE `meetings_leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `meetings_leads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetings_users`
--

DROP TABLE IF EXISTS `meetings_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meetings_users` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `meeting_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `required` varchar(1) COLLATE utf8mb4_general_ci DEFAULT '1',
  `accept_status` varchar(25) COLLATE utf8mb4_general_ci DEFAULT 'none',
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_usr_mtg_mtg` (`meeting_id`),
  KEY `idx_usr_mtg_usr` (`user_id`),
  KEY `idx_meeting_users` (`meeting_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings_users`
--

LOCK TABLES `meetings_users` WRITE;
/*!40000 ALTER TABLE `meetings_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `meetings_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `file_mime_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `portal_flag` tinyint(1) DEFAULT NULL,
  `embed_flag` tinyint(1) DEFAULT '0',
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_note_name` (`name`),
  KEY `idx_notes_parent` (`parent_id`,`parent_type`),
  KEY `idx_note_contact` (`contact_id`),
  KEY `idx_notes_assigned_del` (`deleted`,`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2authcodes`
--

DROP TABLE IF EXISTS `oauth2authcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2authcodes` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `auth_code_is_revoked` tinyint(1) DEFAULT NULL,
  `auto_authorize` tinyint(1) DEFAULT NULL,
  `auth_code_expires` datetime DEFAULT NULL,
  `auth_code` varchar(4000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2authcodes`
--

LOCK TABLES `oauth2authcodes` WRITE;
/*!40000 ALTER TABLE `oauth2authcodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2authcodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2clients`
--

DROP TABLE IF EXISTS `oauth2clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2clients` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `secret` varchar(4000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `redirect_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_confidential` tinyint(1) DEFAULT '1',
  `allowed_grant_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'password',
  `duration_value` int DEFAULT NULL,
  `duration_amount` int DEFAULT NULL,
  `duration_unit` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'Duration Unit',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2clients`
--

LOCK TABLES `oauth2clients` WRITE;
/*!40000 ALTER TABLE `oauth2clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2tokens`
--

DROP TABLE IF EXISTS `oauth2tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2tokens` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `token_is_revoked` tinyint(1) DEFAULT NULL,
  `token_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `access_token_expires` datetime DEFAULT NULL,
  `access_token` varchar(4000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `refresh_token` varchar(4000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `refresh_token_expires` datetime DEFAULT NULL,
  `grant_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2tokens`
--

LOCK TABLES `oauth2tokens` WRITE;
/*!40000 ALTER TABLE `oauth2tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_consumer`
--

DROP TABLE IF EXISTS `oauth_consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_consumer` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `c_key` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `c_secret` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ckey` (`c_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_consumer`
--

LOCK TABLES `oauth_consumer` WRITE;
/*!40000 ALTER TABLE `oauth_consumer` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_consumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_nonce`
--

DROP TABLE IF EXISTS `oauth_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_nonce` (
  `conskey` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `nonce` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `nonce_ts` bigint DEFAULT NULL,
  PRIMARY KEY (`conskey`,`nonce`),
  KEY `oauth_nonce_keyts` (`conskey`,`nonce_ts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_nonce`
--

LOCK TABLES `oauth_nonce` WRITE;
/*!40000 ALTER TABLE `oauth_nonce` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_nonce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_tokens`
--

DROP TABLE IF EXISTS `oauth_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_tokens` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `secret` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tstate` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `consumer` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `token_ts` bigint DEFAULT NULL,
  `verify` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `callback_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`,`deleted`),
  KEY `oauth_state_ts` (`tstate`,`token_ts`),
  KEY `constoken_key` (`consumer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_tokens`
--

LOCK TABLES `oauth_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opportunities`
--

DROP TABLE IF EXISTS `opportunities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opportunities` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `opportunity_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `campaign_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lead_source` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `amount_usdollar` double DEFAULT NULL,
  `currency_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_closed` date DEFAULT NULL,
  `next_step` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sales_stage` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `probability` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_opp_name` (`name`),
  KEY `idx_opp_assigned` (`assigned_user_id`),
  KEY `idx_opp_id_deleted` (`id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opportunities`
--

LOCK TABLES `opportunities` WRITE;
/*!40000 ALTER TABLE `opportunities` DISABLE KEYS */;
/*!40000 ALTER TABLE `opportunities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opportunities_audit`
--

DROP TABLE IF EXISTS `opportunities_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opportunities_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_opportunities_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opportunities_audit`
--

LOCK TABLES `opportunities_audit` WRITE;
/*!40000 ALTER TABLE `opportunities_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `opportunities_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opportunities_contacts`
--

DROP TABLE IF EXISTS `opportunities_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opportunities_contacts` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `contact_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `opportunity_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_role` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_con_opp_con` (`contact_id`),
  KEY `idx_con_opp_opp` (`opportunity_id`),
  KEY `idx_opportunities_contacts` (`opportunity_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opportunities_contacts`
--

LOCK TABLES `opportunities_contacts` WRITE;
/*!40000 ALTER TABLE `opportunities_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `opportunities_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opportunities_cstm`
--

DROP TABLE IF EXISTS `opportunities_cstm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opportunities_cstm` (
  `id_c` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `jjwg_maps_lng_c` float(11,8) DEFAULT '0.00000000',
  `jjwg_maps_lat_c` float(10,8) DEFAULT '0.00000000',
  `jjwg_maps_geocode_status_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_address_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opportunities_cstm`
--

LOCK TABLES `opportunities_cstm` WRITE;
/*!40000 ALTER TABLE `opportunities_cstm` DISABLE KEYS */;
/*!40000 ALTER TABLE `opportunities_cstm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outbound_email`
--

DROP TABLE IF EXISTS `outbound_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outbound_email` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(15) COLLATE utf8mb4_general_ci DEFAULT 'user',
  `user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `smtp_from_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `smtp_from_addr` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reply_to_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reply_to_addr` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `signature` text COLLATE utf8mb4_general_ci,
  `mail_sendtype` varchar(8) COLLATE utf8mb4_general_ci DEFAULT 'SMTP',
  `mail_smtptype` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'other',
  `mail_smtpserver` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mail_smtpport` varchar(5) COLLATE utf8mb4_general_ci DEFAULT '25',
  `mail_smtpuser` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mail_smtppass` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mail_smtpauth_req` tinyint(1) DEFAULT '0',
  `mail_smtpssl` varchar(1) COLLATE utf8mb4_general_ci DEFAULT '0',
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `auth_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'no_auth',
  `external_oauth_connection_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbound_email`
--

LOCK TABLES `outbound_email` WRITE;
/*!40000 ALTER TABLE `outbound_email` DISABLE KEYS */;
INSERT INTO `outbound_email` VALUES ('aa2bf2a3-48a5-4e0e-99ba-607f11be434a','system','system','1',NULL,NULL,NULL,NULL,NULL,'SMTP','other','','25','','',1,'0',NULL,NULL,NULL,NULL,0,NULL,'no_auth',NULL);
/*!40000 ALTER TABLE `outbound_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outbound_email_audit`
--

DROP TABLE IF EXISTS `outbound_email_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outbound_email_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_outbound_email_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbound_email_audit`
--

LOCK TABLES `outbound_email_audit` WRITE;
/*!40000 ALTER TABLE `outbound_email_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `outbound_email_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `estimated_start_date` date DEFAULT NULL,
  `estimated_end_date` date DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `priority` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `override_business_hours` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_contacts_1_c`
--

DROP TABLE IF EXISTS `project_contacts_1_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_contacts_1_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `project_contacts_1project_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `project_contacts_1contacts_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_contacts_1_alt` (`project_contacts_1project_ida`,`project_contacts_1contacts_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_contacts_1_c`
--

LOCK TABLES `project_contacts_1_c` WRITE;
/*!40000 ALTER TABLE `project_contacts_1_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_contacts_1_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_cstm`
--

DROP TABLE IF EXISTS `project_cstm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_cstm` (
  `id_c` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `jjwg_maps_lng_c` float(11,8) DEFAULT '0.00000000',
  `jjwg_maps_lat_c` float(10,8) DEFAULT '0.00000000',
  `jjwg_maps_geocode_status_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_address_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_cstm`
--

LOCK TABLES `project_cstm` WRITE;
/*!40000 ALTER TABLE `project_cstm` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_cstm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_task`
--

DROP TABLE IF EXISTS `project_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_task` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `project_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `project_task_id` int DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `relationship_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `predecessors` text COLLATE utf8mb4_general_ci,
  `date_start` date DEFAULT NULL,
  `time_start` int DEFAULT NULL,
  `time_finish` int DEFAULT NULL,
  `date_finish` date DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `duration_unit` text COLLATE utf8mb4_general_ci,
  `actual_duration` int DEFAULT NULL,
  `percent_complete` int DEFAULT NULL,
  `date_due` date DEFAULT NULL,
  `time_due` time DEFAULT NULL,
  `parent_task_id` int DEFAULT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `priority` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `milestone_flag` tinyint(1) DEFAULT NULL,
  `order_number` int DEFAULT '1',
  `task_number` int DEFAULT NULL,
  `estimated_effort` int DEFAULT NULL,
  `actual_effort` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `utilization` int DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_task`
--

LOCK TABLES `project_task` WRITE;
/*!40000 ALTER TABLE `project_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_task_audit`
--

DROP TABLE IF EXISTS `project_task_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_task_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_project_task_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_task_audit`
--

LOCK TABLES `project_task_audit` WRITE;
/*!40000 ALTER TABLE `project_task_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_task_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_users_1_c`
--

DROP TABLE IF EXISTS `project_users_1_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_users_1_c` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `project_users_1project_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `project_users_1users_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_users_1_alt` (`project_users_1project_ida`,`project_users_1users_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_users_1_c`
--

LOCK TABLES `project_users_1_c` WRITE;
/*!40000 ALTER TABLE `project_users_1_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_users_1_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_accounts`
--

DROP TABLE IF EXISTS `projects_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_accounts` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `account_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `project_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_proj_acct_proj` (`project_id`),
  KEY `idx_proj_acct_acct` (`account_id`),
  KEY `projects_accounts_alt` (`project_id`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_accounts`
--

LOCK TABLES `projects_accounts` WRITE;
/*!40000 ALTER TABLE `projects_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_bugs`
--

DROP TABLE IF EXISTS `projects_bugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_bugs` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `bug_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `project_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_proj_bug_proj` (`project_id`),
  KEY `idx_proj_bug_bug` (`bug_id`),
  KEY `projects_bugs_alt` (`project_id`,`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_bugs`
--

LOCK TABLES `projects_bugs` WRITE;
/*!40000 ALTER TABLE `projects_bugs` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects_bugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_cases`
--

DROP TABLE IF EXISTS `projects_cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_cases` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `case_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `project_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_proj_case_proj` (`project_id`),
  KEY `idx_proj_case_case` (`case_id`),
  KEY `projects_cases_alt` (`project_id`,`case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_cases`
--

LOCK TABLES `projects_cases` WRITE;
/*!40000 ALTER TABLE `projects_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects_cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_contacts`
--

DROP TABLE IF EXISTS `projects_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_contacts` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `contact_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `project_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_proj_con_proj` (`project_id`),
  KEY `idx_proj_con_con` (`contact_id`),
  KEY `projects_contacts_alt` (`project_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_contacts`
--

LOCK TABLES `projects_contacts` WRITE;
/*!40000 ALTER TABLE `projects_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_opportunities`
--

DROP TABLE IF EXISTS `projects_opportunities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_opportunities` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `opportunity_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `project_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_proj_opp_proj` (`project_id`),
  KEY `idx_proj_opp_opp` (`opportunity_id`),
  KEY `projects_opportunities_alt` (`project_id`,`opportunity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_opportunities`
--

LOCK TABLES `projects_opportunities` WRITE;
/*!40000 ALTER TABLE `projects_opportunities` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects_opportunities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_products`
--

DROP TABLE IF EXISTS `projects_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_products` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `product_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `project_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_proj_prod_project` (`project_id`),
  KEY `idx_proj_prod_product` (`product_id`),
  KEY `projects_products_alt` (`project_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_products`
--

LOCK TABLES `projects_products` WRITE;
/*!40000 ALTER TABLE `projects_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prospect_list_campaigns`
--

DROP TABLE IF EXISTS `prospect_list_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prospect_list_campaigns` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `prospect_list_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `campaign_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_pro_id` (`prospect_list_id`),
  KEY `idx_cam_id` (`campaign_id`),
  KEY `idx_prospect_list_campaigns` (`prospect_list_id`,`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prospect_list_campaigns`
--

LOCK TABLES `prospect_list_campaigns` WRITE;
/*!40000 ALTER TABLE `prospect_list_campaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `prospect_list_campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prospect_lists`
--

DROP TABLE IF EXISTS `prospect_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prospect_lists` (
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `list_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `domain_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_prospect_list_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prospect_lists`
--

LOCK TABLES `prospect_lists` WRITE;
/*!40000 ALTER TABLE `prospect_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `prospect_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prospect_lists_prospects`
--

DROP TABLE IF EXISTS `prospect_lists_prospects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prospect_lists_prospects` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `prospect_list_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_type` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_plp_pro_id` (`prospect_list_id`,`deleted`),
  KEY `idx_plp_rel_id` (`related_id`,`related_type`,`prospect_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prospect_lists_prospects`
--

LOCK TABLES `prospect_lists_prospects` WRITE;
/*!40000 ALTER TABLE `prospect_lists_prospects` DISABLE KEYS */;
/*!40000 ALTER TABLE `prospect_lists_prospects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prospects`
--

DROP TABLE IF EXISTS `prospects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prospects` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `salutation` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `department` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `do_not_call` tinyint(1) DEFAULT '0',
  `phone_home` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_mobile` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_work` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_other` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_fax` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lawful_basis` text COLLATE utf8mb4_general_ci,
  `date_reviewed` date DEFAULT NULL,
  `lawful_basis_source` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alt_address_country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assistant` varchar(75) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assistant_phone` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tracker_key` int NOT NULL AUTO_INCREMENT,
  `birthdate` date DEFAULT NULL,
  `lead_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `campaign_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prospect_auto_tracker_key` (`tracker_key`),
  KEY `idx_prospects_last_first` (`last_name`,`first_name`,`deleted`),
  KEY `idx_prospecs_del_last` (`last_name`,`deleted`),
  KEY `idx_prospects_id_del` (`id`,`deleted`),
  KEY `idx_prospects_assigned` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prospects`
--

LOCK TABLES `prospects` WRITE;
/*!40000 ALTER TABLE `prospects` DISABLE KEYS */;
/*!40000 ALTER TABLE `prospects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prospects_cstm`
--

DROP TABLE IF EXISTS `prospects_cstm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prospects_cstm` (
  `id_c` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `jjwg_maps_lng_c` float(11,8) DEFAULT '0.00000000',
  `jjwg_maps_lat_c` float(10,8) DEFAULT '0.00000000',
  `jjwg_maps_geocode_status_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jjwg_maps_address_c` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prospects_cstm`
--

LOCK TABLES `prospects_cstm` WRITE;
/*!40000 ALTER TABLE `prospects_cstm` DISABLE KEYS */;
/*!40000 ALTER TABLE `prospects_cstm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationships`
--

DROP TABLE IF EXISTS `relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationships` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `relationship_name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lhs_module` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lhs_table` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lhs_key` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rhs_module` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rhs_table` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rhs_key` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `join_table` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `join_key_lhs` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `join_key_rhs` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `relationship_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `relationship_role_column` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `relationship_role_column_value` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reverse` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_rel_name` (`relationship_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationships`
--

LOCK TABLES `relationships` WRITE;
/*!40000 ALTER TABLE `relationships` DISABLE KEYS */;
INSERT INTO `relationships` VALUES ('005a7ae1-7372-40b2-9e10-df2b2bad8f7f','cases_created_by','Users','users','id','Cases','cases','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('005f0aa7-68a3-4ae1-86a6-d75ffb4e5eca','opportunity_emails','Opportunities','opportunities','id','Emails','emails','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Opportunities',0,0),('00cbd203-15c2-4866-a4b8-7e32c20c8b56','surveyresponses_surveyquestionresponses','SurveyResponses','surveyresponses','id','SurveyQuestionResponses','surveyquestionresponses','surveyresponse_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('010f6fb6-6d9f-4ba8-bd56-6d8234c1a55a','aow_workflow_aow_processed','AOW_WorkFlow','aow_workflow','id','AOW_Processed','aow_processed','aow_workflow_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('01367a7a-7ae1-4d6e-a1e6-511d6da31a6e','eapm_assigned_user','Users','users','id','EAPM','eapm','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('015a2720-4a66-440f-b837-0430e4024733','oauth2tokens_modified_user','Users','users','id','OAuth2Tokens','oauth2tokens','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('01bfa042-3407-44a9-ad68-eae5530f641d','tasks_notes','Tasks','tasks','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('01c97555-42a7-4757-bbf1-88a2d4398b98','calls_reschedule_assigned_user','Users','users','id','Calls_Reschedule','calls_reschedule','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('01e3fc9d-63d3-444b-a852-f5276d50f1c6','lead_meetings','Leads','leads','id','Meetings','meetings','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Leads',0,0),('022115f7-bf74-4d88-8f5e-7a66c009a471','case_notes','Cases','cases','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Cases',0,0),('037c66cd-6e45-4ff2-9f91-3d6e465e8770','account_emails','Accounts','accounts','id','Emails','emails','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Accounts',0,0),('04465165-29fb-4090-a50e-7b003a8f0aa5','projects_contacts','Project','project','id','Contacts','contacts','id','projects_contacts','project_id','contact_id','many-to-many',NULL,NULL,0,0),('05a1aa26-b003-4ac8-a19a-3ee54433dee0','emails_users_rel','Emails','emails','id','Users','users','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Users',0,0),('064d1980-67f7-4946-8789-fb04a6f6778a','contact_aos_invoices','Contacts','contacts','id','AOS_Invoices','aos_invoices','billing_contact_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('06c8f45c-1a44-4128-b331-8144de049201','securitygroups_fp_events','SecurityGroups','securitygroups','id','FP_events','fp_events','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','FP_events',0,0),('06d1e750-6222-422b-b234-49c33ce3f313','securitygroups_surveyquestions','SecurityGroups','securitygroups','id','SurveyQuestions','surveyquestions','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','SurveyQuestions',0,0),('06f4e3d2-7a25-410a-b9d1-c55ee4758335','jjwg_Maps_contacts','jjwg_Maps','jjwg_Maps','parent_id','Contacts','contacts','id',NULL,NULL,NULL,'one-to-many','parent_type','Contacts',0,0),('0766ccda-8039-4dc6-bd53-98afa2e9aaa1','securitygroups_inboundemail','SecurityGroups','securitygroups','id','InboundEmail','inbound_email','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','InboundEmail',0,0),('0774f008-bbea-4d9b-8781-f13eafd11f0f','am_tasktemplates_created_by','Users','users','id','AM_TaskTemplates','am_tasktemplates','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('07b297d6-d291-4c15-a723-1666208cc8d0','aor_charts_modified_user','Users','users','id','AOR_Charts','aor_charts','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('08b37e02-eace-4e37-b19e-fffd7b67dc98','calls_reschedule','Calls','calls','id','Calls_Reschedule','calls_reschedule','call_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('08e0ef7c-f54c-4013-a3c8-38152db4d42f','prospects_email_addresses_primary','Prospects','prospects','id','EmailAddresses','email_addresses','id','email_addr_bean_rel','bean_id','email_address_id','many-to-many','primary_address','1',0,0),('091fbd5c-1cd1-4700-9b18-1d7c47246cb6','opportunities_assigned_user','Users','users','id','Opportunities','opportunities','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('09395507-1623-4aa3-9651-3cd3c8cc2d26','oauth2clients_created_by','Users','users','id','OAuth2Clients','oauth2clients','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('094ce469-aa30-4473-a893-db80f05ea5ad','opportunity_aos_quotes','Opportunities','opportunities','id','AOS_Quotes','aos_quotes','opportunity_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('09656c96-fd9e-48a7-9624-cc509cf5fa45','securitygroups_aos_product_categories','SecurityGroups','securitygroups','id','AOS_Product_Categories','aos_product_categories','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','AOS_Product_Categories',0,0),('098c3ee8-7c11-4022-81fa-9e98ca540c8a','aos_invoices_modified_user','Users','users','id','AOS_Invoices','aos_invoices','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('09f2ab48-5bf2-4d36-9503-c7d264c81f9a','contacts_users','Contacts','contacts','id','Users','users','id','contacts_users','contact_id','user_id','many-to-many',NULL,NULL,0,0),('0a9d3140-00cc-4c7f-9f3e-17535dbf69af','campaign_contacts','Campaigns','campaigns','id','Contacts','contacts','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('0a9ebd92-422d-4071-bf07-1e9430078802','favorites_created_by','Users','users','id','Favorites','favorites','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('0af5d19b-c048-4724-8b24-c1685851bbd0','cases_aop_case_updates','Cases','cases','id','AOP_Case_Updates','aop_case_updates','case_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('0b9e484a-5a46-4a6a-b80f-a7c41c33da3d','surveyquestionoptions_surveyquestionresponses','SurveyQuestionOptions','surveyquestionoptions','id','SurveyQuestionResponses','surveyquestionresponses','id','surveyquestionoptions_surveyquestionresponses','surveyq72c7options_ida','surveyq10d4sponses_idb','many-to-many',NULL,NULL,0,0),('0c31d296-7cf9-44f8-869f-bdba2e23254d','aos_contracts_aos_line_item_groups','AOS_Contracts','aos_contracts','id','AOS_Line_Item_Groups','aos_line_item_groups','parent_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('0c8fb819-37ed-4bfe-87e0-a7935fd8099f','campaignlog_lead','CampaignLog','campaign_log','related_id','Leads','leads','id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('0ca12675-7e58-4282-9ec3-d69e310fbe41','contact_tasks','Contacts','contacts','id','Tasks','tasks','contact_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('0d5c2c4b-8395-4f28-b8d8-98353b510440','fp_event_locations_modified_user','Users','users','id','FP_Event_Locations','fp_event_locations','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('0da21aea-249c-4c39-b2b2-4e2831e9f4d1','documents_bugs','Documents','documents','id','Bugs','bugs','id','documents_bugs','document_id','bug_id','many-to-many',NULL,NULL,0,0),('0e3e4f1c-c3a1-4724-b2fc-60f643c52f1d','prospect_campaign_log','Prospects','prospects','id','CampaignLog','campaign_log','target_id',NULL,NULL,NULL,'one-to-many','target_type','Prospects',0,0),('0e985bd7-f6f6-4a91-a018-fd468dcbf35c','prospect_tasks','Prospects','prospects','id','Tasks','tasks','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Prospects',0,0),('0ec485bc-2604-4544-8835-685e38ac28a2','campaign_notes','Campaigns','campaigns','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Campaigns',0,0),('0f2963f5-eb86-49d6-91d7-58b5d3024f23','campaign_modified_user','Users','users','id','Campaigns','campaigns','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('0f35fdb6-7e60-46fb-92c3-820b7ada236b','surveyquestions_created_by','Users','users','id','SurveyQuestions','surveyquestions','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('0f93fed5-3703-437b-8dae-fec6b73dcb6d','campaign_opportunities','Campaigns','campaigns','id','Opportunities','opportunities','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('0fe67824-798a-4583-837a-2d588ef56b81','meetings_users','Meetings','meetings','id','Users','users','id','meetings_users','meeting_id','user_id','many-to-many',NULL,NULL,0,0),('101e6a8a-0c94-46f7-a5c8-9c3ad8901e5b','case_calls','Cases','cases','id','Calls','calls','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Cases',0,0),('108eec3a-8d22-451d-b584-96ae7db51c8f','cases_created_contact','Contacts','contacts','id','Cases','cases','contact_created_by_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('109bace9-e42e-4af2-bfc0-33997e59b5d1','projects_project_tasks','Project','project','id','ProjectTask','project_task','project_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('114112ce-2f8b-4c28-96d8-44e773f7b68d','aok_knowledgebase_assigned_user','Users','users','id','AOK_KnowledgeBase','aok_knowledgebase','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('11850c3d-c3cd-4933-a765-2c83980b2138','prospect_emails','Prospects','prospects','id','Emails','emails','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Prospects',0,0),('127aa1f5-06b4-43fb-8a18-ccc040c888c8','project_tasks_created_by','Users','users','id','ProjectTask','project_task','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('14eef363-fb7e-4c17-bebe-121c2f84cc00','account_tasks','Accounts','accounts','id','Tasks','tasks','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Accounts',0,0),('151b0f2d-0af0-4316-bf7f-f894bb426a99','contacts_bugs','Contacts','contacts','id','Bugs','bugs','id','contacts_bugs','contact_id','bug_id','many-to-many',NULL,NULL,0,0),('158a0e75-87c7-40fe-849e-55fe823804e1','contact_leads','Contacts','contacts','id','Leads','leads','contact_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('15b81c58-aa5e-489c-b5f8-6b0be5de6553','securitygroups_externaloauthprovider','SecurityGroups','securitygroups','id','ExternalOAuthProvider','external_oauth_providers','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','ExternalOAuthProvider',0,0),('1634b21d-d920-43a2-b990-9805f8e679b3','aor_reports_created_by','Users','users','id','AOR_Reports','aor_reports','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('176f8870-74b1-4e86-9a3a-98fd138adadf','aow_workflow_assigned_user','Users','users','id','AOW_WorkFlow','aow_workflow','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('182f2b3d-6235-4e0e-947f-63c14bcc90d2','jjwg_Maps_accounts','jjwg_Maps','jjwg_Maps','parent_id','Accounts','accounts','id',NULL,NULL,NULL,'one-to-many','parent_type','Accounts',0,0),('18c05bed-1b1b-48fa-a66e-d527a0c8a575','aos_products_created_by','Users','users','id','AOS_Products','aos_products','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('19d897c3-a1bb-4a81-98a3-858627921e75','templatesectionline_modified_user','Users','users','id','TemplateSectionLine','templatesectionline','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('19dceea1-f6af-4e64-adb8-38ce8669142b','prospect_list_prospects','ProspectLists','prospect_lists','id','Prospects','prospects','id','prospect_lists_prospects','prospect_list_id','related_id','many-to-many','related_type','Prospects',0,0),('1a871b9f-02bd-4646-931a-e608525ce60f','project_tasks_modified_user','Users','users','id','ProjectTask','project_task','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('1aad4ea2-847f-46c5-a31c-e7f820ed0b4f','aor_scheduled_reports_created_by','Users','users','id','AOR_Scheduled_Reports','aor_scheduled_reports','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('1ae6f88d-37ea-443d-9bc6-8b7d9aecd597','prospectlists_assigned_user','Users','users','id','ProspectLists','prospect_lists','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('1b317459-e084-46b8-ab7e-55dde2c487fe','accounts_opportunities','Accounts','accounts','id','Opportunities','opportunities','id','accounts_opportunities','account_id','opportunity_id','many-to-many',NULL,NULL,0,0),('1b5c8dc1-a51f-4760-9044-8c4fd68ca0cd','notes_assigned_user','Users','users','id','Notes','notes','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('1ba90b4d-84c5-419d-9706-e97d1ff5b883','accounts_modified_user','Users','users','id','Accounts','accounts','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('1bcd5938-a0ab-49e2-b4df-a1f0a64a85c6','fp_events_leads_1','FP_events','fp_events','id','Leads','leads','id','fp_events_leads_1_c','fp_events_leads_1fp_events_ida','fp_events_leads_1leads_idb','many-to-many',NULL,NULL,0,0),('1bdab075-7940-4d6e-aba3-4c93ec2def46','aos_contracts_documents','AOS_Contracts','aos_contracts','id','Documents','documents','id','aos_contracts_documents','aos_contracts_id','documents_id','many-to-many',NULL,NULL,0,0),('1bec9298-9e1b-4c00-8020-dab28d2dd6aa','campaign_campaignlog','Campaigns','campaigns','id','CampaignLog','campaign_log','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('1bfab8c6-d703-4a84-a512-c39674df1426','surveyquestionoptions_assigned_user','Users','users','id','SurveyQuestionOptions','surveyquestionoptions','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('1c75e008-40e3-45de-ab53-11b3613c66c3','projects_assigned_user','Users','users','id','Project','project','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('1da8af07-415e-4662-9168-6cab0aa76624','opportunities_modified_user','Users','users','id','Opportunities','opportunities','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('1dd69982-cb0a-4bc4-b918-26f19ba8817e','securitygroups_project','SecurityGroups','securitygroups','id','Project','project','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Project',0,0),('1dda97ca-dd5c-4ec3-9f67-ecbb570e1e6e','projects_tasks','Project','project','id','Tasks','tasks','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Project',0,0),('1e87282e-711b-4d81-b12a-cf4dba8283e3','securitygroups_fp_event_locations','SecurityGroups','securitygroups','id','FP_Event_Locations','fp_event_locations','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','FP_Event_Locations',0,0),('1f9287ac-e9cd-4fe4-979a-b94a0efcc05d','outbound_email_modified_user','Users','users','id','OutboundEmailAccounts','outbound_email','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('209b93b4-47fa-43f0-adcf-01df8d85b666','jjwg_Maps_prospects','jjwg_Maps','jjwg_Maps','parent_id','Prospects','prospects','id',NULL,NULL,NULL,'one-to-many','parent_type','Prospects',0,0),('20f4bf2f-9b16-4c7d-8c95-3541cd35fb7c','leads_created_by','Users','users','id','Leads','leads','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('2121b273-baf5-44d2-8d52-e7ee790dd102','inbound_emails_autoreply_email_templates','EmailTemplates','email_templates','id','InboundEmail','inbound_email','template_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('2184bd92-5617-44a3-8947-a5aa3d7eb406','securitygroups_accounts','SecurityGroups','securitygroups','id','Accounts','accounts','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Accounts',0,0),('2189e969-79fc-4258-9371-7b480635ad11','prospect_meetings','Prospects','prospects','id','Meetings','meetings','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Prospects',0,0),('22766ff5-1ffc-4dde-84e2-263c1d287fe5','calls_assigned_user','Users','users','id','Calls','calls','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('22a0828d-3938-41ea-a19c-2f85e4eacf5e','contacts_cases','Contacts','contacts','id','Cases','cases','id','contacts_cases','contact_id','case_id','many-to-many',NULL,NULL,0,0),('22d995d5-5ce5-4835-ab1b-a7843d20031f','project_tasks_assigned_user','Users','users','id','ProjectTask','project_task','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('23b47aa2-172b-4d50-ad7f-8c4c511130e7','prospect_list_accounts','ProspectLists','prospect_lists','id','Accounts','accounts','id','prospect_lists_prospects','prospect_list_id','related_id','many-to-many','related_type','Accounts',0,0),('25de1e62-17d2-428f-bb8e-b44b12fb8cf1','reminders_created_by','Users','users','id','Reminders','reminders','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('25e604e7-90d8-49fc-a846-791168d9b6e5','prospects_modified_user','Users','users','id','Prospects','prospects','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('26009097-293d-4e8e-a274-e78d7488acc3','saved_search_assigned_user','Users','users','id','SavedSearch','saved_search','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('2751d057-bd32-4f89-aaf6-b852e5e572c4','optimistic_locking',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),('2837e1c9-1f78-4846-9e3e-ae1af6b06bfb','surveyquestionoptions_modified_user','Users','users','id','SurveyQuestionOptions','surveyquestionoptions','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('284d6a59-8454-4f04-bf2d-7b344b67cd46','securitygroups_calendaraccount','SecurityGroups','securitygroups','id','CalendarAccount','calendar_accounts','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','CalendarAccount',0,0),('28983ea5-64e1-41ce-93f7-60edbc3fca4c','securitygroups_prospect_lists','SecurityGroups','securitygroups','id','ProspectLists','prospect_lists','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','ProspectLists',0,0),('2918b00e-74ce-4eb5-83c8-58046340584a','securitygroups_notes','SecurityGroups','securitygroups','id','Notes','notes','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Notes',0,0),('2999bd36-eb97-44ee-aa9a-bf7be455bc85','aos_contracts_notes','AOS_Contracts','aos_contracts','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','AOS_Contracts',0,0),('29ae6f58-0e87-44bd-90ad-866be24337bb','aow_actions_created_by','Users','users','id','AOW_Actions','aow_actions','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('29f94350-b45e-4413-8ca7-79e460eb79ea','alerts_assigned_user','Users','users','id','Alerts','alerts','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('2a44ba56-8c43-4f42-951c-b61f90ca9d09','calendar_accounts_calendar_user','Users','users','id','CalendarAccount','calendar_accounts','calendar_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('2bb0b84b-35e4-44d3-b302-681941a17642','calls_reschedule_modified_user','Users','users','id','Calls_Reschedule','calls_reschedule','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('2bd9f686-5c86-44e8-b073-6bd51ead84be','calendaraccount_modified_user','Users','users','id','CalendarAccount','calendar_accounts','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('2c941b75-eb73-4cd1-b8e0-430caa1a8878','campaign_emailman','Campaigns','campaigns','id','EmailMan','emailman','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('2ca2a50f-6d5d-4714-8823-b3f658faccf1','emails_notes_rel','Emails','emails','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('2d1aa000-e906-4c4c-80a0-1548b1f4d979','projects_cases','Project','project','id','Cases','cases','id','projects_cases','project_id','case_id','many-to-many',NULL,NULL,0,0),('2d987625-63ae-4d06-9f47-febfc1f0b5d7','am_projecttemplates_project_1','AM_ProjectTemplates','am_projecttemplates','id','Project','project','id','am_projecttemplates_project_1_c','am_projecttemplates_project_1am_projecttemplates_ida','am_projecttemplates_project_1project_idb','many-to-many',NULL,NULL,0,0),('2eb4c245-d421-40c2-9b53-89f08be50a22','aop_case_updates_notes','AOP_Case_Updates','aop_case_updates','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','AOP_Case_Updates',0,0),('2f2aa7bc-f8aa-4752-8c74-93f596db3ff4','users_users_password_link','Users','users','id',NULL,'users_signatures','user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('2fb6fbc1-0955-4889-adb1-b2cc146c01f6','aor_scheduled_reports_modified_user','Users','users','id','AOR_Scheduled_Reports','aor_scheduled_reports','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('30434602-2145-4844-9a2b-defc52556146','aor_conditions_created_by','Users','users','id','AOR_Conditions','aor_conditions','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('3082f9ff-68da-452b-b845-818f4a1f92ae','case_tasks','Cases','cases','id','Tasks','tasks','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Cases',0,0),('310ee6b6-ec3c-43ce-a318-3eeb0546274f','securitygroups_aor_reports','SecurityGroups','securitygroups','id','AOR_Reports','aor_reports','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','AOR_Reports',0,0),('31c923ea-cd60-4101-9301-ff8af79b921c','aor_fields_created_by','Users','users','id','AOR_Fields','aor_fields','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('3266d5b4-ebb1-4ca0-b547-d9a85ef61aeb','emails_assigned_user','Users','users','id','Emails','emails','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('326b56ef-bbde-4490-b24e-b3a617e652e8','emails_meetings_rel','Emails','emails','id','Meetings','meetings','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Meetings',0,0),('32ae8e1d-ff43-4928-8f05-0d0742bd973f','meetings_modified_user','Users','users','id','Meetings','meetings','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('33a4aaeb-b949-4dcc-8040-b3ab478c7466','aobh_businesshours_created_by','Users','users','id','AOBH_BusinessHours','aobh_businesshours','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('33b259e1-0385-4f45-9dd2-f60aeb102b03','contact_notes_parent','Contacts','contacts','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Contacts',0,0),('33dbd625-a39d-484e-ba16-27762c3ccd05','aos_line_item_groups_modified_user','Users','users','id','AOS_Line_Item_Groups','aos_line_item_groups','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('3448fea8-4af3-4a44-b27d-80d551cc3015','bug_calls','Bugs','bugs','id','Calls','calls','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Bugs',0,0),('34667741-2c97-4642-b87e-9012876aa92f','aor_charts_aor_reports','AOR_Reports','aor_reports','id','AOR_Charts','aor_charts','aor_report_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('36060a5b-2dbf-41cf-8e31-52dca48c25fa','securitygroups_opportunities','SecurityGroups','securitygroups','id','Opportunities','opportunities','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Opportunities',0,0),('36781a23-dab9-4dfd-b947-861b92f1530f','jjwg_areas_assigned_user','Users','users','id','jjwg_Areas','jjwg_areas','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('36c67736-4be7-4a6e-9c2b-3f78279c0f66','calls_leads','Calls','calls','id','Leads','leads','id','calls_leads','call_id','lead_id','many-to-many',NULL,NULL,0,0),('37c0e841-1c40-40da-b265-f74b2b00c38d','prospect_list_leads','ProspectLists','prospect_lists','id','Leads','leads','id','prospect_lists_prospects','prospect_list_id','related_id','many-to-many','related_type','Leads',0,0),('380fbc40-fd1c-4644-bb7b-9b5de90ad1e0','project_users_1','Project','project','id','Users','users','id','project_users_1_c','project_users_1project_ida','project_users_1users_idb','many-to-many',NULL,NULL,0,0),('3860e888-1929-4615-9541-084c82419529','jjwg_maps_jjwg_areas','jjwg_Maps','jjwg_maps','id','jjwg_Areas','jjwg_areas','id','jjwg_maps_jjwg_areas_c','jjwg_maps_5304wg_maps_ida','jjwg_maps_41f2g_areas_idb','many-to-many',NULL,NULL,0,0),('38c22de3-ccda-4170-98ed-7b3c653ea5fd','fp_events_fp_event_locations_1','FP_events','fp_events','id','FP_Event_Locations','fp_event_locations','id','fp_events_fp_event_locations_1_c','fp_events_fp_event_locations_1fp_events_ida','fp_events_fp_event_locations_1fp_event_locations_idb','many-to-many',NULL,NULL,0,0),('38f076b5-62d0-4079-9bca-81755ee5a01a','oauthkeys_created_by','Users','users','id','OAuthKeys','oauth_consumer','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('39cf9bdc-2136-4763-ae80-07f9f8258ac4','jjwg_Maps_opportunities','jjwg_Maps','jjwg_Maps','parent_id','Opportunities','opportunities','id',NULL,NULL,NULL,'one-to-many','parent_type','Opportunities',0,0),('3a8b856d-66f6-4aea-bdaa-253978c380df','aow_processed_aow_actions','AOW_Processed','aow_processed','id','AOW_Actions','aow_actions','id','aow_processed_aow_actions','aow_processed_id','aow_action_id','many-to-many',NULL,NULL,0,0),('3b8f92f9-ad3d-46b4-a780-b39f87eabe44','securitygroups_aos_products','SecurityGroups','securitygroups','id','AOS_Products','aos_products','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','AOS_Products',0,0),('3d732db2-4ce8-4eed-87a5-009f0e8d8db9','spots_modified_user','Users','users','id','Spots','spots','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('3e639c1e-b4b7-4768-b712-028e9ccaa009','bug_tasks','Bugs','bugs','id','Tasks','tasks','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Bugs',0,0),('3f84d20f-ad88-4845-9b3d-8bd1ee304d7b','securitygroups_surveyquestionoptions','SecurityGroups','securitygroups','id','SurveyQuestionOptions','surveyquestionoptions','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','SurveyQuestionOptions',0,0),('3f9b74bf-6df6-4c4a-81da-284ebd5831d5','aor_scheduled_reports_aor_reports','AOR_Reports','aor_reports','id','AOR_Scheduled_Reports','aor_scheduled_reports','aor_report_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('3fce7b36-d4b2-472c-8395-34c2d8531a8a','opportunity_leads','Opportunities','opportunities','id','Leads','leads','opportunity_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('407187f4-857f-4fc4-b9fc-8b546f068705','jjwg_areas_created_by','Users','users','id','jjwg_Areas','jjwg_areas','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4096cb6e-c825-4af7-9973-22dd06b7966e','aos_products_modified_user','Users','users','id','AOS_Products','aos_products','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('41fb2691-97eb-4543-bd8b-fb41b6f5475d','lead_campaign_log','Leads','leads','id','CampaignLog','campaign_log','target_id',NULL,NULL,NULL,'one-to-many','target_type','Leads',0,0),('42388cda-01b7-4337-a3cd-c9579f0f762c','fp_events_prospects_1','FP_events','fp_events','id','Prospects','prospects','id','fp_events_prospects_1_c','fp_events_prospects_1fp_events_ida','fp_events_prospects_1prospects_idb','many-to-many',NULL,NULL,0,0),('4267fb0a-224d-48c7-8446-67f3bf6d7a61','outbound_email_assigned_user','Users','users','id','OutboundEmailAccounts','outbound_email','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('43000f9f-4dac-4484-a260-ab2702e033a5','emails_prospects_rel','Emails','emails','id','Prospects','prospects','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Prospects',0,0),('431f5d36-d7f1-4d7c-80cc-77c26a15d254','aos_quotes_aos_product_quotes','AOS_Quotes','aos_quotes','id','AOS_Products_Quotes','aos_products_quotes','parent_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('43e52941-a5c8-48a8-a49f-fcbc1f976bb4','surveyresponses_accounts','Accounts','accounts','id','SurveyResponses','surveyresponses','account_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('443c152b-2924-42c0-a440-33eeb1562b54','users_email_addresses','Users','users','id','EmailAddresses','email_addresses','id','email_addr_bean_rel','bean_id','email_address_id','many-to-many','bean_module','Users',0,0),('4471a711-3c4b-42d2-b443-f85aff9fc108','opportunity_meetings','Opportunities','opportunities','id','Meetings','meetings','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Opportunities',0,0),('44c22fe7-94c8-4935-80f6-e1f6edf58f04','sub_product_categories','AOS_Product_Categories','aos_product_categories','id','AOS_Product_Categories','aos_product_categories','parent_category_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4737af17-1989-4f9f-babf-c845d0586a8d','documents_created_by','Users','users','id','Documents','documents','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('47de3cc8-bd42-4f19-a068-09e82c0abd01','campaigns_modified_user','Users','users','id','Campaigns','campaigns','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('48110f7a-ebe7-40cb-a478-79d4662ccbab','bug_emails','Bugs','bugs','id','Emails','emails','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Bugs',0,0),('4879b859-79b8-4c36-af6d-a99591be67f8','aow_conditions_modified_user','Users','users','id','AOW_Conditions','aow_conditions','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('48b50849-5a5b-4d75-8e94-e95f65fce071','aos_products_quotes_created_by','Users','users','id','AOS_Products_Quotes','aos_products_quotes','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('48b64136-ffb5-4fe6-8b83-2f511f15f7c8','prospects_assigned_user','Users','users','id','Prospects','prospects','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('48d3c3a9-72ad-4e49-8944-c957dd04d73a','meetings_created_by','Users','users','id','Meetings','meetings','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4960a6d9-6f3b-41d1-9085-b9a1f33a76de','cases_assigned_user','Users','users','id','Cases','cases','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('49a22e68-b75c-412f-9a7c-d1430f513030','aok_knowledge_base_categories_assigned_user','Users','users','id','AOK_Knowledge_Base_Categories','aok_knowledge_base_categories','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4a0308b5-b431-42ba-898a-401796c31307','surveyquestionresponses_assigned_user','Users','users','id','SurveyQuestionResponses','surveyquestionresponses','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4a2e6968-03d2-46f8-8c72-4d0f6c21ff07','jjwg_address_cache_modified_user','Users','users','id','jjwg_Address_Cache','jjwg_address_cache','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4b128109-dfef-4913-8621-2063ca809735','notes_modified_user','Users','users','id','Notes','notes','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4bcd46fb-1876-421e-bd2e-d15ff2674002','alerts_modified_user','Users','users','id','Alerts','alerts','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4c220e93-8300-41cc-b4ce-f4926cb6536c','account_aos_invoices','Accounts','accounts','id','AOS_Invoices','aos_invoices','billing_account_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4c3af1f0-e834-4cd5-9314-62bfcbc05fb2','jjwg_maps_assigned_user','Users','users','id','jjwg_Maps','jjwg_maps','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4c7b9002-5d49-41e0-9e7c-ce47f480a5ab','project_tasks_meetings','ProjectTask','project_task','id','Meetings','meetings','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','ProjectTask',0,0),('4c928dfc-dbb5-4d48-834b-7374383f7f40','documents_modified_user','Users','users','id','Documents','documents','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4c9df9c7-cb5f-4283-80ad-bc2c2bea3d19','unified_search',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),('4cf9b76c-095d-4b69-8aa8-3dff3fee8766','securitygroups_aos_quotes','SecurityGroups','securitygroups','id','AOS_Quotes','aos_quotes','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','AOS_Quotes',0,0),('4d248454-b416-4baf-a7d1-4dd163a97bfc','schedulers_modified_user_id_rel','Users','users','id','Schedulers','schedulers','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4d44cd66-c50d-4092-9301-8e5ac44c609f','aod_index_created_by','Users','users','id','AOD_Index','aod_index','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4d75fa1a-5ec4-4d4f-bfa2-11f19d7389b0','users_email_addresses_primary','Users','users','id','EmailAddresses','email_addresses','id','email_addr_bean_rel','bean_id','email_address_id','many-to-many','primary_address','1',0,0),('4ebe0917-5c53-4754-9836-a54579049b39','campaign_assigned_user','Users','users','id','Campaigns','campaigns','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('4f535ea5-822d-4bae-b2b4-551c8e7dbf95','schedulersjobs_assigned_user','Users','users','id','SchedulersJobs','job_queue','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('51536102-d439-470e-8c8d-d00553ca7715','accounts_contacts','Accounts','accounts','id','Contacts','contacts','id','accounts_contacts','account_id','contact_id','many-to-many',NULL,NULL,0,0),('52720800-80ce-400a-bd8a-59e39490a783','aod_index_modified_user','Users','users','id','AOD_Index','aod_index','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('528e3498-cf64-45d7-bd86-f5b660f88cdd','securitygroups_modified_user','Users','users','id','SecurityGroups','securitygroups','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('52b5d5a1-08bb-4240-ab86-b177c861b300','aos_contracts_created_by','Users','users','id','AOS_Contracts','aos_contracts','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('531ffddf-26b0-423a-8edd-7ec4e211ecf5','am_projecttemplates_assigned_user','Users','users','id','AM_ProjectTemplates','am_projecttemplates','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('536503c6-da9e-40c4-b705-c8cd0aa69a33','am_projecttemplates_created_by','Users','users','id','AM_ProjectTemplates','am_projecttemplates','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('54259d05-ffec-4de9-ac28-21be80de84ca','securitygroups_prospects','SecurityGroups','securitygroups','id','Prospects','prospects','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Prospects',0,0),('54af5bbc-addb-4a01-beb5-7d908e7ce571','aos_contracts_aos_products_quotes','AOS_Contracts','aos_contracts','id','AOS_Products_Quotes','aos_products_quotes','parent_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5530d8a1-d51d-4e1b-987b-9badbdde100b','contacts_email_addresses_primary','Contacts','contacts','id','EmailAddresses','email_addresses','id','email_addr_bean_rel','bean_id','email_address_id','many-to-many','primary_address','1',0,0),('56205e0f-841d-4865-ad49-57d4ab7fcda2','aow_processed_created_by','Users','users','id','AOW_Processed','aow_processed','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('565f857d-02ba-446a-bb1c-713d5282ee4a','securitygroups_created_by','Users','users','id','SecurityGroups','securitygroups','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('572edbdf-236c-4f6b-b5a5-adf2e2a2791f','securitygroups_leads','SecurityGroups','securitygroups','id','Leads','leads','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Leads',0,0),('573882a0-604f-49c2-901a-df9ba339a9f5','securitygroups_aor_scheduled_reports','SecurityGroups','securitygroups','id','AOR_Scheduled_Reports','aor_scheduled_reports','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','AOR_Scheduled_Reports',0,0),('57461279-a699-4e05-af1a-1dd175b8644f','aow_workflow_aow_conditions','AOW_WorkFlow','aow_workflow','id','AOW_Conditions','aow_conditions','aow_workflow_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('57acea5d-67b7-4d07-8b46-49c3a258ccae','securitygroups_spots','SecurityGroups','securitygroups','id','Spots','spots','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Spots',0,0),('57ddd804-dd0f-4512-b588-da37e34116ea','prospects_email_addresses','Prospects','prospects','id','EmailAddresses','email_addresses','id','email_addr_bean_rel','bean_id','email_address_id','many-to-many','bean_module','Prospects',0,0),('58000d5b-58df-4451-b9ad-9be53c5347bf','aos_product_categories_created_by','Users','users','id','AOS_Product_Categories','aos_product_categories','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('588ffe73-165b-4124-ae5d-5a14830d05f9','accounts_email_addresses_primary','Accounts','accounts','id','EmailAddresses','email_addresses','id','email_addr_bean_rel','bean_id','email_address_id','many-to-many','primary_address','1',0,0),('599faf87-b1ae-4a45-b121-ffe8735056bc','inbound_email_modified_user_id','Users','users','id','InboundEmail','inbound_email','modified_user_id',NULL,NULL,NULL,'one-to-one',NULL,NULL,0,0),('59cb865a-fd75-44a9-8763-fa740b14c251','lead_emails','Leads','leads','id','Emails','emails','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Leads',0,0),('59d7f80b-5568-44b8-9d12-da8fa9f2eae2','aop_case_events_modified_user','Users','users','id','AOP_Case_Events','aop_case_events','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5a7ac67e-6162-460c-b614-e207d04c6e68','aos_quotes_aos_invoices','AOS_Quotes','aos_quotes','id','AOS_Invoices','aos_invoices','id','aos_quotes_aos_invoices_c','aos_quotes77d9_quotes_ida','aos_quotes6b83nvoices_idb','many-to-many',NULL,NULL,0,0),('5aa5cf00-218f-4d11-8dcf-256426927443','jjwg_Maps_projects','jjwg_Maps','jjwg_Maps','parent_id','Project','project','id',NULL,NULL,NULL,'one-to-many','parent_type','Project',0,0),('5bb57fc7-dfef-4a8e-bc59-7f14dd612d45','oauth2clients_oauth2tokens','OAuth2Clients','oauth2clients','id','OAuth2Tokens','oauth2tokens','client',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5c4a6d47-46da-403d-a71f-5b49b7f80907','surveyquestions_surveyquestionoptions','SurveyQuestions','surveyquestions','id','SurveyQuestionOptions','surveyquestionoptions','survey_question_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5d018189-e4fd-4014-b655-df498cdb1e42','securitygroups_projecttask','SecurityGroups','securitygroups','id','ProjectTask','project_task','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','ProjectTask',0,0),('5dc115be-c7b4-4a31-bc59-9a3d5409d842','campaign_email_marketing','Campaigns','campaigns','id','EmailMarketing','email_marketing','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5dfcbed3-1b5f-4359-912a-752aae80601d','surveys_modified_user','Users','users','id','Surveys','surveys','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5e07686c-79cd-48a1-b01f-f71454419ec0','email_template_email_marketings','EmailTemplates','email_templates','id','EmailMarketing','email_marketing','template_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5e18d86b-344a-4148-8ce3-a86d2a2852f2','aod_indexevent_assigned_user','Users','users','id','AOD_IndexEvent','aod_indexevent','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5e48b234-71c1-4429-bc49-2aea7dafc528','securitygroups_jjwg_maps','SecurityGroups','securitygroups','id','jjwg_Maps','jjwg_maps','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','jjwg_Maps',0,0),('5e821f54-7ad4-4a15-a3b1-9fb787653505','am_projecttemplates_modified_user','Users','users','id','AM_ProjectTemplates','am_projecttemplates','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5efebb22-d7b1-4fd9-b726-6ae0da475a4a','account_calls','Accounts','accounts','id','Calls','calls','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Accounts',0,0),('5f6a5d42-cb36-4c8d-80f3-d343bfd93915','opportunity_currencies','Opportunities','opportunities','currency_id','Currencies','currencies','id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5fac39aa-95d1-4e9d-8ce9-b9d48e08e8f6','sugarfeed_assigned_user','Users','users','id','SugarFeed','sugarfeed','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('5ff8db45-9841-4186-ab11-503409a33d7f','aow_processed_modified_user','Users','users','id','AOW_Processed','aow_processed','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('60fc3b6b-6124-41bb-9ef3-cbf4adc7d435','oauthkeys_assigned_user','Users','users','id','OAuthKeys','oauth_consumer','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('6305bdb4-4a43-49f6-a126-13e2dfa1664b','lead_direct_reports','Leads','leads','id','Leads','leads','reports_to_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('64176955-c21b-458f-8dde-f418842974ab','externaloauthconnection_modified_user','Users','users','id','ExternalOAuthConnection','external_oauth_connections','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('64b4aaf7-83e5-4b50-9b84-61810bfb676b','inbound_email_created_by','Users','users','id','InboundEmail','inbound_email','created_by',NULL,NULL,NULL,'one-to-one',NULL,NULL,0,0),('64ea1d9a-ed87-43f4-b8b5-23af6c0b552b','oauth2tokens_created_by','Users','users','id','OAuth2Tokens','oauth2tokens','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('65a01f8d-846f-48ee-a0ef-5edd568baccf','prospect_list_users','ProspectLists','prospect_lists','id','Users','users','id','prospect_lists_prospects','prospect_list_id','related_id','many-to-many','related_type','Users',0,0),('65b6e157-0af3-45e2-9fae-686a406ae7f3','case_meetings','Cases','cases','id','Meetings','meetings','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Cases',0,0),('65c89773-cc49-4cc1-b5eb-8c855e0bcddf','projects_accounts','Project','project','id','Accounts','accounts','id','projects_accounts','project_id','account_id','many-to-many',NULL,NULL,0,0),('67a86be6-4ec8-42ab-9bbb-d305825573e3','outbound_emails_external_oauth_connections','ExternalOAuthConnection','external_oauth_connections','id','OutboundEmailAccounts','outbound_email','external_oauth_connection_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('67b82088-3ba9-4336-856f-ee098202449b','securitygroups_contacts','SecurityGroups','securitygroups','id','Contacts','contacts','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Contacts',0,0),('680d0afa-2c6b-4ead-a36c-0852b1600420','am_tasktemplates_assigned_user','Users','users','id','AM_TaskTemplates','am_tasktemplates','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('682e0104-1cd3-4055-be74-a2e7da65abca','emails_cases_rel','Emails','emails','id','Cases','cases','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Cases',0,0),('6887e0fd-fdae-410c-8a62-59c45ff7e5a5','jjwg_maps_modified_user','Users','users','id','jjwg_Maps','jjwg_maps','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('699f916b-1950-4ace-9675-9b14385fa459','projects_calls','Project','project','id','Calls','calls','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Project',0,0),('6ab46f43-c8c5-4293-b5a9-23319f85886f','calls_modified_user','Users','users','id','Calls','calls','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('6adeb63e-1265-4379-a865-434c37cee986','external_oauth_connections_external_oauth_providers','ExternalOAuthProvider','external_oauth_providers','id','ExternalOAuthConnection','external_oauth_connections','external_oauth_provider_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('6b0dd373-2e20-4dbc-af4b-57a866b9762b','aod_index_assigned_user','Users','users','id','AOD_Index','aod_index','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('6c59e1d9-43b7-466b-9e66-ac2809ce48e8','spots_assigned_user','Users','users','id','Spots','spots','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('6c603f86-933c-4c1f-89d3-d2f2790c86db','aow_workflow_aow_actions','AOW_WorkFlow','aow_workflow','id','AOW_Actions','aow_actions','aow_workflow_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('6d82a013-b190-4637-9715-8b9002aa7d55','jjwg_maps_jjwg_markers','jjwg_Maps','jjwg_maps','id','jjwg_Markers','jjwg_markers','id','jjwg_maps_jjwg_markers_c','jjwg_maps_b229wg_maps_ida','jjwg_maps_2e31markers_idb','many-to-many',NULL,NULL,0,0),('6e62d98a-dc1d-420d-a2f1-22cb06cd34a5','emails_opportunities_rel','Emails','emails','id','Opportunities','opportunities','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Opportunities',0,0),('6f4dbe89-4741-4205-a306-e318e0d88dc4','aop_case_updates_modified_user','Users','users','id','AOP_Case_Updates','aop_case_updates','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('6fe5d669-2cb1-486e-945d-4698715dcbbd','aos_contracts_modified_user','Users','users','id','AOS_Contracts','aos_contracts','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('70e3a303-f7ef-43d1-8d50-2ddff08d824d','aos_line_item_groups_created_by','Users','users','id','AOS_Line_Item_Groups','aos_line_item_groups','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('71b295fc-d120-428b-bff5-9f2d314cfd88','contact_aos_quotes','Contacts','contacts','id','AOS_Quotes','aos_quotes','billing_contact_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('7241da8a-ae69-4126-8a87-8128f2518fc2','fp_event_locations_assigned_user','Users','users','id','FP_Event_Locations','fp_event_locations','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('732366a2-4296-40dd-b0e8-d08f27df0658','alerts_created_by','Users','users','id','Alerts','alerts','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('7357c99c-85dd-47ea-b2d2-c7859719d8b5','documents_assigned_user','Users','users','id','Documents','documents','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('73da41bc-6935-4b1b-bc16-3ad3de75a908','aos_quotes_created_by','Users','users','id','AOS_Quotes','aos_quotes','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('741c7d22-fbd5-430f-83e5-dfd22a20f490','campaignlog_contact','CampaignLog','campaign_log','related_id','Contacts','contacts','id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('747c010e-8222-4155-92ec-c981fe66cd32','meetings_contacts','Meetings','meetings','id','Contacts','contacts','id','meetings_contacts','meeting_id','contact_id','many-to-many',NULL,NULL,0,0),('7531e372-164e-4125-aa9d-bbf57ecfd326','campaign_leads','Campaigns','campaigns','id','Leads','leads','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('76188668-888a-4752-9d3d-b7de95ed9489','aop_case_events_created_by','Users','users','id','AOP_Case_Events','aop_case_events','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('7666eed7-defb-4fd7-9c34-9ac8254b6cd2','externaloauthprovider_created_by','Users','users','id','ExternalOAuthProvider','external_oauth_providers','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('78b9c360-954a-44c1-aeec-ec4691f321e3','aos_product_categories_assigned_user','Users','users','id','AOS_Product_Categories','aos_product_categories','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('78c11aec-4349-494a-be26-5012e07d8039','calls_notes','Calls','calls','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Calls',0,0),('79500f3d-05b0-4df1-9fc6-7442839c8bfc','oauth2clients_oauth2authcodes','OAuth2Clients','oauth2clients','id','Oauth2AuthCodes','oauth2authcodes','client',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('79fc77c3-c8dc-4707-9fde-c974a19955e0','accounts_created_by','Users','users','id','Accounts','accounts','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('7adeb846-9992-4ad4-8251-ee0df1c89078','contact_notes','Contacts','contacts','id','Notes','notes','contact_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('7aee732e-44ed-4a18-8f94-fa86b4e6d4b5','projects_emails','Project','project','id','Emails','emails','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Project',0,0),('7b88a2aa-fa72-433b-904f-9ac8a6a4104f','securitygroups_documents','SecurityGroups','securitygroups','id','Documents','documents','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Documents',0,0),('7bb658d9-997c-43d5-b245-9c476407d64b','documents_cases','Documents','documents','id','Cases','cases','id','documents_cases','document_id','case_id','many-to-many',NULL,NULL,0,0),('7c5e45f9-9908-422a-a927-acd3f7c06656','prospect_list_contacts','ProspectLists','prospect_lists','id','Contacts','contacts','id','prospect_lists_prospects','prospect_list_id','related_id','many-to-many','related_type','Contacts',0,0),('7c7297e8-4622-4299-a9fd-2f61d200a794','fp_events_created_by','Users','users','id','FP_events','fp_events','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('7d068834-039e-4fad-b6c4-5fdbc9f4ffd9','aobh_businesshours_modified_user','Users','users','id','AOBH_BusinessHours','aobh_businesshours','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('7dbc4d0d-3ff0-4c89-b50d-98d8cdfa6523','oauthtokens_assigned_user','Users','users','id','OAuthTokens','oauth_tokens','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('7dea4e98-cad8-4806-8c52-622c4a321e3f','account_campaign_log','Accounts','accounts','id','CampaignLog','campaign_log','target_id',NULL,NULL,NULL,'one-to-many','target_type','Accounts',0,0),('7e0a8ece-6346-44cb-8ff6-06791a4eddc6','securitygroups_externaloauthconnection','SecurityGroups','securitygroups','id','ExternalOAuthConnection','external_oauth_connections','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','ExternalOAuthConnection',0,0),('7e8bf80d-25a7-4dc7-9a2c-c718c87435b7','project_tasks_tasks','ProjectTask','project_task','id','Tasks','tasks','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','ProjectTask',0,0),('7e8d4a4c-6a96-4ca1-94c5-80182ac8c174','aos_contracts_calls','AOS_Contracts','aos_contracts','id','Calls','calls','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','AOS_Contracts',0,0),('7ea6a345-add4-48a3-b657-05fe145907b7','securitygroups_meetings','SecurityGroups','securitygroups','id','Meetings','meetings','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Meetings',0,0),('7ea91dd6-afe4-43a1-9729-b6a83639196f','securitygroups_project_task','SecurityGroups','securitygroups','id','ProjectTask','project_task','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','ProjectTask',0,0),('80f95f78-fdb3-4952-add3-70ae26a90035','notes_created_by','Users','users','id','Notes','notes','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('81e4dbb6-14ee-4c3c-9d7b-45c795ea8e45','securitygroups_tasks','SecurityGroups','securitygroups','id','Tasks','tasks','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Tasks',0,0),('829361f2-6e56-4bc1-8948-b6ba813dcfc4','projects_created_by','Users','users','id','Project','project','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('835915c2-277a-483b-b734-80b5ac43059f','project_tasks_notes','ProjectTask','project_task','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','ProjectTask',0,0),('83ecafd2-c820-47cc-b153-2113749f64db','aos_quotes_project','AOS_Quotes','aos_quotes','id','Project','project','id','aos_quotes_project_c','aos_quotes1112_quotes_ida','aos_quotes7207project_idb','many-to-many',NULL,NULL,0,0),('844d4de2-e073-4510-b5a1-48f5a833246c','email_marketing_prospect_lists','EmailMarketing','email_marketing','id','ProspectLists','prospect_lists','id','email_marketing_prospect_lists','email_marketing_id','prospect_list_id','many-to-many',NULL,NULL,0,0),('84ea3451-d64f-4d6b-b305-3422ba1faca1','reminders_invitees_assigned_user','Users','users','id','Reminders_Invitees','reminders_invitees','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('8516fd93-542a-4382-8780-ffb8fe794b66','securitygroups_campaigns','SecurityGroups','securitygroups','id','Campaigns','campaigns','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Campaigns',0,0),('853395fd-121d-4cba-8f3a-d00c853a2964','aos_pdf_templates_created_by','Users','users','id','AOS_PDF_Templates','aos_pdf_templates','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('85a3811d-ab41-40bc-bc79-2a81a70bcb07','jjwg_markers_assigned_user','Users','users','id','jjwg_Markers','jjwg_markers','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('861ffc10-f654-4573-af83-e96021ba65b7','inbound_emails_distribution_user','Users','users','id','InboundEmail','inbound_email','distribution_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('86b762f4-063a-4e75-90cd-5b52f1da76c5','oauth2clients_assigned_user','Users','users','id','OAuth2Clients','oauth2clients','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('8718bfe1-b6ff-44a1-a2e5-6966cee1fdf5','case_emails','Cases','cases','id','Emails','emails','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Cases',0,0),('87b1409d-d469-41ea-94b6-1933acbd0c97','projects_meetings','Project','project','id','Meetings','meetings','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Project',0,0),('882d2b62-8457-47c3-8141-baef038f7886','schedulers_created_by_rel','Users','users','id','Schedulers','schedulers','created_by',NULL,NULL,NULL,'one-to-one',NULL,NULL,0,0),('885f1ff8-4139-453f-9537-6783ca9d5c60','sugarfeed_created_by','Users','users','id','SugarFeed','sugarfeed','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('88685d7b-13ae-48d1-9f11-584a8d0e2339','surveyresponses_created_by','Users','users','id','SurveyResponses','surveyresponses','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('88c761fe-2104-4475-bffc-f6ceac160106','emails_projects_rel','Emails','emails','id','Project','project','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Project',0,0),('893b43ac-b3e7-47ea-af4c-b2c402e9d859','contacts_modified_user','Users','users','id','Contacts','contacts','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('898e10ec-a344-4407-a44d-6096147de575','acl_roles_users','ACLRoles','acl_roles','id','Users','users','id','acl_roles_users','role_id','user_id','many-to-many',NULL,NULL,0,0),('89f03f08-0737-46b9-9337-846f21951044','aos_invoices_assigned_user','Users','users','id','AOS_Invoices','aos_invoices','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('8cad248f-ab24-4da6-81a9-6e01d070cf8f','surveyresponses_contacts','Contacts','contacts','id','SurveyResponses','surveyresponses','contact_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('8dc91e93-ccda-407c-a2c0-a51faf45b830','aos_quotes_aos_contracts','AOS_Quotes','aos_quotes','id','AOS_Contracts','aos_contracts','id','aos_quotes_os_contracts_c','aos_quotese81e_quotes_ida','aos_quotes4dc0ntracts_idb','many-to-many',NULL,NULL,0,0),('8dff18ae-061a-4b70-9858-fd6660f1e4f5','contacts_email_addresses','Contacts','contacts','id','EmailAddresses','email_addresses','id','email_addr_bean_rel','bean_id','email_address_id','many-to-many','bean_module','Contacts',0,0),('8eca34b9-5ac2-4848-9050-a76764e76293','bugs_release','Releases','releases','id','Bugs','bugs','found_in_release',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('8f054ee2-b6f8-4cce-8164-88b02693b604','jjwg_Maps_meetings','jjwg_Maps','jjwg_Maps','parent_id','Meetings','meetings','id',NULL,NULL,NULL,'one-to-many','parent_type','Meetings',0,0),('8fab693c-552b-4b1a-93d4-90b19eb25245','user_direct_reports','Users','users','id','Users','users','reports_to_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('8fac52ef-47df-4691-a72c-5eeca4a3de20','contacts_aop_case_updates','Contacts','contacts','id','AOP_Case_Updates','aop_case_updates','contact_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('912382c9-7993-41a7-9420-eb1444cb43e4','member_accounts','Accounts','accounts','id','Accounts','accounts','parent_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('9221ac4e-5f5a-41d5-a1e2-7f3a692ed69e','contacts_assigned_user','Users','users','id','Contacts','contacts','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('92371eb7-0204-461b-a0bb-d6c58c534858','securitygroups_aok_knowledgebase','SecurityGroups','securitygroups','id','AOK_KnowledgeBase','aok_knowledgebase','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','AOK_KnowledgeBase',0,0),('930515e6-6e35-43e1-8df1-9077c6f19db9','reminders_modified_user','Users','users','id','Reminders','reminders','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('93f0a809-4e88-44a9-b48a-ee7dbc3af943','emailtemplates_assigned_user','Users','users','id','EmailTemplates','email_templates','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('93f4094c-abc8-4a6e-a906-e2e6f7038ac9','securitygroups_emailmarketing','SecurityGroups','securitygroups','id','EmailMarketing','email_marketing','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','EmailMarketing',0,0),('95f22a20-da10-41ea-9ec2-89ba63f87c8c','aow_conditions_created_by','Users','users','id','AOW_Conditions','aow_conditions','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('96a546e2-ecc0-49ad-a290-de74fb22f5db','leads_email_addresses','Leads','leads','id','EmailAddresses','email_addresses','id','email_addr_bean_rel','bean_id','email_address_id','many-to-many','bean_module','Leads',0,0),('97484c1c-075a-4c6e-80d2-a01dae5dc24a','contact_campaign_log','Contacts','contacts','id','CampaignLog','campaign_log','target_id',NULL,NULL,NULL,'one-to-many','target_type','Contacts',0,0),('97c312b9-0e15-4609-a21c-6b0b072d0ed5','securitygroups_aos_contracts','SecurityGroups','securitygroups','id','AOS_Contracts','aos_contracts','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','AOS_Contracts',0,0),('985c4fd8-d5ad-4db6-a683-8d83d5641587','eapm_modified_user','Users','users','id','EAPM','eapm','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('9884394e-62c7-4b34-bd20-f6d1cfee4a83','opportunities_created_by','Users','users','id','Opportunities','opportunities','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('992bac6b-65ac-4a09-a110-bdeda511b41f','aos_quotes_aos_line_item_groups','AOS_Quotes','aos_quotes','id','AOS_Line_Item_Groups','aos_line_item_groups','parent_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('9a05f0bd-2005-4b5d-9c9f-0a8014f1a5aa','opportunity_notes','Opportunities','opportunities','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Opportunities',0,0),('9a2c2356-c9fc-490f-af94-23a1c5b572f5','securitygroups_surveyresponses','SecurityGroups','securitygroups','id','SurveyResponses','surveyresponses','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','SurveyResponses',0,0),('9a4714a2-ebba-4cb3-865b-abfc781552f6','documents_accounts','Documents','documents','id','Accounts','accounts','id','documents_accounts','document_id','account_id','many-to-many',NULL,NULL,0,0),('9aa514a8-f2b8-4faf-9b35-0f0ebdd78b66','accounts_bugs','Accounts','accounts','id','Bugs','bugs','id','accounts_bugs','account_id','bug_id','many-to-many',NULL,NULL,0,0),('9b2239c4-2ac5-4523-aa23-f7d41f1e6dc4','aos_contracts_assigned_user','Users','users','id','AOS_Contracts','aos_contracts','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('9b57798c-c3d3-403d-af8b-e4b163350b52','reminders_assigned_user','Users','users','id','Reminders','reminders','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('9db38d68-8dc8-4cf3-b0b9-76022528acf8','surveyresponses_campaigns','Campaigns','campaigns','id','SurveyResponses','surveyresponses','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('9eeb3885-2428-46f0-a20c-6e54c41a93d7','oauth2authcodes_assigned_user','Users','users','id','OAuth2AuthCodes','oauth2authcodes','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('9fb0c1a1-1c1b-4eae-ad51-932ff3357ced','bugs_fixed_in_release','Releases','releases','id','Bugs','bugs','fixed_in_release',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a1310cd7-d0ac-476a-bc2f-aedb29057434','schedulers_jobs_rel','Schedulers','schedulers','id','SchedulersJobs','job_queue','scheduler_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a1bdca44-9f6c-421a-bf8e-c846bfdadd50','aos_contracts_tasks','AOS_Contracts','aos_contracts','id','Tasks','tasks','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','AOS_Contracts',0,0),('a1dea7a9-f284-42ec-9b18-992e13d1ad7b','prospect_list_campaigns','ProspectLists','prospect_lists','id','Campaigns','campaigns','id','prospect_list_campaigns','prospect_list_id','campaign_id','many-to-many',NULL,NULL,0,0),('a217cfaf-4f18-4cf7-a8db-c698a560167d','aos_invoices_aos_product_quotes','AOS_Invoices','aos_invoices','id','AOS_Products_Quotes','aos_products_quotes','parent_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a2192186-db00-4802-9190-cf7d08e6dd2d','surveys_surveyquestions','Surveys','surveys','id','SurveyQuestions','surveyquestions','survey_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a25de268-f917-448d-af8b-6c22c9b555b3','securitygroups_jjwg_areas','SecurityGroups','securitygroups','id','jjwg_Areas','jjwg_areas','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','jjwg_Areas',0,0),('a3c4a515-3494-4b03-85b5-8ae40f860a72','aop_case_events_assigned_user','Users','users','id','AOP_Case_Events','aop_case_events','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a3e03c72-e52b-49b0-a830-a10407b90ebd','accounts_assigned_user','Users','users','id','Accounts','accounts','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a3f7f598-f4e3-48a2-bf26-74ba871451d6','aor_reports_modified_user','Users','users','id','AOR_Reports','aor_reports','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a53ef2b6-c53f-4b1a-b8dc-8f59fd89fc9b','contacts_created_by','Users','users','id','Contacts','contacts','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a56108eb-0872-4ab7-ac6f-1975a65ac620','prospect_calls','Prospects','prospects','id','Calls','calls','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Prospects',0,0),('a565f5e1-f42c-4100-9056-f1f3da2507e2','accounts_email_addresses','Accounts','accounts','id','EmailAddresses','email_addresses','id','email_addr_bean_rel','bean_id','email_address_id','many-to-many','bean_module','Accounts',0,0),('a5d8816b-93a3-4360-a356-c9d745802bce','surveyquestionoptions_created_by','Users','users','id','SurveyQuestionOptions','surveyquestionoptions','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a5e8304a-6ddf-4d9c-9fbc-ac4b37b86e0d','emails_created_by','Users','users','id','Emails','emails','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a64eb1fb-939e-4155-8d8a-c2399228b456','cases_aop_case_events','Cases','cases','id','AOP_Case_Events','aop_case_events','case_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a65c74c1-831e-4a9b-9cba-0cd3f0bbf982','account_notes','Accounts','accounts','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Accounts',0,0),('a74faf7e-7971-4507-bcc4-fc5f0ed9dbbc','favorites_modified_user','Users','users','id','Favorites','favorites','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a798fc3a-f9b1-409f-ba4c-3102c46da97e','aos_products_quotes_assigned_user','Users','users','id','AOS_Products_Quotes','aos_products_quotes','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('a9ec0d87-9e0c-4eef-9b5d-ea74abd58f24','securitygroups_calls','SecurityGroups','securitygroups','id','Calls','calls','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Calls',0,0),('a9f9921d-6e2c-4cdc-8801-41b8570833fb','am_projecttemplates_contacts_1','AM_ProjectTemplates','am_projecttemplates','id','Contacts','contacts','id','am_projecttemplates_contacts_1_c','am_projecttemplates_ida','contacts_idb','many-to-many',NULL,NULL,0,0),('aa364df0-6cc9-4f96-a5da-72294e1f57f7','aos_quotes_assigned_user','Users','users','id','AOS_Quotes','aos_quotes','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('aa417d1e-4b92-4668-b444-b70e96e32c55','aor_reports_assigned_user','Users','users','id','AOR_Reports','aor_reports','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('aabc0c9a-03fb-4467-abe5-0fee010e70f5','bugs_modified_user','Users','users','id','Bugs','bugs','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('ab50e0ea-1bf1-49d1-a5d0-b2f246facb04','surveys_surveyresponses','Surveys','surveys','id','SurveyResponses','surveyresponses','survey_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('abbcfeb5-9588-4c4c-a505-8c20a9f45c31','project_contacts_1','Project','project','id','Contacts','contacts','id','project_contacts_1_c','project_contacts_1project_ida','project_contacts_1contacts_idb','many-to-many',NULL,NULL,0,0),('abf7af2e-4a69-465c-b527-561c53447e61','meetings_leads','Meetings','meetings','id','Leads','leads','id','meetings_leads','meeting_id','lead_id','many-to-many',NULL,NULL,0,0),('ad5d287b-3f26-445a-bfb5-f225c45595bd','aow_actions_modified_user','Users','users','id','AOW_Actions','aow_actions','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('adaefffd-50a2-4b6c-a516-b26d340e6538','aos_products_quotes_modified_user','Users','users','id','AOS_Products_Quotes','aos_products_quotes','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('adfd17d7-0dea-4819-b898-56e1cee09270','leads_documents','Leads','leads','id','Documents','documents','id','linked_documents','parent_id','document_id','many-to-many','parent_type','Leads',0,0),('ae06487f-7039-44df-bdc0-f164fc7a5101','leads_email_addresses_primary','Leads','leads','id','EmailAddresses','email_addresses','id','email_addr_bean_rel','bean_id','email_address_id','many-to-many','primary_address','1',0,0),('ae84872b-7614-4389-8f3b-5748b86a4bdd','securitygroups_surveyquestionresponses','SecurityGroups','securitygroups','id','SurveyQuestionResponses','surveyquestionresponses','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','SurveyQuestionResponses',0,0),('afdb0e42-9c26-4075-9058-78ccf84fd236','aos_pdf_templates_modified_user','Users','users','id','AOS_PDF_Templates','aos_pdf_templates','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b11fa532-8eaf-4f91-8cf1-881eb8b4f285','securitygroups_aos_invoices','SecurityGroups','securitygroups','id','AOS_Invoices','aos_invoices','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','AOS_Invoices',0,0),('b34f8cd3-63ae-4401-9552-641d69e98b8b','favorites_assigned_user','Users','users','id','Favorites','favorites','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b39d3ffc-12fd-48d8-9405-93996684a53d','inbound_emails_external_oauth_connections','ExternalOAuthConnection','external_oauth_connections','id','InboundEmail','inbound_email','external_oauth_connection_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b407044d-8255-4ece-b357-e57df0abefae','lead_tasks','Leads','leads','id','Tasks','tasks','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Leads',0,0),('b44dad16-dde1-433f-bba2-aeac2d75b184','jjwg_maps_created_by','Users','users','id','jjwg_Maps','jjwg_maps','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b4bf5fba-2ec9-45a0-b02c-891acb3a8d93','emails_modified_user','Users','users','id','Emails','emails','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b501386e-f7bf-42a1-b1d4-f3e0ceecd6a1','emails_accounts_rel','Emails','emails','id','Accounts','accounts','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Accounts',0,0),('b54ae840-3a60-467d-b2c8-56eca358b4dd','tasks_created_by','Users','users','id','Tasks','tasks','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b58417c0-22a0-43e3-9c5e-aae94f5917f0','surveys_assigned_user','Users','users','id','Surveys','surveys','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b58f6c2f-bc54-413b-8cae-00a6dd943595','securitygroups_users','SecurityGroups','securitygroups','id','Users','users','id','securitygroups_users','securitygroup_id','user_id','many-to-many',NULL,NULL,0,0),('b65e8ae9-4d97-48f8-93bc-aca334a4ca6c','surveys_created_by','Users','users','id','Surveys','surveys','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b66d317a-32ba-45a0-95ab-916596973134','emails_tasks_rel','Emails','emails','id','Tasks','tasks','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Tasks',0,0),('b6900193-bd9e-43db-91e9-0288c57a25ec','eapm_created_by','Users','users','id','EAPM','eapm','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b696c752-8efc-42b8-82c4-2de9d2eb7129','projects_modified_user','Users','users','id','Project','project','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b8155287-bdb4-49ee-8074-33905763ccef','lead_notes','Leads','leads','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Leads',0,0),('b8466ba3-f29a-4c15-9a1c-558f89c01ed6','calendaraccount_assigned_user','Users','users','id','CalendarAccount','calendar_accounts','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b8558c51-ad25-41ec-88f2-5d7032308d2e','projects_bugs','Project','project','id','Bugs','bugs','id','projects_bugs','project_id','bug_id','many-to-many',NULL,NULL,0,0),('b859dc57-00e9-4c3f-a3e2-624286aaa0ba','aor_charts_created_by','Users','users','id','AOR_Charts','aor_charts','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('b8dad166-d1a8-4d1e-a529-541f30d1d4c7','emails_project_task_rel','Emails','emails','id','ProjectTask','project_task','id','emails_beans','email_id','bean_id','many-to-many','bean_module','ProjectTask',0,0),('b8e146ae-4e1e-4cbd-844f-23ce85be5081','opportunities_contacts','Opportunities','opportunities','id','Contacts','contacts','id','opportunities_contacts','opportunity_id','contact_id','many-to-many',NULL,NULL,0,0),('b8ff90c1-9693-4280-baf1-278ada654079','securitygroups_surveys','SecurityGroups','securitygroups','id','Surveys','surveys','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Surveys',0,0),('b93cfdbb-12a7-4c19-bf21-0e1fa5cf5df3','securitygroups_bugs','SecurityGroups','securitygroups','id','Bugs','bugs','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Bugs',0,0),('b9ea6c5e-1f15-4c8c-81aa-6b93050b853f','aok_knowledge_base_categories_created_by','Users','users','id','AOK_Knowledge_Base_Categories','aok_knowledge_base_categories','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('bb085927-c1a6-437d-bb41-b141df901829','emails_contacts_rel','Emails','emails','id','Contacts','contacts','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Contacts',0,0),('bb31ac1a-df94-46b2-a4f5-b47d936ab39a','externaloauthprovider_modified_user','Users','users','id','ExternalOAuthProvider','external_oauth_providers','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('bb5a4621-d359-4b28-af6b-73f06cae1b1c','fp_events_contacts','FP_events','fp_events','id','Contacts','contacts','id','fp_events_contacts_c','fp_events_contactsfp_events_ida','fp_events_contactscontacts_idb','many-to-many',NULL,NULL,0,0),('bcf9dafa-eb07-4331-a157-c86ea8a9729b','spots_created_by','Users','users','id','Spots','spots','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('bdad86aa-6f42-4d5b-adba-f2e34572adf2','jjwg_address_cache_assigned_user','Users','users','id','jjwg_Address_Cache','jjwg_address_cache','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('be4551b4-bd44-499c-bccc-63756ae94d29','am_tasktemplates_am_projecttemplates','AM_ProjectTemplates','am_projecttemplates','id','AM_TaskTemplates','am_tasktemplates','id','am_tasktemplates_am_projecttemplates_c','am_tasktemplates_am_projecttemplatesam_projecttemplates_ida','am_tasktemplates_am_projecttemplatesam_tasktemplates_idb','many-to-many',NULL,NULL,0,0),('be7996e0-af40-471d-a061-b95efcc743ec','aos_invoices_created_by','Users','users','id','AOS_Invoices','aos_invoices','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c03b8693-183c-43ed-8c88-45d731499bf3','account_leads','Accounts','accounts','id','Leads','leads','account_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c0a996e3-fbcc-45c2-b4c8-db79aed6190b','reminders_invitees_modified_user','Users','users','id','Reminders_Invitees','reminders_invitees','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c0c07359-4ff6-4c83-937a-a6a4f4f40af7','jjwg_markers_modified_user','Users','users','id','jjwg_Markers','jjwg_markers','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c101b419-243c-4fd4-aabb-e89c0657ca7a','consumer_tokens','OAuthKeys','oauth_consumer','id','OAuthTokens','oauth_tokens','consumer',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c180ad00-174d-4e76-99a8-4c2fbca2f10d','project_tasks_emails','ProjectTask','project_task','id','Emails','emails','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','ProjectTask',0,0),('c186f4bd-6807-4482-bf5a-74f376bfa1f9','projects_notes','Project','project','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Project',0,0),('c1d42326-f24b-44ec-bf2b-ab6e4b5d3a98','contact_tasks_parent','Contacts','contacts','id','Tasks','tasks','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Contacts',0,0),('c1ffc315-ea30-4fb6-b23b-e0bdc997ca23','document_revisions','Documents','documents','id','DocumentRevisions','document_revisions','document_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c211d51b-564a-4f2d-8d5e-c7411ee26fe4','aow_workflow_created_by','Users','users','id','AOW_WorkFlow','aow_workflow','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c25a40f6-aa0c-46fe-954e-8c14e6223ff8','aor_reports_aor_conditions','AOR_Reports','aor_reports','id','AOR_Conditions','aor_conditions','aor_report_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c261a55a-450b-4b4e-a1ff-c9fa1ac9f46c','surveyquestionresponses_created_by','Users','users','id','SurveyQuestionResponses','surveyquestionresponses','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c300eb96-6f83-4395-93f9-599bb1d97585','account_aos_quotes','Accounts','accounts','id','AOS_Quotes','aos_quotes','billing_account_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c40cf6a3-1e71-4b19-ba60-17414d22c5a4','aor_fields_modified_user','Users','users','id','AOR_Fields','aor_fields','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c445e0c3-1e7f-4ffc-9645-7285b9607d9e','aos_pdf_templates_assigned_user','Users','users','id','AOS_PDF_Templates','aos_pdf_templates','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c47b31e7-7462-4b61-9fb9-6a3dfc30de7d','contact_direct_reports','Contacts','contacts','id','Contacts','contacts','reports_to_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c510e00f-0f2c-446b-8964-a9ea417e86e9','securitygroups_aow_workflow','SecurityGroups','securitygroups','id','AOW_WorkFlow','aow_workflow','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','AOW_WorkFlow',0,0),('c5370f85-5747-454a-8a1d-6bfae2c7246e','groups_aos_product_quotes','AOS_Line_Item_Groups','aos_line_item_groups','id','AOS_Products_Quotes','aos_products_quotes','group_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c6481c71-5362-4a97-bef3-a13abf8d9448','jjwg_markers_created_by','Users','users','id','jjwg_Markers','jjwg_markers','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c688b791-7aeb-4640-baed-b7875d61cff1','aos_line_item_groups_assigned_user','Users','users','id','AOS_Line_Item_Groups','aos_line_item_groups','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c72e7c54-c35c-4c0e-9859-a963656b494f','campaignlog_targeted_users','CampaignLog','campaign_log','target_id','Users','users','id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c755c6c8-0a76-44f8-ae09-ee99bf0f7a9f','aok_knowledgebase_categories','AOK_KnowledgeBase','aok_knowledgebase','id','AOK_Knowledge_Base_Categories','aok_knowledge_base_categories','id','aok_knowledgebase_categories','aok_knowledgebase_id','aok_knowledge_base_categories_id','many-to-many',NULL,NULL,0,0),('c89f4eac-0b31-4703-82d7-5e528be5adab','am_tasktemplates_modified_user','Users','users','id','AM_TaskTemplates','am_tasktemplates','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c8a6ad30-a969-4413-a714-fc903d591501','oauth2authcodes_created_by','Users','users','id','OAuth2AuthCodes','oauth2authcodes','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('c8caf37e-5c15-4868-8fba-18eae7615b1d','securitygroups_outboundemailaccounts','SecurityGroups','securitygroups','id','OutboundEmailAccounts','outbound_email','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','OutboundEmailAccounts',0,0),('c93600a9-8cdc-476b-95a2-ec50a6791d8c','emails_aos_contracts_rel','Emails','emails','id','AOS_Contracts','aos_contracts','id','emails_beans','email_id','bean_id','many-to-many','bean_module','AOS_Contracts',0,0),('c9869da6-6b08-4af2-822a-46808b99b13f','aos_contracts_meetings','AOS_Contracts','aos_contracts','id','Meetings','meetings','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','AOS_Contracts',0,0),('caffd987-b62b-49a5-bfa5-04db3901be9a','inbound_outbound_email_accounts','OutboundEmailAccounts','outbound_email','id','InboundEmail','inbound_email','outbound_email_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('cbd9f5dd-e379-4966-b02e-645a16c78d2f','campaigns_assigned_user','Users','users','id','Campaigns','campaigns','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('cc072fde-6285-49bf-8da8-cb1fde0ad4f9','bugs_created_by','Users','users','id','Bugs','bugs','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('cca3f6f6-cd7d-46b3-97c6-a9a9633991cb','calls_contacts','Calls','calls','id','Contacts','contacts','id','calls_contacts','call_id','contact_id','many-to-many',NULL,NULL,0,0),('ccca8671-df62-4673-beaf-d91dad72e503','jjwg_areas_modified_user','Users','users','id','jjwg_Areas','jjwg_areas','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('ccd3fa33-c0e6-4ea2-8116-9d0bfb302337','surveyquestions_assigned_user','Users','users','id','SurveyQuestions','surveyquestions','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('cdc79fa0-2e67-4cc9-8cd3-087acb9e6f51','securitygroups_cases','SecurityGroups','securitygroups','id','Cases','cases','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Cases',0,0),('cdca9712-48d3-4060-a0aa-8d3ececec396','campaigns_created_by','Users','users','id','Campaigns','campaigns','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('cdfac44a-5c15-47c9-b93f-dc2c581af065','revisions_created_by','Users','users','id','DocumentRevisions','document_revisions','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('ce90089f-e240-4e26-9a5f-9ea1c1a84acc','opportunities_campaign','Campaigns','campaigns','id','Opportunities','opportunities','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('ce97dfbf-6b9f-4b9a-a5eb-f2c7e8785e93','calls_users','Calls','calls','id','Users','users','id','calls_users','call_id','user_id','many-to-many',NULL,NULL,0,0),('ceef930b-c8f3-4c3c-8188-486e00984318','surveyquestions_modified_user','Users','users','id','SurveyQuestions','surveyquestions','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('cf928f58-fd04-44a5-806c-60339a01e451','product_categories','AOS_Product_Categories','aos_product_categories','id','AOS_Products','aos_products','aos_product_category_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d002d38e-511d-4500-b844-69451406dfb8','jjwg_Maps_leads','jjwg_Maps','jjwg_Maps','parent_id','Leads','leads','id',NULL,NULL,NULL,'one-to-many','parent_type','Leads',0,0),('d1ba6499-dc62-4f56-9279-2b1020d45ade','meetings_assigned_user','Users','users','id','Meetings','meetings','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d204742f-ae5a-4133-8fb1-08883bb269b8','surveyquestionresponses_modified_user','Users','users','id','SurveyQuestionResponses','surveyquestionresponses','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d3c1d8e0-35ae-409e-ada4-f9e725384591','project_tasks_calls','ProjectTask','project_task','id','Calls','calls','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','ProjectTask',0,0),('d4a36c8f-07e1-478d-b02f-56f3f331b618','aod_indexevent_modified_user','Users','users','id','AOD_IndexEvent','aod_indexevent','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d506d970-bb44-4c34-8b24-32cbb24e66d3','account_aos_contracts','Accounts','accounts','id','AOS_Contracts','aos_contracts','contract_account_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d558b058-7a0c-49ec-a46f-f2d67caffd32','am_projecttemplates_users_1','AM_ProjectTemplates','am_projecttemplates','id','Users','users','id','am_projecttemplates_users_1_c','am_projecttemplates_ida','users_idb','many-to-many',NULL,NULL,0,0),('d5ae63bc-5561-421d-8da3-0da4d2d1c217','fp_event_locations_created_by','Users','users','id','FP_Event_Locations','fp_event_locations','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d5c0ed83-86eb-4e9e-b833-ce1d2680f238','surveyresponses_modified_user','Users','users','id','SurveyResponses','surveyresponses','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d638f42e-a610-4c8c-ad2c-b0b34c39ccf2','aok_knowledgebase_created_by','Users','users','id','AOK_KnowledgeBase','aok_knowledgebase','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d683e319-8248-472f-874d-c9da466d9070','projects_opportunities','Project','project','id','Opportunities','opportunities','id','projects_opportunities','project_id','opportunity_id','many-to-many',NULL,NULL,0,0),('d6acd67e-b64d-461e-9183-b826d9dd7fc9','campaign_campaigntrakers','Campaigns','campaigns','id','CampaignTrackers','campaign_trkrs','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d6ce4a03-fa70-4b17-97ba-4d6ce0247d48','prospect_notes','Prospects','prospects','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Prospects',0,0),('d80f15cd-58e1-4148-9f66-f23bfc61b20e','jjwg_Maps_cases','jjwg_Maps','jjwg_Maps','parent_id','Cases','cases','id',NULL,NULL,NULL,'one-to-many','parent_type','Cases',0,0),('d8398760-be92-4d25-ae8e-862de5296ac4','aos_product_quotes_aos_products','AOS_Products','aos_products','id','AOS_Products_Quotes','aos_products_quotes','product_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d8535616-967a-4169-88ac-e6d7f5e4b124','contact_aos_contracts','Contacts','contacts','id','AOS_Contracts','aos_contracts','contact_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d8d21b34-92b7-44ae-bae5-cccb9ba7c927','roles_users','Roles','roles','id','Users','users','id','roles_users','role_id','user_id','many-to-many',NULL,NULL,0,0),('d8e61dc1-8509-45ed-9f18-fb8650f707b7','inbound_emails_case_email_templates','EmailTemplates','email_templates','id','InboundEmail','inbound_email','create_case_template_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('d965dbae-71fa-4d25-8859-7e9e80312c6c','aos_product_categories_modified_user','Users','users','id','AOS_Product_Categories','aos_product_categories','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('dae1043b-b261-44a1-841f-4892f414e858','securitygroups_aos_pdf_templates','SecurityGroups','securitygroups','id','AOS_PDF_Templates','aos_pdf_templates','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','AOS_PDF_Templates',0,0),('db91ede4-9365-476d-8a16-97fec87465da','fp_events_assigned_user','Users','users','id','FP_events','fp_events','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('dbd4e760-32d3-4b1e-a4c7-815bf37a755d','fp_events_modified_user','Users','users','id','FP_events','fp_events','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('dc4733db-bc99-4f14-8d12-199e1a83fb58','oauth2authcodes_modified_user','Users','users','id','OAuth2AuthCodes','oauth2authcodes','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('dc685389-0a73-48b9-8db4-f923fbb161d5','opportunity_aos_contracts','Opportunities','opportunities','id','AOS_Contracts','aos_contracts','opportunity_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('ddea9984-10e3-4c5d-bda6-0b65e1aee4e9','account_cases','Accounts','accounts','id','Cases','cases','account_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('ddfb87e8-3dd0-4366-96b4-855f4098f386','aos_invoices_aos_line_item_groups','AOS_Invoices','aos_invoices','id','AOS_Line_Item_Groups','aos_line_item_groups','parent_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('de588c78-5a39-4f7b-bf8d-ae31b73c24f0','oauthkeys_modified_user','Users','users','id','OAuthKeys','oauth_consumer','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('de844682-f5f8-4fa6-a4e1-4a81f66c6749','campaignlog_created_opportunities','CampaignLog','campaign_log','related_id','Opportunities','opportunities','id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('df7164f6-d976-45ff-9191-fbecae4f3243','securitygroups_acl_roles','SecurityGroups','securitygroups','id','ACLRoles','acl_roles','id','securitygroups_acl_roles','securitygroup_id','role_id','many-to-many',NULL,NULL,0,0),('df747a01-0e1b-40bb-82be-d05379c6089b','aos_quotes_modified_user','Users','users','id','AOS_Quotes','aos_quotes','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('df888cee-a91d-4ddd-91b5-f243e604f60e','aos_products_assigned_user','Users','users','id','AOS_Products','aos_products','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('e053a5a1-ed4d-4486-8005-00e57a00a7ca','campaign_prospects','Campaigns','campaigns','id','Prospects','prospects','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('e08e9b19-bb54-428f-bae3-9915370fbfcb','cases_modified_user','Users','users','id','Cases','cases','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('e1ab19b6-ebbd-4675-8317-1d6910a84734','leads_assigned_user','Users','users','id','Leads','leads','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('e3031beb-7ca1-4361-ac7a-1d66aabc2810','meetings_notes','Meetings','meetings','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Meetings',0,0),('e3ce6e20-eac7-447e-bd3b-83dd301b12c3','acl_roles_actions','ACLRoles','acl_roles','id','ACLActions','acl_actions','id','acl_roles_actions','role_id','action_id','many-to-many',NULL,NULL,0,0),('e4bf1e82-4ed6-434d-8fe4-d41ed086edee','reminders_invitees_created_by','Users','users','id','Reminders_Invitees','reminders_invitees','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('e4e56a73-9a31-4e7d-9a04-1a0c20c038b6','oauth2clients_modified_user','Users','users','id','OAuth2Clients','oauth2clients','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('e572ecf5-d58d-4934-affa-561fcac55e3d','campaign_accounts','Campaigns','campaigns','id','Accounts','accounts','campaign_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('e58907c5-52bd-46ae-b2f6-6baacc46deb1','calendar_account_meetings','CalendarAccount','calendar_accounts','id','Meetings','meetings','id','calendar_account_meetings','calendar_account_id','meeting_id','one-to-many',NULL,NULL,0,0),('e5cce463-e264-48da-b34d-765160c06398','account_meetings','Accounts','accounts','id','Meetings','meetings','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Accounts',0,0),('e6e62e73-33c4-4a23-9198-ce2eb3cd35f3','aod_indexevent_created_by','Users','users','id','AOD_IndexEvent','aod_indexevent','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('e7ca4346-63a6-4d37-850b-a9cce222634b','emails_leads_rel','Emails','emails','id','Leads','leads','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Leads',0,0),('e82c069f-fb16-4956-b103-9640eff8b8a9','securitygroups_jjwg_markers','SecurityGroups','securitygroups','id','jjwg_Markers','jjwg_markers','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','jjwg_Markers',0,0),('e94079ee-a9b0-4ab5-bf6a-00dac1631e39','bug_meetings','Bugs','bugs','id','Meetings','meetings','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Bugs',0,0),('e94e3ef9-39a6-421f-95e2-dae901f70132','leads_modified_user','Users','users','id','Leads','leads','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('e95f2f59-28e9-4bce-bb21-a3ddbe23d1e5','oauth2tokens_assigned_user','Users','users','id','OAuth2Tokens','oauth2tokens','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('e9913c9c-a24a-48a8-913a-0452f79f80ea','securitygroups_prospectlists','SecurityGroups','securitygroups','id','ProspectLists','prospect_lists','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','ProspectLists',0,0),('e9c7a4f4-7a26-4e78-ad52-4f382c9bd475','campaignlog_sent_emails','CampaignLog','campaign_log','related_id','Emails','emails','id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('eae1851d-8a59-48a5-84c0-acc76a4f88c4','prospects_created_by','Users','users','id','Prospects','prospects','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('eb1cac44-348c-4fac-badc-2b53478b3c94','templatesectionline_created_by','Users','users','id','TemplateSectionLine','templatesectionline','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('eb2f9eb1-3f8d-481a-b2a5-d0f1977f7d64','outbound_email_owner_user','Users','users','id','OutboundEmailAccounts','outbound_email','user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('eb97a02e-e568-4c0b-98b0-4a24dc3bebb5','aor_reports_aor_fields','AOR_Reports','aor_reports','id','AOR_Fields','aor_fields','aor_report_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('ebbb3011-1370-4387-8b50-04a165c7823e','securitygroups_emails','SecurityGroups','securitygroups','id','Emails','emails','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','Emails',0,0),('edc80ec8-e445-48c6-b165-08596e5f0ff7','surveyquestions_surveyquestionresponses','SurveyQuestions','surveyquestions','id','SurveyQuestionResponses','surveyquestionresponses','surveyquestion_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('ee81cbcc-9138-4ca0-8570-70b2c51c5ca3','jjwg_address_cache_created_by','Users','users','id','jjwg_Address_Cache','jjwg_address_cache','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('eec665fa-aa31-434f-bc1c-df8a2bd15127','calendaraccount_created_by','Users','users','id','CalendarAccount','calendar_accounts','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('eecff0b5-42dd-4644-9fa9-d3304c8546c6','emails_bugs_rel','Emails','emails','id','Bugs','bugs','id','emails_beans','email_id','bean_id','many-to-many','bean_module','Bugs',0,0),('ef7c6811-b1be-4db1-ac18-097a339c9847','sugarfeed_modified_user','Users','users','id','SugarFeed','sugarfeed','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f1926718-e5b1-404a-b218-59d2d8cd2d7c','outbound_email_created_by','Users','users','id','OutboundEmailAccounts','outbound_email','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f1a341e3-dd38-4377-94e9-2dc3d4b71e6a','cases_bugs','Cases','cases','id','Bugs','bugs','id','cases_bugs','case_id','bug_id','many-to-many',NULL,NULL,0,0),('f1db1864-9c33-4df4-8d20-fd8f6dae8c62','bugs_assigned_user','Users','users','id','Bugs','bugs','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f1f45a71-6b3f-4c68-8f15-865a620dd519','aok_knowledge_base_categories_modified_user','Users','users','id','AOK_Knowledge_Base_Categories','aok_knowledge_base_categories','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f271a66d-b030-49e6-b5ef-8bcd75bc6994','securitygroups_emailtemplates','SecurityGroups','securitygroups','id','EmailTemplates','email_templates','id','securitygroups_records','securitygroup_id','record_id','many-to-many','module','EmailTemplates',0,0),('f2b837e2-18e9-4535-82b9-afc2d873417c','opportunity_tasks','Opportunities','opportunities','id','Tasks','tasks','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Opportunities',0,0),('f421ccfe-665c-4609-ac88-880f3100b552','documents_opportunities','Documents','documents','id','Opportunities','opportunities','id','documents_opportunities','document_id','opportunity_id','many-to-many',NULL,NULL,0,0),('f42637cf-d9a4-4169-b27e-c4fe181ea0a8','tasks_assigned_user','Users','users','id','Tasks','tasks','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f4468c26-d0a9-4d7c-9c28-683fd7aa0097','aok_knowledgebase_modified_user','Users','users','id','AOK_KnowledgeBase','aok_knowledgebase','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f4916b35-43cf-4901-ab97-436c94f09e62','aor_conditions_modified_user','Users','users','id','AOR_Conditions','aor_conditions','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f604fb25-0c51-4240-90a2-d7527aefd074','opportunity_calls','Opportunities','opportunities','id','Calls','calls','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Opportunities',0,0),('f745c856-4f24-4184-8f5a-35ef83a8f2f1','lead_calls','Leads','leads','id','Calls','calls','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Leads',0,0),('f835723c-d024-41a6-b214-38936c8468b7','aop_case_updates_created_by','Users','users','id','AOP_Case_Updates','aop_case_updates','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f8794be3-24dd-4bc0-8127-b95d0211c890','securitygroups_assigned_user','Users','users','id','SecurityGroups','securitygroups','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f8b07ea5-67c9-443e-89ed-0626f7c0e6e6','aop_case_updates_assigned_user','Users','users','id','AOP_Case_Updates','aop_case_updates','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f9579b34-7d90-4f1a-a6f5-bf6a48e783b2','tasks_modified_user','Users','users','id','Tasks','tasks','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f9a57411-a32d-48e5-bdd3-5d5a0a571705','surveyresponses_assigned_user','Users','users','id','SurveyResponses','surveyresponses','assigned_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f9a5dc1c-c69b-4539-a256-de688e4650fc','aow_workflow_modified_user','Users','users','id','AOW_WorkFlow','aow_workflow','modified_user_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('f9baeded-4de4-4089-8ff4-2324e59611a0','documents_contacts','Documents','documents','id','Contacts','contacts','id','documents_contacts','document_id','contact_id','many-to-many',NULL,NULL,0,0),('fdc3a659-f8c7-4726-a0d0-ce201a54a0ef','fp_event_locations_fp_events_1','FP_Event_Locations','fp_event_locations','id','FP_events','fp_events','id','fp_event_locations_fp_events_1_c','fp_event_locations_fp_events_1fp_event_locations_ida','fp_event_locations_fp_events_1fp_events_idb','many-to-many',NULL,NULL,0,0),('fe000f30-bfe5-4843-944e-1d9d35e80aae','externaloauthconnection_created_by','Users','users','id','ExternalOAuthConnection','external_oauth_connections','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('fe3a88dc-bcea-40a3-a0c9-25abf12fcf0a','bug_notes','Bugs','bugs','id','Notes','notes','parent_id',NULL,NULL,NULL,'one-to-many','parent_type','Bugs',0,0),('fe9c0074-6345-4571-9a06-79b68db3c75b','surveys_campaigns','Surveys','surveys','id','Campaigns','campaigns','survey_id',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('feb5fdb0-f417-4ae7-8402-6a5c5982c054','calls_created_by','Users','users','id','Calls','calls','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0),('ffd8de48-8388-4094-9537-f0e9a9d559a9','calls_reschedule_created_by','Users','users','id','Calls_Reschedule','calls_reschedule','created_by',NULL,NULL,NULL,'one-to-many',NULL,NULL,0,0);
/*!40000 ALTER TABLE `relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `releases`
--

DROP TABLE IF EXISTS `releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `releases` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `list_order` int DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_releases` (`name`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `releases`
--

LOCK TABLES `releases` WRITE;
/*!40000 ALTER TABLE `releases` DISABLE KEYS */;
/*!40000 ALTER TABLE `releases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reminders` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `popup` tinyint(1) DEFAULT NULL,
  `email` tinyint(1) DEFAULT NULL,
  `email_sent` tinyint(1) DEFAULT NULL,
  `timer_popup` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `timer_email` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_event_module` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_event_module_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_willexecute` int DEFAULT '-1',
  `popup_viewed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_reminder_name` (`name`),
  KEY `idx_reminder_deleted` (`deleted`),
  KEY `idx_reminder_related_event_module` (`related_event_module`),
  KEY `idx_reminder_related_event_module_id` (`related_event_module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminders`
--

LOCK TABLES `reminders` WRITE;
/*!40000 ALTER TABLE `reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminders_invitees`
--

DROP TABLE IF EXISTS `reminders_invitees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reminders_invitees` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reminder_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `related_invitee_module` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_invitee_module_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_reminder_invitee_name` (`name`),
  KEY `idx_reminder_invitee_assigned_user_id` (`assigned_user_id`),
  KEY `idx_reminder_invitee_reminder_id` (`reminder_id`),
  KEY `idx_reminder_invitee_related_invitee_module` (`related_invitee_module`),
  KEY `idx_reminder_invitee_related_invitee_module_id` (`related_invitee_module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminders_invitees`
--

LOCK TABLES `reminders_invitees` WRITE;
/*!40000 ALTER TABLE `reminders_invitees` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminders_invitees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `modules` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_role_id_del` (`id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_modules`
--

DROP TABLE IF EXISTS `roles_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_modules` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `role_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `module_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `allow` tinyint(1) DEFAULT '0',
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_module_id` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_modules`
--

LOCK TABLES `roles_modules` WRITE;
/*!40000 ALTER TABLE `roles_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_users` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `role_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ru_role_id` (`role_id`),
  KEY `idx_ru_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_search`
--

DROP TABLE IF EXISTS `saved_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saved_search` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `search_module` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contents` text COLLATE utf8mb4_general_ci,
  `description` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_desc` (`name`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_search`
--

LOCK TABLES `saved_search` WRITE;
/*!40000 ALTER TABLE `saved_search` DISABLE KEYS */;
/*!40000 ALTER TABLE `saved_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedulers`
--

DROP TABLE IF EXISTS `schedulers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedulers` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `job` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_time_start` datetime DEFAULT NULL,
  `date_time_end` datetime DEFAULT NULL,
  `job_interval` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `time_from` time DEFAULT NULL,
  `time_to` time DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `catch_up` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_schedule` (`date_time_start`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedulers`
--

LOCK TABLES `schedulers` WRITE;
/*!40000 ALTER TABLE `schedulers` DISABLE KEYS */;
INSERT INTO `schedulers` VALUES ('0178c621-40f2-4bf5-b8ef-73da064f42f0',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Perform Elasticsearch Index','function::runElasticSearchIndexerScheduler','2015-01-01 12:15:01',NULL,'30::4::*::*::*',NULL,NULL,NULL,'Active',0),('10f840f9-7cdb-40e2-b0ee-a8994d17dfc3',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Removal of documents from filesystem','function::removeDocumentsFromFS','2015-01-01 13:15:01',NULL,'0::3::1::*::*',NULL,NULL,NULL,'Active',0),('1b8100db-3cab-4023-b463-c1273d584fd9',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Run Nightly Mass Email Campaigns','function::runMassEmailCampaign','2015-01-01 14:45:01',NULL,'0::2-6::*::*::*',NULL,NULL,NULL,'Active',1),('29040c28-4895-4f74-a6ec-c0db879c3a19',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Prune Tracker Tables','function::trimTracker','2015-01-01 07:30:01',NULL,'0::2::1::*::*',NULL,NULL,NULL,'Active',1),('54fe69fe-eca9-469a-9e35-dff36fb02e8c',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Clean Jobs Queue','function::cleanJobQueue','2015-01-01 07:45:01',NULL,'0::5::*::*::*',NULL,NULL,NULL,'Active',0),('5e6e8cf5-e530-4ea8-91d1-aa0e08af0c5b',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Perform Lucene Index','function::aodIndexUnindexed','2015-01-01 11:15:01',NULL,'0::0::*::*::*',NULL,NULL,NULL,'Active',0),('6bd06924-61f6-431a-98f7-bb8c9560317f',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Run Nightly Process Bounced Campaign Emails','function::pollMonitoredInboxesForBouncedCampaignEmails','2015-01-01 09:15:01',NULL,'0::2-6::*::*::*',NULL,NULL,NULL,'Active',1),('738904ce-b70b-415c-93b2-fe1fe22c30cb',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Run Report Generation Scheduled Tasks','function::aorRunScheduledReports','2015-01-01 06:30:01',NULL,'*::*::*::*::*',NULL,NULL,NULL,'Active',1),('85e8faa5-a9b8-4de5-a152-34ec61714f55',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Calendar Accounts Sync','function::calendarSyncJob','2015-01-01 18:00:01',NULL,'*/15::*::*::*::*',NULL,NULL,NULL,'Active',0),('908b95ba-35c7-40b8-a08b-b632a12a5722',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Run Email Reminder Notifications','function::sendEmailReminders','2015-01-01 15:30:01',NULL,'*::*::*::*::*',NULL,NULL,NULL,'Active',0),('a0200580-12a2-47ad-9b90-bfd4af601016',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Process Workflow Tasks','function::processAOW_Workflow','2015-01-01 09:15:01',NULL,'*::*::*::*::*',NULL,NULL,NULL,'Active',1),('d7d589da-efb5-4474-bfff-bf293aa19e94',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Check Inbound Mailboxes','function::pollMonitoredInboxesAOP','2015-01-01 10:45:01',NULL,'*::*::*::*::*',NULL,NULL,NULL,'Active',0),('ebc3de7c-d32d-4efa-9798-4bf12ce39dc1',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Prune SuiteCRM Feed Tables','function::trimSugarFeeds','2015-01-01 18:15:01',NULL,'0::2::1::*::*',NULL,NULL,NULL,'Active',1),('ec4eea3e-d9f3-47ff-bf9e-741bdca6421e',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Optimise AOD Index','function::aodOptimiseIndex','2015-01-01 13:30:01',NULL,'0::*/3::*::*::*',NULL,NULL,NULL,'Active',0),('f7613a4d-83aa-498e-b9a6-30eddc9eff23',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Prune Database on 1st of Month','function::pruneDatabase','2015-01-01 07:15:01',NULL,'0::4::1::*::*',NULL,NULL,NULL,'Inactive',0);
/*!40000 ALTER TABLE `schedulers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroups`
--

DROP TABLE IF EXISTS `securitygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `securitygroups` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `noninheritable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroups`
--

LOCK TABLES `securitygroups` WRITE;
/*!40000 ALTER TABLE `securitygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroups_acl_roles`
--

DROP TABLE IF EXISTS `securitygroups_acl_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `securitygroups_acl_roles` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `securitygroup_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroups_acl_roles`
--

LOCK TABLES `securitygroups_acl_roles` WRITE;
/*!40000 ALTER TABLE `securitygroups_acl_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygroups_acl_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroups_audit`
--

DROP TABLE IF EXISTS `securitygroups_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `securitygroups_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_securitygroups_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroups_audit`
--

LOCK TABLES `securitygroups_audit` WRITE;
/*!40000 ALTER TABLE `securitygroups_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygroups_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroups_default`
--

DROP TABLE IF EXISTS `securitygroups_default`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `securitygroups_default` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `securitygroup_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `module` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroups_default`
--

LOCK TABLES `securitygroups_default` WRITE;
/*!40000 ALTER TABLE `securitygroups_default` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygroups_default` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroups_records`
--

DROP TABLE IF EXISTS `securitygroups_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `securitygroups_records` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `securitygroup_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `record_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `module` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_securitygroups_records_mod` (`module`,`deleted`,`record_id`,`securitygroup_id`),
  KEY `idx_securitygroups_records_del` (`deleted`,`record_id`,`module`,`securitygroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroups_records`
--

LOCK TABLES `securitygroups_records` WRITE;
/*!40000 ALTER TABLE `securitygroups_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygroups_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroups_users`
--

DROP TABLE IF EXISTS `securitygroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `securitygroups_users` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `securitygroup_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primary_group` tinyint(1) DEFAULT NULL,
  `noninheritable` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `securitygroups_users_idxa` (`securitygroup_id`),
  KEY `securitygroups_users_idxb` (`user_id`),
  KEY `securitygroups_users_idxc` (`user_id`,`deleted`,`securitygroup_id`,`id`),
  KEY `securitygroups_users_idxd` (`user_id`,`deleted`,`securitygroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroups_users`
--

LOCK TABLES `securitygroups_users` WRITE;
/*!40000 ALTER TABLE `securitygroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spots`
--

DROP TABLE IF EXISTS `spots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spots` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `config` longtext COLLATE utf8mb4_general_ci,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spots`
--

LOCK TABLES `spots` WRITE;
/*!40000 ALTER TABLE `spots` DISABLE KEYS */;
/*!40000 ALTER TABLE `spots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sugarfeed`
--

DROP TABLE IF EXISTS `sugarfeed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sugarfeed` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_module` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `related_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `link_type` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sgrfeed_date` (`date_entered`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sugarfeed`
--

LOCK TABLES `sugarfeed` WRITE;
/*!40000 ALTER TABLE `sugarfeed` DISABLE KEYS */;
/*!40000 ALTER TABLE `sugarfeed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveyquestionoptions`
--

DROP TABLE IF EXISTS `surveyquestionoptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveyquestionoptions` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `survey_question_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveyquestionoptions`
--

LOCK TABLES `surveyquestionoptions` WRITE;
/*!40000 ALTER TABLE `surveyquestionoptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveyquestionoptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveyquestionoptions_audit`
--

DROP TABLE IF EXISTS `surveyquestionoptions_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveyquestionoptions_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_surveyquestionoptions_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveyquestionoptions_audit`
--

LOCK TABLES `surveyquestionoptions_audit` WRITE;
/*!40000 ALTER TABLE `surveyquestionoptions_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveyquestionoptions_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveyquestionoptions_surveyquestionresponses`
--

DROP TABLE IF EXISTS `surveyquestionoptions_surveyquestionresponses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveyquestionoptions_surveyquestionresponses` (
  `id` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `surveyq72c7options_ida` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `surveyq10d4sponses_idb` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `surveyquestionoptions_surveyquestionresponses_alt` (`surveyq72c7options_ida`,`surveyq10d4sponses_idb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveyquestionoptions_surveyquestionresponses`
--

LOCK TABLES `surveyquestionoptions_surveyquestionresponses` WRITE;
/*!40000 ALTER TABLE `surveyquestionoptions_surveyquestionresponses` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveyquestionoptions_surveyquestionresponses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveyquestionresponses`
--

DROP TABLE IF EXISTS `surveyquestionresponses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveyquestionresponses` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `answer` text COLLATE utf8mb4_general_ci,
  `answer_bool` tinyint(1) DEFAULT NULL,
  `answer_datetime` datetime DEFAULT NULL,
  `surveyquestion_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `surveyresponse_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveyquestionresponses`
--

LOCK TABLES `surveyquestionresponses` WRITE;
/*!40000 ALTER TABLE `surveyquestionresponses` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveyquestionresponses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveyquestionresponses_audit`
--

DROP TABLE IF EXISTS `surveyquestionresponses_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveyquestionresponses_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_surveyquestionresponses_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveyquestionresponses_audit`
--

LOCK TABLES `surveyquestionresponses_audit` WRITE;
/*!40000 ALTER TABLE `surveyquestionresponses_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveyquestionresponses_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveyquestions`
--

DROP TABLE IF EXISTS `surveyquestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveyquestions` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `happiness_question` tinyint(1) DEFAULT NULL,
  `survey_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveyquestions`
--

LOCK TABLES `surveyquestions` WRITE;
/*!40000 ALTER TABLE `surveyquestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveyquestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveyquestions_audit`
--

DROP TABLE IF EXISTS `surveyquestions_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveyquestions_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_surveyquestions_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveyquestions_audit`
--

LOCK TABLES `surveyquestions_audit` WRITE;
/*!40000 ALTER TABLE `surveyquestions_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveyquestions_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveyresponses`
--

DROP TABLE IF EXISTS `surveyresponses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveyresponses` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `happiness` int DEFAULT NULL,
  `email_response_sent` tinyint(1) DEFAULT NULL,
  `account_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `campaign_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `survey_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveyresponses`
--

LOCK TABLES `surveyresponses` WRITE;
/*!40000 ALTER TABLE `surveyresponses` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveyresponses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveyresponses_audit`
--

DROP TABLE IF EXISTS `surveyresponses_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveyresponses_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_surveyresponses_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveyresponses_audit`
--

LOCK TABLES `surveyresponses_audit` WRITE;
/*!40000 ALTER TABLE `surveyresponses_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveyresponses_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveys`
--

DROP TABLE IF EXISTS `surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveys` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'LBL_DRAFT',
  `submit_text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'Submit',
  `satisfied_text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'Satisfied',
  `neither_text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'Neither Satisfied nor Dissatisfied',
  `dissatisfied_text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'Dissatisfied',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys`
--

LOCK TABLES `surveys` WRITE;
/*!40000 ALTER TABLE `surveys` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveys_audit`
--

DROP TABLE IF EXISTS `surveys_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveys_audit` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `created_by` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `after_value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `before_value_text` text COLLATE utf8mb4_general_ci,
  `after_value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_surveys_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys_audit`
--

LOCK TABLES `surveys_audit` WRITE;
/*!40000 ALTER TABLE `surveys_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveys_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Not Started',
  `date_due_flag` tinyint(1) DEFAULT '0',
  `date_due` datetime DEFAULT NULL,
  `date_start_flag` tinyint(1) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `parent_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `priority` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tsk_name` (`name`),
  KEY `idx_task_con_del` (`contact_id`,`deleted`),
  KEY `idx_task_par_del` (`parent_id`,`parent_type`,`deleted`),
  KEY `idx_task_assigned` (`assigned_user_id`),
  KEY `idx_task_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatesectionline`
--

DROP TABLE IF EXISTS `templatesectionline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templatesectionline` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `thumbnail` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `grp` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ord` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatesectionline`
--

LOCK TABLES `templatesectionline` WRITE;
/*!40000 ALTER TABLE `templatesectionline` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatesectionline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracker`
--

DROP TABLE IF EXISTS `tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracker` (
  `id` int NOT NULL AUTO_INCREMENT,
  `monitor_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `module_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `item_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `item_summary` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `session_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tracker_iid` (`item_id`),
  KEY `idx_tracker_userid_vis_id` (`user_id`,`visible`,`id`),
  KEY `idx_tracker_userid_itemid_vis` (`user_id`,`item_id`,`visible`),
  KEY `idx_tracker_monitor_id` (`monitor_id`),
  KEY `idx_tracker_date_modified` (`date_modified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracker`
--

LOCK TABLES `tracker` WRITE;
/*!40000 ALTER TABLE `tracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `tracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upgrade_history`
--

DROP TABLE IF EXISTS `upgrade_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upgrade_history` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `md5sum` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `version` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `id_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `manifest` longtext COLLATE utf8mb4_general_ci,
  `date_entered` datetime DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `upgrade_history_md5_uk` (`md5sum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upgrade_history`
--

LOCK TABLES `upgrade_history` WRITE;
/*!40000 ALTER TABLE `upgrade_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `upgrade_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_preferences` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contents` longtext COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_userprefnamecat` (`assigned_user_id`,`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_preferences`
--

LOCK TABLES `user_preferences` WRITE;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
INSERT INTO `user_preferences` VALUES ('68c1108f-07e1-41cd-a2f1-f33bc24a1021','global',0,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','YToxODp7czoyMDoiY2FsZW5kYXJfcHVibGlzaF9rZXkiO3M6MzY6ImJlM2VjNDM4LWE2N2UtNDZlMi1hOTBmLTY3ZDJmYzRjMDA0NCI7czoxMjoibWFpbG1lcmdlX29uIjtzOjM6Im9mZiI7czoxNjoic3dhcF9sYXN0X3ZpZXdlZCI7YjowO3M6MTQ6InN3YXBfc2hvcnRjdXRzIjtiOjA7czoxOToibmF2aWdhdGlvbl9wYXJhZGlnbSI7czoyOiJnbSI7czoyMDoic29ydF9tb2R1bGVzX2J5X25hbWUiO3M6MDoiIjtzOjEzOiJzdWJwYW5lbF90YWJzIjtiOjE7czoyNToiY291bnRfY29sbGFwc2VkX3N1YnBhbmVscyI7czowOiIiO3M6MTQ6Im1vZHVsZV9mYXZpY29uIjtiOjA7czo5OiJoaWRlX3RhYnMiO2E6MDp7fXM6MTE6InJlbW92ZV90YWJzIjthOjA6e31zOjc6Im5vX29wcHMiO3M6Mzoib2ZmIjtzOjg6InRpbWV6b25lIjtzOjEyOiJBc2lhL0tvbGthdGEiO3M6MjoidXQiO3M6MToiMSI7czoxNDoidXNlX3JlYWxfbmFtZXMiO2I6MTtzOjE3OiJtYWlsX3NtdHBhdXRoX3JlcSI7czowOiIiO3M6MTI6Im1haWxfc210cHNzbCI7aTowO3M6MTc6ImVtYWlsX3Nob3dfY291bnRzIjtpOjA7fQ==');
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `user_name` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_hash` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `system_generated_password` tinyint(1) DEFAULT NULL,
  `pwd_last_changed` datetime DEFAULT NULL,
  `authenticate_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sugar_login` tinyint(1) DEFAULT '1',
  `first_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT '0',
  `external_auth_only` tinyint(1) DEFAULT '0',
  `receive_notifications` tinyint(1) DEFAULT '1',
  `description` text COLLATE utf8mb4_general_ci,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `department` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_home` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_mobile` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_work` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_other` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_fax` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_street` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_country` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_postalcode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `portal_only` tinyint(1) DEFAULT '0',
  `show_on_employees` tinyint(1) DEFAULT '1',
  `employee_status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `messenger_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `messenger_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reports_to_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_group` tinyint(1) DEFAULT NULL,
  `factor_auth` tinyint(1) DEFAULT NULL,
  `factor_auth_interface` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_name` (`user_name`,`is_group`,`status`,`last_name`(30),`first_name`(30),`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('1','admin','$2y$10$JNYSWPAahOk2wH5Ec8toYu9yJqWSVeml91.NrrIjESMxr2b2c1mH.',0,NULL,NULL,1,NULL,'Administrator',1,0,1,NULL,'2026-05-12 09:18:36','2026-05-12 09:18:36','1','1','Administrator',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,NULL,NULL,NULL,NULL,0,0,1,'Active',NULL,NULL,NULL,0,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_feeds`
--

DROP TABLE IF EXISTS `users_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_feeds` (
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `feed_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rank` int DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  KEY `idx_ud_user_id` (`user_id`,`feed_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_feeds`
--

LOCK TABLES `users_feeds` WRITE;
/*!40000 ALTER TABLE `users_feeds` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_feeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_last_import`
--

DROP TABLE IF EXISTS `users_last_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_last_import` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `assigned_user_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `import_module` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bean_type` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bean_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_last_import`
--

LOCK TABLES `users_last_import` WRITE;
/*!40000 ALTER TABLE `users_last_import` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_last_import` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_password_link`
--

DROP TABLE IF EXISTS `users_password_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_password_link` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `keyhash` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `username` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_generated` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_password_link`
--

LOCK TABLES `users_password_link` WRITE;
/*!40000 ALTER TABLE `users_password_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_password_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_signatures`
--

DROP TABLE IF EXISTS `users_signatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_signatures` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `signature` text COLLATE utf8mb4_general_ci,
  `signature_html` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_usersig_uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_signatures`
--

LOCK TABLES `users_signatures` WRITE;
/*!40000 ALTER TABLE `users_signatures` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_signatures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vcals`
--

DROP TABLE IF EXISTS `vcals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vcals` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `user_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `idx_vcal` (`type`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vcals`
--

LOCK TABLES `vcals` WRITE;
/*!40000 ALTER TABLE `vcals` DISABLE KEYS */;
/*!40000 ALTER TABLE `vcals` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-12 14:53:05

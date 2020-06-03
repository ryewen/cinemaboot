CREATE DATABASE  IF NOT EXISTS `cinemaboot` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cinemaboot`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: cinemaboot
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_bin NOT NULL,
  `movie_id` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='场次信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
INSERT INTO `field` VALUES (1,'1号厅',1,'2020-05-31 09:30:00','2020-05-31 11:30:00',50.00),(2,'1号厅',2,'2020-05-31 12:30:00','2020-05-31 14:30:00',60.00),(3,'1号厅',3,'2020-05-31 15:30:00','2020-05-31 17:30:00',40.00),(4,'2号厅',1,'2020-06-03 10:20:00','2020-06-03 12:25:00',60.00),(5,'2号厅',2,'2020-06-01 08:30:00','2020-06-01 10:30:00',70.00),(6,'2号厅',3,'2020-06-01 13:30:00','2020-06-01 15:30:00',40.00),(7,'3号厅',3,'2021-06-06 19:30:00','2021-06-06 21:30:00',50.00);
/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `director` varchar(100) COLLATE utf8_bin NOT NULL,
  `actors` varchar(200) COLLATE utf8_bin NOT NULL,
  `detail` varchar(400) COLLATE utf8_bin NOT NULL,
  `img_url` varchar(800) COLLATE utf8_bin NOT NULL,
  `sales` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='电影信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (1,'唐人街探案','陈思诚','王宝强、刘昊然','该片讲述了两名华人在泰国陷入了刑案风暴，在短短三天内找到下落不明的黄金及查明杀人真凶，洗刷冤屈的故事。','http://p4.img.cctvpic.com/photoworkspace/contentimg/2020/01/20/2020012009025730598.png',1121),(2,'西游记之大圣归来','田晓鹏','张磊、张欣','本片改编自明朝小说家吴承恩的小说《西游记》，设定于孙悟空“大闹天宫”五百年之后，围绕着小和尚江流儿与孙悟空等人展开：江流儿因盲打误撞地解除封印，将压在五行山下的孙悟空救出，而此时孙悟空只想过平静的生活，只因封印所限才打算护送江流儿回城，最终在拯救被妖王绑架女孩的过程中，孙悟空解破封印，恢复“齐天大圣”之身。','https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1479694995,2525906423&fm=26&gp=0.jpg',101),(3,'战狼','吴京','吴京、余男','在一次与公安部联合捣毁制毒窝点的行动中，冷锋违反命令将国际犯罪组织的骨干武吉狙杀，导致被关禁闭，后得到战狼中队指挥官龙小云赏识，保释他并让他加入战狼中队参与军事演习。','https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=803768292,3750057323&fm=26&gp=0.jpg',218);
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_info`
--

DROP TABLE IF EXISTS `order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_info` (
  `id` varchar(200) COLLATE utf8_bin NOT NULL,
  `user_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `field_id` int NOT NULL,
  `seat_name` varchar(45) COLLATE utf8_bin NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(45) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='订单信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_info`
--

LOCK TABLES `order_info` WRITE;
/*!40000 ALTER TABLE `order_info` DISABLE KEYS */;
INSERT INTO `order_info` VALUES ('2020060316092104391',5,3,7,'1',50.00,'2020-06-03 08:09:21','confirmed'),('2020060316092813632',5,3,7,'2',50.00,'2020-06-03 08:09:28','confirmed'),('2020060316165391044',5,3,7,'3',50.00,'2020-06-03 08:16:54','confirmed'),('2020060316165822953',5,3,7,'4',50.00,'2020-06-03 08:16:59','confirmed'),('2020060316434141786',2,3,7,'7',50.00,'2020-06-03 08:43:41','confirmed'),('2020060316434695207',2,3,7,'5',50.00,'2020-06-03 08:43:46','confirmed'),('2020060316435582837',2,3,7,'6',50.00,'2020-06-03 08:43:56','confirmed'),('2020060316461096624',2,3,7,'8',50.00,'2020-06-03 08:46:10','confirmed'),('2020060316462580075',2,3,7,'9',50.00,'2020-06-03 08:46:25','confirmed'),('2020060316470672765',2,3,7,'10',50.00,'2020-06-03 08:47:07','confirmed'),('2020060317160549625',2,3,7,'11',50.00,'2020-06-03 09:16:06','confirmed'),('2020060317233236518',2,3,7,'11',50.00,'2020-06-03 09:23:33','confirmed'),('2020060317320234990',2,3,7,'14',50.00,'2020-06-03 09:32:03','confirmed'),('2020060317343070339',2,3,7,'11',50.00,'2020-06-03 09:34:30','confirmed'),('2020060317394660940',2,3,7,'12',50.00,'2020-06-03 09:39:46','confirmed'),('2020060317395551337',2,3,7,'13',50.00,'2020-06-03 09:39:55','confirmed'),('2020060317400418630',2,3,7,'15',50.00,'2020-06-03 09:40:04','confirmed');
/*!40000 ALTER TABLE `order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_log`
--

DROP TABLE IF EXISTS `sales_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(200) COLLATE utf8_bin NOT NULL,
  `movie_id` int NOT NULL,
  `sale` int NOT NULL,
  `status` varchar(45) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='销量流水表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_log`
--

LOCK TABLES `sales_log` WRITE;
/*!40000 ALTER TABLE `sales_log` DISABLE KEYS */;
INSERT INTO `sales_log` VALUES (1,'2020060316092104391',3,1,'confirmed'),(2,'2020060316092813632',3,1,'confirmed'),(3,'2020060316165391044',3,1,'confirmed'),(4,'2020060316165822953',3,1,'confirmed'),(5,'2020060316434141786',3,1,'confirmed'),(6,'2020060316434695207',3,1,'confirmed'),(7,'2020060316435582837',3,1,'confirmed'),(8,'2020060316461096624',3,1,'confirmed'),(9,'2020060316462580075',3,1,'confirmed'),(10,'2020060316470672765',3,1,'confirmed'),(11,'2020060317160549625',3,1,'confirmed'),(12,'2020060317233236518',3,1,'confirmed'),(13,'2020060317320234990',3,1,'confirmed'),(14,'2020060317343070339',3,1,'confirmed'),(15,'2020060317394660940',3,1,'confirmed'),(16,'2020060317395551337',3,1,'confirmed'),(17,'2020060317400418630',3,1,'confirmed');
/*!40000 ALTER TABLE `sales_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `field_id` int NOT NULL,
  `name` varchar(45) COLLATE utf8_bin NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='座位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
INSERT INTO `seat` VALUES (1,1,'1',0),(2,1,'2',0),(3,1,'3',0),(4,1,'4',0),(5,1,'5',0),(6,1,'6',0),(7,1,'7',0),(8,1,'8',0),(9,1,'9',0),(10,1,'10',0),(11,2,'1',0),(12,2,'2',0),(13,2,'3',0),(14,2,'4',0),(15,2,'5',0),(16,2,'6',0),(17,2,'7',0),(18,2,'8',0),(19,2,'9',0),(20,2,'10',0),(21,3,'1',0),(22,3,'2',0),(23,3,'3',0),(24,3,'4',0),(25,3,'5',0),(26,3,'6',0),(27,3,'7',0),(28,3,'8',0),(29,3,'9',0),(30,3,'10',0),(31,4,'1',1),(32,4,'2',0),(33,4,'3',1),(34,4,'4',1),(35,4,'5',1),(36,4,'6',1),(37,4,'7',1),(38,4,'8',1),(39,4,'9',1),(40,4,'10',1),(41,5,'1',0),(42,5,'2',0),(43,5,'3',0),(44,5,'4',0),(45,5,'5',0),(46,5,'6',0),(47,5,'7',0),(48,5,'8',0),(49,5,'9',0),(50,5,'10',0),(51,6,'1',0),(52,6,'2',0),(53,6,'3',0),(54,6,'4',0),(55,6,'5',0),(56,6,'6',0),(57,6,'7',0),(58,6,'8',0),(59,6,'9',0),(60,6,'10',0),(62,7,'1',1),(63,7,'2',1),(64,7,'3',1),(65,7,'4',1),(66,7,'5',1),(67,7,'6',1),(68,7,'7',1),(69,7,'8',1),(70,7,'9',1),(71,7,'10',1),(72,7,'11',1),(73,7,'12',1),(74,7,'13',1),(75,7,'14',1),(76,7,'15',1),(77,7,'16',0),(78,7,'17',0),(79,7,'18',0),(80,7,'19',0),(81,7,'20',0);
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat_log`
--

DROP TABLE IF EXISTS `seat_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(200) COLLATE utf8_bin NOT NULL,
  `field_id` int NOT NULL,
  `seat_name` varchar(45) COLLATE utf8_bin NOT NULL,
  `status` varchar(45) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='座位流水表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_log`
--

LOCK TABLES `seat_log` WRITE;
/*!40000 ALTER TABLE `seat_log` DISABLE KEYS */;
INSERT INTO `seat_log` VALUES (1,'2020060316092104391',7,'1','confirmed'),(2,'2020060316092813632',7,'2','confirmed'),(3,'2020060316165391044',7,'3','confirmed'),(4,'2020060316165822953',7,'4','confirmed'),(5,'2020060316434141786',7,'7','confirmed'),(6,'2020060316434695207',7,'5','confirmed'),(7,'2020060316435582837',7,'6','confirmed'),(8,'2020060316461096624',7,'8','confirmed'),(9,'2020060316462580075',7,'9','confirmed'),(10,'2020060316470672765',7,'10','confirmed'),(11,'2020060317160549625',7,'11','confirmed'),(12,'2020060317233236518',7,'11','confirmed'),(13,'2020060317320234990',7,'14','confirmed'),(14,'2020060317343070339',7,'11','confirmed'),(15,'2020060317394660940',7,'12','confirmed'),(16,'2020060317395551337',7,'13','confirmed'),(17,'2020060317400418630',7,'15','confirmed');
/*!40000 ALTER TABLE `seat_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tcc_transaction_test_a`
--

DROP TABLE IF EXISTS `tcc_transaction_test_a`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tcc_transaction_test_a` (
  `TRANSACTION_ID` int NOT NULL AUTO_INCREMENT,
  `DOMAIN` varchar(100) DEFAULT NULL,
  `GLOBAL_TX_ID` varbinary(32) NOT NULL,
  `BRANCH_QUALIFIER` varbinary(32) NOT NULL,
  `CONTENT` varbinary(8000) DEFAULT NULL,
  `STATUS` int DEFAULT NULL,
  `TRANSACTION_TYPE` int DEFAULT NULL,
  `RETRIED_COUNT` int DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `LAST_UPDATE_TIME` datetime DEFAULT NULL,
  `VERSION` int DEFAULT NULL,
  `IS_DELETE` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`TRANSACTION_ID`),
  UNIQUE KEY `UX_TX_BQ` (`GLOBAL_TX_ID`,`BRANCH_QUALIFIER`)
) ENGINE=InnoDB AUTO_INCREMENT=4764 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tcc_transaction_test_a`
--

LOCK TABLES `tcc_transaction_test_a` WRITE;
/*!40000 ALTER TABLE `tcc_transaction_test_a` DISABLE KEYS */;
/*!40000 ALTER TABLE `tcc_transaction_test_a` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tcc_transaction_test_consumer`
--

DROP TABLE IF EXISTS `tcc_transaction_test_consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tcc_transaction_test_consumer` (
  `TRANSACTION_ID` int NOT NULL AUTO_INCREMENT,
  `DOMAIN` varchar(100) DEFAULT NULL,
  `GLOBAL_TX_ID` varbinary(32) NOT NULL,
  `BRANCH_QUALIFIER` varbinary(32) NOT NULL,
  `CONTENT` varbinary(8000) DEFAULT NULL,
  `STATUS` int DEFAULT NULL,
  `TRANSACTION_TYPE` int DEFAULT NULL,
  `RETRIED_COUNT` int DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `LAST_UPDATE_TIME` datetime DEFAULT NULL,
  `VERSION` int DEFAULT NULL,
  `IS_DELETE` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`TRANSACTION_ID`),
  UNIQUE KEY `UX_TX_BQ` (`GLOBAL_TX_ID`,`BRANCH_QUALIFIER`)
) ENGINE=InnoDB AUTO_INCREMENT=1230 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tcc_transaction_test_consumer`
--

LOCK TABLES `tcc_transaction_test_consumer` WRITE;
/*!40000 ALTER TABLE `tcc_transaction_test_consumer` DISABLE KEYS */;
/*!40000 ALTER TABLE `tcc_transaction_test_consumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE utf8_bin NOT NULL,
  `password` varchar(200) COLLATE utf8_bin NOT NULL,
  `telephone` varchar(100) COLLATE utf8_bin NOT NULL,
  `wallet` decimal(10,2) NOT NULL DEFAULT '1000.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index2` (`username`,`telephone`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','4QrcOUm6Wau+VuBX8g+IPg==','18580558663',40.00),(2,'www','4QrcOUm6Wau+VuBX8g+IPg==','12311111111',9938090.00),(3,'ddd','4QrcOUm6Wau+VuBX8g+IPg==','13997863436',3000.00),(4,'飞翔的企鹅','bETlzRfwAZxksELkp0VBKg==','13215976358',4000.00),(5,'hello','4QrcOUm6Wau+VuBX8g+IPg==','14512354651',800.00);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_log`
--

DROP TABLE IF EXISTS `wallet_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(200) COLLATE utf8_bin NOT NULL,
  `user_id` int NOT NULL,
  `wallet` decimal(10,2) NOT NULL,
  `status` varchar(45) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='钱包流水信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_log`
--

LOCK TABLES `wallet_log` WRITE;
/*!40000 ALTER TABLE `wallet_log` DISABLE KEYS */;
INSERT INTO `wallet_log` VALUES (1,'2020060316092104391',5,50.00,'confirmed'),(2,'2020060316092813632',5,50.00,'confirmed'),(3,'2020060316165391044',5,50.00,'confirmed'),(4,'2020060316165822953',5,50.00,'confirmed'),(5,'2020060316434141786',2,50.00,'confirmed'),(6,'2020060316434695207',2,50.00,'confirmed'),(7,'2020060316435582837',2,50.00,'confirmed'),(8,'2020060316461096624',2,50.00,'confirmed'),(9,'2020060316462580075',2,50.00,'confirmed'),(10,'2020060316470672765',2,50.00,'confirmed'),(11,'2020060317160549625',2,50.00,'confirmed'),(12,'2020060317233236518',2,50.00,'confirmed'),(13,'2020060317320234990',2,50.00,'confirmed'),(14,'2020060317343070339',2,50.00,'confirmed'),(15,'2020060317394660940',2,50.00,'confirmed'),(16,'2020060317395551337',2,50.00,'confirmed'),(17,'2020060317400418630',2,50.00,'confirmed');
/*!40000 ALTER TABLE `wallet_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-03 17:46:18

-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: nabedjoc_mdbank
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,NULL,1,'Category 1','category-1','2020-03-17 03:23:46','2020-03-17 03:23:46'),(2,NULL,1,'Category 2','category-2','2020-03-17 03:23:46','2020-03-17 03:23:46');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `father_name_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nationality` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `national_id_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UNHCR_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `relative_name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relative_name_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relative_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `card_issue_date` date DEFAULT NULL,
  `card_expiration_date` date DEFAULT NULL,
  `card_status` tinyint(4) DEFAULT NULL,
  `card_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pharmacy_id` bigint(20) DEFAULT NULL,
  `gender` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (3,'Nasser','Yousef','Alhassan','┘å╪º╪╡╪▒','┘è┘ê╪│┘ü','╪º┘ä╪¡╪│┘å','Soileh','╪╡┘ê┘è┘ä╪¡','Jordanian','1969-10-13','29766188c871',NULL,'077965287',NULL,NULL,NULL,NULL,NULL,'2020-04-24 19:42:00','2020-05-10 02:40:45','2020J817',NULL,NULL,1,'Active',2,NULL),(130,'Maher','Ibrahim','Al jandali','┘à╪º┘ç╪▒','╪º╪¿╪▒╪º┘ç┘è┘à','╪º┘ä╪¼┘å╪»┘ä┘è','sweileh','╪╡┘ê┘è┘ä╪¡','syrian','1963-01-01','738',NULL,'779670584',NULL,NULL,NULL,NULL,NULL,'2020-05-10 22:15:00','2020-05-15 01:24:50','0pnp9a','2019-12-05','2020-12-31',1,'Active',3,0),(131,'Maha','Faris','AL shridi','┘à┘ç╪º','┘ü╪º╪▒╪│','╪º┘ä╪┤╪▒┘è╪»┘è','abu nusaier-sahara mall','╪ú╪¿┘ê ┘å╪╡┘è╪▒- ╪╡╪¡╪º╪▒┘ë ┘à┘ê┘ä','syrian','1968-01-01','','','796259437','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','cxkn3g','2019-12-05','2020-01-31',1,'Active',3,1),(132,'Ilham ','Mahmoud','Al-one','╪º┘ä┘ç╪º┘à','┘à╪¡┘à┘ê╪»','╪º┘ä┘ê┘å','Aljubayha-north Amman police','╪º┘ä╪¼╪¿┘è┘ç╪⌐ /╪┤╪▒╪╖╪⌐ ╪┤┘à╪º┘ä ╪╣┘à╪º┘å','syrian','1964-01-01','','','0785151678','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','onn5re','2019-12-05','2020-12-31',1,'active',3,1),(133,'Mowafaq ','Shamma','Shan','┘à┘ê┘ü┘é','╪┤┘à╪º ','╪┤╪º┘å','Aljubayha-north Amman police','╪º┘ä╪¼╪¿┘è┘ç╪⌐ /╪┤╪▒╪╖╪⌐ ╪┤┘à╪º┘ä ╪╣┘à╪º┘å','Syrian','1953-01-01','','','0785151678','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','kosw9e','2019-12-05','2020-12-31',1,'active',3,0),(134,'Anaam','Shamma','Al-one','╪º┘å╪╣╪º┘à','╪┤┘à╪º','╪º┘ä┘ê┘å','Sweileh-eastern suberb','╪╡┘ê┘è┘ä╪¡ - ╪º┘ä╪¡┘è ╪º┘ä╪┤╪▒┘é┘è','Syrian','1957-01-01','0000',NULL,'0786440383',NULL,NULL,NULL,NULL,NULL,'2020-05-10 22:15:00','2020-05-12 05:53:45','nfxmoy','2019-12-05','2020-12-31',0,'active',3,1),(135,'aziza','enad','khalifa','╪╣╪▓┘è╪▓╪⌐','╪╣┘å╪º╪»','╪«┘ä┘è┘ü╪⌐','sweileh,the enstern district','╪╡┘ê┘è┘ä╪¡ ╪º┘ä╪¡┘è ╪º┘ä╪┤╪▒┘é┘è','syrian','1972-12-25','1002930748','199-00290324','009627979456','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','vf7w8d','2019-12-08','2019-12-30',1,'',3,1),(136,'ghada','mohammed','abd-elaal','╪║╪º╪»╪⌐','┘à╪¡┘à╪»','╪╣╪¿╪» ╪º┘ä╪╣╪º┘ä','sweileh- near al hanayen restaurant','╪╡┘ê┘è┘ä╪¡ -╪¿╪º┘ä┘é╪▒╪¿ ┘à┘å ┘à╪╖╪╣┘à ╪º┘ä╪¡┘å╪º┘è┘å ','syrian','1956-01-01','','','009627887230','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','9h6fwg','2019-12-08','2019-12-31',1,'',3,1),(137,'najat','ahmad','al-qusari','┘å╪¼╪º╪⌐','╪º╪¡┘à╪»','╪º┘ä┘é╪╡┘è╪▒┘è','sweileh-the eastern district','╪╡┘ê┘è┘ä╪¡ ╪º┘ä╪¡┘è ╪º┘ä╪┤╪▒┘é┘è ','syrian','2019-12-01','','','0798617653','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','g5o2z4','2019-12-08','2019-12-31',1,'',3,1),(138,'hala','fahd','nasser','┘ç╪º┘ä╪⌐','┘ü┘ç╪»','┘å╪º╪╡╪▒','sweileh-near mosque abd rahman bin auf','╪╡┘ê┘è┘ä╪¡ ╪¿╪º┘ä┘é╪▒╪¿ ┘à┘å ┘à╪│╪¼╪» ╪╣╪¿╪» ╪º┘ä╪▒╪¡┘à┘å ╪¿┘å ╪╣┘ê┘ü','syrian','1956-11-28','8001491902','199-13C05525','0786894688','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','vk70q7','2019-12-08','2019-12-31',1,'',3,1),(139,'ahmad','mahamoud','al mugharbel','╪º╪¡┘à╪» ','┘à╪¡┘à┘ê╪»','╪º┘ä┘à╪║╪▒╪¿┘ä','sweileh near mosque abd alrahman bin auf','╪╡┘ê┘è┘ä╪¡ ╪¿╪º┘ä┘é╪▒╪¿ ┘à┘å ┘à╪│╪¼╪» ╪╣╪¿╪» ╪º┘ä╪▒╪¡┘à┘å ╪¿┘å ╪╣┘ê┘ü','syrian','1989-03-03','','199-13C05525','','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','7jfd4d','2019-12-08','2019-12-31',1,'',3,0),(140,'Ayoub','Soliman','Abo shnen','╪º┘è┘ê╪¿','╪│┘ä┘è┘à╪º┘å','╪º╪¿┘ê ╪┤┘å┘è┘å','Swelih','╪╡┘ê┘è┘ä╪¡','jordanian','2016-06-07','','','795671125','Yaaqoub','┘è╪╣┘é┘ê╪¿','795114809',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','t2vpwd','2019-04-07','2021-09-16',1,'Active',3,0),(141,'Amal','Abd allateef','Albadwe',' ╪º┘à┘ä ','╪╣╪¿╪» ╪º┘ä┘ä╪╖┘è┘ü ','╪º┘ä╪¿╪»┘ê┘è','Swelih / alhae alsharqi','╪╡┘ê┘è┘ä╪¡ /╪º┘ä╪¡┘è ╪º┘ä╪┤╪▒┘é┘è','syrian','2019-12-03','781585588','19c1343','781585588','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','pffd8k','2019-11-04','2019-12-11',1,'',3,1),(142,'Essam','Mohammad ','Salhane','╪╣╪╡╪º┘à','┘à╪¡┘à╪» ','╪╡╪º┘ä╪¡╪º┘å┘è','Ain-Albasha','╪╣┘è┘å ╪º┘ä╪¿╪º╪┤╪º','Syrian','1968-01-01','','','798974538','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','vy35vq','2017-06-04','2020-01-17',1,'',3,0),(143,'Amal','','Alashqar','╪ú┘à┘ä','╪º','╪º┘ä╪ú╪┤┘é╪▒','Swileh','╪╡┘ê┘è┘ä╪¡','Syrian','1960-01-03','','','788520625','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','wmwoxn','2015-01-06','2020-01-17',1,'',3,1),(144,'Fayez','Basher','Alboshe','┘ü╪º┘è╪▓','╪¿╪┤┘è╪▒','╪º┘ä╪¿┘ê╪┤┘è','Swelih alhai al sharqi','╪╡┘ê┘è┘ä╪¡ ╪º┘ä╪¡┘è ╪º┘ä╪┤╪▒┘é┘è','1','1958-01-01','','','787938806','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','yl6tfy','2016-01-06','2020-01-01',1,'',3,0),(145,'Samer','Ahmad','Alyousef','╪│┘à┘è╪▒','╪º╪¡┘à╪»','╪º┘ä┘è┘ê╪│┘ü','Aen Albash','╪╣┘è┘å ╪º┘ä╪¿╪º╪┤╪º','Syrian','1952-01-01','','','789688627','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','ew0xap','2014-01-01','2020-01-01',1,'',3,0),(146,'Hana','Mostafa','Alameer','┘ç┘å╪º','┘à╪╡╪╖┘ü┘ë','╪º┘ä╪ú┘à┘è╪▒','swelih  al hai al sharqi','╪╡┘ê┘è┘ä╪¡ ╪º┘ä╪¡┘è ╪º┘ä╪┤╪▒┘é┘è','Syrian','1967-01-01','','','788399671','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','o5pouw','2017-01-01','2020-01-01',1,'',3,1),(147,'Saleh','','Fayad','╪╡╪º┘ä╪¡','╪º','┘ü┘è╪º╪╢','Swelih / alsena3eh','╪╡┘ê┘è┘ä╪¡ / ╪º┘ä╪╡┘å╪º╪╣┘è╪⌐','syrian','1962-01-01','','','788807405','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','qjuucq','2017-01-01','2020-01-01',1,'',3,0),(148,'Amani','╪º','Fayad','╪º┘à╪º┘å┘è','╪º','┘ü┘è╪º╪╢','Swelih / alsena3eh','╪╡┘ê┘è┘ä╪¡ / ╪º┘ä╪╡┘å╪º╪╣┘è╪⌐','Syrian','1989-01-01','','','788807405','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','bksyza','2011-01-01','2020-01-01',1,'',3,1),(149,'Ma3ale','','Fayad','┘à╪╣╪º┘ä┘è','┘ê','┘ü┘è╪º╪╢','Swelih / alsena3eh','╪╡┘ê┘è┘ä╪¡ / ╪º┘ä╪╡┘å╪º╪╣┘è╪⌐','Syrian','1997-01-01','','','788807405','','╪º┘à╪º┘å┘è ┘ü┘è╪º╪╢','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','02900i','1999-01-01','2020-01-01',1,'',3,1),(150,'Layale ','','Fayad','┘ä┘è╪º┘ä┘è','╪º','┘ü┘è╪º╪╢','Swelih / alsena3eh','╪╡┘ê┘è┘ä╪¡ / ╪º┘ä╪╡┘å╪º╪╣┘è╪⌐','Syrian','2000-01-01','','','788807405','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','z8ci90','2002-01-01','2020-01-01',1,'',3,1),(151,'Fatem','Khalaf','Alsofe','┘ü╪º╪╖┘à  ','╪«┘ä┘ü','╪º┘ä╪╡┘ê┘ü┘è','Swelih / alsena3eh','╪╡┘ê┘è┘ä╪¡ /╪»┘ê╪º╪▒ ╪º┘ä╪╡┘å╪º╪╣╪⌐ ','syrian','1956-01-01','','','791621030','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','2nlli7','1990-01-01','2020-01-01',1,'',3,0),(152,'Hasan','Dakhel','Klah','╪¡╪│┘å ','╪»╪«┘è┘ä ','┘â┘ä╪º╪¡','Swelih / alyarmok school','╪╡┘ê┘è┘ä╪¡/ ┘à╪»╪▒╪│╪⌐ ╪º┘ä┘è╪▒┘à┘ê┘â','syrian','2020-01-13','','','798135885','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','sq0xat','1970-01-01','2020-01-01',1,'',3,0),(153,'Rajaa','Soliman','Alkhalaf','╪▒╪º╪¼╪╣╪⌐ ','╪│┘ä┘è┘à╪º┘å','╪º┘ä╪«┘ä┘ü','Swelih / near sameh mall','╪╡┘ê┘è┘ä╪¡ /╪╖┘ä┘ê╪╣ ╪│╪º┘à╪¡ ┘à┘ê┘ä ','syrian','1965-01-01','','','791522175','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','1j6mim','1980-01-01','2020-01-01',1,'',3,1),(154,'Aoosh','Hoseen','Alsheekh','╪╣┘ê╪┤','╪¡╪│┘è┘å ','╪º┘ä╪┤┘è╪«','Swelih / alhae alsharqi','╪╡┘ê┘è┘ä╪¡ /╪º┘ä╪¡┘è ╪º┘ä╪┤╪▒┘é┘è','syrian','1944-01-01','','','785273922','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','f82thz','1980-01-01','2020-01-01',1,'',3,1),(155,'Khansa','Mokhlef','Albere','╪«┘å╪│╪º','┘à╪«┘ä┘ü','╪º┘ä╪¿╪▒┘è','Khalda / albank alarabe','╪«┘ä╪»╪º /╪º╪┤╪º╪▒╪⌐ ╪º┘ä╪¿┘å┘â ╪º┘ä╪╣╪▒╪¿┘è ','syrian','1959-01-01','','','795996197','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','pxsgye','1990-01-01','2020-01-01',1,'',3,1),(156,'Ahmad','Mokhlef','Albere','╪º╪¡┘à╪» ','┘à╪«┘ä┘ü','╪º┘ä╪¿╪▒┘è','Khalda / albank alarabe','╪«┘ä╪»╪º /╪º╪┤╪º╪▒╪⌐ ╪º┘ä╪¿┘å┘â ╪º┘ä╪╣╪▒╪¿┘è ','syrian','1954-01-01','','','795996197','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','sx0aqa','2000-01-01','2020-01-01',1,'',3,0),(157,'Khaled','Gamel','Aldorah','╪«╪º┘ä╪»','╪¼┘à┘è┘ä','╪º┘ä╪»╪▒╪⌐','Swelih / alayman bakary','╪╡┘ê┘è┘ä╪¡  ┘à╪«╪º╪¿╪▓ ╪º┘ä╪º┘è┘à╪º┘å ','jordanian','1944-01-01','','','795410251','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','0r2lki','1970-01-01','2020-01-01',1,'',3,0),(158,'Yaaqoub','Soliman','Abo shnen','┘è╪╣┘é┘ê╪¿','╪│┘ä┘è┘à╪º┘å','╪ú╪¿┘ê ╪┤┘å┘è┘å','Swelih','╪╡┘ê┘è┘ä╪¡ ','jordanian','1973-01-01','','','795114809','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','n0h4a2','1990-01-01','2020-01-01',1,'',3,0),(159,'Fadia','Mohammad','Lotfe','┘ü╪º╪»┘è╪⌐   ','┘à╪¡┘à╪»','┘ä╪╖┘ü┘è','Swelih / alhodhod moscue','╪╡┘ê┘è┘ä╪¡ /╪¼╪º┘à╪╣ ╪º┘ä┘ç╪»┘ç╪»','syrian','1962-01-01','','','799596048','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','8scsep','1980-01-01','2020-01-01',1,'',3,1),(160,'Somiah','┘à','Abbar','╪│┘à┘è╪⌐','┘à','╪╣╪¿╪º╪▒','Swelih / hai alfadela','╪╡┘ê┘è┘ä╪¡ /╪¡┘è ╪º┘ä┘ü╪╢┘è┘ä╪⌐ ','syrian','1977-01-01','','','779004127','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','nuztaw','1990-01-01','2020-01-01',1,'',3,1),(161,'Mohammad','Mahmmod','Abbar','┘à╪¡┘à╪» ','┘à╪¡┘à┘ê╪»','╪╣╪¿╪º╪▒','Swelih / hai alfadela','╪╡┘ê┘è┘ä╪¡ /╪¡┘è ╪º┘ä┘ü╪╢┘è┘ä╪⌐ ','syrian','1947-01-01','','','779004127','Somiah ','╪│┘à┘è╪⌐ ╪╣╪¿╪º╪▒','779004127',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','5s9isg','1980-01-01','2020-01-01',1,'',3,0),(162,'Noor alhuda','','Alsharbaje','┘å┘ê╪▒ ╪º┘ä┘ç╪»┘ë','┘ê','╪º┘ä╪┤╪▒╪¿╪¼┘è','Swelih / hai alfadela','╪╡┘ê┘è┘ä╪¡ /╪¡┘è ╪º┘ä┘ü╪╢┘è┘ä╪⌐ ','syrian','1949-01-01','','','779004127','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','1187p5','2000-01-01','2020-01-01',1,'',3,1),(163,'Fatem','Mohammad','Ibrahim','┘ü╪º╪╖┘à ','┘à╪¡┘à╪»','╪Ñ╪¿╪▒╪º┘ç┘è┘à','Wadi alsair','┘ê╪º╪»┘è ╪º┘ä╪│┘è╪▒ ','syrian','1959-01-01','','','795440651','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','l5tph3','2000-01-01','2020-01-01',1,'',3,1),(164,'Maryam','Ahmad','Ayoub','┘à╪▒┘è┘à ','╪º╪¡┘à╪»','╪ú┘è┘ê╪¿','Swelih','╪╡┘ê┘è┘ä╪¡','syrian','1969-01-01','','','788198876','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','mmx9af','2013-01-01','2020-01-01',1,'',3,1),(165,'Fatoom','Hamad','Almasto','┘ü╪╖┘ê┘à ','╪¡┘à╪»','╪º┘ä┘à╪╡╪╖┘ê','Swelih / alhae alsharqi','╪╡┘ê┘è┘ä╪¡ ╪º┘ä╪¡┘è ╪º┘ä╪┤╪▒┘é┘è','syrian','1967-01-01','','','792949860','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','i5c0ix','2012-01-01','2020-01-01',1,'',3,1),(166,'Khadeja','╪⌐','Mostafa','╪«╪»┘è╪¼╪⌐','╪⌐','┘à╪╡╪╖┘ü┘ë','Swelih / alhae alsharqi','╪╡┘ê┘è┘ä╪¡ /╪¼╪º┘à╪╣ ╪╣╪¿╪» ╪º┘ä╪▒╪¡┘à┘å ','syrian','1959-01-01','','','786728442','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','v4ymi6','2010-01-01','2000-01-01',1,'',3,1),(167,'Alaa','Alsaadi','Alsaadi','╪º┘ä╪º╪í ','╪º┘ä╪│╪╣╪»┘è','╪º┘ä╪│╪╣╪»┘è','Safoot','╪╡╪º┘ü┘ê╪╖','syrian','1993-01-01','','','790270635','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','1gxfok','2000-01-01','2020-01-01',1,'',3,1),(168,'Mohammad','Maamoon','alnajjar','┘à╪¡┘à╪» ','┘à╪ú┘à┘ê┘å','┘à╪ú┘à┘ê┘å	╪º┘ä┘å╪¼╪º╪▒','Swelih / najeb pharmacy','╪╡┘ê┘è┘ä╪¡ /╪╡┘è╪»┘ä┘è╪⌐ ┘å╪¼┘è╪¿','syrian','1939-01-01','','','796875042','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','ue0dee','1980-01-01','2020-02-01',1,'',3,0),(169,'Ayman','Abbar','Abbar','╪º┘è┘à╪º┘å ','╪╣╪¿╪º╪▒','╪╣╪¿╪º╪▒','Swelih / alsena3eh','','╪╡┘ê┘è┘ä╪¡ /╪º┘ä╪╡┘å╪º','1974-01-01','','','776848397','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','co5c7l','2012-01-01','2020-01-01',1,'',3,1),(170,'Fatma','ibrahem','Alsabsabe','┘ü╪º╪╖┘à╪⌐ ','╪Ñ╪¿╪▒╪º┘ç┘è┘à','╪º┘ä╪│╪¿╪│╪¿┘è','Swelih / alhae alsharqi','╪╡┘ê┘è┘ä╪¡/ ╪º┘ä╪¡┘è ┘ä╪┤╪▒┘é┘è ','syrian','1967-01-01','','','776726930','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','gmamkc','2012-01-01','2020-01-01',1,'',3,1),(171,'Royada','Fawze','Yaseen','╪▒┘ê┘è╪»╪⌐ ','┘ü┘ê╪▓┘è','┘è╪º╪│┘è┘å','Albayader','╪º┘ä╪¿┘è╪º╪»╪▒','jordanian','1961-01-02','9612023595','','785813767','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','mjsdi7','2012-01-01','2020-01-09',1,'',3,1),(172,'Saada','Makhool','Aljaseem','╪│╪╣╪»╪⌐','┘à┘â╪¡┘ê┘ä','╪º┘ä╪¼╪º╪│┘à','Swelih','╪╡┘ê┘è┘ä╪¡','syrian','1961-01-01','','','795926855','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','qx0vgu','2000-01-01','2020-01-01',1,'',3,1),(173,'Jalilah','Hamoah','Hamoah','╪¼┘ä┘è┘ä╪⌐','╪¡┘à┘ê╪»┘ç','╪¡┘à┘ê╪»┘ç','Swelih','╪╡┘ê┘è┘ä╪¡','jordanian','1960-01-01','','','798719404','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','mov75a','2000-01-01','2020-01-01',1,'',3,1),(174,'Ali','Ahmad','Ali','╪╣┘ä┘è','╪º╪¡┘à╪»','╪╣┘ä┘è','Aen Albash','╪╣┘è┘å ╪º┘ä╪¿╪º╪┤╪º','Aen Albash	╪╣','1964-01-01','VKE36797','','785046012','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','hj6t57','2002-01-01','2020-01-01',1,'',3,0),(175,'Zahraa','Omar','Alibrahem','╪▓┘ç╪▒╪⌐','╪╣┘à╪▒','╪º┘ä╪º╪¿╪▒╪º┘ç┘è┘à','Swelih','╪╡┘ê┘è┘ä╪¡','Syrian','1967-01-01','','63114c18806','796152241','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','mm4fby','2010-01-01','2020-01-01',1,'',3,1),(176,'Zakaa','Mohammad','Homse','╪░┘â╪º╪í ','┘à╪¡┘à╪»','╪¡┘à╪╡┘è','Swelih','╪╡┘ê┘è┘ä╪¡','syrian','1967-01-01','','8411402933','796357035','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','41p904','2011-01-01','2020-01-01',1,'',3,1),(177,'Mohammad','Hoseen','Aldolemi','┘à╪¡┘à╪»','╪¡╪│┘è┘å ','╪º┘ä╪»┘ä┘è┘à┘è','Swelih','╪╡┘ê┘è┘ä╪¡','Iraqi','1965-01-01','','','781449356','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','gbjzh2','1991-01-01','2020-01-01',1,'',3,0),(178,'Sajeda','Ali','Abohana','╪│╪º╪¼╪»╪⌐ ','╪╣┘ä┘è ╪¡╪│┘è┘å','╪º╪¿┘ê┘ç┘å┘è┘ç','Om aldnaner','╪º┘à ╪º┘ä╪»┘å╪º┘å┘è╪▒','jordanian','1991-01-01','9912016368','','795130365','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','i8iy1k','2000-01-01','2020-01-01',1,'',3,1),(179,'Omar','Ahmad','Abo rabee','╪╣┘à╪▒ ','╪º╪¡┘à╪»','╪º╪¿┘ê ╪▒╪¿┘è╪╣ ','Aen Albash','╪╣┘è┘å ╪º┘ä╪¿╪º╪┤╪º','jordanian','1974-01-01','9741020579','','785548694','','','',NULL,'','2020-05-10 22:15:35','2020-05-10 22:15:35','2fzd1p','2010-01-01','2020-01-01',1,'',3,0),(193,'TEST 1','TEST 1','TEST 1','╪¬╪¼╪▒╪¿╪⌐ 1','╪¬╪¼╪▒╪¿╪⌐ 1','╪¬╪¼╪▒╪¿╪⌐ 1','amman/jabal alzohor','╪╣┘à╪º┘å ╪¼╪¿┘ä ╪º┘ä╪▓┘ç┘ê╪▒','syrian','1990-09-12','8002759282','13c8983771','0779685343','NOUN','NOUN','0779685333','clients/May2020/0iJS9JYR4qbycF4YcAEy.jpg',NULL,'2020-05-12 05:43:00','2020-05-15 01:23:56','19902832X01','2020-01-01','2022-01-01',1,'╪¿╪╖╪º┘é╪⌐ ╪º╪│╪¬┘ä╪º┘à ╪º╪»┘ê┘è╪⌐',2,1);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_rows`
--

DROP TABLE IF EXISTS `data_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_type_id` int(10) unsigned NOT NULL,
  `field` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `browse` tinyint(1) NOT NULL DEFAULT '1',
  `read` tinyint(1) NOT NULL DEFAULT '1',
  `edit` tinyint(1) NOT NULL DEFAULT '1',
  `add` tinyint(1) NOT NULL DEFAULT '1',
  `delete` tinyint(1) NOT NULL DEFAULT '1',
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `order` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `data_rows_data_type_id_foreign` (`data_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=186 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_rows`
--

LOCK TABLES `data_rows` WRITE;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` VALUES (1,1,'id','number','ID',1,0,0,0,0,0,NULL,1),(2,1,'name','text','Name',1,1,1,1,1,1,NULL,2),(3,1,'email','text','Email',1,1,1,1,1,1,NULL,3),(4,1,'password','password','Password',1,0,0,1,1,0,NULL,4),(5,1,'remember_token','text','Remember Token',0,0,0,0,0,0,NULL,5),(6,1,'created_at','timestamp','Created At',0,1,1,0,0,0,NULL,6),(7,1,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,7),(8,1,'avatar','image','Avatar',0,1,1,1,1,1,NULL,8),(9,1,'user_belongsto_role_relationship','relationship','Role',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":0}',10),(10,1,'user_belongstomany_role_relationship','relationship','Roles',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}',11),(11,1,'settings','hidden','Settings',0,0,0,0,0,0,NULL,12),(12,2,'id','number','ID',1,0,0,0,0,0,NULL,1),(13,2,'name','text','Name',1,1,1,1,1,1,NULL,2),(14,2,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),(15,2,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),(16,3,'id','number','ID',1,0,0,0,0,0,'{}',1),(17,3,'name','text','Name',1,1,1,1,1,1,'{}',2),(18,3,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',3),(19,3,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',4),(20,3,'display_name','text','Display Name',1,1,1,1,1,1,'{}',5),(21,1,'role_id','text','Role',1,1,1,1,1,1,NULL,9),(22,4,'id','number','ID',1,0,0,0,0,0,NULL,1),(23,4,'parent_id','select_dropdown','Parent',0,0,1,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}',2),(24,4,'order','text','Order',1,1,1,1,1,1,'{\"default\":1}',3),(25,4,'name','text','Name',1,1,1,1,1,1,NULL,4),(26,4,'slug','text','Slug',1,1,1,1,1,1,'{\"slugify\":{\"origin\":\"name\"}}',5),(27,4,'created_at','timestamp','Created At',0,0,1,0,0,0,NULL,6),(28,4,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,7),(29,5,'id','number','ID',1,0,0,0,0,0,NULL,1),(30,5,'author_id','text','Author',1,0,1,1,0,1,NULL,2),(31,5,'category_id','text','Category',1,0,1,1,1,0,NULL,3),(32,5,'title','text','Title',1,1,1,1,1,1,NULL,4),(33,5,'excerpt','text_area','Excerpt',1,0,1,1,1,1,NULL,5),(34,5,'body','rich_text_box','Body',1,0,1,1,1,1,NULL,6),(35,5,'image','image','Post Image',0,1,1,1,1,1,'{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}',7),(36,5,'slug','text','Slug',1,0,1,1,1,1,'{\"slugify\":{\"origin\":\"title\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:posts,slug\"}}',8),(37,5,'meta_description','text_area','Meta Description',1,0,1,1,1,1,NULL,9),(38,5,'meta_keywords','text_area','Meta Keywords',1,0,1,1,1,1,NULL,10),(39,5,'status','select_dropdown','Status',1,1,1,1,1,1,'{\"default\":\"DRAFT\",\"options\":{\"PUBLISHED\":\"published\",\"DRAFT\":\"draft\",\"PENDING\":\"pending\"}}',11),(40,5,'created_at','timestamp','Created At',0,1,1,0,0,0,NULL,12),(41,5,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,13),(42,5,'seo_title','text','SEO Title',0,1,1,1,1,1,NULL,14),(43,5,'featured','checkbox','Featured',1,1,1,1,1,1,NULL,15),(44,6,'id','number','ID',1,0,0,0,0,0,NULL,1),(45,6,'author_id','text','Author',1,0,0,0,0,0,NULL,2),(46,6,'title','text','Title',1,1,1,1,1,1,NULL,3),(47,6,'excerpt','text_area','Excerpt',1,0,1,1,1,1,NULL,4),(48,6,'body','rich_text_box','Body',1,0,1,1,1,1,NULL,5),(49,6,'slug','text','Slug',1,0,1,1,1,1,'{\"slugify\":{\"origin\":\"title\"},\"validation\":{\"rule\":\"unique:pages,slug\"}}',6),(50,6,'meta_description','text','Meta Description',1,0,1,1,1,1,NULL,7),(51,6,'meta_keywords','text','Meta Keywords',1,0,1,1,1,1,NULL,8),(52,6,'status','select_dropdown','Status',1,1,1,1,1,1,'{\"default\":\"INACTIVE\",\"options\":{\"INACTIVE\":\"INACTIVE\",\"ACTIVE\":\"ACTIVE\"}}',9),(53,6,'created_at','timestamp','Created At',1,1,1,0,0,0,NULL,10),(54,6,'updated_at','timestamp','Updated At',1,0,0,0,0,0,NULL,11),(55,6,'image','image','Page Image',0,1,1,1,1,1,NULL,12),(56,7,'id','hidden','Id',1,0,0,0,0,0,'{}',1),(57,7,'brand','text','Brand',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',2),(58,7,'medical_name','text','Medical Name',1,0,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',3),(59,7,'dose_per_tablet','text','Dose Per Tablet',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',4),(60,7,'quantity_of_tablets','number','Quantity Of Tablets',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',5),(61,7,'list_purchase_price','number','List Purchase Price',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',6),(62,7,'wholesale_price','number','Wholesale Price',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',7),(63,7,'retail_price','number','Retail Price',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',8),(64,7,'market_price','number','Market Price',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',9),(65,7,'comments','rich_text_box','Comments',0,0,1,1,1,1,'{}',12),(66,7,'photo','image','Photo',0,0,1,1,1,1,'{}',11),(67,7,'created_at','timestamp','Created At',0,1,1,1,0,1,'{}',13),(68,7,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',14),(69,8,'id','hidden','Id',1,0,0,0,0,0,'{}',1),(70,8,'first_name_en','text','First Name (English)',0,0,1,1,1,1,'{}',12),(71,8,'father_name_en','text','Father Name (English)',0,0,1,1,1,1,'{}',13),(72,8,'last_name_en','text','Last Name (English)',0,0,1,1,1,1,'{}',14),(73,8,'first_name_ar','text','First Name (Arabic)',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',2),(74,8,'father_name_ar','text','Father Name (Arabic)',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',3),(75,8,'last_name_ar','text','Last Name (Arabic)',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',4),(76,8,'gender','radio_btn','Gender',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"0\",\"options\":{\"0\":\"Male\",\"1\":\"Female\"}}',11),(77,8,'address_en','text','Address (English)',0,0,1,1,1,1,'{}',15),(78,8,'address_ar','text','Address (Arabic)',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',5),(79,8,'nationality','text','Nationality',0,0,1,1,1,1,'{}',16),(80,8,'date_of_birth','date','Date of Birth',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',10),(81,8,'national_id_number','text','National ID Number',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',6),(82,8,'UNHCR_number','text','UNHCR Number',0,0,1,1,1,1,'{}',17),(83,8,'phone','text','Phone Number',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',7),(84,8,'relative_name_en','text','Relative Name (English)',0,0,1,1,1,1,'{}',18),(85,8,'relative_name_ar','text','Relative Name (Arabic)',0,0,1,1,1,1,'{}',19),(86,8,'relative_phone','text','Relative Phone Number',0,0,1,1,1,1,'{}',20),(87,8,'photo','image','Photo',0,0,1,1,1,1,'{}',21),(88,8,'comments','rich_text_box','Comments',0,0,1,1,1,1,'{}',22),(89,8,'created_at','timestamp','Created At',0,1,1,1,0,1,'{}',26),(90,8,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',27),(91,9,'id','hidden','Id',1,0,0,0,0,0,'{}',1),(92,9,'name_en','text','Name (English)',0,0,1,1,1,1,'{}',10),(93,9,'name_ar','text','Name (Arabic)',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',2),(94,9,'contact_name1','text','Contact 1 Name',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',3),(95,9,'contact_phone1','text','Contact 1 Phone',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',4),(96,9,'contact_email1','text','Contact 1 Email',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',5),(97,9,'contact_name2','text','Contact 2 Name',0,0,1,1,1,1,'{}',11),(98,9,'contact_phone2','text','Contact 2 Phone',0,0,1,1,1,1,'{}',12),(99,9,'contact_email2','text','Contact 2 Email',0,0,1,1,1,1,'{}',13),(100,9,'address_ar','text','Address (Arabic)',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',6),(101,9,'location_latitude','number','Location Latitude',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',7),(102,9,'location_longitude','number','Location Longitude',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',8),(103,9,'discount','number','Discount',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',9),(104,9,'comments','rich_text_box','Comments',0,0,1,1,1,1,'{}',14),(105,9,'created_at','timestamp','Created At',0,1,1,1,0,1,'{}',15),(106,9,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',16),(107,7,'type','radio_btn','Type',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"0\",\"options\":{\"0\":\"Pill\",\"1\":\"Liquid\",\"2\":\"Syringe\"}}',10),(108,10,'id','hidden','Id',1,0,0,0,0,0,'{}',1),(109,10,'name_en','text','Name (English)',0,0,1,1,1,1,'{}',7),(110,10,'name_ar','text','Name (Arabic)',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',2),(111,10,'contact_name1','text','Contact 1 Name',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',3),(112,10,'contact_phone1','text','Contact 1 Phone',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',4),(113,10,'contact_email1','text','Contact 1 Email',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',5),(114,10,'contact_name2','text','Contact 2 Name',0,0,1,1,1,1,'{}',8),(115,10,'contact_phone2','text','Contact 2 Phone',0,0,1,1,1,1,'{}',9),(116,10,'contact_email2','text','Contact 2 Email',0,0,1,1,1,1,'{}',10),(117,10,'address_ar','text','Address (Arabic)',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',6),(118,10,'comments','rich_text_box','Comments',0,0,1,1,1,1,'{}',11),(119,10,'created_at','timestamp','Created At',0,1,1,1,0,1,'{}',12),(120,10,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',13),(121,11,'id','hidden','Id',1,0,0,0,0,0,'{}',1),(122,11,'doctor_name','text','Doctor Name',0,1,1,1,1,1,'{}',9),(123,11,'illness','radio_btn','Illness',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"Diabetes\",\"options\":{\"Diabetes\":\"Diabetes\",\"Hypertension\":\"Hypertension\"}}',5),(124,11,'start_date','date','Start Date',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',6),(125,11,'end_date','date','End Date',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',7),(128,11,'pills_per_day_prescription','text','Pills Per Day (Prescription)',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',4),(129,11,'pills_per_day_actual','text','Pills Per Day (Actual)',0,0,1,1,1,1,'{}',10),(130,11,'photo','image','Photo',0,0,1,1,1,1,'{}',11),(131,11,'status','checkbox','Active',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"on\":\"Yes\",\"off\":\"No\",\"checked\":true}',8),(132,11,'comments','rich_text_box','Comments',0,0,1,1,1,1,'{}',12),(133,11,'created_at','timestamp','Created At',0,1,1,1,0,1,'{}',13),(134,11,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',15),(135,8,'card_number','text','Card Number',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',8),(136,8,'card_issue_date','text','Card Issue Date',0,0,1,1,1,1,'{}',23),(137,8,'card_expiration_date','text','Card Expiration Date',0,0,1,1,1,1,'{}',24),(138,8,'card_status','radio_btn','Card Active',0,1,1,1,1,1,'{\"default\":\"1\",\"options\":{\"0\":\"No\",\"1\":\"Yes\"}}',25),(139,8,'card_comment','text','Card Comment',1,0,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',9),(140,12,'id','text','Id',1,0,0,0,0,0,'{}',1),(141,12,'timestamp_proposed','timestamp','Time Proposed',0,1,1,1,1,1,'{}',7),(142,12,'timestamp_prepared','timestamp','Time Prepared',0,1,1,1,1,1,'{}',8),(143,12,'timestamp_ordered','timestamp','Time Ordered',0,1,1,1,1,1,'{}',9),(144,12,'timestamp_confirmed','timestamp','Time Confirmed',0,1,1,1,1,1,'{}',10),(145,12,'delivery_date_expected','timestamp','Delivery Date Expected',0,1,1,1,1,1,'{}',11),(146,12,'timestamp_delivered','timestamp','Time Delivered',0,1,1,1,1,1,'{}',12),(147,12,'timestamp_closed','timestamp','Time Closed',0,1,1,1,1,1,'{}',13),(148,12,'total_value_ordered','number','Total Value Ordered',0,1,1,1,1,1,'{}',5),(149,12,'total_value_delivered','number','Total Value Delivered',0,1,1,1,1,1,'{}',6),(150,12,'status','radio_btn','Status',0,1,1,1,1,1,'{\"default\":\"0\",\"options\":{\"0\":\"Proposed\",\"1\":\"Prepared\",\"2\":\"Placed\",\"3\":\"Confirmed\",\"4\":\"Delivered\",\"5\":\"Closed\"}}',14),(151,12,'comments','rich_text_box','Comments',0,0,1,1,1,1,'{}',15),(152,12,'created_at','timestamp','Created At',0,1,1,0,0,0,'{}',16),(153,12,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',17),(156,8,'client_belongsto_pharmacy_relationship','relationship','Pharmacy',0,1,1,1,1,1,'{\"model\":\"App\\\\Pharmacy\",\"table\":\"pharmacies\",\"type\":\"belongsTo\",\"column\":\"pharmacy_id\",\"key\":\"id\",\"label\":\"name_en\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',28),(158,7,'medication_belongsto_factory_relationship','relationship','Factory',0,1,1,1,1,1,'{\"model\":\"App\\\\Factory\",\"table\":\"factories\",\"type\":\"belongsTo\",\"column\":\"factory_id\",\"key\":\"id\",\"label\":\"name_en\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',15),(157,8,'pharmacy_id','text','Pharmacy Id',0,1,1,1,1,1,'{}',29),(159,7,'factory_id','text','Factory Id',0,1,1,1,1,1,'{}',16),(160,8,'client_hasmany_prescription_relationship','relationship','Prescriptions',0,1,1,1,1,1,'{\"model\":\"App\\\\Prescription\",\"table\":\"prescriptions\",\"type\":\"hasMany\",\"column\":\"client_id\",\"key\":\"id\",\"label\":\"id\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',30),(161,11,'prescription_belongsto_client_relationship','relationship','Client',0,1,1,1,1,1,'{\"model\":\"App\\\\Client\",\"table\":\"clients\",\"type\":\"belongsTo\",\"column\":\"client_id\",\"key\":\"id\",\"label\":\"full_name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',2),(162,11,'client_id','text','Client Id',0,1,1,1,1,1,'{}',16),(163,11,'prescription_hasone_medication_relationship','relationship','Medication',0,1,1,1,1,1,'{\"model\":\"App\\\\Medication\",\"table\":\"medications\",\"type\":\"belongsTo\",\"column\":\"medication_id\",\"key\":\"id\",\"label\":\"full_description\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',3),(164,11,'medication_id','text','Medication Id',0,1,1,1,1,1,'{}',14),(165,13,'id','text','Id',1,0,0,0,0,0,'{}',1),(166,13,'prescription_id','text','Prescription Id',0,1,1,1,1,1,'{}',2),(167,13,'start_date','text','Start Date',1,1,1,1,1,1,'{}',3),(168,13,'end_date','text','End Date',1,1,1,1,1,1,'{}',4),(169,13,'pills_per_day_prescription','text','Pills Per Day Prescription',1,1,1,1,1,1,'{}',5),(170,13,'pills_per_day_actual','text','Pills Per Day Actual',0,1,1,1,1,1,'{}',6),(171,13,'prescription_status','text','Prescription Status',1,1,1,1,1,1,'{}',7),(172,13,'client_id','text','Client Id',0,1,1,1,1,1,'{}',8),(173,13,'medication_id','text','Medication Id',0,1,1,1,1,1,'{}',9),(174,13,'factory_id','text','Factory Id',0,1,1,1,1,1,'{}',10),(175,13,'pharmacy_id','text','Pharmacy Id',0,1,1,1,1,1,'{}',11),(176,13,'created_at_prescription','timestamp','Created At Prescription',0,1,1,1,1,1,'{}',12),(177,13,'updated_at_prescription','timestamp','Updated At Prescription',0,1,1,1,1,1,'{}',13),(178,13,'created_at','timestamp','Created At',0,1,1,1,0,1,'{}',14),(179,13,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',15),(182,12,'order_belongsto_factory_relationship','relationship','Factory',0,1,1,1,1,1,'{\"model\":\"\\\\App\\\\Factory\",\"table\":\"factories\",\"type\":\"belongsTo\",\"column\":\"factory_id\",\"key\":\"id\",\"label\":\"name_ar\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',3),(183,12,'factory_id','text','Factory Id',0,1,1,1,1,1,'{}',18),(181,12,'number','text','Number',0,1,1,1,1,1,'{}',2),(184,12,'pharmacy_id','text','Pharmacy Id',0,1,1,1,1,1,'{}',19),(185,12,'order_belongsto_pharmacy_relationship','relationship','Pharmacy',0,1,1,1,1,1,'{\"model\":\"\\\\App\\\\Pharmacy\",\"table\":\"pharmacies\",\"type\":\"belongsTo\",\"column\":\"pharmacy_id\",\"key\":\"id\",\"label\":\"name_ar\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',4);
/*!40000 ALTER TABLE `data_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_types`
--

DROP TABLE IF EXISTS `data_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT '0',
  `server_side` tinyint(4) NOT NULL DEFAULT '0',
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_types_name_unique` (`name`),
  UNIQUE KEY `data_types_slug_unique` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_types`
--

LOCK TABLES `data_types` WRITE;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` VALUES (1,'users','users','User','Users','voyager-person','TCG\\Voyager\\Models\\User','TCG\\Voyager\\Policies\\UserPolicy','TCG\\Voyager\\Http\\Controllers\\VoyagerUserController','',1,0,NULL,'2020-03-17 03:23:45','2020-03-17 03:23:45'),(2,'menus','menus','Menu','Menus','voyager-list','TCG\\Voyager\\Models\\Menu',NULL,'','',1,0,NULL,'2020-03-17 03:23:45','2020-03-17 03:23:45'),(3,'roles','roles','Role','Roles','voyager-lock','TCG\\Voyager\\Models\\Role',NULL,'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController',NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}','2020-03-17 03:23:45','2020-03-21 04:42:30'),(4,'categories','categories','Category','Categories','voyager-categories','TCG\\Voyager\\Models\\Category',NULL,'','',1,0,NULL,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(5,'posts','posts','Post','Posts','voyager-news','TCG\\Voyager\\Models\\Post','TCG\\Voyager\\Policies\\PostPolicy','','',1,0,NULL,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(6,'pages','pages','Page','Pages','voyager-file-text','TCG\\Voyager\\Models\\Page',NULL,'','',1,0,NULL,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(7,'medications','medications','Medication','Medications','voyager-rum-1','App\\Medication',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"brand\",\"scope\":null}','2020-03-19 06:38:39','2020-05-18 07:57:01'),(8,'clients','clients','Client','Clients','voyager-person','App\\Client',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"last_name_en\",\"scope\":null}','2020-03-21 04:39:01','2020-05-13 13:35:24'),(9,'pharmacies','pharmacies','Pharmacy','Pharmacies','voyager-activity','App\\Pharmacy',NULL,NULL,NULL,1,1,'{\"order_column\":\"created_at\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"name_en\",\"scope\":null}','2020-03-22 01:44:37','2020-05-13 13:51:54'),(10,'factories','factories','Factory','Factories','voyager-company','App\\Factory',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"name_en\",\"scope\":null}','2020-03-23 04:08:53','2020-05-13 13:38:11'),(11,'prescriptions','prescriptions','Prescription','Prescriptions','voyager-file-text','App\\Prescription',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":\"illness\",\"order_direction\":\"asc\",\"default_search_key\":\"illness\",\"scope\":null}','2020-03-24 17:37:57','2020-05-18 07:55:10'),(12,'orders','orders','Order','Orders','voyager-list','App\\Order',NULL,'\\App\\Http\\Controllers\\Voyager\\OrdersController',NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2020-04-26 02:49:09','2020-05-31 03:12:38'),(13,'suggested_orders','suggested-orders','Suggested Order','Suggested Orders','voyager-move','App\\SuggestedOrder',NULL,'\\App\\Http\\Controllers\\Voyager\\SuggestedOrdersController',NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2020-05-18 05:25:33','2020-05-18 20:09:38');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factories`
--

DROP TABLE IF EXISTS `factories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_name1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_phone1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_email1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_name2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factories`
--

LOCK TABLES `factories` WRITE;
/*!40000 ALTER TABLE `factories` DISABLE KEYS */;
INSERT INTO `factories` VALUES (2,'Alhekma','╪º┘ä╪¡┘â┘à╪⌐','Moayad','0779286276','abdallah.chamas+1email2@gmail.com','Samer','090318798','abdallah.chamas+2email2@gmail.com','╪╣┘à╪º┘å ╪º┘ä┘é╪│╪╖┘ä',NULL,'2020-03-31 04:48:13','2020-03-31 04:48:13'),(3,'Alarabia','╪º┘ä╪╣╪▒╪¿┘è╪⌐','╪▒╪º╪ª╪»','082656198','abdallah.chamas+1email3@gmail.com',NULL,NULL,'abdallah.chamas+2email3@gmail.com','╪╣┘à╪º┘å / ╪╡╪º┘ü┘ê╪╖',NULL,'2020-04-24 19:46:24','2020-04-24 19:46:24'),(5,'test 1','╪¬╪¼╪▒╪¿╪⌐ 1','╪¿╪┤┘è╪▒','0779286276','abdallah.chamas+1email5@gmail.com',NULL,NULL,'abdallah.chamas+2email5@gmail.com','╪╣┘à╪º┘å ╪º┘ä┘é╪│╪╖┘ä',NULL,'2020-05-12 06:32:17','2020-05-12 06:32:17'),(6,'test','╪º┘ä╪¡┘â┘à╪⌐','┘à╪¡┘à╪»','070000000','abdallah.chamas+1email6@gmail.com',NULL,NULL,'abdallah.chamas+2email6@gmail.com','╪╡┘ê┘è┘ä╪¡\\╪╣┘à╪º┘å',NULL,'2020-05-12 19:38:42','2020-05-12 19:38:42');
/*!40000 ALTER TABLE `factories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medications`
--

DROP TABLE IF EXISTS `medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `medical_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dose_per_tablet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity_of_tablets` int(11) NOT NULL,
  `list_purchase_price` float NOT NULL,
  `wholesale_price` float NOT NULL,
  `retail_price` float NOT NULL,
  `market_price` float NOT NULL,
  `comments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` int(10) unsigned DEFAULT NULL,
  `factory_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medications`
--

LOCK TABLES `medications` WRITE;
/*!40000 ALTER TABLE `medications` DISABLE KEYS */;
INSERT INTO `medications` VALUES (1,'Amaryl','Amaryl','1',30,2.25,4.8,2.15,5.55,NULL,NULL,'2020-03-20 23:27:00','2020-03-31 04:52:04',0,NULL),(3,'Panadol','Panda','120',18,1,1.75,1.5,3,'<p style=\"text-align: center;\">Test</p>',NULL,'2020-04-24 19:50:00','2020-04-24 19:51:06',0,NULL),(67,'Natrilix sr','Indapamide','1.5',30,0,0,4.92,2.45,NULL,NULL,'2020-05-11 05:38:00','2020-05-12 05:38:34',0,3),(68,'ACE press','enalapril','10',30,1.99,3.97,5.2,2.6,NULL,NULL,'2020-05-11 05:38:00','2020-05-11 11:39:31',0,3),(69,'ACE press','enalapril','20',30,3.38,6.75,8.84,4.42,NULL,NULL,'2020-05-11 05:38:00','2020-05-11 11:39:17',0,3),(70,'arbiten','valsartan','160',30,3.6,6.11,8.01,4,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(71,'arbiten plus','valsartanhydrochlorothiaz','160/12.5',30,3.05,6.11,8.01,4,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(72,'glemax','glimepiride','2',30,1.09,2.17,2.84,1.42,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(73,'blopress plus','hydrochlorothiazidecandes','12.5/8',28,1.6,3.14,4.12,2.06,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(74,'diusmide','furosemide','20mg2ml',5,0.55,1.06,1.38,0.7,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(75,'glibil','glibenclamide','5',30,0.65,1.24,1.62,0.85,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(76,'glorion','glimepiride','2',30,1.1,2.17,2.84,1.45,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(77,'hypoten','atenolol','50',28,1.05,2.05,2.68,1.35,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(78,'lowvasc','amlodipine','5',28,1.85,3.68,4.83,2.45,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(79,'mystro','metformin','850',30,0.75,1.51,1.98,1,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(80,'concor','bisoprolol','5',30,1.75,3.47,4.54,2.25,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(81,'glucophage','metformin','1000',30,1.06,2.12,2.78,1.4,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(82,'glucophage','metformin','850',30,0.85,1.71,2.25,1.15,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(83,'amaryl','glimeoiride','1',30,0,0,2.66,1.33,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(84,'carvidol','carvedilol','6.25',30,0,0,3.74,1.87,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(85,'co-diavan','valsartan hydrochlorothia','160/25',28,0,0,7.48,3.75,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(86,'co-diovan','valsartan hydrochlorothia','16012.5',28,0,0,7.48,3.74,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(87,'co-diovan','valsartan hydrochlorothia','80 12.5',28,0,0,6.48,3.25,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(88,'dialon','metformin','850',30,0,0,0.84,0.42,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(89,'diamet','metformin','850',30,0,0,2.15,1.08,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(90,'diamicron mr','gliclazide','60',30,0,0,4.64,2.32,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(91,'diaphage ','metformin','850',30,0,0,1.98,0.99,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(92,'forxiga','dapagliflozin','10',28,0,0,38.48,19.24,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(93,'gardia','candesartan','16',30,0,0,8.52,4.27,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(94,'glimeryl','glimepiride','2',30,0,0,2.84,1.42,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(95,'glunil','glibenclamide','5',30,0,0,1.62,0.81,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(96,'glymet','metformin','850',30,0,0,2.15,1.08,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(97,'lasix','furosemide','40',20,0,0,1.02,0.51,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(98,'linopril','lisinopril','10',28,0,0,7.13,3.57,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(99,'metforal','metformin','500',50,0,0,6.1,3.05,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(100,'metforal','metformin','850',30,0,0,1.63,0.82,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(101,'micardis','telmisartan','80',28,0,0,9.44,4.75,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(102,'micardis plus','telmisartan hydrochloroth','80 12.5',28,0,0,10.43,5.22,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(103,'mixtard','insulin human','10ml',1,0,0,10.79,5.4,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(104,'nebilet','nebivolol','5.45',28,0,0,5.86,2.93,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(105,'norvasc','amlodipine','10',30,0,0,6.3,3.15,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(106,'norvasc','amlodipine','5',30,0,0,5.44,2.72,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(107,'tenolol','Atenolol','50',28,0,0,2.68,1.34,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(108,'trajenta','linagliptin','5',30,0,0,27.48,13.74,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(109,'twynsta','amlodipine telmis','80 10',28,0,0,19.14,9.57,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(110,'viltin','vildagliptin','50',28,0,0,10.88,5.44,'',NULL,'2020-05-11 05:38:02','2020-05-11 05:38:17',0,3),(130,'TEST1','EXTRA','160',1,1.5,2.25,3,4.5,'<p>test 1&nbsp;</p>','medications/May2020/sJJoIGN5OiBlatiVzStB.jpg','2020-05-12 05:35:22','2020-05-12 05:35:22',1,2),(131,'test22','metformin hcl','243',30,23.8,23.8,25.6,26.66,NULL,'medications/May2020/SyJCEaNZ5bmGGaB9YeCA.jpg','2020-05-12 19:28:10','2020-05-12 19:28:10',0,5);
/*!40000 ALTER TABLE `medications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,1,'Dashboard','','_self','voyager-boat',NULL,NULL,1,'2020-03-17 03:23:45','2020-03-17 03:23:45','voyager.dashboard',NULL),(2,1,'Media','','_self','voyager-images',NULL,NULL,4,'2020-03-17 03:23:45','2020-05-28 19:27:48','voyager.media.index',NULL),(3,1,'Users','','_self','voyager-person',NULL,NULL,3,'2020-03-17 03:23:45','2020-03-17 03:23:45','voyager.users.index',NULL),(4,1,'Roles','','_self','voyager-lock',NULL,NULL,2,'2020-03-17 03:23:45','2020-03-17 03:23:45','voyager.roles.index',NULL),(5,1,'Tools','','_self','voyager-tools',NULL,NULL,8,'2020-03-17 03:23:45','2020-05-28 19:27:48',NULL,NULL),(6,1,'Menu Builder','','_self','voyager-list',NULL,5,1,'2020-03-17 03:23:45','2020-05-28 19:27:48','voyager.menus.index',NULL),(7,1,'Database','','_self','voyager-data',NULL,5,2,'2020-03-17 03:23:45','2020-05-28 19:27:48','voyager.database.index',NULL),(8,1,'Compass','','_self','voyager-compass',NULL,5,3,'2020-03-17 03:23:45','2020-05-28 19:27:48','voyager.compass.index',NULL),(9,1,'BREAD','','_self','voyager-bread',NULL,5,4,'2020-03-17 03:23:45','2020-05-28 19:27:48','voyager.bread.index',NULL),(10,1,'Settings','','_self','voyager-settings',NULL,NULL,9,'2020-03-17 03:23:45','2020-05-28 19:27:48','voyager.settings.index',NULL),(11,1,'Categories','','_self','voyager-categories',NULL,NULL,7,'2020-03-17 03:23:46','2020-05-28 19:27:48','voyager.categories.index',NULL),(12,1,'Posts','','_self','voyager-news',NULL,NULL,5,'2020-03-17 03:23:46','2020-05-28 19:27:48','voyager.posts.index',NULL),(13,1,'Pages','','_self','voyager-file-text',NULL,NULL,6,'2020-03-17 03:23:46','2020-05-28 19:27:48','voyager.pages.index',NULL),(14,1,'Hooks','','_self','voyager-hook',NULL,5,5,'2020-03-17 03:23:46','2020-05-28 19:27:48','voyager.hooks',NULL),(17,1,'Clients','','_self','voyager-person',NULL,NULL,11,'2020-03-21 04:39:01','2020-05-28 19:27:48','voyager.clients.index',NULL),(16,1,'Medications','/admin/medications','_self','voyager-rum-1','#000000',NULL,10,'2020-03-19 06:45:28','2020-05-28 19:27:48',NULL,''),(18,1,'Pharmacies','','_self','voyager-activity','#000000',NULL,12,'2020-03-22 01:44:37','2020-05-28 19:27:48','voyager.pharmacies.index','null'),(19,1,'Factories','/admin/factories','_self','voyager-company','#000000',NULL,13,'2020-03-23 04:15:25','2020-05-28 19:27:48',NULL,''),(20,1,'Prescriptions','','_self','voyager-file-text',NULL,NULL,14,'2020-03-24 17:37:57','2020-05-28 19:27:48','voyager.prescriptions.index',NULL),(21,1,'Active Orders','','_self',NULL,'#000000',24,2,'2020-04-26 02:49:09','2020-05-28 19:29:16','voyager.orders.index','{\"ordersType\":\"active\"}'),(22,1,'Suggested Orders','','_self',NULL,'#000000',24,1,'2020-05-18 05:25:33','2020-05-28 19:29:09','voyager.suggested-orders.index','null'),(23,1,'Closed Orders','','_self',NULL,'#000000',24,3,'2020-05-28 19:24:41','2020-05-28 19:29:23','voyager.orders.index','{\"ordersType\":\"closed\"}'),(24,1,'Orders','','_self','voyager-list','#000000',NULL,15,'2020-05-28 19:28:06','2020-05-28 19:29:30',NULL,'');
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'admin','2020-03-17 03:23:45','2020-03-17 03:23:45');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_01_01_000000_add_voyager_user_fields',1),(4,'2016_01_01_000000_create_data_types_table',1),(5,'2016_01_01_000000_create_pages_table',1),(6,'2016_01_01_000000_create_posts_table',1),(7,'2016_02_15_204651_create_categories_table',1),(8,'2016_05_19_173453_create_menu_table',1),(9,'2016_10_21_190000_create_roles_table',1),(10,'2016_10_21_190000_create_settings_table',1),(11,'2016_11_30_135954_create_permission_table',1),(12,'2016_11_30_141208_create_permission_role_table',1),(13,'2016_12_26_201236_data_types__add__server_side',1),(14,'2017_01_13_000000_add_route_to_menu_items_table',1),(15,'2017_01_14_005015_create_translations_table',1),(16,'2017_01_15_000000_make_table_name_nullable_in_permissions_table',1),(17,'2017_03_06_000000_add_controller_to_data_types_table',1),(18,'2017_04_11_000000_alter_post_nullable_fields_table',1),(19,'2017_04_21_000000_add_order_to_data_rows_table',1),(20,'2017_07_05_210000_add_policyname_to_data_types_table',1),(21,'2017_08_05_000000_add_group_to_settings_table',1),(22,'2017_11_26_013050_add_user_role_relationship',1),(23,'2017_11_26_015000_create_user_roles_table',1),(24,'2018_03_11_000000_add_user_settings',1),(25,'2018_03_14_000000_add_details_to_data_types_table',1),(26,'2018_03_16_000000_make_settings_value_nullable',1),(27,'2019_08_19_000000_create_failed_jobs_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp_proposed` timestamp NULL DEFAULT NULL,
  `timestamp_prepared` timestamp NULL DEFAULT NULL,
  `timestamp_ordered` timestamp NULL DEFAULT NULL,
  `timestamp_confirmed` timestamp NULL DEFAULT NULL,
  `delivery_date_expected` timestamp NULL DEFAULT NULL,
  `timestamp_delivered` timestamp NULL DEFAULT NULL,
  `timestamp_closed` timestamp NULL DEFAULT NULL,
  `total_value_ordered` float DEFAULT NULL,
  `total_value_delivered` float DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `comments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `factory_id` bigint(20) DEFAULT NULL,
  `pharmacy_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_number_unique` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (12,NULL,NULL,'2020-05-28 18:01:34',NULL,NULL,NULL,NULL,2.25,NULL,1,NULL,'2020-05-28 18:01:34','2020-05-28 18:01:34','DE939A80BF3D',2,3),(13,NULL,NULL,'2020-05-28 18:01:34',NULL,NULL,NULL,NULL,0,NULL,5,NULL,'2020-05-28 18:01:34','2020-05-28 18:01:34','240057F5EA93',3,3),(14,NULL,NULL,'2020-05-31 03:47:00',NULL,NULL,NULL,NULL,1,NULL,1,NULL,'2020-05-31 03:47:00','2020-05-31 03:47:00','9D42C96269DE',NULL,2);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('ACTIVE','INACTIVE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,0,'Hello World','Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.','<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','pages/page1.jpg','hello-world','Yar Meta Description','Keyword1, Keyword2','ACTIVE','2020-03-17 03:23:46','2020-03-17 03:23:46');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_role` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_permission_id_index` (`permission_id`),
  KEY `permission_role_role_id_index` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_role`
--

LOCK TABLES `permission_role` WRITE;
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` VALUES (1,1),(1,4),(2,1),(3,1),(4,1),(4,4),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(16,3),(17,1),(17,3),(18,1),(18,3),(19,1),(19,3),(20,1),(20,3),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(42,1),(42,3),(42,4),(43,1),(43,3),(43,4),(44,1),(44,3),(44,4),(45,1),(45,3),(45,4),(46,1),(46,3),(46,4),(47,1),(47,4),(48,1),(48,4),(49,1),(49,4),(50,1),(50,4),(51,1),(51,4),(52,1),(52,4),(53,1),(53,4),(54,1),(54,4),(55,1),(55,4),(56,1),(56,4),(57,1),(57,4),(58,1),(58,4),(59,1),(59,4),(60,1),(60,4),(61,1),(61,4),(62,1),(62,4),(63,1),(63,4),(64,1),(64,4),(65,1),(65,4),(66,1),(66,4),(67,1),(68,1),(69,1),(70,1),(71,1),(72,1),(73,1),(74,1),(75,1),(76,1);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'browse_admin',NULL,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(2,'browse_bread',NULL,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(3,'browse_database',NULL,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(4,'browse_media',NULL,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(5,'browse_compass',NULL,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(6,'browse_menus','menus','2020-03-17 03:23:46','2020-03-17 03:23:46'),(7,'read_menus','menus','2020-03-17 03:23:46','2020-03-17 03:23:46'),(8,'edit_menus','menus','2020-03-17 03:23:46','2020-03-17 03:23:46'),(9,'add_menus','menus','2020-03-17 03:23:46','2020-03-17 03:23:46'),(10,'delete_menus','menus','2020-03-17 03:23:46','2020-03-17 03:23:46'),(11,'browse_roles','roles','2020-03-17 03:23:46','2020-03-17 03:23:46'),(12,'read_roles','roles','2020-03-17 03:23:46','2020-03-17 03:23:46'),(13,'edit_roles','roles','2020-03-17 03:23:46','2020-03-17 03:23:46'),(14,'add_roles','roles','2020-03-17 03:23:46','2020-03-17 03:23:46'),(15,'delete_roles','roles','2020-03-17 03:23:46','2020-03-17 03:23:46'),(16,'browse_users','users','2020-03-17 03:23:46','2020-03-17 03:23:46'),(17,'read_users','users','2020-03-17 03:23:46','2020-03-17 03:23:46'),(18,'edit_users','users','2020-03-17 03:23:46','2020-03-17 03:23:46'),(19,'add_users','users','2020-03-17 03:23:46','2020-03-17 03:23:46'),(20,'delete_users','users','2020-03-17 03:23:46','2020-03-17 03:23:46'),(21,'browse_settings','settings','2020-03-17 03:23:46','2020-03-17 03:23:46'),(22,'read_settings','settings','2020-03-17 03:23:46','2020-03-17 03:23:46'),(23,'edit_settings','settings','2020-03-17 03:23:46','2020-03-17 03:23:46'),(24,'add_settings','settings','2020-03-17 03:23:46','2020-03-17 03:23:46'),(25,'delete_settings','settings','2020-03-17 03:23:46','2020-03-17 03:23:46'),(26,'browse_categories','categories','2020-03-17 03:23:46','2020-03-17 03:23:46'),(27,'read_categories','categories','2020-03-17 03:23:46','2020-03-17 03:23:46'),(28,'edit_categories','categories','2020-03-17 03:23:46','2020-03-17 03:23:46'),(29,'add_categories','categories','2020-03-17 03:23:46','2020-03-17 03:23:46'),(30,'delete_categories','categories','2020-03-17 03:23:46','2020-03-17 03:23:46'),(31,'browse_posts','posts','2020-03-17 03:23:46','2020-03-17 03:23:46'),(32,'read_posts','posts','2020-03-17 03:23:46','2020-03-17 03:23:46'),(33,'edit_posts','posts','2020-03-17 03:23:46','2020-03-17 03:23:46'),(34,'add_posts','posts','2020-03-17 03:23:46','2020-03-17 03:23:46'),(35,'delete_posts','posts','2020-03-17 03:23:46','2020-03-17 03:23:46'),(36,'browse_pages','pages','2020-03-17 03:23:46','2020-03-17 03:23:46'),(37,'read_pages','pages','2020-03-17 03:23:46','2020-03-17 03:23:46'),(38,'edit_pages','pages','2020-03-17 03:23:46','2020-03-17 03:23:46'),(39,'add_pages','pages','2020-03-17 03:23:46','2020-03-17 03:23:46'),(40,'delete_pages','pages','2020-03-17 03:23:46','2020-03-17 03:23:46'),(41,'browse_hooks',NULL,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(42,'browse_medications','medications','2020-03-19 06:38:39','2020-03-19 06:38:39'),(43,'read_medications','medications','2020-03-19 06:38:39','2020-03-19 06:38:39'),(44,'edit_medications','medications','2020-03-19 06:38:39','2020-03-19 06:38:39'),(45,'add_medications','medications','2020-03-19 06:38:39','2020-03-19 06:38:39'),(46,'delete_medications','medications','2020-03-19 06:38:39','2020-03-19 06:38:39'),(47,'browse_clients','clients','2020-03-21 04:39:01','2020-03-21 04:39:01'),(48,'read_clients','clients','2020-03-21 04:39:01','2020-03-21 04:39:01'),(49,'edit_clients','clients','2020-03-21 04:39:01','2020-03-21 04:39:01'),(50,'add_clients','clients','2020-03-21 04:39:01','2020-03-21 04:39:01'),(51,'delete_clients','clients','2020-03-21 04:39:01','2020-03-21 04:39:01'),(52,'browse_pharmacies','pharmacies','2020-03-22 01:44:37','2020-03-22 01:44:37'),(53,'read_pharmacies','pharmacies','2020-03-22 01:44:37','2020-03-22 01:44:37'),(54,'edit_pharmacies','pharmacies','2020-03-22 01:44:37','2020-03-22 01:44:37'),(55,'add_pharmacies','pharmacies','2020-03-22 01:44:37','2020-03-22 01:44:37'),(56,'delete_pharmacies','pharmacies','2020-03-22 01:44:37','2020-03-22 01:44:37'),(57,'browse_factories','factories','2020-03-23 04:13:12','2020-03-23 04:13:12'),(58,'read_factories','factories','2020-03-23 04:13:12','2020-03-23 04:13:12'),(59,'edit_factories','factories','2020-03-23 04:13:12','2020-03-23 04:13:12'),(60,'add_factories','factories','2020-03-23 04:13:12','2020-03-23 04:13:12'),(61,'delete_factories','factories','2020-03-23 04:13:12','2020-03-23 04:13:12'),(62,'browse_prescriptions','prescriptions','2020-03-24 17:37:57','2020-03-24 17:37:57'),(63,'read_prescriptions','prescriptions','2020-03-24 17:37:57','2020-03-24 17:37:57'),(64,'edit_prescriptions','prescriptions','2020-03-24 17:37:57','2020-03-24 17:37:57'),(65,'add_prescriptions','prescriptions','2020-03-24 17:37:57','2020-03-24 17:37:57'),(66,'delete_prescriptions','prescriptions','2020-03-24 17:37:57','2020-03-24 17:37:57'),(67,'browse_orders','orders','2020-04-26 02:49:09','2020-04-26 02:49:09'),(68,'read_orders','orders','2020-04-26 02:49:09','2020-04-26 02:49:09'),(69,'edit_orders','orders','2020-04-26 02:49:09','2020-04-26 02:49:09'),(70,'add_orders','orders','2020-04-26 02:49:09','2020-04-26 02:49:09'),(71,'delete_orders','orders','2020-04-26 02:49:09','2020-04-26 02:49:09'),(72,'browse_suggested_orders','suggested_orders','2020-05-18 05:25:33','2020-05-18 05:25:33'),(73,'read_suggested_orders','suggested_orders','2020-05-18 05:25:33','2020-05-18 05:25:33'),(74,'edit_suggested_orders','suggested_orders','2020-05-18 05:25:33','2020-05-18 05:25:33'),(75,'add_suggested_orders','suggested_orders','2020-05-18 05:25:33','2020-05-18 05:25:33'),(76,'delete_suggested_orders','suggested_orders','2020-05-18 05:25:33','2020-05-18 05:25:33');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacies`
--

DROP TABLE IF EXISTS `pharmacies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_name1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_phone1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_email1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_name2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_latitude` float NOT NULL,
  `location_longitude` float NOT NULL,
  `discount` float NOT NULL,
  `comments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacies`
--

LOCK TABLES `pharmacies` WRITE;
/*!40000 ALTER TABLE `pharmacies` DISABLE KEYS */;
INSERT INTO `pharmacies` VALUES (2,'Abn Aoof','╪º╪¿┘å ╪╣┘ê┘ü','Mohammad','0779286276','mohammad@abnaoof.com','┘å╪º╪╡╪▒','020837992','naser@hekma.com','╪╣┘à╪º┘å - ╪╡┘ê┘è┘ä╪¡ - ╪º┘ä╪¡┘è ╪º┘ä╪┤╪▒┘é┘è',-721,232,10,NULL,'2020-03-31 04:46:00','2020-03-31 04:46:27'),(3,'Haneen','╪¡┘å┘è┘å','┘à╪¡┘à┘ê╪» ╪º┘ä╪«╪▒┘è╪│╪º╪¬','077266926717','M.hanenn@pharmacy.com',NULL,NULL,NULL,'╪╣┘à╪º┘å ╪╡┘ê┘è┘ä╪¡',128,817,10,NULL,'2020-04-24 19:44:12','2020-04-24 19:44:12');
/*!40000 ALTER TABLE `pharmacies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('PUBLISHED','DRAFT','PENDING') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,0,NULL,'Lorem Ipsum Post',NULL,'This is the excerpt for the Lorem Ipsum Post','<p>This is the body of the lorem ipsum post</p>','posts/post1.jpg','lorem-ipsum-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(2,0,NULL,'My Sample Post',NULL,'This is the excerpt for the sample Post','<p>This is the body for the sample post, which includes the body.</p>\n                <h2>We can use all kinds of format!</h2>\n                <p>And include a bunch of other stuff.</p>','posts/post2.jpg','my-sample-post','Meta Description for sample post','keyword1, keyword2, keyword3','PUBLISHED',0,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(3,0,NULL,'Latest Post',NULL,'This is the excerpt for the latest post','<p>This is the body for the latest post</p>','posts/post3.jpg','latest-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(4,0,NULL,'Yarr Post',NULL,'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.','<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>','posts/post4.jpg','yarr-post','this be a meta descript','keyword1, keyword2, keyword3','PUBLISHED',0,'2020-03-17 03:23:46','2020-03-17 03:23:46');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `doctor_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `illness` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `pills_per_day_prescription` int(11) NOT NULL,
  `pills_per_day_actual` int(11) DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `comments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `medication_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescriptions`
--

LOCK TABLES `prescriptions` WRITE;
/*!40000 ALTER TABLE `prescriptions` DISABLE KEYS */;
INSERT INTO `prescriptions` VALUES (1,'A','Hypertension','2020-05-17','2020-05-24',1,1,NULL,1,NULL,'2020-05-10 03:18:00','2020-05-12 06:26:49',171,1),(2,'Mohammad','Diabetes','2020-12-05','2020-12-31',2,2,NULL,1,NULL,'2020-05-12 06:18:24','2020-05-12 06:18:24',3,3),(3,'┘à╪¡┘à╪»','Diabetes','2020-02-01','2020-12-01',1,1,'prescriptions/May2020/yFxIlr5HuYv4N6MO1ZRJ.jpg',1,NULL,'2020-05-12 19:52:00','2020-05-13 14:19:16',135,99);
/*!40000 ALTER TABLE `prescriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','Administrator','2020-03-17 03:23:45','2020-03-17 03:23:45'),(2,'user','Normal User','2020-03-17 03:23:45','2020-03-17 03:23:45'),(4,'mdbadmin','Medicine Bank Administrator','2020-03-20 18:33:14','2020-03-20 18:33:14');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `group` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'site.title','Site Title','Site Title','','text',1,'Site'),(2,'site.description','Site Description','Site Description','','text',2,'Site'),(3,'site.logo','Site Logo','','','image',3,'Site'),(5,'admin.bg_image','Admin Background Image','settings\\May2020\\V6COCJoT1u5rBBjnGzxI.jpg','','image',5,'Admin'),(6,'admin.title','Admin Title','Medicine Bank','','text',1,'Admin'),(7,'admin.description','Admin Description','Welcome to Medicine Bank (Jordan). We care about your health','','text',2,'Admin'),(8,'admin.loader','Admin Loader','settings\\May2020\\sp8mlVVoklfPUFnu0D5u.gif','','image',3,'Admin'),(9,'admin.icon_image','Admin Icon Image','','','image',4,'Admin');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggested_orders`
--

DROP TABLE IF EXISTS `suggested_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suggested_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `prescription_id` bigint(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `pills_per_day_prescription` int(11) NOT NULL,
  `pills_per_day_actual` int(11) DEFAULT NULL,
  `prescription_status` tinyint(3) unsigned NOT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `medication_id` bigint(20) DEFAULT NULL,
  `factory_id` bigint(20) DEFAULT NULL,
  `pharmacy_id` bigint(20) DEFAULT NULL,
  `created_at_prescription` timestamp NULL DEFAULT NULL,
  `updated_at_prescription` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `quantity` int(11) DEFAULT '1',
  `order_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggested_orders`
--

LOCK TABLES `suggested_orders` WRITE;
/*!40000 ALTER TABLE `suggested_orders` DISABLE KEYS */;
INSERT INTO `suggested_orders` VALUES (19,1,'2020-05-17','2020-05-24',1,1,1,171,1,NULL,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-20 18:14:13',NULL,0,NULL,NULL),(20,2,'2020-12-05','2020-12-31',2,2,1,3,3,NULL,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-20 18:14:13',NULL,0,NULL,NULL),(21,3,'2020-02-01','2020-12-01',1,1,1,135,99,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-20 18:14:13',NULL,0,NULL,NULL),(22,1,'2020-05-17','2020-05-24',1,1,1,171,1,NULL,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-21 08:02:11',NULL,0,NULL,NULL),(23,2,'2020-12-05','2020-12-31',2,2,1,3,3,NULL,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-21 08:02:11',NULL,0,NULL,NULL),(24,3,'2020-02-01','2020-12-01',1,1,1,135,99,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-21 08:02:11',NULL,0,NULL,NULL),(25,1,'2020-05-17','2020-05-24',1,1,1,171,1,NULL,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-22 14:46:37',NULL,0,NULL,NULL),(26,2,'2020-12-05','2020-12-31',2,2,1,3,3,NULL,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-22 14:46:37',NULL,0,NULL,NULL),(27,3,'2020-02-01','2020-12-01',1,1,1,135,99,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-22 14:46:37',NULL,0,NULL,NULL),(28,1,'2020-05-17','2020-05-24',1,1,1,171,68,2,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-23 13:57:03','2020-05-22 21:00:00',0,NULL,NULL),(29,2,'2020-12-05','2020-12-31',2,2,1,3,3,2,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-23 13:57:03','2020-05-22 21:00:00',0,NULL,NULL),(30,3,'2020-02-01','2020-12-01',1,1,1,135,109,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-23 13:57:03','2020-05-22 21:00:00',0,NULL,NULL),(31,1,'2020-05-17','2020-05-24',1,1,1,171,1,6,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-23 21:00:00','2020-05-23 21:00:00',0,2,NULL),(32,2,'2020-12-05','2020-12-31',2,2,1,3,1,6,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-23 21:00:00','2020-05-23 21:00:00',0,3,NULL),(33,3,'2020-02-01','2020-12-01',1,1,1,135,99,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-23 21:00:00','2020-05-23 21:00:00',0,1,NULL),(34,1,'2020-05-17','2020-05-24',1,1,1,171,1,NULL,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-25 21:00:00','2020-05-25 21:00:00',0,1,NULL),(35,2,'2020-12-05','2020-12-31',2,2,1,3,3,NULL,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-25 21:00:00','2020-05-25 21:00:00',0,1,NULL),(36,3,'2020-02-01','2020-12-01',1,1,1,135,99,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-25 21:00:00','2020-05-25 21:00:00',0,1,NULL),(37,1,'2020-05-17','2020-05-24',1,1,1,171,1,NULL,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-26 21:00:00','2020-05-26 21:00:00',0,1,9),(38,2,'2020-12-05','2020-12-31',2,2,1,3,3,NULL,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-26 21:00:00','2020-05-26 21:00:00',0,1,8),(39,3,'2020-02-01','2020-12-01',1,1,1,135,99,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-26 21:00:00','2020-05-26 21:00:00',0,1,10),(40,1,'2020-05-17','2020-05-24',1,1,1,171,1,2,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-27 21:00:00','2020-05-27 21:00:00',2,1,12),(41,2,'2020-12-05','2020-12-31',2,2,1,3,3,2,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-27 21:00:00','2020-05-27 21:00:00',2,1,11),(42,3,'2020-02-01','2020-12-01',1,1,1,135,99,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-27 21:00:00','2020-05-27 21:00:00',2,1,13),(43,1,'2020-05-17','2020-05-24',1,1,1,171,1,NULL,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-28 21:00:00','2020-05-28 21:00:00',1,1,NULL),(44,2,'2020-12-05','2020-12-31',2,2,1,3,3,NULL,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-28 21:00:00','2020-05-28 21:00:00',1,1,NULL),(45,3,'2020-02-01','2020-12-01',1,1,1,135,99,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-28 21:00:00','2020-05-28 21:00:00',1,1,NULL),(46,1,'2020-05-17','2020-05-24',1,1,1,171,1,NULL,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-29 21:00:00','2020-05-29 21:00:00',1,1,NULL),(47,2,'2020-12-05','2020-12-31',2,2,1,3,3,NULL,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-29 21:00:00','2020-05-29 21:00:00',1,1,NULL),(48,3,'2020-02-01','2020-12-01',1,1,1,135,99,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-29 21:00:00','2020-05-29 21:00:00',1,1,NULL),(49,1,'2020-05-17','2020-05-24',1,1,1,171,1,NULL,3,'2020-05-10 03:18:00','2020-05-12 06:26:49','2020-05-30 21:00:00','2020-05-30 21:00:00',1,1,NULL),(50,2,'2020-12-05','2020-12-31',2,2,1,3,3,NULL,2,'2020-05-12 06:18:24','2020-05-12 06:18:24','2020-05-30 21:00:00','2020-05-30 21:00:00',2,1,14),(51,3,'2020-02-01','2020-12-01',1,1,1,135,99,3,3,'2020-05-12 19:52:00','2020-05-13 14:19:16','2020-05-30 21:00:00','2020-05-30 21:00:00',1,1,NULL);
/*!40000 ALTER TABLE `suggested_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES (1,'data_types','display_name_singular',5,'pt','Post','2020-03-17 03:23:46','2020-03-17 03:23:46'),(2,'data_types','display_name_singular',6,'pt','P├ígina','2020-03-17 03:23:46','2020-03-17 03:23:46'),(3,'data_types','display_name_singular',1,'pt','Utilizador','2020-03-17 03:23:46','2020-03-17 03:23:46'),(4,'data_types','display_name_singular',4,'pt','Categoria','2020-03-17 03:23:46','2020-03-17 03:23:46'),(5,'data_types','display_name_singular',2,'pt','Menu','2020-03-17 03:23:46','2020-03-17 03:23:46'),(6,'data_types','display_name_singular',3,'pt','Fun├º├úo','2020-03-17 03:23:46','2020-03-17 03:23:46'),(7,'data_types','display_name_plural',5,'pt','Posts','2020-03-17 03:23:46','2020-03-17 03:23:46'),(8,'data_types','display_name_plural',6,'pt','P├íginas','2020-03-17 03:23:46','2020-03-17 03:23:46'),(9,'data_types','display_name_plural',1,'pt','Utilizadores','2020-03-17 03:23:46','2020-03-17 03:23:46'),(10,'data_types','display_name_plural',4,'pt','Categorias','2020-03-17 03:23:46','2020-03-17 03:23:46'),(11,'data_types','display_name_plural',2,'pt','Menus','2020-03-17 03:23:46','2020-03-17 03:23:46'),(12,'data_types','display_name_plural',3,'pt','Fun├º├╡es','2020-03-17 03:23:46','2020-03-17 03:23:46'),(13,'categories','slug',1,'pt','categoria-1','2020-03-17 03:23:46','2020-03-17 03:23:46'),(14,'categories','name',1,'pt','Categoria 1','2020-03-17 03:23:46','2020-03-17 03:23:46'),(15,'categories','slug',2,'pt','categoria-2','2020-03-17 03:23:46','2020-03-17 03:23:46'),(16,'categories','name',2,'pt','Categoria 2','2020-03-17 03:23:46','2020-03-17 03:23:46'),(17,'pages','title',1,'pt','Ol├í Mundo','2020-03-17 03:23:46','2020-03-17 03:23:46'),(18,'pages','slug',1,'pt','ola-mundo','2020-03-17 03:23:46','2020-03-17 03:23:46'),(19,'pages','body',1,'pt','<p>Ol├í Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','2020-03-17 03:23:46','2020-03-17 03:23:46'),(20,'menu_items','title',1,'pt','Painel de Controle','2020-03-17 03:23:46','2020-03-17 03:23:46'),(21,'menu_items','title',2,'pt','Media','2020-03-17 03:23:46','2020-03-17 03:23:46'),(22,'menu_items','title',12,'pt','Publica├º├╡es','2020-03-17 03:23:46','2020-03-17 03:23:46'),(23,'menu_items','title',3,'pt','Utilizadores','2020-03-17 03:23:46','2020-03-17 03:23:46'),(24,'menu_items','title',11,'pt','Categorias','2020-03-17 03:23:46','2020-03-17 03:23:46'),(25,'menu_items','title',13,'pt','P├íginas','2020-03-17 03:23:46','2020-03-17 03:23:46'),(26,'menu_items','title',4,'pt','Fun├º├╡es','2020-03-17 03:23:46','2020-03-17 03:23:46'),(27,'menu_items','title',5,'pt','Ferramentas','2020-03-17 03:23:46','2020-03-17 03:23:46'),(28,'menu_items','title',6,'pt','Menus','2020-03-17 03:23:46','2020-03-17 03:23:46'),(29,'menu_items','title',7,'pt','Base de dados','2020-03-17 03:23:46','2020-03-17 03:23:46'),(30,'menu_items','title',10,'pt','Configura├º├╡es','2020-03-17 03:23:46','2020-03-17 03:23:46');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_user_id_index` (`user_id`),
  KEY `user_roles_role_id_index` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Admin','admin@admin.com','users/default.png',NULL,'$2y$10$nE47gyFihi1EfXvPGhxrq.OzABkzuGP4XNYkjY4JHTvmKtHdpxXv2','rKRKUTIg3WvRBPHqJvpGZkd6TV2O8nOHvHgCEqm6LCZ0LIs9Kzkk7EUhvV9Q',NULL,'2020-03-17 03:23:46','2020-03-17 03:23:46'),(2,4,'Elie Awwad','elieawad@yahoo.com','users/default.png',NULL,'$2y$10$6U2h6COP3kkw9cRsw7XqP.0Q2.z/.Ai01eEpW5t/YU.rApbZ5qWo.','OVtuVahHE3jw6UxxCuy0j7tadMxxKDYVmbnNY2sTu0EHvae5VJLf1dIM7Uxh','{\"locale\":\"en\"}','2020-03-20 05:22:38','2020-03-20 18:33:37');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-31 12:30:50

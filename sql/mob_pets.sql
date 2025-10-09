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
-- Table structure for table `mob_pets`
--

DROP TABLE IF EXISTS `mob_pets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_pets` (
  `mob_mobid` int(10) unsigned NOT NULL,
  `pet_offset` int(10) unsigned NOT NULL DEFAULT '1',
  `job` tinyint(4) DEFAULT '9',
  `mobname` varchar(24) DEFAULT NULL,
  `petname` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`mob_mobid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_pets`
--

LOCK TABLES `mob_pets` WRITE;
/*!40000 ALTER TABLE `mob_pets` DISABLE KEYS */;

-- ------------------------------------------------------------
-- AlTaieu (Zone 33)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (16912405,3,9,'Ulaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912406,1,14,'Ulaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912418,3,15,'Ulaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912473,10,9,'Omaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912474,7,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912475,7,15,'Omaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912519,1,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912528,3,9,'Omaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912529,1,15,'Omaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912571,2,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912572,2,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912588,5,15,'Omaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912609,5,9,'Omaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912666,1,9,'Omaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912673,1,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912712,1,15,'Omaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912724,1,9,'Omaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912726,1,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912747,1,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912762,1,15,'Omaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912839,1,9,'Jailer_of_Justice','Qnxzomit');

-- ------------------------------------------------------------
-- Grand_Palace_of_HuXzoi (Zone 34)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (16916568,1,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916578,1,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916586,4,9,'Eoaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16916598,1,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916617,1,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916625,2,9,'Eoaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16916626,2,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916639,1,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916644,3,9,'Eoaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16916736,1,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916745,1,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916760,2,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916761,2,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916793,2,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916794,2,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916805,1,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916809,3,9,'Eoaern','Aerns_Euvhi');

-- ------------------------------------------------------------
-- The_Garden_of_RuHmet (Zone 35)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (16920596,1,14,'Awaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16920606,1,9,'Awaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16920609,1,15,'Awaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16920648,1,15,'Awaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16920657,1,9,'Awaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16920662,1,14,'Awaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16920779,1,9,'Awaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16920783,1,14,'Awaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16920787,1,15,'Awaern','Aerns_Elemental');

-- ------------------------------------------------------------
-- Temenos (Zone 37)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (16928790,1,14,'Telchines_Dragoon','Telchiness_Wyvern');
INSERT INTO `mob_pets` VALUES (16928799,1,15,'Kindred_Summoner','Kindreds_Elemental');
INSERT INTO `mob_pets` VALUES (16928819,1,15,'Cryptonberry_Designator','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (16928823,1,15,'Cryptonberry_Designator','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (16928827,1,15,'Cryptonberry_Designator','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (16928988,1,15,'Koo_Buzu_the_Theomanic','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (16929007,1,15,'Pee_Qoho_the_Python','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (16929015,1,14,'Grognard_Impaler','Orcs_Wyvern');
INSERT INTO `mob_pets` VALUES (16929055,1,14,'Temenos_Aern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16929058,1,9,'Temenos_Aern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16929066,1,15,'Temenos_Aern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16929069,1,14,'Temenos_Aern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16929073,1,9,'Temenos_Aern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16929079,1,15,'Temenos_Aern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16929098,1,14,'Temenos_Aern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16929101,1,14,'Temenos_Aern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16929113,1,15,'Temenos_Aern','Aerns_Elemental');

-- ------------------------------------------------------------
-- Apollyon (Zone 38)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (16933135,1,14,'Grognard_Impaler','Orcs_Wyvern');
INSERT INTO `mob_pets` VALUES (16933144,1,15,'Dee_Wapa_the_Desolator','Yagudos_Elemental');

-- ------------------------------------------------------------
-- Ordelles_Caves (Zone 193)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17568091,1,9,'Goblin_Pathfinder','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17568096,1,9,'Goblin_Pathfinder','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17568111,1,9,'Goblin_Pathfinder','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17568116,1,9,'Goblin_Pathfinder','Goblins_Bats');

-- ------------------------------------------------------------
-- Maze_of_Shakhrami (Zone 198)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17588628,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17588633,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17588651,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17588656,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17588666,1,9,'Goblin_Pathfinder','Goblins_Bat');

-- ------------------------------------------------------------
-- Ifrits_Cauldron (Zone 205)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17616975,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617015,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617020,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617025,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617053,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617059,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617064,1,9,'Goblin_Shepherd','Goblins_Bats');

-- ------------------------------------------------------------
-- Gustav_Tunnel (Zone 212)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17645636,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17645638,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17645646,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17645648,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17645651,1,9,'Goblin_Shepherd','Goblins_Leech');

-- ------------------------------------------------------------
-- Labyrinth_of_Onzozo (Zone 213)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17649677,1,9,'Goblin_Trader','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17649832,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17649838,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17649843,1,9,'Goblin_Shepherd','Goblins_Leech');

-- ------------------------------------------------------------
-- Escha_RuAun (Zone 289)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17961000,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961006,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961008,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961010,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961021,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961030,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961032,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961043,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961057,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961068,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961078,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961082,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961092,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961102,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961232,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');
INSERT INTO `mob_pets` VALUES (17961243,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');
INSERT INTO `mob_pets` VALUES (17961253,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');
INSERT INTO `mob_pets` VALUES (17961257,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');
INSERT INTO `mob_pets` VALUES (17961267,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');
INSERT INTO `mob_pets` VALUES (17961277,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');

/*!40000 ALTER TABLE `mob_pets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

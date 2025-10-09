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
-- Castle_Zvahl_Keep_[S] (Zone 155)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17412224,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412234,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412246,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412256,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412258,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412267,1,15,'Demon_Condemner','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412274,1,15,'Demon_Condemner','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412277,1,15,'Adjudicator_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412286,1,15,'Adjudicator_Demon','Demons_Elemental');

-- ------------------------------------------------------------
-- Middle_Delkfutts_Tower (Zone 157)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17420294,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420299,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420304,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420309,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420316,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420321,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420327,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420330,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420335,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420355,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420360,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420367,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420372,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420379,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420385,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420390,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420395,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420400,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420405,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420410,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420420,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420423,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420428,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420433,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420440,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420445,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420450,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420455,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420460,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420465,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420472,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420477,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420487,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420492,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420499,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420504,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420513,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420518,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420527,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420529,1,9,'Ophion','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420535,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420540,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420547,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420552,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420559,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420564,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420597,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420602,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420607,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420612,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420615,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420620,1,9,'Goblin_Pathfinder','Goblins_Bat');

-- ------------------------------------------------------------
-- Upper_Delkfutts_Tower (Zone 158)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17424385,1,9,'Enkelados','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424388,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424393,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424400,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424407,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424414,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424423,1,9,'Enkelados','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424426,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424434,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424439,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424444,1,9,'Pallas','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424455,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424460,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424465,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424470,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424492,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424497,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424502,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424507,1,9,'Jotunn_Wildkeeper','Gigass_Bat');

-- ------------------------------------------------------------
-- Temple_of_Uggalepih (Zone 159)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17428505,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428515,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428528,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428543,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428552,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428556,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428559,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428562,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428570,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428589,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428596,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428601,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428608,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428611,1,15,'Sozu_Terberry','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428625,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428634,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428641,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428643,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428656,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428659,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428662,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428664,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428673,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428675,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428677,1,15,'Tonberry_Kinq','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428680,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428683,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428691,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428698,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428707,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428721,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428731,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428735,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428742,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428767,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428773,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428778,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428792,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428801,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428813,1,15,'Crimson-toothed_Pawberry','Tonberrys_Elemental');

-- ------------------------------------------------------------
-- Den_of_Rancor (Zone 160)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17432632,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432659,1,15,'Carmine-tailed_Janberry','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432723,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432789,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432799,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432802,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432820,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432822,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432851,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432857,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432861,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432868,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432915,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432924,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432936,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432957,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432961,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432965,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432981,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432985,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432987,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432999,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');

-- ------------------------------------------------------------
-- Castle_Zvahl_Baileys (Zone 161)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17436726,1,9,'Goblin_Trader','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17436735,1,9,'Goblin_Trader','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17436745,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436749,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436752,1,9,'Goblin_Trader','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17436761,1,9,'Goblin_Trader','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17436775,1,9,'Goblin_Trader','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17436837,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436847,1,15,'Demon_Magistrate','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436852,1,15,'Demon_Magistrate','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436857,1,15,'Demon_Magistrate','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436862,1,15,'Demon_Magistrate','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436867,1,15,'Demon_Magistrate','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436874,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436879,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436884,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436888,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436895,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436899,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436911,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436916,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436921,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436927,1,15,'Grand_Duke_Batym','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436946,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436951,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436956,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436962,1,15,'Stygian_Demon','Demons_Elemental');

-- ------------------------------------------------------------
-- Castle_Zvahl_Keep (Zone 162)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17440777,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440781,1,9,'Goblin_Trader','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17440786,1,9,'Goblin_Trader','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17440791,1,9,'Goblin_Trader','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17440796,1,9,'Goblin_Trader','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17440960,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440966,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440973,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440975,1,15,'Viscount_Morax','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440992,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440997,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17441005,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17441008,1,15,'Demon_Warlock','Demons_Elemental');

-- ------------------------------------------------------------
-- Sacrificial_Chamber (Zone 163)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17444867,1,15,'Tungsiton','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444872,1,15,'Tungsiton','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444877,1,15,'Tungsiton','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444883,2,15,'Vermilion-eared_Noberry','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444890,2,15,'Vermilion-eared_Noberry','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444897,2,15,'Vermilion-eared_Noberry','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444904,2,14,'Pevv_the_Riverleaper','Sahagins_Wyvern');
INSERT INTO `mob_pets` VALUES (17444910,2,14,'Pevv_the_Riverleaper','Sahagins_Wyvern');
INSERT INTO `mob_pets` VALUES (17444916,2,14,'Pevv_the_Riverleaper','Sahagins_Wyvern');

-- ------------------------------------------------------------
-- Garlaige_Citadel_[S] (Zone 164)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17449003,1,15,'Yagudo_Pythoness','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17449023,1,15,'Yagudo_Pythoness','Yagudos_Elemental');

-- ------------------------------------------------------------
-- Throne_Room (Zone 165)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17453078,2,15,'Duke_Dantalian','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17453085,2,15,'Duke_Dantalian','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17453092,2,15,'Duke_Dantalian','Demons_Elemental');

-- ------------------------------------------------------------
-- Ranguemont_Pass (Zone 166)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17457257,1,9,'Goblin_Chaser','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17457265,1,9,'Goblin_Chaser','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17457290,1,9,'Goblin_Chaser','Goblins_Bats');

-- ------------------------------------------------------------
-- Chamber_of_Oracles (Zone 168)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17465360,1,14,'Maat','Maats_Wyvern');
INSERT INTO `mob_pets` VALUES (17465362,1,14,'Maat','Maats_Wyvern');
INSERT INTO `mob_pets` VALUES (17465364,1,14,'Maat','Maats_Wyvern');

-- ------------------------------------------------------------
-- Korroloka_Tunnel (Zone 173)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17486169,1,9,'Gigas_Foreman','Gigass_Spider');
INSERT INTO `mob_pets` VALUES (17486175,1,9,'Gigas_Foreman','Gigass_Spider');
INSERT INTO `mob_pets` VALUES (17486180,1,9,'Gigas_Foreman','Gigass_Spider');
INSERT INTO `mob_pets` VALUES (17486185,1,9,'Gigas_Foreman','Gigass_Spider');

-- ------------------------------------------------------------
-- Kuftal_Tunnel (Zone 174)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17490151,1,9,'Goblin_Tamer','Goblins_Spider');
INSERT INTO `mob_pets` VALUES (17490156,1,9,'Goblin_Tamer','Goblins_Spider');
INSERT INTO `mob_pets` VALUES (17490164,1,9,'Goblin_Tamer','Goblins_Spider');
INSERT INTO `mob_pets` VALUES (17490171,1,9,'Goblin_Tamer','Goblins_Spider');
INSERT INTO `mob_pets` VALUES (17490180,1,9,'Goblin_Tamer','Goblins_Spider');

-- ------------------------------------------------------------
-- Sea_Serpent_Grotto (Zone 176)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17498356,1,14,'Mouu_the_Waverider','Sahagins_Wyvern');
INSERT INTO `mob_pets` VALUES (17498516,1,14,'Zuug_the_Shoreleaper','Sahagins_Wyvern');
INSERT INTO `mob_pets` VALUES (17498560,1,14,'Ocean_Sahagin','Sahagins_Wyvern');

-- ------------------------------------------------------------
-- The_Shrine_of_RuAvitau (Zone 178)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17506670,5,15,'Kirin','Kirins_Avatar');

-- ------------------------------------------------------------
-- LaLoff_Amphitheater (Zone 180)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Lower_Delkfutts_Tower (Zone 184)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17530884,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530889,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530898,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530903,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530935,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530940,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530952,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530957,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530965,1,9,'Gigas_Butcher','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17530970,1,9,'Gigas_Butcher','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17530989,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530994,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531002,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531007,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531022,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531046,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531062,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531067,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531082,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531087,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531101,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531114,1,9,'Eurymedon','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531118,1,9,'Giant_Sentry','Gigass_Bat');

-- ------------------------------------------------------------
-- Dynamis-San_dOria (Zone 185)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17534991,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17534994,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17534996,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535006,1,15,'Reapertongue_Gadgquok','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535010,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535014,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535028,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535032,1,14,'Wyrmgnasher_Bjakdek','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535042,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535049,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535066,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535072,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535074,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535076,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535094,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535096,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535110,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535149,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535152,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535161,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535164,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535173,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535179,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535181,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535191,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535203,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535208,1,9,'Steelshank_Kratzvatz','Kratzvatzs_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535211,1,14,'Spellspear_Djokvukk','Djokvukks_Wyvern');

-- ------------------------------------------------------------
-- Dynamis-Bastok (Zone 186)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17539076,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539088,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539098,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539105,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539110,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539112,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539143,1,15,'GuNhi_Noondozer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539164,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539166,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539177,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539197,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539199,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539209,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539211,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539213,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539222,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539237,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539239,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539247,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539249,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539272,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539284,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539291,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539308,1,15,'RaGho_Darkfount','RaGhos_Avatar');

-- ------------------------------------------------------------
-- Dynamis-Windurst (Zone 187)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17543186,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543192,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543196,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543203,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543216,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543229,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543235,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543237,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543239,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543241,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543256,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543266,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543272,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543274,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543286,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543294,1,15,'Haa_Pevi_the_Stentorian','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543299,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543310,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543332,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543337,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543339,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543351,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543360,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543367,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543385,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543406,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543415,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543424,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543431,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543442,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543444,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543459,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543464,1,15,'Xuu_Bhoqa_the_Enigma','Xuu_Bhoqas_Avatar');

-- ------------------------------------------------------------
-- Dynamis-Jeuno (Zone 188)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17547268,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547272,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547282,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547286,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547312,1,14,'Wyrmwix_Snakespecs','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547317,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547322,1,15,'Morgmox_Moldnoggin','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547327,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547332,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547337,1,15,'Morgmox_Moldnoggin','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547341,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547348,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547365,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547369,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547373,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547396,1,9,'Trailblix_Goatmug','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547426,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547428,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547436,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547438,1,15,'Mortilox_Wartpaws','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547443,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547450,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547452,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547454,1,9,'Rutrix_Hamgams','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547483,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547487,1,9,'Blazox_Boneybod','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547494,1,9,'Feralox_Honeylips','Feraloxs_Slime');
INSERT INTO `mob_pets` VALUES (17547496,1,14,'Scourquix_Scaleskin','Scourquixs_Wyvern');

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

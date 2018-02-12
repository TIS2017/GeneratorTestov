-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 03, 2018 at 04:36 PM
-- Server version: 5.5.58
-- PHP Version: 5.6.29-0+deb8u1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `michalik38`
--

-- --------------------------------------------------------

--
-- Table structure for table `keywords`
--

CREATE TABLE IF NOT EXISTS `keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'primarny kluc tabulky',
  `keyword` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tabulka ktora obsahuje klucove slova' AUTO_INCREMENT=13 ;

--
-- Dumping data for table `keywords`
--

INSERT INTO `keywords` (`id`, `keyword`) VALUES
(1, 'SVM'),
(2, 'HMM'),
(3, 'perceptron'),
(4, 'ICA'),
(5, 'filter'),
(6, 'PCA'),
(7, 'Bayes'),
(8, 'stromy'),
(9, 'validacia'),
(10, 'chyba'),
(11, 'vyber'),
(12, 'LDA');

-- --------------------------------------------------------

--
-- Table structure for table `keywords_questions`
--

CREATE TABLE IF NOT EXISTS `keywords_questions` (
  `keyword_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci;

--
-- Dumping data for table `keywords_questions`
--

INSERT INTO `keywords_questions` (`keyword_id`, `question_id`) VALUES
(1, 1),
(2, 2),
(6, 3),
(8, 4),
(10, 5),
(11, 5),
(12, 6),
(12, 4),
(13, 6),
(14, 6),
(15, 7),
(16, 8),
(17, 9),
(17, 10),
(18, 10),
(19, 10),
(20, 9),
(21, 6),
(21, 4),
(22, 6),
(22, 12),
(24, 10),
(25, 5),
(26, 7),
(27, 3),
(28, 8),
(29, 6),
(30, 11),
(31, 11),
(32, 11),
(33, 7),
(34, 8),
(35, 6),
(36, 6);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id otazky',
  `question` TEXT COLLATE utf8_bin NOT NULL COMMENT 'znenie otazky',
  `points` int(11) NOT NULL COMMENT 'pocet bodov',
  `practical` tinyint(1) NOT NULL COMMENT 'true - prakticka / false - nie prakticka',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=37 ;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `question`, `points`, `practical`) VALUES
(1, 'Popíšte SVM a postup jeho trénovania. Čo je to kernel a na čo slúži pri SVM?', 20, 0),
(2, 'Popíšte HMM a postup ich trénovania.', 20, 0),
(3, 'Popíšte metódy štrukturálneho (syntaktického) rozpoznávania a postup ich trénovania.', 20, 0),
(4, 'Popíšte dopredné neurónové siete so spätným šírením chyby a postup ich trénovania.', 20, 0),
(5, 'Popíšte samoorganizujúce sa mapy a postup ich trénovania.', 20, 0),
(6, 'Popíšte lineárny klasifikátor a postup jeho trénovania.', 20, 0),
(7, 'Popíšte detailne metódu FLDA.', 15, 0),
(8, 'Popíšte detailne metódu ICA.', 15, 0),
(9, 'Popíšte detailne metódu K najbližších susedov.', 15, 0),
(10, 'Aký je rozdiel medzi dvomi základnými prístupmi k znižovaniu dimenzie (wrapper a filter), aké hodnotiace miery sa pri nich používajú?', 15, 0),
(11, 'Aký je rozdiel medzi dvomi základnými prístupmi k znižovaniu dimenzie (wrapper a filter), aké postupy sa používajú pri výbere príznakov?', 15, 0),
(12, 'Popíšte detailne metódu PCA. Aký je rozdiel medzi PCA a ICA?', 15, 0),
(13, 'Popíšte detailne metódu PCA. Akým spôsobom ju používame pri znížení dimenzie?', 15, 0),
(14, 'Popíšte detailne metódu PCA. Akým spôsobom určujeme počet významých vlastných vektorov?', 15, 0),
(15, 'Popíšte detailne trénovanie Bayesovho klasifikátora. Čo vieme o chybe tohto klasifikátora?', 15, 0),
(16, 'Popíšte ako sa vytvárajú rozhodovacie stromy.', 15, 0),
(17, 'Popíšte metódy krížovej validácie a metódu bootstrap. Aký je medzi nimi hlavný rozdiel? Na čo slúžia?', 15, 0),
(18, 'Čo je matica zámen, ako sa vytvára? Na čo sa používa?', 10, 0),
(19, 'Čo je ROC krivka, ako sa vytvára? Na čo sa používa? Aké hodnoty z nej vieme zistiť?', 10, 0),
(20, 'Aké metódy používame pre voľbu trénovacej a testovacej množiny?', 10, 0),
(21, 'Aký je rozdiel medzi PCA a ICA?', 10, 0),
(22, 'Aký je rozdiel medzi PCA a LDA?', 10, 0),
(23, 'Akými spôsobmi normalizujeme príznaky?', 10, 0),
(24, 'Čo je to chybová funkcia klasifikátora? Ako sa odhaduje chyba klasifikátora? ', 10, 0),
(25, 'Na čo slúžia filter a wrapper? Aký je medzi nimi rozdiel?', 10, 0),
(26, 'Popíšte klasifikáciu pomocou Bayesovho klasifikátora.', 10, 0),
(27, 'Popíšte klasifikáciu pomocou lineárneho klasifikátora.', 10, 0),
(28, 'Popíšte klasifikáciu pomocou rozhodovacích stromov.', 10, 0),
(29, 'Popíšte metódu SVD. Na čo slúži?', 10, 0),
(30, 'Popíšte miery používané na ohodnotenie príznakov.', 10, 0),
(31, 'Zadefinujte pojmy entropia a vzájomná informácia. Na čo sa používajú pri výbere príznakov?', 10, 0),
(32, 'Zadefinujte pojmy štatistická závislosť a konzistencia. Na čo sa používajú pri výbere príznakov?', 10, 0),
(33, 'Pomocou naivného Bayesovho klasifikátora určite, či bude hrať zápas, keď svieti slnko, je chladno, vysoká vlhkosť vzduch a silný vietor. Na určenie pravdepodobností vychádzajte z nasledovnej tabuľky.', 0, 1),
(34, 'Vytvorte rozhodovací strom. Pre výber príznakov do uzlov použite vzájomnú informáciu. Z vytvoreného stromu určite, či študent pôjde do školy, ak vstane neskoro, nemá prednášku RO a prší.', 0, 1),
(35, 'Preveďte dáta z nasledujúceho obrázku do 1D priestoru pomocou PCA. \n1.	Vypočítajte kovariančnú maticu, napíšte ako získate vlastné čísla. \n2.	Predpokladajte, že vlastné čísla sú 0,48 a 2,71. Vektory k nim prislúchajúce sú (0,78 ; -0,63) a (0,63 ; 0,78). \n', 0, 1),
(36, 'Preveďte dáta z nasledujúceho obrázku do 1D priestoru pomocou PCA. \n1.	Vypočítajte kovariančnú maticu, napíšte ako získate vlastné čísla. \n2.	Predpokladajte, že vlastné čísla sú 0,3 a 2,7. Vektory k nim prislúchajúce sú (-0,74 ; 0,68) a (0,68 ; 0,74). Zak', 0, 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

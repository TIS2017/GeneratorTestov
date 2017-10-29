-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u8
-- http://www.phpmyadmin.net
--
-- Hostiteľ: localhost
-- Vygenerované: Ned 29.Okt 2017, 17:32
-- Verzia serveru: 5.5.53
-- Verzia PHP: 5.6.29-0+deb8u1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáza: `michalik38`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `key_words`
--

CREATE TABLE IF NOT EXISTS `key_words` (
  `words` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'klucove slova k otazkam',
  `question_id` int(11) NOT NULL COMMENT 'cudzi kluc odkazujuci na otazku v tabulke questions',
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `pictures`
--

CREATE TABLE IF NOT EXISTS `pictures` (
  `picture` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'obrazok zakomentovany base64',
  `question_id` int(11) NOT NULL COMMENT 'cudzi kluc odkazujuci na otazku v tabulke questions',
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id otazky',
  `question` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'znenie otazky',
  `points` int(11) NOT NULL COMMENT 'pocet bodov',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=6 ;

--
-- Sťahujem dáta pre tabuľku `questions`
--

INSERT INTO `questions` (`id`, `question`, `points`) VALUES
(1, 'Matica opakovaných výskytov. Ako sa tvorí a aké informácie sa z nej dajú odvodiť?', 5),
(2, 'Popíšte Harrisov detektor rohov. Voči ktorým transformáciám ja a nie je invariantný. Prečo?', 10),
(3, 'Popíšte Houghovu transformáciu pre priamky ľubovoľného smeru.', 10),
(4, 'Popíšte metódu SIFT (detektor a deskriptor).', 10),
(5, 'Popíšte Ittiho model vizuálnej pozornosti.', 15);

--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `key_words`
--
ALTER TABLE `key_words`
  ADD CONSTRAINT `key_words_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Obmedzenie pre tabuľku `pictures`
--
ALTER TABLE `pictures`
  ADD CONSTRAINT `pictures_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

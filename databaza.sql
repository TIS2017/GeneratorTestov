-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u8
-- http://www.phpmyadmin.net
--
-- Hostiteľ: localhost
-- Vygenerované: Út 12.Dec 2017, 14:05
-- Verzia serveru: 5.5.58
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
-- Štruktúra tabuľky pre tabuľku `keywords`
--

CREATE TABLE IF NOT EXISTS `keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'primarny kluc tabulky',
  `word` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tabulka ktora obsahuje klucove slova' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `keywords_questions`
--

CREATE TABLE IF NOT EXISTS `keywords_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_keyword_id` (`keyword_id`),
  KEY `fk_question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id otazky',
  `question` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'znenie otazky',
  `points` int(11) NOT NULL COMMENT 'pocet bodov',
  `practical` tinyint(1) NOT NULL COMMENT 'true - prakticka / false - nie prakticka',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=7 ;

--
-- Sťahujem dáta pre tabuľku `questions`
--

INSERT INTO `questions` (`id`, `question`, `points`, `practical`) VALUES
(1, 'Matica opakovaných výskytov. Ako sa tvorí a aké informácie sa z nej dajú odvodiť?', 5, 0),
(2, 'Popíšte Harrisov detektor rohov. Voči ktorým transformáciám ja a nie je invariantný. Prečo?', 10, 0),
(3, 'Popíšte Houghovu transformáciu pre priamky ľubovoľného smeru.', 10, 0),
(4, 'Popíšte metódu SIFT (detektor a deskriptor).', 10, 0),
(5, 'Popíšte Ittiho model vizuálnej pozornosti.', 15, 0),
(6, 'a) Vyznačtete 8-susednú hranicu oblasti na obrázku A. Napíšte jej reťazcový (Freemanov) kód, začínajúci vo vyznačenom bode, ktorý postupuje v smere hodinových ručičiek. Susedov označujte podľa obrázka B.\r\nb) Cyklicky posuňte kód tak, aby vzniklo najmenš', 10, 0);

--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `keywords_questions`
--
ALTER TABLE `keywords_questions`
  ADD CONSTRAINT `fk_questions_id` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  ADD CONSTRAINT `fk_keyword_id` FOREIGN KEY (`keyword_id`) REFERENCES `keywords` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

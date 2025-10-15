-- phpMyAdmin SQL Dump
-- version 3.5.7
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Окт 22 2014 г., 08:24
-- Версия сервера: 5.5.28-log
-- Версия PHP: 5.3.22

SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES cp1251 */;

--
-- База данных: `ubiquiti`
--

-- --------------------------------------------------------

--
-- Структура таблицы `statss`
--

CREATE TABLE IF NOT EXISTS `statss` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_modem` int(10) unsigned NOT NULL DEFAULT '0',
  `mac_ap` char(20) NOT NULL DEFAULT '',
  `signal_level` tinyint(4) NOT NULL DEFAULT '0',
  `date` date NOT NULL DEFAULT '0000-00-00',
  `time` time NOT NULL DEFAULT '00:00:00',
  `status` smallint(6) NOT NULL DEFAULT '0',
  `num_sats` smallint(6) NOT NULL DEFAULT '0',
  `x` smallint(6) DEFAULT '0',
  `y` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mac_ap` (`mac_ap`),
  KEY `status` (`status`),
  KEY `num_sats` (`num_sats`),
  KEY `date` (`date`),
  KEY `x` (`x`),
  KEY `date_idmodem` (`date`,`id_modem`,`time`)
) TYPE=MyISAM;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

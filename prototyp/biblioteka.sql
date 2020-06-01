-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 01 Cze 2020, 22:17
-- Wersja serwera: 10.4.11-MariaDB
-- Wersja PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `biblioteka`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `adresy`
--

CREATE TABLE `adresy` (
  `id` int(11) NOT NULL,
  `ulica` varchar(50) COLLATE utf8mb4_polish_ci NOT NULL,
  `miasto` varchar(30) COLLATE utf8mb4_polish_ci NOT NULL,
  `kod_pocztowy` varchar(6) COLLATE utf8mb4_polish_ci NOT NULL,
  `nr_domu` varchar(4) COLLATE utf8mb4_polish_ci NOT NULL,
  `nr_mieszkania` int(4) DEFAULT NULL,
  `id_osoby` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `autorzy`
--

CREATE TABLE `autorzy` (
  `id` int(10) NOT NULL,
  `imie` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` varchar(50) COLLATE utf8_polish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `autorzy`
--

INSERT INTO `autorzy` (`id`, `imie`, `nazwisko`) VALUES
(1, 'J.k.', 'Rowling'),
(2, 'Bolesław', 'Prus'),
(3, 'Jędrzej', 'Pasierski'),
(4, 'Juliusz', 'Słowacki'),
(5, 'Jan ', 'Brzechwa'),
(6, 'Tove', 'Jansson'),
(7, 'Michelle ', 'Richmond'),
(8, 'Albert ', 'Camus'),
(9, 'Katarzyna', 'Bonda'),
(10, 'Bogdan', 'Lach'),
(11, 'Artur', 'Wells'),
(12, 'John ronald reuel', 'Tolkien ');

--
-- Wyzwalacze `autorzy`
--
DELIMITER $$
CREATE TRIGGER `imie_autor` BEFORE INSERT ON `autorzy` FOR EACH ROW SET NEW.imie = CONCAT(UPPER(SUBSTRING(NEW.imie,1,1)),LOWER(SUBSTRING(NEW.imie,2)))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `nazwisko_autor` BEFORE INSERT ON `autorzy` FOR EACH ROW SET NEW.nazwisko = CONCAT(UPPER(SUBSTRING(NEW.nazwisko,1,1)),LOWER(SUBSTRING(NEW.nazwisko,2)))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `egzemplarze`
--

CREATE TABLE `egzemplarze` (
  `id` int(10) NOT NULL,
  `pozycja_id` bigint(13) NOT NULL,
  `statusy_id` int(11) NOT NULL,
  `id_filii` int(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `egzemplarze`
--

INSERT INTO `egzemplarze` (`id`, `pozycja_id`, `statusy_id`, `id_filii`) VALUES
(1, 9788380082113, 1, NULL),
(2, 9788380082113, 1, NULL),
(3, 9788380082113, 1, NULL),
(4, 9780807282069, 3, NULL),
(5, 9781858660653, 3, NULL),
(6, 9788377381694, 1, NULL),
(7, 9788380497894, 1, NULL),
(8, 9788380497894, 1, NULL),
(9, 9788310129611, 1, NULL),
(10, 9788310129611, 1, NULL),
(11, 9788310135940, 1, NULL),
(12, 9788375154597, 1, NULL),
(13, 9788375154597, 1, NULL),
(14, 9788379004720, 1, NULL),
(15, 9788324403875, 1, NULL),
(16, 9788306033779, 1, NULL),
(17, 9788328714267, 1, NULL),
(18, 9788324403875, 1, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `filie`
--

CREATE TABLE `filie` (
  `id` int(10) NOT NULL,
  `nr_kontaktowy` int(9) NOT NULL,
  `godzina_otwarcia` time NOT NULL,
  `godzina_zamkniecia` time NOT NULL,
  `id_adresu` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kary`
--

CREATE TABLE `kary` (
  `id` int(10) NOT NULL,
  `kwota` float NOT NULL,
  `id_wypozyczenia` int(10) NOT NULL,
  `id_statusu` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kategorie`
--

CREATE TABLE `kategorie` (
  `nazwa` varchar(50) COLLATE utf8_polish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `kategorie`
--

INSERT INTO `kategorie` (`nazwa`) VALUES
('dla dzieci'),
('fantasy'),
('kryminal'),
('lektury'),
('powiesc');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `osoby`
--

CREATE TABLE `osoby` (
  `id` int(11) NOT NULL,
  `imie` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `pesel` bigint(11) NOT NULL,
  `email` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `login` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `haslo` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `nr_tel` int(9) DEFAULT NULL,
  `id_filii` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `osoby`
--

INSERT INTO `osoby` (`id`, `imie`, `nazwisko`, `pesel`, `email`, `login`, `haslo`, `nr_tel`, `id_filii`) VALUES
(1, 'Adam', 'Kowalski', 98100312435, 'adam@gmail.com', 'adam123', 'lama123', 534783125, NULL),
(2, 'Marek', 'Nowak', 76031718641, 'marek@gmail.com', 'marek123', 'parasol77', 793746332, NULL),
(3, 'Anna', 'Lewandowska', 83052509626, 'anna@gmail.com', 'ania532', 'super1', 723090447, NULL);

--
-- Wyzwalacze `osoby`
--
DELIMITER $$
CREATE TRIGGER `imie` BEFORE INSERT ON `osoby` FOR EACH ROW SET NEW.imie = CONCAT(UPPER(SUBSTRING(NEW.imie,1,1)),LOWER(SUBSTRING(NEW.imie,2)))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `nazwisko` BEFORE INSERT ON `osoby` FOR EACH ROW SET NEW.nazwisko = CONCAT(UPPER(SUBSTRING(NEW.nazwisko,1,1)),LOWER(SUBSTRING(NEW.nazwisko,2)))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `osoby_role`
--

CREATE TABLE `osoby_role` (
  `id_osoby` int(10) NOT NULL,
  `id_roli` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pozycje`
--

CREATE TABLE `pozycje` (
  `ISBN` bigint(13) NOT NULL,
  `tytul` varchar(75) COLLATE utf8_polish_ci NOT NULL,
  `opis` varchar(255) COLLATE utf8_polish_ci DEFAULT NULL,
  `rok_wydania` int(4) NOT NULL,
  `ilosc_stron` int(10) NOT NULL,
  `id_wydawnictwo` int(11) NOT NULL,
  `rodzaj` varchar(50) COLLATE utf8_polish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `pozycje`
--

INSERT INTO `pozycje` (`ISBN`, `tytul`, `opis`, `rok_wydania`, `ilosc_stron`, `id_wydawnictwo`, `rodzaj`) VALUES
(9788380082113, 'Harry Potter i Kamień Filozoficzny', NULL, 2016, 328, 1, 'książka'),
(9780807282069, 'Harry Potter i Komnata Tajemnic', NULL, 2016, 358, 1, 'książka'),
(9781858660653, 'Lalka', NULL, 1980, 701, 2, 'książka'),
(9788380497894, 'Roztopy', NULL, 2019, 336, 3, 'książka'),
(9788377381694, 'Balladyna', NULL, 2011, 244, 4, 'książka'),
(9788310135940, 'Tatuś Muminka i morze', NULL, 2020, 256, 5, 'książka'),
(9788310129611, 'Brzechwa dzieciom. Dzieła wszystkie.', NULL, 2016, 336, 5, 'książka'),
(9788375154597, 'I że cię nie opuszczę', NULL, 2018, 488, 6, 'książka'),
(9788306033779, 'Dżuma', NULL, 2017, 304, 7, 'książka'),
(9788328714267, 'Motyw ukryty. Z archiwym profilera', NULL, 2020, 448, 8, 'książka'),
(9788379004720, 'Sen henny', NULL, 2016, 273, 9, 'książka'),
(9788324403875, 'Hobbit', NULL, 2014, 320, 10, 'książka');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pozycje_autorzy`
--

CREATE TABLE `pozycje_autorzy` (
  `autor` int(11) NOT NULL,
  `ISBN` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `pozycje_autorzy`
--

INSERT INTO `pozycje_autorzy` (`autor`, `ISBN`) VALUES
(1, 9780807282069),
(1, 9788380082113),
(2, 9781858660653),
(3, 9788380497894),
(4, 9788377381694),
(5, 9788310129611),
(6, 9788310135940),
(7, 9788375154597),
(8, 9788306033779),
(9, 9788328714267);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pozycje_kategorie`
--

CREATE TABLE `pozycje_kategorie` (
  `ISBN` bigint(11) DEFAULT NULL,
  `kategoria` varchar(50) COLLATE utf8mb4_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `pozycje_kategorie`
--

INSERT INTO `pozycje_kategorie` (`ISBN`, `kategoria`) VALUES
(9780807282069, 'fantasy'),
(9781858660653, 'lektury'),
(9781858660653, 'powiesc'),
(9788306033779, 'lektury'),
(9788306033779, 'powiesc'),
(9788310129611, 'dla dzieci'),
(9788310135940, 'dla dzieci'),
(9788324403875, 'fantasy'),
(9788328714267, 'kryminal'),
(9788375154597, 'kryminal'),
(9788375154597, 'powiesc'),
(9788377381694, 'lektury'),
(9788379004720, 'fantasy'),
(9788380082113, 'fantasy'),
(9788380497894, 'kryminal');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `przedluzenia`
--

CREATE TABLE `przedluzenia` (
  `id` int(11) NOT NULL,
  `data_przedluzenia` date NOT NULL,
  `id_wypozyczenia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rezerwacje`
--

CREATE TABLE `rezerwacje` (
  `id` int(10) NOT NULL,
  `data_odbioru` date DEFAULT NULL,
  `data_rezerwacji` date NOT NULL,
  `id_osoba` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_egzemplarza` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `rezerwacje`
--

INSERT INTO `rezerwacje` (`id`, `data_odbioru`, `data_rezerwacji`, `id_osoba`, `id_status`, `id_egzemplarza`) VALUES
(174, '2020-06-03', '2020-05-31', 1, 10, 4),
(173, '2020-06-03', '2020-05-31', 1, 10, 4),
(179, '2020-06-03', '2020-05-31', 1, 10, 5),
(178, '2020-06-03', '2020-05-31', 1, 10, 4),
(177, '2020-06-03', '2020-05-31', 1, 10, 4),
(176, '2020-06-03', '2020-05-31', 1, 10, 4),
(175, '2020-06-03', '2020-05-31', 1, 10, 4),
(172, '2020-06-03', '2020-05-31', 1, 10, 4),
(171, '2020-06-03', '2020-05-31', 1, 10, 11),
(170, '2020-06-03', '2020-05-31', 1, 10, 4),
(169, '2020-06-03', '2020-05-31', 1, 10, 9),
(168, '2020-06-03', '2020-05-31', 1, 10, 5),
(167, '2020-06-03', '2020-05-31', 1, 10, 9),
(166, '2020-06-03', '2020-05-31', 1, 10, 10),
(165, '2020-06-03', '2020-05-31', 1, 10, 4),
(180, '2020-06-03', '2020-05-31', 1, 10, 4),
(181, '2020-06-03', '2020-05-31', 1, 10, 4),
(182, '2020-06-03', '2020-05-31', 1, 10, 5),
(183, '2020-06-03', '2020-05-31', 1, 8, 4),
(184, '2020-06-03', '2020-05-31', 1, 8, 5),
(185, '2020-06-03', '2020-05-31', 1, 8, 4);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rodzaje`
--

CREATE TABLE `rodzaje` (
  `nazwa` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `czas_na_oddanie` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `rodzaje`
--

INSERT INTO `rodzaje` (`nazwa`, `czas_na_oddanie`) VALUES
('książka', 90),
('czasopismo', 14);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `role`
--

CREATE TABLE `role` (
  `id` int(10) NOT NULL,
  `nazwa` varchar(30) COLLATE utf8mb4_polish_ci NOT NULL,
  `opis` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `role_uprawnienia`
--

CREATE TABLE `role_uprawnienia` (
  `role_id` int(10) NOT NULL,
  `uprawnienia_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `statusy`
--

CREATE TABLE `statusy` (
  `id` int(10) NOT NULL,
  `nazwa` varchar(25) COLLATE utf8_polish_ci NOT NULL,
  `kategoria` varchar(25) COLLATE utf8_polish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `statusy`
--

INSERT INTO `statusy` (`id`, `nazwa`, `kategoria`) VALUES
(1, 'dostepny', 'pozycja'),
(7, 'niepotwierdzony', 'rezerwacja'),
(3, 'zarezerwowany', 'pozycja'),
(4, 'wypożyczony', 'pozycja'),
(5, 'wycofany', 'pozycja'),
(6, 'w transporcie', 'pozycja'),
(8, 'potwierdzony', 'rezerwacja'),
(9, 'zrealizowany', 'rezerwacja'),
(10, 'anulowany', 'rezerwacja');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uprawnienia`
--

CREATE TABLE `uprawnienia` (
  `id` int(10) NOT NULL,
  `nazwa` varchar(30) COLLATE utf8mb4_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wydawnictwa`
--

CREATE TABLE `wydawnictwa` (
  `id` int(10) NOT NULL,
  `nazwa` varchar(50) COLLATE utf8_polish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `wydawnictwa`
--

INSERT INTO `wydawnictwa` (`id`, `nazwa`) VALUES
(1, 'Media Rodzina'),
(2, 'Nakład Gebethnera i Wolffa'),
(3, 'Ze Strachem'),
(4, 'BOOKS'),
(5, 'Nasza Księgarnia'),
(6, 'Otwarte'),
(7, 'Państwowy Instytut Wydawniczy'),
(8, 'Wydawnictwo MUZA S.A.'),
(9, 'Psychoskok'),
(10, 'Wydawnictwo Iskry');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wypozyczenia`
--

CREATE TABLE `wypozyczenia` (
  `id` int(10) NOT NULL,
  `data_wypozyczenia` date NOT NULL,
  `data_oddania` date DEFAULT NULL,
  `id_osoby` int(10) NOT NULL,
  `id_rezerwacji` int(10) DEFAULT NULL,
  `id_egzemplarza` int(10) NOT NULL,
  `id_statusu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `adresy`
--
ALTER TABLE `adresy`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `autorzy`
--
ALTER TABLE `autorzy`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `egzemplarze`
--
ALTER TABLE `egzemplarze`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `filie`
--
ALTER TABLE `filie`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `kary`
--
ALTER TABLE `kary`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `kategorie`
--
ALTER TABLE `kategorie`
  ADD PRIMARY KEY (`nazwa`);

--
-- Indeksy dla tabeli `osoby`
--
ALTER TABLE `osoby`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE` (`pesel`,`login`,`email`) USING BTREE;

--
-- Indeksy dla tabeli `osoby_role`
--
ALTER TABLE `osoby_role`
  ADD UNIQUE KEY `id_osoby` (`id_osoby`,`id_roli`);

--
-- Indeksy dla tabeli `pozycje`
--
ALTER TABLE `pozycje`
  ADD PRIMARY KEY (`ISBN`);

--
-- Indeksy dla tabeli `pozycje_autorzy`
--
ALTER TABLE `pozycje_autorzy`
  ADD UNIQUE KEY `id_autor` (`autor`,`ISBN`);

--
-- Indeksy dla tabeli `pozycje_kategorie`
--
ALTER TABLE `pozycje_kategorie`
  ADD UNIQUE KEY `ISBN` (`ISBN`,`kategoria`);

--
-- Indeksy dla tabeli `przedluzenia`
--
ALTER TABLE `przedluzenia`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `rezerwacje`
--
ALTER TABLE `rezerwacje`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `rodzaje`
--
ALTER TABLE `rodzaje`
  ADD PRIMARY KEY (`nazwa`);

--
-- Indeksy dla tabeli `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nazwa` (`nazwa`);

--
-- Indeksy dla tabeli `role_uprawnienia`
--
ALTER TABLE `role_uprawnienia`
  ADD UNIQUE KEY `role_id` (`role_id`,`uprawnienia_id`);

--
-- Indeksy dla tabeli `statusy`
--
ALTER TABLE `statusy`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `uprawnienia`
--
ALTER TABLE `uprawnienia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nazwa` (`nazwa`);

--
-- Indeksy dla tabeli `wydawnictwa`
--
ALTER TABLE `wydawnictwa`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `adresy`
--
ALTER TABLE `adresy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `autorzy`
--
ALTER TABLE `autorzy`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT dla tabeli `egzemplarze`
--
ALTER TABLE `egzemplarze`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT dla tabeli `filie`
--
ALTER TABLE `filie`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `kary`
--
ALTER TABLE `kary`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `osoby`
--
ALTER TABLE `osoby`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `przedluzenia`
--
ALTER TABLE `przedluzenia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `rezerwacje`
--
ALTER TABLE `rezerwacje`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT dla tabeli `role`
--
ALTER TABLE `role`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `statusy`
--
ALTER TABLE `statusy`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT dla tabeli `uprawnienia`
--
ALTER TABLE `uprawnienia`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `wydawnictwa`
--
ALTER TABLE `wydawnictwa`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT dla tabeli `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

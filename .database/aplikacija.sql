/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `aplikacija`;
CREATE DATABASE IF NOT EXISTS `aplikacija` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `aplikacija`;

DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `password_hash` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `uq_administrator_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `administrator`;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'petar', '57586EC40DC5890993ADAEBD8684399A6AB999F9430E3FF3AB9C3E554B334499533A1B07B4737843F509CAE63977B7EE4637EE2F2C7CF0E856DAD71EFD88A273'),
	(2, 'pavle', 'pakson123'),
	(3, 'admin123', '7FCF4BA391C48784EDDE599889D6E3F1E47A27DB36ECC050CC92F259BFAC38AFAD2C68A1AE804D77075E8FB722503F3ECA2B2C1006EE6F6C7B7628CB45FFFD1D'),
	(8, 'pero', '7578B7AA0B7ED99396145F9A7B4048C177EBE356C90890817178D3A9B9DFBAE0E8EFDFF45D34516BC40C7E9054D8CCEB6860BD92EF378871C3D2150987D8DEF0');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

DROP TABLE IF EXISTS `administrator_token`;
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` text COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_valid` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`administrator_token_id`),
  KEY `fk_administrator_token_administrator_id` (`administrator_id`),
  CONSTRAINT `fk_administrator_token_administrator_id` FOREIGN KEY (`administrator_id`) REFERENCES `administrator` (`administrator_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `administrator_token`;
/*!40000 ALTER TABLE `administrator_token` DISABLE KEYS */;
INSERT INTO `administrator_token` (`administrator_token_id`, `administrator_id`, `created_at`, `token`, `expires_at`, `is_valid`) VALUES
	(1, 3, '2021-05-03 20:06:31', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIyNzQzNTkxLjI1NiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMDY1MTkxfQ.0Ns7gkkHuJc_jMghsNYIiPTKnTn7-ow-pz5PMEYVeXs', '2021-06-03 18:06:31', 1),
	(2, 3, '2021-05-03 20:20:46', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIyNzQ0NDQ2Ljk0MywiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMDY2MDQ2fQ.kfudcbfpxO049idQ2myFyig8r6yrM89hkL__zKyaBHM', '2021-06-03 18:20:46', 1),
	(3, 3, '2021-05-03 20:22:21', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIyNzQ0NTQxLjcwOSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMDY2MTQxfQ.7Yn_H7wWSQevboC0oN3-_XTl9C_y-20Nn_f2ZMOk7ug', '2021-06-03 18:22:21', 1),
	(4, 3, '2021-05-03 20:22:56', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIyNzQ0NTc2LjkzLCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuOTMgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNTEiLCJpYXQiOjE2MjAwNjYxNzZ9.M1YKo1M1mffPkjbM_aKZ4gsmZ5dw_6rJxBYkAbug3Yg', '2021-06-03 18:22:56', 1),
	(5, 3, '2021-05-03 20:54:31', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIyNzQ2NDcxLjA5MiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMDY4MDcxfQ.I6pGHRqz2E5RbwHyMKDnKhxkgiDwyK-lYyg9iOsE9cM', '2021-06-03 18:54:31', 1),
	(6, 3, '2021-05-04 13:38:39', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIyODA2NzE5LjMzMywiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMTI4MzE5fQ.rZPchNUGE8pOS-lx-jqU1b7v1DFibw1Z7fGdPENb8O8', '2021-06-04 11:38:39', 1),
	(7, 3, '2021-05-04 13:39:17', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIyODA2NzU3Ljc5MSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMTI4MzU3fQ._tilKjLMeVJOS-UwHphF9AsbofsbjQMKjcv6BFul-60', '2021-06-04 11:39:17', 1),
	(8, 3, '2021-05-04 13:43:10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIyODA2OTkwLjU1MywiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMTI4NTkwfQ.bn-xrrH-LV609U-3-Eh_uM8O0nowC4wNcI-1KhAoTQg', '2021-06-04 11:43:10', 1),
	(9, 3, '2021-05-04 13:44:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIyODA3MDU2Ljg0NCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMTI4NjU2fQ.BAxTre93rceWEQUYpn0HZUlNEgRbK60VIlOLtciIfBI', '2021-06-04 11:44:16', 1),
	(10, 3, '2021-05-05 14:50:52', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIyODk3NDUyLjI3NCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJQb3N0bWFuUnVudGltZS83LjI4LjAiLCJpYXQiOjE2MjAyMTkwNTJ9.Vr4krp9UzfGV6VTdGp7ijiTsW27dm_gc4U-sWTu7ZNM', '2021-06-05 12:50:52', 1),
	(11, 3, '2021-05-07 13:24:28', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIzMDY1MDY4LjQ4MiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMzg2NjY4fQ.t8FmOm_Gj6AFNACrwKAaBJBBtEX7fng_GW8cJW6OZag', '2021-06-07 11:24:28', 1),
	(12, 3, '2021-05-08 13:06:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIzMTUwMzY5LjU5OSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNDcxOTY5fQ.8eCKm9UkS8wDKTsGrHRxg3yOBvBpFxglGGR5F0D9zr4', '2021-06-08 11:06:09', 1),
	(13, 3, '2021-05-08 14:12:50', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIzMTU0MzcwLjY5OSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNDc1OTcwfQ.q_TlyOysk1WbMeOTBk3qMqAbik5NcqfRQ7_diVsv0h4', '2021-06-08 12:12:50', 1),
	(14, 3, '2021-05-09 11:57:58', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIzMjMyNjc4LjQwNSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNTU0Mjc4fQ.whvVRIHVCbFEsaY4tVYaroX2kZu9tDbboI4hK4cVdHA', '2021-06-09 09:57:58', 1),
	(15, 3, '2021-05-09 13:19:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIzMjM3NTc3LjMwOCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNTU5MTc3fQ.KpocyquRs6PxLu837oWkcODwVga4nbQwZkV_Uvy0rBY', '2021-06-09 11:19:37', 1),
	(16, 3, '2021-05-09 15:19:25', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIzMjQ0NzY1LjkzOSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNTY2MzY1fQ.WAyFIloqGE3D60kvrOCO79SJG-_V4j_z0I4RKq0UOLM', '2021-06-09 13:19:25', 1),
	(17, 3, '2021-05-09 15:37:50', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIzMjQ1ODcwLjQxMywiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJQb3N0bWFuUnVudGltZS83LjI4LjAiLCJpYXQiOjE2MjA1Njc0NzB9.AmFJBvrO4FQ0agymPiukBxF0v664nBV11BcknXONywU', '2021-06-09 13:37:50', 1),
	(18, 3, '2021-05-10 10:35:50', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIzMzE0MTUwLjgzOSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNjM1NzUwfQ._cLJJBRXGJlFFFjdxaoh8bwA5BDMOE5OQzMBxcjGYcg', '2021-06-10 08:35:50', 1),
	(19, 3, '2021-05-10 15:09:43', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIzMzMwNTgzLjQ2NSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNjUyMTgzfQ.yhLtR13C1Ruhcg9wKSjRc1UDSt7BHFZRfI1vtU2M5C4', '2021-06-10 13:09:43', 1),
	(20, 3, '2021-05-10 15:28:57', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6ImFkbWluaXN0cmF0b3IiLCJpZGVudGl0eSI6ImFkbWluMTIzIiwiZXh0IjoxNjIzMzMxNzM3LjA5NSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNjUzMzM3fQ.QxDQQjsos4TPj_Iu62-w0QUOX3pY70lz9PvKl6PrYgE', '2021-06-10 13:28:57', 1);
/*!40000 ALTER TABLE `administrator_token` ENABLE KEYS */;

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `excerpt` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('available','visible','hidden') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'available',
  `is_promoted` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `article`;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`article_id`, `name`, `category_id`, `excerpt`, `description`, `status`, `is_promoted`, `created_at`) VALUES
	(1, 'GAMING PC Aquarius 14', 3, 'Gaming računar', 'detaljan opis2...detaljan opis2...detadetaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...detaljan opis2...ljan opis2...', 'available', 0, '2021-03-30 12:57:27'),
	(2, 'Dell Alienware Aurora R11', 3, 'Promijenjen ', 'Alienware Aurora R11, Core i9 10900F 10 C, 32GB Dual Channel HyperX, SSD 512 GB M.2 PCIe NVMe + HDD 2 TB 7.200 RPM SATA, NVIDIA GeForce RTX 2080 Ti 11 GB GDDR6, Multimedia Keyboard-KB216, MS116AW, W10Home, 3Yr', 'visible', 1, '2021-03-30 18:10:12'),
	(3, 'HP Kompjuter Z2 G5 TWR', 3, 'Kratak opis', 'Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. Detaljan opis .. ', 'visible', 1, '2021-04-08 13:06:38'),
	(6, 'Apple iMac', 3, 'Kratak opis', 'Alienware Aurora R11, Core i9 10900F 10 C, 32GB Dual Channel HyperX, SSD 512 GB M.2 PCIe NVMe + HDD 2 TB 7.200 RPM SATA, NVIDIA GeForce RTX 2080 Ti 11 GB GDDR6, Multimedia Keyboard-KB216, MS116AW, W10Home, 3Yr', 'available', 0, '2021-04-12 11:23:23'),
	(7, 'Gaming računar Lenovo M92p', 4, 'Gaming računar', 'Processor: Intel Core i5-3470 3,20GHz up to 3,60GHz', 'available', 0, '2021-05-09 15:21:41'),
	(8, 'Dell Optiplex 7010 Tower', 4, 'Računar Dell Optiplex 7010 Tower', 'Processor: Intel Core i3-3240 3,40GHz RAM: 4GB DDR3 HDD: 500GB Grafika: Intel HD Konektori: USB 2.0×10, LAN, RS232, DisplayPort x2, VGA', 'available', 0, '2021-05-09 15:38:18'),
	(9, 'Fujitsu esprimo e920', 4, 'Fujitsu esprimo e920', 'Processor: Intel Core i3-4130 3,40GHz RAM: 4GB DDR3 HDD: 250GB Grafika: Intel HD', 'available', 1, '2021-05-09 15:43:46'),
	(10, 'Dell E5550', 16, 'Laptop Dell E5550', 'Processor: Intel Core i5-5200u 2,20GHz RAM: 8GB DDR3SSD 128GB Display: 15,6” Rezolucija: 1920×1080 Grafika: Intel HD 5500 up to 4176MB Webcam, Cardreader Wi-Fi, USB 3.0: x3, HDMI, VGA.', 'available', 0, '2021-05-09 15:54:49'),
	(11, 'Asus X409J', 16, 'Laptop Asus X409J', 'Processor: Intel Core i3-10005G1 1,20GHz up to 3,40GHz RAM: 4GB DDR4 SSD: 256GB M.2 Display: 14” Rezolucija: 1920×1080 Grafika: Intel HD 5500 up to 4181MB Cardreader, Wi-Fi, Webcam, USB 2.0: x2, USB 3.0: x1, HDMI.', 'available', 0, '2021-05-09 15:58:56'),
	(12, 'Asus E410M N4020', 16, 'Laptop Asus E410M N4020', 'Processor: Intel Celeron N4020 1,10GHz up to 2,80GHz RAM: 4GB DDR4 SSD: 128GB Display: 14” Rezolucija: 1920×1080 Grafika: Intel HD 600 up to 2087MB WebCam, Cardreader, Wi-Fi, USB 2.0: x1, USB 3.0: x1, HDMI.', 'available', 1, '2021-05-09 15:59:45'),
	(13, 'Asus X540L', 18, 'Laptop Asus X540L', 'Processor: Intel Core i3-5005u 2,00GHz RAM: 8GB DDR3 SSD: 120GB M.2 Display: 15,6”Rezolucija: 1366×768 Grafika: Intel HD 5500 up to 4173MB WebCam, CardReader, Wi-Fi, DVD-RW, USB 2.0: x1, USB 3.0: x1, HDMI, VGA.', 'available', 0, '2021-05-09 16:13:44'),
	(14, 'Acer 5750', 18, 'Laptop Acer 5750', 'Processor: Intel Core i5-2450m 2,50GHz RAM: 8GB DDR3 SSD: 128GB Display: 15,6” Rezolucija: 1366×768 Grafika: Intel HD 3000 up to 1760MB Webcam, Cardreader, Wi-Fi, DVD-RW, USB 2.0: x3, HDMI, VGA.', 'available', 0, '2021-05-09 16:15:47'),
	(15, 'Acer 7750', 18, 'Laptop Acer 7750', 'Processor: Intel Core i3-2330m 2,20GHz RAM: 4GB DDR3 HDD: 250GB Display: 17,3” Rezolucija: 1600×900 Grafika: Intel HD 3000 up to 1760MB Webcam, Cardreader, Wi-Fi, DVD-RW, USB 2.0: x3, HDMI, VGA.', 'available', 0, '2021-05-09 16:17:25'),
	(16, 'Addison ANC-606  ', 15, 'Cooler Addison ANC-606  ', 'Model: Addison ANC-606 Broj ventilatora: 2 (140x140x15mm) Brzina: 700 – 1400 RPM ±10% Razina buke: 15 dBA USB: 2 Metalna mrežica Prilagodljivi nagib Plavo LED osvjetljenje', 'available', 1, '2021-05-09 16:22:36'),
	(17, 'Canyon CNR-FNS01', 15, 'Cooler Canyon CNR-FNS01', 'Fans Quantity: 1x 120mm*120mm*25mm Rated Speed Max: 1000 RPM Airflow: 33CFM Rated Current: 0.21A Rated Voltage: 5V Ratred Power: 0.5W Typical Operating Noise Level: 22.5dB Life Expectation: 30000h', 'available', 1, '2021-05-09 16:25:41');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_feature`;
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `feature_id` int unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`),
  KEY `fk_article_feature_feature_id` (`feature_id`),
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `article_feature`;
/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `value`) VALUES
	(10, 1, 8, 'Intel Core i3-10100F 3,60GHz up to 4,30GHz'),
	(11, 1, 9, '8GB'),
	(12, 1, 10, '240GB Solid 2,5”'),
	(13, 1, 11, 'RX 570 8GB XFX GDDR5'),
	(21, 3, 9, '32 GB'),
	(25, 3, 8, 'Intel® Core i7'),
	(27, 3, 10, '1 TB'),
	(28, 3, 7, 'Intel® W480'),
	(29, 6, 8, 'Intel® Core i5'),
	(30, 6, 9, 'Intel® Core i5'),
	(31, 7, 7, 'RX 550 2GB XFX'),
	(32, 7, 2, '8GB '),
	(33, 7, 13, '500GB'),
	(35, 7, 1, 'Intel Core i5-3470 3,20GHz up to 3,60GHz'),
	(36, 8, 1, 'Intel Core i3-3240 3,40GHz'),
	(37, 8, 2, '4GB DDR3'),
	(38, 8, 13, '500GB'),
	(39, 8, 7, 'Intel HD'),
	(40, 9, 1, 'Intel Core i3-4130 3,40GHz'),
	(41, 9, 2, '4GB DDR3'),
	(42, 9, 13, '250GB'),
	(43, 9, 7, 'Intel HD'),
	(44, 10, 15, 'Intel Core i5-5200u 2,20GHz'),
	(45, 10, 16, '8GB DDR3'),
	(46, 10, 17, '128GB'),
	(47, 10, 18, 'Intel HD 5500 up to 4176MB'),
	(48, 11, 15, 'Intel Core i3-10005G1 1,20GHz up to 3,40GHz'),
	(49, 11, 16, '4GB DDR4'),
	(50, 11, 17, '256GB '),
	(51, 11, 18, 'Intel HD 5500 up to 4181MB'),
	(56, 12, 15, 'Intel Celeron N4020 1,10GHz up to 2,80GHz'),
	(57, 12, 16, '4GB DDR4'),
	(58, 12, 17, '128GB '),
	(59, 12, 18, 'Intel HD 600 up to 2087MB'),
	(60, 13, 21, 'Intel Core i3-5005u 2,00GHz'),
	(61, 13, 22, '8GB DDR3'),
	(62, 13, 24, '120GB '),
	(63, 13, 25, 'Intel HD 5500 up to 4173MB'),
	(64, 14, 21, 'Intel Core i5-2450m 2,50GHz'),
	(65, 14, 22, '8GB DDR3'),
	(66, 14, 24, '128GB '),
	(67, 14, 25, 'HD 3000 up to 1760MB'),
	(68, 15, 21, 'Intel Core i3-2330m 2,20GHz'),
	(69, 15, 22, '4GB DDR3'),
	(70, 15, 27, '250GB '),
	(71, 15, 25, 'HD 3000 up to 1760MB');
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_price`;
CREATE TABLE IF NOT EXISTS `article_price` (
  `article_price_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_price_id`),
  KEY `fk_article_price_article_id` (`article_id`),
  CONSTRAINT `fk_article_price_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `article_price`;
/*!40000 ALTER TABLE `article_price` DISABLE KEYS */;
INSERT INTO `article_price` (`article_price_id`, `article_id`, `price`, `created_at`) VALUES
	(1, 1, 29.99, '2021-03-30 14:19:09'),
	(2, 1, 25.99, '2021-03-30 14:19:16'),
	(3, 2, 50.22, '2021-03-30 18:10:12'),
	(4, 2, 57.33, '2021-04-06 16:11:42'),
	(5, 3, 72.31, '2021-04-08 13:06:38'),
	(6, 6, 72.31, '2021-04-12 11:23:23'),
	(7, 1, 28.99, '2021-05-06 13:29:33'),
	(8, 1, 1239.00, '2021-05-08 13:09:44'),
	(9, 2, 700.00, '2021-05-08 13:44:32'),
	(10, 2, 7000.00, '2021-05-08 13:44:39'),
	(11, 3, 6552.00, '2021-05-08 13:50:11'),
	(12, 6, 5299.00, '2021-05-08 14:04:22'),
	(13, 7, 439.00, '2021-05-09 15:29:22'),
	(14, 8, 149.00, '2021-05-09 15:38:18'),
	(15, 9, 199.00, '2021-05-09 15:43:46'),
	(16, 10, 629.00, '2021-05-09 15:54:49'),
	(17, 11, 999.00, '2021-05-09 15:58:56'),
	(18, 12, 999.00, '2021-05-09 15:59:45'),
	(19, 12, 799.00, '2021-05-09 16:05:29'),
	(20, 13, 499.00, '2021-05-09 16:13:44'),
	(21, 14, 429.00, '2021-05-09 16:15:47'),
	(22, 15, 349.00, '2021-05-09 16:17:25'),
	(23, 16, 22.50, '2021-05-09 16:22:36'),
	(24, 17, 45.50, '2021-05-09 16:25:41'),
	(25, 12, 45.50, '2021-05-09 16:28:46'),
	(26, 12, 22.50, '2021-05-09 16:30:25'),
	(27, 12, 799.00, '2021-05-09 16:35:12');
/*!40000 ALTER TABLE `article_price` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_user_id` (`user_id`),
  CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `cart`;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`cart_id`, `user_id`, `created_at`) VALUES
	(21, 8, '2021-05-10 14:16:18'),
	(22, 8, '2021-05-10 14:50:38'),
	(23, 8, '2021-05-10 15:12:29'),
	(24, 8, '2021-05-10 15:23:16'),
	(25, 8, '2021-05-10 15:28:46'),
	(26, 8, '2021-05-10 15:28:47');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart_article`;
CREATE TABLE IF NOT EXISTS `cart_article` (
  `cart_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `cart_id` int unsigned NOT NULL DEFAULT '0',
  `quantity` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cart_article_id`),
  UNIQUE KEY `uq_cart_article_article_id_cart_id` (`article_id`,`cart_id`),
  KEY `fk_cart_article_cart_id` (`cart_id`),
  CONSTRAINT `fk_cart_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_article_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `cart_article`;
/*!40000 ALTER TABLE `cart_article` DISABLE KEYS */;
INSERT INTO `cart_article` (`cart_article_id`, `article_id`, `cart_id`, `quantity`) VALUES
	(36, 6, 21, 3),
	(37, 11, 21, 1),
	(40, 11, 22, 2),
	(49, 1, 23, 1),
	(50, 6, 23, 1),
	(51, 3, 23, 1),
	(52, 2, 23, 1),
	(55, 6, 24, 1),
	(56, 17, 25, 1);
/*!40000 ALTER TABLE `cart_article` ENABLE KEYS */;

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `image_path` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `parent__category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`),
  KEY `fk_category_parent__category_id` (`parent__category_id`),
  CONSTRAINT `fk_category_parent__category_id` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(1, 'Računari', 'assets/pc.jpg', NULL),
	(2, 'Monitori', 'assets/monitor.jpg', NULL),
	(3, 'Novi računari', 'assets/pc/new-pc.jpg', 1),
	(4, 'Refubrished računari', 'assets/pc/refubrished-pc.jpg', 1),
	(5, 'Novi monitori', 'assets/monitor/new-monitor.jpg', 2),
	(8, 'TV', 'assets/tv-equipment.jpg', NULL),
	(9, 'Telefoni i tableti', 'assets/mobile.jpg', NULL),
	(12, 'Periferija', 'assets/periferals.jpg', NULL),
	(13, 'Refubrished monitori', 'assets/monitor/refubrished-monitor.jpg', 2),
	(14, 'Laptopi', 'assets/laptop.jpg', NULL),
	(15, 'Cooler za laptop', 'assets/laptop/cooler.jpg', 14),
	(16, 'Novi laptopi', 'assets/laptop/new-laptops.jpg', 14),
	(18, 'Refurbished laptopi', 'assets/laptop/refurbished-laptops.jpg', 14),
	(19, 'Komponente', 'assets/periferals/components.jpg', 12),
	(20, 'Miševi', 'assets/periferals/mouse.jpg', 12),
	(21, 'Tastature', 'assets/periferals/keyboards.jpg', 12),
	(22, 'Slušalice', 'assets/periferals/headphones.jpg', 12),
	(23, 'Procesori', 'assets/periferals/components/proccessor.jpg', 19),
	(24, 'RAM', 'assets/periferals/components/ram.jpg', 19),
	(25, 'SSD', 'assets/periferals/components/ssd.jpg', 19),
	(26, 'HDD', 'assets/periferals/components/hdd.jpg', 19),
	(28, 'Tableti', 'assets/mobile/tablets.jpg', 9),
	(29, 'Telefoni', 'assets/mobile/mobiles.jpg', 9),
	(30, 'Punjači', 'assets/mobile/adapters.jpg', 9),
	(32, 'Grafika', 'assets/periferals/components/graphics.jpg', 19);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_name_category_id` (`name`,`category_id`),
  KEY `fk_feature_category_id` (`category_id`),
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `feature`;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(12, 'Grafika', 1),
	(11, 'Grafika', 3),
	(7, 'Grafika', 4),
	(18, 'Grafika', 16),
	(25, 'Grafika', 18),
	(13, 'HDD', 4),
	(20, 'HDD', 16),
	(27, 'HDD', 18),
	(8, 'Procesor', 3),
	(1, 'Procesor', 4),
	(15, 'Procesor', 16),
	(21, 'Procesor', 18),
	(9, 'RAM', 3),
	(2, 'RAM', 4),
	(16, 'RAM', 16),
	(22, 'RAM', 18),
	(10, 'SSD', 3),
	(3, 'SSD', 4),
	(17, 'SSD', 16),
	(24, 'SSD', 18);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cart_id` int unsigned NOT NULL DEFAULT '0',
  `status` enum('rejected','accepted','shipped','pending') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `user_id` int unsigned NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uq_order_cart_id` (`cart_id`),
  CONSTRAINT `fk_order_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `order`;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` (`order_id`, `created_at`, `cart_id`, `status`, `user_id`) VALUES
	(17, '2021-05-10 14:24:30', 21, 'accepted', 8),
	(18, '2021-05-10 14:50:38', 22, 'accepted', 8),
	(19, '2021-05-10 15:12:28', 23, 'pending', 8),
	(20, '2021-05-10 15:23:16', 24, 'pending', 8),
	(21, '2021-05-10 15:28:45', 25, 'accepted', 8);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

DROP TABLE IF EXISTS `photo`;
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `image_path` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `uq_photo_image_path` (`image_path`),
  KEY `fk_photo_article_id` (`article_id`),
  CONSTRAINT `fk_photo_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `photo`;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `article_id`, `image_path`) VALUES
	(20, 1, '202158-5832387270-maxresdefault.jpg'),
	(21, 1, '202158-4240152317-ms-aquarius-pro-gaming-kuciste-slika_1012_1012.jpg'),
	(22, 1, '202158-5397396981-ms-aquarius-pro-gaming-kuciste-slika-2_1012_1012.jpg'),
	(25, 2, '202158-4063484561-awaurorar11_csy_00020lf_wh.jpg'),
	(26, 2, '202158-8227653396-aurora-11-6.jpg'),
	(27, 2, '202158-4851636537-wp7679507.jpg'),
	(28, 3, '202158-8143611818-c06915390.png'),
	(29, 3, '202158-6641896481-419r1rhipbl._ac_sy450_.jpg'),
	(30, 3, '202158-6925153118-aurora-11-6.jpg'),
	(31, 6, '202158-2570925818-210226150011880055.jpg'),
	(32, 6, '202158-9511264621-210226150011862660.jpg'),
	(33, 6, '202158-1841150701-210226150011922850.jpg'),
	(35, 7, '202159-8675174885-download.png'),
	(36, 7, '202159-3583716713-41uknkeiqpl._ac.png'),
	(37, 8, '202159-1305568223-dell-optiplex-7010.1.png'),
	(38, 8, '202159-3831683823-dell-optiplex-7010.2.png'),
	(39, 9, '202159-0375300822-fujitsu-esprimo-e920-1.png'),
	(40, 9, '202159-0309249393-fujitsu-esprimo-e920-2.png'),
	(41, 9, '202159-4138538921-fujitsu-esprimo-e920-3.png'),
	(42, 10, '202159-5304371733-dell1-.jpg'),
	(43, 10, '202159-8537354758-dell-2.png'),
	(46, 11, '202159-8771523617-asus-x409j-1.jpg'),
	(47, 11, '202159-6056883258-x409j1.png'),
	(48, 11, '202159-1826017482-49-498309_laptop-notebook-png-image-laptop-asus-png-transparent.png'),
	(49, 12, '202159-8943331068-acer-1.png'),
	(50, 12, '202159-6724228288-asus2.png'),
	(51, 12, '202159-7357381045-asus3.png'),
	(52, 13, '202159-1105218282-asus-x-series-x540l__1_result.jpg'),
	(53, 13, '202159-2965612215-download.png'),
	(54, 14, '202159-1587815493-acer5750_2_07.jpg'),
	(55, 14, '202159-2463516333-acer5750_08.jpg'),
	(56, 15, '202159-3756015244-7750-acer-1.png'),
	(57, 15, '202159-1468842642-7750-acer-2.png'),
	(58, 16, '202159-8731756873-anc-606_1.png'),
	(59, 16, '202159-1841612636-anc-606_2.png'),
	(60, 16, '202159-6443458878-anc-606_3.png'),
	(61, 17, '202159-8648136254-cnr-fns01-3.png'),
	(62, 17, '202159-3152856478-cnr-fns01-2.png'),
	(63, 17, '202159-4514808964-cnr-fns01-1.png');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `password_hash` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `forename` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `surname` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `phone_number` varchar(24) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `postal_address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_user_email` (`email`),
  UNIQUE KEY `uq_user_phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `email`, `password_hash`, `forename`, `surname`, `phone_number`, `postal_address`) VALUES
	(1, 'korisnik1@yahoo.com', 'aaa111pop1', 'Marko', 'Sobo', '+38766123321', 'Karakajska 351'),
	(2, 'korisnik2@icloud.com', 'cllclclc781', 'Luka', 'Loncar', '+38665364278', 'Krajiska bb'),
	(3, 'peks@yahoo.com', '106C3127B213C478E99FC0C575B095D6D30089723614C478800B6AF5C83CFD6E8D8828368A78497B255B910275D875F1C097A4DC5D6502A7A7E0716190C63FF0', 'peko', 'vratolomac', '387533213', 'Dagestan 3001 Asia'),
	(5, 'marinko@outlook.com', '4C868B13EF02E9E47345BBEF22D813BC1B59F04DA8F07866A304F6DD7E783BC50C100C95B7FAEE643C013271AEC8F0EF9430FF02CB2A031164F392B049E9F12C', 'masa', 'masa', '387512333213', 'Rusija'),
	(7, 'peks@peks.com', '5372F951BBB601CC4A372B222FFBADC86CC3AFE2056ABFADE991FB7695FAEDA02DDC27A9916F97DE636718B813D0A793200A7D84F33E739E88701232B7C4BEC8', 'peks', 'peks', '+381727172', 'Srbija'),
	(8, 'xx@hotmail.com', 'B1BF2F01588BEF4AE8C6D840D211F839197A3C037EF847A78CFEB3909FE92F627121A6F02BA44F273E718E986FF11A80DE4AC68AE0B022B5938959CAF9CE9DCB', 'Unknown', 'Unknown', '+38766958331', 'R.Srpska'),
	(9, 'pk@gmail.com', 'A90BE10D8676F04DAEA8864D35D9D5A5CF8A1F290126312DE8A2294FF8D6B2C0CEE1019C8E57D5CDE02B6F348FC7EE3EEA18998FCD17987EA27025416157476A', 'Petar', 'Kovac', '+38766978020', 'R.Srpska'),
	(11, 'pk1@gmail.com', '636B542018A56E9CE2B649C6298A7F4FC1D56C2C051D2D35E8DF195F813244585973558819B3818458615D0984349C4EAA53616C9D3F1B47C8DCC52112E773F6', 'Petar', 'Kovac', '+38766556555', 'Neka adresa bb, Republika Srpska');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

DROP TABLE IF EXISTS `user_token`;
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` text COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_valid` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_token_id`),
  KEY `fk_user_token_user_id` (`user_id`),
  CONSTRAINT `fk_user_token_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `user_token`;
/*!40000 ALTER TABLE `user_token` DISABLE KEYS */;
INSERT INTO `user_token` (`user_token_id`, `user_id`, `created_at`, `token`, `expires_at`, `is_valid`) VALUES
	(23, 8, '2021-04-29 14:13:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzc2ODAyLjUxNiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJQb3N0bWFuUnVudGltZS83LjI4LjAiLCJpYXQiOjE2MTk2OTg0MDJ9.tXEv7K5df78_7Yh64l72WGfld5GzrCLmqIMeix9o3wo', '2021-05-30 00:00:00', 0),
	(24, 8, '2021-04-29 14:17:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzc3MDQ5LjYzNSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJQb3N0bWFuUnVudGltZS83LjI4LjAiLCJpYXQiOjE2MTk2OTg2NDl9.kpYrkZOx8BhP98gu6sNr5mGyBIz0r2htkp2D5CSFbKY', '2021-05-30 12:17:29', 1),
	(25, 7, '2021-04-29 17:03:01', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjIzODY5ODEuMTQ4LCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuODUgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNDkiLCJpYXQiOjE2MTk3MDg1ODF9.tAv0P_Wjww5Zp6mRvUYW4vQVWTRXjdCVlCy_9nJhfOw', '2021-05-30 15:03:01', 1),
	(26, 7, '2021-04-29 17:08:26', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjIzODczMDYuMjQ5LCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuODUgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNDkiLCJpYXQiOjE2MTk3MDg5MDZ9.HhX8nw68YyD-J8JWCgxsD92GLcWnZ3U3WJhD051iPsQ', '2021-05-30 15:08:26', 1),
	(27, 7, '2021-04-29 17:12:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjIzODc1NTAuODcsImlwIjoiOjoxIiwidXNlckFnZW50IjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzkwLjAuNDQzMC44NSBTYWZhcmkvNTM3LjM2IEVkZy85MC4wLjgxOC40OSIsImlhdCI6MTYxOTcwOTE1MH0.52hAJp9xEKcosJ5k6hb0Te-Z2y6G8Fbyp3gplUpcFkc', '2021-05-30 15:12:30', 1),
	(28, 8, '2021-04-29 17:49:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzg5Nzk5LjIzNCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJQb3N0bWFuUnVudGltZS83LjI4LjAiLCJpYXQiOjE2MTk3MTEzOTl9.cIAKLRZlcmsnizswuIg7yfciBHv77TnoWTaqlHDZB-I', '2021-05-30 15:49:59', 1),
	(29, 7, '2021-04-29 17:50:42', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjIzODk4NDIuNzc5LCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuODUgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNDkiLCJpYXQiOjE2MTk3MTE0NDJ9.KLferRp1ySbqWuF21PbdRW_IWfxY4Qau268vjoReiKY', '2021-05-30 15:50:42', 1),
	(30, 7, '2021-04-29 17:53:50', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjIzOTAwMzAuNDc2LCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuODUgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNDkiLCJpYXQiOjE2MTk3MTE2MzB9.xfM4vvH6pDILXo5paZIQdHIohfOqJWzjS2rlTZKK8Zk', '2021-05-30 15:53:50', 1),
	(31, 7, '2021-04-29 17:55:00', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjIzOTAxMDAuNTA1LCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuODUgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNDkiLCJpYXQiOjE2MTk3MTE3MDB9.lpeQAPhVGQnTHaC9QWb1WtfNCMTLg3xfB9I-3KSTgNg', '2021-05-30 15:55:00', 1),
	(32, 8, '2021-04-29 20:08:12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzk4MDkyLjUyOCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzE5NjkyfQ.edSYlFBdyjBdpSGsiS3Xpz1P8Y8JpGPDsqazOdeENNA', '2021-05-30 18:08:12', 1),
	(33, 8, '2021-04-29 20:08:35', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzk4MTE1LjMyOCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzE5NzE1fQ.UxUCk7OZAhxYaAnTZ-vh_4acUxUFwI6zkubO1dir-cc', '2021-05-30 18:08:35', 1),
	(34, 8, '2021-04-29 20:09:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzk4MTYyLjQ2NCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzE5NzYyfQ.9NQ8QN04s2NSixEIL1tmve-m7BWZawh27mkst1OYFy0', '2021-05-30 18:09:22', 1),
	(35, 8, '2021-04-29 20:09:26', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzk4MTY2LjM1OSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzE5NzY2fQ.QH-AiAW95Y8w48OFm6xvbtmyy_UFwaP71mC4Y4hvaI8', '2021-05-30 18:09:26', 1),
	(36, 8, '2021-04-29 20:15:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzk4NTIwLjA3NCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzIwMTIwfQ.vi6Aze1XVL4quhZsOrFMNHQUv89Ci_JUUi5plzEk6jk', '2021-05-30 18:15:20', 1),
	(37, 8, '2021-04-29 20:16:56', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzk4NjE2LjU5NiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzIwMjE2fQ.Kr6PjNqk-Y35EJUP3wSZ7qy75HvD3DVAP_TdZN4iKW4', '2021-05-30 18:16:56', 1),
	(38, 8, '2021-04-29 20:24:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzk5MDU0Ljk0OSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzIwNjU0fQ.F-RcaND3GolrsEpnS1OT9a7tRWglNRldB0yetw6Tfjg', '2021-05-30 18:24:14', 1),
	(39, 8, '2021-04-29 20:25:42', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzk5MTQyLjM0MiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzIwNzQyfQ.SfN0WiRx_0ggVpm9EOZbYj27uXg6en97qw1B3IcUwzk', '2021-05-30 18:25:42', 1),
	(40, 7, '2021-04-29 20:30:27', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjIzOTk0MjcuMDI3LCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuODUgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNDkiLCJpYXQiOjE2MTk3MjEwMjd9.yp5ZG92m6QzsWsEulKbF1IUCBNrm-B8ZiQCtzWD-WI8', '2021-05-30 18:30:27', 1),
	(41, 8, '2021-04-29 20:30:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyMzk5NDM3LjM1NCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzIxMDM3fQ.GGaEExbsExSUCkQb1ppkRlAn1a1DuPnxw_w5BkcgkxU', '2021-05-30 18:30:37', 1),
	(42, 7, '2021-04-29 20:31:10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjIzOTk0NzAuMzMzLCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuODUgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNDkiLCJpYXQiOjE2MTk3MjEwNzB9.kuQhHZ0O4l7VQrlzCQxo50Ul1x6gIzTVpIunBrL9skA', '2021-05-30 18:31:10', 1),
	(43, 7, '2021-04-29 21:12:07', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjI0MDE5MjcuODc2LCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuODUgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNDkiLCJpYXQiOjE2MTk3MjM1Mjd9.8QZR0MYgGHW9zyYtUinXpiV_hh7y0iTCQ-MKu12ipMU', '2021-05-30 19:12:07', 1),
	(44, 7, '2021-04-29 21:13:02', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjI0MDE5ODIuOTMxLCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuODUgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNDkiLCJpYXQiOjE2MTk3MjM1ODJ9.HX2lpp_ITB5Ca2lAPYQZz1YT4o1s8PwwmuL3HGXwoec', '2021-05-30 19:13:02', 1),
	(45, 7, '2021-04-29 21:56:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBla3NAcGVrcy5jb20iLCJleHQiOjE2MjI0MDQ1NzYuNDgsImlwIjoiOjoxIiwidXNlckFnZW50IjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzkwLjAuNDQzMC44NSBTYWZhcmkvNTM3LjM2IEVkZy85MC4wLjgxOC40OSIsImlhdCI6MTYxOTcyNjE3Nn0.9Zp_cpqNAop-0Z91RwLthVYUiG2BUHys668GCImACDc', '2021-05-30 19:56:16', 1),
	(46, 8, '2021-04-30 09:27:44', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNDQ2MDY0Ljg1NiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzY3NjY0fQ.5lBoE05LT3bf5Gjs4efc0PCRImppDtRKKwy-7uXu9ZU', '2021-05-31 07:27:44', 1),
	(47, 8, '2021-04-30 11:24:51', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNDUzMDkxLjYyMSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5Nzc0NjkxfQ.gqVS42Nm3nJT1UoZJ-V3HgFuKOAt3eEG6Q7__mHQMiI', '2021-05-31 09:24:51', 1),
	(48, 8, '2021-04-30 14:19:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNDYzNTU2LjkyOSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5Nzg1MTU2fQ.4y34pgmMAKR8s8nTSueF-9C2Z7XRAztYcOHaoK5ttBc', '2021-05-31 12:19:16', 1),
	(49, 8, '2021-04-30 15:45:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNDY4NzEzLjk3NiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjg1IFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjQ5IiwiaWF0IjoxNjE5NzkwMzEzfQ.xtModWYPRCi5FVZMiavfC7pEwHydhD1HqkU1uRW2-uQ', '2021-05-31 13:45:13', 1),
	(50, 8, '2021-05-01 10:09:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNTM0OTcwLjY2NywiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJQb3N0bWFuUnVudGltZS83LjI4LjAiLCJpYXQiOjE2MTk4NTY1NzB9.sdKvv1UhWPlSwJUH5W-qzNcal9swEZ514LhZPec-iv4', '2021-06-01 08:09:30', 1),
	(51, 8, '2021-05-01 10:11:43', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNTM1MTAzLjg0LCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6IlBvc3RtYW5SdW50aW1lLzcuMjguMCIsImlhdCI6MTYxOTg1NjcwM30.70yw7o0sR9JUPc3Gmigjq55Don4Yv54c1GyvssVHVFw', '2021-06-01 08:11:43', 1),
	(52, 8, '2021-05-01 10:19:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNTM1NTU0LjY5MiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJQb3N0bWFuUnVudGltZS83LjI4LjAiLCJpYXQiOjE2MTk4NTcxNTR9.heNqjJyDemlfove-sPeqH-yuc2z4ZofqgwxKzU9QekE', '2021-06-01 08:19:14', 1),
	(53, 8, '2021-05-01 11:41:12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNTQwNDcyLjU4OCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjE5ODYyMDcyfQ.9v4XRmQhe_yjb9O2t_4gVUmmhmBTXpBhMdjL1u2unVk', '2021-06-01 09:41:12', 1),
	(54, 8, '2021-05-03 10:29:15', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNzA4OTU1LjgzNCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJQb3N0bWFuUnVudGltZS83LjI4LjAiLCJpYXQiOjE2MjAwMzA1NTV9.-YWrcrCS512uXScZc-WJkwU-CU3mcsk-hBT0S4eiXgw', '2021-06-03 08:29:15', 1),
	(55, 8, '2021-05-03 12:27:40', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNzE2MDYwLjMyNSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMDM3NjYwfQ.m0Y4kQWDynaxXnhiiD4WbSQ_kM5LjwV1VSqDRNuzd0w', '2021-06-03 10:27:40', 1),
	(56, 8, '2021-05-03 17:23:26', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNzMzODA2LjU1OCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMDU1NDA2fQ.WitkHYWwH4htMlVbG2g8OkHQFDjPHzgX0qa3EEET_Hc', '2021-06-03 15:23:26', 1),
	(57, 8, '2021-05-03 17:27:49', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNzM0MDY5LjA0OCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMDU1NjY5fQ.oP_2Gub6X3sHqN5qo2MUTxOnxbaFb8I_igDCaLhQ0zI', '2021-06-03 15:27:49', 1),
	(58, 8, '2021-05-03 18:19:51', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNzM3MTkxLjg5NiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMDU4NzkxfQ.UbLm_scIIYIvqa8AWMeT7Smi0FEL8n66zJbyTn-kATE', '2021-06-03 16:19:51', 1),
	(59, 8, '2021-05-03 19:56:34', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyNzQyOTk0LjA1MSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMDY0NTk0fQ.LiayypB8762ST9nQJb6SKCHvAQnyg3WEpAeATAbwxMM', '2021-06-03 17:56:34', 1),
	(60, 8, '2021-05-04 12:35:47', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIyODAyOTQ3LjgxOCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMTI0NTQ3fQ.-LM-b8kTEgHYOtGH5q5inH2TGlzQ4W2N64mGTNWqfGs', '2021-06-04 10:35:47', 1),
	(61, 8, '2021-05-06 20:47:54', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMDA1MjczLjk5OSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMzI2ODczfQ.jt22XkrpZhbbKMvUJoUAqlmlp85WqltrrxggyMk8qBc', '2021-06-06 18:47:53', 1),
	(62, 8, '2021-05-07 10:36:08', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMDU0OTY4LjAwOCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMzc2NTY4fQ.WKYwjWtoDg33lFCJZzrWLZ3YUwXjfBxifQL4M_EVZj8', '2021-06-07 08:36:08', 1),
	(63, 8, '2021-05-07 13:07:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMDY0MDUwLjQyMSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjUxIiwiaWF0IjoxNjIwMzg1NjUwfQ.mxOoMmXxcAVnhVtagIJqLwbnJMuaEfwjbBbcxcofIDY', '2021-06-07 11:07:30', 1),
	(64, 8, '2021-05-08 11:41:49', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMTQ1MzA5LjU1MiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNDY2OTA5fQ.AdV0kFvX_f6PEALLjNN-M9CrSrgO5kJ0E8VS80kL3UA', '2021-06-08 09:41:49', 1),
	(65, 8, '2021-05-09 11:55:48', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMjMyNTQ4LjMxMiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNTU0MTQ4fQ.rJb7c4wKziXJllaxbDWMzNImepfQ2OVYRmQYTTXA5Zg', '2021-06-09 09:55:48', 1),
	(66, 8, '2021-05-09 13:14:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMjM3Mjc4LjQ4MSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNTU4ODc4fQ.2VXbGGcQbhvT_4wIevd3kPfg37vnHvidt0tVmzqeuTI', '2021-06-09 11:14:38', 1),
	(67, 8, '2021-05-09 13:32:03', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMjM4MzIzLjczOSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNTU5OTIzfQ.Kjc45mJlmm3yOZ5xS1_nWw_s9R3Cn2S8H54Ank7MVUI', '2021-06-09 11:32:03', 1),
	(68, 8, '2021-05-09 13:44:07', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMjM5MDQ3Ljg0NiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNTYwNjQ3fQ.uz7VR3YksTxIXRQ-W1gVCsVVkGPwFf8MV6j8aSlXyTY', '2021-06-09 11:44:07', 1),
	(69, 9, '2021-05-09 14:17:34', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBrQGdtYWlsLmNvbSIsImV4dCI6MTYyMzI0MTA1NC4wODUsImlwIjoiOjoxIiwidXNlckFnZW50IjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzkwLjAuNDQzMC45MyBTYWZhcmkvNTM3LjM2IEVkZy85MC4wLjgxOC41NiIsImlhdCI6MTYyMDU2MjY1NH0.R_zxxwLYFc505LGSWuufmm7em_YNSZYZ8NFLU8xRL98', '2021-06-09 12:17:34', 1),
	(70, 9, '2021-05-09 15:04:33', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6InBrQGdtYWlsLmNvbSIsImV4dCI6MTYyMzI0Mzg3My44NDQsImlwIjoiOjoxIiwidXNlckFnZW50IjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzkwLjAuNDQzMC45MyBTYWZhcmkvNTM3LjM2IEVkZy85MC4wLjgxOC41NiIsImlhdCI6MTYyMDU2NTQ3M30.na-MAoWL_DEPelYpc47xGp63QzshCm1prV6dAE3H7mA', '2021-06-09 13:04:33', 1),
	(71, 11, '2021-05-09 15:05:28', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInJvbGUiOiJ1c2VyIiwiaWRlbnRpdHkiOiJwazFAZ21haWwuY29tIiwiZXh0IjoxNjIzMjQzOTI4LjE1LCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuOTMgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNTYiLCJpYXQiOjE2MjA1NjU1Mjh9.aosXocQHNNoXRpBuFW0vRz2jx4SjDjQ8X79vRKP7u-A', '2021-06-09 13:05:28', 1),
	(72, 11, '2021-05-09 15:11:32', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInJvbGUiOiJ1c2VyIiwiaWRlbnRpdHkiOiJwazFAZ21haWwuY29tIiwiZXh0IjoxNjIzMjQ0MjkyLjM3MSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNTY1ODkyfQ.K0mAzvO32fEO3sxJVFtI38BZN1ZNjmxHGpZ80D4UGZ0', '2021-06-09 13:11:32', 1),
	(73, 8, '2021-05-10 10:35:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMzE0MTEzLjAyLCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuOTMgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNTYiLCJpYXQiOjE2MjA2MzU3MTN9.ywnDLoVIP0yD_9kJgr88oVyj6gNEHULcHwyMjxYfnbg', '2021-06-10 08:35:13', 1),
	(74, 8, '2021-05-10 10:36:18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMzE0MTc4LjYwMSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNjM1Nzc4fQ.oHM6oANLG4-llwlzePf9DPsF4wbvcnptGq25Z8vLaEk', '2021-06-10 08:36:18', 1),
	(75, 8, '2021-05-10 12:09:24', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMzE5NzY0Ljc0LCJpcCI6Ijo6MSIsInVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85MC4wLjQ0MzAuOTMgU2FmYXJpLzUzNy4zNiBFZGcvOTAuMC44MTguNTYiLCJpYXQiOjE2MjA2NDEzNjR9.sKccNSR7hjAFW2bcFTsPPOp01XnVLn-RJg8DFdzmrS8', '2021-06-10 10:09:24', 1),
	(76, 8, '2021-05-10 13:05:31', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMzIzMTMxLjc5MywiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJQb3N0bWFuUnVudGltZS83LjI4LjAiLCJpYXQiOjE2MjA2NDQ3MzF9.9jLvlZlROEO4emnX4WyxL8P2kaCUA5-ge9E1Na2JR3M', '2021-06-10 11:05:31', 1),
	(77, 8, '2021-05-10 15:10:04', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMzMwNjA0LjAyNSwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNjUyMjA0fQ.e8013YZocEzJt_Pi_gSQ0W28BrlQ9iPWj91rF3EOoGA', '2021-06-10 13:10:04', 1),
	(78, 8, '2021-05-10 15:28:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMzMxNzAwLjA3NiwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNjUzMzAwfQ.cAHkXnpEcTTul1rONNJhCw1Sh7vQ1VbDHTeXYTQu-_4', '2021-06-10 13:28:20', 1),
	(79, 8, '2021-05-10 15:29:12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwicm9sZSI6InVzZXIiLCJpZGVudGl0eSI6Inh4QGhvdG1haWwuY29tIiwiZXh0IjoxNjIzMzMxNzUyLjc3NCwiaXAiOiI6OjEiLCJ1c2VyQWdlbnQiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTAuMC40NDMwLjkzIFNhZmFyaS81MzcuMzYgRWRnLzkwLjAuODE4LjU2IiwiaWF0IjoxNjIwNjUzMzUyfQ.0R0CHwwNFax_KeKPsFH3IedrGbE5o29vRcTWmCcU694', '2021-06-10 13:29:12', 1);
/*!40000 ALTER TABLE `user_token` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

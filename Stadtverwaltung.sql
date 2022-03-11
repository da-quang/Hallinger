CREATE TABLE `mitarbeiter` (
	`personalnummer` INT(11) NOT NULL AUTO_INCREMENT,
	`vorname` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`nachname` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`fk_ressort_bezeichnung` CHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`personalnummer`) USING BTREE,
	INDEX `FK_mitarbeiter_ressort` (`fk_ressort_bezeichnung`) USING BTREE,
	CONSTRAINT `FK_mitarbeiter_ressort` FOREIGN KEY (`fk_ressort_bezeichnung`) 
	REFERENCES `stadtverwaltung`.`ressort` (`bezeichnung`) ON UPDATE NO ACTION ON DELETE NO ACTION
)

CREATE TABLE `projekt` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`bezeichnung` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`kurzbeschreibung` CHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`startdatum` DATE NULL DEFAULT NULL,
	`abschlussdatum` DATE NULL DEFAULT NULL,
	`status` CHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`projektleiter` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)

CREATE TABLE `mitarbeiter_projekt` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`fk_projekt_id` INT(11) NULL DEFAULT NULL,
	`fk_mitarbeieter_personalnummer` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `fk_mitarbeiter_personalnummer` (`fk_mitarbeieter_personalnummer`) USING BTREE,
	INDEX `fk_projekt_id` (`fk_projekt_id`) USING BTREE,
	CONSTRAINT `fk_mitarbeiter_personalnummer` FOREIGN KEY (`fk_mitarbeieter_personalnummer`) 
	REFERENCES `stadtverwaltung`.`mitarbeiter` (`personalnummer`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `fk_projekt_id` FOREIGN KEY (`fk_projekt_id`) 
	REFERENCES `stadtverwaltung`.`projekt` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)

CREATE TABLE `ressort` (
	`bezeichnung` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`stadt` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`bezeichnung`) USING BTREE
)

COLLATE='latin1_swedish_ci'
ENGINE=INNODB;

INSERT INTO projekt VALUES 
()

INSERT INTO mitarbeiter VALUES 
(1, 'Mike', 'Hummels', 'Finanz'),
(2, 'Maya', 'Bosch', 'Finanz'),
(3, 'Coco', 'Kirchdorf', 'Finanz'),
(4, 'Luca', 'Gasser', 'Finanz'),
(5, 'Finn', 'Strauch', 'Recht'),
(6, 'Liam', 'Zug', 'Recht'),
(7, 'Gisele', 'Buchtel', 'Personal'),
(8, 'Fabienne', 'Fisch', 'Personal'),
(9, 'Julia', 'Zorn', 'Logistik'),
(10, 'Eva', 'Schlauch', 'Logistik'),
(11, 'Linus', 'Bosch', 'IT'),
(12, 'Elena', 'Rolland', 'IT'),
(13, 'Fiona', 'Sammer', 'IT');

INSERT INTO ressort VALUES 
('Finanz'),
('Recht'),
('Personal'),
('IT'),
('Risiko Management'),
('Archiv'),
('Logistik');

INSERT INTO projekt VALUES 
(1, 'Transport', '2 LKWs', '2020-10-1', '2020-10-30', 'abgeschlossen', 9),
(2, 'Transport', '100 Kisten', '2021-11-1', '2021-11-30', 'abgeschlossen', 9),
(3, 'Windows 11', 'Windows 7 auf Windows 11', '2021-10-1', '2021-11-30', 'abgeschlossen', 13),
(4, 'Windows 11', 'Windows 7 auf Windows 11', '2021-11-30', '2022-07-30', 'offen', 12),
(5, 'Covid-19', 'neue Regelung', '2021-10-1', '2022-3-30', 'offen', 6),
(6, 'Patent', 'Patent anlegen', '2015-07-1', '2015-8-30', 'abgeschlossen', 1);

INSERT INTO mitarbeiter_projekt VALUES
(1, 1, 9, '2020-10-1', '2020-10-30'),
(2, 1, 10, '2020-10-1', '2020-10-30'),
(3, 2, 9, '2021-11-1', '2021-11-30'),
(4, 2, 10, '2021-11-1', '2021-11-30'),
(5, 3, 13, '2021-10-1', '2021-11-30'),
(6, 3, 12, '2021-10-1', '2021-11-30'),
(7, 3, 11, '2021-10-1', '2021-11-30'),
(8, 4, 12, '2021-11-30', '2022-07-30'),
(9, 4, 11, '2021-11-30', '2022-07-30'),
(10, 5, 5, '2021-10-1', '2022-03-30'),
(11, 6, 1, '2015-07-1', '2015-08-30'),
(12, 6, 2, '2015-07-1', '2015-08-30');

SELECT * FROM mitarbeiter_projekt;
SELECT * FROM projekt;
SELECT * FROM mitarbeiter;
SELECT * FROM ressort;
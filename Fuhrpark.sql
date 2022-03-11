USE `fuhrpark`;

CREATE TABLE `fahrzeug` (
	`Kennzeichen` VARCHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`Modell` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Hersteller` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Kraftstoffart` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Verbrauch` INT(11) NULL DEFAULT NULL,
	`Anschaffungskosten` INT(11) NULL DEFAULT NULL,
	`Anschaffungsdatum` DATE NULL DEFAULT NULL,
	PRIMARY KEY (`Kennzeichen`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `instandhaltung` (
	`Id` INT(11) NOT NULL,
	`Typ` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Beschreibung` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Kilometerstand` INT(11) NULL DEFAULT NULL,
	`Kosten` INT(11) NULL DEFAULT NULL,
	`Datum` DATE NULL DEFAULT NULL,
	`Kennzeichen` VARCHAR(10) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`Id`) USING BTREE,
	INDEX `FK_instandhaltung_fahrzeug` (`Kennzeichen`) USING BTREE,
	CONSTRAINT `FK_instandhaltung_fahrzeug` FOREIGN KEY (`Kennzeichen`) 
	REFERENCES `fuhrpark`.`fahrzeug` (`Kennzeichen`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `mitarbeiter` (
	`Personalnummer` INT(11) NOT NULL,
	`Vorname` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Nachname` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Abteilung` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`Personalnummer`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `reservierung` (
	`Id` INT(11) NOT NULL,
	`Name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Zweck` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Beginn` DATE NULL DEFAULT NULL,
	`Ende` DATE NULL DEFAULT NULL,
	`Personalnummer` INT(11) NULL DEFAULT NULL,
	`Kennzeichen` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`Id`) USING BTREE,
	INDEX `FK_reservierung_mitarbeiter` (`Personalnummer`) USING BTREE,
	INDEX `FK_reservierung_fahrzeug` (`Kennzeichen`) USING BTREE,
	CONSTRAINT `FK_reservierung_fahrzeug` FOREIGN KEY (`Kennzeichen`) 
	REFERENCES `fuhrpark`.`fahrzeug` (`Kennzeichen`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_reservierung_mitarbeiter` FOREIGN KEY (`Personalnummer`) 
	REFERENCES `fuhrpark`.`mitarbeiter` (`Personalnummer`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `versicherungsgesellschaft` (
	`Firmenname` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`Telefonnumer` VARCHAR(10) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Ort` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`PLZ` INT(11) NULL DEFAULT NULL,
	`Adresse` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`Firmenname`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `versicherung` (
	`Versicherungsnummer` INT(11) NOT NULL,
	`Zusatzverischerung` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Beitragskosten` INT(11) NULL DEFAULT NULL,
	`Kennzeichen` VARCHAR(10) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`Firmenname` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`Versicherungsnummer`) USING BTREE,
	INDEX `FK_versicherung_fahrzeug` (`Kennzeichen`) USING BTREE,
	INDEX `FK_versicherung_versicherungsgesellschaft` (`Firmenname`) USING BTREE,
	CONSTRAINT `FK_versicherung_fahrzeug` FOREIGN KEY (`Kennzeichen`) 
	REFERENCES `fuhrpark`.`fahrzeug` (`Kennzeichen`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_versicherung_versicherungsgesellschaft` FOREIGN KEY (`Firmenname`) 
	REFERENCES `fuhrpark`.`versicherungsgesellschaft` (`Firmenname`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

SELECT * FROM fahrzeug;
INSERT INTO fahrzeug VALUES 
('kgg-345', 'r9', 'toyota', 'diesel', 7, 70000, '2013-6-19'),
('lfd-935', 'caprio', 'porsche', 'diesel', 7, 88000, '2016-1-9'),
('acs-923', 'mountain', 'audi', 'benzin', 10, 52000, '2018-8-12'),
('mbf-174', '2-Sitz', 'porsche', 'benzin', 9, 32000, '2019-8-30'),
('lgf-234', 'GG', 'mercedes', 'diesel', 5, 49000, '2021-9-21');

SELECT * FROM instandhaltung;
INSERT INTO instandhaltung VALUES 
(1, 'Reperatur', 'Beule hinten', 1442, 200, '2020-10-30', 'kgg-345'),
(2, 'Reperatur', 'Fenster kaputt', 3432, 300, '2021-11-30', 'kgg-345'),
(3, 'Wartungsarbeit', 'Reifenwechsel', 345, 40, '2021-11-30', 'acs-923'),
(4, 'Wartungsarbeit', 'Ölwechsel', 123, 30, '2021-07-30', 'mbf-174'),
(5, 'Reperatur', 'Rückspiegel defekt', 342, 50, '2021-3-30', 'acs-923');

SELECT * FROM mitarbeiter;
INSERT INTO mitarbeiter VALUES 
(1, 'Mike', 'Hummels', 'Finanz'),
(2, 'Maya', 'Bosch', 'Personal'),
(3, 'Coco', 'Kirchdorf', 'Logistik'),
(4, 'Luca', 'Gasser', 'IT'),
(5, 'Finn', 'Strauch', 'Recht');

SELECT * FROM reservierung;
INSERT INTO reservierung VALUES
(1, 'K2-Gipfel', 'Beruflich', '2020-10-1', '2020-10-30', 1, 'kgg-345'),
(2, 'Freizeit', 'Sport', '2020-10-1', '2020-10-30', 1, 'acs-923'),
(3, 'Testen', 'Limit testen', '2021-11-1', '2021-11-30', 2, 'acs-923'),
(4, 'Notfall', 'Bus verpasst', '2021-11-1', '2021-11-30', 3, 'kgg-345'),
(5, 'Freizeit', 'Familien Besuch', '2021-10-1', '2021-11-30', 2, 'lgf-234');

SELECT * FROM versicherungsgesellschaft;
INSERT INTO versicherungsgesellschaft VALUES 
('Insurance GMBH', '0650 34235', 'Dornbirn', '6850', 'Dornbirnergasse'),
('GIGA Versicherung', '0650 95433', 'Dornbirn', '6850', 'Dornbirnbahnhof'),
('Deine Versicherung AG', '0650 43545', 'Hohenems', '6845', 'Hohenemsergasse'),
('Unemployment Insurance OG', '0650 43545', 'Hohenems', '6845', 'Hohenemserdorf'),
('Health Care KG', '0650 12343', 'Feldkrich', '6800', 'Feldkircherstraße');

SELECT * FROM versicherung;
INSERT INTO versicherung VALUES 
(1, 'Vollkasko', '20000', 'kgg-345', 'Insurance GMBH'),
(2, 'Vollkasko', '31000', 'acs-923', 'GIGA Versicherung'),
(3, 'Teilkasko', '20000', 'acs-923', 'Deine Versicherung AG'),
(4, 'Teilkasko', '19000', 'kgg-345', 'Insurance GMBH'),
(5, 'Teilkasko', '8000', 'lgf-234', 'GIGA Versicherung');


SELECT r.*, CONCAT(m.Vorname, ' ', m.Nachname) AS Name, m.Abteilung  FROM reservierung r 
	INNER JOIN mitarbeiter m
		ON r.Personalnummer = m.Personalnummer;


CREATE VIEW kosten_view AS 
	SELECT kennzeichen, anschaffungskosten AS kosten FROM fahrzeug
		UNION
	SELECT kennzeichen, beitragskosten FROM versicherung
		UNION
	SELECT kennzeichen, kosten FROM instandhaltung

SELECT kennzeichen, SUM(kosten) AS kosten FROM kosten_view
	GROUP BY kennzeichen;
	
	
SELECT f.kennzeichen, IFNULL(SUM(f.Anschaffungskosten), 0) + IFNULL(SUM(v.Beitragskosten), 0)+ IFNULL(SUM(i.kosten), 0)  FROM fahrzeug f 
LEFT JOIN versicherung v ON f.kennzeichen = v.kennzeichen
LEFT JOIN instandhaltung i ON f.kennzeichen = i.kennzeichen
GROUP BY f.kennzeichen;


	
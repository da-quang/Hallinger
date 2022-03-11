create database Fahrradverleih;
use Fahrradverleih;

create table Ort(
	Postleitzahl int primary key,
	Name varchar (50) unique
)

create table Mitarbeiter(
	Id int primary key identity(1,1),
	Vorname varchar(50) not null,
	Nachname varchar(50) not null,
	Straße varchar(50) not null,
	Hausnummer varchar (10),
	Abteilung varchar(50),
	Ort_Postleitzahl int not null,
	foreign key (Ort_Postleitzahl) references Ort(Postleitzahl)
)

create table Fahrrad(
	Rahmennummer int primary key,
	Rahmengröße int not null,
	Typ varchar(50) not null,
	Herstelldatum date not null,
)

create table Kurzbericht(
	Id int primary key identity(1,1),
	Typ varchar(50) not null,
	Beschreibung varchar(50),
	Datum date,
	KM int,
	Fahrrad_Rahmennummer int not null,
	Mitarbeiter_Id int not null,
	foreign key (Mitarbeiter_Id) references Mitarbeiter(Id),
	foreign key (Fahrrad_Rahmennummer) references Fahrrad(Rahmennummer)
)

create table Reservierung(
	Id int primary key identity(1,1),
	Startdatum date,
	Enddatum date,
	Fahrrad_Rahmennummer int not null,
	Mitarbeiter_Id int not null,
	foreign key (Mitarbeiter_Id) references Mitarbeiter(Id),
	foreign key (Fahrrad_Rahmennummer) references Fahrrad(Rahmennummer)
)

create table Foto(
	Id int primary key identity(1,1),
	Foto varbinary,
	Kurzbericht_Id int not null,
	foreign key (Kurzbericht_Id) references Kurzbericht(Id),
)

select * from Mitarbeiter;

select * from Fahrrad;

select * from Kurzbericht;

select * from Reservierung;

select * from Foto;

select * from Ort;


insert into Ort values
	(6890, 'Lustenau'),
	(6850, 'Dornbirn'),
	(6900, 'Bregenz'),
	(6800, 'Feldkirch'),
	(6700, 'Bludenz');

insert into Mitarbeiter values
	('Felix','Hammer','Gössergasse', '12b', 'PRO', 6700),
	('Laura','Bösch','Friedrichstraße', '26', 'SUP', 6900),
	('Sophia','Hadzic','Mariahilfstraße', '6', 'SUP', 6850),
	('Julia','Bösch','Schulgasse', '15d', 'IT', 6700),
	('Paul','König','Hausweg', '3d', 'IT', 6900),
	('Lukas','Krone','Körnerstraße', '6c', 'IT', 6890),
	('Kevin','Thor','Roter Platz', '21', 'PRO', 6890),
	('Lisa','Kopf','Mühlenfeld', '34', 'PRO', 6850),
	('Mario','Krone','Kirchstraße', '12', 'LOG', 6850)

insert into Fahrrad values 
	(1111, 170, 'BMX', '1 Mar 2017'),
	(1122, 180, 'E-Bike', '1 Dec 2020'),
	(1133, 180, 'E-Bike', '1 Apr 2020'),
	(1144, 170, 'Rennrad', '1 Apr 2017'),
	(1155, 160, 'Damenfahrrad', '1 Jul 2015')

insert into Reservierung values
	('23 Mar 2019', '1 Apr 2019', 1122, 1),
	('16 Jul 2019', '21 Jul 2019', 1122, 2),
	('1 Oct 2019', '18 Oct 2019', 1133, 5),
	('3 Oct 2019', '15 Oct 2019', 1111, 2),
	('3 Jul 2019', '13 Jul 2019', 1144, 3),
	('17 Apr 2020', '23 Apr 2020', 1155, 3),
	('23 Aug 2020', '27 Aug 2020', 1155, 6),
	('11 Aug 2020', '19 Aug 2020', 1144, 7)

insert into Kurzbericht values
	('Arbeit', null, '1 Apr 2019', 55, 1122, 1),
	('Freizeit', null, '21 Jul 2019', 57, 1122, 2),
	('Freizeit', null, '18 Oct 2019', 47, 1133, 5),
	('Reparatur', 'Ketten schmieren', '15 Oct 2019', 65, 1111, 2),
	('Arbeit', null, '13 Jul 2019', 46, 1144, 3),
	('Arbeit', null, '23 Apr 2020', 47, 1155, 3),
	('Freizeit', null, '27 Aug 2020', 32, 1155, 6),
	('Reperatur', 'Reifen wechsel', '19 Aug 2020', 34, 1144, 7)

insert into Foto values
	(12343, 1),
	(12332, 1),
	(13424, 2),
	(15322, 3),
	(12112, 3),
	(11123, 4),
	(11234, 5),
	(15322, 6),
	(13244, 7),
	(14444, 7),
	(12343, 7)

select * from Mitarbeiter;
select * from Kurzbericht;

select top 1 m.Abteilung, sum(k.KM)[Anzahl KM]
	from Kurzbericht k inner join Mitarbeiter m
		on k.Mitarbeiter_Id = m.Id
			group by m.Abteilung
				order by 2 desc;


select top 1 m.Vorname, m.Nachname, m.Abteilung, sum(k.KM)[Anzahl KM]
	from Kurzbericht k inner join Mitarbeiter m
		on k.Mitarbeiter_Id = m.Id
			group by m.Vorname, m.Nachname, m.Abteilung
				order by 4 desc;




				LAPTOP-C3LQEHTJ
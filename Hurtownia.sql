
CREATE DATABASE Hurtownia;
GO
USE Hurtownia 

GO
CREATE TABLE [dbo].[Pracownik]
(
	Id_Pracownika INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Id_Dzialu INTEGER NOT NULL,
	Nazwisko NVARCHAR(100) NOT NULL,
	Imie NVARCHAR(100) NOT NULL,
	Nr_tel INTEGER NOT NULL,
	Pesel BIGINT not null,
	Rok_Urodz DATE NOT NULL,
	Nr_Konta NVARCHAR(26) NOT NULL,
	Data_Zatr DATE NOT NULL,
	Id_Szefa INTEGER ,
	CONSTRAINT Sz CHECK(Data_Zatr > Rok_Urodz)
);
CREATE TABLE [dbo].[Dzialy]
(
	Id_Dzialu INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Nazwa NVARCHAR(150) NOT NULL
);
CREATE TABLE [dbo].[Zarobki]
(
	Id_Zarobku INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Id_Pracownika INTEGER NOT NULL,
	Brutto MONEY NOT NULL,
	CONSTRAINT un UNIQUE(Id_Pracownika)
);
CREATE TABLE [dbo].[Urlop]
(
	Id_urlopu INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Id_Pracownika INTEGER NOT NULL,
	Od DATE NOT NULL DEFAULT getdate(),
	Do DATE NOT NULL,
	CONSTRAINT Sprawdz_Urlop CHECK(Do >= Od)
);
CREATE TABLE [dbo].[Faktury]
(
	Id_Faktury INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Id_Pracownika INTEGER NOT NULL,
	Id_Klienta INTEGER NOT NULL,
	Numer_Faktury NVARCHAR(50) NOT NULL,
	Data_Wystaw DATE NOT NULL,
	CONSTRAINT nrf UNIQUE(Numer_Faktury)
);
CREATE TABLE [dbo].[Transakcje]
(
	Id_Transakcji INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Id_Zamowienia INTEGER ,
	Id_Faktury INTEGER ,
	Id_Produktu INTEGER NOT NULL,
	Iloœæ INTEGER NOT NULL
);
CREATE TABLE [dbo].[Klienci]
(
	Id_Klienta INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Id_Miasta INTEGER NOT NULL,
	Nazwisko NVARCHAR(100) NOT NULL,
	Imie NVARCHAR(100) NOT NULL,
	Nip NVARCHAR(50),
	Nr_Tel INTEGER NOT NULL,
	CONSTRAINT nip UNIQUE(Nip)
);
CREATE TABLE [dbo].[Miasto]
(
	Id_Miasta INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Id_Wojewodztwa INTEGER NOT NULL,
	Miasto NVARCHAR(100) NOT NULL,
	CONSTRAINT mias UNIQUE(Miasto)
);
CREATE TABLE [dbo].[Wojewodztwa]
(
	Id_Wojewodztwa INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Województwo NVARCHAR(100) NOT NULL,
	CONSTRAINT woj UNIQUE(Województwo)
);
CREATE TABLE [dbo].[Zamowienia]
(
	Id_zamowienia INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Numer_Zamowienia NVARCHAR(50) NOT NULL,
	Data_Zamowienia DATE NOT NULL,
	Id_Pracownika INTEGER NOT NULL,
	CONSTRAINT nrzam UNIQUE(Numer_Zamowienia)

);

CREATE TABLE [dbo].[Producenci]
(
	Id_Producenta INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Nazwa_Producenta NVARCHAR(150) NOT NULL,
	Id_Miasta INTEGER NOT NULL,
	CONSTRAINT prod UNIQUE(Nazwa_Producenta)
);
CREATE TABLE [dbo].[Produkty]
(
	Id_Produktu INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Id_Kategorii INTEGER NOT NULL,
	Id_Producenta INTEGER NOT NULL,
	Nazwa_Produktu NVARCHAR(150) NOT NULL,
	Iloœæ REAL NOT NULL,
	Cena MONEY NOT NULL,
	Cena_Zakupu MONEY NOT NULL,
	CONSTRAINT cv CHECK(Cena > Cena_Zakupu)
);
CREATE TABLE [dbo].[Kategorie]
(
	Id_Kategorii INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Nazwa_kategorii NVARCHAR(100) NOT NULL,
	CONSTRAINT kat UNIQUE(Nazwa_kategorii)
);


GO
ALTER TABLE [dbo].[Pracownik] ADD FOREIGN KEY ([Id_Szefa]) REFERENCES [dbo].[Pracownik]([Id_Pracownika]);
ALTER TABLE [dbo].[Pracownik] ADD FOREIGN KEY ([Id_Dzialu]) REFERENCES [dbo].[Dzialy]([Id_Dzialu]);
ALTER TABLE [dbo].[Urlop] ADD FOREIGN KEY ([Id_Pracownika]) REFERENCES [dbo].[Pracownik]([Id_Pracownika]);
ALTER TABLE [dbo].[Zarobki] ADD FOREIGN KEY ([Id_Pracownika]) REFERENCES [dbo].[Pracownik]([Id_Pracownika]);
ALTER TABLE [dbo].[Faktury] ADD FOREIGN KEY ([Id_Pracownika]) REFERENCES [dbo].[Pracownik]([Id_Pracownika]);
ALTER TABLE [dbo].[Faktury] ADD FOREIGN KEY ([Id_Klienta]) REFERENCES [dbo].[Klienci]([Id_Klienta]);
ALTER TABLE [dbo].[Klienci] ADD FOREIGN KEY ([Id_Miasta]) REFERENCES [dbo].[Miasto]([Id_Miasta]);
ALTER TABLE [dbo].[Miasto] ADD FOREIGN KEY ([Id_Wojewodztwa]) REFERENCES [dbo].[Wojewodztwa]([Id_Wojewodztwa]);
ALTER TABLE [dbo].[Transakcje] ADD FOREIGN KEY ([Id_Faktury]) REFERENCES [dbo].[Faktury]([Id_Faktury]);
ALTER TABLE [dbo].[Transakcje] ADD FOREIGN KEY ([Id_Produktu]) REFERENCES [dbo].[Produkty]([Id_Produktu]);
ALTER TABLE [dbo].[Produkty] ADD FOREIGN KEY ([Id_Kategorii])	REFERENCES [dbo].[Kategorie]([Id_Kategorii]);
ALTER TABLE [dbo].[Produkty] ADD FOREIGN KEY ([Id_Producenta]) REFERENCES [dbo].[Producenci]([Id_Producenta]);
ALTER TABLE [dbo].[Transakcje] ADD FOREIGN KEY ([Id_Zamowienia]) REFERENCES [dbo].[Zamowienia]([Id_Zamowienia]);
ALTER TABLE [dbo].[Producenci] ADD FOREIGN KEY ([Id_Miasta]) REFERENCES [dbo].[Miasto]([Id_Miasta]);
ALTER TABLE [dbo].[Zamowienia] ADD FOREIGN KEY ([Id_Pracownika]) REFERENCES [dbo].[Pracownik]([Id_Pracownika]);


GO
INSERT INTO [Dzialy] 
VALUES
('W³aœciciel'),
('Kierownik hali'),
('Kierownik magazynu'),
('Sprzedawca'),
('Magazynier'),
('Ksiêgowa');

GO
INSERT INTO [Pracownik] 
VALUES
(1,'Maliszewski','Grzegorz',677347898,850812057890,'08/12/1985','25350505000000001249568044','01/10/2001',NULL),
(2,'Kmieæ','Agnieszka',682032334,89072005349,'07/20/1989','25584756654485700009573044','01/12/2001',1),
(3,'Szymczak','Robert',660756445,91112106857,'11/21/1991','25688745634500007563470344','01/12/2001',1);
GO
INSERT INTO [Pracownik] 
VALUES
(5,'Zawadzki','Szymon',782255082,90120409234,'12/04/1990','25667829100000331248869295','01/15/2001',2),
(5,'Sznyder','Andrzej',662821331,01291906257,'08/19/2001','25576986458000029385448044','05/01/2019',2);
GO
INSERT INTO [Pracownik] 
VALUES
(4,'Sowa','Alicja',722982339,97121207782,'12/12/1997','25475559870000184599832044','02/01/2017',3),
(4,'Nowak','Katarzyna',660921332,99031908277,'03/19/1999','25485766900001945768223349','04/01/2018',3),
(6,'Szymczak','Monika',982382225,90112802766,'11/28/1990','25567883640000467793032044','01/15/2001',1);
GO
INSERT INTO [Zarobki] 
VALUES
(1,10000.00),
(2,6000.00),
(3,6000.00),
(4,4000.00),
(5,4000.00),
(6,3500.00),
(7,3500.00),
(8,8000.00);
GO
INSERT INTO [Urlop] 
VALUES
(2,'01/10/2022','01/13/2022'),
(2,'02/7/2022','02/9/2022'),
(4,'04/20/2022','04/22/2022'),
(5,'03/14/2022','03/16/2022'),
(7,'05/23/2022','05/27/2022'),
(4,'05/25/2022','05/28/2022');

GO
INSERT INTO [Wojewodztwa] 
VALUES
('Dolnoœl¹skie'),
('Kujawsko-pomorskie'),
('Lubelskie'),
('Lubuskie'),
('£ódzkie'),
('Ma³opolskie'),
('Mazowieckie'),
('Opolskie'),
('Podkarpackie'),
('Podlaskie'),
('Pomorskie'),
('Œl¹skie'),
('Œwiêtokrzyskie'),
('Warmiñsko-mazurskie'),
('Wielkopolskie'),
('Zachodniopomorskie');

GO
INSERT INTO [Miasto] 
VALUES
(1,'Wroc³aw'),
(2,'Bydgoszcz'),
(2,'Toruñ'),
(3,'Lublin'),
(4,'Gorzów Wielkopolski'),
(4,'Zielona Góra'),
(5,'£ódŸ'),
(6,'Kraków'),
(7,'Warszawa'),
(8,'Opole'),
(9,'Rzeszów'),
(10,'Bia³ystok'),
(11,'Gdañsk'),
(12,'Katowice'),
(13,'Kielce'),
(14,'Olsztyn'),
(15,'Poznañ'),
(16,'Szczecin'),
(7,'Wêgrów'),
(7,'Liw'),
(7,'Jartypory'),
(7,'Ruchna'),
(7,'Zawady'),
(7,'Miedzna');

GO
INSERT INTO [Klienci] 
VALUES
(19,'Kowalski','Jan','123-635-34-28',742895343),
(21,'Kamiñska','Joanna','465-879-88-96',744922783),
(21,'Nowak','Justyna','574-743-39-33',794734288),
(20,'Wiœniewski','Andrzej','475-874-44-34',764587778),
(23,'Kowalczyk','Joanna','90012005852',660823498),
(23,'Wójcik','Karol','563-736-34-34',743582977),
(24,'Zawada','Piotr','96051904897',592382334),
(22,'Badura','Micha³,','98112306842',258388459);
GO
INSERT INTO [Producenci] 
VALUES
('Nexler',12),
('Okpol',15),
('Simpson',3),
('GoodHome',6),
('Ytong',7),
('Hydro',4),
('Marley',2),
('Kreistel',13),
('Knauf',15),
('Atlas',5),
('OCYNKline',10),
('Termalica',5),
('PusteX',6),
('Lafarge',7),
('Fola',14),
('Seves',3),
('Soudal',9),
('Sopro',2),
('Lode',9),
('Kronospan',13),
('ZBB',1),
('Primacol',15);
GO
INSERT INTO [Kategorie] 
VALUES
('Pokrycia dachowe'),
('Systemy rynnowe'),
('Okna i wy³azy dachowe'),
('Sklejki'),
('Drewno konstrukcyjne'),
('P³yty surowe'),
('P³yty laminowane'),
('Modu³owe œcianki dzia³owe'),
('Ceg³y'),
('Bloczki'),
('Pustaki ceramiczne'),
('Pustaki szklane'),
('Nadpro¿a'),
('Zaprawy cementowe'),
('Zaprawy gipsowe'),
('Tynki'),
('Cementy, wapno i kruszywo'),
('Zbrojenie'),
('Podk³ady gruntuj¹ce'),
('Dodatki do zapraw i betonów');


GO
INSERT INTO [Produkty] 
VALUES
(1,1,'papa samoprzylepna 5m2',40,34.98,29.30),
(2,7,'pod³¹czenie do zbiornika',123,20.48,18.15),
(2,11,'hak rynnowy 127 ocynk',50,14.48,10.12),
(2,11,'denko do rynny z uszczelk¹ 127 ocynk',50,11.98,9.23),
(2,11,'rynna 127 ocynk',50,138.00,123.56),
(15,9,'cement Fix finish bia³y p1,5kg',111,12.98,10.04),
(15,10,'gotowa g³adŸ GTA p5kg',20,30.98,27.13),
(19,10,'podk³ad pod tynk silikonowo-silikatowy p15kg',50,178.00,169.00),
(6,6,'p³yta MDF 1200x600x18',80,70.98,68.15),
(9,19,'ceg³a klinkierowa czerwona',2400,1.98,1.20),
(10,5,'bloczek betonowy b25 36x24x12',422,5.88,4.39),
(16,8,'tynk mineralny baranek 1,5 bia³y p25kg',98,41.98,38.33),
(4,21,'sklejka antypoœlizgowa 18x1220x2400',33,529.73,500.00),
(20,17,'plastyfikator do zapraw MZ p5L',40,43.48,38.13),
(9,19,'ceg³a klinkierowa dr¹zona grafit',2400,3.98,2.80),
(12,16,'pustak szklany bezbarwny g³adki mat',211,30.48,28.40),
(15,9,'cement szybkowi¹¿¹cy Fix finish p1,5kg',120,19.98,16.02),
(14,8,'Wylewka samopoziomuj¹ca 417 p25kg',63,44.98,40.10),
(18,15,'prêt stalowy g³adki 8 p3m',300,37.98,33.16),
(5,3,'z³¹cze k¹towe 90x90x65',27,5.78,4.40),
(1,1,'masa asfaltowo-Kauczukowa p20kg',77,76.98,70.00),
(16,10,'tynk silikonowo-silikatowy kolor p25kg',128,178.00,134.25),
(19,8,'grunt pod tynk tynkolit-t 330 bia³y p20kg',44,118.00,100.00),
(19,8,'grunt pod tynk tynkolit-t 330 bia³y p7kg',20,53.98,48.00),
(3,2,'ko³nierz dachowy 78x140 h9',4,258.00,243.24),
(10,5,'bloczek betonowy 38x24x12',409,5.18,4.29),
(11,13,'bloczek betonowy fundamentowy 38x24x12',950,5.18,4.29),
(13,12,'kszta³tka U 24x24x59',123,23.48,20.00),
(18,15,'prêt stalowy g³adki 10 p3m',120,53.98,46.17),
(6,6,'p³yta MDF 800x400x18',77,35.48,32.09),
(7,20,'p³yta laminowana 18 dab skalny',100,254.63,248.22),
(14,8,'Szybki beton B-20 p25kg',69,11.48,10.12),
(17,14,'cement budowlany p22,5kg',220,13.98,10.00),
(17,14,'cement konstrukcyjny p22,5kg',245,15.98,12.00),
(2,7,'osadnik uniwersalny szary',45,56.98,49.99),
(2,7,'osadnik uniwersalny br¹zowy',45,56.98,49.99),
(14,18,'Wylewka samopoziomuj¹ca WS 3-70 p25kg',74,59.98,53.30),
(2,7,'osadnik uniwersalny czarny',45,56.98,49.99),
(5,3,'z³¹cze k¹towe 60x60x2x40',27,4.18,4.02),
(8,4,'zestaw œcianka modu³owa Alara',1,1940.44,1832.18),
(13,12,'belka nadpro¿owa 120x24',53,138.00,110.15),
(20,22,'plastyfikator zimowy do betonów ZM p1L',30,21.98,19.43),
(12,16,'pustak szklany matowy bezbarwny 1908',200,29.98,27.00),
(7,20,'p³yta laminowana 18 stone oak',100,232.95,218.15),
(3,2,'okno PCV 78x140',7,1198.00,1023.20),
(4,21,'sklejka antypoœlizgowa 12x1220x2400',33,410.68,400.01);


GO
INSERT INTO [Faktury] 
VALUES
(6,8,'F/MG/003327/22','05/13/2022'),
(6,1,'F/MG/003247/21','01/08/2021'),
(6,3,'F/MG/003321/22','01/27/2022'),
(7,3,'F/MG/003322/22','01/29/2022'),
(7,6,'F/MG/003323/22','02/04/2022'),
(6,2,'F/MG/003324/22','02/10/2022'),
(7,5,'F/MG/003325/22','02/21/2022'),
(7,4,'F/MG/003326/22','04/03/2022'),
(6,7,'F/MG/003248/21','05/19/2021');
GO
INSERT INTO [Zamowienia] 
VALUES
('ZM/MG/002001/22','05/15/2022',2),
('ZM/MG/002002/22','05/18/2022',3),
('ZM/MG/002003/22','05/20/2022',2),
('ZM/MG/002004/22','05/20/2022',3),
('ZM/MG/002005/22','05/21/2022',2),
('ZM/MG/002006/22','05/23/2022',3);



GO
INSERT INTO [Transakcje] 
VALUES
(NULL,1,2,4),
(1,NULL,4,5),
(2,NULL,24,3),
(3,NULL,20,6),
(NULL,2,1,14),
(NULL,3,10,24),
(NULL,4,2,3),
(4,NULL,33,11),
(5,NULL,1,6),
(NULL,5,5,4),
(NULL,6,18,2),
(6,NULL,20,10),
(NULL,7,30,1),
(NULL,8,9,4);

CREATE  OR ALTER VIEW Widok_Ksiegowej
AS
SELECT [Nazwisko],[Imie],[Nr_Konta],[Brutto] AS 'Zarobki',Nazwa AS 'Dzia³'
FROM Pracownik p JOIN Zarobki z 
ON p.Id_Pracownika = z.Id_Pracownika
JOIN Dzialy d
ON p.Id_Dzialu = d.Id_Dzialu;


CREATE OR ALTER VIEW Widok_Zamowien
AS 
SELECT [Numer_Zamowienia],[Data_Zamowienia],[Nazwa_Produktu],t.[Iloœæ],[Cena] AS 'Cena/szt',[Cena]*t.[Iloœæ] AS 'Cena do zap³aty',[Nazwisko]+' '+[Imie] AS Pracownik
FROM [dbo].[Zamowienia] z JOIN  [dbo].[Pracownik] p
ON z.Id_Pracownika = p.Id_Pracownika
JOIN [dbo].[Transakcje] t
ON z.Id_zamowienia = t.Id_Zamowienia
JOIN [dbo].[Produkty] pr
ON t.Id_Produktu = pr.Id_Produktu;

CREATE OR ALTER VIEW Widok_Faktury
AS
SELECT [Numer_Faktury],[Data_Wystaw],[Nazwa_Produktu],t.[Iloœæ],[Cena] AS 'Cena/szt',[Cena]*t.[Iloœæ] AS 'Cena do zap³aty',[Nazwisko]+' '+[Imie] AS Pracownik
FROM [dbo].[Faktury] f JOIN  [dbo].[Pracownik] p
ON f.Id_Pracownika = p.Id_Pracownika
JOIN [dbo].[Transakcje] t
ON f.Id_Faktury = t.Id_Faktury
JOIN [dbo].[Produkty] pr
ON t.Id_Produktu = pr.Id_Produktu;

CREATE OR ALTER VIEW Widok_Produktów 
AS
SELECT [Nazwa_kategorii],[Nazwa_Produktu],[Nazwa_Producenta],[Iloœæ],[Cena],[Cena_Zakupu]
FROM [dbo].[Produkty] p
JOIN [dbo].[Kategorie] k
ON p.Id_Kategorii = k.Id_Kategorii
JOIN [dbo].[Producenci] pr
ON pr.Id_Producenta = p.Id_Producenta;

CREATE OR ALTER VIEW Widok_Faktur_klienta
AS
SELECT [Nazwisko],[Imie],[Nip],[Nr_Tel],[Numer_Faktury],[Data_Wystaw]
FROM [dbo].[Klienci] k
JOIN [dbo].[Faktury] f
ON k.Id_Klienta = f.Id_Klienta;
GO
CREATE INDEX Ix_nazwiskoimie ON [dbo].[Pracownik]([Nazwisko],[Imie]);
GO
CREATE UNIQUE INDEX Ix_Nr_konta ON [dbo].[Pracownik]([Nr_Konta]);
GO
CREATE INDEX Ix_nazwiskoimie ON [dbo].[Klienci]([Nazwisko],[Imie]);
GO
CREATE INDEX Ix_Nazwa_Produktu ON [dbo].[Produkty]([Nazwa_Produktu]);
GO


CREATE ROLE Rachunkowosc;
GO
CREATE ROLE Kierownik;
GO
CREATE ROLE Sprzedawca;
GO
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Zarobki] TO Rachunkowosc;
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Urlop] TO Rachunkowosc;
GRANT SELECT ON [dbo].[Pracownik] TO Rachunkowosc;
GRANT SELECT ON [dbo].[Widok_Ksiegowej] TO Rachunkowosc;
GO
GRANT SELECT ON [dbo].[Dzialy] TO Kierownik;
GRANT SELECT, UPDATE, INSERT ON [dbo].[Faktury] TO Kierownik;
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Kategorie] TO Kierownik;
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Klienci] TO Kierownik;
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Miasto] TO Kierownik;
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Pracownik] TO Kierownik;
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Producenci] TO Kierownik;
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Produkty] TO Kierownik;
GRANT SELECT, UPDATE, INSERT ON [dbo].[Transakcje] TO Kierownik;
GRANT SELECT ON [dbo].[Urlop] TO Kierownik;
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Wojewodztwa] TO Kierownik;
GRANT SELECT, UPDATE, INSERT ON [dbo].[Zamowienia] TO Kierownik;
GRANT SELECT, UPDATE ON [dbo].[Zarobki] TO Kierownik;
GRANT SELECT ON [dbo].[Widok_Faktur_klienta] TO Kierownik;
GRANT SELECT ON [dbo].[Widok_Faktury] TO Kierownik;
GRANT SELECT ON [dbo].[Widok_Produktów] TO Kierownik;
GRANT SELECT ON [dbo].[Widok_Zamowien] TO Kierownik;
GO
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Faktury] TO Sprzedawca;
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Transakcje] TO Sprzedawca;
GRANT SELECT, UPDATE, INSERT, DELETE ON [dbo].[Klienci] TO Sprzedawca;
GRANT SELECT ON [dbo].[Produkty] TO Sprzedawca;
GRANT SELECT ON [dbo].[Producenci] TO Sprzedawca;
GRANT SELECT ON [dbo].[Kategorie] TO Sprzedawca;
GRANT SELECT ON [dbo].[Miasto] TO Sprzedawca;
GRANT SELECT ON [dbo].[Wojewodztwa] TO Sprzedawca;
GRANT SELECT ON [dbo].[Widok_Faktur_klienta] TO Sprzedawca;
GRANT SELECT ON [dbo].[Widok_Faktury] TO Sprzedawca;
GRANT SELECT ON [dbo].[Widok_Produktów] TO Sprzedawca;
GO
CREATE LOGIN Ksiegowa1
WITH PASSWORD ='zaq1@WSX';
GO
CREATE LOGIN Kierownikhali1
WITH PASSWORD ='halaQ123';
GO
CREATE LOGIN Sprzedawca1
WITH PASSWORD ='qw3RTY';
GO

CREATE USER  Ksiegowa_1  FOR LOGIN Ksiegowa1; 
CREATE USER  Kierownik_Hali_1  FOR LOGIN Kierownikhali1;
CREATE USER  Sprzedawca_1  FOR LOGIN Sprzedawca1;
GO
ALTER ROLE Rachunkowosc ADD MEMBER Ksiegowa_1; 
GO
ALTER ROLE Kierownik ADD MEMBER Kierownik_Hali_1;
GO
ALTER ROLE Sprzedawca ADD MEMBER Sprzedawca_1;





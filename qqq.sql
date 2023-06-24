DROP TABLE Pes CASCADE CONSTRAINTS;
DROP TABLE Oceneni CASCADE CONSTRAINTS;
DROP TABLE Test CASCADE CONSTRAINTS;
DROP TABLE Ockovani CASCADE CONSTRAINTS;
DROP TABLE Plemeno CASCADE CONSTRAINTS;
DROP TABLE Zeme_puvodu CASCADE CONSTRAINTS;
DROP TABLE Zamestnanec CASCADE CONSTRAINTS;
DROP TABLE Zakaznik CASCADE CONSTRAINTS;
DROP TABLE Uzivatel CASCADE CONSTRAINTS;
CREATE TABLE Pes (
cislo INTEGER,
jmeno VARCHAR(20),
pohlavi VARCHAR(20) NOT NULL,
cena DECIMAL(10,2),
datum_prodeje DATE,
je_predkem INTEGER,
pecovatel INTEGER,
majitel INTEGER,
plemeno INTEGER
);

CREATE TABLE Oceneni (
ID INTEGER,
nazev VARCHAR(200) NOT NULL,
datum DATE NOT NULL,
ziskal INTEGER
);

CREATE TABLE Test (
ID INTEGER,
datum DATE NOT NULL,
hmotnost INTEGER,
cislo_psa INTEGER
);

CREATE TABLE Ockovani (
ID INTEGER,
datum_ockovani DATE NOT NULL,
datum_konce_ucinosti DATE NOT NULL,
cislo_psa INTEGER,
provedl INTEGER
);

CREATE TABLE Plemeno (
ID INTEGER,
nazev VARCHAR(100) NOT NULL,
prumerna_vyska INTEGER,
prumerna_hmotnost INTEGER,
zeme_puvodu INTEGER
);

CREATE TABLE Zeme_puvodu (
ID INTEGER,
nazev VARCHAR(80) NOT NULL,
kontinent VARCHAR(20) NOT NULL
);

CREATE TABLE Uzivatel (
ID INTEGER,
jmeno VARCHAR(300) NOT NULL,
prijmeni VARCHAR(300) NOT NULL,
telefon VARCHAR(22),
email VARCHAR(254) NOT NULL
);

CREATE TABLE Zamestnanec (
ID INTEGER,
datum_nastupu DATE NOT NULL,
pozice VARCHAR(20) NOT NULL,
plat DECIMAL(10,2) NOT NULL
);

CREATE TABLE Zakaznik (
ID INTEGER,
ICO INTEGER UNIQUE,
CHECK (regexp_like(ICO, '^[0-9]{8}$'))
);

ALTER TABLE Pes ADD CONSTRAINT PK_pes PRIMARY KEY (cislo);
ALTER TABLE Oceneni ADD CONSTRAINT PK_oceneni PRIMARY KEY (id);
ALTER TABLE Test ADD CONSTRAINT PK_test PRIMARY KEY (id);
ALTER TABLE Ockovani ADD CONSTRAINT PK_ockovani PRIMARY KEY (id);
ALTER TABLE Plemeno ADD CONSTRAINT PK_plemeno PRIMARY KEY (id);
ALTER TABLE Zeme_puvodu ADD CONSTRAINT PK_zeme_puvodu PRIMARY KEY (id);
ALTER TABLE Uzivatel ADD CONSTRAINT PK_uzivatel PRIMARY KEY (id);
ALTER TABLE Zamestnanec ADD CONSTRAINT FK_zamestnanec_id FOREIGN KEY (id) REFERENCES Uzivatel ON DELETE CASCADE;
ALTER TABLE Zakaznik ADD CONSTRAINT FK_zakaznik_id FOREIGN KEY (id) REFERENCES Uzivatel ON DELETE CASCADE;
ALTER TABLE Pes ADD CONSTRAINT FK_pes_je_predkem FOREIGN KEY (je_predkem) REFERENCES Pes ON DELETE CASCADE;
ALTER TABLE Pes ADD CONSTRAINT FK_pes_pecovatel FOREIGN KEY (pecovatel) REFERENCES Uzivatel;
ALTER TABLE Pes ADD CONSTRAINT FK_pes_majitel FOREIGN KEY (majitel) REFERENCES Uzivatel;
ALTER TABLE Pes ADD CONSTRAINT FK_pes_plemeno FOREIGN KEY (plemeno) REFERENCES Plemeno ON DELETE CASCADE;
ALTER TABLE Oceneni ADD CONSTRAINT FK_oceneni_ziskal FOREIGN KEY (ziskal) REFERENCES Pes ON DELETE CASCADE;
ALTER TABLE Test ADD CONSTRAINT FK_test_cislo_psa FOREIGN KEY (cislo_psa) REFERENCES Pes ON DELETE CASCADE;
ALTER TABLE Ockovani ADD CONSTRAINT FK_ockovani_cislo_psa FOREIGN KEY (cislo_psa) REFERENCES Pes ON DELETE CASCADE;
ALTER TABLE Ockovani ADD CONSTRAINT FK_ockovani_provedl FOREIGN KEY (provedl) REFERENCES Uzivatel;
ALTER TABLE Plemeno ADD CONSTRAINT FK_plemeno_zeme_puvodu FOREIGN KEY (zeme_puvodu) REFERENCES Zeme_puvodu ON DELETE CASCADE;
INSERT INTO Pes
VALUES(0,'Gordon','fena',49000,TO_DATE('2000.01.11', 'yyyy.mm.dd'),NULL,NULL,NULL,NULL);
INSERT INTO Oceneni
VALUES(0,'Psí závody 2021',TO_DATE('2011.02.14', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(0,TO_DATE('1995.01.25', 'yyyy.mm.dd'),22,NULL);
INSERT INTO Ockovani
VALUES(0,TO_DATE('2000.09.16', 'yyyy.mm.dd'),TO_DATE('2006.04.14', 'yyyy.mm.dd'),NULL,NULL);
INSERT INTO Plemeno
VALUES(0,'Akita-Inu',64,32,NULL);
INSERT INTO Zeme_puvodu
VALUES(0,'Libya','Antarctica');
INSERT INTO Uzivatel
VALUES(0,'Brianne','Zoltek','726557636','pkNxQ@gmail.com');
INSERT INTO Zakaznik
VALUES(0,48557753);
INSERT INTO Pes
VALUES(1,'Mary','fena',36000,TO_DATE('2008.02.23', 'yyyy.mm.dd'),NULL,NULL,NULL,NULL);
INSERT INTO Oceneni
VALUES(1,'Virtual 4ALL',TO_DATE('2011.01.11', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(1,TO_DATE('2008.11.01', 'yyyy.mm.dd'),19,NULL);
INSERT INTO Ockovani
VALUES(1,TO_DATE('2003.12.21', 'yyyy.mm.dd'),TO_DATE('2008.05.05', 'yyyy.mm.dd'),NULL,NULL);
INSERT INTO Plemeno
VALUES(1,'Tibetský španěl',46,15,NULL);
INSERT INTO Zeme_puvodu
VALUES(1,'Panama','Europe');
INSERT INTO Uzivatel
VALUES(1,'Mary','Stewart','758575846','XGeMNzLCucjUhwVy@gmail.com');
INSERT INTO Zamestnanec
VALUES(1,TO_DATE('2005.03.24', 'yyyy.mm.dd'),'účetní',22000);
INSERT INTO Pes
VALUES(2,'Arnette','fena',25000,TO_DATE('1990.11.17', 'yyyy.mm.dd'),NULL,NULL,1,1);
INSERT INTO Oceneni
VALUES(2,'Czech DOG race',TO_DATE('2008.08.19', 'yyyy.mm.dd'),1);
INSERT INTO Test
VALUES(2,TO_DATE('1992.06.11', 'yyyy.mm.dd'),32,NULL);
INSERT INTO Ockovani
VALUES(2,TO_DATE('2011.10.28', 'yyyy.mm.dd'),TO_DATE('2013.01.25', 'yyyy.mm.dd'),NULL,1);
INSERT INTO Plemeno
VALUES(2,'Lapinkoira',78,10,NULL);
INSERT INTO Zeme_puvodu
VALUES(2,'Cocos Islands','Europe');
INSERT INTO Uzivatel
VALUES(2,'Opal','Faw','741060288','pWDyda@gmail.com');
INSERT INTO Zakaznik
VALUES(2,96169444);
INSERT INTO Pes
VALUES(3,'Vanessa','fena',23000,TO_DATE('1999.01.01', 'yyyy.mm.dd'),NULL,NULL,NULL,NULL);
INSERT INTO Oceneni
VALUES(3,'Závody psích spřežení',TO_DATE('2002.06.06', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(3,TO_DATE('1991.07.19', 'yyyy.mm.dd'),38,2);
INSERT INTO Ockovani
VALUES(3,TO_DATE('2008.11.25', 'yyyy.mm.dd'),TO_DATE('2014.11.10', 'yyyy.mm.dd'),NULL,1);
INSERT INTO Plemeno
VALUES(3,'Mexický naháč',65,15,NULL);
INSERT INTO Zeme_puvodu
VALUES(3,'Macau','America');
INSERT INTO Uzivatel
VALUES(3,'Christa','Errington','786039701','HcRsQIkNalo@gmail.com');
INSERT INTO Zamestnanec
VALUES(3,TO_DATE('2011.01.25', 'yyyy.mm.dd'),'ošetřovatel',21000);
INSERT INTO Pes
VALUES(4,'Mary','pes',30000,TO_DATE('1993.11.10', 'yyyy.mm.dd'),1,NULL,NULL,NULL);
INSERT INTO Oceneni
VALUES(4,'Pohár Mistra Maleniv',TO_DATE('2010.09.22', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(4,TO_DATE('2000.08.22', 'yyyy.mm.dd'),9,NULL);
INSERT INTO Ockovani
VALUES(4,TO_DATE('2009.01.23', 'yyyy.mm.dd'),TO_DATE('2012.01.04', 'yyyy.mm.dd'),3,2);
INSERT INTO Plemeno
VALUES(4,'Modrý gaskoňský baset',28,23,NULL);
INSERT INTO Zeme_puvodu
VALUES(4,'Cayman Islands','Asia');
INSERT INTO Uzivatel
VALUES(4,'Phyllis','Mitchell','791624702','YOvuoB@gmail.com');
INSERT INTO Zakaznik
VALUES(4,61548542);
INSERT INTO Pes
VALUES(5,'Heather','fena',59000,TO_DATE('1994.04.17', 'yyyy.mm.dd'),NULL,3,NULL,3);
INSERT INTO Oceneni
VALUES(5,'Pohár Mistra Maleniv',TO_DATE('1995.01.29', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(5,TO_DATE('2001.06.23', 'yyyy.mm.dd'),36,NULL);
INSERT INTO Ockovani
VALUES(5,TO_DATE('2009.08.29', 'yyyy.mm.dd'),TO_DATE('2012.11.19', 'yyyy.mm.dd'),1,3);
INSERT INTO Plemeno
VALUES(5,'Sheltie',57,9,NULL);
INSERT INTO Zeme_puvodu
VALUES(5,'Bolivia','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(5,'Kathleen','Cundiff','785375120','RlTxVWHmsAYp@gmail.com');
INSERT INTO Zamestnanec
VALUES(5,TO_DATE('1999.12.21', 'yyyy.mm.dd'),'vedoucí',21000);
INSERT INTO Pes
VALUES(6,'Samuel','fena',48000,TO_DATE('1998.05.22', 'yyyy.mm.dd'),NULL,NULL,5,4);
INSERT INTO Oceneni
VALUES(6,'Extreme Dog Race',TO_DATE('1994.05.03', 'yyyy.mm.dd'),4);
INSERT INTO Test
VALUES(6,TO_DATE('1997.04.01', 'yyyy.mm.dd'),27,5);
INSERT INTO Ockovani
VALUES(6,TO_DATE('1993.09.01', 'yyyy.mm.dd'),TO_DATE('1995.09.08', 'yyyy.mm.dd'),4,5);
INSERT INTO Plemeno
VALUES(6,'Francouzský ohař krátkosrstý pyrenejského typu',24,15,3);
INSERT INTO Zeme_puvodu
VALUES(6,'Macau','Africa');
INSERT INTO Uzivatel
VALUES(6,'Chere','Zimmer','745357998','QxCrukjcTQ@gmail.com');
INSERT INTO Zakaznik
VALUES(6,46446744);
INSERT INTO Pes
VALUES(7,'Janice','pes',29000,TO_DATE('2003.05.07', 'yyyy.mm.dd'),1,6,4,2);
INSERT INTO Oceneni
VALUES(7,'STEEPLECHASE',TO_DATE('1999.09.17', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(7,TO_DATE('2006.12.05', 'yyyy.mm.dd'),8,4);
INSERT INTO Ockovani
VALUES(7,TO_DATE('2007.01.02', 'yyyy.mm.dd'),TO_DATE('2008.05.09', 'yyyy.mm.dd'),4,6);
INSERT INTO Plemeno
VALUES(7,'Německý ovčák',56,9,2);
INSERT INTO Zeme_puvodu
VALUES(7,'St.Pierre','Antarctica');
INSERT INTO Uzivatel
VALUES(7,'Joseph','Robertson','762774844','OiTaRqqwanqnE@gmail.com');
INSERT INTO Zamestnanec
VALUES(7,TO_DATE('2005.04.21', 'yyyy.mm.dd'),'účetní',21000);
INSERT INTO Pes
VALUES(8,'William','pes',60000,TO_DATE('2000.08.09', 'yyyy.mm.dd'),6,2,1,5);
INSERT INTO Oceneni
VALUES(8,'Psí závody 2021',TO_DATE('1992.08.31', 'yyyy.mm.dd'),5);
INSERT INTO Test
VALUES(8,TO_DATE('1995.06.14', 'yyyy.mm.dd'),25,NULL);
INSERT INTO Ockovani
VALUES(8,TO_DATE('1994.03.27', 'yyyy.mm.dd'),TO_DATE('1994.12.28', 'yyyy.mm.dd'),3,NULL);
INSERT INTO Plemeno
VALUES(8,'Velký švýcarský salašnický pes',28,30,NULL);
INSERT INTO Zeme_puvodu
VALUES(8,'Slovakia','Europe');
INSERT INTO Uzivatel
VALUES(8,'Kathryn','Bailey','756694799','aJDLvYb@gmail.com');
INSERT INTO Zakaznik
VALUES(8,55648813);
INSERT INTO Pes
VALUES(9,'Cheryl','pes',50000,TO_DATE('1992.02.11', 'yyyy.mm.dd'),4,1,6,NULL);
INSERT INTO Oceneni
VALUES(9,'Závody psích spřežení',TO_DATE('1998.10.25', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(9,TO_DATE('2002.02.09', 'yyyy.mm.dd'),40,1);
INSERT INTO Ockovani
VALUES(9,TO_DATE('1997.05.09', 'yyyy.mm.dd'),TO_DATE('1998.04.02', 'yyyy.mm.dd'),5,2);
INSERT INTO Plemeno
VALUES(9,'Welsh Corgi Pembroke',70,38,7);
INSERT INTO Zeme_puvodu
VALUES(9,'Anguilla','Antarctica');
INSERT INTO Uzivatel
VALUES(9,'Mozelle','Burrus','725388189','BwTbgsmrrqYECTnG@gmail.com');
INSERT INTO Zamestnanec
VALUES(9,TO_DATE('1995.11.21', 'yyyy.mm.dd'),'uklízeč',16000);
INSERT INTO Pes
VALUES(10,'Brendan','fena',69000,TO_DATE('1997.05.06', 'yyyy.mm.dd'),7,9,3,1);
INSERT INTO Oceneni
VALUES(10,'Závody psích spřežení',TO_DATE('2009.12.08', 'yyyy.mm.dd'),8);
INSERT INTO Test
VALUES(10,TO_DATE('1991.12.23', 'yyyy.mm.dd'),37,2);
INSERT INTO Ockovani
VALUES(10,TO_DATE('2005.03.21', 'yyyy.mm.dd'),TO_DATE('2006.09.30', 'yyyy.mm.dd'),9,9);
INSERT INTO Plemeno
VALUES(10,'Sibiřský husky',30,20,2);
INSERT INTO Zeme_puvodu
VALUES(10,'Liberia','Africa');
INSERT INTO Uzivatel
VALUES(10,'Anna','Courtney','714724719','sxFWQXN@gmail.com');
INSERT INTO Zakaznik
VALUES(10,49754432);
INSERT INTO Pes
VALUES(11,'Albert','fena',57000,TO_DATE('2005.01.09', 'yyyy.mm.dd'),3,10,1,NULL);
INSERT INTO Oceneni
VALUES(11,'Psí závody 2021',TO_DATE('1994.07.05', 'yyyy.mm.dd'),3);
INSERT INTO Test
VALUES(11,TO_DATE('2002.01.26', 'yyyy.mm.dd'),37,6);
INSERT INTO Ockovani
VALUES(11,TO_DATE('1997.05.08', 'yyyy.mm.dd'),TO_DATE('2002.07.26', 'yyyy.mm.dd'),5,6);
INSERT INTO Plemeno
VALUES(11,'Wetterhound',24,16,4);
INSERT INTO Zeme_puvodu
VALUES(11,'Canada','Asia');
INSERT INTO Uzivatel
VALUES(11,'Rufus','Gaskin','715963700','nhdfQEreHWL@gmail.com');
INSERT INTO Zamestnanec
VALUES(11,TO_DATE('2008.08.19', 'yyyy.mm.dd'),'ošetřovatel',23000);
INSERT INTO Pes
VALUES(12,'Carolyn','fena',8000,TO_DATE('1998.07.28', 'yyyy.mm.dd'),6,9,7,7);
INSERT INTO Oceneni
VALUES(12,'Virtual 4ALL',TO_DATE('1995.05.02', 'yyyy.mm.dd'),2);
INSERT INTO Test
VALUES(12,TO_DATE('1998.12.16', 'yyyy.mm.dd'),23,1);
INSERT INTO Ockovani
VALUES(12,TO_DATE('1992.10.05', 'yyyy.mm.dd'),TO_DATE('1996.09.25', 'yyyy.mm.dd'),8,NULL);
INSERT INTO Plemeno
VALUES(12,'Anglický kokršpaněl',34,28,7);
INSERT INTO Zeme_puvodu
VALUES(12,'Liechtenstein','Asia');
INSERT INTO Uzivatel
VALUES(12,'Donna','Hendrickson','758835653','wmbPRZSUwkgejuqmyrB@gmail.com');
INSERT INTO Zakaznik
VALUES(12,14235121);
INSERT INTO Pes
VALUES(13,'Richard','fena',69000,TO_DATE('2010.03.05', 'yyyy.mm.dd'),12,11,NULL,6);
INSERT INTO Oceneni
VALUES(13,'Závody psích spřežení',TO_DATE('1997.05.16', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(13,TO_DATE('2008.07.27', 'yyyy.mm.dd'),31,4);
INSERT INTO Ockovani
VALUES(13,TO_DATE('2003.10.05', 'yyyy.mm.dd'),TO_DATE('2004.07.07', 'yyyy.mm.dd'),7,10);
INSERT INTO Plemeno
VALUES(13,'Shilohský ovčák',36,37,NULL);
INSERT INTO Zeme_puvodu
VALUES(13,'Virgin Islands (British)','Africa');
INSERT INTO Uzivatel
VALUES(13,'Elizabeth','Aquino','742267975','EwgwFD@gmail.com');
INSERT INTO Zamestnanec
VALUES(13,TO_DATE('1991.09.26', 'yyyy.mm.dd'),'ošetřovatel',22000);
INSERT INTO Pes
VALUES(14,'Barbie','fena',69000,TO_DATE('1992.07.31', 'yyyy.mm.dd'),11,4,1,9);
INSERT INTO Oceneni
VALUES(14,'Virtual 4ALL',TO_DATE('1995.10.22', 'yyyy.mm.dd'),6);
INSERT INTO Test
VALUES(14,TO_DATE('2009.02.10', 'yyyy.mm.dd'),40,2);
INSERT INTO Ockovani
VALUES(14,TO_DATE('2002.02.12', 'yyyy.mm.dd'),TO_DATE('2008.04.29', 'yyyy.mm.dd'),2,5);
INSERT INTO Plemeno
VALUES(14,'Black and tan Coonhound',77,40,4);
INSERT INTO Zeme_puvodu
VALUES(14,'Kenya','America');
INSERT INTO Uzivatel
VALUES(14,'Lewis','Sesler','738499289','ugeyLcGBBJ@gmail.com');
INSERT INTO Zakaznik
VALUES(14,45376711);
INSERT INTO Pes
VALUES(15,'Jared','pes',12000,TO_DATE('1995.02.24', 'yyyy.mm.dd'),3,NULL,9,11);
INSERT INTO Oceneni
VALUES(15,'Mushing závody',TO_DATE('1993.08.28', 'yyyy.mm.dd'),8);
INSERT INTO Test
VALUES(15,TO_DATE('1998.10.26', 'yyyy.mm.dd'),15,2);
INSERT INTO Ockovani
VALUES(15,TO_DATE('2008.11.01', 'yyyy.mm.dd'),TO_DATE('2010.02.11', 'yyyy.mm.dd'),12,4);
INSERT INTO Plemeno
VALUES(15,'Jugoslávský planinský honič',41,17,1);
INSERT INTO Zeme_puvodu
VALUES(15,'Uganda','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(15,'Kristine','Matos','786428447','psmUBbXyTaHPeQbDz@gmail.com');
INSERT INTO Zamestnanec
VALUES(15,TO_DATE('2009.09.14', 'yyyy.mm.dd'),'uklízeč',30000);
INSERT INTO Pes
VALUES(16,'Amanda','pes',5000,TO_DATE('1995.07.22', 'yyyy.mm.dd'),1,7,2,15);
INSERT INTO Oceneni
VALUES(16,'Pohár Mistra Maleniv',TO_DATE('1991.02.28', 'yyyy.mm.dd'),3);
INSERT INTO Test
VALUES(16,TO_DATE('1998.04.13', 'yyyy.mm.dd'),39,6);
INSERT INTO Ockovani
VALUES(16,TO_DATE('2008.05.03', 'yyyy.mm.dd'),TO_DATE('2010.01.26', 'yyyy.mm.dd'),9,1);
INSERT INTO Plemeno
VALUES(16,'Velký hrubosrstý vendéeský baset',44,14,NULL);
INSERT INTO Zeme_puvodu
VALUES(16,'Iraq','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(16,'Charles','Mummey','770428366','ItyRChkR@gmail.com');
INSERT INTO Zakaznik
VALUES(16,12184496);
INSERT INTO Pes
VALUES(17,'Robert','pes',11000,TO_DATE('1995.07.23', 'yyyy.mm.dd'),7,10,12,5);
INSERT INTO Oceneni
VALUES(17,'Virtual 4ALL',TO_DATE('2003.10.19', 'yyyy.mm.dd'),16);
INSERT INTO Test
VALUES(17,TO_DATE('2006.02.25', 'yyyy.mm.dd'),7,16);
INSERT INTO Ockovani
VALUES(17,TO_DATE('1994.08.03', 'yyyy.mm.dd'),TO_DATE('2002.02.03', 'yyyy.mm.dd'),3,13);
INSERT INTO Plemeno
VALUES(17,'Velký modrý gaskoňský honič',86,33,2);
INSERT INTO Zeme_puvodu
VALUES(17,'Austria','Antarctica');
INSERT INTO Uzivatel
VALUES(17,'Michael','Bassett','746049543','RfWpGUeKkQnHXz@gmail.com');
INSERT INTO Zamestnanec
VALUES(17,TO_DATE('1994.05.28', 'yyyy.mm.dd'),'uklízeč',18000);
INSERT INTO Pes
VALUES(18,'Tommy','fena',13000,TO_DATE('2005.08.08', 'yyyy.mm.dd'),11,NULL,6,13);
INSERT INTO Oceneni
VALUES(18,'Mushing závody',TO_DATE('2004.01.06', 'yyyy.mm.dd'),14);
INSERT INTO Test
VALUES(18,TO_DATE('2003.04.17', 'yyyy.mm.dd'),29,NULL);
INSERT INTO Ockovani
VALUES(18,TO_DATE('2003.04.15', 'yyyy.mm.dd'),TO_DATE('2004.09.10', 'yyyy.mm.dd'),5,17);
INSERT INTO Plemeno
VALUES(18,'Krašský pastevecký pes',81,28,13);
INSERT INTO Zeme_puvodu
VALUES(18,'Reunion','Antarctica');
INSERT INTO Uzivatel
VALUES(18,'Lena','Culver','700791660','oixUxtnXUhLENaayj@gmail.com');
INSERT INTO Zakaznik
VALUES(18,86454991);
INSERT INTO Pes
VALUES(19,'Richard','fena',47000,TO_DATE('2007.03.29', 'yyyy.mm.dd'),11,2,10,1);
INSERT INTO Oceneni
VALUES(19,'Mushing závody',TO_DATE('2000.03.30', 'yyyy.mm.dd'),1);
INSERT INTO Test
VALUES(19,TO_DATE('2000.04.23', 'yyyy.mm.dd'),9,10);
INSERT INTO Ockovani
VALUES(19,TO_DATE('2003.08.02', 'yyyy.mm.dd'),TO_DATE('2010.06.29', 'yyyy.mm.dd'),8,3);
INSERT INTO Plemeno
VALUES(19,'Tibetský teriér',34,29,18);
INSERT INTO Zeme_puvodu
VALUES(19,'Slovakia','Europe');
INSERT INTO Uzivatel
VALUES(19,'Christina','Acosta','748777131','nIAFIwer@gmail.com');
INSERT INTO Zamestnanec
VALUES(19,TO_DATE('2001.03.07', 'yyyy.mm.dd'),'vedoucí',28000);
INSERT INTO Pes
VALUES(20,'Charles','fena',33000,TO_DATE('2010.08.28', 'yyyy.mm.dd'),14,18,6,18);
INSERT INTO Oceneni
VALUES(20,'Czech DOG race',TO_DATE('1993.09.01', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(20,TO_DATE('1994.06.06', 'yyyy.mm.dd'),30,1);
INSERT INTO Ockovani
VALUES(20,TO_DATE('2007.08.04', 'yyyy.mm.dd'),TO_DATE('2014.11.27', 'yyyy.mm.dd'),2,14);
INSERT INTO Plemeno
VALUES(20,'Haldenův honič',53,15,11);
INSERT INTO Zeme_puvodu
VALUES(20,'Singapore','Antarctica');
INSERT INTO Uzivatel
VALUES(20,'Frances','Harper','753736719','oPJGOOG@gmail.com');
INSERT INTO Zakaznik
VALUES(20,19491562);
INSERT INTO Pes
VALUES(21,'Teresa','pes',54000,TO_DATE('2002.06.24', 'yyyy.mm.dd'),2,6,17,NULL);
INSERT INTO Oceneni
VALUES(21,'Extreme Dog Race',TO_DATE('2005.01.15', 'yyyy.mm.dd'),17);
INSERT INTO Test
VALUES(21,TO_DATE('1999.06.27', 'yyyy.mm.dd'),28,18);
INSERT INTO Ockovani
VALUES(21,TO_DATE('2010.02.12', 'yyyy.mm.dd'),TO_DATE('2010.11.19', 'yyyy.mm.dd'),19,13);
INSERT INTO Plemeno
VALUES(21,'Foxteriér drsnosrstý',35,33,1);
INSERT INTO Zeme_puvodu
VALUES(21,'Faroe Islands','America');
INSERT INTO Uzivatel
VALUES(21,'Charles','Carter','758193975','mZIGIjVfOldyff@gmail.com');
INSERT INTO Zamestnanec
VALUES(21,TO_DATE('1992.05.15', 'yyyy.mm.dd'),'ošetřovatel',21000);
INSERT INTO Pes
VALUES(22,'Robert','fena',38000,TO_DATE('2008.08.29', 'yyyy.mm.dd'),6,8,NULL,2);
INSERT INTO Oceneni
VALUES(22,'Czech DOG race',TO_DATE('1996.12.15', 'yyyy.mm.dd'),16);
INSERT INTO Test
VALUES(22,TO_DATE('2002.01.01', 'yyyy.mm.dd'),27,11);
INSERT INTO Ockovani
VALUES(22,TO_DATE('1994.04.07', 'yyyy.mm.dd'),TO_DATE('1996.08.16', 'yyyy.mm.dd'),6,16);
INSERT INTO Plemeno
VALUES(22,'Kanaánský pes',60,11,17);
INSERT INTO Zeme_puvodu
VALUES(22,'Virgin Islands (British)','Europe');
INSERT INTO Uzivatel
VALUES(22,'David','Ingrum','762597408','IGttNCsNblYMvXTSS@gmail.com');
INSERT INTO Zakaznik
VALUES(22,39456751);
INSERT INTO Pes
VALUES(23,'Mary','fena',5000,TO_DATE('2005.01.10', 'yyyy.mm.dd'),3,2,6,12);
INSERT INTO Oceneni
VALUES(23,'STEEPLECHASE',TO_DATE('1990.11.23', 'yyyy.mm.dd'),10);
INSERT INTO Test
VALUES(23,TO_DATE('2000.08.25', 'yyyy.mm.dd'),29,2);
INSERT INTO Ockovani
VALUES(23,TO_DATE('2005.11.20', 'yyyy.mm.dd'),TO_DATE('2008.12.29', 'yyyy.mm.dd'),4,NULL);
INSERT INTO Plemeno
VALUES(23,'Australský teriér',42,34,1);
INSERT INTO Zeme_puvodu
VALUES(23,'French Polynesia','Europe');
INSERT INTO Uzivatel
VALUES(23,'Robert','Booth','728800752','itgNHlzBT@gmail.com');
INSERT INTO Zamestnanec
VALUES(23,TO_DATE('1999.04.30', 'yyyy.mm.dd'),'vedoucí',15000);
INSERT INTO Pes
VALUES(24,'Amy','fena',69000,TO_DATE('2006.10.12', 'yyyy.mm.dd'),18,8,23,12);
INSERT INTO Oceneni
VALUES(24,'Závody psích spřežení',TO_DATE('2006.11.15', 'yyyy.mm.dd'),21);
INSERT INTO Test
VALUES(24,TO_DATE('2000.11.18', 'yyyy.mm.dd'),12,18);
INSERT INTO Ockovani
VALUES(24,TO_DATE('1993.01.29', 'yyyy.mm.dd'),TO_DATE('1996.11.14', 'yyyy.mm.dd'),7,14);
INSERT INTO Plemeno
VALUES(24,'Argentinská doga',86,11,22);
INSERT INTO Zeme_puvodu
VALUES(24,'Tokelau','Asia');
INSERT INTO Uzivatel
VALUES(24,'Leslie','Wenrich','730962297','jeyBddoFRpcOdyPviq@gmail.com');
INSERT INTO Zakaznik
VALUES(24,26993972);
INSERT INTO Pes
VALUES(25,'Roy','pes',51000,TO_DATE('2001.01.16', 'yyyy.mm.dd'),2,12,12,5);
INSERT INTO Oceneni
VALUES(25,'Závody psích spřežení',TO_DATE('2003.07.06', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(25,TO_DATE('2007.01.17', 'yyyy.mm.dd'),40,7);
INSERT INTO Ockovani
VALUES(25,TO_DATE('2006.12.19', 'yyyy.mm.dd'),TO_DATE('2014.08.01', 'yyyy.mm.dd'),6,14);
INSERT INTO Plemeno
VALUES(25,'Dunker',68,7,8);
INSERT INTO Zeme_puvodu
VALUES(25,'Syrian Arab Republic','Asia');
INSERT INTO Uzivatel
VALUES(25,'Laura','Jackson','762536311','UKGGQsWY@gmail.com');
INSERT INTO Zamestnanec
VALUES(25,TO_DATE('2011.08.23', 'yyyy.mm.dd'),'uklízeč',16000);
INSERT INTO Pes
VALUES(26,'Karol','fena',17000,TO_DATE('2009.03.14', 'yyyy.mm.dd'),4,2,25,17);
INSERT INTO Oceneni
VALUES(26,'Extreme Dog Race',TO_DATE('2004.08.03', 'yyyy.mm.dd'),22);
INSERT INTO Test
VALUES(26,TO_DATE('2001.04.18', 'yyyy.mm.dd'),39,18);
INSERT INTO Ockovani
VALUES(26,TO_DATE('2002.11.06', 'yyyy.mm.dd'),TO_DATE('2003.10.05', 'yyyy.mm.dd'),10,NULL);
INSERT INTO Plemeno
VALUES(26,'Anglický špringršpaněl',24,38,14);
INSERT INTO Zeme_puvodu
VALUES(26,'Sao Tome','Antarctica');
INSERT INTO Uzivatel
VALUES(26,'Marsha','Edwards','784418043','CORdbjgfpYhaFYbfy@gmail.com');
INSERT INTO Zakaznik
VALUES(26,61143542);
INSERT INTO Pes
VALUES(27,'Christopher','fena',16000,TO_DATE('2006.03.13', 'yyyy.mm.dd'),NULL,NULL,NULL,3);
INSERT INTO Oceneni
VALUES(27,'Virtual 4ALL',TO_DATE('2010.09.14', 'yyyy.mm.dd'),13);
INSERT INTO Test
VALUES(27,TO_DATE('1991.10.16', 'yyyy.mm.dd'),25,14);
INSERT INTO Ockovani
VALUES(27,TO_DATE('2002.01.08', 'yyyy.mm.dd'),TO_DATE('2008.02.17', 'yyyy.mm.dd'),3,20);
INSERT INTO Plemeno
VALUES(27,'Sicilský chrt',21,34,7);
INSERT INTO Zeme_puvodu
VALUES(27,'Cuba','Europe');
INSERT INTO Uzivatel
VALUES(27,'Felicia','Carlisle','740079488','hRSsJ@gmail.com');
INSERT INTO Zamestnanec
VALUES(27,TO_DATE('2010.10.19', 'yyyy.mm.dd'),'uklízeč',30000);
INSERT INTO Pes
VALUES(28,'William','pes',34000,TO_DATE('1993.02.15', 'yyyy.mm.dd'),NULL,7,NULL,16);
INSERT INTO Oceneni
VALUES(28,'Pohár Mistra Maleniv',TO_DATE('2008.06.29', 'yyyy.mm.dd'),19);
INSERT INTO Test
VALUES(28,TO_DATE('1998.10.15', 'yyyy.mm.dd'),20,26);
INSERT INTO Ockovani
VALUES(28,TO_DATE('2004.12.08', 'yyyy.mm.dd'),TO_DATE('2008.12.15', 'yyyy.mm.dd'),26,4);
INSERT INTO Plemeno
VALUES(28,'Bílý švýcarský ovčák',31,21,3);
INSERT INTO Zeme_puvodu
VALUES(28,'Benin','Antarctica');
INSERT INTO Uzivatel
VALUES(28,'April','Shearer','745292737','yLkuQujSreUFKQUjg@gmail.com');
INSERT INTO Zakaznik
VALUES(28,81322526);
INSERT INTO Pes
VALUES(29,'Vincent','fena',6000,TO_DATE('2003.12.27', 'yyyy.mm.dd'),11,11,2,16);
INSERT INTO Oceneni
VALUES(29,'Psí závody 2021',TO_DATE('1994.12.13', 'yyyy.mm.dd'),17);
INSERT INTO Test
VALUES(29,TO_DATE('2004.07.23', 'yyyy.mm.dd'),18,19);
INSERT INTO Ockovani
VALUES(29,TO_DATE('2007.12.18', 'yyyy.mm.dd'),TO_DATE('2015.07.02', 'yyyy.mm.dd'),8,6);
INSERT INTO Plemeno
VALUES(29,'Barzoj',64,13,NULL);
INSERT INTO Zeme_puvodu
VALUES(29,'Bosnia And Herzegowina','Antarctica');
INSERT INTO Uzivatel
VALUES(29,'Nancy','Berland','704007042','PVyPXpwidrkfQQsfdV@gmail.com');
INSERT INTO Zamestnanec
VALUES(29,TO_DATE('2003.12.05', 'yyyy.mm.dd'),'vedoucí',23000);
INSERT INTO Pes
VALUES(30,'Kenton','fena',61000,TO_DATE('1996.02.01', 'yyyy.mm.dd'),16,26,16,2);
INSERT INTO Oceneni
VALUES(30,'Hard Dog Race pravidla',TO_DATE('2007.08.22', 'yyyy.mm.dd'),2);
INSERT INTO Test
VALUES(30,TO_DATE('1997.02.15', 'yyyy.mm.dd'),11,8);
INSERT INTO Ockovani
VALUES(30,TO_DATE('2008.02.21', 'yyyy.mm.dd'),TO_DATE('2009.11.18', 'yyyy.mm.dd'),27,22);
INSERT INTO Plemeno
VALUES(30,'Lhasa Apso',76,27,16);
INSERT INTO Zeme_puvodu
VALUES(30,'United Kingdom','Europe');
INSERT INTO Uzivatel
VALUES(30,'Deborah','Price','703611373','EMMoovhNz@gmail.com');
INSERT INTO Zakaznik
VALUES(30,47243617);
INSERT INTO Pes
VALUES(31,'Nancy','pes',26000,TO_DATE('1992.04.07', 'yyyy.mm.dd'),18,1,17,28);
INSERT INTO Oceneni
VALUES(31,'Extreme Dog Race',TO_DATE('2002.10.01', 'yyyy.mm.dd'),27);
INSERT INTO Test
VALUES(31,TO_DATE('1994.05.30', 'yyyy.mm.dd'),33,6);
INSERT INTO Ockovani
VALUES(31,TO_DATE('1995.09.04', 'yyyy.mm.dd'),TO_DATE('1998.12.19', 'yyyy.mm.dd'),28,25);
INSERT INTO Plemeno
VALUES(31,'Bergamský ovčák',56,38,26);
INSERT INTO Zeme_puvodu
VALUES(31,'Suriname','Africa');
INSERT INTO Uzivatel
VALUES(31,'Bobby','Wilburn','710973292','NKvCLiigcMaUXJEUkWP@gmail.com');
INSERT INTO Zamestnanec
VALUES(31,TO_DATE('2006.08.07', 'yyyy.mm.dd'),'uklízeč',23000);
INSERT INTO Pes
VALUES(32,'Vanessa','pes',49000,TO_DATE('1994.04.27', 'yyyy.mm.dd'),12,7,9,15);
INSERT INTO Oceneni
VALUES(32,'Pohár Mistra Maleniv',TO_DATE('1998.11.23', 'yyyy.mm.dd'),14);
INSERT INTO Test
VALUES(32,TO_DATE('1997.07.08', 'yyyy.mm.dd'),35,18);
INSERT INTO Ockovani
VALUES(32,TO_DATE('1992.05.26', 'yyyy.mm.dd'),TO_DATE('1993.07.04', 'yyyy.mm.dd'),2,3);
INSERT INTO Plemeno
VALUES(32,'Český teriér',62,13,27);
INSERT INTO Zeme_puvodu
VALUES(32,'Finland','Asia');
INSERT INTO Uzivatel
VALUES(32,'Stacy','Underwood','768622381','XTRHNuwO@gmail.com');
INSERT INTO Zakaznik
VALUES(32,68123473);
INSERT INTO Pes
VALUES(33,'Richard','pes',36000,TO_DATE('2007.07.07', 'yyyy.mm.dd'),19,22,11,20);
INSERT INTO Oceneni
VALUES(33,'Extreme Dog Race',TO_DATE('1991.06.13', 'yyyy.mm.dd'),14);
INSERT INTO Test
VALUES(33,TO_DATE('1995.10.30', 'yyyy.mm.dd'),8,4);
INSERT INTO Ockovani
VALUES(33,TO_DATE('2001.05.11', 'yyyy.mm.dd'),TO_DATE('2004.09.30', 'yyyy.mm.dd'),32,29);
INSERT INTO Plemeno
VALUES(33,'Kolie dlouhosrstá',86,17,21);
INSERT INTO Zeme_puvodu
VALUES(33,'Zimbabwe','Asia');
INSERT INTO Uzivatel
VALUES(33,'Lloyd','Gratton','769466617','GpnIJvmXQREZyuCeyIM@gmail.com');
INSERT INTO Zamestnanec
VALUES(33,TO_DATE('1990.07.27', 'yyyy.mm.dd'),'účetní',16000);
INSERT INTO Pes
VALUES(34,'Brian','pes',62000,TO_DATE('2008.11.25', 'yyyy.mm.dd'),1,16,18,5);
INSERT INTO Oceneni
VALUES(34,'Psí závody 2021',TO_DATE('1997.07.29', 'yyyy.mm.dd'),22);
INSERT INTO Test
VALUES(34,TO_DATE('2004.10.07', 'yyyy.mm.dd'),24,28);
INSERT INTO Ockovani
VALUES(34,TO_DATE('1991.04.17', 'yyyy.mm.dd'),TO_DATE('1994.08.17', 'yyyy.mm.dd'),32,24);
INSERT INTO Plemeno
VALUES(34,'Jämthund',32,20,32);
INSERT INTO Zeme_puvodu
VALUES(34,'Argentina','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(34,'Robert','Mccoy','739890350','sgpwxheFNqBrqV@gmail.com');
INSERT INTO Zakaznik
VALUES(34,15554613);
INSERT INTO Pes
VALUES(35,'Karen','pes',36000,TO_DATE('2010.06.18', 'yyyy.mm.dd'),15,NULL,30,28);
INSERT INTO Oceneni
VALUES(35,'STEEPLECHASE',TO_DATE('2008.05.08', 'yyyy.mm.dd'),4);
INSERT INTO Test
VALUES(35,TO_DATE('1990.06.10', 'yyyy.mm.dd'),19,15);
INSERT INTO Ockovani
VALUES(35,TO_DATE('1998.02.01', 'yyyy.mm.dd'),TO_DATE('1999.10.03', 'yyyy.mm.dd'),24,3);
INSERT INTO Plemeno
VALUES(35,'Westfálský jezevčíkovitý honič',60,15,26);
INSERT INTO Zeme_puvodu
VALUES(35,'Bolivia','Africa');
INSERT INTO Uzivatel
VALUES(35,'Samuel','Eller','773161669','uasjWxUqUMGuMoVyjh@gmail.com');
INSERT INTO Zamestnanec
VALUES(35,TO_DATE('2007.03.05', 'yyyy.mm.dd'),'ošetřovatel',17000);
INSERT INTO Pes
VALUES(36,'Roy','fena',37000,TO_DATE('2007.02.19', 'yyyy.mm.dd'),NULL,10,31,19);
INSERT INTO Oceneni
VALUES(36,'Psí závody 2021',TO_DATE('2003.07.27', 'yyyy.mm.dd'),25);
INSERT INTO Test
VALUES(36,TO_DATE('2011.10.09', 'yyyy.mm.dd'),8,24);
INSERT INTO Ockovani
VALUES(36,TO_DATE('2007.11.27', 'yyyy.mm.dd'),TO_DATE('2009.09.10', 'yyyy.mm.dd'),11,NULL);
INSERT INTO Plemeno
VALUES(36,'Čínský chocholatý pes',71,18,4);
INSERT INTO Zeme_puvodu
VALUES(36,'Northern Mariana Islands','Europe');
INSERT INTO Uzivatel
VALUES(36,'Michael','Moore','795748265','izPznCZCNDZTdcDja@gmail.com');
INSERT INTO Zakaznik
VALUES(36,27166566);
INSERT INTO Pes
VALUES(37,'Arthur','pes',34000,TO_DATE('2001.03.23', 'yyyy.mm.dd'),29,NULL,17,22);
INSERT INTO Oceneni
VALUES(37,'Závody psích spřežení',TO_DATE('1993.12.16', 'yyyy.mm.dd'),15);
INSERT INTO Test
VALUES(37,TO_DATE('1995.06.03', 'yyyy.mm.dd'),27,7);
INSERT INTO Ockovani
VALUES(37,TO_DATE('1998.03.10', 'yyyy.mm.dd'),TO_DATE('1999.11.12', 'yyyy.mm.dd'),23,18);
INSERT INTO Plemeno
VALUES(37,'Kai-Inu',52,40,NULL);
INSERT INTO Zeme_puvodu
VALUES(37,'Korea (South)','Antarctica');
INSERT INTO Uzivatel
VALUES(37,'Patrick','Dartez','760009657','OcPHlX@gmail.com');
INSERT INTO Zamestnanec
VALUES(37,TO_DATE('1993.03.27', 'yyyy.mm.dd'),'uklízeč',18000);
INSERT INTO Pes
VALUES(38,'Diane','fena',19000,TO_DATE('1996.05.09', 'yyyy.mm.dd'),22,3,37,32);
INSERT INTO Oceneni
VALUES(38,'Extreme Dog Race',TO_DATE('2004.10.30', 'yyyy.mm.dd'),22);
INSERT INTO Test
VALUES(38,TO_DATE('2008.08.13', 'yyyy.mm.dd'),8,20);
INSERT INTO Ockovani
VALUES(38,TO_DATE('1997.05.01', 'yyyy.mm.dd'),TO_DATE('2004.07.11', 'yyyy.mm.dd'),34,35);
INSERT INTO Plemeno
VALUES(38,'Francouzský ohař krátkosrstý pyrenejského typu',79,19,25);
INSERT INTO Zeme_puvodu
VALUES(38,'Rwanda','Europe');
INSERT INTO Uzivatel
VALUES(38,'Joshua','Moxley','778717579','PCFuQClEUGntHeihb@gmail.com');
INSERT INTO Zakaznik
VALUES(38,57598346);
INSERT INTO Pes
VALUES(39,'Scott','pes',22000,TO_DATE('1998.08.16', 'yyyy.mm.dd'),29,32,17,33);
INSERT INTO Oceneni
VALUES(39,'Czech DOG race',TO_DATE('2005.01.04', 'yyyy.mm.dd'),30);
INSERT INTO Test
VALUES(39,TO_DATE('1995.04.12', 'yyyy.mm.dd'),35,11);
INSERT INTO Ockovani
VALUES(39,TO_DATE('1997.07.23', 'yyyy.mm.dd'),TO_DATE('2000.11.03', 'yyyy.mm.dd'),32,11);
INSERT INTO Plemeno
VALUES(39,'Australská kelpie',26,30,26);
INSERT INTO Zeme_puvodu
VALUES(39,'Falkland Islands (Malvinas)','Asia');
INSERT INTO Uzivatel
VALUES(39,'Kandice','Booe','737732331','LXlRPHjwbGCtm@gmail.com');
INSERT INTO Zamestnanec
VALUES(39,TO_DATE('2003.01.24', 'yyyy.mm.dd'),'vedoucí',29000);
INSERT INTO Pes
VALUES(40,'Katherine','fena',26000,TO_DATE('2000.07.08', 'yyyy.mm.dd'),9,18,30,35);
INSERT INTO Oceneni
VALUES(40,'STEEPLECHASE',TO_DATE('2008.09.20', 'yyyy.mm.dd'),36);
INSERT INTO Test
VALUES(40,TO_DATE('1991.03.13', 'yyyy.mm.dd'),13,1);
INSERT INTO Ockovani
VALUES(40,TO_DATE('2004.05.27', 'yyyy.mm.dd'),TO_DATE('2009.11.27', 'yyyy.mm.dd'),NULL,6);
INSERT INTO Plemeno
VALUES(40,'Belgický ovčák - Laekenois',73,34,NULL);
INSERT INTO Zeme_puvodu
VALUES(40,'Mali','Antarctica');
INSERT INTO Uzivatel
VALUES(40,'Martin','Normand','700568621','AzDzDPGJRuS@gmail.com');
INSERT INTO Zakaznik
VALUES(40,76137562);
INSERT INTO Pes
VALUES(41,'Beverly','pes',11000,TO_DATE('2001.09.16', 'yyyy.mm.dd'),NULL,1,38,38);
INSERT INTO Oceneni
VALUES(41,'Mushing závody',TO_DATE('2005.06.30', 'yyyy.mm.dd'),11);
INSERT INTO Test
VALUES(41,TO_DATE('2004.08.15', 'yyyy.mm.dd'),16,21);
INSERT INTO Ockovani
VALUES(41,TO_DATE('1995.08.30', 'yyyy.mm.dd'),TO_DATE('2000.06.15', 'yyyy.mm.dd'),27,32);
INSERT INTO Plemeno
VALUES(41,'Artoisský honič',85,10,31);
INSERT INTO Zeme_puvodu
VALUES(41,'Armenia','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(41,'Ellen','Hernandez','711531578','uTWLRVQrk@gmail.com');
INSERT INTO Zamestnanec
VALUES(41,TO_DATE('2008.05.11', 'yyyy.mm.dd'),'ošetřovatel',21000);
INSERT INTO Pes
VALUES(42,'Tracy','pes',55000,TO_DATE('1995.10.22', 'yyyy.mm.dd'),41,27,7,18);
INSERT INTO Oceneni
VALUES(42,'Czech DOG race',TO_DATE('1998.11.06', 'yyyy.mm.dd'),38);
INSERT INTO Test
VALUES(42,TO_DATE('1993.11.27', 'yyyy.mm.dd'),37,33);
INSERT INTO Ockovani
VALUES(42,TO_DATE('1996.01.11', 'yyyy.mm.dd'),TO_DATE('1996.01.27', 'yyyy.mm.dd'),36,20);
INSERT INTO Plemeno
VALUES(42,'Nivernaisský hrubosrstý honič',88,18,8);
INSERT INTO Zeme_puvodu
VALUES(42,'Virgin Islands (U.S.)','America');
INSERT INTO Uzivatel
VALUES(42,'Norberto','Procter','715084411','TlzeolmvWXf@gmail.com');
INSERT INTO Zakaznik
VALUES(42,68114464);
INSERT INTO Pes
VALUES(43,'Delores','fena',29000,TO_DATE('2004.12.21', 'yyyy.mm.dd'),30,42,40,23);
INSERT INTO Oceneni
VALUES(43,'Pohár Mistra Maleniv',TO_DATE('2008.10.08', 'yyyy.mm.dd'),36);
INSERT INTO Test
VALUES(43,TO_DATE('2005.01.29', 'yyyy.mm.dd'),24,35);
INSERT INTO Ockovani
VALUES(43,TO_DATE('1997.11.03', 'yyyy.mm.dd'),TO_DATE('1999.09.11', 'yyyy.mm.dd'),30,11);
INSERT INTO Plemeno
VALUES(43,'Čínský chocholatý pes',90,11,15);
INSERT INTO Zeme_puvodu
VALUES(43,'Cameroon','Europe');
INSERT INTO Uzivatel
VALUES(43,'Katherine','Smith','760608070','nGnuhFgMAGDsWhf@gmail.com');
INSERT INTO Zamestnanec
VALUES(43,TO_DATE('2006.07.16', 'yyyy.mm.dd'),'ošetřovatel',16000);
INSERT INTO Pes
VALUES(44,'Eric','pes',42000,TO_DATE('2004.08.23', 'yyyy.mm.dd'),43,26,16,1);
INSERT INTO Oceneni
VALUES(44,'Mushing závody',TO_DATE('2002.04.10', 'yyyy.mm.dd'),1);
INSERT INTO Test
VALUES(44,TO_DATE('2001.02.19', 'yyyy.mm.dd'),23,20);
INSERT INTO Ockovani
VALUES(44,TO_DATE('1996.12.17', 'yyyy.mm.dd'),TO_DATE('2001.05.16', 'yyyy.mm.dd'),35,20);
INSERT INTO Plemeno
VALUES(44,'Francouzský ohař krátkosrstý gaskoňského typu',21,18,23);
INSERT INTO Zeme_puvodu
VALUES(44,'Cuba','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(44,'Betty','White','786040502','oSqLltvcNTZWtSS@gmail.com');
INSERT INTO Zakaznik
VALUES(44,35749599);
INSERT INTO Pes
VALUES(45,'Caitlin','fena',56000,TO_DATE('1997.03.23', 'yyyy.mm.dd'),14,38,NULL,NULL);
INSERT INTO Oceneni
VALUES(45,'Virtual 4ALL',TO_DATE('2010.02.03', 'yyyy.mm.dd'),14);
INSERT INTO Test
VALUES(45,TO_DATE('2009.07.12', 'yyyy.mm.dd'),11,3);
INSERT INTO Ockovani
VALUES(45,TO_DATE('2004.05.11', 'yyyy.mm.dd'),TO_DATE('2011.01.21', 'yyyy.mm.dd'),34,21);
INSERT INTO Plemeno
VALUES(45,'Landseer',25,9,29);
INSERT INTO Zeme_puvodu
VALUES(45,'Jamaica','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(45,'Linda','Sheridan','763275777','vXBWKefPFoCEgxqC@gmail.com');
INSERT INTO Zamestnanec
VALUES(45,TO_DATE('2005.08.20', 'yyyy.mm.dd'),'účetní',27000);
INSERT INTO Pes
VALUES(46,'Gordon','fena',6000,TO_DATE('1998.01.08', 'yyyy.mm.dd'),11,19,23,33);
INSERT INTO Oceneni
VALUES(46,'Czech DOG race',TO_DATE('2004.01.14', 'yyyy.mm.dd'),4);
INSERT INTO Test
VALUES(46,TO_DATE('1991.05.25', 'yyyy.mm.dd'),37,19);
INSERT INTO Ockovani
VALUES(46,TO_DATE('2002.01.16', 'yyyy.mm.dd'),TO_DATE('2006.05.14', 'yyyy.mm.dd'),29,21);
INSERT INTO Plemeno
VALUES(46,'Barbet',21,26,5);
INSERT INTO Zeme_puvodu
VALUES(46,'Sudan','America');
INSERT INTO Uzivatel
VALUES(46,'Nita','Thompson','778373899','phHlxSfm@gmail.com');
INSERT INTO Zakaznik
VALUES(46,72863533);
INSERT INTO Pes
VALUES(47,'Warren','pes',38000,TO_DATE('1999.10.15', 'yyyy.mm.dd'),30,22,2,37);
INSERT INTO Oceneni
VALUES(47,'Virtual 4ALL',TO_DATE('2005.01.29', 'yyyy.mm.dd'),14);
INSERT INTO Test
VALUES(47,TO_DATE('1996.11.20', 'yyyy.mm.dd'),9,10);
INSERT INTO Ockovani
VALUES(47,TO_DATE('2003.03.09', 'yyyy.mm.dd'),TO_DATE('2011.04.08', 'yyyy.mm.dd'),2,35);
INSERT INTO Plemeno
VALUES(47,'Brazilská fila',65,40,4);
INSERT INTO Zeme_puvodu
VALUES(47,'Netherlands','Asia');
INSERT INTO Uzivatel
VALUES(47,'James','Carney','732983048','ssidaGDWdz@gmail.com');
INSERT INTO Zamestnanec
VALUES(47,TO_DATE('2010.07.04', 'yyyy.mm.dd'),'účetní',18000);
INSERT INTO Pes
VALUES(48,'Alison','fena',15000,TO_DATE('1997.06.26', 'yyyy.mm.dd'),18,20,13,43);
INSERT INTO Oceneni
VALUES(48,'Virtual 4ALL',TO_DATE('1992.01.14', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(48,TO_DATE('1997.10.17', 'yyyy.mm.dd'),14,30);
INSERT INTO Ockovani
VALUES(48,TO_DATE('2005.07.30', 'yyyy.mm.dd'),TO_DATE('2011.08.24', 'yyyy.mm.dd'),23,45);
INSERT INTO Plemeno
VALUES(48,'Velššpringršpaněl',42,29,2);
INSERT INTO Zeme_puvodu
VALUES(48,'Saint Lucia','Asia');
INSERT INTO Uzivatel
VALUES(48,'Robyn','Mchenry','770223297','FSqlh@gmail.com');
INSERT INTO Zakaznik
VALUES(48,14447226);
INSERT INTO Pes
VALUES(49,'Lori','fena',33000,TO_DATE('2009.08.21', 'yyyy.mm.dd'),43,5,2,31);
INSERT INTO Oceneni
VALUES(49,'Virtual 4ALL',TO_DATE('1991.02.14', 'yyyy.mm.dd'),40);
INSERT INTO Test
VALUES(49,TO_DATE('1995.08.10', 'yyyy.mm.dd'),36,38);
INSERT INTO Ockovani
VALUES(49,TO_DATE('2007.12.13', 'yyyy.mm.dd'),TO_DATE('2015.08.01', 'yyyy.mm.dd'),32,12);
INSERT INTO Plemeno
VALUES(49,'Americký foxhound',47,34,27);
INSERT INTO Zeme_puvodu
VALUES(49,'Iran','Africa');
INSERT INTO Uzivatel
VALUES(49,'Stephanie','Melton','727557648','rWSDAjiwivB@gmail.com');
INSERT INTO Zamestnanec
VALUES(49,TO_DATE('1999.02.28', 'yyyy.mm.dd'),'vedoucí',26000);
INSERT INTO Pes
VALUES(50,'Jimmie','fena',15000,TO_DATE('2001.12.30', 'yyyy.mm.dd'),16,18,34,37);
INSERT INTO Oceneni
VALUES(50,'Pohár Mistra Maleniv',TO_DATE('2011.03.31', 'yyyy.mm.dd'),37);
INSERT INTO Test
VALUES(50,TO_DATE('2009.05.02', 'yyyy.mm.dd'),39,NULL);
INSERT INTO Ockovani
VALUES(50,TO_DATE('1997.11.07', 'yyyy.mm.dd'),TO_DATE('1998.02.17', 'yyyy.mm.dd'),11,40);
INSERT INTO Plemeno
VALUES(50,'Americký vodní španěl',62,32,10);
INSERT INTO Zeme_puvodu
VALUES(50,'Kenya','Antarctica');
INSERT INTO Uzivatel
VALUES(50,'Daniel','Roberson','733843891','SvOYrxKAEvNFCIpiyI@gmail.com');
INSERT INTO Zakaznik
VALUES(50,13731116);
INSERT INTO Pes
VALUES(51,'Jennifer','fena',63000,TO_DATE('1994.11.16', 'yyyy.mm.dd'),36,44,21,29);
INSERT INTO Oceneni
VALUES(51,'Hard Dog Race pravidla',TO_DATE('1995.07.18', 'yyyy.mm.dd'),16);
INSERT INTO Test
VALUES(51,TO_DATE('1999.01.03', 'yyyy.mm.dd'),14,14);
INSERT INTO Ockovani
VALUES(51,TO_DATE('2001.03.22', 'yyyy.mm.dd'),TO_DATE('2007.10.25', 'yyyy.mm.dd'),36,30);
INSERT INTO Plemeno
VALUES(51,'Kavkazský pastevecký pes',51,40,45);
INSERT INTO Zeme_puvodu
VALUES(51,'Indonesia','Africa');
INSERT INTO Uzivatel
VALUES(51,'Ingrid','Frediani','706076791','zxDNWApRyCTSfgKFaXS@gmail.com');
INSERT INTO Zamestnanec
VALUES(51,TO_DATE('2008.12.31', 'yyyy.mm.dd'),'účetní',22000);
INSERT INTO Pes
VALUES(52,'Gary','fena',13000,TO_DATE('2004.06.08', 'yyyy.mm.dd'),36,19,15,12);
INSERT INTO Oceneni
VALUES(52,'Extreme Dog Race',TO_DATE('2011.03.06', 'yyyy.mm.dd'),14);
INSERT INTO Test
VALUES(52,TO_DATE('1996.10.15', 'yyyy.mm.dd'),19,38);
INSERT INTO Ockovani
VALUES(52,TO_DATE('1999.04.06', 'yyyy.mm.dd'),TO_DATE('1999.11.23', 'yyyy.mm.dd'),NULL,28);
INSERT INTO Plemeno
VALUES(52,'Anglo-francouzský honič de Petite Venerie',28,37,26);
INSERT INTO Zeme_puvodu
VALUES(52,'Albania','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(52,'Dave','Jenkins','729400802','MkVxqfaBCvJqZxbZ@gmail.com');
INSERT INTO Zakaznik
VALUES(52,35189246);
INSERT INTO Pes
VALUES(53,'Kenneth','pes',11000,TO_DATE('2004.12.20', 'yyyy.mm.dd'),NULL,31,30,9);
INSERT INTO Oceneni
VALUES(53,'Extreme Dog Race',TO_DATE('1999.10.03', 'yyyy.mm.dd'),NULL);
INSERT INTO Test
VALUES(53,TO_DATE('1999.06.07', 'yyyy.mm.dd'),34,46);
INSERT INTO Ockovani
VALUES(53,TO_DATE('2011.09.29', 'yyyy.mm.dd'),TO_DATE('2019.02.07', 'yyyy.mm.dd'),34,2);
INSERT INTO Plemeno
VALUES(53,'West Highland White teriér',63,29,49);
INSERT INTO Zeme_puvodu
VALUES(53,'St. Helena','Africa');
INSERT INTO Uzivatel
VALUES(53,'Carlos','Acuna','749841828','yuuvdTHPHYYK@gmail.com');
INSERT INTO Zamestnanec
VALUES(53,TO_DATE('2003.10.31', 'yyyy.mm.dd'),'vedoucí',28000);
INSERT INTO Pes
VALUES(54,'Beatriz','fena',12000,TO_DATE('2001.05.21', 'yyyy.mm.dd'),27,19,14,22);
INSERT INTO Oceneni
VALUES(54,'Mushing závody',TO_DATE('2003.08.22', 'yyyy.mm.dd'),41);
INSERT INTO Test
VALUES(54,TO_DATE('1999.01.01', 'yyyy.mm.dd'),36,2);
INSERT INTO Ockovani
VALUES(54,TO_DATE('2008.07.02', 'yyyy.mm.dd'),TO_DATE('2016.04.27', 'yyyy.mm.dd'),4,19);
INSERT INTO Plemeno
VALUES(54,'Blue Lacy',73,28,37);
INSERT INTO Zeme_puvodu
VALUES(54,'Lebanon','Africa');
INSERT INTO Uzivatel
VALUES(54,'Gary','Eyre','795076894','wKKRlQm@gmail.com');
INSERT INTO Zakaznik
VALUES(54,13118576);
INSERT INTO Pes
VALUES(55,'Randy','fena',43000,TO_DATE('2004.07.06', 'yyyy.mm.dd'),32,54,46,18);
INSERT INTO Oceneni
VALUES(55,'Virtual 4ALL',TO_DATE('1995.07.09', 'yyyy.mm.dd'),28);
INSERT INTO Test
VALUES(55,TO_DATE('1997.04.06', 'yyyy.mm.dd'),28,2);
INSERT INTO Ockovani
VALUES(55,TO_DATE('2007.11.19', 'yyyy.mm.dd'),TO_DATE('2012.08.07', 'yyyy.mm.dd'),54,43);
INSERT INTO Plemeno
VALUES(55,'Stafordšírský bulteriér',63,32,9);
INSERT INTO Zeme_puvodu
VALUES(55,'Finland','Antarctica');
INSERT INTO Uzivatel
VALUES(55,'Kevin','Rehlander','797988041','uyPYSsxIj@gmail.com');
INSERT INTO Zamestnanec
VALUES(55,TO_DATE('2010.11.12', 'yyyy.mm.dd'),'účetní',21000);
INSERT INTO Pes
VALUES(56,'Karen','pes',9000,TO_DATE('2007.10.09', 'yyyy.mm.dd'),55,11,49,7);
INSERT INTO Oceneni
VALUES(56,'Extreme Dog Race',TO_DATE('1997.08.23', 'yyyy.mm.dd'),1);
INSERT INTO Test
VALUES(56,TO_DATE('1999.08.14', 'yyyy.mm.dd'),14,32);
INSERT INTO Ockovani
VALUES(56,TO_DATE('2003.02.10', 'yyyy.mm.dd'),TO_DATE('2004.04.17', 'yyyy.mm.dd'),1,42);
INSERT INTO Plemeno
VALUES(56,'Velššpringršpaněl',44,32,6);
INSERT INTO Zeme_puvodu
VALUES(56,'Brazil','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(56,'Debra','Porter','752528051','NFuqffCYCUgid@gmail.com');
INSERT INTO Zakaznik
VALUES(56,19523845);
INSERT INTO Pes
VALUES(57,'Robert','fena',65000,TO_DATE('2002.11.05', 'yyyy.mm.dd'),33,25,52,14);
INSERT INTO Oceneni
VALUES(57,'Psí závody 2021',TO_DATE('1996.05.16', 'yyyy.mm.dd'),11);
INSERT INTO Test
VALUES(57,TO_DATE('1998.05.28', 'yyyy.mm.dd'),35,25);
INSERT INTO Ockovani
VALUES(57,TO_DATE('2009.08.05', 'yyyy.mm.dd'),TO_DATE('2014.06.15', 'yyyy.mm.dd'),45,8);
INSERT INTO Plemeno
VALUES(57,'Bordeauxská doga',53,12,NULL);
INSERT INTO Zeme_puvodu
VALUES(57,'Croatia','Antarctica');
INSERT INTO Uzivatel
VALUES(57,'Nathaniel','Kramer','752516326','GblfOkD@gmail.com');
INSERT INTO Zamestnanec
VALUES(57,TO_DATE('2011.11.03', 'yyyy.mm.dd'),'ošetřovatel',16000);
INSERT INTO Pes
VALUES(58,'Robert','fena',63000,TO_DATE('1991.06.19', 'yyyy.mm.dd'),21,44,7,45);
INSERT INTO Oceneni
VALUES(58,'Závody psích spřežení',TO_DATE('1992.04.10', 'yyyy.mm.dd'),45);
INSERT INTO Test
VALUES(58,TO_DATE('1995.07.17', 'yyyy.mm.dd'),17,29);
INSERT INTO Ockovani
VALUES(58,TO_DATE('2010.06.29', 'yyyy.mm.dd'),TO_DATE('2013.06.17', 'yyyy.mm.dd'),26,19);
INSERT INTO Plemeno
VALUES(58,'Velký francouzsko-anglický trikolorní honič',88,15,16);
INSERT INTO Zeme_puvodu
VALUES(58,'Switzerland','America');
INSERT INTO Uzivatel
VALUES(58,'Sabrina','Clayton','791508710','sNQsbAaEcEBiwsrLng@gmail.com');
INSERT INTO Zakaznik
VALUES(58,81669854);
INSERT INTO Pes
VALUES(59,'Mark','fena',43000,TO_DATE('2002.06.01', 'yyyy.mm.dd'),27,3,NULL,11);
INSERT INTO Oceneni
VALUES(59,'Závody psích spřežení',TO_DATE('2003.12.05', 'yyyy.mm.dd'),14);
INSERT INTO Test
VALUES(59,TO_DATE('2004.04.30', 'yyyy.mm.dd'),32,7);
INSERT INTO Ockovani
VALUES(59,TO_DATE('2002.02.05', 'yyyy.mm.dd'),TO_DATE('2003.01.20', 'yyyy.mm.dd'),3,37);
INSERT INTO Plemeno
VALUES(59,'Hygenův honič',68,26,NULL);
INSERT INTO Zeme_puvodu
VALUES(59,'Puerto Rico','Africa');
INSERT INTO Uzivatel
VALUES(59,'Scott','Nein','797994575','dhYsTdqNNtaZBGZBM@gmail.com');
INSERT INTO Zamestnanec
VALUES(59,TO_DATE('2005.09.04', 'yyyy.mm.dd'),'uklízeč',25000);
INSERT INTO Pes
VALUES(60,'Elva','fena',18000,TO_DATE('1993.09.23', 'yyyy.mm.dd'),NULL,9,53,46);
INSERT INTO Oceneni
VALUES(60,'Mushing závody',TO_DATE('1999.09.19', 'yyyy.mm.dd'),43);
INSERT INTO Test
VALUES(60,TO_DATE('2002.11.23', 'yyyy.mm.dd'),11,35);
INSERT INTO Ockovani
VALUES(60,TO_DATE('1993.12.31', 'yyyy.mm.dd'),TO_DATE('1998.02.27', 'yyyy.mm.dd'),NULL,35);
INSERT INTO Plemeno
VALUES(60,'Ruskoevropská lajka',48,32,25);
INSERT INTO Zeme_puvodu
VALUES(60,'Romania','Africa');
INSERT INTO Uzivatel
VALUES(60,'Francisca','Isbell','781232911','SrcdOEvAfvpOFP@gmail.com');
INSERT INTO Zakaznik
VALUES(60,92573195);
INSERT INTO Pes
VALUES(61,'Frank','pes',57000,TO_DATE('1993.09.03', 'yyyy.mm.dd'),43,14,60,13);
INSERT INTO Oceneni
VALUES(61,'Pohár Mistra Maleniv',TO_DATE('1997.05.15', 'yyyy.mm.dd'),5);
INSERT INTO Test
VALUES(61,TO_DATE('2011.01.20', 'yyyy.mm.dd'),18,26);
INSERT INTO Ockovani
VALUES(61,TO_DATE('2001.07.10', 'yyyy.mm.dd'),TO_DATE('2009.07.06', 'yyyy.mm.dd'),17,43);
INSERT INTO Plemeno
VALUES(61,'Sicilský chrt',86,40,50);
INSERT INTO Zeme_puvodu
VALUES(61,'Antarctica','Africa');
INSERT INTO Uzivatel
VALUES(61,'Melissa','Slaughter','734118836','ctZgZwoeQHQ@gmail.com');
INSERT INTO Zamestnanec
VALUES(61,TO_DATE('2006.05.22', 'yyyy.mm.dd'),'vedoucí',29000);
INSERT INTO Pes
VALUES(62,'Emma','pes',43000,TO_DATE('2010.01.24', 'yyyy.mm.dd'),10,10,14,13);
INSERT INTO Oceneni
VALUES(62,'Závody psích spřežení',TO_DATE('1998.12.23', 'yyyy.mm.dd'),61);
INSERT INTO Test
VALUES(62,TO_DATE('2000.12.17', 'yyyy.mm.dd'),31,39);
INSERT INTO Ockovani
VALUES(62,TO_DATE('2010.11.28', 'yyyy.mm.dd'),TO_DATE('2011.11.07', 'yyyy.mm.dd'),18,25);
INSERT INTO Plemeno
VALUES(62,'Welsh Corgi Pembroke',61,30,17);
INSERT INTO Zeme_puvodu
VALUES(62,'India','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(62,'Travis','Hill','756803706','fzNCNzbSTzwIGof@gmail.com');
INSERT INTO Zakaznik
VALUES(62,47329165);
INSERT INTO Pes
VALUES(63,'Sheila','pes',53000,TO_DATE('2005.11.14', 'yyyy.mm.dd'),36,53,54,40);
INSERT INTO Oceneni
VALUES(63,'Pohár Mistra Maleniv',TO_DATE('1999.07.08', 'yyyy.mm.dd'),11);
INSERT INTO Test
VALUES(63,TO_DATE('1990.03.22', 'yyyy.mm.dd'),39,2);
INSERT INTO Ockovani
VALUES(63,TO_DATE('1990.07.03', 'yyyy.mm.dd'),TO_DATE('1993.07.21', 'yyyy.mm.dd'),NULL,62);
INSERT INTO Plemeno
VALUES(63,'Puli',88,36,16);
INSERT INTO Zeme_puvodu
VALUES(63,'Macau','America');
INSERT INTO Uzivatel
VALUES(63,'Diane','Roush','736845158','aOhfaEzmhWnYaEhLm@gmail.com');
INSERT INTO Zamestnanec
VALUES(63,TO_DATE('2008.11.20', 'yyyy.mm.dd'),'účetní',24000);
INSERT INTO Pes
VALUES(64,'Charles','fena',20000,TO_DATE('1997.03.27', 'yyyy.mm.dd'),13,43,52,16);
INSERT INTO Oceneni
VALUES(64,'Pohár Mistra Maleniv',TO_DATE('2000.11.14', 'yyyy.mm.dd'),18);
INSERT INTO Test
VALUES(64,TO_DATE('1993.07.12', 'yyyy.mm.dd'),29,22);
INSERT INTO Ockovani
VALUES(64,TO_DATE('1992.09.23', 'yyyy.mm.dd'),TO_DATE('1994.09.12', 'yyyy.mm.dd'),16,17);
INSERT INTO Plemeno
VALUES(64,'Maremmansko-abruzzský pastevecký pes',42,25,60);
INSERT INTO Zeme_puvodu
VALUES(64,'Anguilla','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(64,'Johnny','Brinson','703659071','iyKEghlR@gmail.com');
INSERT INTO Zakaznik
VALUES(64,59634313);
INSERT INTO Pes
VALUES(65,'Denise','fena',67000,TO_DATE('2011.09.09', 'yyyy.mm.dd'),49,34,9,38);
INSERT INTO Oceneni
VALUES(65,'Psí závody 2021',TO_DATE('2010.02.22', 'yyyy.mm.dd'),57);
INSERT INTO Test
VALUES(65,TO_DATE('2008.07.14', 'yyyy.mm.dd'),40,44);
INSERT INTO Ockovani
VALUES(65,TO_DATE('2008.05.28', 'yyyy.mm.dd'),TO_DATE('2010.06.06', 'yyyy.mm.dd'),30,21);
INSERT INTO Plemeno
VALUES(65,'Wetterhound',77,36,5);
INSERT INTO Zeme_puvodu
VALUES(65,'Christmas Island','Africa');
INSERT INTO Uzivatel
VALUES(65,'Jena','Merkle','746919131','Wrfvj@gmail.com');
INSERT INTO Zamestnanec
VALUES(65,TO_DATE('2009.12.16', 'yyyy.mm.dd'),'ošetřovatel',15000);
INSERT INTO Pes
VALUES(66,'Gale','pes',48000,TO_DATE('1990.04.07', 'yyyy.mm.dd'),40,5,27,16);
INSERT INTO Oceneni
VALUES(66,'Mushing závody',TO_DATE('2007.04.14', 'yyyy.mm.dd'),30);
INSERT INTO Test
VALUES(66,TO_DATE('1995.10.25', 'yyyy.mm.dd'),9,3);
INSERT INTO Ockovani
VALUES(66,TO_DATE('2002.09.08', 'yyyy.mm.dd'),TO_DATE('2008.07.16', 'yyyy.mm.dd'),16,63);
INSERT INTO Plemeno
VALUES(66,'Tornjak',52,18,3);
INSERT INTO Zeme_puvodu
VALUES(66,'Peru','Europe');
INSERT INTO Uzivatel
VALUES(66,'Jack','Turner','712770148','pGJhBKJFQe@gmail.com');
INSERT INTO Zakaznik
VALUES(66,25911814);
INSERT INTO Pes
VALUES(67,'Rod','fena',51000,TO_DATE('2009.08.29', 'yyyy.mm.dd'),50,63,44,63);
INSERT INTO Oceneni
VALUES(67,'Psí závody 2021',TO_DATE('2011.01.19', 'yyyy.mm.dd'),3);
INSERT INTO Test
VALUES(67,TO_DATE('1998.08.01', 'yyyy.mm.dd'),22,36);
INSERT INTO Ockovani
VALUES(67,TO_DATE('1991.11.11', 'yyyy.mm.dd'),TO_DATE('1994.12.23', 'yyyy.mm.dd'),NULL,35);
INSERT INTO Plemeno
VALUES(67,'Thajský ridgeback',38,19,28);
INSERT INTO Zeme_puvodu
VALUES(67,'Botswana','Asia');
INSERT INTO Uzivatel
VALUES(67,'Robert','Vandervort','702821461','AqYYaorjYDmMHFlM@gmail.com');
INSERT INTO Zamestnanec
VALUES(67,TO_DATE('1994.03.24', 'yyyy.mm.dd'),'účetní',14000);
INSERT INTO Pes
VALUES(68,'Edward','fena',13000,TO_DATE('2011.02.17', 'yyyy.mm.dd'),11,50,10,4);
INSERT INTO Oceneni
VALUES(68,'Extreme Dog Race',TO_DATE('1997.06.18', 'yyyy.mm.dd'),8);
INSERT INTO Test
VALUES(68,TO_DATE('2004.06.20', 'yyyy.mm.dd'),22,53);
INSERT INTO Ockovani
VALUES(68,TO_DATE('1992.03.05', 'yyyy.mm.dd'),TO_DATE('1995.11.15', 'yyyy.mm.dd'),12,17);
INSERT INTO Plemeno
VALUES(68,'Hovawart',33,16,1);
INSERT INTO Zeme_puvodu
VALUES(68,'Brunei Darussalam','Africa');
INSERT INTO Uzivatel
VALUES(68,'Joseph','Seger','796565926','HocBWHmuQbhiPcPD@gmail.com');
INSERT INTO Zakaznik
VALUES(68,75516813);
INSERT INTO Pes
VALUES(69,'Anthony','pes',47000,TO_DATE('1999.07.16', 'yyyy.mm.dd'),5,54,16,29);
INSERT INTO Oceneni
VALUES(69,'Psí závody 2021',TO_DATE('1991.09.16', 'yyyy.mm.dd'),5);
INSERT INTO Test
VALUES(69,TO_DATE('2000.10.18', 'yyyy.mm.dd'),25,42);
INSERT INTO Ockovani
VALUES(69,TO_DATE('1999.07.17', 'yyyy.mm.dd'),TO_DATE('2005.06.02', 'yyyy.mm.dd'),44,36);
INSERT INTO Plemeno
VALUES(69,'Holandský pinč',66,27,37);
INSERT INTO Zeme_puvodu
VALUES(69,'Tajikistan','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(69,'Annie','Buchanan','720012881','bwFcDU@gmail.com');
INSERT INTO Zamestnanec
VALUES(69,TO_DATE('2010.06.08', 'yyyy.mm.dd'),'účetní',19000);
INSERT INTO Pes
VALUES(70,'James','pes',52000,TO_DATE('2003.07.09', 'yyyy.mm.dd'),6,30,38,NULL);
INSERT INTO Oceneni
VALUES(70,'Pohár Mistra Maleniv',TO_DATE('2006.06.30', 'yyyy.mm.dd'),28);
INSERT INTO Test
VALUES(70,TO_DATE('2005.08.05', 'yyyy.mm.dd'),9,52);
INSERT INTO Ockovani
VALUES(70,TO_DATE('2001.12.17', 'yyyy.mm.dd'),TO_DATE('2006.06.24', 'yyyy.mm.dd'),65,64);
INSERT INTO Plemeno
VALUES(70,'Velký švýcarský salašnický pes',28,39,27);
INSERT INTO Zeme_puvodu
VALUES(70,'Estonia','Africa');
INSERT INTO Uzivatel
VALUES(70,'Tonja','Byrd','788532793','DfSaqmcYWQxQb@gmail.com');
INSERT INTO Zakaznik
VALUES(70,47688918);
INSERT INTO Pes
VALUES(71,'George','fena',41000,TO_DATE('2005.12.02', 'yyyy.mm.dd'),54,14,13,63);
INSERT INTO Oceneni
VALUES(71,'Hard Dog Race pravidla',TO_DATE('2001.09.04', 'yyyy.mm.dd'),45);
INSERT INTO Test
VALUES(71,TO_DATE('1990.01.28', 'yyyy.mm.dd'),12,33);
INSERT INTO Ockovani
VALUES(71,TO_DATE('1996.01.21', 'yyyy.mm.dd'),TO_DATE('1998.11.13', 'yyyy.mm.dd'),34,55);
INSERT INTO Plemeno
VALUES(71,'Norský losí pes černý',52,11,61);
INSERT INTO Zeme_puvodu
VALUES(71,'Equatorial Guinea','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(71,'William','Malloy','764224867','vRoxkxnudpFGohCjZ@gmail.com');
INSERT INTO Zamestnanec
VALUES(71,TO_DATE('1992.01.20', 'yyyy.mm.dd'),'vedoucí',25000);
INSERT INTO Pes
VALUES(72,'Doris','fena',51000,TO_DATE('2004.06.26', 'yyyy.mm.dd'),41,56,9,67);
INSERT INTO Oceneni
VALUES(72,'Mushing závody',TO_DATE('1993.08.29', 'yyyy.mm.dd'),40);
INSERT INTO Test
VALUES(72,TO_DATE('2002.03.04', 'yyyy.mm.dd'),8,54);
INSERT INTO Ockovani
VALUES(72,TO_DATE('1999.04.12', 'yyyy.mm.dd'),TO_DATE('2001.06.08', 'yyyy.mm.dd'),8,48);
INSERT INTO Plemeno
VALUES(72,'Jugoslávský planinský honič',45,13,35);
INSERT INTO Zeme_puvodu
VALUES(72,'Seychelles','Asia');
INSERT INTO Uzivatel
VALUES(72,'Paul','Chilcott','716706546','hebxcGXw@gmail.com');
INSERT INTO Zakaznik
VALUES(72,95791651);
INSERT INTO Pes
VALUES(73,'Abby','fena',52000,TO_DATE('1993.12.25', 'yyyy.mm.dd'),34,69,30,70);
INSERT INTO Oceneni
VALUES(73,'STEEPLECHASE',TO_DATE('1999.07.27', 'yyyy.mm.dd'),24);
INSERT INTO Test
VALUES(73,TO_DATE('1995.06.21', 'yyyy.mm.dd'),15,72);
INSERT INTO Ockovani
VALUES(73,TO_DATE('1998.05.12', 'yyyy.mm.dd'),TO_DATE('2000.07.19', 'yyyy.mm.dd'),72,66);
INSERT INTO Plemeno
VALUES(73,'Blue Lacy',61,33,22);
INSERT INTO Zeme_puvodu
VALUES(73,'Tonga','Europe');
INSERT INTO Uzivatel
VALUES(73,'Junior','Maloney','715542940','vXWOgCnajzOi@gmail.com');
INSERT INTO Zamestnanec
VALUES(73,TO_DATE('2004.01.23', 'yyyy.mm.dd'),'vedoucí',27000);
INSERT INTO Pes
VALUES(74,'Alyssa','pes',43000,TO_DATE('1992.01.09', 'yyyy.mm.dd'),57,14,65,38);
INSERT INTO Oceneni
VALUES(74,'Mushing závody',TO_DATE('2006.09.03', 'yyyy.mm.dd'),29);
INSERT INTO Test
VALUES(74,TO_DATE('1995.05.24', 'yyyy.mm.dd'),40,50);
INSERT INTO Ockovani
VALUES(74,TO_DATE('1991.08.21', 'yyyy.mm.dd'),TO_DATE('1996.01.02', 'yyyy.mm.dd'),38,66);
INSERT INTO Plemeno
VALUES(74,'Český horský pes',66,26,65);
INSERT INTO Zeme_puvodu
VALUES(74,'St Vincent/Grenadines','Asia');
INSERT INTO Uzivatel
VALUES(74,'Richard','Hall','777083387','dARBpP@gmail.com');
INSERT INTO Zakaznik
VALUES(74,53324216);
INSERT INTO Pes
VALUES(75,'Mark','pes',27000,TO_DATE('2002.05.08', 'yyyy.mm.dd'),48,69,41,30);
INSERT INTO Oceneni
VALUES(75,'Pohár Mistra Maleniv',TO_DATE('2007.04.16', 'yyyy.mm.dd'),8);
INSERT INTO Test
VALUES(75,TO_DATE('2007.04.16', 'yyyy.mm.dd'),21,43);
INSERT INTO Ockovani
VALUES(75,TO_DATE('1997.07.14', 'yyyy.mm.dd'),TO_DATE('1999.04.30', 'yyyy.mm.dd'),53,70);
INSERT INTO Plemeno
VALUES(75,'Otterhound',60,36,15);
INSERT INTO Zeme_puvodu
VALUES(75,'Singapore','Africa');
INSERT INTO Uzivatel
VALUES(75,'Bobbi','Wood','796271293','mPQyZQOAPrWR@gmail.com');
INSERT INTO Zamestnanec
VALUES(75,TO_DATE('2004.06.24', 'yyyy.mm.dd'),'účetní',15000);
INSERT INTO Pes
VALUES(76,'James','fena',32000,TO_DATE('1994.04.12', 'yyyy.mm.dd'),69,37,8,25);
INSERT INTO Oceneni
VALUES(76,'Mushing závody',TO_DATE('2009.06.21', 'yyyy.mm.dd'),13);
INSERT INTO Test
VALUES(76,TO_DATE('2000.10.09', 'yyyy.mm.dd'),18,37);
INSERT INTO Ockovani
VALUES(76,TO_DATE('1997.04.28', 'yyyy.mm.dd'),TO_DATE('1998.05.15', 'yyyy.mm.dd'),64,23);
INSERT INTO Plemeno
VALUES(76,'Tornjak',83,23,15);
INSERT INTO Zeme_puvodu
VALUES(76,'French Guiana','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(76,'Carole','Peterson','715514110','PWmLpaVbhOGZZg@gmail.com');
INSERT INTO Zakaznik
VALUES(76,46581981);
INSERT INTO Pes
VALUES(77,'Eleanor','fena',8000,TO_DATE('2001.11.25', 'yyyy.mm.dd'),16,42,14,29);
INSERT INTO Oceneni
VALUES(77,'Extreme Dog Race',TO_DATE('1996.11.30', 'yyyy.mm.dd'),25);
INSERT INTO Test
VALUES(77,TO_DATE('2004.05.22', 'yyyy.mm.dd'),20,29);
INSERT INTO Ockovani
VALUES(77,TO_DATE('2004.06.18', 'yyyy.mm.dd'),TO_DATE('2012.06.10', 'yyyy.mm.dd'),11,28);
INSERT INTO Plemeno
VALUES(77,'Americký eskymácký pes',54,29,67);
INSERT INTO Zeme_puvodu
VALUES(77,'Philippines','America');
INSERT INTO Uzivatel
VALUES(77,'Amanda','Owens','785204923','RTMxrjuRDpxFT@gmail.com');
INSERT INTO Zamestnanec
VALUES(77,TO_DATE('1990.11.08', 'yyyy.mm.dd'),'vedoucí',16000);
INSERT INTO Pes
VALUES(78,'Sharron','pes',64000,TO_DATE('2009.11.25', 'yyyy.mm.dd'),20,38,71,10);
INSERT INTO Oceneni
VALUES(78,'Závody psích spřežení',TO_DATE('1993.04.10', 'yyyy.mm.dd'),30);
INSERT INTO Test
VALUES(78,TO_DATE('2009.03.02', 'yyyy.mm.dd'),30,40);
INSERT INTO Ockovani
VALUES(78,TO_DATE('1998.07.08', 'yyyy.mm.dd'),TO_DATE('2001.10.27', 'yyyy.mm.dd'),51,62);
INSERT INTO Plemeno
VALUES(78,'Cao de Castro Laboreiro',41,7,2);
INSERT INTO Zeme_puvodu
VALUES(78,'Syrian Arab Republic','Africa');
INSERT INTO Uzivatel
VALUES(78,'James','Burnham','742452055','xPdDSSaeebc@gmail.com');
INSERT INTO Zakaznik
VALUES(78,11383277);
INSERT INTO Pes
VALUES(79,'Donna','fena',19000,TO_DATE('1996.01.22', 'yyyy.mm.dd'),47,16,17,54);
INSERT INTO Oceneni
VALUES(79,'Extreme Dog Race',TO_DATE('2007.05.12', 'yyyy.mm.dd'),30);
INSERT INTO Test
VALUES(79,TO_DATE('1991.01.05', 'yyyy.mm.dd'),18,62);
INSERT INTO Ockovani
VALUES(79,TO_DATE('2006.05.18', 'yyyy.mm.dd'),TO_DATE('2012.11.15', 'yyyy.mm.dd'),27,30);
INSERT INTO Plemeno
VALUES(79,'Americká akita (neboli velký japonský pes)',90,8,64);
INSERT INTO Zeme_puvodu
VALUES(79,'Moldova','America');
INSERT INTO Uzivatel
VALUES(79,'Evelyn','Rector','715853998','mBsdwAUV@gmail.com');
INSERT INTO Zamestnanec
VALUES(79,TO_DATE('1997.10.09', 'yyyy.mm.dd'),'ošetřovatel',15000);
INSERT INTO Pes
VALUES(80,'Stephen','fena',61000,TO_DATE('1993.11.21', 'yyyy.mm.dd'),37,8,29,70);
INSERT INTO Oceneni
VALUES(80,'Mushing závody',TO_DATE('2010.08.13', 'yyyy.mm.dd'),5);
INSERT INTO Test
VALUES(80,TO_DATE('1993.01.10', 'yyyy.mm.dd'),11,74);
INSERT INTO Ockovani
VALUES(80,TO_DATE('2010.08.01', 'yyyy.mm.dd'),TO_DATE('2018.01.15', 'yyyy.mm.dd'),52,40);
INSERT INTO Plemeno
VALUES(80,'Grónský pes',51,7,30);
INSERT INTO Zeme_puvodu
VALUES(80,'Panama','America');
INSERT INTO Uzivatel
VALUES(80,'Larry','Wraight','741530358','YXZJRRghxmqHBTiENAH@gmail.com');
INSERT INTO Zakaznik
VALUES(80,13237418);
INSERT INTO Pes
VALUES(81,'Harold','fena',38000,TO_DATE('2005.08.21', 'yyyy.mm.dd'),76,38,NULL,61);
INSERT INTO Oceneni
VALUES(81,'Extreme Dog Race',TO_DATE('1999.05.06', 'yyyy.mm.dd'),49);
INSERT INTO Test
VALUES(81,TO_DATE('2008.05.30', 'yyyy.mm.dd'),38,40);
INSERT INTO Ockovani
VALUES(81,TO_DATE('1994.11.09', 'yyyy.mm.dd'),TO_DATE('2001.04.17', 'yyyy.mm.dd'),79,63);
INSERT INTO Plemeno
VALUES(81,'Anglický špringršpaněl',72,34,77);
INSERT INTO Zeme_puvodu
VALUES(81,'St Vincent/Grenadines','Africa');
INSERT INTO Uzivatel
VALUES(81,'Delores','Johnson','767674486','FXLuxXBYhlHvxBAZmow@gmail.com');
INSERT INTO Zamestnanec
VALUES(81,TO_DATE('2008.09.09', 'yyyy.mm.dd'),'vedoucí',15000);
INSERT INTO Pes
VALUES(82,'Roger','fena',26000,TO_DATE('2008.09.30', 'yyyy.mm.dd'),33,51,5,46);
INSERT INTO Oceneni
VALUES(82,'Závody psích spřežení',TO_DATE('1991.06.08', 'yyyy.mm.dd'),8);
INSERT INTO Test
VALUES(82,TO_DATE('2007.02.23', 'yyyy.mm.dd'),20,37);
INSERT INTO Ockovani
VALUES(82,TO_DATE('2008.04.11', 'yyyy.mm.dd'),TO_DATE('2013.01.23', 'yyyy.mm.dd'),49,44);
INSERT INTO Plemeno
VALUES(82,'Irish Glen of Imaal terier',66,40,67);
INSERT INTO Zeme_puvodu
VALUES(82,'Saint Kitts And Nevis','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(82,'Brittany','Caravati','772095111','boAiqFwRaHQ@gmail.com');
INSERT INTO Zakaznik
VALUES(82,18275175);
INSERT INTO Pes
VALUES(83,'Shannon','pes',16000,TO_DATE('1995.10.16', 'yyyy.mm.dd'),60,49,52,26);
INSERT INTO Oceneni
VALUES(83,'Virtual 4ALL',TO_DATE('1998.09.06', 'yyyy.mm.dd'),17);
INSERT INTO Test
VALUES(83,TO_DATE('2002.11.01', 'yyyy.mm.dd'),29,28);
INSERT INTO Ockovani
VALUES(83,TO_DATE('1993.04.03', 'yyyy.mm.dd'),TO_DATE('1999.11.29', 'yyyy.mm.dd'),69,10);
INSERT INTO Plemeno
VALUES(83,'Bernský salašnický pes',75,22,66);
INSERT INTO Zeme_puvodu
VALUES(83,'France','Africa');
INSERT INTO Uzivatel
VALUES(83,'Lisa','Tripp','721825832','qJblaR@gmail.com');
INSERT INTO Zamestnanec
VALUES(83,TO_DATE('1992.12.14', 'yyyy.mm.dd'),'uklízeč',23000);
INSERT INTO Pes
VALUES(84,'Anita','pes',43000,TO_DATE('1993.12.17', 'yyyy.mm.dd'),71,75,8,40);
INSERT INTO Oceneni
VALUES(84,'Mushing závody',TO_DATE('1998.05.29', 'yyyy.mm.dd'),55);
INSERT INTO Test
VALUES(84,TO_DATE('1998.05.25', 'yyyy.mm.dd'),19,20);
INSERT INTO Ockovani
VALUES(84,TO_DATE('1995.04.07', 'yyyy.mm.dd'),TO_DATE('1998.03.25', 'yyyy.mm.dd'),19,83);
INSERT INTO Plemeno
VALUES(84,'Francouzský ohař dlouhosrstý',63,29,61);
INSERT INTO Zeme_puvodu
VALUES(84,'Djibouti','America');
INSERT INTO Uzivatel
VALUES(84,'David','Hollman','734869260','CrasTEocqsejJJem@gmail.com');
INSERT INTO Zakaznik
VALUES(84,82788664);
INSERT INTO Pes
VALUES(85,'Roxana','pes',68000,TO_DATE('1999.08.27', 'yyyy.mm.dd'),33,47,16,6);
INSERT INTO Oceneni
VALUES(85,'Pohár Mistra Maleniv',TO_DATE('1992.02.02', 'yyyy.mm.dd'),15);
INSERT INTO Test
VALUES(85,TO_DATE('2006.03.20', 'yyyy.mm.dd'),26,7);
INSERT INTO Ockovani
VALUES(85,TO_DATE('1998.11.13', 'yyyy.mm.dd'),TO_DATE('2007.01.25', 'yyyy.mm.dd'),10,5);
INSERT INTO Plemeno
VALUES(85,'Bulteriér',23,28,75);
INSERT INTO Zeme_puvodu
VALUES(85,'Tokelau','America');
INSERT INTO Uzivatel
VALUES(85,'Jennifer','Wylie','728824171','GeFyIilJq@gmail.com');
INSERT INTO Zamestnanec
VALUES(85,TO_DATE('1998.05.10', 'yyyy.mm.dd'),'vedoucí',23000);
INSERT INTO Pes
VALUES(86,'Paul','fena',48000,TO_DATE('1991.03.16', 'yyyy.mm.dd'),42,65,33,42);
INSERT INTO Oceneni
VALUES(86,'Psí závody 2021',TO_DATE('1991.06.15', 'yyyy.mm.dd'),77);
INSERT INTO Test
VALUES(86,TO_DATE('2007.06.12', 'yyyy.mm.dd'),9,3);
INSERT INTO Ockovani
VALUES(86,TO_DATE('2009.10.31', 'yyyy.mm.dd'),TO_DATE('2011.02.03', 'yyyy.mm.dd'),23,9);
INSERT INTO Plemeno
VALUES(86,'Krašský pastevecký pes',81,33,6);
INSERT INTO Zeme_puvodu
VALUES(86,'Taiwan','Africa');
INSERT INTO Uzivatel
VALUES(86,'Scot','Malkani','782912677','BlTBVWxaZd@gmail.com');
INSERT INTO Zakaznik
VALUES(86,37127222);
INSERT INTO Pes
VALUES(87,'Lucina','fena',5000,TO_DATE('1997.04.10', 'yyyy.mm.dd'),42,77,10,62);
INSERT INTO Oceneni
VALUES(87,'Hard Dog Race pravidla',TO_DATE('2005.09.21', 'yyyy.mm.dd'),13);
INSERT INTO Test
VALUES(87,TO_DATE('1998.11.01', 'yyyy.mm.dd'),16,65);
INSERT INTO Ockovani
VALUES(87,TO_DATE('2006.08.15', 'yyyy.mm.dd'),TO_DATE('2010.05.21', 'yyyy.mm.dd'),45,67);
INSERT INTO Plemeno
VALUES(87,'Japonský špic',63,39,74);
INSERT INTO Zeme_puvodu
VALUES(87,'Equatorial Guinea','Asia');
INSERT INTO Uzivatel
VALUES(87,'Charles','Brown','714349713','GcMVUDZSkgkhbnlP@gmail.com');
INSERT INTO Zamestnanec
VALUES(87,TO_DATE('2005.08.30', 'yyyy.mm.dd'),'ošetřovatel',30000);
INSERT INTO Pes
VALUES(88,'Herbert','pes',22000,TO_DATE('1993.02.23', 'yyyy.mm.dd'),50,51,9,28);
INSERT INTO Oceneni
VALUES(88,'Psí závody 2021',TO_DATE('1991.12.31', 'yyyy.mm.dd'),41);
INSERT INTO Test
VALUES(88,TO_DATE('2001.09.23', 'yyyy.mm.dd'),23,11);
INSERT INTO Ockovani
VALUES(88,TO_DATE('2011.11.23', 'yyyy.mm.dd'),TO_DATE('2020.02.09', 'yyyy.mm.dd'),4,60);
INSERT INTO Plemeno
VALUES(88,'Kooikerhondje',50,28,24);
INSERT INTO Zeme_puvodu
VALUES(88,'El Salvador','Asia');
INSERT INTO Uzivatel
VALUES(88,'Sharon','Parrish','795555524','eSrCkQkZmPkhQw@gmail.com');
INSERT INTO Zakaznik
VALUES(88,17124658);
INSERT INTO Pes
VALUES(89,'Otto','pes',31000,TO_DATE('2001.08.14', 'yyyy.mm.dd'),49,88,20,52);
INSERT INTO Oceneni
VALUES(89,'Virtual 4ALL',TO_DATE('1993.09.24', 'yyyy.mm.dd'),42);
INSERT INTO Test
VALUES(89,TO_DATE('2001.09.04', 'yyyy.mm.dd'),17,NULL);
INSERT INTO Ockovani
VALUES(89,TO_DATE('2008.02.07', 'yyyy.mm.dd'),TO_DATE('2015.06.05', 'yyyy.mm.dd'),5,60);
INSERT INTO Plemeno
VALUES(89,'Foxteriér hladkosrstý',84,20,58);
INSERT INTO Zeme_puvodu
VALUES(89,'Maldives','Africa');
INSERT INTO Uzivatel
VALUES(89,'Alfred','Tommie','702962079','pEwSdwEoUWwcuesXtHg@gmail.com');
INSERT INTO Zamestnanec
VALUES(89,TO_DATE('2000.06.22', 'yyyy.mm.dd'),'vedoucí',22000);
INSERT INTO Pes
VALUES(90,'Edith','fena',25000,TO_DATE('2003.07.08', 'yyyy.mm.dd'),54,75,63,44);
INSERT INTO Oceneni
VALUES(90,'Extreme Dog Race',TO_DATE('2002.06.23', 'yyyy.mm.dd'),38);
INSERT INTO Test
VALUES(90,TO_DATE('2001.12.04', 'yyyy.mm.dd'),33,59);
INSERT INTO Ockovani
VALUES(90,TO_DATE('1991.03.05', 'yyyy.mm.dd'),TO_DATE('1997.10.12', 'yyyy.mm.dd'),23,44);
INSERT INTO Plemeno
VALUES(90,'Norský losí pes šedý',20,11,77);
INSERT INTO Zeme_puvodu
VALUES(90,'Ireland','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(90,'Hope','Conners','783624540','sGoMNJdljdIt@gmail.com');
INSERT INTO Zakaznik
VALUES(90,18495516);
INSERT INTO Pes
VALUES(91,'Rhonda','pes',20000,TO_DATE('2006.03.01', 'yyyy.mm.dd'),39,73,14,24);
INSERT INTO Oceneni
VALUES(91,'Extreme Dog Race',TO_DATE('2007.12.05', 'yyyy.mm.dd'),55);
INSERT INTO Test
VALUES(91,TO_DATE('2008.08.03', 'yyyy.mm.dd'),36,11);
INSERT INTO Ockovani
VALUES(91,TO_DATE('1991.08.30', 'yyyy.mm.dd'),TO_DATE('1996.04.20', 'yyyy.mm.dd'),10,68);
INSERT INTO Plemeno
VALUES(91,'Chortaja borzaja',58,39,25);
INSERT INTO Zeme_puvodu
VALUES(91,'Iceland','Europe');
INSERT INTO Uzivatel
VALUES(91,'Bonnie','Dulaney','721433475','yiXwbllBVyWDr@gmail.com');
INSERT INTO Zamestnanec
VALUES(91,TO_DATE('1998.04.09', 'yyyy.mm.dd'),'účetní',19000);
INSERT INTO Pes
VALUES(92,'Maria','pes',27000,TO_DATE('1999.07.21', 'yyyy.mm.dd'),25,82,76,12);
INSERT INTO Oceneni
VALUES(92,'Extreme Dog Race',TO_DATE('2010.04.13', 'yyyy.mm.dd'),56);
INSERT INTO Test
VALUES(92,TO_DATE('1996.11.08', 'yyyy.mm.dd'),35,13);
INSERT INTO Ockovani
VALUES(92,TO_DATE('1994.08.04', 'yyyy.mm.dd'),TO_DATE('1997.08.11', 'yyyy.mm.dd'),48,42);
INSERT INTO Plemeno
VALUES(92,'Plottův pes',49,25,76);
INSERT INTO Zeme_puvodu
VALUES(92,'Chile','Antarctica');
INSERT INTO Uzivatel
VALUES(92,'Kathleen','Daniels','793045266','ucnYGc@gmail.com');
INSERT INTO Zakaznik
VALUES(92,68395761);
INSERT INTO Pes
VALUES(93,'Eddie','pes',35000,TO_DATE('1993.11.07', 'yyyy.mm.dd'),76,36,74,4);
INSERT INTO Oceneni
VALUES(93,'STEEPLECHASE',TO_DATE('1995.06.10', 'yyyy.mm.dd'),33);
INSERT INTO Test
VALUES(93,TO_DATE('2008.04.04', 'yyyy.mm.dd'),29,30);
INSERT INTO Ockovani
VALUES(93,TO_DATE('1997.09.03', 'yyyy.mm.dd'),TO_DATE('2003.12.31', 'yyyy.mm.dd'),35,24);
INSERT INTO Plemeno
VALUES(93,'Pumi',50,23,71);
INSERT INTO Zeme_puvodu
VALUES(93,'Gibraltar','Africa');
INSERT INTO Uzivatel
VALUES(93,'Mable','Wilson','790657228','IsThyRDFP@gmail.com');
INSERT INTO Zamestnanec
VALUES(93,TO_DATE('2009.08.09', 'yyyy.mm.dd'),'účetní',29000);
INSERT INTO Pes
VALUES(94,'Judith','pes',55000,TO_DATE('2011.08.18', 'yyyy.mm.dd'),15,67,85,39);
INSERT INTO Oceneni
VALUES(94,'Virtual 4ALL',TO_DATE('2011.09.12', 'yyyy.mm.dd'),31);
INSERT INTO Test
VALUES(94,TO_DATE('1995.07.28', 'yyyy.mm.dd'),30,28);
INSERT INTO Ockovani
VALUES(94,TO_DATE('1997.10.09', 'yyyy.mm.dd'),TO_DATE('2004.12.10', 'yyyy.mm.dd'),8,36);
INSERT INTO Plemeno
VALUES(94,'Podhalaňský ovčák',31,14,5);
INSERT INTO Zeme_puvodu
VALUES(94,'Niue','Asia');
INSERT INTO Uzivatel
VALUES(94,'Tracy','Dupont','726960854','BmnGwMSsKbeXIdNFF@gmail.com');
INSERT INTO Zakaznik
VALUES(94,59325751);
INSERT INTO Pes
VALUES(95,'David','fena',63000,TO_DATE('1998.12.15', 'yyyy.mm.dd'),79,7,18,28);
INSERT INTO Oceneni
VALUES(95,'STEEPLECHASE',TO_DATE('2009.02.13', 'yyyy.mm.dd'),66);
INSERT INTO Test
VALUES(95,TO_DATE('1990.01.13', 'yyyy.mm.dd'),22,18);
INSERT INTO Ockovani
VALUES(95,TO_DATE('1991.03.09', 'yyyy.mm.dd'),TO_DATE('1994.09.08', 'yyyy.mm.dd'),61,42);
INSERT INTO Plemeno
VALUES(95,'Burgoský perdiquero',50,32,56);
INSERT INTO Zeme_puvodu
VALUES(95,'Jamaica','America');
INSERT INTO Uzivatel
VALUES(95,'Anne','Gordon','702092014','sKiwswElnvjRELGB@gmail.com');
INSERT INTO Zamestnanec
VALUES(95,TO_DATE('1990.11.16', 'yyyy.mm.dd'),'ošetřovatel',16000);
INSERT INTO Pes
VALUES(96,'Charles','pes',58000,TO_DATE('2008.03.23', 'yyyy.mm.dd'),81,1,6,11);
INSERT INTO Oceneni
VALUES(96,'STEEPLECHASE',TO_DATE('2001.03.23', 'yyyy.mm.dd'),85);
INSERT INTO Test
VALUES(96,TO_DATE('2000.05.02', 'yyyy.mm.dd'),13,32);
INSERT INTO Ockovani
VALUES(96,TO_DATE('2002.08.17', 'yyyy.mm.dd'),TO_DATE('2003.01.11', 'yyyy.mm.dd'),27,6);
INSERT INTO Plemeno
VALUES(96,'Parson Russell teriér',88,16,56);
INSERT INTO Zeme_puvodu
VALUES(96,'Saudi Arabia','Asia');
INSERT INTO Uzivatel
VALUES(96,'Dennis','Fehrenbach','760453460','BGLvOVMQA@gmail.com');
INSERT INTO Zakaznik
VALUES(96,28295733);
INSERT INTO Pes
VALUES(97,'Jimmy','fena',56000,TO_DATE('2008.09.29', 'yyyy.mm.dd'),58,60,4,19);
INSERT INTO Oceneni
VALUES(97,'Czech DOG race',TO_DATE('1999.07.31', 'yyyy.mm.dd'),93);
INSERT INTO Test
VALUES(97,TO_DATE('2004.03.06', 'yyyy.mm.dd'),23,74);
INSERT INTO Ockovani
VALUES(97,TO_DATE('1993.02.19', 'yyyy.mm.dd'),TO_DATE('1997.11.19', 'yyyy.mm.dd'),41,27);
INSERT INTO Plemeno
VALUES(97,'Entlebušský salašnický pes',20,8,47);
INSERT INTO Zeme_puvodu
VALUES(97,'Malawi','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(97,'Barbara','Phillips','748339680','emKlidqwMgXEEAs@gmail.com');
INSERT INTO Zamestnanec
VALUES(97,TO_DATE('2008.10.22', 'yyyy.mm.dd'),'uklízeč',26000);
INSERT INTO Pes
VALUES(98,'James','fena',62000,TO_DATE('2008.09.09', 'yyyy.mm.dd'),80,7,36,87);
INSERT INTO Oceneni
VALUES(98,'Mushing závody',TO_DATE('1997.09.27', 'yyyy.mm.dd'),77);
INSERT INTO Test
VALUES(98,TO_DATE('2011.11.20', 'yyyy.mm.dd'),33,45);
INSERT INTO Ockovani
VALUES(98,TO_DATE('2011.03.16', 'yyyy.mm.dd'),TO_DATE('2015.07.15', 'yyyy.mm.dd'),67,78);
INSERT INTO Plemeno
VALUES(98,'Dobrman',34,8,84);
INSERT INTO Zeme_puvodu
VALUES(98,'Bulgaria','Europe');
INSERT INTO Uzivatel
VALUES(98,'Mattie','Walley','753661419','AqaUTLGmG@gmail.com');
INSERT INTO Zakaznik
VALUES(98,65545155);
INSERT INTO Pes
VALUES(99,'Bryant','fena',30000,TO_DATE('2001.10.18', 'yyyy.mm.dd'),9,45,92,18);
INSERT INTO Oceneni
VALUES(99,'Virtual 4ALL',TO_DATE('2011.04.19', 'yyyy.mm.dd'),14);
INSERT INTO Test
VALUES(99,TO_DATE('1999.02.13', 'yyyy.mm.dd'),25,24);
INSERT INTO Ockovani
VALUES(99,TO_DATE('2010.02.04', 'yyyy.mm.dd'),TO_DATE('2012.06.09', 'yyyy.mm.dd'),90,46);
INSERT INTO Plemeno
VALUES(99,'Francouzský ohař dlouhosrstý',35,26,89);
INSERT INTO Zeme_puvodu
VALUES(99,'Moldova','Asia');
INSERT INTO Uzivatel
VALUES(99,'John','Weeden','765858238','hSeRfxEZaxEyLApUX@gmail.com');
INSERT INTO Zamestnanec
VALUES(99,TO_DATE('1994.09.21', 'yyyy.mm.dd'),'uklízeč',18000);
INSERT INTO Pes
VALUES(100,'Bobby','fena',42000,TO_DATE('2006.07.21', 'yyyy.mm.dd'),5,53,96,42);
INSERT INTO Oceneni
VALUES(100,'STEEPLECHASE',TO_DATE('2008.09.12', 'yyyy.mm.dd'),46);
INSERT INTO Test
VALUES(100,TO_DATE('2003.08.05', 'yyyy.mm.dd'),27,44);
INSERT INTO Ockovani
VALUES(100,TO_DATE('2008.06.26', 'yyyy.mm.dd'),TO_DATE('2015.10.02', 'yyyy.mm.dd'),60,55);
INSERT INTO Plemeno
VALUES(100,'Kavalír King Charles španěl',43,30,27);
INSERT INTO Zeme_puvodu
VALUES(100,'United Kingdom','Europe');
INSERT INTO Uzivatel
VALUES(100,'Robert','Davila','735443437','WVdtHAvqVueiGrTL@gmail.com');
INSERT INTO Zakaznik
VALUES(100,23955398);
INSERT INTO Pes
VALUES(101,'Annie','fena',54000,TO_DATE('1999.06.02', 'yyyy.mm.dd'),78,39,7,30);
INSERT INTO Oceneni
VALUES(101,'Virtual 4ALL',TO_DATE('1992.03.24', 'yyyy.mm.dd'),64);
INSERT INTO Test
VALUES(101,TO_DATE('2003.09.25', 'yyyy.mm.dd'),15,36);
INSERT INTO Ockovani
VALUES(101,TO_DATE('1998.05.26', 'yyyy.mm.dd'),TO_DATE('2005.02.20', 'yyyy.mm.dd'),56,10);
INSERT INTO Plemeno
VALUES(101,'Sussex španěl',74,39,57);
INSERT INTO Zeme_puvodu
VALUES(101,'Italy','Antarctica');
INSERT INTO Uzivatel
VALUES(101,'Arthur','Johns','744228338','QYkvdApLZwEQrmN@gmail.com');
INSERT INTO Zamestnanec
VALUES(101,TO_DATE('2004.08.24', 'yyyy.mm.dd'),'vedoucí',22000);
INSERT INTO Pes
VALUES(102,'Jacquline','pes',27000,TO_DATE('2009.07.02', 'yyyy.mm.dd'),32,17,8,84);
INSERT INTO Oceneni
VALUES(102,'Virtual 4ALL',TO_DATE('1996.04.23', 'yyyy.mm.dd'),19);
INSERT INTO Test
VALUES(102,TO_DATE('2001.03.12', 'yyyy.mm.dd'),29,56);
INSERT INTO Ockovani
VALUES(102,TO_DATE('2004.01.24', 'yyyy.mm.dd'),TO_DATE('2011.01.25', 'yyyy.mm.dd'),59,1);
INSERT INTO Plemeno
VALUES(102,'Srbský honič (neboli balkánský honič)',29,36,47);
INSERT INTO Zeme_puvodu
VALUES(102,'Belarus','Africa');
INSERT INTO Uzivatel
VALUES(102,'Mary','Simpson','780284639','TdcrbrstRJmagcb@gmail.com');
INSERT INTO Zakaznik
VALUES(102,17375558);
INSERT INTO Pes
VALUES(103,'Ladonna','pes',20000,TO_DATE('1990.02.02', 'yyyy.mm.dd'),97,86,1,44);
INSERT INTO Oceneni
VALUES(103,'STEEPLECHASE',TO_DATE('2008.07.28', 'yyyy.mm.dd'),4);
INSERT INTO Test
VALUES(103,TO_DATE('1994.09.21', 'yyyy.mm.dd'),29,33);
INSERT INTO Ockovani
VALUES(103,TO_DATE('1990.10.26', 'yyyy.mm.dd'),TO_DATE('1995.01.28', 'yyyy.mm.dd'),38,94);
INSERT INTO Plemeno
VALUES(103,'Belgický ovčák - Malinois',22,28,28);
INSERT INTO Zeme_puvodu
VALUES(103,'Liechtenstein','Antarctica');
INSERT INTO Uzivatel
VALUES(103,'Pamela','Bull','749945345','ghzhEllbMqFtnYhz@gmail.com');
INSERT INTO Zamestnanec
VALUES(103,TO_DATE('1998.10.27', 'yyyy.mm.dd'),'uklízeč',23000);
INSERT INTO Pes
VALUES(104,'Ethel','fena',64000,TO_DATE('2007.04.18', 'yyyy.mm.dd'),71,69,76,45);
INSERT INTO Oceneni
VALUES(104,'Hard Dog Race pravidla',TO_DATE('1992.03.28', 'yyyy.mm.dd'),18);
INSERT INTO Test
VALUES(104,TO_DATE('2006.02.17', 'yyyy.mm.dd'),35,25);
INSERT INTO Ockovani
VALUES(104,TO_DATE('1995.11.22', 'yyyy.mm.dd'),TO_DATE('1998.06.11', 'yyyy.mm.dd'),10,57);
INSERT INTO Plemeno
VALUES(104,'Francouzský bílo-černý honič',39,37,103);
INSERT INTO Zeme_puvodu
VALUES(104,'Guatemala','Africa');
INSERT INTO Uzivatel
VALUES(104,'Cheryl','Brown','748032211','heRvpu@gmail.com');
INSERT INTO Zakaznik
VALUES(104,27346449);
INSERT INTO Pes
VALUES(105,'Lula','pes',26000,TO_DATE('1994.05.21', 'yyyy.mm.dd'),99,1,49,86);
INSERT INTO Oceneni
VALUES(105,'Pohár Mistra Maleniv',TO_DATE('2008.07.12', 'yyyy.mm.dd'),22);
INSERT INTO Test
VALUES(105,TO_DATE('1997.09.24', 'yyyy.mm.dd'),25,61);
INSERT INTO Ockovani
VALUES(105,TO_DATE('1999.12.10', 'yyyy.mm.dd'),TO_DATE('2001.11.28', 'yyyy.mm.dd'),64,94);
INSERT INTO Plemeno
VALUES(105,'Krysí teriér',56,20,70);
INSERT INTO Zeme_puvodu
VALUES(105,'Spain','Antarctica');
INSERT INTO Uzivatel
VALUES(105,'Aaron','Johnson','709078263','cSqoqj@gmail.com');
INSERT INTO Zamestnanec
VALUES(105,TO_DATE('2001.08.12', 'yyyy.mm.dd'),'vedoucí',24000);
INSERT INTO Pes
VALUES(106,'Claude','pes',19000,TO_DATE('2005.12.26', 'yyyy.mm.dd'),60,12,30,84);
INSERT INTO Oceneni
VALUES(106,'Virtual 4ALL',TO_DATE('2006.02.05', 'yyyy.mm.dd'),53);
INSERT INTO Test
VALUES(106,TO_DATE('2000.04.28', 'yyyy.mm.dd'),25,36);
INSERT INTO Ockovani
VALUES(106,TO_DATE('2009.01.24', 'yyyy.mm.dd'),TO_DATE('2011.09.24', 'yyyy.mm.dd'),94,91);
INSERT INTO Plemeno
VALUES(106,'Plavý bretaňský baset',36,20,NULL);
INSERT INTO Zeme_puvodu
VALUES(106,'Madagascar','Asia');
INSERT INTO Uzivatel
VALUES(106,'Nicholas','Coffelt','711925180','BDCDOa@gmail.com');
INSERT INTO Zakaznik
VALUES(106,71666554);
INSERT INTO Pes
VALUES(107,'Bobby','fena',46000,TO_DATE('2001.06.10', 'yyyy.mm.dd'),12,35,37,72);
INSERT INTO Oceneni
VALUES(107,'Czech DOG race',TO_DATE('1997.03.11', 'yyyy.mm.dd'),21);
INSERT INTO Test
VALUES(107,TO_DATE('1993.07.14', 'yyyy.mm.dd'),35,17);
INSERT INTO Ockovani
VALUES(107,TO_DATE('2001.05.07', 'yyyy.mm.dd'),TO_DATE('2001.06.04', 'yyyy.mm.dd'),60,66);
INSERT INTO Plemeno
VALUES(107,'Peruánský naháč',66,14,18);
INSERT INTO Zeme_puvodu
VALUES(107,'French Guiana','America');
INSERT INTO Uzivatel
VALUES(107,'Jacob','Warren','766179396','BzcILSTTSnECwzkWPz@gmail.com');
INSERT INTO Zamestnanec
VALUES(107,TO_DATE('1990.10.08', 'yyyy.mm.dd'),'vedoucí',19000);
INSERT INTO Pes
VALUES(108,'Michael','fena',20000,TO_DATE('2007.05.16', 'yyyy.mm.dd'),42,20,96,4);
INSERT INTO Oceneni
VALUES(108,'Pohár Mistra Maleniv',TO_DATE('1990.07.22', 'yyyy.mm.dd'),83);
INSERT INTO Test
VALUES(108,TO_DATE('1996.12.21', 'yyyy.mm.dd'),10,48);
INSERT INTO Ockovani
VALUES(108,TO_DATE('2003.12.19', 'yyyy.mm.dd'),TO_DATE('2005.05.18', 'yyyy.mm.dd'),19,73);
INSERT INTO Plemeno
VALUES(108,'Irský vodní španěl',45,22,98);
INSERT INTO Zeme_puvodu
VALUES(108,'United Kingdom','Antarctica');
INSERT INTO Uzivatel
VALUES(108,'Marian','Bryant','799347969','qCOhZFBbmdv@gmail.com');
INSERT INTO Zakaznik
VALUES(108,36881413);
INSERT INTO Pes
VALUES(109,'Glenna','pes',37000,TO_DATE('2003.05.30', 'yyyy.mm.dd'),NULL,25,87,11);
INSERT INTO Oceneni
VALUES(109,'Czech DOG race',TO_DATE('1991.05.24', 'yyyy.mm.dd'),67);
INSERT INTO Test
VALUES(109,TO_DATE('1995.10.27', 'yyyy.mm.dd'),36,33);
INSERT INTO Ockovani
VALUES(109,TO_DATE('2009.03.01', 'yyyy.mm.dd'),TO_DATE('2016.06.27', 'yyyy.mm.dd'),66,3);
INSERT INTO Plemeno
VALUES(109,'Rhodéský ridgeback',45,24,92);
INSERT INTO Zeme_puvodu
VALUES(109,'Switzerland','America');
INSERT INTO Uzivatel
VALUES(109,'Rose','Schultz','747016099','KZXdXQqkuV@gmail.com');
INSERT INTO Zamestnanec
VALUES(109,TO_DATE('2005.05.21', 'yyyy.mm.dd'),'vedoucí',19000);
INSERT INTO Pes
VALUES(110,'Rachel','fena',26000,TO_DATE('1997.12.28', 'yyyy.mm.dd'),71,20,19,13);
INSERT INTO Oceneni
VALUES(110,'STEEPLECHASE',TO_DATE('2006.10.27', 'yyyy.mm.dd'),77);
INSERT INTO Test
VALUES(110,TO_DATE('2009.01.05', 'yyyy.mm.dd'),40,69);
INSERT INTO Ockovani
VALUES(110,TO_DATE('1992.03.06', 'yyyy.mm.dd'),TO_DATE('1997.05.04', 'yyyy.mm.dd'),42,25);
INSERT INTO Plemeno
VALUES(110,'Malý modrý gaskoňský honič',81,11,88);
INSERT INTO Zeme_puvodu
VALUES(110,'Burkina Faso','Antarctica');
INSERT INTO Uzivatel
VALUES(110,'William','Kornbluth','748561082','nGwDjIyBsySyA@gmail.com');
INSERT INTO Zakaznik
VALUES(110,71926665);
INSERT INTO Pes
VALUES(111,'Maryann','fena',38000,TO_DATE('1998.06.17', 'yyyy.mm.dd'),14,24,41,13);
INSERT INTO Oceneni
VALUES(111,'Hard Dog Race pravidla',TO_DATE('2007.10.22', 'yyyy.mm.dd'),36);
INSERT INTO Test
VALUES(111,TO_DATE('1992.08.01', 'yyyy.mm.dd'),30,87);
INSERT INTO Ockovani
VALUES(111,TO_DATE('2006.12.05', 'yyyy.mm.dd'),TO_DATE('2012.01.12', 'yyyy.mm.dd'),22,64);
INSERT INTO Plemeno
VALUES(111,'Norský lundehund',39,15,12);
INSERT INTO Zeme_puvodu
VALUES(111,'Singapore','America');
INSERT INTO Uzivatel
VALUES(111,'James','Strickland','785659786','hCWhygABYYqZWBAHTdH@gmail.com');
INSERT INTO Zamestnanec
VALUES(111,TO_DATE('2004.11.20', 'yyyy.mm.dd'),'uklízeč',19000);
INSERT INTO Pes
VALUES(112,'David','pes',64000,TO_DATE('1992.04.07', 'yyyy.mm.dd'),90,7,21,34);
INSERT INTO Oceneni
VALUES(112,'STEEPLECHASE',TO_DATE('2010.09.11', 'yyyy.mm.dd'),11);
INSERT INTO Test
VALUES(112,TO_DATE('2000.04.27', 'yyyy.mm.dd'),23,99);
INSERT INTO Ockovani
VALUES(112,TO_DATE('2005.12.04', 'yyyy.mm.dd'),TO_DATE('2012.12.04', 'yyyy.mm.dd'),71,18);
INSERT INTO Plemeno
VALUES(112,'Kanadský eskymácký pes',52,15,12);
INSERT INTO Zeme_puvodu
VALUES(112,'American Samoa','Africa');
INSERT INTO Uzivatel
VALUES(112,'Wayne','Young','773787854','BiZvheTFBuhyTby@gmail.com');
INSERT INTO Zakaznik
VALUES(112,61218536);
INSERT INTO Pes
VALUES(113,'Maria','pes',45000,TO_DATE('1991.05.25', 'yyyy.mm.dd'),68,77,47,35);
INSERT INTO Oceneni
VALUES(113,'Pohár Mistra Maleniv',TO_DATE('2011.05.20', 'yyyy.mm.dd'),51);
INSERT INTO Test
VALUES(113,TO_DATE('1995.02.21', 'yyyy.mm.dd'),22,51);
INSERT INTO Ockovani
VALUES(113,TO_DATE('2009.03.04', 'yyyy.mm.dd'),TO_DATE('2013.08.30', 'yyyy.mm.dd'),73,34);
INSERT INTO Plemeno
VALUES(113,'Burgoský perdiquero',23,11,109);
INSERT INTO Zeme_puvodu
VALUES(113,'Croatia','America');
INSERT INTO Uzivatel
VALUES(113,'Leonardo','Arias','781559071','XaDEPHJaUpJGy@gmail.com');
INSERT INTO Zamestnanec
VALUES(113,TO_DATE('2006.07.01', 'yyyy.mm.dd'),'účetní',16000);
INSERT INTO Pes
VALUES(114,'Vickie','fena',50000,TO_DATE('1999.05.27', 'yyyy.mm.dd'),31,89,110,102);
INSERT INTO Oceneni
VALUES(114,'Virtual 4ALL',TO_DATE('2005.04.15', 'yyyy.mm.dd'),13);
INSERT INTO Test
VALUES(114,TO_DATE('1998.08.16', 'yyyy.mm.dd'),13,31);
INSERT INTO Ockovani
VALUES(114,TO_DATE('2011.03.27', 'yyyy.mm.dd'),TO_DATE('2013.03.18', 'yyyy.mm.dd'),63,10);
INSERT INTO Plemeno
VALUES(114,'Istrijský krátkosrstý honič',23,11,11);
INSERT INTO Zeme_puvodu
VALUES(114,'Barbados','Antarctica');
INSERT INTO Uzivatel
VALUES(114,'Hector','Roller','704109236','emLUBGbTOQc@gmail.com');
INSERT INTO Zakaznik
VALUES(114,46427966);
INSERT INTO Pes
VALUES(115,'Erik','fena',42000,TO_DATE('1998.02.19', 'yyyy.mm.dd'),98,46,15,55);
INSERT INTO Oceneni
VALUES(115,'Psí závody 2021',TO_DATE('2007.05.12', 'yyyy.mm.dd'),60);
INSERT INTO Test
VALUES(115,TO_DATE('1999.02.16', 'yyyy.mm.dd'),35,62);
INSERT INTO Ockovani
VALUES(115,TO_DATE('2011.10.16', 'yyyy.mm.dd'),TO_DATE('2019.02.17', 'yyyy.mm.dd'),47,36);
INSERT INTO Plemeno
VALUES(115,'Islandský pes',78,21,41);
INSERT INTO Zeme_puvodu
VALUES(115,'Puerto Rico','Asia');
INSERT INTO Uzivatel
VALUES(115,'James','Ruiz','730445421','CRNsdhRxLyH@gmail.com');
INSERT INTO Zamestnanec
VALUES(115,TO_DATE('2003.03.16', 'yyyy.mm.dd'),'vedoucí',21000);
INSERT INTO Pes
VALUES(116,'Velma','pes',18000,TO_DATE('2001.12.03', 'yyyy.mm.dd'),104,111,40,33);
INSERT INTO Oceneni
VALUES(116,'Czech DOG race',TO_DATE('2008.03.24', 'yyyy.mm.dd'),59);
INSERT INTO Test
VALUES(116,TO_DATE('2003.08.10', 'yyyy.mm.dd'),22,113);
INSERT INTO Ockovani
VALUES(116,TO_DATE('2005.05.05', 'yyyy.mm.dd'),TO_DATE('2010.01.28', 'yyyy.mm.dd'),103,8);
INSERT INTO Plemeno
VALUES(116,'Bosenský hrubosrstý honič',26,15,10);
INSERT INTO Zeme_puvodu
VALUES(116,'Cape Verde','Africa');
INSERT INTO Uzivatel
VALUES(116,'Albert','Wallace','738616317','AXnnQzLlvSBSTTrnwrw@gmail.com');
INSERT INTO Zakaznik
VALUES(116,91324983);
INSERT INTO Pes
VALUES(117,'Peter','fena',15000,TO_DATE('2008.02.04', 'yyyy.mm.dd'),80,52,22,NULL);
INSERT INTO Oceneni
VALUES(117,'Závody psích spřežení',TO_DATE('2003.06.23', 'yyyy.mm.dd'),82);
INSERT INTO Test
VALUES(117,TO_DATE('1996.07.10', 'yyyy.mm.dd'),26,10);
INSERT INTO Ockovani
VALUES(117,TO_DATE('1991.05.04', 'yyyy.mm.dd'),TO_DATE('1995.05.05', 'yyyy.mm.dd'),43,19);
INSERT INTO Plemeno
VALUES(117,'Německý ovčák',82,16,100);
INSERT INTO Zeme_puvodu
VALUES(117,'Tunisia','Asia');
INSERT INTO Uzivatel
VALUES(117,'Gary','Familia','751238855','grKPo@gmail.com');
INSERT INTO Zamestnanec
VALUES(117,TO_DATE('2008.02.23', 'yyyy.mm.dd'),'uklízeč',21000);
INSERT INTO Pes
VALUES(118,'Jackie','pes',69000,TO_DATE('2004.01.15', 'yyyy.mm.dd'),62,113,84,7);
INSERT INTO Oceneni
VALUES(118,'STEEPLECHASE',TO_DATE('1997.03.02', 'yyyy.mm.dd'),14);
INSERT INTO Test
VALUES(118,TO_DATE('1994.11.17', 'yyyy.mm.dd'),30,102);
INSERT INTO Ockovani
VALUES(118,TO_DATE('2001.04.30', 'yyyy.mm.dd'),TO_DATE('2002.03.02', 'yyyy.mm.dd'),103,116);
INSERT INTO Plemeno
VALUES(118,'Řecký honič',72,30,63);
INSERT INTO Zeme_puvodu
VALUES(118,'New Caledonia','Asia');
INSERT INTO Uzivatel
VALUES(118,'Nancy','Hamilton','718661081','MamDopxvbLCuKEfi@gmail.com');
INSERT INTO Zakaznik
VALUES(118,33963127);
INSERT INTO Pes
VALUES(119,'Colene','fena',13000,TO_DATE('1990.08.03', 'yyyy.mm.dd'),73,8,91,27);
INSERT INTO Oceneni
VALUES(119,'Czech DOG race',TO_DATE('2006.06.23', 'yyyy.mm.dd'),59);
INSERT INTO Test
VALUES(119,TO_DATE('2004.04.01', 'yyyy.mm.dd'),40,35);
INSERT INTO Ockovani
VALUES(119,TO_DATE('2005.06.04', 'yyyy.mm.dd'),TO_DATE('2010.03.09', 'yyyy.mm.dd'),113,13);
INSERT INTO Plemeno
VALUES(119,'Tyrolský honič',61,11,5);
INSERT INTO Zeme_puvodu
VALUES(119,'Barbados','Africa');
INSERT INTO Uzivatel
VALUES(119,'Bruce','Bedell','733591848','uQwhAtCfiasTAHblF@gmail.com');
INSERT INTO Zamestnanec
VALUES(119,TO_DATE('2010.10.11', 'yyyy.mm.dd'),'účetní',18000);
INSERT INTO Pes
VALUES(120,'Sara','fena',57000,TO_DATE('1996.09.24', 'yyyy.mm.dd'),24,12,67,54);
INSERT INTO Oceneni
VALUES(120,'STEEPLECHASE',TO_DATE('2004.03.02', 'yyyy.mm.dd'),32);
INSERT INTO Test
VALUES(120,TO_DATE('1996.06.21', 'yyyy.mm.dd'),20,108);
INSERT INTO Ockovani
VALUES(120,TO_DATE('1994.05.30', 'yyyy.mm.dd'),TO_DATE('2001.10.31', 'yyyy.mm.dd'),79,73);
INSERT INTO Plemeno
VALUES(120,'Miniaturní bulteriér',67,24,118);
INSERT INTO Zeme_puvodu
VALUES(120,'Netherlands','America');
INSERT INTO Uzivatel
VALUES(120,'Carolina','Rosario','763120430','SjPdbkggEiW@gmail.com');
INSERT INTO Zakaznik
VALUES(120,55468128);
INSERT INTO Pes
VALUES(121,'Chase','pes',12000,TO_DATE('1992.07.12', 'yyyy.mm.dd'),71,110,45,13);
INSERT INTO Oceneni
VALUES(121,'Hard Dog Race pravidla',TO_DATE('2011.01.29', 'yyyy.mm.dd'),36);
INSERT INTO Test
VALUES(121,TO_DATE('2009.05.17', 'yyyy.mm.dd'),31,114);
INSERT INTO Ockovani
VALUES(121,TO_DATE('1994.10.24', 'yyyy.mm.dd'),TO_DATE('2000.08.01', 'yyyy.mm.dd'),86,95);
INSERT INTO Plemeno
VALUES(121,'Australský ovčák',21,33,40);
INSERT INTO Zeme_puvodu
VALUES(121,'Saint Kitts And Nevis','Antarctica');
INSERT INTO Uzivatel
VALUES(121,'Patricia','Haney','702759087','CbcKMFRBeYeJriiulX@gmail.com');
INSERT INTO Zamestnanec
VALUES(121,TO_DATE('1997.03.07', 'yyyy.mm.dd'),'uklízeč',25000);
INSERT INTO Pes
VALUES(122,'Susan','pes',12000,TO_DATE('2007.10.11', 'yyyy.mm.dd'),104,13,57,114);
INSERT INTO Oceneni
VALUES(122,'Hard Dog Race pravidla',TO_DATE('1995.06.12', 'yyyy.mm.dd'),109);
INSERT INTO Test
VALUES(122,TO_DATE('2000.09.18', 'yyyy.mm.dd'),13,106);
INSERT INTO Ockovani
VALUES(122,TO_DATE('2000.07.20', 'yyyy.mm.dd'),TO_DATE('2007.09.15', 'yyyy.mm.dd'),118,106);
INSERT INTO Plemeno
VALUES(122,'Bretaňský ohař',66,37,10);
INSERT INTO Zeme_puvodu
VALUES(122,'Philippines','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(122,'Jamie','Montijo','780359139','gPNIZPGfpwX@gmail.com');
INSERT INTO Zakaznik
VALUES(122,75276237);
INSERT INTO Pes
VALUES(123,'Shannon','fena',31000,TO_DATE('2006.05.12', 'yyyy.mm.dd'),104,73,43,61);
INSERT INTO Oceneni
VALUES(123,'Hard Dog Race pravidla',TO_DATE('2006.10.30', 'yyyy.mm.dd'),69);
INSERT INTO Test
VALUES(123,TO_DATE('2008.05.18', 'yyyy.mm.dd'),27,99);
INSERT INTO Ockovani
VALUES(123,TO_DATE('2008.02.24', 'yyyy.mm.dd'),TO_DATE('2011.03.06', 'yyyy.mm.dd'),95,75);
INSERT INTO Plemeno
VALUES(123,'Artoisský basset',81,12,3);
INSERT INTO Zeme_puvodu
VALUES(123,'Korea (North)','Antarctica');
INSERT INTO Uzivatel
VALUES(123,'Jack','Mcarthur','735637219','oXAXJboXcdiPAbACct@gmail.com');
INSERT INTO Zamestnanec
VALUES(123,TO_DATE('2011.08.11', 'yyyy.mm.dd'),'ošetřovatel',29000);
INSERT INTO Pes
VALUES(124,'Gerald','pes',42000,TO_DATE('1999.06.30', 'yyyy.mm.dd'),69,74,23,49);
INSERT INTO Oceneni
VALUES(124,'Extreme Dog Race',TO_DATE('2009.10.30', 'yyyy.mm.dd'),102);
INSERT INTO Test
VALUES(124,TO_DATE('2000.05.13', 'yyyy.mm.dd'),12,77);
INSERT INTO Ockovani
VALUES(124,TO_DATE('2011.04.27', 'yyyy.mm.dd'),TO_DATE('2017.03.26', 'yyyy.mm.dd'),74,112);
INSERT INTO Plemeno
VALUES(124,'Bobtail',22,26,63);
INSERT INTO Zeme_puvodu
VALUES(124,'Cyprus','America');
INSERT INTO Uzivatel
VALUES(124,'Everett','Thixton','749738713','GSNWvblVJuOTh@gmail.com');
INSERT INTO Zakaznik
VALUES(124,17949539);
INSERT INTO Pes
VALUES(125,'Vernon','fena',29000,TO_DATE('1999.07.07', 'yyyy.mm.dd'),21,2,46,24);
INSERT INTO Oceneni
VALUES(125,'Pohár Mistra Maleniv',TO_DATE('2004.12.14', 'yyyy.mm.dd'),39);
INSERT INTO Test
VALUES(125,TO_DATE('2004.06.11', 'yyyy.mm.dd'),18,40);
INSERT INTO Ockovani
VALUES(125,TO_DATE('2009.08.15', 'yyyy.mm.dd'),TO_DATE('2011.06.01', 'yyyy.mm.dd'),87,117);
INSERT INTO Plemeno
VALUES(125,'Pyrenejský horský pes',60,17,16);
INSERT INTO Zeme_puvodu
VALUES(125,'Reunion','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(125,'Sonia','Prentice','709212220','PDcUOZYoKgfo@gmail.com');
INSERT INTO Zamestnanec
VALUES(125,TO_DATE('1997.07.10', 'yyyy.mm.dd'),'vedoucí',27000);
INSERT INTO Pes
VALUES(126,'Antonio','pes',24000,TO_DATE('1990.02.27', 'yyyy.mm.dd'),113,62,31,38);
INSERT INTO Oceneni
VALUES(126,'Czech DOG race',TO_DATE('1996.07.25', 'yyyy.mm.dd'),54);
INSERT INTO Test
VALUES(126,TO_DATE('1999.01.03', 'yyyy.mm.dd'),27,81);
INSERT INTO Ockovani
VALUES(126,TO_DATE('2004.01.08', 'yyyy.mm.dd'),TO_DATE('2012.02.27', 'yyyy.mm.dd'),35,119);
INSERT INTO Plemeno
VALUES(126,'Entlebušský salašnický pes',32,18,74);
INSERT INTO Zeme_puvodu
VALUES(126,'Belarus','Antarctica');
INSERT INTO Uzivatel
VALUES(126,'Clara','Reyna','790380422','kVURqgjcXHRfH@gmail.com');
INSERT INTO Zakaznik
VALUES(126,21816386);
INSERT INTO Pes
VALUES(127,'Shawn','pes',9000,TO_DATE('1993.09.07', 'yyyy.mm.dd'),14,6,115,101);
INSERT INTO Oceneni
VALUES(127,'Závody psích spřežení',TO_DATE('2001.06.04', 'yyyy.mm.dd'),56);
INSERT INTO Test
VALUES(127,TO_DATE('1997.10.21', 'yyyy.mm.dd'),23,2);
INSERT INTO Ockovani
VALUES(127,TO_DATE('2004.06.08', 'yyyy.mm.dd'),TO_DATE('2006.02.24', 'yyyy.mm.dd'),56,99);
INSERT INTO Plemeno
VALUES(127,'Bergamský ovčák',47,20,5);
INSERT INTO Zeme_puvodu
VALUES(127,'Albania','Antarctica');
INSERT INTO Uzivatel
VALUES(127,'Nancy','Brewer','726488310','ChrFzAE@gmail.com');
INSERT INTO Zamestnanec
VALUES(127,TO_DATE('1991.11.17', 'yyyy.mm.dd'),'vedoucí',27000);
INSERT INTO Pes
VALUES(128,'Shawn','fena',65000,TO_DATE('1999.03.31', 'yyyy.mm.dd'),9,27,40,1);
INSERT INTO Oceneni
VALUES(128,'Závody psích spřežení',TO_DATE('1996.03.09', 'yyyy.mm.dd'),34);
INSERT INTO Test
VALUES(128,TO_DATE('1999.05.29', 'yyyy.mm.dd'),31,12);
INSERT INTO Ockovani
VALUES(128,TO_DATE('2004.11.13', 'yyyy.mm.dd'),TO_DATE('2012.08.14', 'yyyy.mm.dd'),105,15);
INSERT INTO Plemeno
VALUES(128,'Novofundlandský pes',59,8,10);
INSERT INTO Zeme_puvodu
VALUES(128,'New Caledonia','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(128,'Kathleen','Cantu','770219639','JSErGpuYof@gmail.com');
INSERT INTO Zakaznik
VALUES(128,18591327);
INSERT INTO Pes
VALUES(129,'Julia','fena',40000,TO_DATE('2011.01.05', 'yyyy.mm.dd'),62,123,60,40);
INSERT INTO Oceneni
VALUES(129,'Závody psích spřežení',TO_DATE('1991.08.16', 'yyyy.mm.dd'),58);
INSERT INTO Test
VALUES(129,TO_DATE('2006.05.27', 'yyyy.mm.dd'),40,23);
INSERT INTO Ockovani
VALUES(129,TO_DATE('1990.01.13', 'yyyy.mm.dd'),TO_DATE('1997.07.25', 'yyyy.mm.dd'),71,23);
INSERT INTO Plemeno
VALUES(129,'Appenzellský salašnický pes',45,36,46);
INSERT INTO Zeme_puvodu
VALUES(129,'Morocco','Africa');
INSERT INTO Uzivatel
VALUES(129,'Christine','Phillips','705473967','nHlvlLwYXcax@gmail.com');
INSERT INTO Zamestnanec
VALUES(129,TO_DATE('1993.10.10', 'yyyy.mm.dd'),'ošetřovatel',28000);
INSERT INTO Pes
VALUES(130,'Edward','fena',23000,TO_DATE('2005.12.31', 'yyyy.mm.dd'),104,65,77,32);
INSERT INTO Oceneni
VALUES(130,'Czech DOG race',TO_DATE('2011.05.15', 'yyyy.mm.dd'),66);
INSERT INTO Test
VALUES(130,TO_DATE('1997.11.08', 'yyyy.mm.dd'),16,118);
INSERT INTO Ockovani
VALUES(130,TO_DATE('1991.05.28', 'yyyy.mm.dd'),TO_DATE('1995.02.21', 'yyyy.mm.dd'),86,65);
INSERT INTO Plemeno
VALUES(130,'Welsh Corgi Pembroke',87,24,32);
INSERT INTO Zeme_puvodu
VALUES(130,'Niue','Europe');
INSERT INTO Uzivatel
VALUES(130,'Shelia','Davis','741484612','mCWlaFgMhm@gmail.com');
INSERT INTO Zakaznik
VALUES(130,65393811);
INSERT INTO Pes
VALUES(131,'Stephen','fena',24000,TO_DATE('2006.09.07', 'yyyy.mm.dd'),23,108,120,43);
INSERT INTO Oceneni
VALUES(131,'Závody psích spřežení',TO_DATE('2006.04.23', 'yyyy.mm.dd'),122);
INSERT INTO Test
VALUES(131,TO_DATE('2005.12.14', 'yyyy.mm.dd'),39,49);
INSERT INTO Ockovani
VALUES(131,TO_DATE('2003.02.08', 'yyyy.mm.dd'),TO_DATE('2004.04.13', 'yyyy.mm.dd'),67,75);
INSERT INTO Plemeno
VALUES(131,'Německý ohař dlouhosrstý',76,27,12);
INSERT INTO Zeme_puvodu
VALUES(131,'Paraguay','Asia');
INSERT INTO Uzivatel
VALUES(131,'Stacy','Little','770217040','HDCOfxDCETkVh@gmail.com');
INSERT INTO Zamestnanec
VALUES(131,TO_DATE('1994.02.28', 'yyyy.mm.dd'),'uklízeč',21000);
INSERT INTO Pes
VALUES(132,'Juan','pes',48000,TO_DATE('1996.05.22', 'yyyy.mm.dd'),71,83,90,34);
INSERT INTO Oceneni
VALUES(132,'Psí závody 2021',TO_DATE('1994.03.30', 'yyyy.mm.dd'),61);
INSERT INTO Test
VALUES(132,TO_DATE('2007.06.13', 'yyyy.mm.dd'),35,32);
INSERT INTO Ockovani
VALUES(132,TO_DATE('2006.05.06', 'yyyy.mm.dd'),TO_DATE('2010.05.19', 'yyyy.mm.dd'),39,55);
INSERT INTO Plemeno
VALUES(132,'Boloňský psík',80,25,48);
INSERT INTO Zeme_puvodu
VALUES(132,'Sweden','America');
INSERT INTO Uzivatel
VALUES(132,'Barbara','Carlone','706165274','NDDiMSebAzsHY@gmail.com');
INSERT INTO Zakaznik
VALUES(132,95716239);
INSERT INTO Pes
VALUES(133,'Lynn','fena',48000,TO_DATE('1990.10.30', 'yyyy.mm.dd'),74,71,131,75);
INSERT INTO Oceneni
VALUES(133,'Psí závody 2021',TO_DATE('2001.02.14', 'yyyy.mm.dd'),8);
INSERT INTO Test
VALUES(133,TO_DATE('2002.08.19', 'yyyy.mm.dd'),34,57);
INSERT INTO Ockovani
VALUES(133,TO_DATE('2009.06.24', 'yyyy.mm.dd'),TO_DATE('2016.05.23', 'yyyy.mm.dd'),122,42);
INSERT INTO Plemeno
VALUES(133,'Azavak',28,36,34);
INSERT INTO Zeme_puvodu
VALUES(133,'Trinidad And Tobago','Asia');
INSERT INTO Uzivatel
VALUES(133,'Thomas','Bentley','726410500','xKxVPJPeDKB@gmail.com');
INSERT INTO Zamestnanec
VALUES(133,TO_DATE('1997.04.01', 'yyyy.mm.dd'),'ošetřovatel',23000);
INSERT INTO Pes
VALUES(134,'Norma','fena',67000,TO_DATE('2009.05.10', 'yyyy.mm.dd'),89,32,60,108);
INSERT INTO Oceneni
VALUES(134,'Virtual 4ALL',TO_DATE('2003.03.10', 'yyyy.mm.dd'),132);
INSERT INTO Test
VALUES(134,TO_DATE('2001.01.17', 'yyyy.mm.dd'),13,38);
INSERT INTO Ockovani
VALUES(134,TO_DATE('2007.01.29', 'yyyy.mm.dd'),TO_DATE('2009.08.15', 'yyyy.mm.dd'),1,64);
INSERT INTO Plemeno
VALUES(134,'Leonberger',45,18,83);
INSERT INTO Zeme_puvodu
VALUES(134,'Guam','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(134,'James','Pittman','725022764','WVNagozM@gmail.com');
INSERT INTO Zakaznik
VALUES(134,76836681);
INSERT INTO Pes
VALUES(135,'Billy','pes',34000,TO_DATE('2000.07.01', 'yyyy.mm.dd'),94,20,118,55);
INSERT INTO Oceneni
VALUES(135,'Extreme Dog Race',TO_DATE('2010.01.11', 'yyyy.mm.dd'),84);
INSERT INTO Test
VALUES(135,TO_DATE('1996.02.25', 'yyyy.mm.dd'),10,99);
INSERT INTO Ockovani
VALUES(135,TO_DATE('2001.06.25', 'yyyy.mm.dd'),TO_DATE('2007.01.12', 'yyyy.mm.dd'),132,108);
INSERT INTO Plemeno
VALUES(135,'Španělský galgo',61,33,33);
INSERT INTO Zeme_puvodu
VALUES(135,'Cape Verde','Europe');
INSERT INTO Uzivatel
VALUES(135,'William','Wright','767837024','mTjyeHSkFxMfWf@gmail.com');
INSERT INTO Zamestnanec
VALUES(135,TO_DATE('2002.07.06', 'yyyy.mm.dd'),'ošetřovatel',14000);
INSERT INTO Pes
VALUES(136,'Yolanda','fena',14000,TO_DATE('1992.04.01', 'yyyy.mm.dd'),5,116,88,19);
INSERT INTO Oceneni
VALUES(136,'Závody psích spřežení',TO_DATE('1998.01.23', 'yyyy.mm.dd'),26);
INSERT INTO Test
VALUES(136,TO_DATE('1998.12.03', 'yyyy.mm.dd'),25,52);
INSERT INTO Ockovani
VALUES(136,TO_DATE('1995.01.07', 'yyyy.mm.dd'),TO_DATE('1999.09.27', 'yyyy.mm.dd'),105,39);
INSERT INTO Plemeno
VALUES(136,'Italský segugio',22,38,7);
INSERT INTO Zeme_puvodu
VALUES(136,'Tonga','Africa');
INSERT INTO Uzivatel
VALUES(136,'William','Braun','701287726','nuJNZuqZxwVWcUuj@gmail.com');
INSERT INTO Zakaznik
VALUES(136,66557841);
INSERT INTO Pes
VALUES(137,'Jonathan','fena',15000,TO_DATE('1990.05.19', 'yyyy.mm.dd'),98,38,70,65);
INSERT INTO Oceneni
VALUES(137,'Czech DOG race',TO_DATE('1991.05.29', 'yyyy.mm.dd'),126);
INSERT INTO Test
VALUES(137,TO_DATE('1997.10.20', 'yyyy.mm.dd'),14,130);
INSERT INTO Ockovani
VALUES(137,TO_DATE('1992.12.22', 'yyyy.mm.dd'),TO_DATE('2001.01.11', 'yyyy.mm.dd'),8,117);
INSERT INTO Plemeno
VALUES(137,'Artésko-normandský baset',81,35,17);
INSERT INTO Zeme_puvodu
VALUES(137,'Malaysia','Asia');
INSERT INTO Uzivatel
VALUES(137,'Lesa','Chick','755353708','BzZIHsVr@gmail.com');
INSERT INTO Zamestnanec
VALUES(137,TO_DATE('2006.06.22', 'yyyy.mm.dd'),'vedoucí',29000);
INSERT INTO Pes
VALUES(138,'Jonathan','pes',45000,TO_DATE('1997.11.30', 'yyyy.mm.dd'),123,131,116,33);
INSERT INTO Oceneni
VALUES(138,'STEEPLECHASE',TO_DATE('2009.11.24', 'yyyy.mm.dd'),8);
INSERT INTO Test
VALUES(138,TO_DATE('2008.09.16', 'yyyy.mm.dd'),16,35);
INSERT INTO Ockovani
VALUES(138,TO_DATE('1993.01.26', 'yyyy.mm.dd'),TO_DATE('1998.06.09', 'yyyy.mm.dd'),35,127);
INSERT INTO Plemeno
VALUES(138,'Japonský teriér',79,35,46);
INSERT INTO Zeme_puvodu
VALUES(138,'India','Europe');
INSERT INTO Uzivatel
VALUES(138,'Marian','Burke','770815273','pYEZsAxnctLnwrrAUcI@gmail.com');
INSERT INTO Zakaznik
VALUES(138,53471669);
INSERT INTO Pes
VALUES(139,'Christopher','pes',18000,TO_DATE('2001.07.17', 'yyyy.mm.dd'),18,75,83,62);
INSERT INTO Oceneni
VALUES(139,'Extreme Dog Race',TO_DATE('2005.08.26', 'yyyy.mm.dd'),7);
INSERT INTO Test
VALUES(139,TO_DATE('1994.02.11', 'yyyy.mm.dd'),14,56);
INSERT INTO Ockovani
VALUES(139,TO_DATE('2000.04.11', 'yyyy.mm.dd'),TO_DATE('2002.05.19', 'yyyy.mm.dd'),59,7);
INSERT INTO Plemeno
VALUES(139,'Německý křepelák',84,40,56);
INSERT INTO Zeme_puvodu
VALUES(139,'Cameroon','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(139,'Roger','Johnson','751385247','eCtrMMZ@gmail.com');
INSERT INTO Zamestnanec
VALUES(139,TO_DATE('2010.07.24', 'yyyy.mm.dd'),'vedoucí',21000);
INSERT INTO Pes
VALUES(140,'Clinton','fena',33000,TO_DATE('1990.03.12', 'yyyy.mm.dd'),53,8,82,91);
INSERT INTO Oceneni
VALUES(140,'Závody psích spřežení',TO_DATE('2008.04.18', 'yyyy.mm.dd'),39);
INSERT INTO Test
VALUES(140,TO_DATE('1993.01.11', 'yyyy.mm.dd'),25,105);
INSERT INTO Ockovani
VALUES(140,TO_DATE('2004.10.23', 'yyyy.mm.dd'),TO_DATE('2008.04.17', 'yyyy.mm.dd'),73,130);
INSERT INTO Plemeno
VALUES(140,'Chortaja borzaja',56,33,38);
INSERT INTO Zeme_puvodu
VALUES(140,'Syrian Arab Republic','Antarctica');
INSERT INTO Uzivatel
VALUES(140,'Denise','Brown','758876337','cOvSoXJIEeteJtEsYY@gmail.com');
INSERT INTO Zakaznik
VALUES(140,77346954);
INSERT INTO Pes
VALUES(141,'Margaret','fena',6000,TO_DATE('1992.06.29', 'yyyy.mm.dd'),71,43,49,95);
INSERT INTO Oceneni
VALUES(141,'Pohár Mistra Maleniv',TO_DATE('2006.09.02', 'yyyy.mm.dd'),119);
INSERT INTO Test
VALUES(141,TO_DATE('1996.05.05', 'yyyy.mm.dd'),32,54);
INSERT INTO Ockovani
VALUES(141,TO_DATE('2005.07.29', 'yyyy.mm.dd'),TO_DATE('2012.08.14', 'yyyy.mm.dd'),12,134);
INSERT INTO Plemeno
VALUES(141,'Ariégois',20,17,25);
INSERT INTO Zeme_puvodu
VALUES(141,'Tokelau','Asia');
INSERT INTO Uzivatel
VALUES(141,'Stephanie','Gonzales','760897369','tmQYAPNnhvCIBHAfIxh@gmail.com');
INSERT INTO Zamestnanec
VALUES(141,TO_DATE('2002.02.22', 'yyyy.mm.dd'),'uklízeč',17000);
INSERT INTO Pes
VALUES(142,'Francis','fena',18000,TO_DATE('1992.01.25', 'yyyy.mm.dd'),20,4,93,28);
INSERT INTO Oceneni
VALUES(142,'Hard Dog Race pravidla',TO_DATE('1990.07.18', 'yyyy.mm.dd'),22);
INSERT INTO Test
VALUES(142,TO_DATE('2009.01.23', 'yyyy.mm.dd'),31,68);
INSERT INTO Ockovani
VALUES(142,TO_DATE('2001.02.09', 'yyyy.mm.dd'),TO_DATE('2002.07.21', 'yyyy.mm.dd'),14,90);
INSERT INTO Plemeno
VALUES(142,'Malý hrubosrstý vendéeský baset',79,23,110);
INSERT INTO Zeme_puvodu
VALUES(142,'Korea (North)','America');
INSERT INTO Uzivatel
VALUES(142,'Carolyn','Davenport','726586764','qNdxnp@gmail.com');
INSERT INTO Zakaznik
VALUES(142,36946221);
INSERT INTO Pes
VALUES(143,'Harold','fena',58000,TO_DATE('2002.04.18', 'yyyy.mm.dd'),123,114,25,133);
INSERT INTO Oceneni
VALUES(143,'Psí závody 2021',TO_DATE('1998.04.22', 'yyyy.mm.dd'),82);
INSERT INTO Test
VALUES(143,TO_DATE('2008.04.11', 'yyyy.mm.dd'),24,53);
INSERT INTO Ockovani
VALUES(143,TO_DATE('2004.12.30', 'yyyy.mm.dd'),TO_DATE('2006.03.02', 'yyyy.mm.dd'),17,55);
INSERT INTO Plemeno
VALUES(143,'Čau-čau',21,10,43);
INSERT INTO Zeme_puvodu
VALUES(143,'Chad','Europe');
INSERT INTO Uzivatel
VALUES(143,'Joseph','Manchini','722417595','pdTYvTsuogoFfYQ@gmail.com');
INSERT INTO Zamestnanec
VALUES(143,TO_DATE('2000.04.08', 'yyyy.mm.dd'),'účetní',23000);
INSERT INTO Pes
VALUES(144,'Judith','pes',49000,TO_DATE('2003.10.22', 'yyyy.mm.dd'),84,4,37,133);
INSERT INTO Oceneni
VALUES(144,'Extreme Dog Race',TO_DATE('1997.08.21', 'yyyy.mm.dd'),113);
INSERT INTO Test
VALUES(144,TO_DATE('2000.08.15', 'yyyy.mm.dd'),19,7);
INSERT INTO Ockovani
VALUES(144,TO_DATE('2009.08.19', 'yyyy.mm.dd'),TO_DATE('2016.01.19', 'yyyy.mm.dd'),40,134);
INSERT INTO Plemeno
VALUES(144,'Moskevský strážní pes',65,27,140);
INSERT INTO Zeme_puvodu
VALUES(144,'Mongolia','Antarctica');
INSERT INTO Uzivatel
VALUES(144,'Martha','Engles','795166054','ZvPGdL@gmail.com');
INSERT INTO Zakaznik
VALUES(144,55635128);
INSERT INTO Pes
VALUES(145,'Christopher','pes',41000,TO_DATE('1991.05.02', 'yyyy.mm.dd'),108,2,121,48);
INSERT INTO Oceneni
VALUES(145,'Mushing závody',TO_DATE('2006.03.13', 'yyyy.mm.dd'),118);
INSERT INTO Test
VALUES(145,TO_DATE('2006.04.11', 'yyyy.mm.dd'),19,131);
INSERT INTO Ockovani
VALUES(145,TO_DATE('2009.10.18', 'yyyy.mm.dd'),TO_DATE('2017.12.16', 'yyyy.mm.dd'),67,129);
INSERT INTO Plemeno
VALUES(145,'Laponský špic',57,13,137);
INSERT INTO Zeme_puvodu
VALUES(145,'Algeria','Australia/Oceania');
INSERT INTO Uzivatel
VALUES(145,'Chasity','Kost','702559638','dPQmJF@gmail.com');
INSERT INTO Zamestnanec
VALUES(145,TO_DATE('1996.06.08', 'yyyy.mm.dd'),'vedoucí',19000);
INSERT INTO Pes
VALUES(146,'Juliana','pes',13000,TO_DATE('1992.03.17', 'yyyy.mm.dd'),99,46,94,117);
INSERT INTO Oceneni
VALUES(146,'Czech DOG race',TO_DATE('2005.04.22', 'yyyy.mm.dd'),90);
INSERT INTO Test
VALUES(146,TO_DATE('1992.09.18', 'yyyy.mm.dd'),12,62);
INSERT INTO Ockovani
VALUES(146,TO_DATE('1993.03.10', 'yyyy.mm.dd'),TO_DATE('1996.03.19', 'yyyy.mm.dd'),2,48);
INSERT INTO Plemeno
VALUES(146,'Francouzský buldoček',66,8,19);
INSERT INTO Zeme_puvodu
VALUES(146,'Belgium','Africa');
INSERT INTO Uzivatel
VALUES(146,'Blanca','Bruce','718210322','uWbQwhIWKpD@gmail.com');
INSERT INTO Zakaznik
VALUES(146,28512855);
INSERT INTO Pes
VALUES(147,'Donna','pes',47000,TO_DATE('1997.09.12', 'yyyy.mm.dd'),73,95,111,15);
INSERT INTO Oceneni
VALUES(147,'Závody psích spřežení',TO_DATE('1994.04.18', 'yyyy.mm.dd'),47);
INSERT INTO Test
VALUES(147,TO_DATE('2010.04.16', 'yyyy.mm.dd'),31,73);
INSERT INTO Ockovani
VALUES(147,TO_DATE('2008.09.16', 'yyyy.mm.dd'),TO_DATE('2016.03.12', 'yyyy.mm.dd'),90,23);
INSERT INTO Plemeno
VALUES(147,'Finský špic',46,23,36);
INSERT INTO Zeme_puvodu
VALUES(147,'Poland','Antarctica');
INSERT INTO Uzivatel
VALUES(147,'Rose','Thompson','727117842','juYLmjGkyePLdxfqM@gmail.com');
INSERT INTO Zamestnanec
VALUES(147,TO_DATE('1993.08.20', 'yyyy.mm.dd'),'účetní',18000);

DROP TABLE  buf_adres;
DROP TABLE  buf_dane_techniczne_auta;
DROP TABLE  buf_model_auta;
DROP TABLE  buf_auto;
DROP TABLE  buf_klient;
DROP TABLE  buf_stanowisko;
DROP TABLE  buf_pracownik;
DROP TABLE  buf_dane_firmy;
DROP TABLE  buf_rodzaj_wypozyczenia;
DROP TABLE  buf_oddzial_firmy;
DROP TABLE  buf_wypozyczenia;
DROP TABLE  buf_zwroty;
DROP TABLE  buf_ubezpieczenia;
DROP TABLE  buf_ubezpieczyciel;


CREATE TABLE buf_adres (
    id_adres           NUMBER(7) PRIMARY KEY NOT NULL,
    panstwo            VARCHAR2(50) NOT NULL,
    kod_pocztowy       VARCHAR2(6) NOT NULL,
    poczta             VARCHAR2(35) NOT NULL,
    miejscowosc        VARCHAR2(35) NOT NULL,
    adres_zamieszkania VARCHAR2(45) NOT NULL
);


CREATE TABLE buf_dane_firmy (
	id_dane_firmy		NUMBER(7) PRIMARY KEY  NOT NULL,
	nazwa_firmy 		VARCHAR2(100) NOT NULL,	
	numer_nip			VARCHAR2(10) NOT NULL,	
	kraj				VARCHAR2(50) NOT NULL,	
	miejscowosc			VARCHAR2(50) NOT NULL,	
	adres 				VARCHAR2(50) NOT NULL	
);


CREATE TABLE buf_dane_techniczne_auta (
    id_dane_techniczne_auta  	NUMBER(7)	  PRIMARY KEY NOT NULL,
	silnik			 			VARCHAR2(25) NOT NULL,	
	moc_silnika      			NUMBER 	  NOT NULL,
	pojemosc_silnika 			NUMBER		  NOT NULL,
    rodzaj_paliwa    			VARCHAR2(14) NOT NULL
);

CREATE TABLE buf_model_auta(
	id_model						NUMBER(7) 	 PRIMARY KEY NOT NULL,
	model							VARCHAR2(20) NOT NULL,
	rodzaj_nadwozia 				VARCHAR2(25) NOT NULL,
	data_produkcji  				DATE 		 NOT NULL,
	id_dane_techniczne_auta	 		NUMBER(7)	 NOT NULL
);



CREATE TABLE buf_auto (
    id_auta          NUMBER(7) 		PRIMARY KEY NOT NULL,
    przebieg         NUMBER	   		NOT NULL,
	marka            VARCHAR2(15) 	NOT NULL,
    id_model 	     NUMBER(7) 		NOT NULL,
	nr_vin           VARCHAR2(17) 	NOT NULL UNIQUE,
    nr_rejestracyjny VARCHAR2(9) 	NOT NULL UNIQUE,
	data_rejestracji_auta 	DATE  NOT NULL,
	cena        	 NUMBER(19, 4)  NOT NULL,
    uwagi            VARCHAR2(255)  NOT NULL
);


CREATE TABLE buf_rodzaj_wypozyczenia(
	id_rodzaj_wypozyczenia	 NUMBER(7) PRIMARY KEY NOT NULL,
	rodzaj_wypozyczenia      VARCHAR2(100) NOT NULL,
	id_dane_firmy			 NUMBER(7),
	uwagi					 VARCHAR2(250)
);


CREATE TABLE buf_wypozyczenia (
    id_wypozyczenia           NUMBER(7) PRIMARY KEY NOT NULL,
    id_pracownika             NUMBER(7) NOT NULL,
    id_auta                   NUMBER(7) NOT NULL,
    id_klienta                NUMBER(7) NOT NULL,
    id_rodzaj_wypozyczenia    NUMBER(7) NOT NULL,
    stan_licznika_przed       NUMBER NOT NULL,
    data_wypozyczenia         DATE NOT NULL,
    id_rezerwacji             NUMBER(7),
	id_oddzialu               NUMBER(7) NOT NULL,
    uwagi                     VARCHAR2(250)
);



CREATE TABLE buf_zwroty (
    id_zwrotu           NUMBER(7) PRIMARY KEY NOT NULL,
    id_wypozyczenia     NUMBER(7) NOT NULL,
    id_pracownika       NUMBER(7) NOT NULL,
    id_oddzialu       	NUMBER(7) NOT NULL,
    data_zwrotu         DATE,
    stan_licznika_po    NUMBER,
    uwagi               VARCHAR2(255)
);


CREATE TABLE buf_oddzial_firmy (
	id_oddzialu		NUMBER(7) PRIMARY KEY NOT NULL,
	miasto		    VARCHAR2(50) NOT NULL,	
	adres			VARCHAR2(50) NOT NULL	
);

CREATE TABLE buf_klient (
    id_klienta       		NUMBER(7) PRIMARY KEY NOT NULL,
    imie             		VARCHAR2(50) NOT NULL,
    nazwisko         		VARCHAR2(50) NOT NULL,
    wiek                    NUMBER(3)    NOT NULL, 
    pesel            		VARCHAR2(11) NOT NULL UNIQUE,
    telefon          		VARCHAR2(14) NOT NULL UNIQUE,
	id_karta_platnicza		NUMBER(7) NOT NULL,
	id_dokumentu         	NUMBER(7) NOT NULL,
	id_prawo_jazdy         	NUMBER(7) NOT NULL,
	id_adres         		NUMBER(7) NOT NULL
);

CREATE TABLE buf_stanowisko (
    id_stanowiska    NUMBER(7)PRIMARY KEY NOT NULL,
    nazwa_stanowiska VARCHAR2(50) NOT NULL,
    opis             VARCHAR2(255)
);

CREATE TABLE buf_pracownik (
    id_pracownika       NUMBER(7) PRIMARY KEY NOT NULL,
    imie     			VARCHAR2(50) NOT NULL,
    nazwisko 			VARCHAR2(50) NOT NULL,
    pesel               VARCHAR2(11) NOT NULL UNIQUE,
    data_zatrudnienia   DATE NOT NULL,
	id_stanowiska    	NUMBER(7) NOT NULL,
    id_adres            NUMBER(7) NOT NULL
);


CREATE TABLE buf_ubezpieczyciel (
    id_ubezpieczyciela NUMBER PRIMARY KEY NOT NULL,
    nazwa              VARCHAR2(50) NOT NULL,
    miejscowosc        VARCHAR2(50) NOT NULL,
    adres              VARCHAR2(50) NOT NULL
);

CREATE TABLE buf_ubezpieczenia (
    id_ubezpieczenia               NUMBER(7) PRIMARY KEY NOT NULL,
    id_auta                        NUMBER(7) NOT NULL,
    rodzaj_ubezpieczenia           VARCHAR2(10) NOT NULL,
    id_ubezpieczyciela             NUMBER(7) NOT NULL,
    data_rozpoczecia_ubezpieczenia DATE NOT NULL,
    data_zakonczenia_ubezpieczenia DATE,
    skladka                        NUMBER(19, 4),
    data_zawieszenia_ubezpieczenia DATE,
    uwagi                          VARCHAR2(255)
);


DROP SEQUENCE seq_licznik;
DROP SEQUENCE seq_przejazd;
DROP SEQUENCE seq_osoba;

--tabela adres--
INSERT /*+ APPEND */ INTO adres(
id_adres,
panstwo,
kod_pocztowy,
poczta,
miejscowosc,
adres_zamieszkania
)
SELECT 
id_adres,
panstwo,
kod_pocztowy,
poczta,
miejscowosc,
adres_zamieszkania 
FROM buf_adres;
COMMIT;

SELECT * FROM adres;

--tabela dane_firmy--

INSERT /*+ APPEND */ INTO dane_firmy(
id_dane_firmy,
nazwa_firmy,
numer_nip,
kraj,
miejscowosc,
adres
)
SELECT 
id_dane_firmy,
nazwa_firmy,
numer_nip,
kraj,
miejscowosc,
adres
FROM buf_dane_firmy;
COMMIT;

SELECT * FROM dane_firmy;

--tabela licznik--
CREATE SEQUENCE seq_licznik
MINVALUE 1
MAXVALUE 1000
START WITH 1
INCREMENT BY 1;

INSERT /*+ APPEND */ INTO licznik(
id_licznik,
stan_licznika_przed,
stan_licznika_po
)
SELECT 
seq_licznik.NEXTVAL,
buf_wypozyczenia.stan_licznika_przed,
buf_zwroty.stan_licznika_po
FROM buf_wypozyczenia, buf_zwroty
WHERE buf_wypozyczenia.id_wypozyczenia=buf_zwroty.id_wypozyczenia; 
COMMIT;

SELECT * FROM licznik;


--tabela dane_techniczne_auta--

INSERT /*+ APPEND */ INTO dane_techniczne_auta(
id_dane_techniczne_auta,
silnik,
moc_silnika,
pojemosc_silnika,
rodzaj_paliwa
)
SELECT 
id_dane_techniczne_auta,
silnik,
moc_silnika,
pojemosc_silnika,
rodzaj_paliwa
FROM buf_dane_techniczne_auta;
COMMIT;

SELECT * FROM dane_techniczne_auta;

--tabela model_auta --
INSERT /*+ APPEND */ INTO model_auta(
id_model,
model,
rodzaj_nadwozia,
data_produkcji,
id_dane_techniczne_auta
)
SELECT 
id_model,
model,
rodzaj_nadwozia,
data_produkcji,
id_dane_techniczne_auta
FROM buf_model_auta;
COMMIT;

SELECT * FROM model_auta;
--tabela auto--

INSERT /*+ APPEND */ INTO auto(
id_auta,
przebieg,
marka,
id_model,
nr_vin,
nr_rejestracyjny,
data_rejestracji_auta,
cena
)
SELECT 
id_auta,
przebieg,
marka,
id_model,
nr_vin,
nr_rejestracyjny,
data_rejestracji_auta,
cena
FROM buf_auto;
COMMIT;

SELECT * FROM auto;

--tabela rodzaj_wypozyczenia--

INSERT /*+ APPEND */ INTO rodzaj_wypozyczenia(
id_rodzaj_wypozyczenia,
rodzaj_wypozyczenia,
id_dane_firmy
)
SELECT 
id_rodzaj_wypozyczenia,
rodzaj_wypozyczenia,
id_dane_firmy
FROM buf_rodzaj_wypozyczenia;
COMMIT;

SELECT * FROM rodzaj_wypozyczenia;

--tabela przejazd--

CREATE SEQUENCE seq_przejazd
MINVALUE 1
MAXVALUE 1000
START WITH 1
INCREMENT BY 1;

INSERT /*+ APPEND */ INTO przejazd(
id_przejazdu,
miasto_wypozyczenia,
adres_wypozyczenia,
miasto_zwrotu,
adres_zwrotu
)
SELECT 
seq_przejazd.NEXTVAL,
x.miasto,
x.adres, 
y.miasto,
y.adres 
FROM buf_oddzial_firmy x, buf_oddzial_firmy y, buf_wypozyczenia, buf_zwroty
WHERE buf_wypozyczenia.id_oddzialu = x.id_oddzialu
AND buf_zwroty.id_oddzialu = y.id_oddzialu
AND buf_wypozyczenia.id_wypozyczenia = buf_zwroty.id_wypozyczenia;
COMMIT;
SELECT * FROM przejazd;

--tabela ubezpieczenia--
INSERT /*+ APPEND */ INTO ubezpieczenie(
    id_ubezpieczenia,
    nazwa_firmy_ubezpieczeniowej,
    miejscowosc_firmy_ubezpieczeniowej,
    adres_firmy_ubezpieczeniowej,
    data_rozpoczecia_ubezpieczenia,
    data_zakonczenia_ubezpieczenia
)
SELECT
buf_ubezpieczenia.id_ubezpieczenia,
buf_ubezpieczyciel.nazwa,
buf_ubezpieczyciel.miejscowosc,
buf_ubezpieczyciel.adres,
buf_ubezpieczenia.data_rozpoczecia_ubezpieczenia,
buf_ubezpieczenia.data_zakonczenia_ubezpieczenia
FROM buf_ubezpieczenia,buf_ubezpieczyciel,buf_auto
WHERE buf_ubezpieczenia.id_ubezpieczyciela=buf_ubezpieczyciel.id_ubezpieczyciela
AND buf_auto.id_auta=buf_ubezpieczenia.id_auta;
COMMIT;
SELECT * FROM ubezpieczenie;



--tabela wypozyczenia--

INSERT /*+ APPEND */ INTO wypozyczenia(
id_wypozyczenia,
id_auta,
id_rodzaj_wypozyczenia,
data_wypozyczenia,
id_przejazdu,
id_licznik,
id_ubezpieczenia
)
SELECT
buf_wypozyczenia.id_wypozyczenia,
buf_wypozyczenia.id_auta,
buf_wypozyczenia.id_rodzaj_wypozyczenia,
buf_wypozyczenia.data_wypozyczenia,
id_przejazdu,
licznik.id_licznik,
buf_ubezpieczenia.id_ubezpieczenia
FROM buf_wypozyczenia,licznik,buf_zwroty,przejazd,buf_oddzial_firmy x, buf_oddzial_firmy y,buf_ubezpieczenia,buf_ubezpieczyciel,buf_auto
WHERE buf_wypozyczenia.stan_licznika_przed = licznik.stan_licznika_przed
AND buf_zwroty.stan_licznika_po = licznik.stan_licznika_po
AND buf_wypozyczenia.id_oddzialu = x.id_oddzialu
AND buf_zwroty.id_oddzialu = y.id_oddzialu
AND buf_wypozyczenia.id_wypozyczenia = buf_zwroty.id_wypozyczenia
AND x.miasto = przejazd.miasto_wypozyczenia
AND x.adres = przejazd.adres_wypozyczenia
AND y.miasto = przejazd.miasto_zwrotu
AND y.adres = przejazd.adres_zwrotu
AND buf_ubezpieczenia.id_ubezpieczyciela=buf_ubezpieczyciel.id_ubezpieczyciela
AND buf_auto.id_auta=buf_ubezpieczenia.id_auta
AND buf_wypozyczenia.id_auta=buf_auto.id_auta;
COMMIT;
SELECT * FROM wypozyczenia;

--tabela osoby--

CREATE SEQUENCE seq_osoba
MINVALUE 1
MAXVALUE 3000
START WITH 1
INCREMENT BY 1;

INSERT /*+ APPEND */ INTO osoba(
id_osoba,
rodzaj_osoby,
id_adres,
id_wypozyczenia,
imie,
nazwisko,
pesel,
wiek, 
telefon
)
SELECT 
seq_osoba.NEXTVAL,
'Klient',
buf_adres.id_adres,
buf_wypozyczenia.id_wypozyczenia,
buf_klient.imie,
buf_klient.nazwisko,
buf_klient.pesel,
buf_klient.wiek,
buf_klient.telefon
FROM buf_adres,buf_wypozyczenia,buf_klient,buf_zwroty
WHERE buf_wypozyczenia.id_klienta = buf_klient.id_klienta
AND buf_wypozyczenia.id_wypozyczenia = buf_zwroty.id_wypozyczenia
AND buf_klient.id_adres=buf_adres.id_adres;
COMMIT;


INSERT /*+ APPEND */ INTO osoba(
id_osoba,
rodzaj_osoby,
id_adres,
id_wypozyczenia,
imie,
nazwisko,
pesel,
data_zatrudnienia,
nazwa_stanowiska
)
SELECT 
seq_osoba.NEXTVAL,
'Pracownik wypozyczajacy',
buf_adres.id_adres,
buf_wypozyczenia.id_wypozyczenia,
buf_pracownik.imie,
buf_pracownik.nazwisko,
buf_pracownik.pesel,
buf_pracownik.data_zatrudnienia,
buf_stanowisko.nazwa_stanowiska
FROM buf_adres,buf_wypozyczenia,buf_pracownik,buf_zwroty,buf_stanowisko
WHERE buf_wypozyczenia.id_pracownika = buf_pracownik.id_pracownika
AND buf_wypozyczenia.id_wypozyczenia = buf_zwroty.id_wypozyczenia
AND buf_pracownik.id_adres=buf_adres.id_adres
AND buf_stanowisko.id_stanowiska = buf_pracownik.id_stanowiska;
COMMIT;


INSERT /*+ APPEND */ INTO osoba(
id_osoba,
rodzaj_osoby,
id_adres,
id_wypozyczenia,
imie,
nazwisko,
pesel,
data_zatrudnienia,
nazwa_stanowiska
)
SELECT  
seq_osoba.NEXTVAL,
'Pracownik zwracajacy',
buf_adres.id_adres,
buf_wypozyczenia.id_wypozyczenia,
buf_pracownik.imie,
buf_pracownik.nazwisko,
buf_pracownik.pesel,
buf_pracownik.data_zatrudnienia,
buf_stanowisko.nazwa_stanowiska
FROM buf_adres,buf_wypozyczenia,buf_pracownik,buf_zwroty,buf_stanowisko
WHERE buf_zwroty.id_pracownika = buf_pracownik.id_pracownika
AND buf_wypozyczenia.id_wypozyczenia = buf_zwroty.id_wypozyczenia
AND buf_pracownik.id_adres=buf_adres.id_adres
AND buf_stanowisko.id_stanowiska = buf_pracownik.id_stanowiska;
COMMIT;

SELECT * FROM osoba;
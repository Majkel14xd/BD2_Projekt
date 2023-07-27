DROP TABLE  adres  CASCADE CONSTRAINTS;
DROP TABLE  dane_firmy CASCADE CONSTRAINTS;
DROP TABLE  licznik CASCADE CONSTRAINTS;
DROP TABLE  dane_techniczne_auta  CASCADE CONSTRAINTS;
DROP TABLE  model_auta  CASCADE CONSTRAINTS;
DROP TABLE  auto CASCADE CONSTRAINTS;
DROP TABLE  rodzaj_wypozyczenia  CASCADE CONSTRAINTS;
DROP TABLE  przejazd CASCADE CONSTRAINTS; 
DROP TABLE  ubezpieczenie CASCADE CONSTRAINTS;
DROP TABLE  wypozyczenia CASCADE CONSTRAINTS;
DROP TABLE  osoba CASCADE CONSTRAINTS;

CREATE TABLE adres (
    id_adres           NUMBER(7) PRIMARY KEY NOT NULL,
    panstwo            VARCHAR2(50) NOT NULL,
    kod_pocztowy       VARCHAR2(6) NOT NULL,
    poczta             VARCHAR2(35) NOT NULL,
    miejscowosc        VARCHAR2(35) NOT NULL,
    adres_zamieszkania VARCHAR2(45) NOT NULL
);

CREATE TABLE dane_firmy (
	id_dane_firmy		NUMBER(7) PRIMARY KEY  NOT NULL,
	nazwa_firmy 		VARCHAR2(100) NOT NULL,	
	numer_nip			VARCHAR2(10) NOT NULL,	
	kraj				VARCHAR2(50) NOT NULL,	
	miejscowosc			VARCHAR2(50) NOT NULL,	
	adres 				VARCHAR2(50) NOT NULL	
);


CREATE TABLE licznik (
    id_licznik                 NUMBER(7) PRIMARY KEY NOT NULL,
    stan_licznika_przed       NUMBER,
    stan_licznika_po          NUMBER
);


CREATE TABLE dane_techniczne_auta (
    id_dane_techniczne_auta  	NUMBER(7)	  PRIMARY KEY NOT NULL,
	silnik			 			VARCHAR2(25) NOT NULL,	
	moc_silnika      			NUMBER 	  NOT NULL,
	pojemosc_silnika 			NUMBER		  NOT NULL,
    rodzaj_paliwa    			VARCHAR2(14) NOT NULL
);

CREATE TABLE model_auta(
	id_model						NUMBER(7) 	 PRIMARY KEY NOT NULL,
	model							VARCHAR2(20) NOT NULL,
	rodzaj_nadwozia 				VARCHAR2(25) NOT NULL,
	data_produkcji  				DATE 		 NOT NULL,
	id_dane_techniczne_auta	 		NUMBER(7)	 NOT NULL,
	CONSTRAINTS id_dane_techniczne_auta_model_auta FOREIGN KEY(id_dane_techniczne_auta) REFERENCES dane_techniczne_auta(id_dane_techniczne_auta)
);

CREATE TABLE auto (
    id_auta          NUMBER(7) 	PRIMARY KEY NOT NULL,
    przebieg         NUMBER	   		NOT NULL,
	marka            VARCHAR2(15) 	NOT NULL,
    id_model 	     NUMBER(7) 		NOT NULL,
	nr_vin           VARCHAR2(17) 	NOT NULL UNIQUE,
    nr_rejestracyjny VARCHAR2(9) 	NOT NULL UNIQUE,
	data_rejestracji_auta 	DATE  NOT NULL,
	cena        	 NUMBER(19, 4)  NOT NULL,
	CONSTRAINTS id_model_fk_auto FOREIGN KEY(id_model) REFERENCES model_auta(id_model)
);

CREATE TABLE rodzaj_wypozyczenia(
	id_rodzaj_wypozyczenia	 NUMBER(7) PRIMARY KEY NOT NULL,
	rodzaj_wypozyczenia      VARCHAR2(100) NOT NULL,
	id_dane_firmy			 NUMBER(7),
	CONSTRAINTS id_dane_firmy_fk_rodzaj_wypozyczenia FOREIGN KEY(id_dane_firmy) REFERENCES dane_firmy(id_dane_firmy)
);

CREATE TABLE przejazd (
id_przejazdu            NUMBER(7) PRIMARY KEY NOT NULL,
miasto_wypozyczenia     VARCHAR2(50) NOT NULL,
adres_wypozyczenia      VARCHAR2(50) NOT NULL,
miasto_zwrotu           VARCHAR2(50) NOT NULL,
adres_zwrotu            VARCHAR2(50) NOT NULL
);

CREATE TABLE ubezpieczenie(
    id_ubezpieczenia                          NUMBER(7) PRIMARY KEY NOT NULL,
    nazwa_firmy_ubezpieczeniowej              VARCHAR2(50) NOT NULL,
    miejscowosc_firmy_ubezpieczeniowej        VARCHAR2(50) NOT NULL,
    adres_firmy_ubezpieczeniowej              VARCHAR2(50) NOT NULL,
    data_rozpoczecia_ubezpieczenia            DATE NOT NULL,
    data_zakonczenia_ubezpieczenia            DATE NOT NULL
);

CREATE TABLE wypozyczenia (
    id_wypozyczenia           NUMBER(7) PRIMARY KEY NOT NULL,
    id_auta                   NUMBER(7) NOT NULL,
    id_rodzaj_wypozyczenia    NUMBER(7) NOT NULL,
    data_wypozyczenia         DATE NOT NULL,
    id_przejazdu              NUMBER(7) NOT NULL,
    id_licznik                NUMBER(7) NOT NULL,
    id_ubezpieczenia               NUMBER(7) NOT NULL,
    CONSTRAINTS id_auta_fk_wypozyczenia FOREIGN KEY(id_auta) REFERENCES auto(id_auta),
    CONSTRAINTS id_wypozyczenia_fk_wypozyczenia FOREIGN KEY(id_rodzaj_wypozyczenia) REFERENCES rodzaj_wypozyczenia(id_rodzaj_wypozyczenia),
    CONSTRAINTS id_przejazdu_fk_wypozyczenia FOREIGN KEY(id_przejazdu) REFERENCES przejazd(id_przejazdu),
    CONSTRAINTS id_licznik_fk_wypozyczenia FOREIGN KEY(id_licznik) REFERENCES licznik(id_licznik),
    CONSTRAINTS id_ubezpieczenia_fk_wypozyczenia FOREIGN KEY(id_ubezpieczenia) REFERENCES ubezpieczenie(id_ubezpieczenia)
);


CREATE TABLE osoba(
id_osoba            NUMBER(7) PRIMARY KEY NOT NULL,
rodzaj_osoby        VARCHAR2(50) NOT NULL,
id_adres            NUMBER(7)  NOT NULL,
id_wypozyczenia     NUMBER(7)  NOT NULL,
imie             	VARCHAR2(50) NOT NULL,
nazwisko         	VARCHAR2(50) NOT NULL,
pesel               VARCHAR2(11) NOT NULL,
data_zatrudnienia   DATE,
wiek                NUMBER(3), 
telefon             VARCHAR2(14),
nazwa_stanowiska    VARCHAR2(50),
CONSTRAINTS id_adres_fk_osoba FOREIGN KEY(id_adres) REFERENCES adres(id_adres),
CONSTRAINTS id_wypozyczenia_fk_osoba FOREIGN KEY(id_wypozyczenia) REFERENCES wypozyczenia(id_wypozyczenia),
CONSTRAINTS wiek_powyzej_18 CHECK (wiek>=18)
);
DROP TABLE  adres  CASCADE CONSTRAINTS;
DROP TABLE  dane_techniczne_auta  CASCADE CONSTRAINTS;
DROP TABLE  model_auta  CASCADE CONSTRAINTS;
DROP TABLE  auto CASCADE CONSTRAINTS;
DROP TABLE  dokument CASCADE CONSTRAINTS;
DROP TABLE  prawo_jazdy  CASCADE CONSTRAINTS;
DROP TABLE  karta_platnicza  CASCADE CONSTRAINTS;
DROP TABLE  klient CASCADE CONSTRAINTS;
DROP TABLE  stanowisko CASCADE CONSTRAINTS;
DROP TABLE  pracownik  CASCADE CONSTRAINTS;
DROP TABLE  przeglad   CASCADE CONSTRAINTS;
DROP TABLE  serwis CASCADE CONSTRAINTS;
DROP TABLE  ubezpieczyciel  CASCADE CONSTRAINTS;
DROP TABLE  ubezpieczenia CASCADE CONSTRAINTS;
DROP TABLE  rezerwacja  CASCADE CONSTRAINTS;
DROP TABLE  dane_firmy CASCADE CONSTRAINTS;
DROP TABLE  rodzaj_wypozyczenia  CASCADE CONSTRAINTS;
DROP TABLE  oddzial_firmy CASCADE CONSTRAINTS;
DROP TABLE  wypozyczenia CASCADE CONSTRAINTS;
DROP TABLE  zwroty CASCADE CONSTRAINTS;


CREATE TABLE adres (
    id_adres           NUMBER(7) PRIMARY KEY NOT NULL,
    panstwo            VARCHAR2(50) NOT NULL,
    kod_pocztowy       VARCHAR2(6) NOT NULL,
    poczta             VARCHAR2(35) NOT NULL,
    miejscowosc        VARCHAR2(35) NOT NULL,
    adres_zamieszkania VARCHAR2(45) NOT NULL
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
    id_auta          NUMBER(7) 		PRIMARY KEY NOT NULL,
    przebieg         NUMBER	   		NOT NULL,
	marka            VARCHAR2(15) 	NOT NULL,
    id_model 	     NUMBER(7) 		NOT NULL,
	nr_vin           VARCHAR2(17) 	NOT NULL UNIQUE,
    nr_rejestracyjny VARCHAR2(9) 	NOT NULL UNIQUE,
	data_rejestracji_auta 	DATE  NOT NULL,
	cena        	 NUMBER(19, 4)  NOT NULL,
    uwagi            VARCHAR2(255)  NOT NULL,
	CONSTRAINTS id_model_fk_auto FOREIGN KEY(id_model) REFERENCES model_auta(id_model)
);




CREATE TABLE dokument (
	id_dokumentu		NUMBER(7) PRIMARY KEY NOT NULL,
	rodzaj_dokumentu	VARCHAR2(100) NOT NULL,
	numer_dokumentu		VARCHAR2(30) NOT NULL UNIQUE,
	data_wydania		DATE NOT NULL,
	termin_waznosci		DATE NOT NULL
);

CREATE TABLE prawo_jazdy (
	id_prawo_jazdy					NUMBER(7) PRIMARY KEY NOT NULL,
	numer_prawa_jazdy				VARCHAR2(30) NOT NULL UNIQUE,
	kraj_wydania					VARCHAR2(50) NOT NULL,
	data_wydania 					DATE NOT NULL,
	termin_waznosci_prawa_jazdy		DATE NOT NULL
);

CREATE TABLE karta_platnicza (
	id_karta_platnicza		NUMBER(7) PRIMARY KEY NOT NULL,	
	numer_karty_platniczej	VARCHAR2(16) NOT NULL UNIQUE,
	data_waznosci_karty		DATE         NOT NULL,
	CVC						NUMBER(3)    NOT NULL
);



CREATE TABLE klient (
    id_klienta       		NUMBER(7) PRIMARY KEY NOT NULL,
    imie             		VARCHAR2(50) NOT NULL,
    nazwisko         		VARCHAR2(50) NOT NULL,
    wiek                    NUMBER(3)    NOT NULL, 
    pesel            		VARCHAR2(11) NOT NULL UNIQUE,
    telefon          		VARCHAR2(14) NOT NULL UNIQUE,
	id_karta_platnicza		NUMBER(7) NOT NULL,
	id_dokumentu         	NUMBER(7) NOT NULL,
	id_prawo_jazdy         	NUMBER(7) NOT NULL,
	id_adres         		NUMBER(7) NOT NULL,
	CONSTRAINTS id_karta_platnicza_fk_klient FOREIGN KEY(id_karta_platnicza) REFERENCES karta_platnicza(id_karta_platnicza),
	CONSTRAINTS id_dokumentu_fk_klient FOREIGN KEY(id_dokumentu) REFERENCES dokument(id_dokumentu),
	CONSTRAINTS id_prawo_jazdy_fk_klient FOREIGN KEY(id_prawo_jazdy) REFERENCES prawo_jazdy(id_prawo_jazdy),
	CONSTRAINTS id_adres_fk_klient FOREIGN KEY(id_adres) REFERENCES adres(id_adres),
    CONSTRAINTS wiek_powyzej_18 CHECK (wiek>=18)
);

CREATE TABLE stanowisko (
    id_stanowiska    NUMBER(7)PRIMARY KEY NOT NULL,
    nazwa_stanowiska VARCHAR2(50) NOT NULL,
    opis             VARCHAR2(255)
);

CREATE TABLE pracownik (
    id_pracownika       NUMBER(7) PRIMARY KEY NOT NULL,
    imie     			VARCHAR2(50) NOT NULL,
    nazwisko 			VARCHAR2(50) NOT NULL,
    pesel               VARCHAR2(11) NOT NULL UNIQUE,
    data_zatrudnienia   DATE NOT NULL,
	id_stanowiska    	NUMBER(7) NOT NULL,
    id_adres            NUMBER(7) NOT NULL,
	CONSTRAINTS id_adres_fk_pracownik FOREIGN KEY(id_adres) REFERENCES adres(id_adres),
	CONSTRAINTS id_stanowiska_fk_pracownik FOREIGN KEY(id_stanowiska) REFERENCES stanowisko(id_stanowiska)
);


CREATE TABLE przeglad (
    id_przegladu          NUMBER(7) PRIMARY KEY NOT NULL,
    data_przegladu        DATE NOT NULL,
    cena                  NUMBER(19, 4),
    nazwa_firmy_przegladu VARCHAR2(100) NOT NULL,
    adres_firmy_przegladu VARCHAR2(200) NOT NULL,
    id_auta               NUMBER(7) NOT NULL,
	CONSTRAINTS id_auta_fk_przeglad FOREIGN KEY(id_auta) REFERENCES auto(id_auta)
);

CREATE TABLE serwis (
    id_serwisu               NUMBER(7) PRIMARY KEY NOT NULL,
    rodzaj_serwisu           VARCHAR2(50),
    nazwa_firmy_serwisujacej VARCHAR2(50) NOT NULL,
	adres_firmy_serwisujacej VARCHAR2(50) NOT NULL,
    id_auta                  NUMBER(7) NOT NULL,
    data_serwisu             DATE NOT NULL,
	CONSTRAINTS id_auta_fk_serwis FOREIGN KEY(id_auta) REFERENCES auto(id_auta)
);




CREATE TABLE ubezpieczyciel (
    id_ubezpieczyciela NUMBER PRIMARY KEY NOT NULL,
    nazwa              VARCHAR2(50) NOT NULL,
    miejscowosc        VARCHAR2(50) NOT NULL,
    adres              VARCHAR2(50) NOT NULL
);

CREATE TABLE ubezpieczenia (
    id_ubezpieczenia               NUMBER(7) PRIMARY KEY NOT NULL,
    id_auta                        NUMBER(7) NOT NULL,
    rodzaj_ubezpieczenia           VARCHAR2(10) NOT NULL,
    id_ubezpieczyciela             NUMBER(7) NOT NULL,
    data_rozpoczecia_ubezpieczenia DATE NOT NULL,
    data_zakonczenia_ubezpieczenia DATE,
    skladka                        NUMBER(19, 4),
    data_zawieszenia_ubezpieczenia DATE,
    uwagi                          VARCHAR2(255),
	CONSTRAINTS id_auta_fk_ubezpieczenia FOREIGN KEY(id_auta) REFERENCES auto(id_auta),
	CONSTRAINTS id_ubezpieczyciela_fk_ubezpieczenia FOREIGN KEY(id_ubezpieczyciela) REFERENCES ubezpieczyciel(id_ubezpieczyciela)
);


CREATE TABLE rezerwacja (
    id_rezerwacji             NUMBER(7) PRIMARY KEY,
    data_rezerwacji           DATE NOT NULL,
    ilosc_dni_rezerwacji      NUMBER NOT NULL
);

CREATE TABLE dane_firmy (
	id_dane_firmy		NUMBER(7) PRIMARY KEY NOT NULL,
	nazwa_firmy 		VARCHAR2(100) NOT NULL,	
	numer_nip			VARCHAR2(10) NOT NULL,	
	kraj				VARCHAR2(50) NOT NULL,	
	miejscowosc			VARCHAR2(50) NOT NULL,	
	adres 				VARCHAR2(50) NOT NULL	
);


CREATE TABLE rodzaj_wypozyczenia(
	id_rodzaj_wypozyczenia	 NUMBER(7) PRIMARY KEY NOT NULL,
	rodzaj_wypozyczenia      VARCHAR2(100) NOT NULL,
	id_dane_firmy			 NUMBER(7),
	uwagi					 VARCHAR2(250),
	CONSTRAINTS id_dane_firmy_fk_rodzaj_wypozyczenia FOREIGN KEY(id_dane_firmy) REFERENCES dane_firmy(id_dane_firmy)
);




CREATE TABLE oddzial_firmy (
	id_oddzialu		NUMBER(7) PRIMARY KEY NOT NULL,
	miasto		    VARCHAR2(50) NOT NULL,	
	adres			VARCHAR2(50) NOT NULL	
);


CREATE TABLE wypozyczenia (
    id_wypozyczenia           NUMBER(7) PRIMARY KEY NOT NULL,
    id_pracownika             NUMBER(7) NOT NULL,
    id_auta                   NUMBER(7) NOT NULL,
    id_klienta                NUMBER(7) NOT NULL,
    id_rodzaj_wypozyczenia    NUMBER(7) NOT NULL,
    stan_licznika_przed       NUMBER NOT NULL,
    data_wypozyczenia         DATE NOT NULL,
    id_rezerwacji             NUMBER(7),
	id_oddzialu               NUMBER(7) NOT NULL,
    uwagi                     VARCHAR2(250),
	CONSTRAINTS id_pracownika_fk_wypozyczenia FOREIGN KEY(id_pracownika) REFERENCES pracownik(id_pracownika),
	CONSTRAINTS id_auta_fk_wypozyczenia FOREIGN KEY(id_auta) REFERENCES auto(id_auta),
	CONSTRAINTS id_klienta_fk_wypozyczenia FOREIGN KEY(id_klienta) REFERENCES klient(id_klienta),
	CONSTRAINTS id_rodzaj_wypozyczenia_fk_wypozyczenia FOREIGN KEY(id_rodzaj_wypozyczenia) REFERENCES rodzaj_wypozyczenia(id_rodzaj_wypozyczenia),
	CONSTRAINTS id_rezerwacji_fk_wypozyczenia FOREIGN KEY(id_rezerwacji) REFERENCES rezerwacja(id_rezerwacji),
	CONSTRAINTS id_oddzialu_fk_wypozyczenia FOREIGN KEY(id_oddzialu) REFERENCES oddzial_firmy(id_oddzialu)
);



CREATE TABLE zwroty (
    id_zwrotu           NUMBER(7) PRIMARY KEY NOT NULL,
    id_wypozyczenia     NUMBER(7) NOT NULL,
    id_pracownika       NUMBER(7) NOT NULL,
    id_oddzialu       	NUMBER(7) NOT NULL,
    data_zwrotu         DATE,
    stan_licznika_po    NUMBER,
    uwagi               VARCHAR2(255),
	CONSTRAINTS id_wypozyczenia_fk_zwroty FOREIGN KEY(id_wypozyczenia) REFERENCES wypozyczenia(id_wypozyczenia),
	CONSTRAINTS id_pracownika_fk_zwroty FOREIGN KEY(id_pracownika) REFERENCES pracownik(id_pracownika),
	CONSTRAINTS id_oddzialu_fk_zwroty FOREIGN KEY(id_oddzialu) REFERENCES oddzial_firmy(id_oddzialu)
);





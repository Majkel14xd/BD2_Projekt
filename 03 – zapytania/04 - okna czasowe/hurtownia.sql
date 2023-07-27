--Wyświetl ilość, marki, i modele aut zarejestrowane do 2013 roku
SELECT DISTINCT auto.marka,model_auta.model,COUNT(auto.marka) AS "ILOSC"
FROM auto,model_auta
WHERE auto.id_model=model_auta.id_model
AND EXTRACT(YEAR FROM auto.data_rejestracji_auta) BETWEEN 2013 
AND EXTRACT(YEAR FROM SYSDATE) GROUP BY auto.marka,model_auta.model;


--Wyświetl klientów z ostatniego roku 

SELECT DISTINCT osoba.imie,osoba.nazwisko,adres.panstwo,adres.miejscowosc 
FROM osoba,adres,wypozyczenia 
WHERE osoba.id_adres=adres.id_adres 
AND osoba.rodzaj_osoby='Klient'
AND osoba.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
AND EXTRACT(YEAR FROM wypozyczenia.data_wypozyczenia) BETWEEN EXTRACT(YEAR FROM SYSDATE-365) 
AND EXTRACT(YEAR FROM SYSDATE) 
GROUP BY osoba.imie,osoba.nazwisko,adres.panstwo,adres.miejscowosc 
ORDER BY osoba.imie,osoba.nazwisko;


--Wyświetl pracowników zatrudnionych w 2022 roku 

SELECT DISTINCT osoba.imie,osoba.nazwisko,osoba.nazwa_stanowiska,osoba.data_zatrudnienia
FROM osoba,adres 
WHERE osoba.id_adres=adres.id_adres 
AND osoba.rodzaj_osoby ='Pracownik wypozyczajacy' OR osoba.rodzaj_osoby = 'Pracownik zwracajacy'
AND EXTRACT(YEAR FROM osoba.data_zatrudnienia)= 22 
GROUP BY osoba.imie,osoba.nazwisko,osoba.nazwa_stanowiska,osoba.data_zatrudnienia
ORDER BY osoba.imie,osoba.nazwisko;
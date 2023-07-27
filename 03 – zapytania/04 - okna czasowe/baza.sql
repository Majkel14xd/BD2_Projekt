--Wyświetl ilość, marki, i modele aut zarejestrowane do 2013 roku
SELECT DISTINCT auto.marka,model_auta.model,COUNT(auto.marka) AS "ILOSC"
FROM auto,model_auta
WHERE auto.id_model=model_auta.id_model
AND EXTRACT(YEAR FROM auto.data_rejestracji_auta) BETWEEN 2013 
AND EXTRACT(YEAR FROM SYSDATE) GROUP BY auto.marka,model_auta.model;


--Wyświetl klientów z ostatniego roku 

SELECT DISTINCT klient.imie,klient.nazwisko,adres.panstwo,adres.miejscowosc 
FROM klient,adres,wypozyczenia 
WHERE klient.id_adres=adres.id_adres 
AND klient.id_klienta=wypozyczenia.id_klienta 
AND EXTRACT(YEAR FROM wypozyczenia.data_wypozyczenia) BETWEEN EXTRACT(YEAR FROM SYSDATE-365) 
AND EXTRACT(YEAR FROM SYSDATE) 
GROUP BY klient.imie,klient.nazwisko,adres.panstwo,adres.miejscowosc 
ORDER BY klient.imie,klient.nazwisko;


--Wyświetl pracowników zatrudnionych w 2022 roku 

SELECT DISTINCT pracownik.imie,pracownik.nazwisko,stanowisko.nazwa_stanowiska,pracownik.data_zatrudnienia
FROM pracownik,stanowisko,adres 
WHERE pracownik.id_stanowiska=stanowisko.id_stanowiska 
AND pracownik.id_adres=adres.id_adres 
AND EXTRACT(YEAR FROM pracownik.data_zatrudnienia)= 22 
GROUP BY pracownik.imie,pracownik.nazwisko,stanowisko.nazwa_stanowiska,pracownik.data_zatrudnienia
ORDER BY pracownik.imie,pracownik.nazwisko;

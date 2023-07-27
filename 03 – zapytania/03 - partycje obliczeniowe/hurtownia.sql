--Wyświetl ilość konkretnych modeli aut z konkretnym silnikiem 

SELECT auto.marka,model_auta.model,dane_techniczne_auta.moc_silnika,dane_techniczne_auta.rodzaj_paliwa,count(moc_silnika) AS "ILOŚĆ"
FROM auto,model_auta,dane_techniczne_auta 
WHERE auto.id_model=model_auta.id_model 
AND model_auta.id_dane_techniczne_auta=dane_techniczne_auta.id_dane_techniczne_auta 
GROUP BY GROUPING SETS((auto.marka,model_auta.model,dane_techniczne_auta.moc_silnika,dane_techniczne_auta.rodzaj_paliwa)) 
ORDER BY auto.marka,model_auta.model;

--Wyświetl pracowników na konkretnych stanowiskach oraz z danego państwa 

SELECT osoba.nazwa_stanowiska,adres.panstwo,COUNT(osoba.nazwa_stanowiska) AS "ILOŚĆ"
FROM adres,osoba 
WHERE osoba.id_adres=adres.id_adres 
GROUP BY GROUPING SETS((osoba.nazwa_stanowiska,adres.panstwo)) 
ORDER BY osoba.nazwa_stanowiska,adres.panstwo;

--Wyświetl ilość aut wypożyczanych przez klientów
SELECT auto.marka,model_auta.model, COUNT(osoba.id_osoba) AS "ILOŚĆ"
FROM osoba,wypozyczenia,auto,model_auta 
WHERE osoba.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
AND wypozyczenia.id_auta=auto.id_auta 
AND auto.id_model=model_auta.id_model 
AND osoba.rodzaj_osoby='Klient'
GROUP BY GROUPING SETS((auto.marka,model_auta.model)) ORDER BY auto.marka,model_auta.model;
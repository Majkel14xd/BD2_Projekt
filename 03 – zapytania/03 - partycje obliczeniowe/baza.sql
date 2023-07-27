--Wyświetl ilość konkretnych modeli aut z konkretnym silnikiem 

SELECT auto.marka,model_auta.model,dane_techniczne_auta.moc_silnika,dane_techniczne_auta.rodzaj_paliwa,count(moc_silnika) AS "ILOŚĆ"
FROM auto,model_auta,dane_techniczne_auta 
WHERE auto.id_model=model_auta.id_model 
AND model_auta.id_dane_techniczne_auta=dane_techniczne_auta.id_dane_techniczne_auta 
GROUP BY GROUPING SETS((auto.marka,model_auta.model,dane_techniczne_auta.moc_silnika,dane_techniczne_auta.rodzaj_paliwa)) 
ORDER BY auto.marka,model_auta.model;

--Wyświetl pracowników na konkretnych stanowiskach oraz z danego państwa 

SELECT stanowisko.nazwa_stanowiska,adres.panstwo,COUNT(nazwa_stanowiska) AS "ILOŚĆ"
FROM stanowisko,adres,pracownik 
WHERE stanowisko.id_stanowiska=pracownik.id_stanowiska 
AND pracownik.id_adres=adres.id_adres 
GROUP BY GROUPING SETS((stanowisko.nazwa_stanowiska,adres.panstwo)) 
ORDER BY stanowisko.nazwa_stanowiska,adres.panstwo;

--Wyświetl ilość aut wypożyczanych przez klientów
SELECT auto.marka,model_auta.model, COUNT(klient.id_klienta) AS "ILOŚĆ"
FROM klient,wypozyczenia,auto,model_auta 
WHERE klient.id_klienta=wypozyczenia.id_klienta 
AND wypozyczenia.id_auta=auto.id_auta 
AND auto.id_model=model_auta.id_model 
GROUP BY GROUPING SETS((auto.marka,model_auta.model)) ORDER BY auto.marka,model_auta.model;
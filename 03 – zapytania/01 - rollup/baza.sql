--Wyświetl listę klientów wraz z informacjami na temat auta którzy wypożyczyli auto marki Fiat 

SELECT klient.nazwisko,klient.imie,klient.telefon,auto.marka,model_auta.model 
FROM klient,auto,wypozyczenia,model_auta
WHERE wypozyczenia.id_klienta=klient.id_klienta AND wypozyczenia.id_auta=auto.id_auta AND model_auta.id_model=auto.id_model AND auto.marka = 'Fiat'
GROUP BY ROLLUP(klient.nazwisko,klient.imie,klient.telefon,auto.marka,model_auta.model);

--Wyświetl ilość wypożyczeń konkretnych modeli aut wypożyczonych przez każdego pracownika
SELECT pracownik.nazwisko,pracownik.imie,auto.marka,model_auta.model,COUNT(auto.id_model) AS "ILOSC WYPOZYCZEN" 
FROM pracownik,wypozyczenia,auto,model_auta 
WHERE pracownik.id_pracownika=wypozyczenia.id_pracownika AND wypozyczenia.id_auta=auto.id_auta AND auto.id_model=model_auta.id_model 
GROUP BY ROLLUP (pracownik.nazwisko,pracownik.imie,auto.marka,model_auta.model);


--Wyświetl ilość modeli aut których moc silnika jest większa niż 70km 

SELECT auto.marka,model_auta.model,auto.cena,dane_techniczne_auta.moc_silnika 
FROM auto,model_auta,dane_techniczne_auta WHERE
auto.id_auta=model_auta.id_model AND model_auta.id_dane_techniczne_auta=dane_techniczne_auta.id_dane_techniczne_auta AND dane_techniczne_auta.moc_silnika>70
GROUP BY ROLLUP(auto.marka,model_auta.model,auto.cena,dane_techniczne_auta.moc_silnika);
--Wyświetl listę klientów wraz z informacjami na temat auta którzy wypożyczyli auto marki Fiat 

SELECT osoba.nazwisko,osoba.imie,osoba.telefon,auto.marka,model_auta.model 
FROM osoba,auto,wypozyczenia,model_auta
WHERE wypozyczenia.id_wypozyczenia=osoba.id_wypozyczenia AND wypozyczenia.id_auta=auto.id_auta AND model_auta.id_model=auto.id_model AND auto.marka = 'Fiat' AND osoba.rodzaj_osoby='Klient'
GROUP BY ROLLUP(osoba.nazwisko,osoba.imie,osoba.telefon,auto.marka,model_auta.model);

--Wyświetl ilość wypożyczeń konkretnych modeli aut wypożyczonych przez każdego pracownika
SELECT osoba.nazwisko,osoba.imie,auto.marka,model_auta.model,COUNT(auto.id_model) AS "ILOSC WYPOZYCZEN" 
FROM osoba,wypozyczenia,auto,model_auta 
WHERE osoba.id_wypozyczenia=wypozyczenia.id_wypozyczenia AND wypozyczenia.id_auta=auto.id_auta AND auto.id_model=model_auta.id_model AND osoba.rodzaj_osoby='Pracownik wypozyczajacy'
GROUP BY ROLLUP (osoba.nazwisko,osoba.imie,auto.marka,model_auta.model);

--Wyświetl ilość modeli aut których moc silnika jest większa niż 70km 

SELECT auto.marka,model_auta.model,auto.cena,dane_techniczne_auta.moc_silnika 
FROM auto,model_auta,dane_techniczne_auta WHERE
auto.id_auta=model_auta.id_model AND model_auta.id_dane_techniczne_auta=dane_techniczne_auta.id_dane_techniczne_auta AND dane_techniczne_auta.moc_silnika>70
GROUP BY ROLLUP(auto.marka,model_auta.model,auto.cena,dane_techniczne_auta.moc_silnika);
--Wyświetl dane o pracownikach (miejscowość, nazwisko, imię, stanowisko ) 
SELECT osoba.imie,osoba.nazwisko,osoba.nazwa_stanowiska,adres.miejscowosc 
FROM osoba,adres 
WHERE osoba.id_adres=adres.id_adres 
AND osoba.rodzaj_osoby ='Pracownik wypozyczajacy' OR osoba.rodzaj_osoby = 'Pracownik zwracajacy'
GROUP BY CUBE(osoba.imie,osoba.nazwisko,osoba.nazwa_stanowiska,adres.miejscowosc );

-- Wyświetl marki aut które były najczęściej wypożyczane 
SELECT auto.marka, count(auto.marka) AS "ILOSC MAREK"
FROM auto,wypozyczenia
WHERE auto.id_auta=wypozyczenia.id_auta
GROUP BY CUBE(auto.marka);

--Wyświetl firmy które najczęściej wypożyczając konkretne auta 
SELECT auto.marka,dane_firmy.nazwa_firmy,count(auto.marka) AS "ILOŚĆ"
FROM auto,wypozyczenia,rodzaj_wypozyczenia,dane_firmy
WHERE dane_firmy.id_dane_firmy=rodzaj_wypozyczenia.id_dane_firmy 
AND rodzaj_wypozyczenia.id_rodzaj_wypozyczenia=wypozyczenia.id_rodzaj_wypozyczenia 
AND wypozyczenia.id_auta=auto.id_auta
GROUP BY CUBE(auto.marka,dane_firmy.nazwa_firmy);
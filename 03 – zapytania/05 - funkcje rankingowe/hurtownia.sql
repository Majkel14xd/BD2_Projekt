--Wyświetl ranking najchętniej wypożyczanych marek przez klientów 

SELECT DISTINCT auto.marka,COUNT(osoba.id_osoba) AS "ILOSC",
DENSE_RANK() OVER (ORDER BY count(osoba.id_osoba) DESC) AS "RANKING" 
FROM auto,wypozyczenia,osoba 
WHERE auto.id_auta=wypozyczenia.id_auta 
AND wypozyczenia.id_wypozyczenia =osoba.id_wypozyczenia 
AND osoba.rodzaj_osoby='Klient'
GROUP BY auto.marka;

--Wyświetl ranking firm najchętniej wypożyczających auta

SELECT DISTINCT dane_firmy.nazwa_firmy,COUNT(wypozyczenia.id_wypozyczenia) AS "ILOSC",
DENSE_RANK() OVER (ORDER BY count(dane_firmy.id_dane_firmy) DESC) AS "RANKING" 
FROM dane_firmy,rodzaj_wypozyczenia,wypozyczenia 
WHERE dane_firmy.id_dane_firmy=rodzaj_wypozyczenia.id_dane_firmy 
AND rodzaj_wypozyczenia.id_rodzaj_wypozyczenia=wypozyczenia.id_rodzaj_wypozyczenia 
GROUP BY dane_firmy.nazwa_firmy;

--Wyświetl ranking firm ubezpieczających auta wypożyczalni 

SELECT DISTINCT ubezpieczenie.nazwa_firmy_ubezpieczeniowej , count(auto.id_auta) AS "ILOSC",
DENSE_RANK() OVER (ORDER BY count(auto.id_auta) DESC) AS "RANKING"
FROM wypozyczenia,ubezpieczenie,auto
WHERE wypozyczenia.id_ubezpieczenia=ubezpieczenie.id_ubezpieczenia 
AND wypozyczenia.id_auta=auto.id_auta 
GROUP BY ubezpieczenie.nazwa_firmy_ubezpieczeniowej;

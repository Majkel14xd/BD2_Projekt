--Wyświetl ranking najchętniej wypożyczanych marek przez klientów 

SELECT DISTINCT auto.marka,COUNT(klient.id_klienta) AS "ILOSC",
DENSE_RANK() OVER (ORDER BY count(klient.id_klienta) DESC) AS "RANKING" 
FROM auto,wypozyczenia,klient 
WHERE auto.id_auta=wypozyczenia.id_auta 
AND wypozyczenia.id_klienta=klient.id_klienta 
GROUP BY auto.marka;

--Wyświetl ranking firm najchętniej wypożyczających auta

SELECT DISTINCT dane_firmy.nazwa_firmy,COUNT(wypozyczenia.id_wypozyczenia) AS "ILOSC",
DENSE_RANK() OVER (ORDER BY count(dane_firmy.id_dane_firmy) DESC) AS "RANKING" 
FROM dane_firmy,rodzaj_wypozyczenia,wypozyczenia 
WHERE dane_firmy.id_dane_firmy=rodzaj_wypozyczenia.id_dane_firmy 
AND rodzaj_wypozyczenia.id_rodzaj_wypozyczenia=wypozyczenia.id_rodzaj_wypozyczenia 
GROUP BY dane_firmy.nazwa_firmy;

--Wyświetl ranking firm ubezpieczających auta wypożyczalni 

SELECT DISTINCT ubezpieczyciel.nazwa, count(auto.id_auta) AS "ILOSC",
DENSE_RANK() OVER (ORDER BY count(auto.id_auta) DESC) AS "RANKING"
FROM ubezpieczyciel,ubezpieczenia,auto 
WHERE ubezpieczyciel.id_ubezpieczyciela=ubezpieczenia.id_ubezpieczyciela 
AND ubezpieczenia.id_auta=auto.id_auta 
GROUP BY ubezpieczyciel.nazwa;

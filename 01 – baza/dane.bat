cd .\ladowanie_danych
Set nazwa_uztkownika=BD2_Projekt
Set haslo=haslo
Set adres=localhost:1521/XE
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\adres.txt LOG=".\logi\adres.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\dane_techniczne_auta.txt LOG=".\logi\dane_techniczne_auta.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\model_auta.txt LOG=".\logi\model_auta.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\auto.txt LOG=".\logi\auto.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\dokument.txt LOG=".\logi\dokument.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\prawo_jazdy.txt  LOG=".\logi\prawo_jazdy.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\karta_platnicza.txt LOG=".\logi\karta_platnicza.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\klient.txt LOG=".\logi\klient.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\stanowisko.txt LOG=".\logi\stanowisko.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\pracownik.txt LOG=".\logi\pracownik.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\przeglad.txt LOG=".\logi\przeglad.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\serwis.txt LOG=".\logi\serwis.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\ubezpieczyciel.txt LOG=".\logi\ubezpieczyciel.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\ubezpieczenia.txt LOG=".\logi\ubezpieczenia.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\rezerwacja.txt LOG=".\logi\rezerwacja.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\dane_firmy.txt LOG=".\logi\dane_firmy.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\rodzaj_wypozyczenia.txt LOG=".\logi\rodzaj_wypozyczenia.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\oddzial_firmy.txt LOG=".\logi\oddzial_firmy.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\wypozyczenia.txt LOG=".\logi\wypozyczenia.log" DATE_CACHE=0
sqlldr %nazwa_uztkownika%/%haslo%@%adres% control=.\dane\zwroty.txt LOG=".\logi\zwroty.log" DATE_CACHE=0
pause
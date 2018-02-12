# Generátor testov
Webová aplikácia pre doc. Šikudovú.

## Inštalácia
Je potrebné mať nainštalovaný [Composer](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-osx) a [npm](https://docs.npmjs.com/getting-started/installing-node). Následne spustiť nasledovné príkazy:
```
composer install
npm install
```

## Vytvorenie databázy
Pre vytvorenie tabuliek zadať tento príkaz:
```
php artisan migrate
```
Pre naplnenie náhodnými dátami:
```
php artisan db:seed
```
Druhá možnosť je klasické importovanie súboru `databaza.sql` - v tomto súbore sú už všetky údaje dodané zadávateľkou.

## Generovanie kľúča
```
php artisan key:generate
```
## Compiling assets
Run this command
```
npm run dev
```
If you want to minify output run this
```
npm run production
```
See [this](https://laravel.com/docs/5.5/mix) for more info.

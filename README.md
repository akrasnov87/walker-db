## Общедоступная база данных Mobile Walker для Postgres

Исходный код базы данных адаптирован для интеграции с [bidubase](https://github.com/akrasnov87/budibase).

Код БД создан при помощи плагина [pgcodekeeper](https://pgcodekeeper.org/)

__Примечание__: перед созданием БД требуется создать роль `mobwal` и к ней привязать пользователя, чтобы была возможность подключаться.

<pre>
-- Role: mobwal
-- DROP ROLE IF EXISTS mobwal;

CREATE ROLE mobwal WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  NOBYPASSRLS;
</pre>

### Предварительная настройка

Создаём пустую бд:

<pre>
-- Database: walker-dev

-- DROP DATABASE IF EXISTS "walker-dev";

CREATE DATABASE "walker-dev"
    WITH
    OWNER = mobwal
    ENCODING = 'UTF8'
    LC_COLLATE = 'ru_RU.UTF-8'
    LC_CTYPE = 'ru_RU.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

ALTER DATABASE "walker-dev"
    SET "TimeZone" TO 'UTC';
</pre>

Далее при помощи плагина [pgcodekeeper](https://pgcodekeeper.org/) "наполняем" БД структурой. 

### Первичная загрузка данных

Перед началом работы с базоф данных требуется выполнить скрипт `MIGRATION/data.sql`.
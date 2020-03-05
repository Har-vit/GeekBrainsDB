use shop_online;

SELECT * FROM products;

-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

UPDATE products
    SET created_at = NOW() where created_at is NULL;

UPDATE products
    SET updated_at = NOW() where created_at is NULL;

-- 2.Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения
-- в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

ALTER TABLE products 
    CHANGE COLUMN `created_at` `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHANGE COLUMN `updated_at` `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0,
-- если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом,
-- чтобы они выводились в порядке увеличения значения value. Нулевые запасы должны выводиться в конце, после всех записей.

create table storehouses_products (
	id SERIAL PRIMARY KEY,
    storehouse_id INT unsigned,
    product_id INT unsigned,
    `value` INT unsigned COMMENT 'Запас на складе',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 4, 11),
    (1, 3, 0),
    (1, 0, 13);

SELECT 
    value
FROM
    storehouses_products ORDER BY IF(value > 0, 0, 1), value;

-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT name, birthday_at FROM users WHERE MONTHNAME(birthday_at) IN ('may', 'august'); -- // Вариант от GB - Н работаетю

-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса:
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

SELECT* FROM catalogs WHERE id IN (3, 1, 2) ORDER BY FIELD(id, 3, 1, 2);



-- *** 1. Подсчитайте средний возраст пользователей в таблице users. ***

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 0) AS AVG_Age FROM users;

-- *** 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.***
-- *** Следует учесть, что необходимы дни недели текущего года, а не года рождения. ***********

SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
FROM
	users
GROUP BY
	day
ORDER BY
	total DESC;

-- *** 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы. ***

SELECT ROUND(exp(SUM(ln(value))), 0) AS factorial FROM integers;

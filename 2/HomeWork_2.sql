USE myfirstdb;
/* 1. Используя операторы языка SQL, создайте таблицу “sales”. Заполните ее данными.*/
CREATE TABLE IF NOT EXISTS sales (
	id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT, -- UNSIGNED - НЕ ОТРЕЦАТЕЛЬНО ЗНАЧЕНИЕ.
	order_date DATE,
	count_product INT UNSIGNED
);

DESCRIBE sales; -- выведем структуру таблицы.

INSERT sales -- добавим значения в таблицу
VALUES
(id, "2022-01-01", 156),
(id, "2022-01-02", 180),
(id, "2022-01-03", 21),
(id, "2022-01-04", 124),
(id, "2022-01-05", 341);

SELECT * FROM sales; -- выведем таблицу

/*2. Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва :
меньше 100 - Маленький заказ 
от 100 до 300 - Средний заказ
больше 300 - Большой заказ*/

SELECT 
	id,
    count_product,
	IF (count_product < 100, "Маленький заказ",
		IF (count_product between 100 AND 300, "Средний заказ", "Большой заказ"
            )
		) AS "Тип заказа"
FROM sales;

/*3. 
Создайте таблицу “orders”, заполните ее значениями
id employee_id amount order_status
1 e03 15.00 OPEN
2 e01 25.50 OPEN
3 e05 100.70 CLOSED
4 e02 22.18 OPEN
5 e04 9.50 CANCELLED
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED - «Order is cancelled»
 */
 
 CREATE TABLE IF NOT EXISTS orders (
	id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT, -- UNSIGNED - НЕ ОТРЕЦАТЕЛЬНО ЗНАЧЕНИЕ.
	employee_id VARCHAR(5),
	amount DOUBLE(5,2),
    order_status VARCHAR(20)
);

DESCRIBE orders; -- выведем структуру таблицы.

INSERT orders -- добавим значения в таблицу.
VALUES
(id, "e03", 15.00, "OPEN"),
(id, "e01", 25.50, "OPEN"),
(id, "e05", 100.70, "CLOSED"),
(id, "e02", 22.18, "OPEN"),
(id, "e04", 9.50, "CANCELLED");

SELECT 
id, employee_id, amount, order_status,
CASE
	WHEN order_status = "OPEN" THEN "«Order is in open state»"
	WHEN order_status = "CLOSED" THEN "«Order is closed»"
	WHEN order_status = "CANCELLED" THEN "«Order is cancelled»"
	ELSE "Такого статуса нет" 
END AS  full_order_status
FROM orders;

/*4. Чем 0 отличается от NULL?
Ответ: 
0 это цифровое значение, которое может применяться в числовых данных типо INT.
NULL - NULL - это специальное значение, которое используется в SQL для обозначения отсутствия данных. 
Оно отличается от пустой строки или нулевого значения, 
так как NULL означает отсутствие какого-либо значения в ячейке таблицы.*/

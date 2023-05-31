-- создадим заполним таблицу 1 
CREATE DATABASE IF NOT EXISTS lesson3;

USE Lesson3;

-- создадим таблицу 1 SALESPEOPLE
CREATE TABLE IF NOT EXISTS SALESPEOPLE (
  snum INT PRIMARY KEY,
  sname VARCHAR(45),
  city VARCHAR(45),
  comm DECIMAL(2, 2)
);

-- Заполним таблицу 1
INSERT
  salespeople
VALUES
  (1001, 'Peel', 'London',.12),
  (1002, 'Serres', 'San Jose',.13),
  (1004, 'Motika', 'London',.11),
  (1007, 'Rifkin', 'Barcelona',.15),
  (1003, 'Axelrod', 'New York',.10);

SELECT
  *
FROM
  salespeople;

-- создадим заполним таблицу 2 CUSTOMERS
CREATE TABLE IF NOT EXISTS CUSTOMERS (
  cnum INT PRIMARY KEY,
  cname VARCHAR(45),
  city VARCHAR(45),
  rating INT,
  snum INT
);

-- связжем таблицу 1 и 2 по snum
ALTER TABLE
  CUSTOMERS -- Потомок
ADD
  CONSTRAINT CUSTOMERS_SALESPEOPLE_id_fk FOREIGN KEY (snum) REFERENCES SALESPEOPLE(snum) -- Предок
  ON DELETE NO ACTION -- CASCADE, SET NULL, NO ACTION, RESTRICT, SET DEFAULT
  ON UPDATE CASCADE;

-- заполним таблицу 2
INSERT
  CUSTOMERS
VALUES
  (2001, "Hoffman", "London", 100, 1001),
  (2002, "Giovanni", "Rome", 200, 1003),
  (2003, "Liu", "SanJose", 200, 1002),
  (2004, "Grass", "Berlin", 300, 1002),
  (2006, "Clemens", "London", 100, 1001),
  (2008, "Cisneros", "SanJose", 300, 1007),
  (2007, "Pereira", "Rome", 100, 1004);

SELECT
  *
FROM
  CUSTOMERS;

-- создадим таблицу 3 ORDERS
CREATE TABLE IF NOT EXISTS ORDERS (
  onum INT PRIMARY KEY,
  amt DECIMAL(7, 2),
  odate VARCHAR(10) NOT NULL,
  cnum INT,
  snum INT
);

-- свяжем таблицы
ALTER TABLE
  ORDERS -- Потомок
ADD
  CONSTRAINT ORDERS_SALESPEOPLE_id FOREIGN KEY (snum) REFERENCES SALESPEOPLE(snum) -- Предок
  ON DELETE NO ACTION -- CASCADE, SET NULL, NO ACTION, RESTRICT, SET DEFAULT
  ON UPDATE CASCADE;

ALTER TABLE
  ORDERS
ADD
  CONSTRAINT ORDERS_CUSTOMERS_id FOREIGN KEY (cnum) REFERENCES CUSTOMERS(cnum) ON DELETE NO ACTION -- CASCADE, SET NULL, NO ACTION, RESTRICT, SET DEFAULT
  ON UPDATE CASCADE;

-- заполним таблицу 3.
INSERT
  ORDERS
VALUES
  (3001, 18.69, "10/03/1990", 2008, 1007),
  (3003, 767.19, "10/03/1990", 2001, 1001),
  (3002, 1900.10, "10/03/1990", 2007, 1004),
  (3005, 5160.45, "10/03/1990", 2003, 1002),
  (3006, 1098.16, "10/03/1990", 2008, 1007),
  (3009, 1713.23, "10/04/1990", 2002, 1003),
  (3007, 75.75, "10/04/1990", 2004, 1002),
  (3008, 4723.00, "10/05/1990", 2006, 1001),
  (3010, 1309.95, "10/06/1990", 2004, 1002),
  (3011, 9891.88, "10/06/1990", 2006, 1001);

SELECT
  *
FROM
  ORDERS;

/*1. Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: city, sname,
 snum, comm. (к первой или второй таблице, используя SELECT)*/
SELECT
  city,
  sname,
  snum,
  comm
FROM
  salespeople;

/*2. Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем
 каждого заказчика в городе San Jose. (“заказчики”)*/
SELECT
  rating,
  cname,
  city
FROM
  CUSTOMERS
WHERE
  city = "SanJose";

/*3. Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без
 каких бы то ни было повторений. (уникальные значения в “snum“ “Продавцы”)*/
SELECT
  *
FROM
  SALESPEOPLE
GROUP BY
  snum;

/*4*. Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G.
 Используется оператор "LIKE": (“заказчики”) https://dev.mysql.com/doc/refman/8.0/en/string-comparisonfunctions.html*/
SELECT
  *
FROM
  CUSTOMERS
WHERE
  cname LIKE "G%";

/*5. Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000.
 (“Заказы”, “amt” - сумма)*/
SELECT
  *
FROM
  ORDERS
WHERE
  amt > 1000;

/*6. Напишите запрос который выбрал бы наименьшую сумму заказа.
 (Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)*/
SELECT
  MIN(amt)
FROM
  ORDERS;

/*  
 7. Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков,
 у которых рейтинг больше 100 и они находятся не в Риме.	*/
SELECT
  *
FROM
  customers
WHERE
  rating > 100
  AND city != "Rome";

/* 
 ==================== ТАБЛИЦА 1: ПРОДАВЦЫ (SALESPEOPLE) ================
 ----------------------------------------------
 snum | sname 	| city 		| comm
 -----|---------|-----------|----------
 1001 | Peel 	| London 	| .12
 1002 | Serres 	| San Jose 	| .13
 1004 | Motika 	| London 	| .11
 1007 | Rifkin 	| Barcelona | .15
 1003 | Axelrod | New York 	| .10
 ---------------------------------------------
 */
/*
 ================== ТАБЛИЦА 2: ЗАКАЗЧИКИ (CUSTOMERS) ===============
 ----------------------------------------------
 cnum 	| cname 	| city 		| rating| snum
 --------|-----------|-----------|-------|------
 2001	| Hoffman 	| London 	| 100 	| 1001
 2002 	| Giovanni 	| Rome 		| 200 	| 1003
 2003 	| Liu 		| SanJose 	| 200 	| 1002
 2004 	| Grass 	| Berlin 	| 300 	| 1002
 2006 	| Clemens 	| London 	| 100 	| 1001
 2008 	| Cisneros 	| SanJose 	| 300 	| 1007
 2007 	| Pereira 	| Rome 		| 100 	| 1004
 ----------------------------------------------
 */
/*
 ================== ТАБЛИЦА 3: ЗАКАЗЫ (ORDERS) ==================
 -----------------------------------------------
 onum | amt 	| odate 	 | cnum | snum
 -----|---------|------------|------|------
 3001 | 18.69 	| 10/03/1990 | 2008 | 1007
 3003 | 767.19 	| 10/03/1990 | 2001 | 1001
 3002 | 1900.10 | 10/03/1990 | 2007 | 1004
 3005 | 5160.45 | 10/03/1990 | 2003 | 1002
 3006 | 1098.16	| 10/03/1990 | 2008 | 1007
 3009 | 1713.23 | 10/04/1990 | 2002 | 1003
 3007 | 75.75	| 10/04/1990 | 2004 | 1002
 3008 | 4723.00 | 10/05/1990 | 2006 | 1001
 3010 | 1309.95 | 10/06/1990 | 2004 | 1002
 3011 | 9891.88 | 10/06/1990 | 2006 | 1001
 -----------------------------------------------
 */
------------------------------------------------------
-- Дополнительное задание-------
-- 3. Создание таблицы
CREATE TABLE IF NOT EXISTS staff (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(45),
  last_name VARCHAR(45),
  post VARCHAR(45),
  seniority INT,
  -- DECIMAL(общее количество знаков, количество знаков после запятой)
  -- DECIMAL(5,2) будут числа от -999.99 до 999.99
  salary DECIMAL(8, 2),
  -- это числа от -999999.99 до 999999.99
  age INT
);

# Заполнение данными
INSERT
  staff (
    first_name,
    last_name,
    post,
    seniority,
    salary,
    age
  )
VALUES
  ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
  ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
  ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
  ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
  ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
  ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
  ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
  ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
  ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
  ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
  ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
  ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

SELECT
  *
FROM
  staff;

/*1. Отсортируйте поле “зарплата” в порядке убывания и возрастания*/
SELECT
  *
FROM
  staff
ORDER BY
  salary DESC;

SELECT
  *
FROM
  staff
ORDER BY
  salary;

/*2. ** Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с
 наибольшей заработной платой (возможен подзапрос)*/
SELECT
  *
FROM
  (
    SELECT
      *
    FROM
      staff
    ORDER BY
      salary DESC
    LIMIT
      5
  ) AS tb
ORDER BY
  salary;

/*3. Выполните группировку всех сотрудников по специальности,
 суммарная зарплата которых превышает 100000*/
SELECT
  post,
  SUM(salary) AS money
FROM
  staff
GROUP BY
  post
HAVING
  money > 100000;
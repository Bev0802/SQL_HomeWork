CREATE DATABASE IF NOT EXISTS lesson_4;

USE Lesson_4;

CREATE TABLE  AUTO 
(       
	REGNUM VARCHAR(10) PRIMARY KEY, 
	MARK VARCHAR(10), 
	COLOR VARCHAR(15),
	RELEASEDT DATE, 
	PHONENUM VARCHAR(15)
);

INSERT AUTO 
VALUES
(111114,'LADA', 'КРАСНЫЙ', date'2008-01-01', '9152222221'),
(111115,'VOLVO', 'КРАСНЫЙ', date'2013-01-01', '9173333334'),
(111116,'BMW', 'СИНИЙ', date'2015-01-01', '9173333334'),
(111121,'AUDI', 'СИНИЙ', date'2009-01-01', '9173333332'),
(111122,'AUDI', 'СИНИЙ', date'2011-01-01', '9213333336'),
(111113,'BMW', 'ЗЕЛЕНЫЙ', date'2007-01-01', '9214444444'),
(111126,'LADA', 'ЗЕЛЕНЫЙ', date'2005-01-01', null),
(111117,'BMW', 'СИНИЙ', date'2005-01-01', null),
(111119,'LADA', 'СИНИЙ', date'2017-01-01', 9213333331);

SELECT * FROM AUTO;

CREATE TABLE  CITY 
(	
    CITYCODE INT PRIMARY KEY,
	CITYNAME VARCHAR(50), 
	PEOPLES INT 
);

INSERT CITY 
VALUES
(1,'Москва', 10000000),
(2,'Владимир', 500000),
(3, 'Орел', 300000),
(4,'Курск', 200000),
(5, 'Казань', 2000000),
(7, 'Котлас', 110000),
(8, 'Мурманск', 400000),
(9, 'Ярославль', 500000);

SELECT * FROM CITY;

CREATE TABLE  MAN 
(	
	PHONENUM VARCHAR(15) PRIMARY KEY , 
	FIRSTNAME VARCHAR(50),
	LASTNAME VARCHAR(50),  
	CITYCODE INT, 
	YEAROLD INT	 
);

INSERT MAN
VALUES
('9152222221','Андрей','Николаев', 1, 22),
('9152222222','Максим','Москитов', 1, 31),
('9153333333','Олег','Денисов', 3, 34),
('9173333334','Алиса','Никина', 4, 31),
('9173333335','Таня','Иванова', 4, 31),
('9213333336','Алексей','Иванов', 7, 25),
('9213333331','Андрей','Некрасов', 2, 27),
('9213333332','Миша','Рогозин', 2, 21),
('9214444444','Алексей','Галкин', 1, 38);

SELECT * FROM MAN;

/*
1. Вывести на экран, сколько машин каждого цвета для машин марок BMW и LADA.
*/

SELECT
	MARK,
    COLOR,    
    COUNT(COLOR)
FROM AUTO
WHERE MARK IN ("BMW", "LADA") 
GROUP BY MARK, COLOR
ORDER BY MARK;

/*
2. Вывести на экран марку авто(количество) и количество авто не этой марки.
100 машин, их них 
20 - BMW и 80 машин другой марки , 
AUDI - 30 и 70 машин другой марки, 
LADA - 15, 85 авто другой марки
*/

SELECT 
	MARK,
    COUNT(MARK),
    (SELECT COUNT(*) FROM auto) - COUNT(MARK) AS OTHER_MARK
FROM AUTO
GROUP BY MARK
ORDER BY MARK;

/*
Даны 2 таблицы, созданные следующим образом:
Напишите запрос, который вернет строки из таблицы test_a, id которых нет в
таблице test_b, НЕ используя ключевого слова NOT.
*/
create table test_a (id INT, test varchar(10));
create table test_b (id INT);
insert into test_a(id, test) values
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');
insert into test_b(id) values
(10),
(30),
(50);

SELECT test_a.*
FROM test_a
  LEFT JOIN test_b
	ON test_a.id = test_b.id
WHERE test_b.id IS NULL;

/*4. Дополнительное задание
 Вернёмся к домашней работе #3 и заметим, что таблица orders была неудачно спроектирована. 
 Записи odate были заданы типом VARCHAR и в них долгое время помещались значения в формате '10/03/1990'. 
 Необходимо преобразовать поля таблицы к типу DATETIME, сохранив введеные ранее значения. */ 

CREATE TABLE IF NOT EXISTS orders (
	onum INT NOT NULL,
	amt DECIMAL(7,2) NOT NULL,
	odate VARCHAR(10) NOT NULL,
	cnum INT,
	snum INT,
	PRIMARY KEY (onum)
);

INSERT INTO orders(onum, amt, odate, cnum, snum)
VALUES
	(3001, 18.69, '10/03/1990', 2008, 1007),
	(3003, 767.19, '10/03/1990', 2001, 1001),
	(3002, 1900.10, '10/03/1990', 2007, 1004),
	(3005, 5160.45, '10/03/1990', 2003, 1002),
	(3006, 1098.16, '10/03/1990', 2008, 1007),
	(3009, 1713.23, '10/04/1990', 2002, 1003),
	(3007, 75.75, '10/04/1990', 2004, 1002),
	(3008, 4723.00, '10/05/1990', 2006, 1001),
	(3010, 1309.95, '10/06/1990', 2004, 1002),
	(3011, 9891.88, '10/06/1990', 2006, 1001);
SELECT * FROM orders;

ALTER TABLE orders
  ADD COLUMN odate_correct DATE;
    
UPDATE orders
    SET odate_correct = STR_TO_DATE(odate, '%d/%m/%Y');
    
SELECT * FROM orders;

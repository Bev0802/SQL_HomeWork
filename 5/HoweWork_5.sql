/*1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов;*/
CREATE TABLE IF NOT EXISTS cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT UNSIGNED
);

INSERT cars
VALUES
	(1, "Audi", 52642),
  (2, "Mercedes", 57127 ),
  (3, "Skoda", 9000 ),
  (4, "Volvo", 29000),
	(5, "Bentley", 350000),
  (6, "Citroen ", 21000 ), 
  (7, "Hummer", 41400), 
  (8, "Volkswagen ", 21600);
    
SELECT * FROM cars;

CREATE VIEW create_view AS 
SELECT * 
FROM cars 
WHERE cost < 25000;

SELECT * FROM create_view;
/*2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW);*/

ALTER VIEW create_view AS
SELECT *
FROM cars 
WHERE cost < 30000;

SELECT * FROM create_view;

DROP VIEW create_view;

/*3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично).*/

CREATE VIEW name_shcoda_audi AS
SELECT * FROM cars
WHERE name IN ("Audi", "Skoda");

SELECT * FROM name_shcoda_audi;

DROP VIEW name_shcoda_audi;
/*4. Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.*/

CREATE TABLE analysis_groups(
gr_id INT NOT NULL PRIMARY KEY, -- ID группы
gr_name VARCHAR(45), -- название группы
gr_temp FLOAT -- температурный режим хранения
);

SELECT * FROM analysis_groups;

CREATE TABLE Analysis
(
an_id INT NOT NULL PRIMARY KEY, -- ID анализа;
an_name VARCHAR(45), -- название анализа;
an_cost FLOAT, -- себестоимость анализа;
an_price FLOAT, -- розничная цена анализа
an_group INT -- группа анализов
);

SELECT * FROM Analysis;

ALTER TABLE
  Analysis -- Потомок
ADD
  CONSTRAINT an_group FOREIGN KEY (an_group) REFERENCES analysis_groups(gr_id) -- Предок
  ON DELETE NO ACTION -- CASCADE, SET NULL, NO ACTION, RESTRICT, SET DEFAULT
  ON UPDATE CASCADE;

CREATE TABLE Orders
(
ord_id INT NOT NULL PRIMARY KEY, --  ID заказа;
ord_datetime datetime,-- дата и время заказа;
ord_an INT -- ID анализа.
);

SELECT * FROM Orders;

ALTER TABLE
  Orders -- Потомок
ADD
  CONSTRAINT ord_an FOREIGN KEY (ord_an) REFERENCES Analysis(an_id) -- Предок
  ON DELETE NO ACTION -- CASCADE, SET NULL, NO ACTION, RESTRICT, SET DEFAULT
  ON UPDATE CASCADE;


SELECT
  an_name AS 'Название анализа',  
  an_price AS 'Цена',
  ord_datetime AS 'Дата заказа'
FROM Analysis
  JOIN Orders
    ON Analysis.an_id = Orders.ord_id  
      AND Orders.ord_datetime >= '2020-02-05' 
      AND Orders.ord_datetime <= '2020-02-12'; 

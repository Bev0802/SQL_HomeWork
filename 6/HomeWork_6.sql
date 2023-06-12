DROP DATABASE IF EXISTS HW_6;
CREATE DATABASE HW_6;
USE HW_6;
/*Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '*/
DELIMITER //
DROP PROCEDURE IF EXISTS seconds_converter//
CREATE PROCEDURE seconds_converter (IN value float)
BEGIN   
   SET @days = (value div 86400);
   SET @hours = (value % 86400) div 3600;
   SET @minutes = ((value % 86400) % 3600) div 60;
   SET @seconds = value % 60;
END//

CALL seconds_converter(123456);
SELECT @days AS days, @hours AS hours, @minutes AS minutes, @seconds AS seconds;

/*Выведите только четные числа от 1 до 10. Пример: 2,4,6,8,10 */
DROP TEMPORARY TABLE IF EXISTS even_numbers//
CREATE TEMPORARY TABLE even_numbers (  
  even INT
  )//

DROP PROCEDURE IF EXISTS even_num//
CREATE PROCEDURE even_num (IN value INT)
BEGIN	
	DECLARE i INT DEFAULT 1;
	WHILE i <= value DO		
		IF i % 2 = 0 THEN        
		INSERT INTO even_numbers (even) 
        VALUES (i);	
		END IF;
        SET i = i + 1;
	END WHILE;
  SELECT * FROM even_numbers;
  DELETE FROM even_numbers;
END//

CALL even_num(17)//


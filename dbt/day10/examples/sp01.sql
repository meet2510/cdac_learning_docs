DROP PROCEDURE IF EXISTS sp_hello1;

DELIMITER $$

CREATE PROCEDURE sp_hello1()
BEGIN
	INSERT INTO result VALUES (1, 'Hello World!');
END;
$$

DELIMITER ;

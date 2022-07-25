DROP PROCEDURE IF EXISTS sp_hello2;

DELIMITER $$

CREATE PROCEDURE sp_hello2()
BEGIN
	SELECT 1 AS v1, 'Hello World!' AS v2;
END;
$$

DELIMITER ;


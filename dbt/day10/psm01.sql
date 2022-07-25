
DROP PROCEDURE IF EXISTS sp_hello2;

DELIMITER $$

CREATE PROCEDURE sp_hello2()
BEGIN
	SELECT 'Hello MySQL' AS msg;
END;
$$

DELIMITER ;

-- to execute this
-- SOURCE D:/may21/dbt/day10/psm01.sql
-- CALL sp_hello2();
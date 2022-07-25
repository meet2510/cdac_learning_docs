
DROP PROCEDURE IF EXISTS sp_hello3;

DELIMITER $$

CREATE PROCEDURE sp_hello3(uname VARCHAR(30))
BEGIN
	-- variable declaration and initialization
	DECLARE var DOUBLE DEFAULT 1;
	-- variable declaration
	DECLARE msg VARCHAR(40);
	-- assign value to the variable
	SET msg = CONCAT('Hello', uname);
	-- INSERT result into the table
	INSERT INTO result VALUES(var, msg);
END;
$$

DELIMITER ;

-- to execute this
-- SOURCE D:/may21/dbt/day10/psm02.sql

-- CALL sp_hello3('Nilesh');
-- SELECT * FROM result;
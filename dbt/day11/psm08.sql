-- simple demo of until loop.

DROP PROCEDURE IF EXISTS sp_until;

DELIMITER $$

CREATE PROCEDURE sp_until()
BEGIN
	DECLARE v_i INT DEFAULT 1;
	DECLARE v_sum INT DEFAULT 0;

	REPEAT
		SET v_sum = v_sum + v_i;
		SET v_i = v_i + 1;
	UNTIL v_i > 10
	END REPEAT;

	SELECT v_sum AS result;
END;
$$

DELIMITER ;

-- UNTIL loop first execute body and then check the condition.
-- UNTIL loop is executed at least once.
-- UNTIL loop executes if condition is false.

-- SOURCE D:/may21/dbt/day11/psm08.sql
-- CALL sp_until();
-- perform addition of even numbers in given range and display result on cli.
-- range will be given as argument.

DROP PROCEDURE IF EXISTS sp_evenadd;

DELIMITER $$

CREATE PROCEDURE sp_evenadd(v_low INT, v_high INT)
BEGIN
	DECLARE v_i INT;
	DECLARE v_sum INT DEFAULT 0;

	SET v_i = v_low; -- initialization
	WHILE v_i <= v_high DO -- condition
		
		IF v_i % 2 = 0 THEN
			SET v_sum = v_sum + v_i;
		END IF;

		SET v_i = v_i + 1; -- modification

	END WHILE;

	SELECT v_low AS low, v_high AS high, v_sum AS result;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm06.sql
-- CALL sp_evenadd(1, 10);
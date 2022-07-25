
DROP PROCEDURE IF EXISTS sp_test;

DELIMITER $$

CREATE PROCEDURE sp_test(v_n1 INT, v_n2 INT)
BEGIN
	DECLARE v_result INT;

	SET v_result = fn_add(v_n1, v_n2);
	-- SELECT fn_add(v_n1, v_n2) INTO v_result;

	SELECT v_result AS result;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day14/sp_test.sql
-- CALL sp_test(20, 30);

-- write a fn to add two decimal values.
-- if any input is null, consider it as 0.0.

DROP FUNCTION IF EXISTS fn_add;

DELIMITER $$

CREATE FUNCTION fn_add(v_num1 DECIMAL(9,2), v_num2 DECIMAL(9,2))
RETURNS DECIMAL(9,2)
DETERMINISTIC
BEGIN
	DECLARE v_result DECIMAL(9,2);
	SET v_result = IFNULL(v_num1, 0.0) + IFNULL(v_num2, 0.0);
	RETURN v_result;
END;
$$

DELIMITER ;

-- "root" login
--	SET GLOBAL log_bin_trust_function_creators = 1;
-- 	SELECT @@log_bin_trust_function_creators;
--	EXIT;
-- these settings will be discarded when MySql server or Computer is restarted.

-- "sunbeam" login
-- SOURCE D:/may21/dbt/day12/psm17.sql
-- SELECT fn_add(3, 7);
-- SELECT fn_add(70.2, NULL);
-- SELECT ename, sal, comm, fn_add(sal, comm) income FROM emp;

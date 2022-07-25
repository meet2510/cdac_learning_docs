-- write a fn to add two decimal values.
-- if any input is null, consider it as 0.0.

DROP FUNCTION IF EXISTS fn_experience;

DELIMITER $$

CREATE FUNCTION fn_experience(v_hire DATE)
RETURNS INT
NOT DETERMINISTIC
BEGIN
	DECLARE v_result INT;
	SELECT TIMESTAMPDIFF(MONTH, v_hire, NOW()) INTO v_result;
	RETURN v_result;
END;
$$

DELIMITER ;

-- SELECT ename, hire, TIMESTAMPDIFF(MONTH, hire, NOW()) exp FROM emp;

-- SOURCE D:/may21/dbt/day12/psm18.sql
-- SELECT fn_experience('2020-03-12');
-- SELECT ename, hire, fn_experience(hire) exp FROM emp;







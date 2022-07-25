-- find emp name with max sal and min sal. put result into result table with their sal values.

DROP PROCEDURE IF EXISTS sp_maxminsalemp;

DELIMITER $$

CREATE PROCEDURE sp_maxminsalemp()
BEGIN
	DECLARE v_sal DOUBLE;
	DECLARE v_ename VARCHAR(40);

	SELECT sal, ename INTO v_sal, v_ename FROM emp ORDER BY sal DESC LIMIT 1;
	INSERT INTO result VALUES(v_sal, v_ename);

	SELECT sal, ename INTO v_sal, v_ename  FROM emp ORDER BY sal ASC LIMIT 1;
	INSERT INTO result VALUES(v_sal, v_ename);
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm05.sql
-- TRUNCATE result;
-- CALL sp_maxminsalemp();
-- SELECT * FROM result;

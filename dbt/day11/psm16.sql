-- write a SP to insert all emps into result table with sal > 2000.

DROP PROCEDURE IF EXISTS sp_add_emp;

DELIMITER $$

CREATE PROCEDURE sp_add_emp()
BEGIN
	DECLARE v_empno INT;
	DECLARE v_ename VARCHAR(20);
	DECLARE v_flag INT DEFAULT 0;
	DECLARE v_cur CURSOR FOR SELECT empno, ename FROM emp WHERE sal > 2000; -- 2

	DECLARE CONTINUE HANDLER FOR NOT FOUND -- 1
	BEGIN
		SET v_flag = 1;
	END;

	OPEN v_cur; -- 3

	label: LOOP
		FETCH v_cur INTO v_empno, v_ename; -- 4
		IF v_flag = 1 THEN	-- 5
			LEAVE label;	-- 6
		END IF;
		INSERT INTO result VALUES(v_empno, v_ename); -- 4
	END LOOP;

	CLOSE v_cur; -- 6
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm16.sql
-- TRUNCATE result;
-- CALL sp_add_emp();
-- SELECT * FROM result;

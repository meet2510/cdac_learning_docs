-- Get the sal of emp whose empid is passed as arg.

DROP PROCEDURE IF EXISTS sp_getempsal;

DELIMITER $$

CREATE PROCEDURE sp_getempsal(p_empno INT)
BEGIN
	DECLARE v_sal DOUBLE;
	
	SELECT sal INTO v_sal FROM emp WHERE empno=p_empno;
	
	SELECT v_sal AS v1;
END;
$$

DELIMITER ;




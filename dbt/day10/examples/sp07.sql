-- Check if given emp is rich or poor.
-- if sal >= 3000, rich; else poor.

DROP PROCEDURE IF EXISTS sp_classifyemp1;

DELIMITER $$

CREATE PROCEDURE sp_classifyemp1(p_ename VARCHAR(20))
BEGIN
	DECLARE v_status VARCHAR(20);
	DECLARE v_sal DOUBLE;
	
	SELECT sal INTO v_sal FROM emp WHERE ename=p_ename;
	
	IF v_sal >= 3000 THEN
		SET v_status = 'RICH';
	ELSE
		SET v_status = 'POOR';
	END IF;
	
	SELECT v_sal AS v1, v_status AS v2;
END;
$$

DELIMITER ;



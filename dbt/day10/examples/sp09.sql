-- Check if given emp is rich or poor.
-- sal < 1500 = poor
-- 1500 to 3000 = mid
-- sal > 3000 = rich

DROP PROCEDURE IF EXISTS sp_classifyemp3;

DELIMITER $$

CREATE PROCEDURE sp_classifyemp3(p_ename VARCHAR(20))
BEGIN
	DECLARE v_status VARCHAR(20);
	DECLARE v_sal DOUBLE;
	
	SELECT sal INTO v_sal FROM emp WHERE ename=p_ename;
	
	CASE
	WHEN v_sal < 1500 THEN
		SET v_status = 'Poor';
	WHEN v_sal >= 1500 AND v_sal <= 3000 THEN
		SET v_status = 'Mid';
	ELSE
		SET v_status = 'Rich';
	END CASE;
	
	SELECT v_sal AS v1, v_status AS v2;
END;
$$

DELIMITER ;



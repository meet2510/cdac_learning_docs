-- Get number of emps for given job (as arg);

DROP PROCEDURE IF EXISTS sp_empcntbyjob;

DELIMITER $$

CREATE PROCEDURE sp_empcntbyjob(p_job VARCHAR(20))
BEGIN
	DECLARE v_cnt INT;
	
	SELECT COUNT(*) INTO v_cnt FROM emp WHERE job=p_job;

	SELECT v_cnt AS v1, p_job AS v2;
END;
$$

DELIMITER ;


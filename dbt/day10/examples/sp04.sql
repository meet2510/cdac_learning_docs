DROP PROCEDURE IF EXISTS sp_circlearea;

DELIMITER $$

CREATE PROCEDURE sp_circlearea(rad DOUBLE)
BEGIN
	DECLARE area DOUBLE;
	
	-- SET area = 3.14 * rad * rad;
	SELECT 3.14 * rad * rad INTO area;

	SELECT area AS v1;
END;
$$

DELIMITER ;




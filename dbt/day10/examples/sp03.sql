DROP PROCEDURE IF EXISTS sp_rectarea;

DELIMITER $$

CREATE PROCEDURE sp_rectarea()
BEGIN
	DECLARE len INT DEFAULT 10;
	DECLARE br INT;
	DECLARE area INT;
	
	SET br = 4;
	SET area = len * br;

	SELECT area AS v1;
END;
$$

DELIMITER ;


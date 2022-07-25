/*
Write a Procedure to add values DAC1, DAC2, ..., DAC5 in result table.
*/

DROP PROCEDURE IF EXISTS sp_while;

DELIMITER $$

CREATE PROCEDURE sp_while()
BEGIN
	DECLARE v_i INT DEFAULT 1;
	
	WHILE v_i <= 5 DO
		INSERT INTO result VALUES (v_i, CONCAT('DAC', v_i));	
		SET v_i = v_i + 1;
	END WHILE;
END;
$$

DELIMITER ;

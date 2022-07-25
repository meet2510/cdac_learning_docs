/*
Write a Procedure to add values DAC1, DAC2, ..., DAC5 in result table.
*/

DROP PROCEDURE IF EXISTS sp_repeat;

DELIMITER $$

CREATE PROCEDURE sp_repeat()
BEGIN
	DECLARE v_i INT DEFAULT 1;
	
	REPEAT
		INSERT INTO result VALUES (v_i, CONCAT('DESD', v_i));	
		SET v_i = v_i + 1;
	UNTIL v_i > 5
	END REPEAT;
END;
$$

DELIMITER ;


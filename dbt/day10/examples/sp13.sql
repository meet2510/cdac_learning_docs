DROP PROCEDURE IF EXISTS sp_params;

DELIMITER $$

CREATE PROCEDURE sp_params(IN x INT, OUT y INT, INOUT z INT)
BEGIN
	SET y = 2 * x;
	SET z = 3 * z;
END;
$$

DELIMITER ;

/*
In MySQL shell,
SET @a = 3;
SET @b = 0;
SET @c = 8;
CALL sp_params(@a, @b, @c);
SELECT @a AS a, @b AS b, @c AS c;
*/






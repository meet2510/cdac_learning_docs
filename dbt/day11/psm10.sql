-- write a SP to calculate square of a number.
-- number will be given as parameter and result should be returned in same parameter.

DROP PROCEDURE IF EXISTS sp_sqr2;

DELIMITER $$

CREATE PROCEDURE sp_sqr2(INOUT v_num INT)
BEGIN
	SET v_num = v_num * v_num;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm10.sql
-- SET @v_num = 6;
-- CALL sp_sqr2(@v_num);
-- SELECT @v_num AS result; 



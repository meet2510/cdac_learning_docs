-- write a SP to calculate square of a number.
-- number will be given as parameter.
-- return must be returned via paramter.

DROP PROCEDURE IF EXISTS sp_sqr1;

DELIMITER $$

CREATE PROCEDURE sp_sqr1(IN v_n INT, OUT v_res INT)
BEGIN
	SET v_res = v_n * v_n;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm09.sql
-- SET @v_num = 5;
-- SET @v_result = 0;
-- CALL sp_sqr1(@v_num, @v_result);
-- SELECT @v_num AS number, @v_result AS result; 



-- calculate area and perimeter of a square and put result into results table.
-- side of square should be taken as procedure param.

DROP PROCEDURE IF EXISTS sp_square;

DELIMITER $$

CREATE PROCEDURE sp_square(v_side DOUBLE)
BEGIN
	DECLARE v_area DOUBLE;
	DECLARE v_peri DOUBLE;
	DECLARE v_output VARCHAR(80);

	SET v_area = v_side * v_side;
	SET v_peri = 4 * v_side;
	SET v_output = CONCAT('side=', v_side, ', area=', v_area, ', peri=', v_peri);

	INSERT INTO result VALUES(1, v_output);
END;
$$

DELIMITER ;

-- CREATE TABLE result(id DOUBLE, val VARCHAR(80)); -- created yesterday
-- TRUNCATE result;

-- SOURCE D:/may21/dbt/day11/psm04.sql
-- CALL sp_square(10);
-- SELECT * FROM result;
-- CALL sp_square(20);
-- SELECT * FROM result;
-- CALL sp_square(30);
-- SELECT * FROM result;


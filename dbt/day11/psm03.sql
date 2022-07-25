-- calculate area and circumference of circle and display result on cli.
-- radius of circle is 7.

DROP PROCEDURE IF EXISTS sp_circle;

DELIMITER $$

CREATE PROCEDURE sp_circle()
BEGIN
	DECLARE v_radius DOUBLE DEFAULT 7.0;
	DECLARE v_area DOUBLE;
	DECLARE v_circum DOUBLE;
	
	SET v_area = 3.142 * v_radius * v_radius;
	SELECT 2 * 3.142 * v_radius INTO v_circum;

	SELECT v_radius AS radius, v_area AS area, v_circum AS circum;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm03.sql
-- CALL sp_circle();



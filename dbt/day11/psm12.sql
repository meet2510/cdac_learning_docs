-- write a SP to add a new book into books table.
-- if duplicate record, show message and stop executing.

DROP PROCEDURE IF EXISTS sp_add_book2;

DELIMITER $$

CREATE PROCEDURE sp_add_book2(v_id INT, v_name VARCHAR(30), v_price DOUBLE)
BEGIN
	DECLARE EXIT HANDLER FOR 1062 SELECT 'Book add failed due to duplicate id.' AS msg;
	-- If 1062 error occurs, execute SELECT stmt and then EXIT.

	INSERT INTO books(id, name, price) VALUES(v_id, v_name, v_price);

	SELECT 'Book added successfully.' AS msg;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm12.sql
-- CALL sp_add_book2(6002, 'THE ALCHEMIST', 490.0);
	-- okay
-- CALL sp_add_book2(1001, 'ATLAS SHRUGGED', 620.0);
	-- error: duplicate PK

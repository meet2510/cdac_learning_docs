-- write a SP to add a new book into books table.
-- no error handling done in this example.

DROP PROCEDURE IF EXISTS sp_add_book1;

DELIMITER $$

CREATE PROCEDURE sp_add_book1(v_id INT, v_name VARCHAR(30), v_price DOUBLE)
BEGIN

	INSERT INTO books(id, name, price) VALUES(v_id, v_name, v_price);

	SELECT 'Book added successfully.' AS msg;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm11.sql
-- CALL sp_add_book1(6001, 'THE  FOUNTAINHEAD', 540.0);
	-- okay
	-- SELECT * FROM books;
-- CALL sp_add_book1(1001, 'ATLAS SHRUGGED', 620.0);
	-- error: duplicate PK

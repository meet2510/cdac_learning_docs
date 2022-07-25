-- write a SP to add a new book into books table.
-- if duplicate record, use continue handler to show appropriate message.
-- use error alias for better readability

DROP PROCEDURE IF EXISTS sp_add_book4;

DELIMITER $$

CREATE PROCEDURE sp_add_book4(v_id INT, v_name VARCHAR(30), v_price DOUBLE)
BEGIN
	DECLARE v_flag INT DEFAULT 0;
	DECLARE duplicate_entry CONDITION FOR 1062; -- "duplicate_entry" is alias for 1062
	DECLARE CONTINUE HANDLER FOR duplicate_entry
	BEGIN
		INSERT INTO result VALUES(v_id, 'Duplicate Id for Book');
		SET v_flag = 1;	
	END;
	-- if duplicate, set flag=1 and then continue executing next line after INSERT.

	INSERT INTO books(id, name, price) VALUES(v_id, v_name, v_price);

	IF v_flag = 0 THEN
		SELECT 'Book added successfully.' AS msg;
	ELSE
		SELECT 'Book add failed due to duplicate id.' AS msg;
	END IF;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm15.sql
-- CALL sp_add_book4(6004, 'THE ARCHER', 610.0);
	-- okay
-- CALL sp_add_book4(1001, 'ATLAS SHRUGGED', 620.0);
	-- error: duplicate PK

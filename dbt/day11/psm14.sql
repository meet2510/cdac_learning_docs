-- write a SP to add a new book into books table.
-- if duplicate record, use continue handler to show appropriate message.

DROP PROCEDURE IF EXISTS sp_add_book3;

DELIMITER $$

CREATE PROCEDURE sp_add_book3(v_id INT, v_name VARCHAR(30), v_price DOUBLE)
BEGIN
	DECLARE v_flag INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR 1062 SET v_flag = 1;
	DECLARE CONTINUE HANDLER FOR 1044 SET v_flag = 2;
	-- if duplicate, set flag=1 and then continue executing next line after INSERT.

	INSERT INTO books(id, name, price) VALUES(v_id, v_name, v_price);

	IF v_flag = 0 THEN
		SELECT 'Book added successfully.' AS msg;
	ELSEIF v_flag = 1 THEN
		SELECT 'Book add failed due to duplicate id.' AS msg;
	ELSE
		SELECT 'Book add failed due to Access denied.' AS msg;
	END IF;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm14.sql
-- CALL sp_add_book3(6003, 'ZAHEER', 510.0);
	-- okay
-- CALL sp_add_book3(1001, 'ATLAS SHRUGGED', 620.0);
	-- error: duplicate PK

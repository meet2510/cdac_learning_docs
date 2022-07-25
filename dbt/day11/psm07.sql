-- take a number as argument. check if it is prime or not.
-- put result into results table.

DROP PROCEDURE IF EXISTS sp_prime;

DELIMITER $$

CREATE PROCEDURE sp_prime(v_num INT)
BEGIN
	DECLARE v_i INT DEFAULT 2;

	prime: LOOP
		IF v_i >= v_num THEN
			INSERT INTO result VALUES (v_num, 'Prime');
			LEAVE prime;
		END IF;

		IF v_num % v_i = 0 THEN
			INSERT INTO result VALUES (v_num, 'Not Prime');
			LEAVE prime;
		END IF;

		SET v_i = v_i + 1;
	END LOOP;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day11/psm07.sql
-- TRUNCATE result;
-- CALL sp_prime(7);
-- CALL sp_prime(49);
-- CALL sp_prime(81);
-- CALL sp_prime(51);
-- CALL sp_prime(101);
-- SELECT * FROM result;






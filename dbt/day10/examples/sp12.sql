/*
Check if given number is prime or not.
*/

DROP PROCEDURE IF EXISTS sp_prime;

DELIMITER $$

CREATE PROCEDURE sp_prime(p_num INT)
BEGIN
	DECLARE v_i INT DEFAULT 2;
	DECLARE v_status VARCHAR(20);
	is_prime: LOOP
		IF v_i = p_num THEN
			SET v_status = 'PRIME';
			LEAVE is_prime;
		END IF;
		IF MOD(p_num, v_i) = 0 THEN
			SET v_status = 'NOT PRIME';
			LEAVE is_prime;
		END IF;
		SET v_i = v_i + 1;
	END LOOP;
	SELECT p_num AS v1, v_status AS v2;
END;
$$

DELIMITER ;

/*
label: LOOP
	...
	IF condition THEN
		LEAVE label;
	END IF;
	...
END LOOP;
*/








-- implement a trigger to auto update balance on each transaction.

DROP TRIGGER IF EXISTS trig_updatebalance;

DELIMITER $$

CREATE TRIGGER trig_updatebalance
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
	DECLARE v_accid INT DEFAULT NEW.accid;
	DECLARE v_amount DOUBLE DEFAULT NEW.amount;
	DECLARE v_type CHAR(20) DEFAULT NEW.type;
	
	IF v_type = 'DEPOSIT' THEN
		UPDATE accounts SET balance = balance + v_amount WHERE id = v_accid;
	ELSE
		UPDATE accounts SET balance = balance - v_amount WHERE id = v_accid;
	END IF;
END;
$$

DELIMITER ;

-- SOURCE D:/may21/dbt/day12/psm19.sql

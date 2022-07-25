# MySQL - RDBMS

## Agenda
* ALTER
* Views
* DCL (Security)
* PSM
* Stored Procedure

## Q & A

```SQL
ALTER TABLE emp ADD PRIMARY KEY(empno);

DESCRIBE emp;

ALTER TABLE emp DROP PRIMARY KEY;

DESCRIBE emp;
```

```SQL
SHOW CREATE TABLE emp;

SHOW CREATE TABLE dept;
```

## ALTER table

```SQL
SHOW TABLES;

DESCRIBE checked_emp;

ALTER TABLE checked_emp ADD COLUMN lastname CHAR(40);

ALTER TABLE checked_emp MODIFY COLUMN lastname VARCHAR(50);
-- modify data type (if compatible) or length of column (if data can fit)

ALTER TABLE checked_emp MODIFY COLUMN job INT;
-- error: incompatible data type

ALTER TABLE checked_emp MODIFY COLUMN comm CHAR(20);
-- allowed: DECIMAL --> CHAR

ALTER TABLE checked_emp MODIFY COLUMN job CHAR(4);
-- error: job length > 4

ALTER TABLE checked_emp MODIFY COLUMN job CHAR(10);
-- allowed: all job length <= 10

DESCRIBE checked_emp;

ALTER TABLE checked_emp DROP COLUMN lastname;

ALTER TABLE checked_emp CHANGE empno empid INT;
-- rename empno column to empid column

DESCRIBE checked_emp;

ALTER TABLE checked_emp RENAME TO chk_emp;

SHOW TABLES;
```

## Views

```SQL
CREATE VIEW v_allemp AS
SELECT * FROM emp;

SHOW TABLES;

SELECT * FROM v_allemp;

CREATE VIEW v_empordered AS
SELECT * FROM emp
ORDER BY sal DESC;

SELECT * FROM v_empordered;

CREATE VIEW v_pooremp AS
SELECT * FROM emp
ORDER BY sal ASC
LIMIT 5;

SELECT * FROM v_pooremp;

CREATE VIEW v_jobwisesal AS
SELECT job, SUM(sal) total, MAX(sal) maxsal, AVG(sal) avgsal FROM emp
GROUP BY job;
-- complex view

DESCRIBE v_jobwisesal;

SELECT * FROM v_jobwisesal;

CREATE VIEW v_deptemp AS
SELECT e.empno, e.ename, e.job, e.sal, d.dname, d.loc FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno;

SELECT * FROM v_deptemp;

SELECT dname, SUM(sal) FROM v_deptemp
GROUP BY dname;

SELECT dname, SUM(sal) FROM v_deptemp
GROUP BY dname
ORDER BY SUM(sal) DESC;

SELECT dname, SUM(sal) FROM v_deptemp
GROUP BY dname
HAVING SUM(sal) > 10000;
```

```SQL
DESCRIBE v_jobwisesal;

INSERT INTO v_jobwisesal VALUES ('DIRECTOR', 8000.0, 6000.0, 5000.0);
-- cannot insert in complex view

DELETE FROM v_jobwisesal WHERE job = 'ANALYST'; 
-- cannot update/delete in complex view

CREATE VIEW v_empnocomm AS
SELECT * FROM emp WHERE comm IS NULL;

SELECT * FROM v_empnocomm;

INSERT INTO v_empnocomm(empno, ename, sal) VALUES(1000, 'DAGNY', 2500.0);
-- allowed: can perform DML on simple views

SELECT * FROM v_empnocomm;

SELECT * FROM emp;
```

```SQL
SELECT * FROM v_empnocomm;

INSERT INTO v_empnocomm(empno, ename, sal, comm) VALUES (1001, 'ROGER', 2000.00, 500.0);
-- allowed
SELECT * FROM v_empnocomm;
-- not visible
INSERT INTO v_empnocomm(empno, ename, sal, comm) VALUES (1001, 'ROGER', 2000.00, 500.0);

SELECT * FROM v_empnocomm;

SELECT * FROM emp;
-- new records added are visible here

ALTER VIEW v_empnocomm AS
SELECT * FROM emp WHERE comm IS NULL
WITH CHECK OPTION;
-- WHERE comm IS NULL condition will be checked for all DML operations on this view.

SELECT * FROM v_empnocomm;

INSERT INTO v_empnocomm(empno, ename, sal, comm) VALUES (1001, 'ROGER', 2000.00, 500.0);
-- error: cannot insert any record vioalating WHERE clause given while creating view.

DROP VIEW v_empnocomm;
```

```SQL
SHOW TABLES;
-- tables + views

SHOW FULL TABLES;
-- tables + views + type

DESCRIBE v_allemp;
```

```SQL
USE sales;

CREATE VIEW v_sales AS
SELECT o.onum, o.amt, o.odate, o.cnum, c.cname, c.city ccity, c.rating, o.snum, s.sname, s.city scity, s.comm 
FROM orders o
INNER JOIN customers c ON o.cnum = c.cnum
INNER JOIN salespeople s ON o.snum = s.snum;
```

```SQL
SHOW CREATE TABLE emp;

SHOW CREATE VIEW v_jobwisesal;
-- BI given access to v_jobwisesal, but not emp.
-- BI will never get to know all columns and constraints on emp.
```

## DCL

* Login with "root" user.
* Do not perform DML operations on system tables. It may corrupt your whole installation.

```SQL
SHOW TABLES;

USE mysql;

SHOW TABLES;

DESCRIBE tables_priv;

SELECT * FROM tables_priv;

DESCRIBE user;

SELECT user, host FROM user;
```

```SQL
SHOW GRANTS FOR sunbeam@localhost;

SHOW GRANTS FOR nilesh@localhost;

SHOW GRANTS;
```

### GRANT and REVOKE
* "root" login

```SQL
CREATE USER mgr@'%' IDENTIFIED BY 'mgr';
CREATE USER dev1@'%' IDENTIFIED BY 'dev1';
CREATE USER dev2@'%' IDENTIFIED BY 'dev2';
CREATE USER dev3@'%' IDENTIFIED BY 'dev3';

CREATE DATABASE onlineshop;

GRANT ALL PRIVILEGES ON onlineshop.* TO mgr@'%' WITH GRANT OPTION;
-- give full permissions on onlineshop db to mgr.
-- WITH GRANT OPTION -- mgr in turn can give persmissions to his subbordinates

SELECT user, host FROM mysql.user;

SHOW GRANTS FOR mgr@'%';
-- ALL --> all permissions
-- onlineshop.* --> every object (table/procedure/...) within onlineshop database/schema.

SHOW GRANTS FOR dev1@'%';
-- USAGE permission --> no permissions
-- *.* --> all databases (global)

EXIT;
```

* "mgr" login

```SQL
SHOW DATABASES;

USE onlineshop;

SELECT USER(), DATABASE();
-- mgr, onlineshop

SHOW TABLES;

SOURCE D:\may21\dbt\db\classwork-db.sql

SHOW TABLES;

GRANT INSERT, SELECT, UPDATE, DELETE ON onlineshop.* TO dev1@'%' WITH GRANT OPTION;

CREATE VIEW v_emp AS
SELECT empno, ename, sal, comm, deptno FROM emp WHERE sal >= 2500 WITH CHECK OPTION;

SELECT * FROM v_emp;

EXIT;
```

* "dev1" login

```SQL
SHOW DATABASES;

USE onlineshop;

SHOW TABLES;

SELECT USER(), DATABASE();
-- dev1, 

SHOW GRANTS;

GRANT INSERT, UPDATE, SELECT ON onlineshop.emp TO dev2@'%';
GRANT INSERT, UPDATE, SELECT ON onlineshop.dept TO dev2@'%';

GRANT SELECT ON onlineshop.v_emp TO dev3@'%';

GRANT SELECT ON onlineshop.bonus TO dev2@'%', dev3@'%';

GRANT DROP ON onlineshop.* TO dev2@'%';
-- error: dev1 doesn't have DROP permission.

EXIT;
```

* "dev3" login

```SQL
USE onlineshop;

SELECT USER(), DATABASE();
-- dev3, onlineshop

SHOW TABLES;

SHOW GRANTS;

SELECT * FROM v_emp;

SHOW CREATE VIEW v_emp;
-- error: not allowed

INSERT INTO v_emp(empno, sal) VALUES(1000, 2400.00);
-- error: not allowed

DELETE FROM bonus;
-- error: not allowed

EXIT;
```

* "dev2" login

```SQL
USE onlineshop;

SELECT USER(), DATABASE();
-- dev2, onlineshop

SHOW TABLES;

SHOW GRANTS;

DELETE FROM dept;
-- error: not allowed

INSERT INTO dept VALUES (50, 'TRAINING', 'PUNE');

SELECT * FROM dept;

CREATE INDEX idx_job ON emp(job);
-- error: not allowed

GRANT SELECT, INSERT ON onlineshop.dept TO dev3@'%';
-- error: not allowed
-- when mgr gave permissions to dev2 he didn't add "WITH GRANT OPTION".

EXIT;
```

* "mgr" login

```SQL
USE onlineshop;

SELECT USER(), DATABASE();
-- mgr, onlineshop

SHOW GRANTS FOR dev2@'%';

REVOKE DELETE ON onlineshop.emp FROM dev1@'%';
REVOKE UPDATE,DELETE ON onlineshop.dept FROM dev1@'%';

EXIT;
```

## MySQL PSM

### Stored Procedure
* Procedure is like C function -- set of SQL statements with programming constructs.
	* Reusable i.e. same procedure can be called multiple times.
	* Procedure do not return value (like C void return type).

* login with "sunbeam" into "classwork".

```SQL
-- how to write stored procedure?
DELIMITER $$

CREATE PROCEDURE sp_hello1()
BEGIN
	SELECT 'Hello World' AS msg;
END;
$$

DELIMITER ;
```

```SQL
-- how to call stored procedure?
CALL sp_hello1();

CALL sp_hello1();
```

```SQL
HELP CREATE PROCEDURE;
```

* SP writing & execution steps
	* step 1: create psm01.sql on your computer (e.g. D:/dbt/psm01.sql).
	* step 2: write stored procedure in it.
		```SQL
		DROP PROCEDURE IF EXISTS sp_hello2;

		DELIMITER $$

		CREATE PROCEDURE sp_hello2()
		BEGIN
			SELECT 'Hello MySQL' AS msg;
		END;
		$$

		DELIMITER ;
		```
	* step 3: submit procedure to server
		```SQL
		SOURCE D:/dbt/psm01.sql
		```
	* step 4: call the procedure.
		```SQL
		CALL sp_hello2();
		```

* SP hello3 -- write hello message in a table.
	
	```SQL
	CREATE TABLE result(id DOUBLE, val VARCHAR(80));
	```
	
	* follow above steps for psm02.sql.
	
































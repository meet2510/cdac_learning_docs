# MySQL - RDBMS

## Agenda
* Lab Exam Instructions
* Stored Procedure
* Exception Handling
* Cursor
* ~~Functions~~
* ~~Triggers~~
* ~~NoSQL concepts~~

## Lab Exam Instructions
* Mock exam
	* To understand submission process
* Module End Exam Syllabus
	* All topics covered till Thursday
		* SQL
		* PSM
		* Mongo
	* Multiple questions
		* Few SQL queries
		* 1/2 PSM programs
		* Few Mongo queries
* Steps/Process to give lab exam
	* Zoom login 15 mins before time --> Lab exam meeting
	* Breakout rooms
		* Breakout room --> 1 student
	* Start video + Start screen share
	* Login into Moodle
	* Go to exam paper
	* Read exam paper (all instructions carefully)
	* Solve the paper (2 hours)
		* Do commits as instructed in paper.
		* Last commit should be before deadline.
	* Submit into moodle (30 mins)
		* GIT repository link
		* GIT repository last commit id
		* Record a Loom video explaining queries (as per instructions in paper)
			* Copy from text file and execute on MySQL CLI
			* Display Output
			* Short explanation of query 
		* Loom video link
		* GIT repository link, last commit id, Loom video + Self declaration --> Format
			* Format is given in exam paper
			* Copy the format into "Online Text" in submission
			* Fill the details
			* Submit --> "Submitted for Grading".
* During Exam
	* MySQL CLI -- Help
	* VSCode -- Current exam submission file ONLY
	* GitBash
	* Browser -- loom.com, gitlab.com, sunbeam.moodlecloud.com

## Stored Procedure

### Procedure Parameters
* SP cannot return value (using RETURN statement).
* However value can be retunr using Parameters.

```C
// "n" is used to give input to the function --> "IN" parameter.
int sqr(int n) {
	return n * n;
}
int main() {
	int res;
	res = sqr(6);
	printf("result: %d\n", res);
	return 0;
}
```


```C
// "n" is used to give input to the function --> "IN" parameter.
// "r" is used to collect output from the function --> "OUT" parameter.
void sqr(int n, int *r) {
	*r = n * n;
}
int main() {
	int res;
	sqr(6, &res);
	printf("result: %d\n", res);
	return 0;
}
```

```C
// "n" is used to give input & collect output --> "IN-OUT" parameter.
void sqr(int *n) {
	*n = (*n) * (*n);
}
int main() {
	int num = 6;
	sqr(&num);
	printf("result: %d\n", num);
	return 0;
}
```

```SQL
-- param1: v_n IN param, param2: v_res OUT param
CREATE PROCEDURE sp_sqr1(IN v_n INT, OUT v_res INT)
BEGIN
	SET v_res = v_n * v_n;
END;

-- MySQL CLI
-- 		SET @v_result = 0;
-- 		CALL sp_sqr1(5, @v_result);
-- 		SELECT @v_result;
```

```SQL
-- param1: v_n INOUT param
CREATE PROCEDURE sp_sqr1(INOUT v_n INT)
BEGIN
	SET v_n = v_n * v_n;
END;

-- MySQL CLI
-- 		SET @v_num = 6;
-- 		CALL sp_sqr1(@v_num);
-- 		SELECT @v_num;
```

### IN param
* Used to give input to the SP.
* Must be initialized by the calling (CLI).
* If not mentioned, all params are IN params.

### OUT param
* Used to collect output from the SP.
* Must be initialized by the called SP.

### INOUT param
* Used to give input to the SP and same is used to collect output from the SP.
* Must be initialized by the calling (CLI).
* It is overwritten by the called SP.

## List procedures

```SQL
SHOW PROCEDURE STATUS LIKE 'sp_until';

SHOW PROCEDURE STATUS LIKE 'sp_%';

SHOW CREATE PROCEDURE sp_until;

USE information_schema;

SHOW TABLES;

DESCRIBE ROUTINES;

SELECT DEFINER, ROUTINE_DEFINITION FROM ROUTINES;

SELECT DEFINER, ROUTINE_DEFINITION FROM ROUTINES
WHERE DEFINER = 'sunbeam@localhost';

USE classwork;
```

## Exception Handling

```SQL
USE classwork;

DESCRIBE books;

SELECT * FROM books;

INSERT INTO books VALUES (1001, 'ATLAS SHRIGGED', 'Ayn Rand', 'Novell', 620.0);
-- error: 1001 is duplicate (primary key)
-- error code - 1062 (numeric)
-- error status - 23000 (alpha-numeric)

SELECT * FROM empl;

SELECT empid, ename FROM emp;

GRANT ALL ON classwork.* TO dev1@'%';
```

### Error Codes/Status
* 1062 (23000) --> Primary Key Duplicate.
* 1146 (42S02) --> Table does not exists.
* 1054 (42S22) --> Column does not exists.
* 1044 (42000) --> Access denied.

### Error handling
* Syntax: DECLARE action HANDLER FOR err_condition handler_implementation;
* action:
	* EXIT: stop SP execution after executing handler. Do not execute next line.
	* CONITINUE: Execute next line after executing handler.
* err_condition:
	* Error code (4 digit)
	* Error status (alpha-numeric)
	* Error alias (Readable name)
* handler_implementation:
	* Single liner
	* PSM block: BEGIN ... END;

## Cursors
* Cursor is special variable type to read rows one by one from the table (SELECT query).
* Cursor is always based on SELECT query.
	* Simple SELECT, WHERE, ORDER BY, LIMIT, GROUP BY, HAVING, JOIN, Sub-Query, etc.

```SQL
SELECT empno, ename FROM emp WHERE sal > 2000;
```

* Programming Steps
	* 1. Declare handler for end of cursor (like end-of-file). Error code: "NOT FOUND".
	* 2. Declare cursor variable with its SELECT statement.
	* 3. Open cursor.
	* 4. Fetch (current row) values from cursor into some variables & process them.
	* 5. Repeat process all rows in SELECT output. At the end error handler will be executed.
	* 6. Exit the loop and close the cursor. 

```
DECLARE v_flag INT DEFAULT 0;
DECLARE CONTINUE HANDLER FOR NOT FOUND -- 1
BEGIN
	SET v_flag = 1;
END;

DECLARE v_cur CURSOR FOR SELECT ...; -- 2

OPEN v_cur; -- 3

label: LOOP
	FETCH v_cur INTO variable(s); -- 4
	IF v_flag = 1 THEN	-- 5
		LEAVE label;	-- 6
	END IF;
	process variables; -- 4
END LOOP;

CLOSE v_cur; -- 6
```

```
// C -- file io -- read records

// open the file;
fp = fopen(...);

// read a record from the file
fread(fp, ...);
// process the record
printf(...);
// repeat the process -- loop till end of file

// close file
fclose(fp);
```
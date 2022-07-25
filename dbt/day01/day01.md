# Database Technologies

## Module Syllabus
* RDBMS - MySQL
* NoSQL - Mongo

## Module Evaluation
* Theory - 40
	* CCEE - At the end of course
	* MCQ questions (No negative marking)
* Lab - 40
	* At the end of module
		* SQL queries
		* Stored Procedures/Functions/Triggers
		* NoSQL queries
* Internal - 20
	* Lab assignments
		* Submit on time.
	* Interview questions
		* Write questions and answers on paper.
		* Scan and upload PDF.
	* Case study (Mini-project)
	
## Agenda
* Introduction
* SQL
* MySQL
* First step (Test installation)

## Getting Started

* Open Command Prompt
	* mysql -u root -p
		* Password: manager

```SQL
mysql> \! cls

mysql> SHOW DATABASES;

mysql> CREATE DATABASE classwork;

mysql> SHOW DATABASES;

mysql> USE classwork;

mysql> SHOW TABLES;

mysql> CREATE TABLE students(roll INT, name CHAR(40), marks DOUBLE);

mysql> SELECT * FROM students;

mysql> INSERT INTO students VALUES(1, 'Batman', 95.0);
mysql> INSERT INTO students VALUES(2, 'Spiderman', 92.0);
mysql> INSERT INTO students VALUES(3, 'Superman', 94.0);
mysql> INSERT INTO students VALUES(7, 'JamesBond', 100.0);

mysql> SELECT * FROM students;

mysql> QUIT;
```




























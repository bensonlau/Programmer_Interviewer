##Creating tables to practice questions frmo 
##http://www.programmerinterview.com/index.php/database-sql/practice-interview-question-1/

DROP SCHEMA programmer_interview;
CREATE SCHEMA programmer_interview;

DROP TABLE if exists programmer_interview.salesperson;
CREATE TABLE programmer_interview.salesperson
(
	id INT not null,
	name VARCHAR (15) not null,
	age VARCHAR (15) not null,
	salary INT not null
);

INSERT INTO programmer_interview.salesperson
VALUES
	('1','Abe','61','140000'),
	('2','Bob','34','44000'),
	('5','Chris','34','40000'),
	('7','Dan','41','52000'),
	('8','Ken','57','115000'),
	('11','Joe','38','38000')
;

DROP TABLE if exists programmer_interview.customer;
CREATE TABLE programmer_interview.customer
(
	id int not null,
    name varchar(30) not null,
    city varchar(30) not null,
    industry_type char(1) not null
);

INSERT INTO programmer_interview.customer
VALUES
	('4','Samsonic','pleasant','J'),
    ('6','Panasung','oaktown','J'),
	('7','Samony','Jackson','B'),
    ('9','Orange','Jackson','B')
;

DROP TABLE if exists programmer_interview.orders;
CREATE TABLE programmer_interview.orders
(
	number INT not null,
	order_date date not null,
    cust_id int not null,
    salesperson_id int not null,
	amount int not null

);

INSERT INTO programmer_interview.orders
VALUES
	('10','1996-08-02','4','2','540'),
    ('20','1999-01-30','4','8','1800'),
    ('30','1995-07-12','9','1','460'),
    ('40','1998-01-29','7','2','2400'),
    ('50','1998-02-03','6','7','600'),
    ('60','1998-03-2','6','7','720'),
    ('70','1998-05-06','9','7','150')
;

CREATE TABLE person (id int, first_name varchar(20), age int, gender char(1));

INSERT INTO person VALUES (1, 'Bob', 25, 'M');
INSERT INTO person VALUES (2, 'Jane', 20, 'F');
INSERT INTO person VALUES (3, 'Jack', 30, 'M');
INSERT INTO person VALUES (4, 'Bill', 32, 'M');
INSERT INTO person VALUES (5, 'Nick', 22, 'M');
INSERT INTO person VALUES (6, 'Kathy', 18, 'F');
INSERT INTO person VALUES (7, 'Steve', 36, 'M');
INSERT INTO person VALUES (8, 'Anne', 25, 'F');

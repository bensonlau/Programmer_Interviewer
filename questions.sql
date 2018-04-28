###Questions from http://www.programmerinterview.com/index.php/database-sql/practice-interview-question-1/

#See tables
SELECT
	*
FROM programmer_interview.salesperson;

SELECT
	*
FROM programmer_interview.customer;

SELECT

*
FROM programmer_interview.orders;



#a. The names of all salespeople that have an order with Samsonic.
SELECT
	distinct s.name
FROM
	orders o 
LEFT JOIN
	salesperson s on o.salesperson_id=s.id
LEFT JOIN
	Customer c on o.cust_id=c.id
where c.name='Samsonic'
;

#b. The names of all salespeople that do not have any order with Samsonic.
SELECT
	distinct s.name
FROM
	orders o 
LEFT JOIN
	salesperson s on o.salesperson_id=s.id
LEFT JOIN
	Customer c on o.cust_id=c.id
where c.name not in ('Samsonic')
;
;
#c. The names of salespeople that have 2 or more orders.
SELECT
	s.name,
	count(*)
FROM
	orders o 
LEFT JOIN
	salesperson s on o.salesperson_id=s.id
LEFT JOIN
	Customer c on o.cust_id=c.id
GROUP BY 1
HAVING count(*)>1
;

#d. Write a SQL statement to insert rows into a table called highAchiever(Name, Age), 
#where a salesperson must have a salary of 100,000 or greater to be included in the table.
DROP TABLE if exists programmer_interview.highAchiever;
CREATE TABLE programmer_interview.highAchiever
as
	SELECT
		s.name,
		s.age
	FROM
		salesperson s
	WHERE 
		s.salary>=100000
;
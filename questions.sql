###Questions from http://www.programmerinterview.com/index.php/database-sql/practice-interview-question-1/

/*
SELECT
	*
FROM programmer_interview.salesperson;

SELECT
	*
FROM programmer_interview.customer;

SELECT

*
FROM programmer_interview.orders;

*/

#a. The names of all salespeople that have an order with Samsonic.
SELECT
	s.name
FROM
	orders o 
LEFT JOIN
	salesperson s on o.salesperson_id=s.id
LEFT JOIN
	Customer c on o.cust_id=c.id
where c.name='Samsonic'
;
#b. The names of all salespeople that do not have any order with Samsonic.

#c. The names of salespeople that have 2 or more orders.

#d. Write a SQL statement to insert rows into a table called highAchiever(Name, Age), where a salesperson must have a salary of 100,000 or greater to be included in the table.
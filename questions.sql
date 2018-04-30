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

#Write a SQL Statement to find the employees and the running total of the salary
SELECT
		name,
        salary,
        @running_total := @running_total+salary as running_total
FROM programmer_interview.salesperson, (SELECT @running_total := 0) r
;

##another way of doing it without session variables
SELECT
	*
FROM
(
	SELECT
		o.order_date,
		o.amount as a,
		sum(o1.amount) as t
	FROM programmer_interview.orders o
	JOIN
	programmer_interview.orders o1
		on o.order_date>=o1.order_date
	GROUP by 1,2
)  t
;

#Searching across columns
#Identify all salesperson who have sold Samsonic
SELECT
	s.name,
    group_concat(distinct c.name) as brands_sold
FROM orders o
LEFT JOIN salesperson s
	on o.salesperson_id=s.id
LEFT JOIN
	Customer c on o.cust_id=c.id
GROUP by 1
HAVING  brands_sold like '%samsonic%'
;

#Create table of first and second orders made by employee
##moving rows to columns
SELECT
	g.name,
    max(case when g.rank=1 then order_date else null end) as first_order_date,
    max(case when g.rank=1 then order_amount else null end) as first_order_amount,
	max(case when g.rank=2 then order_date else null end) as second_order_date,
    max(case when g.rank=2 then order_amount else null end) as second_order_amount
FROM
(
	SELECT
		o.order_date,
		s.name,
        sum(o.amount) as order_amount,
		count(o1.order_date)+1 as rank
	FROM orders o
	LEFT JOIN salesperson s
		on o.salesperson_id=s.id
	LEFT JOIN
		Customer c 
		on o.cust_id=c.id
	LEFT JOIN orders o1
		on o.order_date>o1.order_date AND o.salesperson_id=o1.salesperson_id
GROUP by 1,2
) g
group by 1
;

#Creating subtotals
SELECT
	s.name,
    o.number as order_number,
	sum(o.amount) as order_amount
FROM orders o
LEFT JOIN salesperson s
	on o.salesperson_id=s.id
LEFT JOIN
	Customer c on o.cust_id=c.id
GROUP by 1,2 WITH ROLLUP
;

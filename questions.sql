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
		@curRank := @curRank + 1,
		s.name,
		s.age,
        s.salary
	FROM
		salesperson s, (SELECT @curRank := 0) r
	WHERE 
		s.salary>=100000
	order by 4 desc
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

#Create table of dates of first and second orders sold by and the amount of the order by employee
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

#rounding ages of salesperson into bins of 10
SELECT
	CONCAT(age.a-5,'-',age.a+4) as age_range,
    age.count
FROM
(SELECT
	round(age,-1) as a,
    count(*) as count
FROM salesperson s
GROUP by 1
) age
;
##this is also possible through use of the floor function
SELECT
	s.age,
    5*FLOOR(s.age/5) AS valueBucket,
	CONCAT(5*FLOOR(s.age/5),'-',5*FLOOR(s.age/5)+4) as age_range
FROM salesperson s
;

#Write a query that shows the number of employees with names that start with A through M,
#and the number at employees with names starting with N - Z.
 SELECT 
	CASE WHEN name < 'n' THEN 'A-M'
		WHEN name >= 'n' THEN 'N-Z'
		ELSE NULL END AS range_name,
       COUNT(*) AS count
  FROM salesperson
 GROUP BY 1
 ;
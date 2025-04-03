show databases;
CREATE database rajsql;
use rajsql;
#Create a table Employee with the given data

CREATE TABLE employee (emp_id integer primary key,emp_name varchar(25) not null,age integer check(age >=18),email varchar(20) unique,
salary float default 30000.00);

/*2)Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints? 

Ans: Constrains plays a vital role to distinguish on the type of data to be store in a table/columns. Constrains helps maintain the data integrity by prior validation checks like not null, deafault,check and etc....
Unique, Defalult, Primary key, foriegn key, not null, null, and check are the most common contraits that we use. 
*/

/* 3)Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer

Ans: Not Null means the column  should not accept null values. A primary key in a database should never be null because it plays a critical role in uniquely identifying each record in a table. 
*/

/* 4). Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint

Ans: Steps to add or remove constains on an existing table:
step1:Use the ALTER TABLE statement to modify the table.
step2: Specify the column(s) and the constraint type in the ADD or REMOVE  clause
*/
ALTER TABLE employee DROP CONSTRAINT email;
ALTER TABLE employee MODIFY COLUMN email VARCHAR(25) NOT NULL;
select * from employee;

/*5).5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.

Ans: Example: If a unique constraint is applied to email column, inserting a duplicate email will be blocked.
ERROR 1062 (23000): Duplicate entry 'example@gmail.com'

 If a not null  constraint exists on , attempting to update a record  to not null column  will be blocked.
ERROR 1048 (23000): Column 'email' cannot be null

Deleting a row that is referenced by a  in another table can lead to constraint violations.
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key 

*/
SELECT * FROM employee;
INSERT INTO employee VALUES(101, 'Raju',35,'raj@g.com',40000);
INSERT INTO employee VALUES(102, 'Ramesh',36,'ra@g.com',36000);
INSERT INTO employee VALUES (103,'Rajesh',32,'k@h.com',25000);

#6. You created a products table without constraints as follows:

CREATE TABLE products (product_id INT, product_name VARCHAR(50),price DECIMAL(10, 2));
/*Now, you realise that?
: The product_id should be a primary key
: The price should have a default value of 50.00
*/
ALTER TABLE products ADD CONSTRAINT p_key PRIMARY KEY (product_id);
ALTER TABLE products ALTER COLUMN price SET DEFAULT 50.00;

#7)Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

CREATE TABLE students(student_id INT, student_name varchar(30), class_id INT);
CREATE TABLE class(class_id INT, class_name varchar(30));

INSERT INTO students VALUES( 01,'Alice',101);
INSERT INTO students VALUES(02,'Bob',102);
INSERT INTO students VALUES(03,'Charlie',101);

INSERT INTO class VALUES(101,'MATHS');
INSERT INTO class VALUES(102,'Science');
INSERT INTO class VALUES(103,'History');


SELECT student_name, class_name FROM students INNER JOIN class ON students.class_id=class.class_id;

/*
. Consider the following three tables: Orders, Customers, Products 

Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order Hint: (use INNER JOIN and LEFT JOIN)
*/

CREATE TABLE Orders(order_id INT, order_date varchar(30), customer_id INT);
CREATE TABLE Customers(customer_id INT, customer_name varchar(30));
ALTER TABLE products ADD COLUMN order_id INT;

ALTER TABLE Orders MODIFY order_date DATE;

INSERT INTO Orders VALUES(1, '2024-01-01',101);
INSERT INTO Orders VALUES(2,'2024-01-03',102);

INSERT INTO  Customers VALUES(101,'Alice');
INSERT INTO  Customers VALUES(102,'BOB');

select * from products;

INSERT INTO products VALUES(1,'Laptop',2200,1);
INSERT INTO products VALUES(2,'Phone',3000, null);

SELECT Orders.order_id, Customers.customer_name, products.product_name FROM products INNER JOIN Orders ON products.order_id = Orders.order_id LEFT JOIN Customers ON Orders.customer_id = Customers.customer_id;

#9.Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function

CREATE TABLE Sales (sales_id INT, product_id INT, Amount INT);
ALTER TABLE Sales RENAME COLUMN Amount to Total_Sales;
INSERT INTO Sales VALUES(201,1, 500);
INSERT INTO Sales VALUES(202,2,700);
SELECT * FROM products;
SELECT Sales.product_id, products.product_name ,SUM(products.price * Sales.Total_Sales) as Gross_Sales FROM Sales 
INNER JOIN products 
ON Sales.product_id=products.product_id 
GROUP BY Sales.product_id, products.product_name;

/*10. Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer 
using an INNER JOIN between all three tables.
*/

SELECT * FROM Orders; # need order_id
SELECT * FROM Customers; # need customer name from this
SELECT * FROM Sales; # need Total sales where 

SELECT Orders.order_id, Customers.customer_name, Sales.Total_Sales FROM Sales 
INNER JOIN Orders 
ON Sales.product_id=Orders.order_id
INNER JOIN Customers 
ON Customers.customer_id=Orders.customer_id;


# QUERIES USING mavenmovies DATABASE 
USE mavenmovies;

/*1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences 
Primary key is nothing but a column which uniquely identifies each row within a table, while a foreign key establishes a link between two tables by referencing the primary key of another table
*/

SELECT TABLE_NAME, COLUMN_NAME,'Primary Key' AS KeyType
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE CONSTRAINT_NAME = 'PRIMARY' AND TABLE_SCHEMA = 'mavenmovies'
UNION ALL
SELECT TABLE_NAME, COLUMN_NAME, 'Foreign Key' AS KeyType
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_NAME IS NOT NULL AND TABLE_SCHEMA = 'mavenmovies';

#2). List all details of actors
SELECT * FROM actor;

#3)List all customer information from DB.
SELECT * FROM customer;

#4).List different countries
SELECT DISTINCT country FROM country;

#5).Display all active customers
SELECT * FROM customer WHERE active =1; # Observation 15 customers are not active 

#6).List of all rental IDs for customer with ID 1.
SELECT * FROM rental;
SELECT rental_id FROM rental WHERE customer_id=1; #Observation 32 rows are displayed

#7).Display all the films whose rental duration is greater than 5 .
SELECT * FROM film;
SELECT title FROM film WHERE rental_duration>5; # Observation 34 films have rental duration greater than 5.

#8).List the total number of films whose replacement cost is greater than $15 and less than $20
SELECT * FROM film;
SELECT COUNT(title) FROM film WHERE replacement_cost >15 AND replacement_cost < 20; # Observation 214 films have replacement_cost greater than 15 and less than 20 dollars. 

# 9). Display the count of unique first names of actors.
SELECT COUNT(DISTINCT first_name) AS unique_FN FROM actor; # Observation 128 unique first names are available in actor table. 

#10).Display the first 10 records from the customer table .
SELECT * FROM customer LIMIT 10;

#11).Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT * FROM customer WHERE first_name LIKE 'b%' LIMIT 3;

#12).Display the names of the first 5 movies which are rated as ‘G’.
SELECT * FROM film WHERE rating LIKE 'G' LIMIT 5;

#13). Find all customers whose first name starts with "a".
SELECT * FROM customer WHERE first_name LIKE 'a%'; #Observation: 44 rows displayed

#14).Find all customers whose first name ends with "a".
SELECT * FROM customer WHERE first_name LIKE '%a'; #Observation: 96 rows displayed

#15).Display the list of first 4 cities which start and end with ‘a’ . 
SELECT city FROM city WHERE city LIKE 'a%%a' LIMIT 4; #Observation (Abha, Acua, Adana, Addis Abeba)

#16).Find all customers whose first name have "NI" in any position
SELECT * FROM customer WHERE first_name LIKE '%NI%'; #Observation: 29 rows displayed 

#17).Find all customers whose first name have "r" in the second position .
SELECT * FROM customer WHERE first_name LIKE '_r%'; # 45 rows displayed

#18).Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT * FROM customer WHERE first_name LIKE 'a%' AND LENGTH(first_name) >=5; # 34 rows displyed

#19).  Find all customers whose first name starts with "a" and ends with "o".
SELECT * FROM customer WHERE first_name LIKE 'a%%o' ; #4 rows displyed 

#20).Get the films with pg and pg-13 rating using IN operator.
SELECT * FROM film WHERE rating IN ('pg','pg-13'); #Observation 417 rows are displyed

#21) Get the films with length between 50 to 100 using between operator.
SELECT * FROM film WHERE length BETWEEN 50 AND 100; #Observation: 362 films have length between 50 to 100. 

#22).Get the top 50 actors using limit operator.
SELECT * FROM actor LIMIT 50;

#23). Get the distinct film ids from inventory table.
SELECT DISTINCT film_id FROM inventory; # Observatio there 958 dinstinct film ids available in the Invetory table of given dataset . 


/* FUNCTIONS
Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function
*/
SHOW DATABASES;
USE sakila;
SELECT COUNT(rental_id) FROM rental; # Total 160444 rental made in rental table that existed in Sakila database.alter

#2)Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT * FROM rental;
SELECT AVG(DATEDIFF(return_date, rental_date)) AS Average_Rental_Duration FROM rental; # Observation on an average movies rented for 5 days.

#3)Display the first name and last name of customers in uppercase
SELECT UPPER(first_name),UPPER(last_name) FROM customer; 

#4)Extract the month from the rental date and display it alongside the rental ID.
SELECT rental_id, MONTHNAME(rental_date) as rented_month FROM rental;

#5).Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT customer_id,COUNT(rental_id) FROM rental GROUP BY customer_id;

#6)Find the total revenue generated by each store.
SELECT i.store_id, SUM(p.amount) as Total_revenue FROM payment p
JOIN rental r ON r.rental_id=p.rental_id
JOIN inventory i ON i.inventory_id= r.inventory_id
GROUP BY i.store_id; # Observation: Store_id 1 has 33679.79 revenue and Store_id 2 has 33726.77 revenue

#7)Determine the total number of rentals for each category of movies. Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY. 
SELECT fc.category_id, COUNT(r.rental_id) AS total_rentals
FROM film_category fc
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY fc.category_id
ORDER BY total_rentals DESC;

#8).Find the average rental rate of movies in each language.
#Hint: JOIN film and language tables, then use AVG () and GROUP BY
SELECT l.language_id, l.name, AVG(f.rental_rate) AS avg_rental FROM language l
JOIN film f ON f.language_id=l.language_id
GROUP BY l.language_id; #Observation avg_rental of English films is 2.9800

#9)Display the title of the movie, customer s first name, and last name who rented it.
#Hint: Use JOIN between the film, inventory, rental, and customer tables.
SELECT CONCAT(c.first_name,' ',c.last_name) AS Customer_name,f.title AS rented_film_name FROM rental r
JOIN customer c ON c.customer_id=r.customer_id
JOIN inventory i ON i.inventory_id=r.inventory_id
JOIN film f ON f.film_id=i.film_id;

#10).Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
#Hint: Use JOIN between the film actor, film, and actor tables
SELECT a.first_name,a.last_name FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON f.film_id=fa.film_id
WHERE f.title LIKE "%Gone with the Wind%";

#11).Retrieve the customer names along with the total amount they've spent on rentals.
#Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
SELECT CONCAT(c.first_name,' ', c.last_name) AS customer_name, SUM(p.amount) AS total_rental_amoount_by_customer FROM payment p 
JOIN customer c ON p.customer_id=c.customer_id
# JOIN rental r ON r.rental_id=p.rental_id rental table not needed here 
GROUP BY c.customer_id;

#List the titles of movies rented by each customer in a particular city (e.g., 'London').
#Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY
SELECT f.title,CONCAT(c.first_name,' ',c.last_name) AS customer_name, city.city FROM customer c
JOIN address a ON c.address_id=a.address_id 
JOIN city ON city.city_id=a.city_id
JOIN inventory i ON i.store_id=c.store_id
JOIN film f ON f.film_id=i.film_id
WHERE city.city LIKE '%London%';

# Display the top 5 rented movies along with the number of times they've been rented.
#Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
SELECT f.title AS Top5_rented_Movie,COUNT(r.rental_id) AS No_of_times_rented FROM film f
JOIN inventory i ON f.film_id=i.film_id
JOIN rental r ON i.inventory_id=r.inventory_id
GROUP BY f.title
ORDER BY No_of_times_rented DESC
LIMIT 5; #BUCKET BROTHERHOOD,ROCKETEER MOTHER,FORWARD TEMPLE,GRIT CLOCKWORK,JUGGLER HARDLY

#Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
#Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
SELECT CONCAT(c.first_name,' ',c.last_name) AS customer_name FROM customer c
JOIN rental r ON r.customer_id=c.customer_id
JOIN inventory i ON i.inventory_id=r.inventory_id
#WHERE i.store_id IN (1, 2) we dont need this line/condition as we have only 2 stores available in the database. 
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;

#1. Rank the customers based on the total amount they've spent on rentals.
SELECT RANK() OVER (ORDER BY SUM(p.amount) DESC) AS ranks, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,SUM(p.amount) AS total_spent
FROM customer c JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY ranks;

#2.Calculate the cumulative revenue generated by each film over time. 
SELECT f.film_id,f.title,r.rental_date,SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM film f INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN rental AS r ON r.inventory_id = i.inventory_id
INNER JOIN payment AS p ON p.rental_id = r.rental_id
ORDER BY f.film_id, r.rental_date;

#3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT f.film_id,f.title,f.length, AVG(f.rental_duration) OVER (PARTITION BY f.length) AS avg_duration_for_similar_lengths
FROM film f
ORDER BY f.length;

#4.Identify the top 3 films in each category based on their rental counts.
WITH FilmRanking AS (
SELECT f.title,c.name AS category_name,COUNT(r.rental_id) AS rental_count,RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rental_rank FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN inventory i ON i.film_id = fc.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY f.film_id, c.category_id, c.name
)
SELECT title, category_name, rental_count,rental_rank FROM FilmRanking
WHERE rental_rank <= 3
ORDER BY category_name, rental_rank;

#5)Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
WITH CustomerRentals AS (
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(r.rental_id) AS total_rentals_per_customer FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id
),
AverageRentals AS (
SELECT AVG(total_rentals_per_customer) AS average_rentals_across_customers FROM CustomerRentals
)
SELECT cr.customer_name,cr.total_rentals_per_customer, ar.average_rentals_across_customers,cr.total_rentals_per_customer - ar.average_rentals_across_customers AS rental_difference FROM CustomerRentals cr
JOIN AverageRentals ar ON 1=1 -- Cartesian join to calculate difference for each customer
ORDER BY cr.customer_name;

#6. Find the monthly revenue trend for the entire rental store over time.
SELECT DATE_FORMAT(r.rental_date, '%m') AS month, SUM(p.amount) AS monthly_revenue FROM rental r
JOIN payment p ON r.rental_id = p.rental_id 
GROUP BY month
ORDER BY month; #Observation july and august has peak in revenue/sales

#7)Identify the customers whose total spending on rentals falls within the top 20% of all customers.
SELECT customer_name, total_spent_by_customer FROM (
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(p.amount) AS total_spent_by_customer, RANK() OVER (ORDER BY SUM(p.amount) DESC) AS c_rank FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spent_by_customer DESC
) AS ranked_customers
WHERE c_rank <= (SELECT COUNT(*) * 0.2 FROM customer)
ORDER BY total_spent_by_customer DESC;

#8.Calculate the running total of rentals per category, ordered by rental count.
SELECT c.name AS category_name,COUNT(r.rental_id) AS rental_count, SUM(COUNT(r.rental_id)) OVER (ORDER BY COUNT(r.rental_id) DESC) AS running_total FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY c.category_id, c.name
ORDER BY rental_count DESC;

#9.Find the films that have been rented less than the average rental count for their respective categories.
WITH group1 AS (
    SELECT fc.category_id,COUNT(fc.film_id) AS film_count FROM film_category fc
    GROUP BY fc.category_id
),
group2 AS (
    SELECT fc.category_id,COUNT(r.rental_id) AS rental_count FROM film f
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON fc.film_id = i.film_id
    GROUP BY fc.category_id
),
group3 AS (
SELECT f.title, COUNT(r.rental_id) as rental_film FROM film f
JOIN inventory i ON i.film_id= f.film_id
JOIN rental r ON r.inventory_id=i.inventory_id
GROUP BY f.title
),
group4 AS(
SELECT f.title, fc.category_id, COUNT(r.rental_id) as rental_film FROM film f
JOIN inventory i ON i.film_id= f.film_id
JOIN rental r ON r.inventory_id=i.inventory_id
JOIN film_category fc ON fc.film_id=f.film_id
GROUP BY f.title,fc.category_id
)

SELECT g3.title,g3.rental_film,g1.category_id,g1.film_count,g2.rental_count,(g2.rental_count/g1.film_count) AS avg_film_cat FROM group1 g1
JOIN group2 g2 ON g1.category_id = g2.category_id
JOIN group4 g3 ON g3.category_id=g2.category_id
WHERE g3.rental_film<=(g2.rental_count/g1.film_count)
ORDER BY g1.category_id,g3.title;

# Identify the top 5 months with the highest revenue and display the revenue generated in each month.
SELECT DATE_FORMAT(r.rental_date, '%Y-%m') AS years_month, SUM(p.amount) AS monthly_revenue FROM rental r
JOIN payment p ON r.rental_id = p.rental_id 
GROUP BY years_month
ORDER BY monthly_revenue DESC
LIMIT 5; #Observation july and august has peak in revenue/sales

#1)Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
SELECT * FROM film; #film table voilates the 1NF , speacial features column has multiple data points in a cell.
CREATE TABLE film_special_features (film_id SMALLINT unsigned,special_feature VARCHAR(255), PRIMARY KEY (film_id, special_feature),
FOREIGN KEY (film_id) REFERENCES film(film_id));
DESCRIBE film;
INSERT INTO film_special_features (film_id, special_feature)
SELECT f.film_id,TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(f.special_features, ',', n.n), ',', -1)) AS special_feature FROM film f
JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
) n -- Replace this with the maximum number of items in the column
WHERE n.n <= CHAR_LENGTH(f.special_features) - CHAR_LENGTH(REPLACE(f.special_features, ',', '')) + 1;
SELECT * FROM film_special_features;
ALTER TABLE film DROP COLUMN special_features;
SELECT * FROM film;

# Observation: by creating a new/separate table with which data causing voilation of 1NF, and dropping original column we can achive 1NF normalization. 

#2. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.
/*Ans: Conditions for 2NF:
The table must first satisfy 1NF(Atomicity).
The table must eliminate partial dependencies:
The film_actor table satisfies 1NF because every column contains atomic values (e.g., integers and timestamps), and there are no repeating groups.
The last_upated column in fil_actor table is not specifically dependent on the unique pair (actor_id,film_id). It is related to the whole table, so no partial dependency exists.

Steps to Achieve 2NF
Remove Partial Dependencies, create separate table
Modify the Original table, drop the columns which are partial dependent 
Establish Relationships: Use a foreign key to references original table 
*/

#3. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF
/* 3NF means the table satisfies 1NF,2NF AND It has no transitive dependencies.
Transitive Dependency: Occurs when a non-prime attribute depends on another non-prime attribute, rather than directly on the primary key.
In payment table payment_id is the primary key, staff_name is non-key attribute which is indirectly depend on primary key , directly depend on staff_id . 

Steps to Normalize the Table to Achieve 3NF:
Remove Transitive Dependencies: create a new table that directly references primary_key
Insert the relevant data into the new table
Alter table to remove the redundant column
Use Foreign Keys to Maintain Relationships
*/

#4.Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.
SELECT * FROM staff;
#I do not find any table which voilates 2NF in sakila database . 
SELECT * FROM film_actor;

#5. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables
WITH actor_films AS(
SELECT DISTINCT CONCAT(first_name,' ',last_name) AS actor_name, COUNT(fa.film_id) AS number_of_movies FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
GROUP BY actor_name
ORDER BY number_of_movies DESC)
SELECT * FROM actor_films;

 #6.Create a CTE that combines information from the film and language tables to display the film title,language name, and rental rate.
WITH film_lang AS(
SELECT f.title,f.rental_rate,l.name AS language_name FROM film f
JOIN language l ON f.language_id=l.language_id
GROUP BY f.film_id)
SELECT * FROM film_lang;

#7.Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.
WITH customer_pay AS(
SELECT CONCAT(c.first_name,' ',c.last_name) AS customer_name, SUM(p.amount) AS total_revenue FROM customer c
JOIN payment p ON p.customer_id=c.customer_id
GROUP BY p.customer_id
ORDER BY total_revenue DESC)
SELECT * FROM customer_pay;

#8.Utilize a CTE with a window function to rank films based on their rental duration from the film table
WITH film_rental_rank AS(
SELECT title, rental_duration,RANK() OVER(ORDER BY rental_duration DESC) as rental_rank FROM film)
SELECT * FROM film_rental_rank ORDER BY rental_duration DESC;

#9.Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.
 WITH rentals AS(
 SELECT customer_id,COUNT(rental_id) AS total_rentals FROM rental GROUP BY customer_id
)
 SELECT r.customer_id,CONCAT(c.first_name,' ',c.last_name) AS customer_name, r.total_rentals FROM rentals r 
 JOIN customer c
 GROUP BY r.customer_id, customer_name;
 
 #10.Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table?
 WITH rentals_per_month AS(
 SELECT DATE_FORMAT(rental_date,'%Y-%m') AS rental_month, COUNT(rental_id) as rental_count FROM rental
 GROUP BY rental_month)
 SELECT * FROM rentals_per_month;

#11.Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
WITH FilmActors AS (
SELECT f.film_id, f.title,GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.film_id, f.title
)
SELECT film_id, title, actors,LENGTH(actors) - LENGTH(REPLACE(actors, ',', '')) + 1 AS number_actors_acted FROM FilmActors;
#Observation I can simply write code to fetch the actors as per film_id with different rows but thought to beautify my report like this. 

#12.Implement a recursive CTE to find all employees in the staff table who report to a specific manager,considering the reports_to column
WITH RECURSIVE StoreHierarchy AS (
SELECT store_id,manager_staff_id FROM store
WHERE manager_staff_id IS NOT NULL-- Replace <manager_staff_id> with the manager's ID
UNION ALL
-- Recursive Query: Find all related stores recursively
SELECT s.store_id, s.manager_staff_id FROM store s
INNER JOIN StoreHierarchy sh ON s.manager_staff_id = sh.manager_staff_id
WHERE s.manager_staff_id IS NOT NULL -- Stop when no valid continuation exists
)
SELECT * FROM StoreHierarchy;
#Observation: two set backs, i cant see any table with the manager details, using manager_staff_id the recursive call going to infinite interations. 
SET @@cte_max_recursion_depth = 2000;

WITH RECURSIVE ActorConnections AS (
SELECT a.actor_id,CONCAT(a.first_name, ' ', a.last_name) AS actor_name,fa.film_id FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE a.actor_id = 1
UNION ALL
-- Recursive Query: Find other actors connected through shared films
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor_name,fa.film_id FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN ActorConnections ac ON fa.film_id = ac.film_id
WHERE a.actor_id != ac.actor_id -- Avoid repeating the same actor
)
SELECT DISTINCT actor_id, actor_name FROM ActorConnections;
#OBSERVATION: ERROR CODE 2013 ARISES ,RECURSIVE CALLS MIGHT BE TAKING LONGER THAN EXPECTED . 

SET GLOBAL max_execution_time = 60000;
SET GLOBAL net_read_timeout = 120;
SET GLOBAL net_write_timeout = 120;



























